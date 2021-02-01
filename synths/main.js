"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MyChart = void 0;
const cdk8s_1 = require("cdk8s");
const k8s_1 = require("./imports/k8s");
class MyChart extends cdk8s_1.Chart {
    constructor(scope, id, props = {}) {
        super(scope, id, props);
        const label = { app: 'hello-k8s' };
        new k8s_1.KubeService(this, 'service', {
            spec: {
                type: 'LoadBalancer',
                ports: [{ port: 80, targetPort: k8s_1.IntOrString.fromNumber(8080) }],
                selector: label
            }
        });
        new k8s_1.KubeDeployment(this, 'deployment', {
            spec: {
                replicas: 2,
                selector: {
                    matchLabels: label
                },
                template: {
                    metadata: { labels: label },
                    spec: {
                        containers: [
                            {
                                name: 'hello-kubernetes',
                                image: 'paulbouwer/hello-kubernetes:1.7',
                                ports: [{ containerPort: 8080 }]
                            }
                        ]
                    }
                }
            }
        });
    }
}
exports.MyChart = MyChart;
const app = new cdk8s_1.App();
new MyChart(app, 'synths');
app.synth();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWFpbi5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIm1haW4udHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7O0FBQ0EsaUNBQStDO0FBRS9DLHVDQUF5RTtBQUV6RSxNQUFhLE9BQVEsU0FBUSxhQUFLO0lBQ2hDLFlBQVksS0FBZ0IsRUFBRSxFQUFVLEVBQUUsUUFBb0IsRUFBRztRQUMvRCxLQUFLLENBQUMsS0FBSyxFQUFFLEVBQUUsRUFBRSxLQUFLLENBQUMsQ0FBQztRQUV4QixNQUFNLEtBQUssR0FBRyxFQUFFLEdBQUcsRUFBRSxXQUFXLEVBQUUsQ0FBQztRQUVuQyxJQUFJLGlCQUFXLENBQUMsSUFBSSxFQUFFLFNBQVMsRUFBRTtZQUMvQixJQUFJLEVBQUU7Z0JBQ0osSUFBSSxFQUFFLGNBQWM7Z0JBQ3BCLEtBQUssRUFBRSxDQUFFLEVBQUUsSUFBSSxFQUFFLEVBQUUsRUFBRSxVQUFVLEVBQUUsaUJBQVcsQ0FBQyxVQUFVLENBQUMsSUFBSSxDQUFDLEVBQUUsQ0FBRTtnQkFDakUsUUFBUSxFQUFFLEtBQUs7YUFDaEI7U0FDRixDQUFDLENBQUM7UUFFSCxJQUFJLG9CQUFjLENBQUMsSUFBSSxFQUFFLFlBQVksRUFBRTtZQUNyQyxJQUFJLEVBQUU7Z0JBQ0osUUFBUSxFQUFFLENBQUM7Z0JBQ1gsUUFBUSxFQUFFO29CQUNSLFdBQVcsRUFBRSxLQUFLO2lCQUNuQjtnQkFDRCxRQUFRLEVBQUU7b0JBQ1IsUUFBUSxFQUFFLEVBQUUsTUFBTSxFQUFFLEtBQUssRUFBRTtvQkFDM0IsSUFBSSxFQUFFO3dCQUNKLFVBQVUsRUFBRTs0QkFDVjtnQ0FDRSxJQUFJLEVBQUUsa0JBQWtCO2dDQUN4QixLQUFLLEVBQUUsaUNBQWlDO2dDQUN4QyxLQUFLLEVBQUUsQ0FBRSxFQUFFLGFBQWEsRUFBRSxJQUFJLEVBQUUsQ0FBRTs2QkFDbkM7eUJBQ0Y7cUJBQ0Y7aUJBQ0Y7YUFDRjtTQUNGLENBQUMsQ0FBQztJQUNMLENBQUM7Q0FDRjtBQW5DRCwwQkFtQ0M7QUFFRCxNQUFNLEdBQUcsR0FBRyxJQUFJLFdBQUcsRUFBRSxDQUFDO0FBQ3RCLElBQUksT0FBTyxDQUFDLEdBQUcsRUFBRSxRQUFRLENBQUMsQ0FBQztBQUMzQixHQUFHLENBQUMsS0FBSyxFQUFFLENBQUMiLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgeyBDb25zdHJ1Y3QgfSBmcm9tICdjb25zdHJ1Y3RzJztcbmltcG9ydCB7IEFwcCwgQ2hhcnQsIENoYXJ0UHJvcHMgfSBmcm9tICdjZGs4cyc7XG5cbmltcG9ydCB7IEt1YmVEZXBsb3ltZW50LCBLdWJlU2VydmljZSwgSW50T3JTdHJpbmcgfSBmcm9tICcuL2ltcG9ydHMvazhzJztcblxuZXhwb3J0IGNsYXNzIE15Q2hhcnQgZXh0ZW5kcyBDaGFydCB7XG4gIGNvbnN0cnVjdG9yKHNjb3BlOiBDb25zdHJ1Y3QsIGlkOiBzdHJpbmcsIHByb3BzOiBDaGFydFByb3BzID0geyB9KSB7XG4gICAgc3VwZXIoc2NvcGUsIGlkLCBwcm9wcyk7XG5cbiAgICBjb25zdCBsYWJlbCA9IHsgYXBwOiAnaGVsbG8tazhzJyB9O1xuXG4gICAgbmV3IEt1YmVTZXJ2aWNlKHRoaXMsICdzZXJ2aWNlJywge1xuICAgICAgc3BlYzoge1xuICAgICAgICB0eXBlOiAnTG9hZEJhbGFuY2VyJyxcbiAgICAgICAgcG9ydHM6IFsgeyBwb3J0OiA4MCwgdGFyZ2V0UG9ydDogSW50T3JTdHJpbmcuZnJvbU51bWJlcig4MDgwKSB9IF0sXG4gICAgICAgIHNlbGVjdG9yOiBsYWJlbFxuICAgICAgfVxuICAgIH0pO1xuXG4gICAgbmV3IEt1YmVEZXBsb3ltZW50KHRoaXMsICdkZXBsb3ltZW50Jywge1xuICAgICAgc3BlYzoge1xuICAgICAgICByZXBsaWNhczogMixcbiAgICAgICAgc2VsZWN0b3I6IHtcbiAgICAgICAgICBtYXRjaExhYmVsczogbGFiZWxcbiAgICAgICAgfSxcbiAgICAgICAgdGVtcGxhdGU6IHtcbiAgICAgICAgICBtZXRhZGF0YTogeyBsYWJlbHM6IGxhYmVsIH0sXG4gICAgICAgICAgc3BlYzoge1xuICAgICAgICAgICAgY29udGFpbmVyczogW1xuICAgICAgICAgICAgICB7XG4gICAgICAgICAgICAgICAgbmFtZTogJ2hlbGxvLWt1YmVybmV0ZXMnLFxuICAgICAgICAgICAgICAgIGltYWdlOiAncGF1bGJvdXdlci9oZWxsby1rdWJlcm5ldGVzOjEuNycsXG4gICAgICAgICAgICAgICAgcG9ydHM6IFsgeyBjb250YWluZXJQb3J0OiA4MDgwIH0gXVxuICAgICAgICAgICAgICB9XG4gICAgICAgICAgICBdXG4gICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICB9XG4gICAgfSk7XG4gIH1cbn1cblxuY29uc3QgYXBwID0gbmV3IEFwcCgpO1xubmV3IE15Q2hhcnQoYXBwLCAnc3ludGhzJyk7XG5hcHAuc3ludGgoKTtcbiJdfQ==