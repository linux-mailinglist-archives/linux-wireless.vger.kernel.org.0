Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26794F8B5C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 02:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiDGWjl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 18:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiDGWjU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 18:39:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32016129E96;
        Thu,  7 Apr 2022 15:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649371035; x=1680907035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=EDtSOSod4MlBtV/lqhUPAE5l5Od4E5cFtq6YdfMt5u4=;
  b=L8t7VLc9WeGLK1GqFQ8LwUyihLtYXKjWGxAX02UWdruxmqTP+mff/IrY
   6Fucj1DMNhKY6vrnjncc76Q/nk4AUhVv1mLjrpOcKp8lFaJZzU9RUfGnj
   jEqzRbdX6r3k/Ecur8IT9bE3F9/9z2nMtd5ActNOzQCN7K/eZ8go34DaW
   2Vy9ut0SoXDyaBQJqLlfvKi1fYv1AKpBF3EuBSduksdHpGB65FWQdib9w
   7cxsad9Fpn1Nq4+QTsWDHz0kXzXC2u4wfPZqOqeVwoOXmCCMQngmCjnl1
   LfiX3+BMXIFExmueJgoKvK+RtMfDfiHAMfgYmAU6ldjIZlW+bc4Y78NwE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="243589608"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="243589608"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 15:37:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="659242905"
Received: from rmarti10-desk.jf.intel.com ([134.134.150.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 15:37:12 -0700
From:   Ricardo Martinez <ricardo.martinez@linux.intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.net, johannes@sipsolutions.net,
        ryazanov.s.a@gmail.com, loic.poulain@linaro.org,
        m.chetan.kumar@intel.com, chandrashekar.devegowda@intel.com,
        linuxwwan@intel.com, chiranjeevi.rapolu@linux.intel.com,
        haijun.liu@mediatek.com, amir.hanania@intel.com,
        andriy.shevchenko@linux.intel.com, dinesh.sharma@intel.com,
        eliot.lee@intel.com, ilpo.johannes.jarvinen@intel.com,
        moises.veleta@intel.com, pierre-louis.bossart@intel.com,
        muralidharan.sethuraman@intel.com, Soumya.Prakash.Mishra@intel.com,
        sreehari.kancharla@intel.com, madhusmita.sahu@intel.com,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>
Subject: [PATCH net-next v6 12/13] net: wwan: t7xx: Device deep sleep lock/unlock
Date:   Thu,  7 Apr 2022 15:36:28 -0700
Message-Id: <20220407223629.21487-13-ricardo.martinez@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407223629.21487-1-ricardo.martinez@linux.intel.com>
References: <20220407223629.21487-1-ricardo.martinez@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haijun Liu <haijun.liu@mediatek.com>

Introduce the mechanism to lock/unlock the device 'deep sleep' mode.
When the PCIe link state is L1.2 or L2, the host side still can keep
the device is in D0 state from the host side point of view. At the same
time, if the device's 'deep sleep' mode is unlocked, the device will
go to 'deep sleep' while it is still in D0 state on the host side.

Signed-off-by: Haijun Liu <haijun.liu@mediatek.com>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Co-developed-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
Signed-off-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c     | 12 +++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 14 +++-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c | 41 +++++++---
 drivers/net/wwan/t7xx/t7xx_mhccif.c        |  3 +
 drivers/net/wwan/t7xx/t7xx_pci.c           | 93 ++++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.h           | 10 +++
 6 files changed, 158 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index 3f3bb82a0543..e78995ecb63e 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -951,6 +951,7 @@ int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb
 	if (ret < 0 && ret != -EACCES)
 		return ret;
 
+	t7xx_pci_disable_sleep(md_ctrl->t7xx_dev);
 	queue = &md_ctrl->txq[qno];
 
 	spin_lock_irqsave(&md_ctrl->cldma_lock, flags);
@@ -972,6 +973,11 @@ int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb
 			queue->tx_next = list_next_entry_circular(tx_req, gpd_ring, entry);
 			spin_unlock_irqrestore(&queue->ring_lock, flags);
 
+			if (!t7xx_pci_sleep_disable_complete(md_ctrl->t7xx_dev)) {
+				ret = -ETIMEDOUT;
+				break;
+			}
+
 			/* Protect the access to the modem for queues operations (resume/start)
 			 * which access shared locations by all the queues.
 			 * cldma_lock is independent of ring_lock which is per queue.
@@ -984,6 +990,11 @@ int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb
 		}
 		spin_unlock_irqrestore(&queue->ring_lock, flags);
 
+		if (!t7xx_pci_sleep_disable_complete(md_ctrl->t7xx_dev)) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+
 		if (!t7xx_cldma_hw_queue_status(&md_ctrl->hw_info, qno, MTK_TX)) {
 			spin_lock_irqsave(&md_ctrl->cldma_lock, flags);
 			t7xx_cldma_hw_resume_queue(&md_ctrl->hw_info, qno, MTK_TX);
@@ -994,6 +1005,7 @@ int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb
 	} while (!ret);
 
 allow_sleep:
+	t7xx_pci_enable_sleep(md_ctrl->t7xx_dev);
 	pm_runtime_mark_last_busy(md_ctrl->dev);
 	pm_runtime_put_autosuspend(md_ctrl->dev);
 	return ret;
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 1b029cbc28ff..57ec49f9fc11 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -928,8 +928,11 @@ static void t7xx_dpmaif_rxq_work(struct work_struct *work)
 	if (ret < 0 && ret != -EACCES)
 		return;
 
-	t7xx_dpmaif_do_rx(dpmaif_ctrl, rxq);
+	t7xx_pci_disable_sleep(dpmaif_ctrl->t7xx_dev);
+	if (t7xx_pci_sleep_disable_complete(dpmaif_ctrl->t7xx_dev))
+		t7xx_dpmaif_do_rx(dpmaif_ctrl, rxq);
 
+	t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
 	pm_runtime_mark_last_busy(dpmaif_ctrl->dev);
 	pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
 	atomic_set(&rxq->rx_processing, 0);
@@ -1139,11 +1142,16 @@ static void t7xx_dpmaif_bat_release_work(struct work_struct *work)
 	if (ret < 0 && ret != -EACCES)
 		return;
 
+	t7xx_pci_disable_sleep(dpmaif_ctrl->t7xx_dev);
+
 	/* ALL RXQ use one BAT table, so choose DPF_RX_QNO_DFT */
 	rxq = &dpmaif_ctrl->rxq[DPF_RX_QNO_DFT];
-	t7xx_dpmaif_bat_release_and_add(rxq);
-	t7xx_dpmaif_frag_bat_release_and_add(rxq);
+	if (t7xx_pci_sleep_disable_complete(dpmaif_ctrl->t7xx_dev)) {
+		t7xx_dpmaif_bat_release_and_add(rxq);
+		t7xx_dpmaif_frag_bat_release_and_add(rxq);
+	}
 
+	t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
 	pm_runtime_mark_last_busy(dpmaif_ctrl->dev);
 	pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
index 026821a98c9d..e999d87e0483 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -166,20 +166,25 @@ static void t7xx_dpmaif_tx_done(struct work_struct *work)
 	if (ret < 0 && ret != -EACCES)
 		return;
 
-	hw_info = &dpmaif_ctrl->hw_info;
-	ret = t7xx_dpmaif_tx_release(dpmaif_ctrl, txq->index, txq->drb_size_cnt);
-	if (ret == -EAGAIN ||
-	    (t7xx_dpmaif_ul_clr_done(hw_info, txq->index) &&
-	     t7xx_dpmaif_drb_ring_not_empty(txq))) {
-		queue_work(dpmaif_ctrl->txq[txq->index].worker,
-			   &dpmaif_ctrl->txq[txq->index].dpmaif_tx_work);
-		/* Give the device time to enter the low power state */
-		t7xx_dpmaif_clr_ip_busy_sts(hw_info);
-	} else {
-		t7xx_dpmaif_clr_ip_busy_sts(hw_info);
-		t7xx_dpmaif_unmask_ulq_intr(hw_info, txq->index);
+	/* The device may be in low power state. Disable sleep if needed */
+	t7xx_pci_disable_sleep(dpmaif_ctrl->t7xx_dev);
+	if (t7xx_pci_sleep_disable_complete(dpmaif_ctrl->t7xx_dev)) {
+		hw_info = &dpmaif_ctrl->hw_info;
+		ret = t7xx_dpmaif_tx_release(dpmaif_ctrl, txq->index, txq->drb_size_cnt);
+		if (ret == -EAGAIN ||
+		    (t7xx_dpmaif_ul_clr_done(hw_info, txq->index) &&
+		     t7xx_dpmaif_drb_ring_not_empty(txq))) {
+			queue_work(dpmaif_ctrl->txq[txq->index].worker,
+				   &dpmaif_ctrl->txq[txq->index].dpmaif_tx_work);
+			/* Give the device time to enter the low power state */
+			t7xx_dpmaif_clr_ip_busy_sts(hw_info);
+		} else {
+			t7xx_dpmaif_clr_ip_busy_sts(hw_info);
+			t7xx_dpmaif_unmask_ulq_intr(hw_info, txq->index);
+		}
 	}
 
+	t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
 	pm_runtime_mark_last_busy(dpmaif_ctrl->dev);
 	pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
 }
@@ -402,6 +407,8 @@ static int t7xx_txq_burst_send_skb(struct dpmaif_tx_queue *txq)
 
 static void t7xx_do_tx_hw_push(struct dpmaif_ctrl *dpmaif_ctrl)
 {
+	bool wait_disable_sleep = true;
+
 	do {
 		struct dpmaif_tx_queue *txq;
 		int drb_send_cnt;
@@ -417,6 +424,14 @@ static void t7xx_do_tx_hw_push(struct dpmaif_ctrl *dpmaif_ctrl)
 			continue;
 		}
 
+		/* Wait for the PCIe resource to unlock */
+		if (wait_disable_sleep) {
+			if (!t7xx_pci_sleep_disable_complete(dpmaif_ctrl->t7xx_dev))
+				return;
+
+			wait_disable_sleep = false;
+		}
+
 		t7xx_dpmaif_ul_update_hw_drb_cnt(&dpmaif_ctrl->hw_info, txq->index,
 						 drb_send_cnt * DPMAIF_UL_DRB_SIZE_WORD);
 
@@ -447,7 +462,9 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 		if (ret < 0 && ret != -EACCES)
 			return ret;
 
+		t7xx_pci_disable_sleep(dpmaif_ctrl->t7xx_dev);
 		t7xx_do_tx_hw_push(dpmaif_ctrl);
+		t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
 		pm_runtime_mark_last_busy(dpmaif_ctrl->dev);
 		pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
 	}
diff --git a/drivers/net/wwan/t7xx/t7xx_mhccif.c b/drivers/net/wwan/t7xx/t7xx_mhccif.c
index 4bb452f5ccff..3ee18d46f8d2 100644
--- a/drivers/net/wwan/t7xx/t7xx_mhccif.c
+++ b/drivers/net/wwan/t7xx/t7xx_mhccif.c
@@ -59,6 +59,9 @@ static irqreturn_t t7xx_mhccif_isr_thread(int irq, void *data)
 
 	t7xx_mhccif_clear_interrupts(t7xx_dev, int_status);
 
+	if (int_status & D2H_INT_DS_LOCK_ACK)
+		complete_all(&t7xx_dev->sleep_lock_acquire);
+
 	if (int_status & D2H_INT_SR_ACK)
 		complete(&t7xx_dev->pm_sr_ack);
 
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 400c11f7b31e..ce4b22b61f68 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -33,6 +33,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeup.h>
+#include <linux/spinlock.h>
 
 #include "t7xx_mhccif.h"
 #include "t7xx_modem_ops.h"
@@ -44,6 +45,7 @@
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
 
+#define PM_SLEEP_DIS_TIMEOUT_MS		20
 #define PM_ACK_TIMEOUT_MS		1500
 #define PM_AUTOSUSPEND_MS		20000
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
@@ -56,6 +58,21 @@ enum t7xx_pm_state {
 	MTK_PM_RESUMED,
 };
 
+static void t7xx_dev_set_sleep_capability(struct t7xx_pci_dev *t7xx_dev, bool enable)
+{
+	void __iomem *ctrl_reg = IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_CTRL;
+	u32 value;
+
+	value = ioread32(ctrl_reg);
+
+	if (enable)
+		value &= ~T7XX_PCIE_MISC_MAC_SLEEP_DIS;
+	else
+		value |= T7XX_PCIE_MISC_MAC_SLEEP_DIS;
+
+	iowrite32(value, ctrl_reg);
+}
+
 static int t7xx_wait_pm_config(struct t7xx_pci_dev *t7xx_dev)
 {
 	int ret, val;
@@ -76,6 +93,8 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 
 	INIT_LIST_HEAD(&t7xx_dev->md_pm_entities);
 	mutex_init(&t7xx_dev->md_pm_entity_mtx);
+	spin_lock_init(&t7xx_dev->md_pm_lock);
+	init_completion(&t7xx_dev->sleep_lock_acquire);
 	init_completion(&t7xx_dev->pm_sr_ack);
 	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_INIT);
 
@@ -94,6 +113,7 @@ void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
 {
 	/* Enable the PCIe resource lock only after MD deep sleep is done */
 	t7xx_mhccif_mask_clr(t7xx_dev,
+			     D2H_INT_DS_LOCK_ACK |
 			     D2H_INT_SUSPEND_ACK |
 			     D2H_INT_RESUME_ACK |
 			     D2H_INT_SUSPEND_ACK_AP |
@@ -159,6 +179,79 @@ int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_en
 	return -ENXIO;
 }
 
+int t7xx_pci_sleep_disable_complete(struct t7xx_pci_dev *t7xx_dev)
+{
+	struct device *dev = &t7xx_dev->pdev->dev;
+	int ret;
+
+	ret = wait_for_completion_timeout(&t7xx_dev->sleep_lock_acquire,
+					  msecs_to_jiffies(PM_SLEEP_DIS_TIMEOUT_MS));
+	if (!ret)
+		dev_err_ratelimited(dev, "Resource wait complete timed out\n");
+
+	return ret;
+}
+
+/**
+ * t7xx_pci_disable_sleep() - Disable deep sleep capability.
+ * @t7xx_dev: MTK device.
+ *
+ * Lock the deep sleep capability, note that the device can still go into deep sleep
+ * state while device is in D0 state, from the host's point-of-view.
+ *
+ * If device is in deep sleep state, wake up the device and disable deep sleep capability.
+ */
+void t7xx_pci_disable_sleep(struct t7xx_pci_dev *t7xx_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&t7xx_dev->md_pm_lock, flags);
+	t7xx_dev->sleep_disable_count++;
+	if (atomic_read(&t7xx_dev->md_pm_state) < MTK_PM_RESUMED)
+		goto unlock_and_complete;
+
+	if (t7xx_dev->sleep_disable_count == 1) {
+		u32 status;
+
+		reinit_completion(&t7xx_dev->sleep_lock_acquire);
+		t7xx_dev_set_sleep_capability(t7xx_dev, false);
+
+		status = ioread32(IREG_BASE(t7xx_dev) + T7XX_PCIE_RESOURCE_STATUS);
+		if (status & T7XX_PCIE_RESOURCE_STS_MSK)
+			goto unlock_and_complete;
+
+		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DS_LOCK);
+	}
+	spin_unlock_irqrestore(&t7xx_dev->md_pm_lock, flags);
+	return;
+
+unlock_and_complete:
+	spin_unlock_irqrestore(&t7xx_dev->md_pm_lock, flags);
+	complete_all(&t7xx_dev->sleep_lock_acquire);
+}
+
+/**
+ * t7xx_pci_enable_sleep() - Enable deep sleep capability.
+ * @t7xx_dev: MTK device.
+ *
+ * After enabling deep sleep, device can enter into deep sleep state.
+ */
+void t7xx_pci_enable_sleep(struct t7xx_pci_dev *t7xx_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&t7xx_dev->md_pm_lock, flags);
+	t7xx_dev->sleep_disable_count--;
+	if (atomic_read(&t7xx_dev->md_pm_state) < MTK_PM_RESUMED) {
+		spin_unlock_irqrestore(&t7xx_dev->md_pm_lock, flags);
+		return;
+	}
+
+	if (t7xx_dev->sleep_disable_count == 0)
+		t7xx_dev_set_sleep_capability(t7xx_dev, true);
+	spin_unlock_irqrestore(&t7xx_dev->md_pm_lock, flags);
+}
+
 static int t7xx_send_pm_request(struct t7xx_pci_dev *t7xx_dev, u32 request)
 {
 	unsigned long wait_ret;
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index f51fc5a1301f..50b37056ce5a 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -21,6 +21,7 @@
 #include <linux/irqreturn.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include "t7xx_reg.h"
@@ -55,6 +56,9 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
  * @md_pm_entity_mtx: protects md_pm_entities list
  * @pm_sr_ack: ack from the device when went to sleep or woke up
  * @md_pm_state: state for resume/suspend
+ * @md_pm_lock: protects PCIe sleep lock
+ * @sleep_disable_count: PCIe L1.2 lock counter
+ * @sleep_lock_acquire: indicates that sleep has been disabled
  */
 struct t7xx_pci_dev {
 	t7xx_intr_callback	intr_handler[EXT_INT_NUM];
@@ -71,6 +75,9 @@ struct t7xx_pci_dev {
 	struct mutex		md_pm_entity_mtx;	/* Protects MD PM entities list */
 	struct completion	pm_sr_ack;
 	atomic_t		md_pm_state;
+	spinlock_t		md_pm_lock;		/* Protects PCI resource lock */
+	unsigned int		sleep_disable_count;
+	struct completion	sleep_lock_acquire;
 };
 
 enum t7xx_pm_id {
@@ -102,6 +109,9 @@ struct md_pm_entity {
 	void			*entity_param;
 };
 
+void t7xx_pci_disable_sleep(struct t7xx_pci_dev *t7xx_dev);
+void t7xx_pci_enable_sleep(struct t7xx_pci_dev *t7xx_dev);
+int t7xx_pci_sleep_disable_complete(struct t7xx_pci_dev *t7xx_dev);
 int t7xx_pci_pm_entity_register(struct t7xx_pci_dev *t7xx_dev, struct md_pm_entity *pm_entity);
 int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_entity *pm_entity);
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev);
-- 
2.17.1

