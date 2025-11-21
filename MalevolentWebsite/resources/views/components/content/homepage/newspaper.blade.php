<?php
    $newspaper = array(
        array(
            'author' => 'Dec',
            'image' => asset('Malevolent/images/Dec.webp'),
            'title' => 'Malevolent Plutonium Project 1',
            'description' => 'This is a long description about the new and upcoming project called Malevolent which is for Plutonium Black Ops 2 zombies.',
            'created_at' => '2025-11-20 17:00:24'
        ),
        array(
            'author' => 'Dec',
            'image' => asset('Malevolent/images/Dec.webp'),
            'title' => 'Malevolent Plutonium Project 2',
            'description' => 'This is a long description about the new and upcoming project called Malevolent which is for Plutonium Black Ops 2 zombies.',
            'created_at' => '2025-11-20 17:00:24'
        ),
        array(
            'author' => 'Dec',
            'image' => asset('Malevolent/images/Dec.webp'),
            'title' => 'Malevolent Plutonium Project 3',
            'description' => 'This is a long description about the new and upcoming project called Malevolent which is for Plutonium Black Ops 2 zombies.',
            'created_at' => '2025-11-20 17:00:24'
        ),
        array(
            'author' => 'Dec',
            'image' => asset('Malevolent/images/Dec.webp'),
            'title' => 'Malevolent Plutonium Project 4',
            'description' => 'This is a long description about the new and upcoming project called Malevolent which is for Plutonium Black Ops 2 zombies.',
            'created_at' => '2025-11-20 17:00:24'
        ),
    );
?>

<div class="newspaper">
    <div>
        <article>
            <h2 class="title news-title" data-index="0">{{ $newspaper[0]['title'] }}</h2>
            <p class="description news-description" data-index="0">{{ $newspaper[0]['description'] }}</p>
            <div class="author news-author" data-index="0">
                <a href="/">
                    <img src="{{ $newspaper[0]['image'] }}" alt="avatar">
                    <span>{{ $newspaper[0]['author'] }}</span>
                </a>
                <div class="published">{{ Carbon\Carbon::parse($newspaper[0]['created_at'])->format('F d, Y') }}</div>
            </div>
        </article>
        <progress id="newspaper-progress" class="progress" value="0" max="1000"></progress>
    </div>

    <div>
        <article>
            <h2 class="title news-title fade" data-index="1">{{ $newspaper[1]['title'] }}</h2>
            <p class="description news-description fade" data-index="1">{{ $newspaper[1]['description'] }}</p>
            <div class="author news-author fade" data-index="1">
                <a href="/">
                    <img src="{{ $newspaper[1]['image'] }}" alt="avatar">
                    <span>{{ $newspaper[1]['author'] }}</span>
                </a>
                <div class="published">{{ Carbon\Carbon::parse($newspaper[0]['created_at'])->format('F d, Y') }}</div>
            </div>
        </article>
    </div>

    <div>
        <article>
            <h2 class="title news-title fade" data-index="2">{{ $newspaper[2]['title'] }}</h2>
            <p class="description news-description fade" data-index="2">{{ $newspaper[2]['description'] }}</p>
            <div class="author news-author fade" data-index="2">
                <a href="/">
                    <img src="{{ $newspaper[2]['image'] }}" alt="avatar">
                    <span>{{ $newspaper[2]['author'] }}</span>
                </a>
                <div class="published">{{ Carbon\Carbon::parse($newspaper[0]['created_at'])->format('F d, Y') }}</div>
            </div>
        </article>
    </div>
</div>


<script src="{{ asset('Malevolent/js/newspaper.js') }}"></script>
<script>
    document.addEventListener('DOMContentLoaded', initNewspaperProgress({!! json_encode($newspaper) !!}));
    document.addEventListener('livewire:navigated', initNewspaperProgress({!! json_encode($newspaper) !!}));
</script>

