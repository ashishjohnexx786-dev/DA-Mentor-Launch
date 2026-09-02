const CACHE='da-mentor-launch-v2.0';
const ASSETS=['./v2-release.js','./v2-source-map.js','./v2-release.css','./','./index.html','./styles.css','./curriculum.js','./app.js','./enhancements.js','./theme-picker.js','./course-sync.js','./optional-videos.js','./optional-videos-ui.js','./optional-videos.css','./manifest.webmanifest','./icon-192.svg','./icon-512.svg'];
self.addEventListener('install',e=>{e.waitUntil(caches.open(CACHE).then(c=>c.addAll(ASSETS)));self.skipWaiting();});
self.addEventListener('activate',e=>{e.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k!==CACHE&&(k.startsWith('da-mentor-os')||k.startsWith('da-mentor-launch'))).map(k=>caches.delete(k)))));self.clients.claim();});
self.addEventListener('fetch',e=>{if(e.request.method!=='GET')return;e.respondWith(fetch(e.request).then(r=>{const copy=r.clone();caches.open(CACHE).then(c=>c.put(e.request,copy));return r;}).catch(()=>caches.match(e.request).then(r=>r||caches.match('./index.html'))));});
