function initNewspaperProgress(json) {
    const newspapers = json;

    const progress = document.getElementById('newspaper-progress');
    if (!progress) return;

    const titles = document.querySelectorAll('.news-title');
    const descriptions = document.querySelectorAll('.news-description');
    const authors = document.querySelectorAll('.news-author');

    const max = progress.max;

    let value = 0;
    let currentIndex = 0;
    let interval = null;

    function updateContent() {
        titles.forEach((el, i) => {
            el.classList.add(i === 0 ? 'slide-out' : 'fade-out');
        });

        descriptions.forEach((el, i) => {
            el.classList.add(i === 0 ? 'slide-out' : 'fade-out');
        });

        authors.forEach((el, i) => {
            el.classList.add(i === 0 ? 'slide-out' : 'fade-out');
        });

        setTimeout(() => {
            currentIndex = (currentIndex + 1) % newspapers.length;

            titles.forEach((el, i) => {
                const idx = (currentIndex + i) % newspapers.length;
                el.textContent = newspapers[idx].title;

                el.classList.remove(i === 0 ? 'slide-out' : 'fade-out');
                el.classList.add(i === 0 ? 'slide-in' : 'fade-in');
            });

            descriptions.forEach((el, i) => {
                const idx = (currentIndex + i) % newspapers.length;
                el.textContent = newspapers[idx].description;

                el.classList.remove(i === 0 ? 'slide-out' : 'fade-out');
                el.classList.add(i === 0 ? 'slide-in' : 'fade-in');
            });

            authors.forEach((el, i) => {
                const idx = (currentIndex + i) % newspapers.length;
                const img = el.querySelector('img');
                const span = el.querySelector('span');

                if (img) img.src = newspapers[idx].image;
                if (span) span.textContent = newspapers[idx].author;

                el.classList.remove(i === 0 ? 'slide-out' : 'fade-out');
                el.classList.add(i === 0 ? 'slide-in' : 'fade-in');
            });

            setTimeout(() => {
                titles.forEach(el => el.classList.remove('slide-in', 'fade-in'));
                descriptions.forEach(el => el.classList.remove('slide-in', 'fade-in'));
                authors.forEach(el => el.classList.remove('slide-in', 'fade-in'));
            }, 600);

        }, 600);
    }

    function startProgress() {
        value = 0;
        progress.value = 0;

        if (interval) clearInterval(interval);

        interval = setInterval(() => {
            value++;
            progress.value = value;

            if (value >= max) {
                clearInterval(interval);
                updateContent();
                startProgress();
            }
        }, 10);
    }

    startProgress();
}
