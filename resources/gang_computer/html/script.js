const body = document.body;
const desktop = document.getElementById('desktop');
const intelList = document.getElementById('intel-list');
const appsGrid = document.getElementById('apps-grid');
const gangNameLabel = document.getElementById('gang-name');
const rankLabel = document.getElementById('rank-label');
const clockLabel = document.getElementById('clock');
const closeBtn = document.getElementById('close-btn');

function toggleDesktop(open) {
    if (open) {
        body.style.display = 'flex';
        requestAnimationFrame(() => {
            desktop.classList.add('open');
        });
    } else {
        desktop.classList.remove('open');
        setTimeout(() => {
            body.style.display = 'none';
        }, 180);
    }
}

function renderIntel(intel = []) {
    intelList.innerHTML = '';
    if (!intel.length) {
        const empty = document.createElement('div');
        empty.className = 'intel-card';
        empty.innerHTML = '<h3>لا توجد تقارير</h3><p>لم يتم تسجيل أي نشاط حديث.</p>';
        intelList.appendChild(empty);
        return;
    }

    intel.forEach((entry) => {
        const card = document.createElement('article');
        card.className = 'intel-card';
        card.innerHTML = `<h3>${entry.title}</h3><p>${entry.body}</p>`;
        intelList.appendChild(card);
    });
}

function renderApps(items = []) {
    appsGrid.innerHTML = '';
    if (!items.length) {
        const empty = document.createElement('p');
        empty.textContent = 'لم تتم إضافة تطبيقات بعد.';
        appsGrid.appendChild(empty);
        return;
    }

    items.forEach((item) => {
        const tile = document.createElement('button');
        tile.className = 'app-tile';
        tile.innerHTML = `
            <i class="${item.icon || 'fa-solid fa-folder-open'}"></i>
            <h3>${item.label}</h3>
            <p>${item.description}</p>
        `;
        tile.addEventListener('click', () => {
            fetch(`https://${GetParentResourceName()}/useItem`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify({ id: item.id })
            });
        });
        appsGrid.appendChild(tile);
    });
}

window.addEventListener('message', (event) => {
    const data = event.data || {};
    if (data.action === 'open') {
        gangNameLabel.textContent = data.gang || 'كمبيوتر العصابة';
        rankLabel.textContent = data.rank ? `الرتبة: ${data.rank}` : '';
        renderIntel(data.intel);
        renderApps(data.items);
        toggleDesktop(true);
    }

    if (data.action === 'close') {
        toggleDesktop(false);
    }
});

closeBtn.addEventListener('click', () => {
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        body: '{}'
    });
});

function updateClock() {
    const now = new Date();
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    clockLabel.textContent = `${hours}:${minutes}`;
}

setInterval(updateClock, 1000);
updateClock();
