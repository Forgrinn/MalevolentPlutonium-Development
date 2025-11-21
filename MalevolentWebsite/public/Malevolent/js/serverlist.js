function animateServerlistProgressBars(root = document) {
    const bars = root.querySelectorAll(".serverlist progress.progress:not([data-animated])");

    bars.forEach(bar => {
        const target = parseFloat(bar.getAttribute("value"));
        bar.value = 0;

        const duration = 600;
        const startTime = performance.now();

        function animate(time) {
            const progress = Math.min((time - startTime) / duration, 1);
            bar.value = progress * target;

            if (progress < 1) {
                requestAnimationFrame(animate);
            } else {
                bar.value = target;
            }
        }

        requestAnimationFrame(animate);
        bar.dataset.animated = "true";
    });
}

document.addEventListener("DOMContentLoaded", () => { animateServerlistProgressBars(); });
document.addEventListener("livewire:navigated", () => { animateServerlistProgressBars(); });
document.addEventListener("livewire:updated", (event) => { animateServerlistProgressBars(event.target); });
document.addEventListener("livewire:initialized", () => { animateServerlistProgressBars(); });
