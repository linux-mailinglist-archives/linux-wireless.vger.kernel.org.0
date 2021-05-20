Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F1138B0FC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbhETOHq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 10:07:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:5047 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234831AbhETOG1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 10:06:27 -0400
IronPort-SDR: BP+HtXL7tjO8QDOlNw17WBY1s9X5/Am2IhPnRacBEOGHJH/NRePJGqPQ4q83uc9nZ3gaXs6Ub+
 GMXJuDc3kkjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="198144576"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="198144576"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 07:02:40 -0700
IronPort-SDR: pAV02BfRYo1pYbn7dQAJpgHzWamXzNrex2PPnQs1G33hDANdam/BEnG0E2a3Qf4tGZ+SwxOWNW
 z7yHyFo7OMYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="631407528"
Received: from bgsxx0031.iind.intel.com ([10.106.222.40])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2021 07:02:38 -0700
From:   M Chetan Kumar <m.chetan.kumar@intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, krishna.c.sudi@intel.com,
        linuxwwan@intel.com
Subject: [PATCH V3 05/16] net: iosm: shared memory I/O operations
Date:   Thu, 20 May 2021 19:31:47 +0530
Message-Id: <20210520140158.10132-6-m.chetan.kumar@intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20210520140158.10132-1-m.chetan.kumar@intel.com>
References: <20210520140158.10132-1-m.chetan.kumar@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1) Binds logical channel between host-device for communication.
2) Implements device specific(Char/Net) IO operations.

Signed-off-by: M Chetan Kumar <m.chetan.kumar@intel.com>
---
v3:
* WWAN port adaptation.
* Aligned ipc_ prefix for function name to be consistent across file.
v2:
* Change vlan_id to ip link if_id & document correction.
* Define new enums for IP & DSS session mapping.
* Return proper error code instead of returning -1.
* Clean-up vlan tag id & removed FW flashing logic.
---
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.c | 346 ++++++++++++++++++++++
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.h |  99 +++++++
 2 files changed, 445 insertions(+)
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_imem_ops.h

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
new file mode 100644
index 000000000000..46f76e8aae92
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020-21 Intel Corporation.
+ */
+
+#include <linux/delay.h>
+
+#include "iosm_ipc_chnl_cfg.h"
+#include "iosm_ipc_imem.h"
+#include "iosm_ipc_imem_ops.h"
+#include "iosm_ipc_port.h"
+#include "iosm_ipc_task_queue.h"
+
+/* Open a packet data online channel between the network layer and CP. */
+int ipc_imem_sys_wwan_open(struct iosm_imem *ipc_imem, int if_id)
+{
+	dev_dbg(ipc_imem->dev, "%s if id: %d",
+		ipc_imem_phase_get_string(ipc_imem->phase), if_id);
+
+	/* The network interface is only supported in the runtime phase. */
+	if (ipc_imem_phase_update(ipc_imem) != IPC_P_RUN) {
+		dev_err(ipc_imem->dev, "net:%d : refused phase %s", if_id,
+			ipc_imem_phase_get_string(ipc_imem->phase));
+		return -EIO;
+	}
+
+	/* check for the interafce id
+	 * if if_id 1 to 8 then create IP MUX channel sessions.
+	 * To start MUX session from 0 as network interface id would start
+	 * from 1 so map it to if_id = if_id - 1
+	 */
+	if (if_id >= IP_MUX_SESSION_START && if_id <= IP_MUX_SESSION_END)
+		return ipc_mux_open_session(ipc_imem->mux, if_id - 1);
+
+	return -EINVAL;
+}
+
+/* Release a net link to CP. */
+void ipc_imem_sys_wwan_close(struct iosm_imem *ipc_imem, int if_id,
+			     int channel_id)
+{
+	if (ipc_imem->mux && if_id >= IP_MUX_SESSION_START &&
+	    if_id <= IP_MUX_SESSION_END)
+		ipc_mux_close_session(ipc_imem->mux, if_id - 1);
+}
+
+/* Tasklet call to do uplink transfer. */
+static int ipc_imem_tq_cdev_write(struct iosm_imem *ipc_imem, int arg,
+				  void *msg, size_t size)
+{
+	ipc_imem->ev_cdev_write_pending = false;
+	ipc_imem_ul_send(ipc_imem);
+
+	return 0;
+}
+
+/* Through tasklet to do sio write. */
+static int ipc_imem_call_cdev_write(struct iosm_imem *ipc_imem)
+{
+	if (ipc_imem->ev_cdev_write_pending)
+		return -1;
+
+	ipc_imem->ev_cdev_write_pending = true;
+
+	return ipc_task_queue_send_task(ipc_imem, ipc_imem_tq_cdev_write, 0,
+					NULL, 0, false);
+}
+
+/* Function for transfer UL data */
+int ipc_imem_sys_wwan_transmit(struct iosm_imem *ipc_imem,
+			       int if_id, int channel_id, struct sk_buff *skb)
+{
+	int ret = -EINVAL;
+
+	if (!ipc_imem || channel_id < 0)
+		goto out;
+
+	/* Is CP Running? */
+	if (ipc_imem->phase != IPC_P_RUN) {
+		dev_dbg(ipc_imem->dev, "phase %s transmit",
+			ipc_imem_phase_get_string(ipc_imem->phase));
+		ret = -EIO;
+		goto out;
+	}
+
+	if (if_id >= IP_MUX_SESSION_START && if_id <= IP_MUX_SESSION_END)
+		/* Route the UL packet through IP MUX Layer */
+		ret = ipc_mux_ul_trigger_encode(ipc_imem->mux,
+						if_id - 1, skb);
+	else
+		dev_err(ipc_imem->dev,
+			"invalid if_id %d: ", if_id);
+out:
+	return ret;
+}
+
+/* Initialize wwan channel */
+void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
+				enum ipc_mux_protocol mux_type)
+{
+	struct ipc_chnl_cfg chnl_cfg = { 0 };
+
+	ipc_imem->cp_version = ipc_mmio_get_cp_version(ipc_imem->mmio);
+
+	/* If modem version is invalid (0xffffffff), do not initialize WWAN. */
+	if (ipc_imem->cp_version == -1) {
+		dev_err(ipc_imem->dev, "invalid CP version");
+		return;
+	}
+
+	ipc_chnl_cfg_get(&chnl_cfg, ipc_imem->nr_of_channels);
+	ipc_imem_channel_init(ipc_imem, IPC_CTYPE_WWAN, chnl_cfg,
+			      IRQ_MOD_OFF);
+
+	/* WWAN registration. */
+	ipc_imem->wwan = ipc_wwan_init(ipc_imem, ipc_imem->dev);
+	if (!ipc_imem->wwan)
+		dev_err(ipc_imem->dev,
+			"failed to register the ipc_wwan interfaces");
+}
+
+/* Map SKB to DMA for transfer */
+static int ipc_imem_map_skb_to_dma(struct iosm_imem *ipc_imem,
+				   struct sk_buff *skb)
+{
+	struct iosm_pcie *ipc_pcie = ipc_imem->pcie;
+	char *buf = skb->data;
+	int len = skb->len;
+	dma_addr_t mapping;
+	int ret;
+
+	ret = ipc_pcie_addr_map(ipc_pcie, buf, len, &mapping, DMA_TO_DEVICE);
+
+	if (ret)
+		goto err;
+
+	BUILD_BUG_ON(sizeof(*IPC_CB(skb)) > sizeof(skb->cb));
+
+	IPC_CB(skb)->mapping = mapping;
+	IPC_CB(skb)->direction = DMA_TO_DEVICE;
+	IPC_CB(skb)->len = len;
+	IPC_CB(skb)->op_type = (u8)UL_DEFAULT;
+
+err:
+	return ret;
+}
+
+/* return true if channel is ready for use */
+static bool ipc_imem_is_channel_active(struct iosm_imem *ipc_imem,
+				       struct ipc_mem_channel *channel)
+{
+	enum ipc_phase phase;
+
+	/* Update the current operation phase. */
+	phase = ipc_imem->phase;
+
+	/* Select the operation depending on the execution stage. */
+	switch (phase) {
+	case IPC_P_RUN:
+	case IPC_P_PSI:
+	case IPC_P_EBL:
+		break;
+
+	case IPC_P_ROM:
+		/* Prepare the PSI image for the CP ROM driver and
+		 * suspend the flash app.
+		 */
+		if (channel->state != IMEM_CHANNEL_RESERVED) {
+			dev_err(ipc_imem->dev,
+				"ch[%d]:invalid channel state %d,expected %d",
+				channel->channel_id, channel->state,
+				IMEM_CHANNEL_RESERVED);
+			goto channel_unavailable;
+		}
+		goto channel_available;
+
+	default:
+		/* Ignore uplink actions in all other phases. */
+		dev_err(ipc_imem->dev, "ch[%d]: confused phase %d",
+			channel->channel_id, phase);
+		goto channel_unavailable;
+	}
+	/* Check the full availability of the channel. */
+	if (channel->state != IMEM_CHANNEL_ACTIVE) {
+		dev_err(ipc_imem->dev, "ch[%d]: confused channel state %d",
+			channel->channel_id, channel->state);
+		goto channel_unavailable;
+	}
+
+channel_available:
+	return true;
+
+channel_unavailable:
+	return false;
+}
+
+/* Release a sio link to CP. */
+void ipc_imem_sys_cdev_close(struct iosm_cdev *ipc_cdev)
+{
+	struct iosm_imem *ipc_imem = ipc_cdev->ipc_imem;
+	struct ipc_mem_channel *channel = ipc_cdev->channel;
+	enum ipc_phase curr_phase;
+	int status = 0;
+	u32 tail = 0;
+
+	curr_phase = ipc_imem->phase;
+
+	/* If current phase is IPC_P_OFF or SIO ID is -ve then
+	 * channel is already freed. Nothing to do.
+	 */
+	if (curr_phase == IPC_P_OFF) {
+		dev_err(ipc_imem->dev,
+			"nothing to do. Current Phase: %s",
+			ipc_imem_phase_get_string(curr_phase));
+		return;
+	}
+
+	if (channel->state == IMEM_CHANNEL_FREE) {
+		dev_err(ipc_imem->dev, "ch[%d]: invalid channel state %d",
+			channel->channel_id, channel->state);
+		return;
+	}
+
+	/* If there are any pending TDs then wait for Timeout/Completion before
+	 * closing pipe.
+	 */
+	if (channel->ul_pipe.old_tail != channel->ul_pipe.old_head) {
+		ipc_imem->app_notify_ul_pend = 1;
+
+		/* Suspend the user app and wait a certain time for processing
+		 * UL Data.
+		 */
+		status = wait_for_completion_interruptible_timeout
+			 (&ipc_imem->ul_pend_sem,
+			  msecs_to_jiffies(IPC_PEND_DATA_TIMEOUT));
+		if (status == 0) {
+			dev_dbg(ipc_imem->dev,
+				"Pend data Timeout UL-Pipe:%d Head:%d Tail:%d",
+				channel->ul_pipe.pipe_nr,
+				channel->ul_pipe.old_head,
+				channel->ul_pipe.old_tail);
+		}
+
+		ipc_imem->app_notify_ul_pend = 0;
+	}
+
+	/* If there are any pending TDs then wait for Timeout/Completion before
+	 * closing pipe.
+	 */
+	ipc_protocol_get_head_tail_index(ipc_imem->ipc_protocol,
+					 &channel->dl_pipe, NULL, &tail);
+
+	if (tail != channel->dl_pipe.old_tail) {
+		ipc_imem->app_notify_dl_pend = 1;
+
+		/* Suspend the user app and wait a certain time for processing
+		 * DL Data.
+		 */
+		status = wait_for_completion_interruptible_timeout
+			 (&ipc_imem->dl_pend_sem,
+			  msecs_to_jiffies(IPC_PEND_DATA_TIMEOUT));
+		if (status == 0) {
+			dev_dbg(ipc_imem->dev,
+				"Pend data Timeout DL-Pipe:%d Head:%d Tail:%d",
+				channel->dl_pipe.pipe_nr,
+				channel->dl_pipe.old_head,
+				channel->dl_pipe.old_tail);
+		}
+
+		ipc_imem->app_notify_dl_pend = 0;
+	}
+
+	/* Due to wait for completion in messages, there is a small window
+	 * between closing the pipe and updating the channel is closed. In this
+	 * small window there could be HP update from Host Driver. Hence update
+	 * the channel state as CLOSING to aviod unnecessary interrupt
+	 * towards CP.
+	 */
+	channel->state = IMEM_CHANNEL_CLOSING;
+
+	ipc_imem_pipe_close(ipc_imem, &channel->ul_pipe);
+	ipc_imem_pipe_close(ipc_imem, &channel->dl_pipe);
+
+	ipc_imem_channel_free(channel);
+}
+
+/* Open a PORT link to CP and return the channel */
+struct ipc_mem_channel *ipc_imem_sys_port_open(struct iosm_imem *ipc_imem,
+					       int chl_id, int hp_id)
+{
+	struct ipc_mem_channel *channel;
+	int ch_id;
+
+	/* The PORT interface is only supported in the runtime phase. */
+	if (ipc_imem_phase_update(ipc_imem) != IPC_P_RUN) {
+		dev_err(ipc_imem->dev, "PORT open refused, phase %s",
+			ipc_imem_phase_get_string(ipc_imem->phase));
+		return NULL;
+	}
+
+	ch_id = ipc_imem_channel_alloc(ipc_imem, chl_id, IPC_CTYPE_CTRL);
+
+	if (ch_id < 0) {
+		dev_err(ipc_imem->dev, "reservation of an PORT chnl id failed");
+		return NULL;
+	}
+
+	channel = ipc_imem_channel_open(ipc_imem, ch_id, hp_id);
+
+	if (!channel) {
+		dev_err(ipc_imem->dev, "PORT channel id open failed");
+		return NULL;
+	}
+
+	return channel;
+}
+
+/* transfer skb to modem */
+int ipc_imem_sys_cdev_write(struct iosm_cdev *ipc_cdev, struct sk_buff *skb)
+{
+	struct ipc_mem_channel *channel = ipc_cdev->channel;
+	struct iosm_imem *ipc_imem = ipc_cdev->ipc_imem;
+	int ret = -EIO;
+
+	if (!ipc_imem_is_channel_active(ipc_imem, channel) ||
+	    ipc_imem->phase == IPC_P_OFF_REQ)
+		goto out;
+
+	ret = ipc_imem_map_skb_to_dma(ipc_imem, skb);
+
+	if (ret)
+		goto out;
+
+	/* Add skb to the uplink skbuf accumulator. */
+	skb_queue_tail(&channel->ul_list, skb);
+
+	ret = ipc_imem_call_cdev_write(ipc_imem);
+
+	if (ret) {
+		skb_dequeue_tail(&channel->ul_list);
+		dev_err(ipc_cdev->dev, "channel id[%d] write failed\n",
+			ipc_cdev->channel->channel_id);
+	}
+out:
+	return ret;
+}
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
new file mode 100644
index 000000000000..6677a82be77b
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2020-21 Intel Corporation.
+ */
+
+#ifndef IOSM_IPC_IMEM_OPS_H
+#define IOSM_IPC_IMEM_OPS_H
+
+#include "iosm_ipc_mux_codec.h"
+
+/* Maximum wait time for blocking read */
+#define IPC_READ_TIMEOUT 500
+
+/* The delay in ms for defering the unregister */
+#define SIO_UNREGISTER_DEFER_DELAY_MS 1
+
+/* Default delay till CP PSI image is running and modem updates the
+ * execution stage.
+ * unit : milliseconds
+ */
+#define PSI_START_DEFAULT_TIMEOUT 3000
+
+/* Default time out when closing SIO, till the modem is in
+ * running state.
+ * unit : milliseconds
+ */
+#define BOOT_CHECK_DEFAULT_TIMEOUT 400
+
+/* IP MUX channel range */
+#define IP_MUX_SESSION_START 1
+#define IP_MUX_SESSION_END 8
+#define MAX_IP_MUX_SESSION IP_MUX_SESSION_END
+
+/**
+ * ipc_imem_sys_port_open - Open a port link to CP.
+ * @ipc_imem:	Imem instance.
+ * @chl_id:	Channel Indentifier.
+ * @hp_id:	HP Indentifier.
+ *
+ * Return: channel instance on success, NULL for failure
+ */
+struct ipc_mem_channel *ipc_imem_sys_port_open(struct iosm_imem *ipc_imem,
+					       int chl_id, int hp_id);
+
+/**
+ * ipc_imem_sys_cdev_close - Release a sio link to CP.
+ * @ipc_cdev:		iosm sio instance.
+ */
+void ipc_imem_sys_cdev_close(struct iosm_cdev *ipc_cdev);
+
+/**
+ * ipc_imem_sys_cdev_write - Route the uplink buffer to CP.
+ * @ipc_cdev:		iosm_cdev instance.
+ * @skb:		Pointer to skb.
+ *
+ * Return: 0 on success and failure value on error
+ */
+int ipc_imem_sys_cdev_write(struct iosm_cdev *ipc_cdev, struct sk_buff *skb);
+
+/**
+ * ipc_imem_sys_wwan_open - Open packet data online channel between network
+ *			layer and CP.
+ * @ipc_imem:		Imem instance.
+ * @if_id:		ip link tag of the net device.
+ *
+ * Return: Channel ID on success and failure value on error
+ */
+int ipc_imem_sys_wwan_open(struct iosm_imem *ipc_imem, int if_id);
+
+/**
+ * ipc_imem_sys_wwan_close - Close packet data online channel between network
+ *			 layer and CP.
+ * @ipc_imem:		Imem instance.
+ * @if_id:		IP link id net device.
+ * @channel_id:		Channel ID to be closed.
+ */
+void ipc_imem_sys_wwan_close(struct iosm_imem *ipc_imem, int if_id,
+			     int channel_id);
+
+/**
+ * ipc_imem_sys_wwan_transmit - Function for transfer UL data
+ * @ipc_imem:		Imem instance.
+ * @if_id:		link ID of the device.
+ * @channel_id:		Channel ID used
+ * @skb:		Pointer to sk buffer
+ *
+ * Return: 0 on success and failure value on error
+ */
+int ipc_imem_sys_wwan_transmit(struct iosm_imem *ipc_imem, int if_id,
+			       int channel_id, struct sk_buff *skb);
+/**
+ * ipc_imem_wwan_channel_init - Initializes WWAN channels and the channel for
+ *				MUX.
+ * @ipc_imem:		Pointer to iosm_imem struct.
+ * @mux_type:		Type of mux protocol.
+ */
+void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
+				enum ipc_mux_protocol mux_type);
+#endif
-- 
2.25.1

