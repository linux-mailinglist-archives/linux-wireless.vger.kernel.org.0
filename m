Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61573A586B
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jun 2021 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhFMMxQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Jun 2021 08:53:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:20206 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231871AbhFMMxK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Jun 2021 08:53:10 -0400
IronPort-SDR: e/yAJpbCi5dU+Tp15CM4XQl74mlH2ZGWyD9gPy+SqFtQaHOyM5zhMCajD20gbcZQAU1hc5XjPC
 9Yhr5WisLGOg==
X-IronPort-AV: E=McAfee;i="6200,9189,10013"; a="227158472"
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="scan'208";a="227158472"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 05:51:09 -0700
IronPort-SDR: LxNgfGG5rFg/6MbuWZzq/m3I6EsypaW3Yub7mLKEumP74i3rG8+TGc3//HEf2bv0EshjLFb/jz
 KxzZEtOiu+bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="scan'208";a="449613031"
Received: from bgsxx0031.iind.intel.com ([10.106.222.40])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2021 05:51:07 -0700
From:   M Chetan Kumar <m.chetan.kumar@intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, krishna.c.sudi@intel.com,
        linuxwwan@intel.com
Subject: [PATCH V5 09/16] net: iosm: multiplex IP sessions
Date:   Sun, 13 Jun 2021 18:20:16 +0530
Message-Id: <20210613125023.18945-10-m.chetan.kumar@intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20210613125023.18945-1-m.chetan.kumar@intel.com>
References: <20210613125023.18945-1-m.chetan.kumar@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Establish IP session between host-device & session management.

Signed-off-by: M Chetan Kumar <m.chetan.kumar@intel.com>
---
v5: no change.
v4: no change.
v3: Aligned ipc_ prefix for function name to be consistent across file.
v2:
* Endianness type correction for Host-Device protocol structure.
* Removed space around the : for the bitfields.
* Change session from dynamic to static.
* Streamline multiple returns using goto.
---
 drivers/net/wwan/iosm/iosm_ipc_mux.c | 455 +++++++++++++++++++++++++++
 drivers/net/wwan/iosm/iosm_ipc_mux.h | 343 ++++++++++++++++++++
 2 files changed, 798 insertions(+)
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_mux.c
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_mux.h

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux.c b/drivers/net/wwan/iosm/iosm_ipc_mux.c
new file mode 100644
index 000000000000..c1c77ce699da
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020-21 Intel Corporation.
+ */
+
+#include "iosm_ipc_mux_codec.h"
+
+/* At the begin of the runtime phase the IP MUX channel shall created. */
+static int ipc_mux_channel_create(struct iosm_mux *ipc_mux)
+{
+	int channel_id;
+
+	channel_id = ipc_imem_channel_alloc(ipc_mux->imem, ipc_mux->instance_id,
+					    IPC_CTYPE_WWAN);
+
+	if (channel_id < 0) {
+		dev_err(ipc_mux->dev,
+			"allocation of the MUX channel id failed");
+		ipc_mux->state = MUX_S_ERROR;
+		ipc_mux->event = MUX_E_NOT_APPLICABLE;
+		goto no_channel;
+	}
+
+	/* Establish the MUX channel in blocking mode. */
+	ipc_mux->channel = ipc_imem_channel_open(ipc_mux->imem, channel_id,
+						 IPC_HP_NET_CHANNEL_INIT);
+
+	if (!ipc_mux->channel) {
+		dev_err(ipc_mux->dev, "ipc_imem_channel_open failed");
+		ipc_mux->state = MUX_S_ERROR;
+		ipc_mux->event = MUX_E_NOT_APPLICABLE;
+		return -ENODEV; /* MUX channel is not available. */
+	}
+
+	/* Define the MUX active state properties. */
+	ipc_mux->state = MUX_S_ACTIVE;
+	ipc_mux->event = MUX_E_NO_ORDERS;
+
+no_channel:
+	return channel_id;
+}
+
+/* Reset the session/if id state. */
+static void ipc_mux_session_free(struct iosm_mux *ipc_mux, int if_id)
+{
+	struct mux_session *if_entry;
+
+	if_entry = &ipc_mux->session[if_id];
+	/* Reset the session state. */
+	if_entry->wwan = NULL;
+}
+
+/* Create and send the session open command. */
+static struct mux_cmd_open_session_resp *
+ipc_mux_session_open_send(struct iosm_mux *ipc_mux, int if_id)
+{
+	struct mux_cmd_open_session_resp *open_session_resp;
+	struct mux_acb *acb = &ipc_mux->acb;
+	union mux_cmd_param param;
+
+	/* open_session commands to one ACB and start transmission. */
+	param.open_session.flow_ctrl = 0;
+	param.open_session.ipv4v6_hints = 0;
+	param.open_session.reserved2 = 0;
+	param.open_session.dl_head_pad_len = cpu_to_le32(IPC_MEM_DL_ETH_OFFSET);
+
+	/* Finish and transfer ACB. The user thread is suspended.
+	 * It is a blocking function call, until CP responds or timeout.
+	 */
+	acb->wanted_response = MUX_CMD_OPEN_SESSION_RESP;
+	if (ipc_mux_dl_acb_send_cmds(ipc_mux, MUX_CMD_OPEN_SESSION, if_id, 0,
+				     &param, sizeof(param.open_session), true,
+				 false) ||
+	    acb->got_response != MUX_CMD_OPEN_SESSION_RESP) {
+		dev_err(ipc_mux->dev, "if_id %d: OPEN_SESSION send failed",
+			if_id);
+		return NULL;
+	}
+
+	open_session_resp = &ipc_mux->acb.got_param.open_session_resp;
+	if (open_session_resp->response != cpu_to_le32(MUX_CMD_RESP_SUCCESS)) {
+		dev_err(ipc_mux->dev,
+			"if_id %d,session open failed,response=%d", if_id,
+			open_session_resp->response);
+		return NULL;
+	}
+
+	return open_session_resp;
+}
+
+/* Open the first IP session. */
+static bool ipc_mux_session_open(struct iosm_mux *ipc_mux,
+				 struct mux_session_open *session_open)
+{
+	struct mux_cmd_open_session_resp *open_session_resp;
+	int if_id;
+
+	/* Search for a free session interface id. */
+	if_id = le32_to_cpu(session_open->if_id);
+	if (if_id < 0 || if_id >= ipc_mux->nr_sessions) {
+		dev_err(ipc_mux->dev, "invalid interface id=%d", if_id);
+		return false;
+	}
+
+	/* Create and send the session open command.
+	 * It is a blocking function call, until CP responds or timeout.
+	 */
+	open_session_resp = ipc_mux_session_open_send(ipc_mux, if_id);
+	if (!open_session_resp) {
+		ipc_mux_session_free(ipc_mux, if_id);
+		session_open->if_id = cpu_to_le32(-1);
+		return false;
+	}
+
+	/* Initialize the uplink skb accumulator. */
+	skb_queue_head_init(&ipc_mux->session[if_id].ul_list);
+
+	ipc_mux->session[if_id].dl_head_pad_len = IPC_MEM_DL_ETH_OFFSET;
+	ipc_mux->session[if_id].ul_head_pad_len =
+		le32_to_cpu(open_session_resp->ul_head_pad_len);
+	ipc_mux->session[if_id].wwan = ipc_mux->wwan;
+
+	/* Reset the flow ctrl stats of the session */
+	ipc_mux->session[if_id].flow_ctl_en_cnt = 0;
+	ipc_mux->session[if_id].flow_ctl_dis_cnt = 0;
+	ipc_mux->session[if_id].ul_flow_credits = 0;
+	ipc_mux->session[if_id].net_tx_stop = false;
+	ipc_mux->session[if_id].flow_ctl_mask = 0;
+
+	/* Save and return the assigned if id. */
+	session_open->if_id = cpu_to_le32(if_id);
+
+	return true;
+}
+
+/* Free pending session UL packet. */
+static void ipc_mux_session_reset(struct iosm_mux *ipc_mux, int if_id)
+{
+	/* Reset the session/if id state. */
+	ipc_mux_session_free(ipc_mux, if_id);
+
+	/* Empty the uplink skb accumulator. */
+	skb_queue_purge(&ipc_mux->session[if_id].ul_list);
+}
+
+static void ipc_mux_session_close(struct iosm_mux *ipc_mux,
+				  struct mux_session_close *msg)
+{
+	int if_id;
+
+	/* Copy the session interface id. */
+	if_id = le32_to_cpu(msg->if_id);
+
+	if (if_id < 0 || if_id >= ipc_mux->nr_sessions) {
+		dev_err(ipc_mux->dev, "invalid session id %d", if_id);
+		return;
+	}
+
+	/* Create and send the session close command.
+	 * It is a blocking function call, until CP responds or timeout.
+	 */
+	if (ipc_mux_dl_acb_send_cmds(ipc_mux, MUX_CMD_CLOSE_SESSION, if_id, 0,
+				     NULL, 0, true, false))
+		dev_err(ipc_mux->dev, "if_id %d: CLOSE_SESSION send failed",
+			if_id);
+
+	/* Reset the flow ctrl stats of the session */
+	ipc_mux->session[if_id].flow_ctl_en_cnt = 0;
+	ipc_mux->session[if_id].flow_ctl_dis_cnt = 0;
+	ipc_mux->session[if_id].flow_ctl_mask = 0;
+
+	ipc_mux_session_reset(ipc_mux, if_id);
+}
+
+static void ipc_mux_channel_close(struct iosm_mux *ipc_mux,
+				  struct mux_channel_close *channel_close_p)
+{
+	int i;
+
+	/* Free pending session UL packet. */
+	for (i = 0; i < ipc_mux->nr_sessions; i++)
+		if (ipc_mux->session[i].wwan)
+			ipc_mux_session_reset(ipc_mux, i);
+
+	ipc_imem_channel_close(ipc_mux->imem, ipc_mux->channel_id);
+
+	/* Reset the MUX object. */
+	ipc_mux->state = MUX_S_INACTIVE;
+	ipc_mux->event = MUX_E_INACTIVE;
+}
+
+/* CP has interrupted AP. If AP is in IP MUX mode, execute the pending ops. */
+static int ipc_mux_schedule(struct iosm_mux *ipc_mux, union mux_msg *msg)
+{
+	enum mux_event order;
+	bool success;
+	int ret = -EIO;
+
+	if (!ipc_mux->initialized) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	order = msg->common.event;
+
+	switch (ipc_mux->state) {
+	case MUX_S_INACTIVE:
+		if (order != MUX_E_MUX_SESSION_OPEN)
+			goto out; /* Wait for the request to open a session */
+
+		if (ipc_mux->event == MUX_E_INACTIVE)
+			/* Establish the MUX channel and the new state. */
+			ipc_mux->channel_id = ipc_mux_channel_create(ipc_mux);
+
+		if (ipc_mux->state != MUX_S_ACTIVE) {
+			ret = ipc_mux->channel_id; /* Missing the MUX channel */
+			goto out;
+		}
+
+		/* Disable the TD update timer and open the first IP session. */
+		ipc_imem_td_update_timer_suspend(ipc_mux->imem, true);
+		ipc_mux->event = MUX_E_MUX_SESSION_OPEN;
+		success = ipc_mux_session_open(ipc_mux, &msg->session_open);
+
+		ipc_imem_td_update_timer_suspend(ipc_mux->imem, false);
+		if (success)
+			ret = ipc_mux->channel_id;
+		goto out;
+
+	case MUX_S_ACTIVE:
+		switch (order) {
+		case MUX_E_MUX_SESSION_OPEN:
+			/* Disable the TD update timer and open a session */
+			ipc_imem_td_update_timer_suspend(ipc_mux->imem, true);
+			ipc_mux->event = MUX_E_MUX_SESSION_OPEN;
+			success = ipc_mux_session_open(ipc_mux,
+						       &msg->session_open);
+			ipc_imem_td_update_timer_suspend(ipc_mux->imem, false);
+			if (success)
+				ret = ipc_mux->channel_id;
+			goto out;
+
+		case MUX_E_MUX_SESSION_CLOSE:
+			/* Release an IP session. */
+			ipc_mux->event = MUX_E_MUX_SESSION_CLOSE;
+			ipc_mux_session_close(ipc_mux, &msg->session_close);
+			ret = ipc_mux->channel_id;
+			goto out;
+
+		case MUX_E_MUX_CHANNEL_CLOSE:
+			/* Close the MUX channel pipes. */
+			ipc_mux->event = MUX_E_MUX_CHANNEL_CLOSE;
+			ipc_mux_channel_close(ipc_mux, &msg->channel_close);
+			ret = ipc_mux->channel_id;
+			goto out;
+
+		default:
+			/* Invalid order. */
+			goto out;
+		}
+
+	default:
+		dev_err(ipc_mux->dev,
+			"unexpected MUX transition: state=%d, event=%d",
+			ipc_mux->state, ipc_mux->event);
+	}
+out:
+	return ret;
+}
+
+struct iosm_mux *ipc_mux_init(struct ipc_mux_config *mux_cfg,
+			      struct iosm_imem *imem)
+{
+	struct iosm_mux *ipc_mux = kzalloc(sizeof(*ipc_mux), GFP_KERNEL);
+	int i, ul_tds, ul_td_size;
+	struct sk_buff_head *free_list;
+	struct sk_buff *skb;
+
+	if (!ipc_mux)
+		return NULL;
+
+	ipc_mux->protocol = mux_cfg->protocol;
+	ipc_mux->ul_flow = mux_cfg->ul_flow;
+	ipc_mux->nr_sessions = mux_cfg->nr_sessions;
+	ipc_mux->instance_id = mux_cfg->instance_id;
+	ipc_mux->wwan_q_offset = 0;
+
+	ipc_mux->pcie = imem->pcie;
+	ipc_mux->imem = imem;
+	ipc_mux->ipc_protocol = imem->ipc_protocol;
+	ipc_mux->dev = imem->dev;
+	ipc_mux->wwan = imem->wwan;
+
+	/* Get the reference to the UL ADB list. */
+	free_list = &ipc_mux->ul_adb.free_list;
+
+	/* Initialize the list with free ADB. */
+	skb_queue_head_init(free_list);
+
+	ul_td_size = IPC_MEM_MAX_DL_MUX_LITE_BUF_SIZE;
+
+	ul_tds = IPC_MEM_MAX_TDS_MUX_LITE_UL;
+
+	ipc_mux->ul_adb.dest_skb = NULL;
+
+	ipc_mux->initialized = true;
+	ipc_mux->adb_prep_ongoing = false;
+	ipc_mux->size_needed = 0;
+	ipc_mux->ul_data_pend_bytes = 0;
+	ipc_mux->state = MUX_S_INACTIVE;
+	ipc_mux->ev_mux_net_transmit_pending = false;
+	ipc_mux->tx_transaction_id = 0;
+	ipc_mux->rr_next_session = 0;
+	ipc_mux->event = MUX_E_INACTIVE;
+	ipc_mux->channel_id = -1;
+	ipc_mux->channel = NULL;
+
+	/* Allocate the list of UL ADB. */
+	for (i = 0; i < ul_tds; i++) {
+		dma_addr_t mapping;
+
+		skb = ipc_pcie_alloc_skb(ipc_mux->pcie, ul_td_size, GFP_ATOMIC,
+					 &mapping, DMA_TO_DEVICE, 0);
+		if (!skb) {
+			ipc_mux_deinit(ipc_mux);
+			return NULL;
+		}
+		/* Extend the UL ADB list. */
+		skb_queue_tail(free_list, skb);
+	}
+
+	return ipc_mux;
+}
+
+/* Informs the network stack to restart transmission for all opened session if
+ * Flow Control is not ON for that session.
+ */
+static void ipc_mux_restart_tx_for_all_sessions(struct iosm_mux *ipc_mux)
+{
+	struct mux_session *session;
+	int idx;
+
+	for (idx = 0; idx < ipc_mux->nr_sessions; idx++) {
+		session = &ipc_mux->session[idx];
+
+		if (!session->wwan)
+			continue;
+
+		/* If flow control of the session is OFF and if there was tx
+		 * stop then restart. Inform the network interface to restart
+		 * sending data.
+		 */
+		if (session->flow_ctl_mask == 0) {
+			session->net_tx_stop = false;
+			ipc_mux_netif_tx_flowctrl(session, idx, false);
+		}
+	}
+}
+
+/* Informs the network stack to stop sending further pkt for all opened
+ * sessions
+ */
+static void ipc_mux_stop_netif_for_all_sessions(struct iosm_mux *ipc_mux)
+{
+	struct mux_session *session;
+	int idx;
+
+	for (idx = 0; idx < ipc_mux->nr_sessions; idx++) {
+		session = &ipc_mux->session[idx];
+
+		if (!session->wwan)
+			continue;
+
+		ipc_mux_netif_tx_flowctrl(session, session->if_id, true);
+	}
+}
+
+void ipc_mux_check_n_restart_tx(struct iosm_mux *ipc_mux)
+{
+	if (ipc_mux->ul_flow == MUX_UL) {
+		int low_thresh = IPC_MEM_MUX_UL_FLOWCTRL_LOW_B;
+
+		if (ipc_mux->ul_data_pend_bytes < low_thresh)
+			ipc_mux_restart_tx_for_all_sessions(ipc_mux);
+	}
+}
+
+int ipc_mux_get_max_sessions(struct iosm_mux *ipc_mux)
+{
+	return ipc_mux ? ipc_mux->nr_sessions : -EFAULT;
+}
+
+enum ipc_mux_protocol ipc_mux_get_active_protocol(struct iosm_mux *ipc_mux)
+{
+	return ipc_mux ? ipc_mux->protocol : MUX_UNKNOWN;
+}
+
+int ipc_mux_open_session(struct iosm_mux *ipc_mux, int session_nr)
+{
+	struct mux_session_open *session_open;
+	union mux_msg mux_msg;
+
+	session_open = &mux_msg.session_open;
+	session_open->event = MUX_E_MUX_SESSION_OPEN;
+
+	session_open->if_id = cpu_to_le32(session_nr);
+	ipc_mux->session[session_nr].flags |= IPC_MEM_WWAN_MUX;
+	return ipc_mux_schedule(ipc_mux, &mux_msg);
+}
+
+int ipc_mux_close_session(struct iosm_mux *ipc_mux, int session_nr)
+{
+	struct mux_session_close *session_close;
+	union mux_msg mux_msg;
+	int ret_val;
+
+	session_close = &mux_msg.session_close;
+	session_close->event = MUX_E_MUX_SESSION_CLOSE;
+
+	session_close->if_id = cpu_to_le32(session_nr);
+	ret_val = ipc_mux_schedule(ipc_mux, &mux_msg);
+	ipc_mux->session[session_nr].flags &= ~IPC_MEM_WWAN_MUX;
+
+	return ret_val;
+}
+
+void ipc_mux_deinit(struct iosm_mux *ipc_mux)
+{
+	struct mux_channel_close *channel_close;
+	struct sk_buff_head *free_list;
+	union mux_msg mux_msg;
+	struct sk_buff *skb;
+
+	if (!ipc_mux->initialized)
+		return;
+	ipc_mux_stop_netif_for_all_sessions(ipc_mux);
+
+	channel_close = &mux_msg.channel_close;
+	channel_close->event = MUX_E_MUX_CHANNEL_CLOSE;
+	ipc_mux_schedule(ipc_mux, &mux_msg);
+
+	/* Empty the ADB free list. */
+	free_list = &ipc_mux->ul_adb.free_list;
+
+	/* Remove from the head of the downlink queue. */
+	while ((skb = skb_dequeue(free_list)))
+		ipc_pcie_kfree_skb(ipc_mux->pcie, skb);
+
+	if (ipc_mux->channel) {
+		ipc_mux->channel->ul_pipe.is_open = false;
+		ipc_mux->channel->dl_pipe.is_open = false;
+	}
+
+	kfree(ipc_mux);
+}
diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux.h b/drivers/net/wwan/iosm/iosm_ipc_mux.h
new file mode 100644
index 000000000000..ddd2cd0bd911
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux.h
@@ -0,0 +1,343 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2020-21 Intel Corporation.
+ */
+
+#ifndef IOSM_IPC_MUX_H
+#define IOSM_IPC_MUX_H
+
+#include "iosm_ipc_protocol.h"
+
+/* Size of the buffer for the IP MUX data buffer. */
+#define IPC_MEM_MAX_DL_MUX_BUF_SIZE (16 * 1024)
+#define IPC_MEM_MAX_UL_ADB_BUF_SIZE IPC_MEM_MAX_DL_MUX_BUF_SIZE
+
+/* Size of the buffer for the IP MUX Lite data buffer. */
+#define IPC_MEM_MAX_DL_MUX_LITE_BUF_SIZE (2 * 1024)
+
+/* TD counts for IP MUX Lite */
+#define IPC_MEM_MAX_TDS_MUX_LITE_UL 800
+#define IPC_MEM_MAX_TDS_MUX_LITE_DL 1200
+
+/* open session request (AP->CP) */
+#define MUX_CMD_OPEN_SESSION 1
+
+/* response to open session request (CP->AP) */
+#define MUX_CMD_OPEN_SESSION_RESP 2
+
+/* close session request (AP->CP) */
+#define MUX_CMD_CLOSE_SESSION 3
+
+/* response to close session request (CP->AP) */
+#define MUX_CMD_CLOSE_SESSION_RESP 4
+
+/* Flow control command with mask of the flow per queue/flow. */
+#define MUX_LITE_CMD_FLOW_CTL 5
+
+/* ACK the flow control command. Shall have the same Transaction ID as the
+ * matching FLOW_CTL command.
+ */
+#define MUX_LITE_CMD_FLOW_CTL_ACK 6
+
+/* Command for report packet indicating link quality metrics. */
+#define MUX_LITE_CMD_LINK_STATUS_REPORT 7
+
+/* Response to a report packet */
+#define MUX_LITE_CMD_LINK_STATUS_REPORT_RESP 8
+
+/* Used to reset a command/response state. */
+#define MUX_CMD_INVALID 255
+
+/* command response : command processed successfully */
+#define MUX_CMD_RESP_SUCCESS 0
+
+/* MUX for route link devices */
+#define IPC_MEM_WWAN_MUX BIT(0)
+
+/* Initiated actions to change the state of the MUX object. */
+enum mux_event {
+	MUX_E_INACTIVE, /* No initiated actions. */
+	MUX_E_MUX_SESSION_OPEN, /* Create the MUX channel and a session. */
+	MUX_E_MUX_SESSION_CLOSE, /* Release a session. */
+	MUX_E_MUX_CHANNEL_CLOSE, /* Release the MUX channel. */
+	MUX_E_NO_ORDERS, /* No MUX order. */
+	MUX_E_NOT_APPLICABLE, /* Defect IP MUX. */
+};
+
+/* MUX session open command. */
+struct mux_session_open {
+	enum mux_event event;
+	__le32 if_id;
+};
+
+/* MUX session close command. */
+struct mux_session_close {
+	enum mux_event event;
+	__le32 if_id;
+};
+
+/* MUX channel close command. */
+struct mux_channel_close {
+	enum mux_event event;
+};
+
+/* Default message type to find out the right message type. */
+struct mux_common {
+	enum mux_event event;
+};
+
+/* List of ops in MUX mode. */
+union mux_msg {
+	struct mux_session_open session_open;
+	struct mux_session_close session_close;
+	struct mux_channel_close channel_close;
+	struct mux_common common;
+};
+
+/* Parameter definition of the open session command. */
+struct mux_cmd_open_session {
+	u8 flow_ctrl; /* 0: Flow control disabled (flow allowed). */
+	/* 1: Flow control enabled (flow not allowed)*/
+	u8 ipv4v6_hints; /* 0: IPv4/IPv6 hints not supported.*/
+	/* 1: IPv4/IPv6 hints supported*/
+	__le16 reserved2; /* Reserved. Set to zero. */
+	__le32 dl_head_pad_len; /* Maximum length supported */
+	/* for DL head padding on a datagram. */
+};
+
+/* Parameter definition of the open session response. */
+struct mux_cmd_open_session_resp {
+	__le32 response; /* Response code */
+	u8 flow_ctrl; /* 0: Flow control disabled (flow allowed). */
+	/* 1: Flow control enabled (flow not allowed) */
+	u8 ipv4v6_hints; /* 0: IPv4/IPv6 hints not supported */
+	/* 1: IPv4/IPv6 hints supported */
+	__le16 reserved2; /* Reserved. Set to zero. */
+	__le32 ul_head_pad_len; /* Actual length supported for */
+	/* UL head padding on adatagram.*/
+};
+
+/* Parameter definition of the close session response code */
+struct mux_cmd_close_session_resp {
+	__le32 response;
+};
+
+/* Parameter definition of the flow control command. */
+struct mux_cmd_flow_ctl {
+	__le32 mask; /* indicating the desired flow control */
+	/* state for various flows/queues */
+};
+
+/* Parameter definition of the link status report code*/
+struct mux_cmd_link_status_report {
+	u8 payload;
+};
+
+/* Parameter definition of the link status report response code. */
+struct mux_cmd_link_status_report_resp {
+	__le32 response;
+};
+
+/**
+ * union mux_cmd_param - Union-definition of the command parameters.
+ * @open_session:	Inband command for open session
+ * @open_session_resp:	Inband command for open session response
+ * @close_session_resp:	Inband command for close session response
+ * @flow_ctl:		In-band flow control on the opened interfaces
+ * @link_status:	In-band Link Status Report
+ * @link_status_resp:	In-band command for link status report response
+ */
+union mux_cmd_param {
+	struct mux_cmd_open_session open_session;
+	struct mux_cmd_open_session_resp open_session_resp;
+	struct mux_cmd_close_session_resp close_session_resp;
+	struct mux_cmd_flow_ctl flow_ctl;
+	struct mux_cmd_link_status_report link_status;
+	struct mux_cmd_link_status_report_resp link_status_resp;
+};
+
+/* States of the MUX object.. */
+enum mux_state {
+	MUX_S_INACTIVE, /* IP MUX is unused. */
+	MUX_S_ACTIVE, /* IP MUX channel is available. */
+	MUX_S_ERROR, /* Defect IP MUX. */
+};
+
+/* Supported MUX protocols. */
+enum ipc_mux_protocol {
+	MUX_UNKNOWN,
+	MUX_LITE,
+};
+
+/* Supported UL data transfer methods. */
+enum ipc_mux_ul_flow {
+	MUX_UL_UNKNOWN,
+	MUX_UL, /* Normal UL data transfer */
+	MUX_UL_ON_CREDITS, /* UL data transfer will be based on credits */
+};
+
+/* List of the MUX session. */
+struct mux_session {
+	struct iosm_wwan *wwan; /*Network i/f used for communication*/
+	int if_id; /* i/f id for session open message.*/
+	u32 flags;
+	u32 ul_head_pad_len; /* Nr of bytes for UL head padding. */
+	u32 dl_head_pad_len; /* Nr of bytes for DL head padding. */
+	struct sk_buff_head ul_list; /* skb entries for an ADT. */
+	u32 flow_ctl_mask; /* UL flow control */
+	u32 flow_ctl_en_cnt; /* Flow control Enable cmd count */
+	u32 flow_ctl_dis_cnt; /* Flow Control Disable cmd count */
+	int ul_flow_credits; /* UL flow credits */
+	u8 net_tx_stop:1,
+	   flush:1; /* flush net interface ? */
+};
+
+/* State of a single UL data block. */
+struct mux_adb {
+	struct sk_buff *dest_skb; /* Current UL skb for the data block. */
+	u8 *buf; /* ADB memory. */
+	struct mux_adgh *adgh; /* ADGH pointer */
+	struct sk_buff *qlth_skb; /* QLTH pointer */
+	u32 *next_table_index; /* Pointer to next table index. */
+	struct sk_buff_head free_list; /* List of alloc. ADB for the UL sess.*/
+	int size; /* Size of the ADB memory. */
+	u32 if_cnt; /* Statistic counter */
+	u32 dg_cnt_total;
+	u32 payload_size;
+};
+
+/* Temporary ACB state. */
+struct mux_acb {
+	struct sk_buff *skb; /* Used UL skb. */
+	int if_id; /* Session id. */
+	u32 wanted_response;
+	u32 got_response;
+	u32 cmd;
+	union mux_cmd_param got_param; /* Received command/response parameter */
+};
+
+/**
+ * struct iosm_mux - Structure of the data multiplexing over an IP channel.
+ * @dev:		Pointer to device structure
+ * @session:		Array of the MUX sessions.
+ * @channel:		Reference to the IP MUX channel
+ * @pcie:		Pointer to iosm_pcie struct
+ * @imem:		Pointer to iosm_imem
+ * @wwan:		Poinetr to iosm_wwan
+ * @ipc_protocol:	Pointer to iosm_protocol
+ * @channel_id:		Channel ID for MUX
+ * @protocol:		Type of the MUX protocol
+ * @ul_flow:		UL Flow type
+ * @nr_sessions:	Number of sessions
+ * @instance_id:	Instance ID
+ * @state:		States of the MUX object
+ * @event:		Initiated actions to change the state of the MUX object
+ * @tx_transaction_id:	Transaction id for the ACB command.
+ * @rr_next_session:	Next session number for round robin.
+ * @ul_adb:		State of the UL ADB/ADGH.
+ * @size_needed:	Variable to store the size needed during ADB preparation
+ * @ul_data_pend_bytes:	Pending UL data to be processed in bytes
+ * @acb:		Temporary ACB state
+ * @wwan_q_offset:	This will hold the offset of the given instance
+ *			Useful while passing or receiving packets from
+ *			wwan/imem layer.
+ * @initialized:	MUX object is initialized
+ * @ev_mux_net_transmit_pending:
+ *			0 means inform the IPC tasklet to pass the
+ *			accumulated uplink ADB to CP.
+ * @adb_prep_ongoing:	Flag for ADB preparation status
+ */
+struct iosm_mux {
+	struct device *dev;
+	struct mux_session session[IPC_MEM_MUX_IP_SESSION_ENTRIES];
+	struct ipc_mem_channel *channel;
+	struct iosm_pcie *pcie;
+	struct iosm_imem *imem;
+	struct iosm_wwan *wwan;
+	struct iosm_protocol *ipc_protocol;
+	int channel_id;
+	enum ipc_mux_protocol protocol;
+	enum ipc_mux_ul_flow ul_flow;
+	int nr_sessions;
+	int instance_id;
+	enum mux_state state;
+	enum mux_event event;
+	u32 tx_transaction_id;
+	int rr_next_session;
+	struct mux_adb ul_adb;
+	int size_needed;
+	long long ul_data_pend_bytes;
+	struct mux_acb acb;
+	int wwan_q_offset;
+	u8 initialized:1,
+	   ev_mux_net_transmit_pending:1,
+	   adb_prep_ongoing:1;
+};
+
+/* MUX configuration structure */
+struct ipc_mux_config {
+	enum ipc_mux_protocol protocol;
+	enum ipc_mux_ul_flow ul_flow;
+	int nr_sessions;
+	int instance_id;
+};
+
+/**
+ * ipc_mux_init - Allocates and Init MUX instance
+ * @mux_cfg:	Pointer to MUX configuration structure
+ * @ipc_imem:	Pointer to imem data-struct
+ *
+ * Returns: Initialized mux pointer on success else NULL
+ */
+struct iosm_mux *ipc_mux_init(struct ipc_mux_config *mux_cfg,
+			      struct iosm_imem *ipc_imem);
+
+/**
+ * ipc_mux_deinit - Deallocates MUX instance
+ * @ipc_mux:	Pointer to the MUX instance.
+ */
+void ipc_mux_deinit(struct iosm_mux *ipc_mux);
+
+/**
+ * ipc_mux_check_n_restart_tx - Checks for pending UL date bytes and then
+ *				it restarts the net interface tx queue if
+ *				device has set flow control as off.
+ * @ipc_mux:	Pointer to MUX data-struct
+ */
+void ipc_mux_check_n_restart_tx(struct iosm_mux *ipc_mux);
+
+/**
+ * ipc_mux_get_active_protocol - Returns the active MUX protocol type.
+ * @ipc_mux:	Pointer to MUX data-struct
+ *
+ * Returns: enum of type ipc_mux_protocol
+ */
+enum ipc_mux_protocol ipc_mux_get_active_protocol(struct iosm_mux *ipc_mux);
+
+/**
+ * ipc_mux_open_session - Opens a MUX session for IP traffic.
+ * @ipc_mux:	Pointer to MUX data-struct
+ * @session_nr:	Interface ID or session number
+ *
+ * Returns: channel id on success, failure value on error
+ */
+int ipc_mux_open_session(struct iosm_mux *ipc_mux, int session_nr);
+
+/**
+ * ipc_mux_close_session - Closes a MUX session.
+ * @ipc_mux:	Pointer to MUX data-struct
+ * @session_nr:	Interface ID or session number
+ *
+ * Returns: channel id on success, failure value on error
+ */
+int ipc_mux_close_session(struct iosm_mux *ipc_mux, int session_nr);
+
+/**
+ * ipc_mux_get_max_sessions - Retuns the maximum sessions supported on the
+ *			      provided MUX instance..
+ * @ipc_mux:	Pointer to MUX data-struct
+ *
+ * Returns: Number of sessions supported on Success and failure value on error
+ */
+int ipc_mux_get_max_sessions(struct iosm_mux *ipc_mux);
+#endif
-- 
2.25.1

