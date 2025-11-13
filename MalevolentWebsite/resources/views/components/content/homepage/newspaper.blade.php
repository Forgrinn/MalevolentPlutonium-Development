<?php
    $newspaper = array(
        array(
            'title' => 'Malevolent Plutonium Project 1',
            'description' => 'This is a long description about the new and upcoming project called Malevolent which is for Plutonium Black Ops 2 zombies.'
        ),
        array(
            'title' => 'Malevolent Plutonium Project 2',
            'description' => 'This is a long description about the new and upcoming project called Malevolent which is for Plutonium Black Ops 2 zombies.'
        ),
        array(
            'title' => 'Malevolent Plutonium Project 3',
            'description' => 'This is a long description about the new and upcoming project called Malevolent which is for Plutonium Black Ops 2 zombies.'
        ),
    );
?>

<div class="newspaper">
    <div class="title" id="news-title">{{ $newspaper[0]['title'] }}</div>
    <div class="description" id="news-description">{{ $newspaper[0]['description'] }}</div>
    <progress
        id="newspaper-progress"
        class="progress"
        value="0"
        max="1000"
    ></progress>
</div>

<script>
    const newspapers = {!! json_encode($newspaper) !!};

    const progress = document.getElementById('newspaper-progress');
    const titleEl = document.getElementById('news-title');
    const descEl = document.getElementById('news-description');
    const max = progress.max;

    let value = 0;
    let currentIndex = 0;

    function updateContent() {
        titleEl.classList.add('slide-out');
        descEl.classList.add('slide-out');

        setTimeout(() => {
            currentIndex = (currentIndex + 1) % newspapers.length;

            titleEl.textContent = newspapers[currentIndex].title;
            descEl.textContent = newspapers[currentIndex].description;

            titleEl.classList.remove('slide-out');
            descEl.classList.remove('slide-out');
            titleEl.classList.add('slide-in');
            descEl.classList.add('slide-in');

            setTimeout(() => {
                titleEl.classList.remove('slide-in');
                descEl.classList.remove('slide-in');
            }, 600);
        }, 600);
    }

    function startProgress() {
        value = 0;
        progress.value = value;

        const interval = setInterval(() => {
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
</script>


