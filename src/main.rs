use libvips::VipsApp;
///Users/iavian/Desktop/cnews/backend/image-resize/node_modules/sharp/vendor/8.10.0
//--libdir=DIR            object code libraries [EPREFIX/lib]
//  --includedir=DIR
fn main() {
   let cpus = num_cpus::get();
   let mut available_threads = cpus;
   if available_threads < 2 {
      available_threads = 2;
   }
   let vips_threads = available_threads / 2;
   let name = "dali";
   let app = VipsApp::new(name, false).expect("Cannot initialize libvips");
   app.concurrency_set(vips_threads as i32);
   app.cache_set_max(0);
   app.cache_set_max_mem(0);
   println!("Hello, world! ,{}", cpus);
}
