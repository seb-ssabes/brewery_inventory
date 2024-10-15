import A2HS from "a2hs";

document.addEventListener("DOMContentLoaded", () => {
  new A2HS();
});

if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/service-worker.js').then(registration => {
      console.log('ServiceWorker registered: ', registration);
    }).catch(registrationError => {
      console.log('ServiceWorker registration failed: ', registrationError);
    });
  });
}
