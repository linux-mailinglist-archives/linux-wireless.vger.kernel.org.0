Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE1D4C1E9F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 23:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbiBWWgA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 17:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244223AbiBWWfr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 17:35:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A45350B18;
        Wed, 23 Feb 2022 14:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645655715; x=1677191715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+QIkgYKmP4pxdgEotnticuBqZhmilARfItmXdNE2TaQ=;
  b=cMcgEzqmM85QOdNz8FzubecT5Rshl9n/tntyYtuTA8IVQijUN1lqHQoX
   NSEmmFWbvPuu9Ar68GWrUMrq7eob7cIiiP+p1hYSDuNv2Z3bb1EBNoD4r
   T1C8bLFIEHIB9Y64LabsnMoNeLDt6PJ6WNKRvcxgbCzo0jPRD6z0+WcSM
   svSgdKbocL3SFCkYCtKHbDJDUQYSTvPPE6c9N9jUdke81z1RPejVkmRmn
   z5De4TwFrwvZFP+1N8aIId8CnXtUAdYMLiudVWVuZ7zalSkOQBJ1Dp9/z
   vkggek36+u0gGGjyIOqGrbp7xRSAh2CoYVICD2gr4/i9swTBcS6Ankd22
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232718019"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="232718019"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:35:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="628252273"
Received: from rmarti10-desk.jf.intel.com ([134.134.150.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:35:13 -0800
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
Subject: [PATCH net-next v5 10/13] net: wwan: t7xx: Introduce power management
Date:   Wed, 23 Feb 2022 15:33:23 -0700
Message-Id: <20220223223326.28021-11-ricardo.martinez@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223223326.28021-1-ricardo.martinez@linux.intel.com>
References: <20220223223326.28021-1-ricardo.martinez@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haijun Liu <haijun.liu@mediatek.com>

Implements suspend, resumes, freeze, thaw, poweroff, and restore
`dev_pm_ops` callbacks.

From the host point of view, the t7xx driver is one entity. But, the
device has several modules that need to be addressed in different ways
during power management (PM) flows.
The driver uses the term 'PM entities' to refer to the 2 DPMA and
2 CLDMA HW blocks that need to be managed during PM flows.
When a dev_pm_ops function is called, the PM entities list is iterated
and the matching function is called for each entry in the list.

Signed-off-by: Haijun Liu <haijun.liu@mediatek.com>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Co-developed-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
Signed-off-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c     | 123 +++++-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h     |   1 +
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c    |  90 +++++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h    |   1 +
 drivers/net/wwan/t7xx/t7xx_mhccif.c        |  17 +
 drivers/net/wwan/t7xx/t7xx_pci.c           | 425 +++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.h           |  47 +++
 drivers/net/wwan/t7xx/t7xx_state_monitor.c |   2 +
 8 files changed, 705 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index b2b82e9dff09..114b67ebb270 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -1087,6 +1087,120 @@ int t7xx_cldma_alloc(enum cldma_id hif_id, struct t7xx_pci_dev *t7xx_dev)
 	return 0;
 }
 
+static void t7xx_cldma_resume_early(struct t7xx_pci_dev *t7xx_dev, void *entity_param)
+{
+	struct cldma_ctrl *md_ctrl = entity_param;
+	struct t7xx_cldma_hw *hw_info;
+	unsigned long flags;
+	int qno_t;
+
+	hw_info = &md_ctrl->hw_info;
+
+	spin_lock_irqsave(&md_ctrl->cldma_lock, flags);
+	t7xx_cldma_hw_restore(hw_info);
+	for (qno_t = 0; qno_t < CLDMA_TXQ_NUM; qno_t++) {
+		t7xx_cldma_hw_set_start_addr(hw_info, qno_t, md_ctrl->txq[qno_t].tx_next->gpd_addr,
+					     MTK_TX);
+		t7xx_cldma_hw_set_start_addr(hw_info, qno_t, md_ctrl->rxq[qno_t].tr_done->gpd_addr,
+					     MTK_RX);
+	}
+	t7xx_cldma_enable_irq(md_ctrl);
+	t7xx_cldma_hw_start_queue(hw_info, CLDMA_ALL_Q, MTK_RX);
+	md_ctrl->rxq_active |= TXRX_STATUS_BITMASK;
+	t7xx_cldma_hw_irq_en_eq(hw_info, CLDMA_ALL_Q, MTK_RX);
+	t7xx_cldma_hw_irq_en_txrx(hw_info, CLDMA_ALL_Q, MTK_RX);
+	spin_unlock_irqrestore(&md_ctrl->cldma_lock, flags);
+}
+
+static int t7xx_cldma_resume(struct t7xx_pci_dev *t7xx_dev, void *entity_param)
+{
+	struct cldma_ctrl *md_ctrl = entity_param;
+	unsigned long flags;
+
+	spin_lock_irqsave(&md_ctrl->cldma_lock, flags);
+	md_ctrl->txq_active |= TXRX_STATUS_BITMASK;
+	t7xx_cldma_hw_irq_en_txrx(&md_ctrl->hw_info, CLDMA_ALL_Q, MTK_TX);
+	t7xx_cldma_hw_irq_en_eq(&md_ctrl->hw_info, CLDMA_ALL_Q, MTK_TX);
+	spin_unlock_irqrestore(&md_ctrl->cldma_lock, flags);
+
+	if (md_ctrl->hif_id == CLDMA_ID_MD)
+		t7xx_mhccif_mask_clr(t7xx_dev, D2H_SW_INT_MASK);
+
+	return 0;
+}
+
+static void t7xx_cldma_suspend_late(struct t7xx_pci_dev *t7xx_dev, void *entity_param)
+{
+	struct cldma_ctrl *md_ctrl = entity_param;
+	struct t7xx_cldma_hw *hw_info;
+	unsigned long flags;
+
+	hw_info = &md_ctrl->hw_info;
+
+	spin_lock_irqsave(&md_ctrl->cldma_lock, flags);
+	t7xx_cldma_hw_irq_dis_eq(hw_info, CLDMA_ALL_Q, MTK_RX);
+	t7xx_cldma_hw_irq_dis_txrx(hw_info, CLDMA_ALL_Q, MTK_RX);
+	md_ctrl->rxq_active &= ~TXRX_STATUS_BITMASK;
+	t7xx_cldma_hw_stop_all_qs(hw_info, MTK_RX);
+	t7xx_cldma_clear_ip_busy(hw_info);
+	t7xx_cldma_disable_irq(md_ctrl);
+	spin_unlock_irqrestore(&md_ctrl->cldma_lock, flags);
+}
+
+static int t7xx_cldma_suspend(struct t7xx_pci_dev *t7xx_dev, void *entity_param)
+{
+	struct cldma_ctrl *md_ctrl = entity_param;
+	struct t7xx_cldma_hw *hw_info;
+	unsigned long flags;
+
+	if (md_ctrl->hif_id == CLDMA_ID_MD)
+		t7xx_mhccif_mask_set(t7xx_dev, D2H_SW_INT_MASK);
+
+	hw_info = &md_ctrl->hw_info;
+
+	spin_lock_irqsave(&md_ctrl->cldma_lock, flags);
+	t7xx_cldma_hw_irq_dis_eq(hw_info, CLDMA_ALL_Q, MTK_TX);
+	t7xx_cldma_hw_irq_dis_txrx(hw_info, CLDMA_ALL_Q, MTK_TX);
+	md_ctrl->txq_active &= ~TXRX_STATUS_BITMASK;
+	t7xx_cldma_hw_stop_all_qs(hw_info, MTK_TX);
+	md_ctrl->txq_started = 0;
+	spin_unlock_irqrestore(&md_ctrl->cldma_lock, flags);
+
+	return 0;
+}
+
+static int t7xx_cldma_pm_init(struct cldma_ctrl *md_ctrl)
+{
+	md_ctrl->pm_entity = kzalloc(sizeof(*md_ctrl->pm_entity), GFP_KERNEL);
+	if (!md_ctrl->pm_entity)
+		return -ENOMEM;
+
+	md_ctrl->pm_entity->entity_param = md_ctrl;
+
+	if (md_ctrl->hif_id == CLDMA_ID_MD)
+		md_ctrl->pm_entity->id = PM_ENTITY_ID_CTRL1;
+	else
+		md_ctrl->pm_entity->id = PM_ENTITY_ID_CTRL2;
+
+	md_ctrl->pm_entity->suspend = t7xx_cldma_suspend;
+	md_ctrl->pm_entity->suspend_late = t7xx_cldma_suspend_late;
+	md_ctrl->pm_entity->resume = t7xx_cldma_resume;
+	md_ctrl->pm_entity->resume_early = t7xx_cldma_resume_early;
+
+	return t7xx_pci_pm_entity_register(md_ctrl->t7xx_dev, md_ctrl->pm_entity);
+}
+
+static int t7xx_cldma_pm_uninit(struct cldma_ctrl *md_ctrl)
+{
+	if (!md_ctrl->pm_entity)
+		return -EINVAL;
+
+	t7xx_pci_pm_entity_unregister(md_ctrl->t7xx_dev, md_ctrl->pm_entity);
+	kfree(md_ctrl->pm_entity);
+	md_ctrl->pm_entity = NULL;
+	return 0;
+}
+
 void t7xx_cldma_hif_hw_init(struct cldma_ctrl *md_ctrl)
 {
 	struct t7xx_cldma_hw *hw_info = &md_ctrl->hw_info;
@@ -1137,6 +1251,7 @@ static void t7xx_cldma_destroy_wqs(struct cldma_ctrl *md_ctrl)
  * t7xx_cldma_init() - Initialize CLDMA.
  * @md_ctrl: CLDMA context structure.
  *
+ * Allocate and initialize device power management entity.
  * Initialize HIF TX/RX queue structure.
  * Register CLDMA callback ISR with PCIe driver.
  *
@@ -1147,12 +1262,16 @@ static void t7xx_cldma_destroy_wqs(struct cldma_ctrl *md_ctrl)
 int t7xx_cldma_init(struct cldma_ctrl *md_ctrl)
 {
 	struct t7xx_cldma_hw *hw_info = &md_ctrl->hw_info;
-	int i;
+	int ret, i;
 
 	md_ctrl->txq_active = 0;
 	md_ctrl->rxq_active = 0;
 	md_ctrl->is_late_init = false;
 
+	ret = t7xx_cldma_pm_init(md_ctrl);
+	if (ret)
+		return ret;
+
 	spin_lock_init(&md_ctrl->cldma_lock);
 
 	for (i = 0; i < CLDMA_TXQ_NUM; i++) {
@@ -1187,6 +1306,7 @@ int t7xx_cldma_init(struct cldma_ctrl *md_ctrl)
 
 err_workqueue:
 	t7xx_cldma_destroy_wqs(md_ctrl);
+	t7xx_cldma_pm_uninit(md_ctrl);
 	return -ENOMEM;
 }
 
@@ -1201,4 +1321,5 @@ void t7xx_cldma_exit(struct cldma_ctrl *md_ctrl)
 	t7xx_cldma_stop(md_ctrl);
 	t7xx_cldma_late_release(md_ctrl);
 	t7xx_cldma_destroy_wqs(md_ctrl);
+	t7xx_cldma_pm_uninit(md_ctrl);
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
index 2970b6312e99..38210fa9cc19 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
@@ -87,6 +87,7 @@ struct cldma_ctrl {
 	struct dma_pool *gpd_dmapool;
 	struct cldma_ring tx_ring[CLDMA_TXQ_NUM];
 	struct cldma_ring rx_ring[CLDMA_RXQ_NUM];
+	struct md_pm_entity *pm_entity;
 	struct t7xx_cldma_hw hw_info;
 	bool is_late_init;
 	int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb);
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
index b0b459f060ce..76f5f802083a 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
@@ -398,6 +398,90 @@ static int t7xx_dpmaif_stop(struct dpmaif_ctrl *dpmaif_ctrl)
 	return 0;
 }
 
+static int t7xx_dpmaif_suspend(struct t7xx_pci_dev *t7xx_dev, void *param)
+{
+	struct dpmaif_ctrl *dpmaif_ctrl = param;
+
+	t7xx_dpmaif_tx_stop(dpmaif_ctrl);
+	t7xx_dpmaif_hw_stop_all_txq(&dpmaif_ctrl->hw_info);
+	t7xx_dpmaif_hw_stop_all_rxq(&dpmaif_ctrl->hw_info);
+	t7xx_dpmaif_disable_irq(dpmaif_ctrl);
+	t7xx_dpmaif_rx_stop(dpmaif_ctrl);
+	return 0;
+}
+
+static void t7xx_dpmaif_unmask_dlq_intr(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	int qno;
+
+	for (qno = 0; qno < DPMAIF_RXQ_NUM; qno++)
+		t7xx_dpmaif_dlq_unmask_rx_done(&dpmaif_ctrl->hw_info, qno);
+}
+
+static void t7xx_dpmaif_start_txrx_qs(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct dpmaif_rx_queue *rxq;
+	struct dpmaif_tx_queue *txq;
+	unsigned int que_cnt;
+
+	for (que_cnt = 0; que_cnt < DPMAIF_TXQ_NUM; que_cnt++) {
+		txq = &dpmaif_ctrl->txq[que_cnt];
+		txq->que_started = true;
+	}
+
+	for (que_cnt = 0; que_cnt < DPMAIF_RXQ_NUM; que_cnt++) {
+		rxq = &dpmaif_ctrl->rxq[que_cnt];
+		rxq->que_started = true;
+	}
+}
+
+static int t7xx_dpmaif_resume(struct t7xx_pci_dev *t7xx_dev, void *param)
+{
+	struct dpmaif_ctrl *dpmaif_ctrl = param;
+
+	if (!dpmaif_ctrl)
+		return 0;
+
+	t7xx_dpmaif_start_txrx_qs(dpmaif_ctrl);
+	t7xx_dpmaif_enable_irq(dpmaif_ctrl);
+	t7xx_dpmaif_unmask_dlq_intr(dpmaif_ctrl);
+	t7xx_dpmaif_start_hw(&dpmaif_ctrl->hw_info);
+	wake_up(&dpmaif_ctrl->tx_wq);
+	return 0;
+}
+
+static int t7xx_dpmaif_pm_entity_init(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct md_pm_entity *dpmaif_pm_entity = &dpmaif_ctrl->dpmaif_pm_entity;
+	int ret;
+
+	INIT_LIST_HEAD(&dpmaif_pm_entity->entity);
+	dpmaif_pm_entity->suspend = &t7xx_dpmaif_suspend;
+	dpmaif_pm_entity->suspend_late = NULL;
+	dpmaif_pm_entity->resume_early = NULL;
+	dpmaif_pm_entity->resume = &t7xx_dpmaif_resume;
+	dpmaif_pm_entity->id = PM_ENTITY_ID_DATA;
+	dpmaif_pm_entity->entity_param = dpmaif_ctrl;
+
+	ret = t7xx_pci_pm_entity_register(dpmaif_ctrl->t7xx_dev, dpmaif_pm_entity);
+	if (ret)
+		dev_err(dpmaif_ctrl->dev, "dpmaif register pm_entity fail\n");
+
+	return ret;
+}
+
+static int t7xx_dpmaif_pm_entity_release(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct md_pm_entity *dpmaif_pm_entity = &dpmaif_ctrl->dpmaif_pm_entity;
+	int ret;
+
+	ret = t7xx_pci_pm_entity_unregister(dpmaif_ctrl->t7xx_dev, dpmaif_pm_entity);
+	if (ret < 0)
+		dev_err(dpmaif_ctrl->dev, "dpmaif register pm_entity fail\n");
+
+	return ret;
+}
+
 int t7xx_dpmaif_md_state_callback(struct dpmaif_ctrl *dpmaif_ctrl, unsigned char state)
 {
 	int ret = 0;
@@ -461,11 +545,16 @@ struct dpmaif_ctrl *t7xx_dpmaif_hif_init(struct t7xx_pci_dev *t7xx_dev,
 	dpmaif_ctrl->hw_info.pcie_base = t7xx_dev->base_addr.pcie_ext_reg_base -
 					 t7xx_dev->base_addr.pcie_dev_reg_trsl_addr;
 
+	ret = t7xx_dpmaif_pm_entity_init(dpmaif_ctrl);
+	if (ret)
+		return NULL;
+
 	t7xx_dpmaif_register_pcie_irq(dpmaif_ctrl);
 	t7xx_dpmaif_disable_irq(dpmaif_ctrl);
 
 	ret = t7xx_dpmaif_rxtx_sw_allocs(dpmaif_ctrl);
 	if (ret) {
+		t7xx_dpmaif_pm_entity_release(dpmaif_ctrl);
 		dev_err(dev, "Failed to allocate RX/TX SW resources: %d\n", ret);
 		return NULL;
 	}
@@ -478,6 +567,7 @@ void t7xx_dpmaif_hif_exit(struct dpmaif_ctrl *dpmaif_ctrl)
 {
 	if (dpmaif_ctrl->dpmaif_sw_init_done) {
 		t7xx_dpmaif_stop(dpmaif_ctrl);
+		t7xx_dpmaif_pm_entity_release(dpmaif_ctrl);
 		t7xx_dpmaif_sw_release(dpmaif_ctrl);
 		dpmaif_ctrl->dpmaif_sw_init_done = false;
 	}
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h
index a133c3dfac94..f86785ae2481 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h
@@ -179,6 +179,7 @@ struct dpmaif_callbacks {
 struct dpmaif_ctrl {
 	struct device			*dev;
 	struct t7xx_pci_dev		*t7xx_dev;
+	struct md_pm_entity		dpmaif_pm_entity;
 	enum dpmaif_state		state;
 	bool				dpmaif_sw_init_done;
 	struct dpmaif_hw_info		hw_info;
diff --git a/drivers/net/wwan/t7xx/t7xx_mhccif.c b/drivers/net/wwan/t7xx/t7xx_mhccif.c
index 0ed12f8638fb..60c265c24a8b 100644
--- a/drivers/net/wwan/t7xx/t7xx_mhccif.c
+++ b/drivers/net/wwan/t7xx/t7xx_mhccif.c
@@ -24,6 +24,11 @@
 #include "t7xx_pcie_mac.h"
 #include "t7xx_reg.h"
 
+#define D2H_INT_SR_ACK		(D2H_INT_SUSPEND_ACK |		\
+				 D2H_INT_RESUME_ACK |		\
+				 D2H_INT_SUSPEND_ACK_AP |	\
+				 D2H_INT_RESUME_ACK_AP)
+
 static void t7xx_mhccif_clear_interrupts(struct t7xx_pci_dev *t7xx_dev, u32 mask)
 {
 	void __iomem *mhccif_pbase = t7xx_dev->base_addr.mhccif_rc_base;
@@ -53,6 +58,18 @@ static irqreturn_t t7xx_mhccif_isr_thread(int irq, void *data)
 	}
 
 	t7xx_mhccif_clear_interrupts(t7xx_dev, int_status);
+
+	if (int_status & D2H_INT_SR_ACK)
+		complete(&t7xx_dev->pm_sr_ack);
+
+	iowrite32(L1_DISABLE_BIT(1), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_CLR_0);
+
+	int_status = t7xx_mhccif_read_sw_int_sts(t7xx_dev);
+	if (!int_status) {
+		val = L1_1_DISABLE_BIT(1) | L1_2_DISABLE_BIT(1);
+		iowrite32(val, IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_CLR_0);
+	}
+
 	t7xx_pcie_mac_set_int(t7xx_dev, MHCCIF_INT);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 1c34919ae5d6..880d9448d662 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -18,23 +18,442 @@
 
 #include <linux/atomic.h>
 #include <linux/bits.h>
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
+#include <linux/pm_wakeup.h>
 
 #include "t7xx_mhccif.h"
 #include "t7xx_modem_ops.h"
 #include "t7xx_pci.h"
 #include "t7xx_pcie_mac.h"
 #include "t7xx_reg.h"
+#include "t7xx_state_monitor.h"
 
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
 
+#define PM_ACK_TIMEOUT_MS		1500
+#define PM_RESOURCE_POLL_TIMEOUT_US	10000
+#define PM_RESOURCE_POLL_STEP_US	100
+
+enum t7xx_pm_state {
+	MTK_PM_EXCEPTION,
+	MTK_PM_INIT,		/* Device initialized, but handshake not completed */
+	MTK_PM_SUSPENDED,
+	MTK_PM_RESUMED,
+};
+
+static int t7xx_wait_pm_config(struct t7xx_pci_dev *t7xx_dev)
+{
+	int ret, val;
+
+	ret = read_poll_timeout(ioread32, val,
+				(val & T7XX_PCIE_RESOURCE_STS_MSK) == T7XX_PCIE_RESOURCE_STS_MSK,
+				PM_RESOURCE_POLL_STEP_US, PM_RESOURCE_POLL_TIMEOUT_US, true,
+				IREG_BASE(t7xx_dev) + T7XX_PCIE_RESOURCE_STATUS);
+	if (ret == -ETIMEDOUT)
+		dev_err(&t7xx_dev->pdev->dev, "PM configuration timed out\n");
+
+	return ret;
+}
+
+static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
+{
+	struct pci_dev *pdev = t7xx_dev->pdev;
+
+	INIT_LIST_HEAD(&t7xx_dev->md_pm_entities);
+
+	mutex_init(&t7xx_dev->md_pm_entity_mtx);
+
+	init_completion(&t7xx_dev->pm_sr_ack);
+
+	device_init_wakeup(&pdev->dev, true);
+
+	dev_pm_set_driver_flags(&pdev->dev, pdev->dev.power.driver_flags |
+				DPM_FLAG_NO_DIRECT_COMPLETE);
+
+	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_INIT);
+
+	iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_SET_0);
+
+	return t7xx_wait_pm_config(t7xx_dev);
+}
+
+void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
+{
+	/* Enable the PCIe resource lock only after MD deep sleep is done */
+	t7xx_mhccif_mask_clr(t7xx_dev,
+			     D2H_INT_SUSPEND_ACK |
+			     D2H_INT_RESUME_ACK |
+			     D2H_INT_SUSPEND_ACK_AP |
+			     D2H_INT_RESUME_ACK_AP);
+	iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_CLR_0);
+	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
+}
+
+static int t7xx_pci_pm_reinit(struct t7xx_pci_dev *t7xx_dev)
+{
+	/* The device is kept in FSM re-init flow
+	 * so just roll back PM setting to the init setting.
+	 */
+	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_INIT);
+	iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_SET_0);
+	return t7xx_wait_pm_config(t7xx_dev);
+}
+
+void t7xx_pci_pm_exp_detected(struct t7xx_pci_dev *t7xx_dev)
+{
+	iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_SET_0);
+	t7xx_wait_pm_config(t7xx_dev);
+	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_EXCEPTION);
+}
+
+int t7xx_pci_pm_entity_register(struct t7xx_pci_dev *t7xx_dev, struct md_pm_entity *pm_entity)
+{
+	struct md_pm_entity *entity;
+
+	mutex_lock(&t7xx_dev->md_pm_entity_mtx);
+	list_for_each_entry(entity, &t7xx_dev->md_pm_entities, entity) {
+		if (entity->id == pm_entity->id) {
+			mutex_unlock(&t7xx_dev->md_pm_entity_mtx);
+			return -EEXIST;
+		}
+	}
+
+	list_add_tail(&pm_entity->entity, &t7xx_dev->md_pm_entities);
+	mutex_unlock(&t7xx_dev->md_pm_entity_mtx);
+	return 0;
+}
+
+int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_entity *pm_entity)
+{
+	struct md_pm_entity *entity, *tmp_entity;
+
+	mutex_lock(&t7xx_dev->md_pm_entity_mtx);
+	list_for_each_entry_safe(entity, tmp_entity, &t7xx_dev->md_pm_entities, entity) {
+		if (entity->id == pm_entity->id) {
+			list_del(&pm_entity->entity);
+			mutex_unlock(&t7xx_dev->md_pm_entity_mtx);
+			return 0;
+		}
+	}
+
+	mutex_unlock(&t7xx_dev->md_pm_entity_mtx);
+
+	return -ENXIO;
+}
+
+static int t7xx_send_pm_request(struct t7xx_pci_dev *t7xx_dev, u32 request)
+{
+	unsigned long wait_ret;
+
+	reinit_completion(&t7xx_dev->pm_sr_ack);
+	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, request);
+	wait_ret = wait_for_completion_timeout(&t7xx_dev->pm_sr_ack,
+					       msecs_to_jiffies(PM_ACK_TIMEOUT_MS));
+	if (!wait_ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int __t7xx_pci_pm_suspend(struct pci_dev *pdev)
+{
+	enum t7xx_pm_id entity_id = PM_ENTITY_ID_INVALID;
+	struct t7xx_pci_dev *t7xx_dev;
+	struct md_pm_entity *entity;
+	int ret;
+
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (atomic_read(&t7xx_dev->md_pm_state) <= MTK_PM_INIT) {
+		dev_err(&pdev->dev, "[PM] Exiting suspend, modem in invalid state\n");
+		return -EFAULT;
+	}
+
+	iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_SET_0);
+	ret = t7xx_wait_pm_config(t7xx_dev);
+	if (ret) {
+		iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_CLR_0);
+		return ret;
+	}
+
+	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_SUSPENDED);
+	t7xx_pcie_mac_clear_int(t7xx_dev, SAP_RGU_INT);
+	t7xx_dev->rgu_pci_irq_en = false;
+
+	list_for_each_entry(entity, &t7xx_dev->md_pm_entities, entity) {
+		if (!entity->suspend)
+			continue;
+
+		ret = entity->suspend(t7xx_dev, entity->entity_param);
+		if (ret) {
+			entity_id = entity->id;
+			dev_err(&pdev->dev, "[PM] Suspend error: %d, id: %d\n", ret, entity_id);
+			goto abort_suspend;
+		}
+	}
+
+	ret = t7xx_send_pm_request(t7xx_dev, H2D_CH_SUSPEND_REQ);
+	if (ret) {
+		dev_err(&pdev->dev, "[PM] MD suspend error: %d\n", ret);
+		goto abort_suspend;
+	}
+
+	ret = t7xx_send_pm_request(t7xx_dev, H2D_CH_SUSPEND_REQ_AP);
+	if (ret) {
+		t7xx_send_pm_request(t7xx_dev, H2D_CH_RESUME_REQ);
+		dev_err(&pdev->dev, "[PM] SAP suspend error: %d\n", ret);
+		goto abort_suspend;
+	}
+
+	list_for_each_entry(entity, &t7xx_dev->md_pm_entities, entity) {
+		if (entity->suspend_late)
+			entity->suspend_late(t7xx_dev, entity->entity_param);
+	}
+
+	iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_CLR_0);
+	return 0;
+
+abort_suspend:
+	list_for_each_entry(entity, &t7xx_dev->md_pm_entities, entity) {
+		if (entity_id == entity->id)
+			break;
+
+		if (entity->resume)
+			entity->resume(t7xx_dev, entity->entity_param);
+	}
+
+	iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_CLR_0);
+	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
+	t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
+	return ret;
+}
+
+static void t7xx_pcie_interrupt_reinit(struct t7xx_pci_dev *t7xx_dev)
+{
+	t7xx_pcie_set_mac_msix_cfg(t7xx_dev, EXT_INT_NUM);
+
+	/* Disable interrupt first and let the IPs enable them */
+	iowrite32(MSIX_MSK_SET_ALL, IREG_BASE(t7xx_dev) + IMASK_HOST_MSIX_CLR_GRP0_0);
+
+	/* Device disables PCIe interrupts during resume and
+	 * following function will re-enable PCIe interrupts.
+	 */
+	t7xx_pcie_mac_interrupts_en(t7xx_dev);
+	t7xx_pcie_mac_set_int(t7xx_dev, MHCCIF_INT);
+}
+
+static int t7xx_pcie_reinit(struct t7xx_pci_dev *t7xx_dev, bool is_d3)
+{
+	int ret;
+
+	ret = pcim_enable_device(t7xx_dev->pdev);
+	if (ret)
+		return ret;
+
+	t7xx_pcie_mac_atr_init(t7xx_dev);
+	t7xx_pcie_interrupt_reinit(t7xx_dev);
+
+	if (is_d3) {
+		t7xx_mhccif_init(t7xx_dev);
+		return t7xx_pci_pm_reinit(t7xx_dev);
+	}
+
+	return 0;
+}
+
+static int t7xx_send_fsm_command(struct t7xx_pci_dev *t7xx_dev, u32 event)
+{
+	struct t7xx_fsm_ctl *fsm_ctl = t7xx_dev->md->fsm_ctl;
+	struct device *dev = &t7xx_dev->pdev->dev;
+	int ret = -EINVAL;
+
+	switch (event) {
+	case FSM_CMD_STOP:
+		ret = t7xx_fsm_append_cmd(fsm_ctl, FSM_CMD_STOP, FSM_CMD_FLAG_WAIT_FOR_COMPLETION);
+		break;
+
+	case FSM_CMD_START:
+		t7xx_pcie_mac_clear_int(t7xx_dev, SAP_RGU_INT);
+		t7xx_pcie_mac_clear_int_status(t7xx_dev, SAP_RGU_INT);
+		t7xx_dev->rgu_pci_irq_en = true;
+		t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
+		ret = t7xx_fsm_append_cmd(fsm_ctl, FSM_CMD_START, 0);
+		break;
+
+	default:
+		break;
+	}
+
+	if (ret)
+		dev_err(dev, "Failure handling FSM command %u, %d\n", event, ret);
+
+	return ret;
+}
+
+static int __t7xx_pci_pm_resume(struct pci_dev *pdev, bool state_check)
+{
+	struct t7xx_pci_dev *t7xx_dev;
+	struct md_pm_entity *entity;
+	u32 prev_state;
+	int ret = 0;
+
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (atomic_read(&t7xx_dev->md_pm_state) <= MTK_PM_INIT) {
+		iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_CLR_0);
+		return 0;
+	}
+
+	t7xx_pcie_mac_interrupts_en(t7xx_dev);
+	prev_state = ioread32(IREG_BASE(t7xx_dev) + T7XX_PCIE_PM_RESUME_STATE);
+
+	if (state_check) {
+		/* For D3/L3 resume, the device could boot so quickly that the
+		 * initial value of the dummy register might be overwritten.
+		 * Identify new boots if the ATR source address register is not initialized.
+		 */
+		u32 atr_reg_val = ioread32(IREG_BASE(t7xx_dev) +
+					   ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR);
+		if (prev_state == PM_RESUME_REG_STATE_L3 ||
+		    (prev_state == PM_RESUME_REG_STATE_INIT &&
+		     atr_reg_val == ATR_SRC_ADDR_INVALID)) {
+			ret = t7xx_send_fsm_command(t7xx_dev, FSM_CMD_STOP);
+			if (ret)
+				return ret;
+
+			ret = t7xx_pcie_reinit(t7xx_dev, true);
+			if (ret)
+				return ret;
+
+			t7xx_clear_rgu_irq(t7xx_dev);
+			return t7xx_send_fsm_command(t7xx_dev, FSM_CMD_START);
+		}
+
+		if (prev_state == PM_RESUME_REG_STATE_EXP ||
+		    prev_state == PM_RESUME_REG_STATE_L2_EXP) {
+			if (prev_state == PM_RESUME_REG_STATE_L2_EXP) {
+				ret = t7xx_pcie_reinit(t7xx_dev, false);
+				if (ret)
+					return ret;
+			}
+
+			atomic_set(&t7xx_dev->md_pm_state, MTK_PM_SUSPENDED);
+			t7xx_dev->rgu_pci_irq_en = true;
+			t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
+
+			t7xx_mhccif_mask_clr(t7xx_dev,
+					     D2H_INT_EXCEPTION_INIT |
+					     D2H_INT_EXCEPTION_INIT_DONE |
+					     D2H_INT_EXCEPTION_CLEARQ_DONE |
+					     D2H_INT_EXCEPTION_ALLQ_RESET |
+					     D2H_INT_PORT_ENUM);
+
+			return ret;
+		}
+
+		if (prev_state == PM_RESUME_REG_STATE_L2) {
+			ret = t7xx_pcie_reinit(t7xx_dev, false);
+			if (ret)
+				return ret;
+
+		} else if (prev_state != PM_RESUME_REG_STATE_L1 &&
+			   prev_state != PM_RESUME_REG_STATE_INIT) {
+			ret = t7xx_send_fsm_command(t7xx_dev, FSM_CMD_STOP);
+			if (ret)
+				return ret;
+
+			t7xx_clear_rgu_irq(t7xx_dev);
+			atomic_set(&t7xx_dev->md_pm_state, MTK_PM_SUSPENDED);
+			return 0;
+		}
+	}
+
+	iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_SET_0);
+	t7xx_wait_pm_config(t7xx_dev);
+
+	list_for_each_entry(entity, &t7xx_dev->md_pm_entities, entity) {
+		if (entity->resume_early)
+			entity->resume_early(t7xx_dev, entity->entity_param);
+	}
+
+	ret = t7xx_send_pm_request(t7xx_dev, H2D_CH_RESUME_REQ);
+	if (ret)
+		dev_err(&pdev->dev, "[PM] MD resume error: %d\n", ret);
+
+	ret = t7xx_send_pm_request(t7xx_dev, H2D_CH_RESUME_REQ_AP);
+	if (ret)
+		dev_err(&pdev->dev, "[PM] SAP resume error: %d\n", ret);
+
+	list_for_each_entry(entity, &t7xx_dev->md_pm_entities, entity) {
+		if (entity->resume) {
+			ret = entity->resume(t7xx_dev, entity->entity_param);
+			if (ret)
+				dev_err(&pdev->dev, "[PM] Resume entry ID: %d error: %d\n",
+					entity->id, ret);
+		}
+	}
+
+	t7xx_dev->rgu_pci_irq_en = true;
+	t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
+	iowrite32(L1_DISABLE_BIT(0), IREG_BASE(t7xx_dev) + DIS_ASPM_LOWPWR_CLR_0);
+	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
+
+	return ret;
+}
+
+static int t7xx_pci_pm_resume_noirq(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct t7xx_pci_dev *t7xx_dev;
+
+	t7xx_dev = pci_get_drvdata(pdev);
+	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
+
+	return 0;
+}
+
+static void t7xx_pci_shutdown(struct pci_dev *pdev)
+{
+	__t7xx_pci_pm_suspend(pdev);
+}
+
+static int t7xx_pci_pm_suspend(struct device *dev)
+{
+	return __t7xx_pci_pm_suspend(to_pci_dev(dev));
+}
+
+static int t7xx_pci_pm_resume(struct device *dev)
+{
+	return __t7xx_pci_pm_resume(to_pci_dev(dev), true);
+}
+
+static int t7xx_pci_pm_thaw(struct device *dev)
+{
+	return __t7xx_pci_pm_resume(to_pci_dev(dev), false);
+}
+
+static const struct dev_pm_ops t7xx_pci_pm_ops = {
+	.suspend = t7xx_pci_pm_suspend,
+	.resume = t7xx_pci_pm_resume,
+	.resume_noirq = t7xx_pci_pm_resume_noirq,
+	.freeze = t7xx_pci_pm_suspend,
+	.thaw = t7xx_pci_pm_thaw,
+	.poweroff = t7xx_pci_pm_suspend,
+	.restore = t7xx_pci_pm_resume,
+	.restore_noirq = t7xx_pci_pm_resume_noirq,
+};
+
 static int t7xx_request_irq(struct pci_dev *pdev)
 {
 	struct t7xx_pci_dev *t7xx_dev;
@@ -165,6 +584,10 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	IREG_BASE(t7xx_dev) = pcim_iomap_table(pdev)[T7XX_PCI_IREG_BASE];
 	t7xx_dev->base_addr.pcie_ext_reg_base = pcim_iomap_table(pdev)[T7XX_PCI_EREG_BASE];
 
+	ret = t7xx_pci_pm_init(t7xx_dev);
+	if (ret)
+		return ret;
+
 	t7xx_pcie_mac_atr_init(t7xx_dev);
 	t7xx_pci_infracfg_ao_calc(t7xx_dev);
 	t7xx_mhccif_init(t7xx_dev);
@@ -216,6 +639,8 @@ static struct pci_driver t7xx_pci_driver = {
 	.id_table = t7xx_pci_table,
 	.probe = t7xx_pci_probe,
 	.remove = t7xx_pci_remove,
+	.driver.pm = &t7xx_pci_pm_ops,
+	.shutdown = t7xx_pci_shutdown,
 };
 
 module_pci_driver(t7xx_pci_driver);
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index ecdab7abe17b..314d8616a0e0 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -17,7 +17,9 @@
 #ifndef __T7XX_PCI_H__
 #define __T7XX_PCI_H__
 
+#include <linux/completion.h>
 #include <linux/irqreturn.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/types.h>
 
@@ -47,6 +49,10 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
  * @pdev: PCI device
  * @base_addr: memory base addresses of HW components
  * @md: modem interface
+ * @md_pm_entities: list of pm entities
+ * @md_pm_entity_mtx: protects md_pm_entities list
+ * @pm_sr_ack: ack from the device when went to sleep or woke up
+ * @md_pm_state: state for resume/suspend
  * @ccmni_ctlb: context structure used to control the network data path
  * @rgu_pci_irq_en: RGU callback isr registered and active
  * @pools: pre allocated skb pools
@@ -58,8 +64,49 @@ struct t7xx_pci_dev {
 	struct pci_dev		*pdev;
 	struct t7xx_addr_base	base_addr;
 	struct t7xx_modem	*md;
+
+	/* Low Power Items */
+	struct list_head	md_pm_entities;
+	struct mutex		md_pm_entity_mtx;	/* Protects MD PM entities list */
+	struct completion	pm_sr_ack;
+	atomic_t		md_pm_state;
+
 	struct t7xx_ccmni_ctrl	*ccmni_ctlb;
 	bool			rgu_pci_irq_en;
 };
 
+enum t7xx_pm_id {
+	PM_ENTITY_ID_CTRL1,
+	PM_ENTITY_ID_CTRL2,
+	PM_ENTITY_ID_DATA,
+	PM_ENTITY_ID_INVALID
+};
+
+/* struct md_pm_entity - device power management entity
+ * @entity: list of PM Entities
+ * @suspend: callback invoked before sending D3 request to device
+ * @suspend_late: callback invoked after getting D3 ACK from device
+ * @resume_early: callback invoked before sending the resume request to device
+ * @resume: callback invoked after getting resume ACK from device
+ * @id: unique PM entity identifier
+ * @entity_param: parameter passed to the registered callbacks
+ *
+ *  This structure is used to indicate PM operations required by internal
+ *  HW modules such as CLDMA and DPMA.
+ */
+struct md_pm_entity {
+	struct list_head	entity;
+	int (*suspend)(struct t7xx_pci_dev *t7xx_dev, void *entity_param);
+	void (*suspend_late)(struct t7xx_pci_dev *t7xx_dev, void *entity_param);
+	void (*resume_early)(struct t7xx_pci_dev *t7xx_dev, void *entity_param);
+	int (*resume)(struct t7xx_pci_dev *t7xx_dev, void *entity_param);
+	enum t7xx_pm_id		id;
+	void			*entity_param;
+};
+
+int t7xx_pci_pm_entity_register(struct t7xx_pci_dev *t7xx_dev, struct md_pm_entity *pm_entity);
+int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_entity *pm_entity);
+void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev);
+void t7xx_pci_pm_exp_detected(struct t7xx_pci_dev *t7xx_dev);
+
 #endif /* __T7XX_PCI_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index b2b809316301..e0024c3cbd3c 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -188,6 +188,7 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
 	case EXCEPTION_EVENT:
 		dev_err(dev, "Exception event\n");
 		t7xx_fsm_broadcast_state(ctl, MD_STATE_EXCEPTION);
+		t7xx_pci_pm_exp_detected(ctl->md->t7xx_dev);
 		t7xx_md_exception_handshake(ctl->md);
 
 		fsm_wait_for_event(ctl, FSM_EVENT_MD_EX_REC_OK, FSM_EVENT_MD_EX,
@@ -300,6 +301,7 @@ static int fsm_routine_starting(struct t7xx_fsm_ctl *ctl)
 		return -ETIMEDOUT;
 	}
 
+	t7xx_pci_pm_init_late(md->t7xx_dev);
 	fsm_routine_ready(ctl);
 	return 0;
 }
-- 
2.17.1

