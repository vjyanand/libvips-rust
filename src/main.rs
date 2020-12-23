use a2::{
   Client, CollapseId, Endpoint, NotificationBuilder, NotificationOptions,
   PlainNotificationBuilder, Priority,
};
use std::fs::File;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
   let mut builder = PlainNotificationBuilder::new("Yahoo!k112");
   builder.set_category("break");
   builder.set_sound("g.caf");

   let options = NotificationOptions {
      apns_topic: Some("com.iavian.breakingnews"),
      apns_collapse_id: Some(CollapseId { value: "break1" }),
      apns_id: Some("3B381E13-52C3-40EF-AE84-9DC0EA350507"),
      apns_expiration: Some(420),
      apns_priority: Some(Priority::High),
   };
   let payload = builder.build(
      "9431d3a5a255f4e422058975d29c7c82cec0a9b39f6df4ae09abe710f458722b",
      options,
   );
   let mut file = File::open("/Users/iavian/Desktop/quic-quinn/key.p8").expect("Poda go");

   let client = Client::token(&mut file, "9WTD8HKTV3", "JX83D66C47", Endpoint::Production).unwrap();
   
   let response = client.send(payload).await?;
   println!("Sent: {:?}", response);
   Ok(())
}
