Config = {}

Config.Computer = {
    model = `prop_dyn_pc`,
    coords = vec3(112.25, -1303.91, 29.27),
    heading = 300.0
}

Config.AllowedGangs = {
    ballas = true,
    families = true,
    vagos = true,
    triads = true
}

Config.DesktopItems = {
    {
        id = 'intel',
        label = 'لوحة المعلومات',
        description = 'مراجعة آخر العمليات وتقارير الأعضاء.',
        icon = 'fa-solid fa-chart-line',
        event = ''
    },
    {
        id = 'stash',
        label = 'مخزن العصابة',
        description = 'الوصول إلى المخزن الرئيسي وطلب الذخيرة.',
        icon = 'fa-solid fa-box-open',
        event = 'gang-computer:client:openStash'
    },
    {
        id = 'dispatch',
        label = 'البلاغات',
        description = 'عرض البلاغات الداخلية بين أعضاء العصابة.',
        icon = 'fa-solid fa-headset',
        event = 'gang-computer:client:openDispatch'
    }
}

Config.IntelFeed = {
    default = {
        {
            title = 'عمليات اليوم',
            body = 'تمت مصادرة شحنة أسلحة في الميناء الشرقي. انتبه من تحركات الشرطة.'
        },
        {
            title = 'معلومة داخلية',
            body = 'هناك مشتري جديد مهتم بطلب كمية كبيرة من المخدرات مساء الخميس.'
        }
    },
    ballas = {
        {
            title = 'منطقة المروج',
            body = 'شوهدت عصابة Families تتجول بالقرب من الحارة الرئيسية.'
        }
    }
}

Config.DispatchExamples = {
    "اطلب تعزيزات إلى المستودع الخلفي فوراً!",
    "لا تنسوا تفريغ العربات قبل نهاية الوردية.",
    "تم تجهيز دفعة الأسلحة، بانتظار التعليمات."
}
