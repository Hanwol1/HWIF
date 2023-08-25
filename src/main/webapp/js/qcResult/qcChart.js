const createChartRendering = () => {
    const $chartContainer = document.getElementById('chart-container');
    $chartContainer.innerHTML = '';

    const arr = multiselectCheckboxChecked();


    for (let i = 0; i < arr.length; i++) {
        const datatimeRegexp = /[0-9]{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])/;
        const xValues = [];
        const yValues = [];

        for (const [key, value] of Object.entries(arr[i])) {
            if (!datatimeRegexp.test(key)) {
                continue;
            }
            if (!value) 
                continue;
            
            xValues.push(key);
            yValues.push(value);
        }
        const {LotNo, 검사명} = arr[i];
        const name = "myChart" + i;
        const chartCanvas = document.createElement('canvas');
        chartCanvas.setAttribute("id", name);
        chartCanvas.style.height = '150px';
        chartCanvas.style.width = '100%';
        $chartContainer.append(chartCanvas);

        const ctx = chartCanvas.getContext('2d');
        new Chart(ctx, {
            type: "line",
            data: {
                labels: xValues,
                datasets: [
                    {
                        label: LotNo,
                        fill: false,
                        lineTension: 0,
                        backgroundColor: "rgba(0,0,255,1.0)",
                        borderColor: "rgba(0,0,255,0.1)",
                        data: yValues
                    }
                ]
            },
            options: {
                plugins: {
                    title: {
                        display: true,
                        text: 검사명,
                        position: 'left'
                    }
                },
                legend: {
                    display: false
                },
                scales: {
                    yAxes: [
                        {
                            ticks: {
                                min: 0,
                                max: 450
                            }
                        }
                    ]
                }
            }
        });
    }
}