Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4710409BDA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 20:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbhIMSK7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 14:10:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60966 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346562AbhIMSK6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 14:10:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631556582; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BLE6MJvE6Ge/ZSJDBxa44b+Ojdm9my70K8ySPLhKbhE=; b=hjJpRmFEmF2xHT2njFcutI+kFOpX6oW+u6QZ1oYfTiLMOYgAe6s+sA9A4+OdTxidL92vryFG
 QxVVsuJPP6bfshwGzrCxrpxs+og9A8x5u+BuWC5T0Bi1SeLI5YSQMrTpCIPtgjT29MpDdRtF
 es/1uwXj+RFC9J8O/P/eBWlrD2Q=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 613f93d1d914b051827230c9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 18:09:21
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59183C4338F; Mon, 13 Sep 2021 18:09:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29189C43616;
        Mon, 13 Sep 2021 18:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 29189C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/3] ath11k: Move pdev debugfs creation ahead
Date:   Mon, 13 Sep 2021 21:09:01 +0300
Message-Id: <20210913180902.193874-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913180902.193874-1-jouni@codeaurora.org>
References: <20210913180902.193874-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

The sram dump debugfs interface has to be put under pdev directory
located under /sys/kernel/debug/ath11k/<pdev name>. Currently pdev directory
is created after firmware is ready, this is too late for sram dump.
Suppose that if errors happen and ath11k fails to reach firmware
ready, we have no way to dump sram content to debug cause the
interface has not been created yet. So move it ahead.

Also move pdev debugfs destroy to ath11k_core_soc_destroy as a mirror.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c    | 23 +++++++++++++----------
 drivers/net/wireless/ath/ath11k/debugfs.c | 21 +++++++++++++++------
 drivers/net/wireless/ath/ath11k/debugfs.h |  9 +++++++++
 3 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 9f2c9795767e..59fa0ff06dff 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -701,14 +701,22 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 		goto err_qmi_deinit;
 	}
 
+	ret = ath11k_debugfs_pdev_create(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to create core pdev debugfs: %d\n", ret);
+		goto err_debugfs_reg;
+	}
+
 	ret = ath11k_hif_power_up(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to power up :%d\n", ret);
-		goto err_debugfs_reg;
+		goto err_pdev_debug;
 	}
 
 	return 0;
 
+err_pdev_debug:
+	ath11k_debugfs_pdev_destroy(ab);
 err_debugfs_reg:
 	ath11k_debugfs_soc_destroy(ab);
 err_qmi_deinit:
@@ -718,6 +726,7 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 
 static void ath11k_core_soc_destroy(struct ath11k_base *ab)
 {
+	ath11k_debugfs_pdev_destroy(ab);
 	ath11k_debugfs_soc_destroy(ab);
 	ath11k_dp_free(ab);
 	ath11k_reg_free(ab);
@@ -728,16 +737,13 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 {
 	int ret;
 
-	ret = ath11k_debugfs_pdev_create(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to create core pdev debugfs: %d\n", ret);
-		return ret;
-	}
+	ath11k_debugfs_crash_trigger_create(ab);
+	ath11k_debugfs_dp_stats_create(ab);
 
 	ret = ath11k_mac_register(ab);
 	if (ret) {
 		ath11k_err(ab, "failed register the radio with mac80211: %d\n", ret);
-		goto err_pdev_debug;
+		return ret;
 	}
 
 	ret = ath11k_dp_pdev_alloc(ab);
@@ -767,8 +773,6 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 	ath11k_dp_pdev_free(ab);
 err_mac_unregister:
 	ath11k_mac_unregister(ab);
-err_pdev_debug:
-	ath11k_debugfs_pdev_destroy(ab);
 
 	return ret;
 }
@@ -780,7 +784,6 @@ static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 	ath11k_mac_unregister(ab);
 	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
-	ath11k_debugfs_pdev_destroy(ab);
 }
 
 static int ath11k_core_start(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 17f0bbbac7ae..cdc492421807 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -831,20 +831,29 @@ static const struct file_operations fops_soc_dp_stats = {
 	.llseek = default_llseek,
 };
 
-int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
+void ath11k_debugfs_crash_trigger_create(struct ath11k_base *ab)
 {
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
-		return 0;
-
-	ab->debugfs_soc = debugfs_create_dir(ab->hw_params.name, ab->debugfs_ath11k);
-	if (IS_ERR(ab->debugfs_soc))
-		return PTR_ERR(ab->debugfs_soc);
+		return;
 
 	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
 			    &fops_simulate_fw_crash);
+}
+
+void ath11k_debugfs_dp_stats_create(struct ath11k_base *ab)
+{
+	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
+		return;
 
 	debugfs_create_file("soc_dp_stats", 0600, ab->debugfs_soc, ab,
 			    &fops_soc_dp_stats);
+}
+
+int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
+{
+	ab->debugfs_soc = debugfs_create_dir(ab->hw_params.name, ab->debugfs_ath11k);
+	if (IS_ERR(ab->debugfs_soc))
+		return PTR_ERR(ab->debugfs_soc);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index e5346af71f24..47b96848cf0a 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -145,6 +145,8 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return ar->debug.rx_filter;
 }
 
+void ath11k_debugfs_crash_trigger_create(struct ath11k_base *ab);
+void ath11k_debugfs_dp_stats_create(struct ath11k_base *ab);
 #else
 static inline int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
@@ -212,6 +214,13 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return 0;
 }
 
+static inline void ath11k_debugfs_crash_trigger_create(struct ath11k_base *ab)
+{
+}
+
+static inline void ath11k_debugfs_dp_stats_create(struct ath11k_base *ab)
+{
+}
 #endif /* CONFIG_MAC80211_DEBUGFS*/
 
 #endif /* _ATH11K_DEBUGFS_H_ */
-- 
2.25.1

