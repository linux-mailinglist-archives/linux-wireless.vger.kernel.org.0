Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90081C6D68
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 11:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgEFJoQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 05:44:16 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57770 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728663AbgEFJoP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 05:44:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588758253; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=SRmaoc5xm209w4bDkjXVL4c3F4Di7LbTTRC+q1qfats=; b=Zgltkh0lxoROL64w6By/VeZYaPc6yjFgFaE9ui1dAKAJu7yNWE0hXr2NxyJi1ZD0hdhzDDfe
 5xJjgCLVRN5yjdnerwRyvO6MrFdGl6lLeSB7BBmKaoh4kUGX+dtNSe+wU0SAbly2bsAYvkDf
 srv+ObdMMNsTWuxg+KR3NyfGwPM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb286ea.7f9bae940f10-smtp-out-n01;
 Wed, 06 May 2020 09:44:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 97A5AC433BA; Wed,  6 May 2020 09:44:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BCBA2C43636;
        Wed,  6 May 2020 09:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCBA2C43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 1/3] ath11k: Add support for multibus support
Date:   Wed,  6 May 2020 15:13:58 +0530
Message-Id: <20200506094400.4740-2-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200506094400.4740-1-govinds@codeaurora.org>
References: <20200506094400.4740-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Current design supports only AHB interface for
11ax chipset. Refactor the code by adding hif layer
for bus level abstraction to support  PCI based device.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c    | 45 ++++++++++---
 drivers/net/wireless/ath/ath11k/ahb.h    | 22 ------
 drivers/net/wireless/ath/ath11k/core.c   | 41 +++--------
 drivers/net/wireless/ath/ath11k/core.h   |  4 +-
 drivers/net/wireless/ath/ath11k/dp.c     |  1 +
 drivers/net/wireless/ath/ath11k/hal.c    | 86 ++++++++++++------------
 drivers/net/wireless/ath/ath11k/hal_rx.c | 21 +++---
 drivers/net/wireless/ath/ath11k/hal_tx.c | 11 +--
 drivers/net/wireless/ath/ath11k/hif.h    | 65 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/htc.c    |  3 +-
 10 files changed, 180 insertions(+), 119 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/hif.h

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 3b2b76d602f2..b625b7c3ad32 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include "ahb.h"
 #include "debug.h"
+#include "hif.h"
 #include <linux/remoteproc.h>
 
 static const struct of_device_id ath11k_ahb_of_match[] = {
@@ -434,6 +435,16 @@ enum ext_irq_num {
 	tcl2host_status_ring,
 };
 
+static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
+{
+	return ioread32(ab->mem + offset);
+}
+
+static inline void ath11k_ahb_write32(struct ath11k_base *ab, u32 offset, u32 value)
+{
+	iowrite32(value, ab->mem + offset);
+}
+
 static void ath11k_ahb_kill_tasklets(struct ath11k_base *ab)
 {
 	int i;
@@ -575,7 +586,7 @@ static void ath11k_ahb_ce_irqs_disable(struct ath11k_base *ab)
 	}
 }
 
-int ath11k_ahb_start(struct ath11k_base *ab)
+static int ath11k_ahb_start(struct ath11k_base *ab)
 {
 	ath11k_ahb_ce_irqs_enable(ab);
 	ath11k_ce_rx_post_buf(ab);
@@ -583,7 +594,7 @@ int ath11k_ahb_start(struct ath11k_base *ab)
 	return 0;
 }
 
-void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab)
+static void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab)
 {
 	int i;
 
@@ -595,13 +606,13 @@ void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab)
 	}
 }
 
-void ath11k_ahb_ext_irq_disable(struct ath11k_base *ab)
+static void ath11k_ahb_ext_irq_disable(struct ath11k_base *ab)
 {
 	__ath11k_ahb_ext_irq_disable(ab);
 	ath11k_ahb_sync_ext_irqs(ab);
 }
 
-void ath11k_ahb_stop(struct ath11k_base *ab)
+static void ath11k_ahb_stop(struct ath11k_base *ab)
 {
 	if (!test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
 		ath11k_ahb_ce_irqs_disable(ab);
@@ -611,7 +622,7 @@ void ath11k_ahb_stop(struct ath11k_base *ab)
 	ath11k_ce_cleanup_pipes(ab);
 }
 
-int ath11k_ahb_power_up(struct ath11k_base *ab)
+static int ath11k_ahb_power_up(struct ath11k_base *ab)
 {
 	int ret;
 
@@ -622,7 +633,7 @@ int ath11k_ahb_power_up(struct ath11k_base *ab)
 	return ret;
 }
 
-void ath11k_ahb_power_down(struct ath11k_base *ab)
+static void ath11k_ahb_power_down(struct ath11k_base *ab)
 {
 	rproc_shutdown(ab->tgt_rproc);
 }
@@ -834,8 +845,8 @@ static int ath11k_ahb_config_irq(struct ath11k_base *ab)
 	return ret;
 }
 
-int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
-				   u8 *ul_pipe, u8 *dl_pipe)
+static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+					  u8 *ul_pipe, u8 *dl_pipe)
 {
 	const struct service_to_pipe *entry;
 	bool ul_set = false, dl_set = false;
@@ -877,6 +888,18 @@ int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 	return 0;
 }
 
+static const struct ath11k_hif_ops ath11k_ahb_hif_ops = {
+	.start = ath11k_ahb_start,
+	.stop = ath11k_ahb_stop,
+	.read32 = ath11k_ahb_read32,
+	.write32 = ath11k_ahb_write32,
+	.irq_enable = ath11k_ahb_ext_irq_enable,
+	.irq_disable = ath11k_ahb_ext_irq_disable,
+	.map_service_to_pipe = ath11k_ahb_map_service_to_pipe,
+	.power_down = ath11k_ahb_power_down,
+	.power_up = ath11k_ahb_power_up,
+};
+
 static int ath11k_ahb_probe(struct platform_device *pdev)
 {
 	struct ath11k_base *ab;
@@ -915,6 +938,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	ab->hif.ops = &ath11k_ahb_hif_ops;
 	ab->pdev = pdev;
 	ab->hw_rev = (enum ath11k_hw_rev)of_id->data;
 	ab->mem = mem;
@@ -997,8 +1021,13 @@ int ath11k_ahb_init(void)
 {
 	return platform_driver_register(&ath11k_ahb_driver);
 }
+module_init(ath11k_ahb_init);
 
 void ath11k_ahb_exit(void)
 {
 	platform_driver_unregister(&ath11k_ahb_driver);
 }
+module_exit(ath11k_ahb_exit);
+
+MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax wireless chip");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
index 93f46dfe22df..6c7b26ac6545 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.h
+++ b/drivers/net/wireless/ath/ath11k/ahb.h
@@ -10,26 +10,4 @@
 #define ATH11K_AHB_RECOVERY_TIMEOUT (3 * HZ)
 struct ath11k_base;
 
-static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
-{
-	return ioread32(ab->mem + offset);
-}
-
-static inline void ath11k_ahb_write32(struct ath11k_base *ab, u32 offset, u32 value)
-{
-	iowrite32(value, ab->mem + offset);
-}
-
-void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab);
-void ath11k_ahb_ext_irq_disable(struct ath11k_base *ab);
-int ath11k_ahb_start(struct ath11k_base *ab);
-void ath11k_ahb_stop(struct ath11k_base *ab);
-int ath11k_ahb_power_up(struct ath11k_base *ab);
-void ath11k_ahb_power_down(struct ath11k_base *ab);
-int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
-				   u8 *ul_pipe, u8 *dl_pipe);
-
-int ath11k_ahb_init(void);
-void ath11k_ahb_exit(void);
-
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index bf5657d2ae18..985ea3bcadb9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -12,6 +12,7 @@
 #include "dp_tx.h"
 #include "dp_rx.h"
 #include "debug.h"
+#include "hif.h"
 
 unsigned int ath11k_debug_mask;
 module_param_named(debug_mask, ath11k_debug_mask, uint, 0644);
@@ -41,6 +42,7 @@ u8 ath11k_core_get_hw_mac_id(struct ath11k_base *ab, int pdev_idx)
 		return ATH11K_INVALID_HW_MAC_ID;
 	}
 }
+EXPORT_SYMBOL(ath11k_core_get_hw_mac_id);
 
 static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 					 size_t name_len)
@@ -324,7 +326,7 @@ static void ath11k_core_stop(struct ath11k_base *ab)
 {
 	if (!test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
 		ath11k_qmi_firmware_stop(ab);
-	ath11k_ahb_stop(ab);
+	ath11k_hif_stop(ab);
 	ath11k_wmi_detach(ab);
 	ath11k_dp_pdev_reo_cleanup(ab);
 
@@ -347,7 +349,7 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 		goto err_qmi_deinit;
 	}
 
-	ret = ath11k_ahb_power_up(ab);
+	ret = ath11k_hif_power_up(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to power up :%d\n", ret);
 		goto err_debugfs_reg;
@@ -415,7 +417,7 @@ static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
 	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
-	ath11k_ahb_ext_irq_disable(ab);
+	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
 	ath11k_debug_pdev_destroy(ab);
 }
@@ -443,7 +445,7 @@ static int ath11k_core_start(struct ath11k_base *ab,
 		goto err_wmi_detach;
 	}
 
-	ret = ath11k_ahb_start(ab);
+	ret = ath11k_hif_start(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to start HIF: %d\n", ret);
 		goto err_wmi_detach;
@@ -522,7 +524,7 @@ static int ath11k_core_start(struct ath11k_base *ab,
 err_mac_destroy:
 	ath11k_mac_destroy(ab);
 err_hif_stop:
-	ath11k_ahb_stop(ab);
+	ath11k_hif_stop(ab);
 err_wmi_detach:
 	ath11k_wmi_detach(ab);
 err_firmware_stop:
@@ -559,7 +561,7 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		ath11k_err(ab, "failed to create pdev core: %d\n", ret);
 		goto err_core_stop;
 	}
-	ath11k_ahb_ext_irq_enable(ab);
+	ath11k_hif_irq_enable(ab);
 	mutex_unlock(&ab->core_lock);
 
 	return 0;
@@ -579,9 +581,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 
 	mutex_lock(&ab->core_lock);
 	ath11k_thermal_unregister(ab);
-	ath11k_ahb_ext_irq_disable(ab);
+	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
-	ath11k_ahb_stop(ab);
+	ath11k_hif_stop(ab);
 	ath11k_wmi_detach(ab);
 	ath11k_dp_pdev_reo_cleanup(ab);
 	mutex_unlock(&ab->core_lock);
@@ -744,7 +746,7 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 
 	mutex_unlock(&ab->core_lock);
 
-	ath11k_ahb_power_down(ab);
+	ath11k_hif_power_down(ab);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
 }
@@ -784,24 +786,3 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev)
 	kfree(ab);
 	return NULL;
 }
-
-static int __init ath11k_init(void)
-{
-	int ret;
-
-	ret = ath11k_ahb_init();
-	if (ret)
-		printk(KERN_ERR "failed to register ath11k ahb driver: %d\n",
-		       ret);
-	return ret;
-}
-module_init(ath11k_init);
-
-static void __exit ath11k_exit(void)
-{
-	ath11k_ahb_exit();
-}
-module_exit(ath11k_exit);
-
-MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax wireless chip");
-MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 33237eaf0371..fdc09995609b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -602,7 +602,9 @@ struct ath11k_base {
 	void __iomem *mem;
 	unsigned long mem_len;
 
-	const struct ath11k_hif_ops *hif_ops;
+	struct {
+		const struct ath11k_hif_ops *ops;
+	} hif;
 
 	struct ath11k_ce ce;
 	struct timer_list rx_replenish_retry;
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 50350f77b309..3528806a67a4 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -701,6 +701,7 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 done:
 	return tot_work_done;
 }
+EXPORT_SYMBOL(ath11k_dp_service_srng);
 
 void ath11k_dp_pdev_free(struct ath11k_base *ab)
 {
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 9e40c4bdd674..6d937674215e 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -7,6 +7,7 @@
 #include "hal_tx.h"
 #include "debug.h"
 #include "hal_desc.h"
+#include "hif.h"
 
 static const struct hal_srng_config hw_srng_config[] = {
 	/* TODO: max_rings can populated by querying HW capabilities */
@@ -351,11 +352,12 @@ static void ath11k_hal_ce_dst_setup(struct ath11k_base *ab,
 	addr = HAL_CE_DST_RING_CTRL +
 	       srng_config->reg_start[HAL_SRNG_REG_GRP_R0] +
 	       ring_num * srng_config->reg_size[HAL_SRNG_REG_GRP_R0];
-	val = ath11k_ahb_read32(ab, addr);
+
+	val = ath11k_hif_read32(ab, addr);
 	val &= ~HAL_CE_DST_R0_DEST_CTRL_MAX_LEN;
 	val |= FIELD_PREP(HAL_CE_DST_R0_DEST_CTRL_MAX_LEN,
 			  srng->u.dst_ring.max_buffer_length);
-	ath11k_ahb_write32(ab, addr, val);
+	ath11k_hif_write32(ab, addr, val);
 }
 
 static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
@@ -369,34 +371,34 @@ static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
 	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
 
 	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
-		ath11k_ahb_write32(ab, reg_base +
-				       HAL_REO1_RING_MSI1_BASE_LSB_OFFSET,
+		ath11k_hif_write32(ab, reg_base +
+				   HAL_REO1_RING_MSI1_BASE_LSB_OFFSET,
 				   (u32)srng->msi_addr);
 
 		val = FIELD_PREP(HAL_REO1_RING_MSI1_BASE_MSB_ADDR,
 				 ((u64)srng->msi_addr >>
 				  HAL_ADDR_MSB_REG_SHIFT)) |
 		      HAL_REO1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
-		ath11k_ahb_write32(ab, reg_base +
+		ath11k_hif_write32(ab, reg_base +
 				       HAL_REO1_RING_MSI1_BASE_MSB_OFFSET, val);
 
-		ath11k_ahb_write32(ab,
+		ath11k_hif_write32(ab,
 				   reg_base + HAL_REO1_RING_MSI1_DATA_OFFSET,
 				   srng->msi_data);
 	}
 
-	ath11k_ahb_write32(ab, reg_base, (u32)srng->ring_base_paddr);
+	ath11k_hif_write32(ab, reg_base, (u32)srng->ring_base_paddr);
 
 	val = FIELD_PREP(HAL_REO1_RING_BASE_MSB_RING_BASE_ADDR_MSB,
 			 ((u64)srng->ring_base_paddr >>
 			  HAL_ADDR_MSB_REG_SHIFT)) |
 	      FIELD_PREP(HAL_REO1_RING_BASE_MSB_RING_SIZE,
 			 (srng->entry_size * srng->num_entries));
-	ath11k_ahb_write32(ab, reg_base + HAL_REO1_RING_BASE_MSB_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_BASE_MSB_OFFSET, val);
 
 	val = FIELD_PREP(HAL_REO1_RING_ID_RING_ID, srng->ring_id) |
 	      FIELD_PREP(HAL_REO1_RING_ID_ENTRY_SIZE, srng->entry_size);
-	ath11k_ahb_write32(ab, reg_base + HAL_REO1_RING_ID_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_ID_OFFSET, val);
 
 	/* interrupt setup */
 	val = FIELD_PREP(HAL_REO1_RING_PRDR_INT_SETUP_INTR_TMR_THOLD,
@@ -406,22 +408,22 @@ static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
 			  (srng->intr_batch_cntr_thres_entries *
 			   srng->entry_size));
 
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   reg_base + HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET,
 			   val);
 
 	hp_addr = hal->rdp.paddr +
 		  ((unsigned long)srng->u.dst_ring.hp_addr -
 		   (unsigned long)hal->rdp.vaddr);
-	ath11k_ahb_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_LSB_OFFSET,
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_LSB_OFFSET,
 			   hp_addr & HAL_ADDR_LSB_REG_MASK);
-	ath11k_ahb_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_MSB_OFFSET,
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_MSB_OFFSET,
 			   hp_addr >> HAL_ADDR_MSB_REG_SHIFT);
 
 	/* Initialize head and tail pointers to indicate ring is empty */
 	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R2];
-	ath11k_ahb_write32(ab, reg_base, 0);
-	ath11k_ahb_write32(ab, reg_base + HAL_REO1_RING_TP_OFFSET, 0);
+	ath11k_hif_write32(ab, reg_base, 0);
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_TP_OFFSET, 0);
 	*srng->u.dst_ring.hp_addr = 0;
 
 	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
@@ -434,7 +436,7 @@ static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
 		val |= HAL_REO1_RING_MISC_MSI_SWAP;
 	val |= HAL_REO1_RING_MISC_SRNG_ENABLE;
 
-	ath11k_ahb_write32(ab, reg_base + HAL_REO1_RING_MISC_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_MISC_OFFSET, val);
 }
 
 static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
@@ -448,34 +450,34 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
 
 	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
-		ath11k_ahb_write32(ab, reg_base +
-				       HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET,
+		ath11k_hif_write32(ab, reg_base +
+				    HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET,
 				   (u32)srng->msi_addr);
 
 		val = FIELD_PREP(HAL_TCL1_RING_MSI1_BASE_MSB_ADDR,
 				 ((u64)srng->msi_addr >>
 				  HAL_ADDR_MSB_REG_SHIFT)) |
 		      HAL_TCL1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
-		ath11k_ahb_write32(ab, reg_base +
+		ath11k_hif_write32(ab, reg_base +
 				       HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET,
 				   val);
 
-		ath11k_ahb_write32(ab, reg_base +
+		ath11k_hif_write32(ab, reg_base +
 				       HAL_TCL1_RING_MSI1_DATA_OFFSET,
 				   srng->msi_data);
 	}
 
-	ath11k_ahb_write32(ab, reg_base, (u32)srng->ring_base_paddr);
+	ath11k_hif_write32(ab, reg_base, (u32)srng->ring_base_paddr);
 
 	val = FIELD_PREP(HAL_TCL1_RING_BASE_MSB_RING_BASE_ADDR_MSB,
 			 ((u64)srng->ring_base_paddr >>
 			  HAL_ADDR_MSB_REG_SHIFT)) |
 	      FIELD_PREP(HAL_TCL1_RING_BASE_MSB_RING_SIZE,
 			 (srng->entry_size * srng->num_entries));
-	ath11k_ahb_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET, val);
 
 	val = FIELD_PREP(HAL_REO1_RING_ID_ENTRY_SIZE, srng->entry_size);
-	ath11k_ahb_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET, val);
 
 	/* interrupt setup */
 	/* NOTE: IPQ8074 v2 requires the interrupt timer threshold in the
@@ -488,7 +490,7 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 			  (srng->intr_batch_cntr_thres_entries *
 			   srng->entry_size));
 
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET,
 			   val);
 
@@ -497,7 +499,7 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 		val |= FIELD_PREP(HAL_TCL1_RING_CONSR_INT_SETUP_IX1_LOW_THOLD,
 				  srng->u.src_ring.low_threshold);
 	}
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET,
 			   val);
 
@@ -505,18 +507,18 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 		tp_addr = hal->rdp.paddr +
 			  ((unsigned long)srng->u.src_ring.tp_addr -
 			   (unsigned long)hal->rdp.vaddr);
-		ath11k_ahb_write32(ab,
+		ath11k_hif_write32(ab,
 				   reg_base + HAL_TCL1_RING_TP_ADDR_LSB_OFFSET,
 				   tp_addr & HAL_ADDR_LSB_REG_MASK);
-		ath11k_ahb_write32(ab,
+		ath11k_hif_write32(ab,
 				   reg_base + HAL_TCL1_RING_TP_ADDR_MSB_OFFSET,
 				   tp_addr >> HAL_ADDR_MSB_REG_SHIFT);
 	}
 
 	/* Initialize head and tail pointers to indicate ring is empty */
 	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R2];
-	ath11k_ahb_write32(ab, reg_base, 0);
-	ath11k_ahb_write32(ab, reg_base + HAL_TCL1_RING_TP_OFFSET, 0);
+	ath11k_hif_write32(ab, reg_base, 0);
+	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_TP_OFFSET, 0);
 	*srng->u.src_ring.tp_addr = 0;
 
 	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
@@ -533,7 +535,7 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 
 	val |= HAL_TCL1_RING_MISC_SRNG_ENABLE;
 
-	ath11k_ahb_write32(ab, reg_base + HAL_TCL1_RING_MISC_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_MISC_OFFSET, val);
 }
 
 static void ath11k_hal_srng_hw_init(struct ath11k_base *ab,
@@ -889,13 +891,13 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
 				*(volatile u32 *)srng->u.src_ring.tp_addr;
-			ath11k_ahb_write32(ab,
+			ath11k_hif_write32(ab,
 					   (unsigned long)srng->u.src_ring.hp_addr -
 					   (unsigned long)ab->mem,
 					   srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
-			ath11k_ahb_write32(ab,
+			ath11k_hif_write32(ab,
 					   (unsigned long)srng->u.dst_ring.tp_addr -
 					   (unsigned long)ab->mem,
 					   srng->u.dst_ring.tp);
@@ -929,20 +931,20 @@ void ath11k_hal_setup_link_idle_list(struct ath11k_base *ab,
 			     HAL_WBM_IDLE_SCATTER_BUF_SIZE;
 	}
 
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR,
 			   FIELD_PREP(HAL_WBM_SCATTER_BUFFER_SIZE, reg_scatter_buf_sz) |
 			   FIELD_PREP(HAL_WBM_LINK_DESC_IDLE_LIST_MODE, 0x1));
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_R0_IDLE_LIST_SIZE_ADDR,
 			   FIELD_PREP(HAL_WBM_SCATTER_RING_SIZE_OF_IDLE_LINK_DESC_LIST,
 				      reg_scatter_buf_sz * nsbufs));
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
 			   HAL_WBM_SCATTERED_RING_BASE_LSB,
 			   FIELD_PREP(BUFFER_ADDR_INFO0_ADDR,
 				      sbuf[0].paddr & HAL_ADDR_LSB_REG_MASK));
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
 			   HAL_WBM_SCATTERED_RING_BASE_MSB,
 			   FIELD_PREP(
@@ -953,12 +955,12 @@ void ath11k_hal_setup_link_idle_list(struct ath11k_base *ab,
 				BASE_ADDR_MATCH_TAG_VAL));
 
 	/* Setup head and tail pointers for the idle list */
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
 			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0,
 			   FIELD_PREP(BUFFER_ADDR_INFO0_ADDR,
 				      sbuf[nsbufs - 1].paddr));
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
 			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1,
 			   FIELD_PREP(
@@ -967,18 +969,18 @@ void ath11k_hal_setup_link_idle_list(struct ath11k_base *ab,
 				 HAL_ADDR_MSB_REG_SHIFT)) |
 			   FIELD_PREP(HAL_WBM_SCATTERED_DESC_HEAD_P_OFFSET_IX1,
 				      (end_offset >> 2)));
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
 			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0,
 			   FIELD_PREP(BUFFER_ADDR_INFO0_ADDR,
 				      sbuf[0].paddr));
 
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
 			   HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0,
 			   FIELD_PREP(BUFFER_ADDR_INFO0_ADDR,
 				      sbuf[0].paddr));
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
 			   HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1,
 			   FIELD_PREP(
@@ -986,13 +988,13 @@ void ath11k_hal_setup_link_idle_list(struct ath11k_base *ab,
 				((u64)sbuf[0].paddr >> HAL_ADDR_MSB_REG_SHIFT)) |
 			   FIELD_PREP(HAL_WBM_SCATTERED_DESC_TAIL_P_OFFSET_IX1,
 				      0));
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
 			   HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR,
 			   2 * tot_link_desc);
 
 	/* Enable the SRNG */
-	ath11k_ahb_write32(ab,
+	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
 			   HAL_WBM_IDLE_LINK_RING_MISC_ADDR, 0x40);
 }
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index f277c9434a25..69b0248a7baf 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -9,6 +9,7 @@
 #include "hal_tx.h"
 #include "hal_rx.h"
 #include "hal_desc.h"
+#include "hif.h"
 
 static void ath11k_hal_reo_set_desc_hdr(struct hal_desc_header *hdr,
 					u8 owner, u8 buffer_type, u32 magic)
@@ -804,34 +805,34 @@ void ath11k_hal_reo_hw_setup(struct ath11k_base *ab, u32 ring_hash_map)
 	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
 	u32 val;
 
-	val = ath11k_ahb_read32(ab, reo_base + HAL_REO1_GEN_ENABLE);
+	val = ath11k_hif_read32(ab, reo_base + HAL_REO1_GEN_ENABLE);
 
 	val &= ~HAL_REO1_GEN_ENABLE_FRAG_DST_RING;
 	val |= FIELD_PREP(HAL_REO1_GEN_ENABLE_FRAG_DST_RING,
 			  HAL_SRNG_RING_ID_REO2SW1) |
 	       FIELD_PREP(HAL_REO1_GEN_ENABLE_AGING_LIST_ENABLE, 1) |
 	       FIELD_PREP(HAL_REO1_GEN_ENABLE_AGING_FLUSH_ENABLE, 1);
-	ath11k_ahb_write32(ab, reo_base + HAL_REO1_GEN_ENABLE, val);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_GEN_ENABLE, val);
 
-	ath11k_ahb_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_0,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_0,
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
-	ath11k_ahb_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_1,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_1,
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
-	ath11k_ahb_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_2,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_2,
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
-	ath11k_ahb_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_3,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_3,
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
 
-	ath11k_ahb_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_0,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_0,
 			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
 				      ring_hash_map));
-	ath11k_ahb_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_1,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_1,
 			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
 				      ring_hash_map));
-	ath11k_ahb_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_2,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_2,
 			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
 				      ring_hash_map));
-	ath11k_ahb_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_3,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_3,
 			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
 				      ring_hash_map));
 }
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index e4aa7e8a1284..b364c077c1f7 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -6,6 +6,7 @@
 #include "ahb.h"
 #include "hal.h"
 #include "hal_tx.h"
+#include "hif.h"
 
 #define DSCP_TID_MAP_TBL_ENTRY_SIZE 64
 
@@ -83,11 +84,11 @@ void ath11k_hal_tx_set_dscp_tid_map(struct ath11k_base *ab, int id)
 	u32 value;
 	int cnt = 0;
 
-	ctrl_reg_val = ath11k_ahb_read32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
+	ctrl_reg_val = ath11k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
 					 HAL_TCL1_RING_CMN_CTRL_REG);
 	/* Enable read/write access */
 	ctrl_reg_val |= HAL_TCL1_RING_CMN_CTRL_DSCP_TID_MAP_PROG_EN;
-	ath11k_ahb_write32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
+	ath11k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
 			   HAL_TCL1_RING_CMN_CTRL_REG, ctrl_reg_val);
 
 	addr = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_DSCP_TID_MAP +
@@ -118,15 +119,15 @@ void ath11k_hal_tx_set_dscp_tid_map(struct ath11k_base *ab, int id)
 	}
 
 	for (i = 0; i < HAL_DSCP_TID_TBL_SIZE; i += 4) {
-		ath11k_ahb_write32(ab, addr, *(u32 *)&hw_map_val[i]);
+		ath11k_hif_write32(ab, addr, *(u32 *)&hw_map_val[i]);
 		addr += 4;
 	}
 
 	/* Disable read/write access */
-	ctrl_reg_val = ath11k_ahb_read32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
+	ctrl_reg_val = ath11k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
 					 HAL_TCL1_RING_CMN_CTRL_REG);
 	ctrl_reg_val &= ~HAL_TCL1_RING_CMN_CTRL_DSCP_TID_MAP_PROG_EN;
-	ath11k_ahb_write32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
+	ath11k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
 			   HAL_TCL1_RING_CMN_CTRL_REG,
 			   ctrl_reg_val);
 }
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
new file mode 100644
index 000000000000..165f7e51c238
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ */
+
+#include "core.h"
+
+struct ath11k_hif_ops {
+	u32 (*read32)(struct ath11k_base *sc, u32 address);
+	void (*write32)(struct ath11k_base *sc, u32 address, u32 data);
+	void (*irq_enable)(struct ath11k_base *sc);
+	void (*irq_disable)(struct ath11k_base *sc);
+	int (*start)(struct ath11k_base *sc);
+	void (*stop)(struct ath11k_base *sc);
+	int (*power_up)(struct ath11k_base *sc);
+	void (*power_down)(struct ath11k_base *sc);
+	int (*map_service_to_pipe)(struct ath11k_base *sc, u16 service_id,
+				   u8 *ul_pipe, u8 *dl_pipe);
+};
+
+static inline int ath11k_hif_start(struct ath11k_base *sc)
+{
+	return sc->hif.ops->start(sc);
+}
+
+static inline void ath11k_hif_stop(struct ath11k_base *sc)
+{
+	sc->hif.ops->stop(sc);
+}
+
+static inline void ath11k_hif_irq_enable(struct ath11k_base *sc)
+{
+	sc->hif.ops->irq_enable(sc);
+}
+
+static inline void ath11k_hif_irq_disable(struct ath11k_base *sc)
+{
+	sc->hif.ops->irq_disable(sc);
+}
+
+static inline int ath11k_hif_power_up(struct ath11k_base *sc)
+{
+	return sc->hif.ops->power_up(sc);
+}
+
+static inline void ath11k_hif_power_down(struct ath11k_base *sc)
+{
+	sc->hif.ops->power_down(sc);
+}
+
+static inline u32 ath11k_hif_read32(struct ath11k_base *sc, u32 address)
+{
+	return sc->hif.ops->read32(sc, address);
+}
+
+static inline void ath11k_hif_write32(struct ath11k_base *sc, u32 address, u32 data)
+{
+	sc->hif.ops->write32(sc, address, data);
+}
+
+static inline int ath11k_hif_map_service_to_pipe(struct ath11k_base *sc, u16 service_id,
+						 u8 *ul_pipe, u8 *dl_pipe)
+{
+	return sc->hif.ops->map_service_to_pipe(sc, service_id, ul_pipe, dl_pipe);
+}
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 8f54f58b83e6..1909fc3287ba 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -7,6 +7,7 @@
 
 #include "ahb.h"
 #include "debug.h"
+#include "hif.h"
 
 struct sk_buff *ath11k_htc_alloc_skb(struct ath11k_base *ab, int size)
 {
@@ -672,7 +673,7 @@ int ath11k_htc_connect_service(struct ath11k_htc *htc,
 	/* copy all the callbacks */
 	ep->ep_ops = conn_req->ep_ops;
 
-	status = ath11k_ahb_map_service_to_pipe(htc->ab,
+	status = ath11k_hif_map_service_to_pipe(htc->ab,
 						ep->service_id,
 						&ep->ul_pipe_id,
 						&ep->dl_pipe_id);
-- 
2.22.0
