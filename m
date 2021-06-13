Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB53A586F
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jun 2021 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhFMMxX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Jun 2021 08:53:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:20206 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231872AbhFMMxQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Jun 2021 08:53:16 -0400
IronPort-SDR: MQofEUM0StnbYdUAFXl9nq2vy/4pL5cqPTuUXKwow3on5swp23MBHk6+pxWFxj9w1YsFMlfKCR
 UIWjnU9TSHuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10013"; a="227158482"
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="scan'208";a="227158482"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 05:51:15 -0700
IronPort-SDR: 2vU+e060I2zyqmbrnGwZbkq2VleE9bLXf2Fh42cwV2IgMR23AM4M4y8RcfDZ2lCEXh/GetAfny
 5UlW9LmgUy/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="scan'208";a="449613044"
Received: from bgsxx0031.iind.intel.com ([10.106.222.40])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2021 05:51:13 -0700
From:   M Chetan Kumar <m.chetan.kumar@intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, krishna.c.sudi@intel.com,
        linuxwwan@intel.com
Subject: [PATCH V5 11/16] net: iosm: power management
Date:   Sun, 13 Jun 2021 18:20:18 +0530
Message-Id: <20210613125023.18945-12-m.chetan.kumar@intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20210613125023.18945-1-m.chetan.kumar@intel.com>
References: <20210613125023.18945-1-m.chetan.kumar@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Implements state machine to handle host & device sleep.

Signed-off-by: M Chetan Kumar <m.chetan.kumar@intel.com>
---
v5: no change.
v4: no change.
v3: Aligned ipc_ prefix for function name to be consistent across file.
v2:
* Removed space around the : for the bitfields.
* Moved pm module under static allocation
* Added memory barriers around atomic operations.
---
 drivers/net/wwan/iosm/iosm_ipc_pm.c | 333 ++++++++++++++++++++++++++++
 drivers/net/wwan/iosm/iosm_ipc_pm.h | 207 +++++++++++++++++
 2 files changed, 540 insertions(+)
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_pm.c
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_pm.h

diff --git a/drivers/net/wwan/iosm/iosm_ipc_pm.c b/drivers/net/wwan/iosm/iosm_ipc_pm.c
new file mode 100644
index 000000000000..413601c72dcd
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_pm.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020-21 Intel Corporation.
+ */
+
+#include "iosm_ipc_protocol.h"
+
+/* Timeout value in MS for the PM to wait for device to reach active state */
+#define IPC_PM_ACTIVE_TIMEOUT_MS (500)
+
+/* Note that here "active" has the value 1, as compared to the enums
+ * ipc_mem_host_pm_state or ipc_mem_dev_pm_state, where "active" is 0
+ */
+#define IPC_PM_SLEEP (0)
+#define CONSUME_STATE (0)
+#define IPC_PM_ACTIVE (1)
+
+void ipc_pm_signal_hpda_doorbell(struct iosm_pm *ipc_pm, u32 identifier,
+				 bool host_slp_check)
+{
+	if (host_slp_check && ipc_pm->host_pm_state != IPC_MEM_HOST_PM_ACTIVE &&
+	    ipc_pm->host_pm_state != IPC_MEM_HOST_PM_ACTIVE_WAIT) {
+		ipc_pm->pending_hpda_update = true;
+		dev_dbg(ipc_pm->dev,
+			"Pend HPDA update set. Host PM_State: %d identifier:%d",
+			ipc_pm->host_pm_state, identifier);
+		return;
+	}
+
+	if (!ipc_pm_trigger(ipc_pm, IPC_PM_UNIT_IRQ, true)) {
+		ipc_pm->pending_hpda_update = true;
+		dev_dbg(ipc_pm->dev, "Pending HPDA update set. identifier:%d",
+			identifier);
+		return;
+	}
+	ipc_pm->pending_hpda_update = false;
+
+	/* Trigger the irq towards CP */
+	ipc_cp_irq_hpda_update(ipc_pm->pcie, identifier);
+
+	ipc_pm_trigger(ipc_pm, IPC_PM_UNIT_IRQ, false);
+}
+
+/* Wake up the device if it is in low power mode. */
+static bool ipc_pm_link_activate(struct iosm_pm *ipc_pm)
+{
+	if (ipc_pm->cp_state == IPC_MEM_DEV_PM_ACTIVE)
+		return true;
+
+	if (ipc_pm->cp_state == IPC_MEM_DEV_PM_SLEEP) {
+		if (ipc_pm->ap_state == IPC_MEM_DEV_PM_SLEEP) {
+			/* Wake up the device. */
+			ipc_cp_irq_sleep_control(ipc_pm->pcie,
+						 IPC_MEM_DEV_PM_WAKEUP);
+			ipc_pm->ap_state = IPC_MEM_DEV_PM_ACTIVE_WAIT;
+
+			goto not_active;
+		}
+
+		if (ipc_pm->ap_state == IPC_MEM_DEV_PM_ACTIVE_WAIT)
+			goto not_active;
+
+		return true;
+	}
+
+not_active:
+	/* link is not ready */
+	return false;
+}
+
+bool ipc_pm_wait_for_device_active(struct iosm_pm *ipc_pm)
+{
+	bool ret_val = false;
+
+	if (ipc_pm->ap_state != IPC_MEM_DEV_PM_ACTIVE) {
+		/* Complete all memory stores before setting bit */
+		smp_mb__before_atomic();
+
+		/* Wait for IPC_PM_ACTIVE_TIMEOUT_MS for Device sleep state
+		 * machine to enter ACTIVE state.
+		 */
+		set_bit(0, &ipc_pm->host_sleep_pend);
+
+		/* Complete all memory stores after setting bit */
+		smp_mb__after_atomic();
+
+		if (!wait_for_completion_interruptible_timeout
+		   (&ipc_pm->host_sleep_complete,
+		    msecs_to_jiffies(IPC_PM_ACTIVE_TIMEOUT_MS))) {
+			dev_err(ipc_pm->dev,
+				"PM timeout. Expected State:%d. Actual: %d",
+				IPC_MEM_DEV_PM_ACTIVE, ipc_pm->ap_state);
+			goto  active_timeout;
+		}
+	}
+
+	ret_val = true;
+active_timeout:
+	/* Complete all memory stores before clearing bit */
+	smp_mb__before_atomic();
+
+	/* Reset the atomic variable in any case as device sleep
+	 * state machine change is no longer of interest.
+	 */
+	clear_bit(0, &ipc_pm->host_sleep_pend);
+
+	/* Complete all memory stores after clearing bit */
+	smp_mb__after_atomic();
+
+	return ret_val;
+}
+
+static void ipc_pm_on_link_sleep(struct iosm_pm *ipc_pm)
+{
+	/* pending sleep ack and all conditions are cleared
+	 * -> signal SLEEP__ACK to CP
+	 */
+	ipc_pm->cp_state = IPC_MEM_DEV_PM_SLEEP;
+	ipc_pm->ap_state = IPC_MEM_DEV_PM_SLEEP;
+
+	ipc_cp_irq_sleep_control(ipc_pm->pcie, IPC_MEM_DEV_PM_SLEEP);
+}
+
+static void ipc_pm_on_link_wake(struct iosm_pm *ipc_pm, bool ack)
+{
+	ipc_pm->ap_state = IPC_MEM_DEV_PM_ACTIVE;
+
+	if (ack) {
+		ipc_pm->cp_state = IPC_MEM_DEV_PM_ACTIVE;
+
+		ipc_cp_irq_sleep_control(ipc_pm->pcie, IPC_MEM_DEV_PM_ACTIVE);
+
+		/* check the consume state !!! */
+		if (test_bit(CONSUME_STATE, &ipc_pm->host_sleep_pend))
+			complete(&ipc_pm->host_sleep_complete);
+	}
+
+	/* Check for pending HPDA update.
+	 * Pending HP update could be because of sending message was
+	 * put on hold due to Device sleep state or due to TD update
+	 * which could be because of Device Sleep and Host Sleep
+	 * states.
+	 */
+	if (ipc_pm->pending_hpda_update &&
+	    ipc_pm->host_pm_state == IPC_MEM_HOST_PM_ACTIVE)
+		ipc_pm_signal_hpda_doorbell(ipc_pm, IPC_HP_PM_TRIGGER, true);
+}
+
+bool ipc_pm_trigger(struct iosm_pm *ipc_pm, enum ipc_pm_unit unit, bool active)
+{
+	union ipc_pm_cond old_cond;
+	union ipc_pm_cond new_cond;
+	bool link_active;
+
+	/* Save the current D3 state. */
+	new_cond = ipc_pm->pm_cond;
+	old_cond = ipc_pm->pm_cond;
+
+	/* Calculate the power state only in the runtime phase. */
+	switch (unit) {
+	case IPC_PM_UNIT_IRQ: /* CP irq */
+		new_cond.irq = active;
+		break;
+
+	case IPC_PM_UNIT_LINK: /* Device link state. */
+		new_cond.link = active;
+		break;
+
+	case IPC_PM_UNIT_HS: /* Host sleep trigger requires Link. */
+		new_cond.hs = active;
+		break;
+
+	default:
+		break;
+	}
+
+	/* Something changed ? */
+	if (old_cond.raw == new_cond.raw) {
+		/* Stay in the current PM state. */
+		link_active = old_cond.link == IPC_PM_ACTIVE;
+		goto ret;
+	}
+
+	ipc_pm->pm_cond = new_cond;
+
+	if (new_cond.link)
+		ipc_pm_on_link_wake(ipc_pm, unit == IPC_PM_UNIT_LINK);
+	else if (unit == IPC_PM_UNIT_LINK)
+		ipc_pm_on_link_sleep(ipc_pm);
+
+	if (old_cond.link == IPC_PM_SLEEP && new_cond.raw) {
+		link_active = ipc_pm_link_activate(ipc_pm);
+		goto ret;
+	}
+
+	link_active = old_cond.link == IPC_PM_ACTIVE;
+
+ret:
+	return link_active;
+}
+
+bool ipc_pm_prepare_host_sleep(struct iosm_pm *ipc_pm)
+{
+	/* suspend not allowed if host_pm_state is not IPC_MEM_HOST_PM_ACTIVE */
+	if (ipc_pm->host_pm_state != IPC_MEM_HOST_PM_ACTIVE) {
+		dev_err(ipc_pm->dev, "host_pm_state=%d\tExpected to be: %d",
+			ipc_pm->host_pm_state, IPC_MEM_HOST_PM_ACTIVE);
+		return false;
+	}
+
+	ipc_pm->host_pm_state = IPC_MEM_HOST_PM_SLEEP_WAIT_D3;
+
+	return true;
+}
+
+bool ipc_pm_prepare_host_active(struct iosm_pm *ipc_pm)
+{
+	if (ipc_pm->host_pm_state != IPC_MEM_HOST_PM_SLEEP) {
+		dev_err(ipc_pm->dev, "host_pm_state=%d\tExpected to be: %d",
+			ipc_pm->host_pm_state, IPC_MEM_HOST_PM_SLEEP);
+		return false;
+	}
+
+	/* Sending Sleep Exit message to CP. Update the state */
+	ipc_pm->host_pm_state = IPC_MEM_HOST_PM_ACTIVE_WAIT;
+
+	return true;
+}
+
+void ipc_pm_set_s2idle_sleep(struct iosm_pm *ipc_pm, bool sleep)
+{
+	if (sleep) {
+		ipc_pm->ap_state = IPC_MEM_DEV_PM_SLEEP;
+		ipc_pm->cp_state = IPC_MEM_DEV_PM_SLEEP;
+		ipc_pm->device_sleep_notification = IPC_MEM_DEV_PM_SLEEP;
+	} else {
+		ipc_pm->ap_state = IPC_MEM_DEV_PM_ACTIVE;
+		ipc_pm->cp_state = IPC_MEM_DEV_PM_ACTIVE;
+		ipc_pm->device_sleep_notification = IPC_MEM_DEV_PM_ACTIVE;
+		ipc_pm->pm_cond.link = IPC_PM_ACTIVE;
+	}
+}
+
+bool ipc_pm_dev_slp_notification(struct iosm_pm *ipc_pm, u32 cp_pm_req)
+{
+	if (cp_pm_req == ipc_pm->device_sleep_notification)
+		return false;
+
+	ipc_pm->device_sleep_notification = cp_pm_req;
+
+	/* Evaluate the PM request. */
+	switch (ipc_pm->cp_state) {
+	case IPC_MEM_DEV_PM_ACTIVE:
+		switch (cp_pm_req) {
+		case IPC_MEM_DEV_PM_ACTIVE:
+			break;
+
+		case IPC_MEM_DEV_PM_SLEEP:
+			/* Inform the PM that the device link can go down. */
+			ipc_pm_trigger(ipc_pm, IPC_PM_UNIT_LINK, false);
+			return true;
+
+		default:
+			dev_err(ipc_pm->dev,
+				"loc-pm=%d active: confused req-pm=%d",
+				ipc_pm->cp_state, cp_pm_req);
+			break;
+		}
+		break;
+
+	case IPC_MEM_DEV_PM_SLEEP:
+		switch (cp_pm_req) {
+		case IPC_MEM_DEV_PM_ACTIVE:
+			/* Inform the PM that the device link is active. */
+			ipc_pm_trigger(ipc_pm, IPC_PM_UNIT_LINK, true);
+			break;
+
+		case IPC_MEM_DEV_PM_SLEEP:
+			break;
+
+		default:
+			dev_err(ipc_pm->dev,
+				"loc-pm=%d sleep: confused req-pm=%d",
+				ipc_pm->cp_state, cp_pm_req);
+			break;
+		}
+		break;
+
+	default:
+		dev_err(ipc_pm->dev, "confused loc-pm=%d, req-pm=%d",
+			ipc_pm->cp_state, cp_pm_req);
+		break;
+	}
+
+	return false;
+}
+
+void ipc_pm_init(struct iosm_protocol *ipc_protocol)
+{
+	struct iosm_imem *ipc_imem = ipc_protocol->imem;
+	struct iosm_pm *ipc_pm = &ipc_protocol->pm;
+
+	ipc_pm->pcie = ipc_imem->pcie;
+	ipc_pm->dev = ipc_imem->dev;
+
+	ipc_pm->pm_cond.irq = IPC_PM_SLEEP;
+	ipc_pm->pm_cond.hs = IPC_PM_SLEEP;
+	ipc_pm->pm_cond.link = IPC_PM_ACTIVE;
+
+	ipc_pm->cp_state = IPC_MEM_DEV_PM_ACTIVE;
+	ipc_pm->ap_state = IPC_MEM_DEV_PM_ACTIVE;
+	ipc_pm->host_pm_state = IPC_MEM_HOST_PM_ACTIVE;
+
+	/* Create generic wait-for-completion handler for Host Sleep
+	 * and device sleep coordination.
+	 */
+	init_completion(&ipc_pm->host_sleep_complete);
+
+	/* Complete all memory stores before clearing bit */
+	smp_mb__before_atomic();
+
+	clear_bit(0, &ipc_pm->host_sleep_pend);
+
+	/* Complete all memory stores after clearing bit */
+	smp_mb__after_atomic();
+}
+
+void ipc_pm_deinit(struct iosm_protocol *proto)
+{
+	struct iosm_pm *ipc_pm = &proto->pm;
+
+	complete(&ipc_pm->host_sleep_complete);
+}
diff --git a/drivers/net/wwan/iosm/iosm_ipc_pm.h b/drivers/net/wwan/iosm/iosm_ipc_pm.h
new file mode 100644
index 000000000000..e7c00f388cb0
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_pm.h
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2020-21 Intel Corporation.
+ */
+
+#ifndef IOSM_IPC_PM_H
+#define IOSM_IPC_PM_H
+
+/* Trigger the doorbell interrupt on cp to change the PM sleep/active status */
+#define ipc_cp_irq_sleep_control(ipc_pcie, data)                               \
+	ipc_doorbell_fire(ipc_pcie, IPC_DOORBELL_IRQ_SLEEP, data)
+
+/* Trigger the doorbell interrupt on CP to do hpda update */
+#define ipc_cp_irq_hpda_update(ipc_pcie, data)                                 \
+	ipc_doorbell_fire(ipc_pcie, IPC_DOORBELL_IRQ_HPDA, 0xFF & (data))
+
+/**
+ * union ipc_pm_cond - Conditions for D3 and the sleep message to CP.
+ * @raw:	raw/combined value for faster check
+ * @irq:	IRQ towards CP
+ * @hs:		Host Sleep
+ * @link:	Device link state.
+ */
+union ipc_pm_cond {
+	unsigned int raw;
+
+	struct {
+		unsigned int irq:1,
+			     hs:1,
+			     link:1;
+	};
+};
+
+/**
+ * enum ipc_mem_host_pm_state - Possible states of the HOST SLEEP finite state
+ *				machine.
+ * @IPC_MEM_HOST_PM_ACTIVE:		   Host is active
+ * @IPC_MEM_HOST_PM_ACTIVE_WAIT:	   Intermediate state before going to
+ *					   active
+ * @IPC_MEM_HOST_PM_SLEEP_WAIT_IDLE:	   Intermediate state to wait for idle
+ *					   before going into sleep
+ * @IPC_MEM_HOST_PM_SLEEP_WAIT_D3:	   Intermediate state to wait for D3
+ *					   before going to sleep
+ * @IPC_MEM_HOST_PM_SLEEP:		   after this state the interface is not
+ *					   accessible host is in suspend to RAM
+ * @IPC_MEM_HOST_PM_SLEEP_WAIT_EXIT_SLEEP: Intermediate state before exiting
+ *					   sleep
+ */
+enum ipc_mem_host_pm_state {
+	IPC_MEM_HOST_PM_ACTIVE,
+	IPC_MEM_HOST_PM_ACTIVE_WAIT,
+	IPC_MEM_HOST_PM_SLEEP_WAIT_IDLE,
+	IPC_MEM_HOST_PM_SLEEP_WAIT_D3,
+	IPC_MEM_HOST_PM_SLEEP,
+	IPC_MEM_HOST_PM_SLEEP_WAIT_EXIT_SLEEP,
+};
+
+/**
+ * enum ipc_mem_dev_pm_state - Possible states of the DEVICE SLEEP finite state
+ *			       machine.
+ * @IPC_MEM_DEV_PM_ACTIVE:		IPC_MEM_DEV_PM_ACTIVE is the initial
+ *					power management state.
+ *					IRQ(struct ipc_mem_device_info:
+ *					device_sleep_notification)
+ *					and DOORBELL-IRQ-HPDA(data) values.
+ * @IPC_MEM_DEV_PM_SLEEP:		IPC_MEM_DEV_PM_SLEEP is PM state for
+ *					sleep.
+ * @IPC_MEM_DEV_PM_WAKEUP:		DOORBELL-IRQ-DEVICE_WAKE(data).
+ * @IPC_MEM_DEV_PM_HOST_SLEEP:		DOORBELL-IRQ-HOST_SLEEP(data).
+ * @IPC_MEM_DEV_PM_ACTIVE_WAIT:		Local intermediate states.
+ * @IPC_MEM_DEV_PM_FORCE_SLEEP:		DOORBELL-IRQ-FORCE_SLEEP.
+ * @IPC_MEM_DEV_PM_FORCE_ACTIVE:	DOORBELL-IRQ-FORCE_ACTIVE.
+ */
+enum ipc_mem_dev_pm_state {
+	IPC_MEM_DEV_PM_ACTIVE,
+	IPC_MEM_DEV_PM_SLEEP,
+	IPC_MEM_DEV_PM_WAKEUP,
+	IPC_MEM_DEV_PM_HOST_SLEEP,
+	IPC_MEM_DEV_PM_ACTIVE_WAIT,
+	IPC_MEM_DEV_PM_FORCE_SLEEP = 7,
+	IPC_MEM_DEV_PM_FORCE_ACTIVE,
+};
+
+/**
+ * struct iosm_pm - Power management instance
+ * @pcie:			Pointer to iosm_pcie structure
+ * @dev:			Pointer to device structure
+ * @host_pm_state:		PM states for host
+ * @host_sleep_pend:		Variable to indicate Host Sleep Pending
+ * @host_sleep_complete:	Generic wait-for-completion used in
+ *				case of Host Sleep
+ * @pm_cond:			Conditions for power management
+ * @ap_state:			Current power management state, the
+ *				initial state is IPC_MEM_DEV_PM_ACTIVE eq. 0.
+ * @cp_state:			PM State of CP
+ * @device_sleep_notification:	last handled device_sleep_notfication
+ * @pending_hpda_update:	is a HPDA update pending?
+ */
+struct iosm_pm {
+	struct iosm_pcie *pcie;
+	struct device *dev;
+	enum ipc_mem_host_pm_state host_pm_state;
+	unsigned long host_sleep_pend;
+	struct completion host_sleep_complete;
+	union ipc_pm_cond pm_cond;
+	enum ipc_mem_dev_pm_state ap_state;
+	enum ipc_mem_dev_pm_state cp_state;
+	u32 device_sleep_notification;
+	u8 pending_hpda_update:1;
+};
+
+/**
+ * enum ipc_pm_unit - Power management units.
+ * @IPC_PM_UNIT_IRQ:	IRQ towards CP
+ * @IPC_PM_UNIT_HS:	Host Sleep for converged protocol
+ * @IPC_PM_UNIT_LINK:	Link state controlled by CP.
+ */
+enum ipc_pm_unit {
+	IPC_PM_UNIT_IRQ,
+	IPC_PM_UNIT_HS,
+	IPC_PM_UNIT_LINK,
+};
+
+/**
+ * ipc_pm_init - Allocate power management component
+ * @ipc_protocol:	Pointer to iosm_protocol structure
+ */
+void ipc_pm_init(struct iosm_protocol *ipc_protocol);
+
+/**
+ * ipc_pm_deinit - Free power management component, invalidating its pointer.
+ * @ipc_protocol:	Pointer to iosm_protocol structure
+ */
+void ipc_pm_deinit(struct iosm_protocol *ipc_protocol);
+
+/**
+ * ipc_pm_dev_slp_notification - Handle a sleep notification message from the
+ *				 device. This can be called from interrupt state
+ *				 This function handles Host Sleep requests too
+ *				 if the Host Sleep protocol is register based.
+ * @ipc_pm:			Pointer to power management component
+ * @sleep_notification:		Actual notification from device
+ *
+ * Returns: true if dev sleep state has to be checked, false otherwise.
+ */
+bool ipc_pm_dev_slp_notification(struct iosm_pm *ipc_pm,
+				 u32 sleep_notification);
+
+/**
+ * ipc_pm_set_s2idle_sleep - Set PM variables to sleep/active
+ * @ipc_pm:	Pointer to power management component
+ * @sleep:	true to enter sleep/false to exit sleep
+ */
+void ipc_pm_set_s2idle_sleep(struct iosm_pm *ipc_pm, bool sleep);
+
+/**
+ * ipc_pm_prepare_host_sleep - Prepare the PM for sleep by entering
+ *			       IPC_MEM_HOST_PM_SLEEP_WAIT_D3 state.
+ * @ipc_pm:	Pointer to power management component
+ *
+ * Returns: true on success, false if the host was not active.
+ */
+bool ipc_pm_prepare_host_sleep(struct iosm_pm *ipc_pm);
+
+/**
+ * ipc_pm_prepare_host_active - Prepare the PM for wakeup by entering
+ *				IPC_MEM_HOST_PM_ACTIVE_WAIT state.
+ * @ipc_pm:	Pointer to power management component
+ *
+ * Returns: true on success, false if the host was not sleeping.
+ */
+bool ipc_pm_prepare_host_active(struct iosm_pm *ipc_pm);
+
+/**
+ * ipc_pm_wait_for_device_active - Wait upto IPC_PM_ACTIVE_TIMEOUT_MS ms
+ *				   for the device to reach active state
+ * @ipc_pm:	Pointer to power management component
+ *
+ * Returns: true if device is active, false on timeout
+ */
+bool ipc_pm_wait_for_device_active(struct iosm_pm *ipc_pm);
+
+/**
+ * ipc_pm_signal_hpda_doorbell - Wake up the device if it is in low power mode
+ *				 and trigger a head pointer update interrupt.
+ * @ipc_pm:		Pointer to power management component
+ * @identifier:		specifies what component triggered hpda update irq
+ * @host_slp_check:	if set to true then Host Sleep state machine check will
+ *			be performed. If Host Sleep state machine allows HP
+ *			update then only doorbell is triggered otherwise pending
+ *			flag will be set. If set to false then Host Sleep check
+ *			will not be performed. This is helpful for Host Sleep
+ *			negotiation through message ring.
+ */
+void ipc_pm_signal_hpda_doorbell(struct iosm_pm *ipc_pm, u32 identifier,
+				 bool host_slp_check);
+/**
+ * ipc_pm_trigger - Update power manager and wake up the link if needed
+ * @ipc_pm:	Pointer to power management component
+ * @unit:	Power management units
+ * @active:	Device link state
+ *
+ * Returns: true if link is unchanged or active, false otherwise
+ */
+bool ipc_pm_trigger(struct iosm_pm *ipc_pm, enum ipc_pm_unit unit, bool active);
+
+#endif
-- 
2.25.1

