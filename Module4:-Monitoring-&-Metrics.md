## Module 4: Monitoring & Metrics  

### Introduction

In this module, we will set up **Prometheus** for monitoring and **Grafana** for visualizing metrics in our Kubernetes cluster. By integrating these tools, we will be able to collect key metrics such as CPU, memory usage, and network traffic, and visualize them on customizable dashboards.

---

### 1. Install Prometheus & Grafana 📈

We will deploy **Prometheus** and **Grafana** on the Kubernetes cluster to collect and visualize the metrics from our game servers and other Kubernetes components.

#### Step 1: Deploy Prometheus

First, we need to deploy **Prometheus** in the Kubernetes cluster. We will use the official Prometheus Helm chart for this.

1. Install **Helm** if it is not already installed:

```bash
sudo snap install helm --classic
```

2. Add the Prometheus Helm chart repository:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

3. Install Prometheus using Helm:

```bash
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
```

This will install Prometheus along with the necessary components, including **Alertmanager**, **Prometheus Operator**, and **Grafana**, into the `monitoring` namespace.

#### Step 2: Verify Prometheus Deployment

Once installed, check if Prometheus is running:

```bash
kubectl get pods -n monitoring
```

You should see several pods related to Prometheus and Grafana. If everything looks good, you can proceed to the next step.

---

### 2. Set Up Dashboards 📊

With Prometheus running, we will now set up **Grafana** to visualize the collected metrics and create dashboards for monitoring.

#### Step 1: Access Grafana Dashboard

To access the Grafana dashboard, we need to port-forward the Grafana service to a local port.

```bash
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80
```

Now, open your browser and navigate to [http://localhost:3000](http://localhost:3000). The default login credentials are:

- Username: `admin`
- Password: `prom-operator`

#### Step 2: Add Prometheus as a Data Source

Once logged into Grafana:

1. Click on the **"gear"** icon on the left sidebar to go to the **Data Sources** section.
2. Click **Add data source** and select **Prometheus** from the list of available data sources.
3. In the **HTTP** section, enter the following URL for the Prometheus server:

```
http://prometheus-operated:9090
```

4. Click **Save & Test** to confirm that Grafana can connect to Prometheus.

#### Step 3: Import Dashboards

Now, we will import pre-configured dashboards for Kubernetes monitoring.

1. Go to **Create** (the "+" icon on the left sidebar) and select **Import**.
2. In the **Import via grafana.com** field, enter the dashboard ID for Kubernetes monitoring:

```
315
```

3. Click **Load**, and then select the Prometheus data source we added earlier.
4. Click **Import** to add the dashboard.

You should now have a pre-configured dashboard that displays metrics related to Kubernetes, including CPU usage, memory usage, and network traffic.

#### Step 4: Customize Dashboards (Optional)

You can customize your Grafana dashboards to include additional metrics, set alerts, or adjust visualizations as per your requirements. Grafana offers flexibility for building dashboards that provide a comprehensive overview of your Kubernetes cluster's performance.

---

## Conclusion

You now have **Prometheus** and **Grafana** installed and configured for monitoring and visualizing metrics in your Kubernetes cluster. With these tools, you can track the performance and health of your game servers and other Kubernetes components in real-time.

For further enhancements, you can explore additional Prometheus exporters, set up alerts for specific thresholds, or customize Grafana dashboards to meet your needs.

---

## Next Steps

Proceed to [Module 5: Game Server Deployment](#module-5-game-server-deployment) to deploy your game server on Kubernetes.

