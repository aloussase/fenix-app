const CACHE_NAME = "fenix-app-cache-v6";
const CACHED_URLS = [
  // HTML
  "/",
  "index.html",
  // Images
  "assets/lightbulb.png",
  "assets/lightbulb-off.png",
  // Scripts
  "build/main.js",
  // StyleSheets
  "https://cdn.jsdelivr.net/npm/beercss@3.7.10/dist/cdn/beer.min.css",
  "https://cdn.jsdelivr.net/npm/beercss@3.7.10/dist/cdn/beer.min.js",
  "https://cdn.jsdelivr.net/npm/material-dynamic-colors@1.1.2/dist/cdn/material-dynamic-colors.min.js",
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(CACHED_URLS);
    })
  );
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys().then((keyList) => {
      return Promise.all(
        keyList.map((key) => {
          if (key === CACHE_NAME) {
            return;
          }
          return caches.delete(key);
        })
      );
    })
  );
});

self.addEventListener("fetch", (event) => {
  const url = new URL(event.request.url);
  if (CACHED_URLS.some((u) => url.pathname.endsWith(u))) {
    return event.respondWith(
      caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          return response || fetch(event.request);
        });
      })
    );
  }
});
