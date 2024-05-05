const eventStreamEndpoint = `${window.location.href}event-stream`;

async function setupEventSource() {
    evtSource = new EventSource(eventStreamEndpoint);

    evtSource.onmessage = (ev) => {
        console.log(ev.data);
    };

    evtSource.onerror = (err) => {
        console.log(err);
        evtSource.close();
    }
}


setupEventSource();
