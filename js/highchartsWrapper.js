// Internal JS function
function renderChartInternal(targetID, gene, tissuesAsString, adjustedValuesAsString) {
  console.log("TargetID " + targetID + ", gene " + gene + ", tissues " + tissuesAsString +
    ", values " + adjustedValuesAsString);
  var chart1 = new Highcharts.Chart({
       chart: {
          renderTo: targetID,
          defaultSeriesType: 'column',
          margin: [50, 50, 150, 80]
       },
       title: {
          text: 'Log average relative transcript abundance for ' + gene + ' in mouse tissues'
       },
       xAxis: {
          categories: tissuesAsString,
          labels: {
                  rotation: -90,
                  align: 'right',
                  style: {
                      font: 'normal 12px Verdana, sans-serif',
                      color: '#000000'
                  }
          }
       },
       yAxis: {
          title: {
             min: 0,
             text: 'Log average relative abundance'

          },
          labels: {
              style: {
                  color: '#000000'
              }
          }
       },
       legend: {
              enabled: false
       },
       tooltip: {
              formatter: function() {
                  return '<b>'+ this.x +'</b><br/>'+
                      'Log average relative abundance: '+ Highcharts.numberFormat(this.y, 2);
              }
       },
       series: [{
          name: 'Tissues',
          data: adjustedValuesAsString

       }]
  });
}

// Exposed to Links
function _renderChart(experiment, targetDiv) {
  console.log("in renderChart");
  const logBaseline = Math.log10(experiment.baseline);
  function adjustByBaseline(x) {
    return (Math.log10(x) - logBaseline);
  }

  const data = LINKEDLIST.toArray(experiment.data);

  const tissues = data.map(x => x[1]);
  const values = data.map(x => adjustByBaseline(x[2]));
  renderChartInternal(targetDiv, experiment.geneName, tissues, values);
}
const renderChart = LINKS.kify(_renderChart);
