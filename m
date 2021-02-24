Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D555323A07
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 10:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhBXJ5W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 04:57:22 -0500
Received: from z11.mailgun.us ([104.130.96.11]:50971 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234678AbhBXJ4t (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 04:56:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614160586; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4OX1dbijW82l7e2CtJ3oWvUe+S26p9ku+mLbyAlkAUs=; b=Mc61UI008uiRpvItnmg8mhM5782U12OflGsmFbvHLcr9UUNtIj0yGR6ogxJ93mcg59W5Zkvo
 GH1+BNjmYlbjQ6d/MakNqdbwJrj5rbi9y/aiihPWuqVg5b04+hrl31Zt7l+8aCFQvNxVPkWl
 QnAWDy3UzP3sMcAsOnrTEqt6E3Q=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 603622b0e9080d5ff7c1996b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 09:56:00
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6C704C433CA; Wed, 24 Feb 2021 09:55:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89DF9C433ED;
        Wed, 24 Feb 2021 09:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89DF9C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH] ath11k: update debugfs support for mupltiple radios in PCI bus
Date:   Wed, 24 Feb 2021 15:25:42 +0530
Message-Id: <1614160542-27882-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

debugfs_ath11k struct is moved to ath11k_core, since its common
for both pci and ahb.

Current ath11k_pci insmod fails if there are multiple PCI rdaios,

 ath11k_pci 0000:01:00.0: Hardware name qcn9074 hw1.0
 debugfs: Directory 'ath11k' with parent '/' already present!
 ath11k_pci 0000:01:00.0: failed to create ath11k debugfs
 ath11k_pci 0000:01:00.0: failed to create soc core: -17
 ath11k_pci 0000:01:00.0: failed to init core: -17
 ath11k_pci: probe of 0000:01:00.0 failed with error -17

To avoid the failure, debugfs directory is created with soc_name
and bus_id to allow creating debugfs directory for second PCI radio.

with this Debugfs entries looks like,
 # ls -l /sys/kernel/debug/ath11k/
 ipq8074 hw2.0 qcn9000 hw1.0_0000:01:00.0 qcn9000 hw1.0_0001:01:00.0

 # ls -l /sys/kernel/debug/ath11k/ipq8074 hw2.0/
  mac0  mac1 simulate_fw_crash soc_dp_stats

 # ls -l /sys/kernel/debug/ath11k/qcn9000 hw1.0_0000:01:00.0
  mac0 simulate_fw_crash soc_dp_stats

 # /sys/kernel/debug/ath11k/qcn9000 hw1.0_0001:01:00.0:
   mac0  simulate_fw_crash soc_dp_stats

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c    | 12 +++++++
 drivers/net/wireless/ath/ath11k/core.h    |  1 -
 drivers/net/wireless/ath/ath11k/debugfs.c | 57 +++++++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/debugfs.h | 11 ++++++
 4 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 77ce3347ab86..d121fa1fd6d7 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1111,5 +1111,17 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 }
 EXPORT_SYMBOL(ath11k_core_alloc);
 
+static int ath11k_init(void)
+{
+	return ath11k_debugfs_create();
+}
+module_init(ath11k_init);
+
+static void ath11k_exit(void)
+{
+	ath11k_debugfs_destroy();
+}
+module_exit(ath11k_exit);
+
 MODULE_DESCRIPTION("Core module for Qualcomm Atheros 802.11ax wireless LAN cards.");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9cdc4f0b0690..2672448d7848 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -723,7 +723,6 @@ struct ath11k_base {
 	enum ath11k_dfs_region dfs_region;
 #ifdef CONFIG_ATH11K_DEBUGFS
 	struct dentry *debugfs_soc;
-	struct dentry *debugfs_ath11k;
 #endif
 	struct ath11k_soc_dp_stats soc_stats;
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 554feaf1ed5c..02694f8d33d2 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -13,6 +13,8 @@
 #include "debugfs_htt_stats.h"
 #include "peer.h"
 
+struct dentry *debugfs_ath11k;
+
 static const char *htt_bp_umac_ring[HTT_SW_UMAC_RING_IDX_MAX] = {
 	"REO2SW1_RING",
 	"REO2SW2_RING",
@@ -836,10 +838,6 @@ int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
 		return 0;
 
-	ab->debugfs_soc = debugfs_create_dir(ab->hw_params.name, ab->debugfs_ath11k);
-	if (IS_ERR(ab->debugfs_soc))
-		return PTR_ERR(ab->debugfs_soc);
-
 	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
 			    &fops_simulate_fw_crash);
 
@@ -851,24 +849,58 @@ int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 
 void ath11k_debugfs_pdev_destroy(struct ath11k_base *ab)
 {
-	debugfs_remove_recursive(ab->debugfs_soc);
-	ab->debugfs_soc = NULL;
 }
 
 int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
-	ab->debugfs_ath11k = debugfs_create_dir("ath11k", NULL);
+	struct device *dev = ab->dev;
+	char soc_name[64] = {0};
+
+	if (!(IS_ERR_OR_NULL(ab->debugfs_soc)))
+		return 0;
+
+	if (ab->hif.bus == ATH11K_BUS_AHB) {
+		snprintf(soc_name, sizeof(soc_name), "%s", ab->hw_params.name);
+	} else {
+		snprintf(soc_name, sizeof(soc_name), "%s_%s",
+			 ab->hw_params.name, dev_name(dev));
+	}
 
-	return PTR_ERR_OR_ZERO(ab->debugfs_ath11k);
+	ab->debugfs_soc = debugfs_create_dir(soc_name, debugfs_ath11k);
+	if (IS_ERR_OR_NULL(ab->debugfs_soc)) {
+		if (IS_ERR(ab->debugfs_soc))
+			return PTR_ERR(ab->debugfs_soc);
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 void ath11k_debugfs_soc_destroy(struct ath11k_base *ab)
 {
-	debugfs_remove_recursive(ab->debugfs_ath11k);
-	ab->debugfs_ath11k = NULL;
+	debugfs_remove_recursive(ab->debugfs_soc);
+	ab->debugfs_soc = NULL;
 }
 EXPORT_SYMBOL(ath11k_debugfs_soc_destroy);
 
+int ath11k_debugfs_create(void)
+{
+	debugfs_ath11k = debugfs_create_dir("ath11k", NULL);
+	if (IS_ERR_OR_NULL(debugfs_ath11k)) {
+		if (IS_ERR(debugfs_ath11k))
+			return PTR_ERR(debugfs_ath11k);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void ath11k_debugfs_destroy(void)
+{
+	debugfs_remove_recursive(debugfs_ath11k);
+	debugfs_ath11k = NULL;
+}
+
 void ath11k_debugfs_fw_stats_init(struct ath11k *ar)
 {
 	struct dentry *fwstats_dir = debugfs_create_dir("fw_stats",
@@ -1057,6 +1089,9 @@ int ath11k_debugfs_register(struct ath11k *ar)
 	char pdev_name[5];
 	char buf[100] = {0};
 
+	if (!(IS_ERR_OR_NULL(ar->debug.debugfs_pdev)))
+		return 0;
+
 	snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
 
 	ar->debug.debugfs_pdev = debugfs_create_dir(pdev_name, ab->debugfs_soc);
@@ -1095,4 +1130,6 @@ int ath11k_debugfs_register(struct ath11k *ar)
 
 void ath11k_debugfs_unregister(struct ath11k *ar)
 {
+	debugfs_remove_recursive(ar->debug.debugfs_pdev);
+	ar->debug.debugfs_pdev = NULL;
 }
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index e5346af71f24..5882a6761a5a 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -104,6 +104,8 @@ enum ath11k_dbg_aggr_mode {
 };
 
 #ifdef CONFIG_ATH11K_DEBUGFS
+int ath11k_debugfs_create(void);
+void ath11k_debugfs_destroy(void);
 int ath11k_debugfs_soc_create(struct ath11k_base *ab);
 void ath11k_debugfs_soc_destroy(struct ath11k_base *ab);
 int ath11k_debugfs_pdev_create(struct ath11k_base *ab);
@@ -146,6 +148,15 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 }
 
 #else
+static inline int ath11k_debugfs_create(void)
+{
+	return 0;
+}
+
+static inline void ath11k_debugfs_destroy(void)
+{
+}
+
 static inline int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
 	return 0;
-- 
2.7.4

