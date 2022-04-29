use chrono::{self, DateTime, Utc};
use rand::Rng;
use serde_json::{Map, Value};
use std::fs;
use std::io::{self, Write};

use base64;

fn is_token_valid(token: &Map<String, Value>) -> bool {
  let expiration = match &token["status"]["expirationTimestamp"] {
    Value::String(exp) => match String::from(exp).parse::<DateTime<Utc>>() {
      Ok(value) => value,
      Err(e) => {
        eprintln!("Could not parse token expiry date {}", e);
        return false;
      }
    },
    value => {
      eprintln!("Could not find token expiry date. {}", value);
      return false;
    }
  };

  let now: DateTime<Utc> = Utc::now();
  if expiration.timestamp() < (now.timestamp() - 10) {
    return false;
  }

  true
}

fn main() -> std::io::Result<()> {
  let home = match std::env::var("HOME") {
    Ok(value) => value,
    Err(e) => panic!("Failed to read $HOME. {}", e),
  };

  let cache_file_path = format!("{}/.kube/kube-auth-cache.json", home);
  let data = match fs::read_to_string(&cache_file_path) {
    Ok(data) => String::from(data),
    Err(_) => String::from("{}"),
  };

  let mut cache = match serde_json::from_str(&data) {
    Err(e) => {
      eprintln!("Failed to parse existing token cache {}", e);
      Value::Object(Map::new())
    }
    Ok(value) => value,
  };

  let args: Vec<String> = std::env::args().collect();
  let args = &args[1..];
  let key = base64::encode(args.join(" "));

  let token = &cache[&key];

  let valid = match token {
    Value::Object(value) => is_token_valid(value),
    _ => false
  };

  if valid {
    println!("{}", token.to_string().trim());
    return Ok(());
  }

  let result = std::process::Command::new(&args[0])
    .args(&args[1..])
    .output()
    .expect("Failed to execute process");

  if !result.status.success() {
    io::stderr().write_all(&result.stderr).unwrap();
    return Ok(());
  }

  let output = String::from_utf8(result.stdout).unwrap();
  let parsed_token = match serde_json::from_str(&output) {
    Err(e) => {
      eprintln!("Failed to parse token as json {}", e);
      return Ok(());
    }
    Ok(value) => value,
  };

  cache[key] = parsed_token;

  let tmp_dir = std::env::temp_dir();
  let tmp_file_name: String = rand::thread_rng()
    .sample_iter(&rand::distributions::Alphanumeric)
    .take(10)
    .map(char::from)
    .collect();
  let tmp_file_path = format!("{}{}", tmp_dir.to_str().unwrap(), tmp_file_name);

  let mut tmp_file = fs::File::create(&tmp_file_path)?;
  tmp_file.write_all(cache.to_string().as_bytes())?;
  tmp_file.flush()?;

  fs::rename(&tmp_file_path, &cache_file_path)?;

  println!("{}", output.trim());

  Ok(())
}
