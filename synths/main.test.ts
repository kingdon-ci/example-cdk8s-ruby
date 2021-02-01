import {MyChart} from './main';
import {Testing} from 'cdk8s';

interface MyObj2 {
  namespace: string;
}

interface MyObj {
  metadata: MyObj2;
}

describe('Placeholder', () => {
  let results: any[];
  beforeEach(() => {
    const app = Testing.app();
    const chart = new MyChart(app, 'test-chart', {namespace: 'default'});
    results = Testing.synth(chart)
  });
  test('namespace matches', () => {
    const [service, deployment] = results;
    // expect(service).toMatchSnapshot();
    // expect(deployment).toMatchSnapshot();
    let svc: MyObj = service;
    let deploy: MyObj = deployment;
    expect(svc.metadata.namespace).toEqual('default');
    expect(deploy.metadata.namespace).toEqual('default');
  });
});
