Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B35D2ED520
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jan 2021 18:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbhAGRHY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Jan 2021 12:07:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:53928 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbhAGRHY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Jan 2021 12:07:24 -0500
IronPort-SDR: URazgUtcJw6vmQuLl5KPx7ZN6oNT5pBN1IxhxMAfkbSkaZ3AgN/nmBj4zFnEqgke6iYS8nsDUN
 7JIQ5tl5DGWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="176681017"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="176681017"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 09:06:30 -0800
IronPort-SDR: ibd0U3TaK4hMWX8pagLGvIM3XXnYAAxeLndDS51jCKxNjaPYs4qxXODACer5Z9mvuPUj0FfmS+
 3nepX2EnHEYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="422643982"
Received: from bgsxx0031.iind.intel.com ([10.106.222.40])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2021 09:06:27 -0800
From:   M Chetan Kumar <m.chetan.kumar@intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, krishna.c.sudi@intel.com,
        m.chetan.kumar@intel.com
Subject: [PATCH 13/18] net: iosm: shared memory protocol
Date:   Thu,  7 Jan 2021 22:35:18 +0530
Message-Id: <20210107170523.26531-14-m.chetan.kumar@intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20210107170523.26531-1-m.chetan.kumar@intel.com>
References: <20210107170523.26531-1-m.chetan.kumar@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1) Defines messaging protocol for handling Transfer Descriptor
   in both UL/DL direction.
2) Ring buffer management.

Signed-off-by: M Chetan Kumar <m.chetan.kumar@intel.com>
---
 drivers/net/wwan/iosm/iosm_ipc_protocol.c | 287 ++++++++++++++++++++++++++++++
 drivers/net/wwan/iosm/iosm_ipc_protocol.h | 239 +++++++++++++++++++++++++
 2 files changed, 526 insertions(+)
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_protocol.c
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_protocol.h

diff --git a/drivers/net/wwan/iosm/iosm_ipc_protocol.c b/drivers/net/wwan/iosm/iosm_ipc_protocol.c
new file mode 100644
index 000000000000..b256724d2fe6
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_protocol.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Intel Corporation.
+ */
+
+#include "iosm_ipc_protocol.h"
+#include "iosm_ipc_task_queue.h"
+
+int ipc_protocol_tq_msg_send(struct iosm_protocol *ipc_protocol,
+			     enum ipc_msg_prep_type msg_type,
+			     union ipc_msg_prep_args *prep_args,
+			     struct ipc_rsp *response)
+{
+	int index = ipc_protocol_msg_prep(ipc_protocol->imem, msg_type,
+					  prep_args);
+
+	/* Store reference towards caller specified response in response ring
+	 * and signal CP
+	 */
+	if (index >= 0 && index < IPC_MEM_MSG_ENTRIES) {
+		ipc_protocol->rsp_ring[index] = response;
+		ipc_protocol_msg_hp_update(ipc_protocol->imem);
+	}
+
+	return index;
+}
+
+/* Callback for message send */
+static int ipc_protocol_tq_msg_send_cb(struct iosm_imem *ipc_imem, int arg,
+				       void *msg, size_t size)
+{
+	struct ipc_call_msg_send_args *send_args = msg;
+	struct iosm_protocol *ipc_protocol = ipc_imem->ipc_protocol;
+
+	return ipc_protocol_tq_msg_send(ipc_protocol, send_args->msg_type,
+					send_args->prep_args,
+					send_args->response);
+}
+
+/* Remove reference to a response. This is typically used when a requestor timed
+ * out and is no longer interested in the response.
+ */
+static int ipc_protocol_tq_msg_remove(struct iosm_imem *ipc_imem, int arg,
+				      void *msg, size_t size)
+{
+	struct iosm_protocol *ipc_protocol = ipc_imem->ipc_protocol;
+
+	ipc_protocol->rsp_ring[arg] = NULL;
+	return 0;
+}
+
+int ipc_protocol_msg_send(struct iosm_protocol *ipc_protocol,
+			  enum ipc_msg_prep_type prep,
+			  union ipc_msg_prep_args *prep_args)
+{
+	struct ipc_call_msg_send_args send_args;
+	unsigned int exec_timeout;
+	struct ipc_rsp response;
+	int index;
+
+	exec_timeout = (ipc_protocol_get_ap_exec_stage(ipc_protocol) ==
+					IPC_MEM_EXEC_STAGE_RUN ?
+				IPC_MSG_COMPLETE_RUN_DEFAULT_TIMEOUT :
+				IPC_MSG_COMPLETE_BOOT_DEFAULT_TIMEOUT);
+
+	/* Trap if called from non-preemptible context */
+	might_sleep();
+
+	response.status = IPC_MEM_MSG_CS_INVALID;
+	init_completion(&response.completion);
+
+	send_args.msg_type = prep;
+	send_args.prep_args = prep_args;
+	send_args.response = &response;
+
+	/* Allocate and prepare message to be sent in tasklet context.
+	 * A positive index returned form tasklet_call references the message
+	 * in case it needs to be cancelled when there is a timeout.
+	 */
+	index = ipc_task_queue_send_task(ipc_protocol->imem,
+					 ipc_protocol_tq_msg_send_cb, 0,
+					 &send_args, 0, true);
+
+	if (index < 0) {
+		dev_err(ipc_protocol->dev, "msg %d failed", prep);
+		return index;
+	}
+
+	/* Wait for the device to respond to the message */
+	switch (wait_for_completion_timeout(&response.completion,
+					    msecs_to_jiffies(exec_timeout))) {
+	case 0:
+		/* Timeout, there was no response from the device.
+		 * Remove the reference to the local response completion
+		 * object as we are no longer interested in the response.
+		 */
+		ipc_task_queue_send_task(ipc_protocol->imem,
+					 ipc_protocol_tq_msg_remove, index,
+					 NULL, 0, true);
+		dev_err(ipc_protocol->dev, "msg timeout");
+		ipc_uevent_send(ipc_protocol->pcie->dev, UEVENT_MDM_TIMEOUT);
+		break;
+	default:
+		/* We got a response in time; check completion status: */
+		if (response.status != IPC_MEM_MSG_CS_SUCCESS) {
+			dev_err(ipc_protocol->dev,
+				"msg completion status error %d",
+				response.status);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int ipc_protocol_msg_send_host_sleep(struct iosm_protocol *ipc_protocol,
+					    u32 state)
+{
+	union ipc_msg_prep_args prep_args = {
+		.sleep.target = 0,
+		.sleep.state = state,
+	};
+
+	return ipc_protocol_msg_send(ipc_protocol, IPC_MSG_PREP_SLEEP,
+				     &prep_args);
+}
+
+void ipc_protocol_doorbell_trigger(struct iosm_protocol *ipc_protocol,
+				   u32 identifier)
+{
+	ipc_pm_signal_hpda_doorbell(ipc_protocol->pm, identifier, true);
+}
+
+bool ipc_protocol_pm_dev_sleep_handle(struct iosm_protocol *ipc_protocol)
+{
+	u32 ipc_status = ipc_protocol_get_ipc_status(ipc_protocol);
+	u32 requested;
+
+	if (ipc_status != IPC_MEM_DEVICE_IPC_RUNNING) {
+		dev_err(ipc_protocol->dev,
+			"irq ignored, CP IPC state is %d, should be RUNNING",
+			ipc_status);
+
+		/* Stop further processing. */
+		return false;
+	}
+
+	/* Get a copy of the requested PM state by the device and the local
+	 * device PM state.
+	 */
+	requested = ipc_protocol_pm_dev_get_sleep_notification(ipc_protocol);
+
+	return ipc_pm_dev_slp_notification(ipc_protocol->pm, requested);
+}
+
+static int ipc_protocol_tq_wakeup_dev_slp(struct iosm_imem *ipc_imem, int arg,
+					  void *msg, size_t size)
+{
+	struct iosm_protocol *ipc_protocol = ipc_imem->ipc_protocol;
+
+	/* Wakeup from device sleep if it is not ACTIVE */
+	if (!ipc_pm_trigger(ipc_protocol->pm, IPC_PM_UNIT_HS, true))
+		/* Link was not active. Prepare for notification and waiting */
+		ipc_pm_host_slp_reinit_dev_active_completion(ipc_protocol->pm);
+
+	ipc_pm_trigger(ipc_protocol->pm, IPC_PM_UNIT_HS, false);
+
+	return 0;
+}
+
+void ipc_protocol_s2idle_sleep(struct iosm_protocol *ipc_protocol, bool sleep)
+{
+	ipc_pm_set_s2idle_sleep(ipc_protocol->pm, sleep);
+}
+
+bool ipc_protocol_suspend(struct iosm_protocol *ipc_protocol)
+{
+	if (!ipc_pm_prepare_host_sleep(ipc_protocol->pm))
+		goto err;
+
+	ipc_task_queue_send_task(ipc_protocol->imem,
+				 ipc_protocol_tq_wakeup_dev_slp, 0, NULL, 0,
+				 true);
+
+	if (!ipc_pm_wait_for_device_active(ipc_protocol->pm)) {
+		ipc_uevent_send(ipc_protocol->pcie->dev, UEVENT_MDM_TIMEOUT);
+		goto err;
+	}
+
+	/* Send the sleep message for sync sys calls. */
+	dev_dbg(ipc_protocol->dev, "send TARGET_HOST, ENTER_SLEEP");
+	if (ipc_protocol_msg_send_host_sleep(ipc_protocol,
+					     IPC_HOST_SLEEP_ENTER_SLEEP)) {
+		/* Sending ENTER_SLEEP message failed, we are still active */
+		ipc_protocol->pm->host_pm_state = IPC_MEM_HOST_PM_ACTIVE;
+		goto err;
+	}
+
+	ipc_protocol->pm->host_pm_state = IPC_MEM_HOST_PM_SLEEP;
+	return true;
+err:
+	return false;
+}
+
+bool ipc_protocol_resume(struct iosm_protocol *ipc_protocol)
+{
+	if (!ipc_pm_prepare_host_active(ipc_protocol->pm))
+		return false;
+
+	dev_dbg(ipc_protocol->dev, "send TARGET_HOST, EXIT_SLEEP");
+	if (ipc_protocol_msg_send_host_sleep(ipc_protocol,
+					     IPC_HOST_SLEEP_EXIT_SLEEP)) {
+		ipc_protocol->pm->host_pm_state = IPC_MEM_HOST_PM_SLEEP;
+		return false;
+	}
+
+	ipc_protocol->pm->host_pm_state = IPC_MEM_HOST_PM_ACTIVE;
+
+	return true;
+}
+
+struct iosm_protocol *ipc_protocol_init(struct iosm_imem *ipc_imem)
+{
+	struct iosm_protocol *ipc_protocol =
+		kzalloc(sizeof(*ipc_protocol), GFP_KERNEL);
+	struct ipc_protocol_context_info *p_ci;
+	u64 addr;
+
+	if (!ipc_protocol)
+		return NULL;
+
+	ipc_protocol->dev = ipc_imem->dev;
+	ipc_protocol->pcie = ipc_imem->pcie;
+	ipc_protocol->imem = ipc_imem;
+	ipc_protocol->p_ap_shm = NULL;
+	ipc_protocol->phy_ap_shm = 0;
+
+	ipc_protocol->old_msg_tail = 0;
+
+	ipc_protocol->p_ap_shm =
+		pci_alloc_consistent(ipc_protocol->pcie->pci,
+				     sizeof(*ipc_protocol->p_ap_shm),
+				     &ipc_protocol->phy_ap_shm);
+
+	if (!ipc_protocol->p_ap_shm) {
+		dev_err(ipc_protocol->dev, "pci shm alloc error");
+		kfree(ipc_protocol);
+		return NULL;
+	}
+
+	/* Prepare the context info for CP. */
+	addr = ipc_protocol->phy_ap_shm;
+	p_ci = &ipc_protocol->p_ap_shm->ci;
+	p_ci->device_info_addr =
+		addr + offsetof(struct ipc_protocol_ap_shm, device_info);
+	p_ci->head_array =
+		addr + offsetof(struct ipc_protocol_ap_shm, head_array);
+	p_ci->tail_array =
+		addr + offsetof(struct ipc_protocol_ap_shm, tail_array);
+	p_ci->msg_head = addr + offsetof(struct ipc_protocol_ap_shm, msg_head);
+	p_ci->msg_tail = addr + offsetof(struct ipc_protocol_ap_shm, msg_tail);
+	p_ci->msg_ring_addr =
+		addr + offsetof(struct ipc_protocol_ap_shm, msg_ring);
+	p_ci->msg_ring_entries = IPC_MEM_MSG_ENTRIES;
+	p_ci->msg_irq_vector = IPC_MSG_IRQ_VECTOR;
+	p_ci->device_info_irq_vector = IPC_DEVICE_IRQ_VECTOR;
+
+	ipc_mmio_set_contex_info_addr(ipc_imem->mmio, addr);
+
+	ipc_protocol->pm = ipc_pm_init(ipc_imem);
+
+	if (!ipc_protocol->pm) {
+		ipc_protocol_deinit(ipc_protocol);
+		return NULL;
+	}
+
+	return ipc_protocol;
+}
+
+void ipc_protocol_deinit(struct iosm_protocol *proto)
+{
+	pci_free_consistent(proto->pcie->pci, sizeof(*proto->p_ap_shm),
+			    proto->p_ap_shm, proto->phy_ap_shm);
+
+	ipc_pm_deinit(proto->pm);
+	kfree(proto);
+}
diff --git a/drivers/net/wwan/iosm/iosm_ipc_protocol.h b/drivers/net/wwan/iosm/iosm_ipc_protocol.h
new file mode 100644
index 000000000000..b9a5e87befaf
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_protocol.h
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2020 Intel Corporation.
+ */
+
+#ifndef IOSM_IPC_PROTOCOL_H
+#define IOSM_IPC_PROTOCOL_H
+
+#include "iosm_ipc_imem.h"
+#include "iosm_ipc_pm.h"
+#include "iosm_ipc_protocol_ops.h"
+
+/* Trigger the doorbell interrupt on CP. */
+#define IPC_DOORBELL_IRQ_HPDA 0
+#define IPC_DOORBELL_IRQ_IPC 1
+#define IPC_DOORBELL_IRQ_SLEEP 2
+
+/* IRQ vector number. */
+#define IPC_DEVICE_IRQ_VECTOR 0
+#define IPC_MSG_IRQ_VECTOR 0
+#define IPC_UL_PIPE_IRQ_VECTOR 0
+#define IPC_DL_PIPE_IRQ_VECTOR 0
+
+#define IPC_MEM_MSG_ENTRIES 128
+
+/* Default time out for sending IPC messages like open pipe, close pipe etc.
+ * during run mode.
+ *
+ * If the message interface lock to CP times out, the link to CP is broken.
+ * mode : run mode (IPC_MEM_EXEC_STAGE_RUN)
+ * unit : milliseconds
+ */
+#define IPC_MSG_COMPLETE_RUN_DEFAULT_TIMEOUT 500 /* 0.5 seconds */
+
+/* Default time out for sending IPC messages like open pipe, close pipe etc.
+ * during boot mode.
+ *
+ * If the message interface lock to CP times out, the link to CP is broken.
+ * mode : boot mode
+ * (IPC_MEM_EXEC_STAGE_BOOT | IPC_MEM_EXEC_STAGE_PSI | IPC_MEM_EXEC_STAGE_EBL)
+ * unit : milliseconds
+ */
+#define IPC_MSG_COMPLETE_BOOT_DEFAULT_TIMEOUT 500 /* 0.5 seconds */
+
+/**
+ * struct ipc_protocol_context_info - Structure of the context info
+ * @device_info_addr:		64 bit address to device info
+ * @head_array:			64 bit address to head pointer arr for the pipes
+ * @tail_array:			64 bit address to tail pointer arr for the pipes
+ * @msg_head:			64 bit address to message head pointer
+ * @msg_tail:			64 bit address to message tail pointer
+ * @msg_ring_addr:		64 bit pointer to the message ring buffer
+ * @msg_ring_entries:		This field provides the number of entries which
+ *				the MR can hold
+ * @msg_irq_vector:		This field provides the IRQ which shall be
+ *				generated by the EP device when generating
+ *				completion for Messages.
+ * @device_info_irq_vector:	This field provides the IRQ which shall be
+ *				generated by the EP dev after updating Dev. Info
+ * @reserved:			reserved
+ */
+struct ipc_protocol_context_info {
+	phys_addr_t device_info_addr;
+	phys_addr_t head_array;
+	phys_addr_t tail_array;
+	phys_addr_t msg_head;
+	phys_addr_t msg_tail;
+	phys_addr_t msg_ring_addr;
+	u32 msg_ring_entries : 16;
+	u32 msg_irq_vector : 5;
+	u32 device_info_irq_vector : 5;
+	u32 reserved : 6;
+};
+
+/**
+ * struct ipc_protocol_device_info - Structure for the device information
+ * @execution_stage:		CP execution stage
+ * @ipc_status:			IPC states
+ * @device_sleep_notification:	Requested device pm states
+ */
+struct ipc_protocol_device_info {
+	u32 execution_stage;
+	u32 ipc_status;
+	u32 device_sleep_notification;
+};
+
+/**
+ * struct ipc_protocol_ap_shm - Protocol Shared Memory Structure
+ * @ci:			Context information struct
+ * @device_info:	Device information struct
+ * @msg_head:		Point to msg head
+ * @head_array:		Array of head pointer
+ * @msg_tail:		Point to msg tail
+ * @tail_array:		Array of tail pointer
+ * @msg_ring:		Circular buffers for the read/tail and write/head
+ *			indeces.
+ */
+struct ipc_protocol_ap_shm {
+	struct ipc_protocol_context_info ci;
+	struct ipc_protocol_device_info device_info;
+	u32 msg_head;
+	u32 head_array[IPC_MEM_MAX_PIPES];
+	u32 msg_tail;
+	u32 tail_array[IPC_MEM_MAX_PIPES];
+	union ipc_mem_msg_entry msg_ring[IPC_MEM_MSG_ENTRIES];
+};
+
+/**
+ * struct iosm_protocol - Structure for IPC protocol.
+ * @p_ap_shm:		Pointer to Protocol Shared Memory Structure
+ * @pm:			Pointer to struct iosm_pm
+ * @pcie:		Pointer to struct iosm_pcie
+ * @imem:		Pointer to struct iosm_imem
+ * @rsp_ring:		Array of OS completion objects to be triggered once CP
+ *			acknowledges a request in the message ring
+ * @dev:		Pointer to device structure
+ * @phy_ap_shm:		Physical/Mapped representation of the shared memory info
+ * @old_msg_tail:	Old msg tail ptr, until AP has handled ACK's from CP
+ */
+struct iosm_protocol {
+	struct ipc_protocol_ap_shm *p_ap_shm;
+	struct iosm_pm *pm;
+	struct iosm_pcie *pcie;
+	struct iosm_imem *imem;
+	struct ipc_rsp *rsp_ring[IPC_MEM_MSG_ENTRIES];
+	struct device *dev;
+	phys_addr_t phy_ap_shm;
+	u32 old_msg_tail;
+};
+
+/**
+ * struct ipc_call_msg_send_args - Structure for message argument for
+ *				   tasklet function.
+ * @prep_args:		Arguments for message preparation function
+ * @response:		Can be NULL if result can be ignored
+ * @msg_type:		Message Type
+ */
+struct ipc_call_msg_send_args {
+	union ipc_msg_prep_args *prep_args;
+	struct ipc_rsp *response;
+	enum ipc_msg_prep_type msg_type;
+};
+
+/**
+ * ipc_protocol_tq_msg_send - prepare the msg and send to CP
+ * @ipc_protocol:	Pointer to ipc_protocol instance
+ * @msg_type:		Message type
+ * @prep_args:		Message arguments
+ * @response:		Pointer to a response object which has a
+ *			completion object and return code.
+ *
+ * Returns: 0 on success, -1 on failure
+ */
+int ipc_protocol_tq_msg_send(struct iosm_protocol *ipc_protocol,
+			     enum ipc_msg_prep_type msg_type,
+			     union ipc_msg_prep_args *prep_args,
+			     struct ipc_rsp *response);
+
+/**
+ * ipc_protocol_msg_send - Send ipc control message to CP and wait for response
+ * @ipc_protocol:	Pointer to ipc_protocol instance
+ * @prep:		Message type
+ * @prep_args:		Message arguments
+ *
+ * Returns: 0 on success, -1 on failure
+ */
+int ipc_protocol_msg_send(struct iosm_protocol *ipc_protocol,
+			  enum ipc_msg_prep_type prep,
+			  union ipc_msg_prep_args *prep_args);
+
+/**
+ * ipc_protocol_suspend - Signal to CP that host wants to go to sleep (suspend).
+ * @ipc_protocol:	Pointer to ipc_protocol instance
+ *
+ * Returns: true if host can suspend, false if suspend must be aborted.
+ */
+bool ipc_protocol_suspend(struct iosm_protocol *ipc_protocol);
+
+/**
+ * ipc_protocol_s2idle_sleep - Call PM function to set PM variables in s2idle
+ *			       sleep/active case
+ * @ipc_protocol:	Pointer to ipc_protocol instance
+ * @sleep:		True for sleep/False for active
+ */
+void ipc_protocol_s2idle_sleep(struct iosm_protocol *ipc_protocol, bool sleep);
+
+/**
+ * ipc_protocol_resume - Signal to CP that host wants to resume operation.
+ * @ipc_protocol:	Pointer to ipc_protocol instance
+ *
+ * Returns: true if host can resume, false if there is a problem.
+ */
+bool ipc_protocol_resume(struct iosm_protocol *ipc_protocol);
+
+/**
+ * ipc_protocol_pm_dev_sleep_handle - Handles the Device Sleep state change
+ *				      notification.
+ * @ipc_protocol:	Pointer to ipc_protocol instance.
+ *
+ * Returns: true if sleep notification handled, false otherwise.
+ */
+bool ipc_protocol_pm_dev_sleep_handle(struct iosm_protocol *ipc_protocol);
+
+/**
+ * ipc_protocol_doorbell_trigger - Wrapper for PM function which wake up the
+ *				   device if it is in low power mode
+ *				   and trigger a head pointer update interrupt.
+ * @ipc_protocol:	Pointer to ipc_protocol instance.
+ * @identifier:		Specifies what component triggered hpda
+ *			update irq
+ */
+void ipc_protocol_doorbell_trigger(struct iosm_protocol *ipc_protocol,
+				   u32 identifier);
+
+/**
+ * ipc_protocol_sleep_notification_string - Returns last Sleep Notification as
+ *					    string.
+ * @ipc_protocol:	Instance pointer of Protocol module.
+ *
+ * Returns: Pointer to string.
+ */
+const char *
+ipc_protocol_sleep_notification_string(struct iosm_protocol *ipc_protocol);
+
+/**
+ * ipc_protocol_init - Allocates IPC protocol instance
+ * @ipc_imem:		Pointer to iosm_imem structure
+ *
+ * Returns: Address of IPC  protocol instance on success & NULL on failure.
+ */
+struct iosm_protocol *ipc_protocol_init(struct iosm_imem *ipc_imem);
+
+/**
+ * ipc_protocol_deinit - Deallocates IPC protocol instance
+ * @ipc_protocol:	pointer to the IPC protocol instance
+ */
+void ipc_protocol_deinit(struct iosm_protocol *ipc_protocol);
+
+#endif
-- 
2.12.3

