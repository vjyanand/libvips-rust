use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use std::env;


async fn index() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

async fn index2() -> impl Responder {
    HttpResponse::Ok().body("Hello world again!")
}

#[tokio::main]
async fn main() -> std::io::Result<()> {
    let HOST = env::var("HOST").expect("Host not set");
    let PORT = env::var("PORT").expect("Port not set");
    HttpServer::new(|| {
        App::new()
            .route("/", web::get().to(index))
            .route("/again", web::get().to(index2))
    })
    .bind(format!("{}:{}", HOST, PORT))?
    .run()
    .await
}