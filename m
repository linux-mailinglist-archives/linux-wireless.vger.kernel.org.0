Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195D02AE928
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 07:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgKKGin (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 01:38:43 -0500
Received: from z5.mailgun.us ([104.130.96.5]:11449 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgKKGik (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 01:38:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605076718; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xuAdOllg0NdzhUWiI43U7wLVSfv1M99u0QpXi6UBW2k=; b=SkJNH7tU25/QaaOzhyzAgbM+TRogzu/l2kw4Niuj6qPAzAYN3rd29loDvBbOwd2TlqB7wzha
 FZUjn+jqkzAiLs+8b8QVjggFT4RL1IltsTW65tIkD1EMraFCgCoXMtnwN6cmJZsnpniRLa+Z
 iBO5UaXsOidS7B1A/LkLwDnCh3w=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fab86e81bdb18ae754b5506 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 06:38:32
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9AF0C433C9; Wed, 11 Nov 2020 06:38:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B662C433C6;
        Wed, 11 Nov 2020 06:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B662C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2] ath11k: fix rmmod failure if qmi sequence fails
Date:   Wed, 11 Nov 2020 12:08:19 +0530
Message-Id: <1605076699-21924-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QMI sequence fails if caldata file is not available.
It is observed that 'rmmod ath11k' fails if qmi message fails.
With this patch rmmod/insmod is working.

Logs:
Direct firmware load for IPQ8074/caldata.bin failed with error -2
Falling back to user helper
qmi failed to load CAL: IPQ8074/caldata.bin
qmi failed to load board data file:-11

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V2:
  - Rebased on latest tree

 drivers/net/wireless/ath/ath11k/ahb.c     |  9 +++++++-
 drivers/net/wireless/ath/ath11k/core.h    |  1 +
 drivers/net/wireless/ath/ath11k/debugfs.c |  1 +
 drivers/net/wireless/ath/ath11k/pci.c     |  8 +++++++
 drivers/net/wireless/ath/ath11k/qmi.c     | 37 ++++++++++++++++++++-----------
 5 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index c7843f461dd2..d4ef45cd0685 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -747,6 +747,13 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 	struct ath11k_base *ab = platform_get_drvdata(pdev);
 	unsigned long left;
 
+	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
+		ath11k_ahb_power_down(ab);
+		ath11k_debugfs_soc_destroy(ab);
+		ath11k_qmi_deinit_service(ab);
+		goto qmi_fail;
+	}
+
 	reinit_completion(&ab->driver_recovery);
 
 	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags)) {
@@ -760,8 +767,8 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 	cancel_work_sync(&ab->restart_work);
 
 	ath11k_core_deinit(ab);
+qmi_fail:
 	ath11k_ahb_free_irq(ab);
-
 	ath11k_hal_srng_deinit(ab);
 	ath11k_ce_free_pipes(ab);
 	ath11k_core_free(ab);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 79224ed703db..b40ce9f3ebac 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -183,6 +183,7 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_RECOVERY,
 	ATH11K_FLAG_UNREGISTERING,
 	ATH11K_FLAG_REGISTERED,
+	ATH11K_FLAG_QMI_FAIL,
 };
 
 enum ath11k_monitor_flags {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 1b914e67d314..554feaf1ed5c 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -867,6 +867,7 @@ void ath11k_debugfs_soc_destroy(struct ath11k_base *ab)
 	debugfs_remove_recursive(ab->debugfs_ath11k);
 	ab->debugfs_ath11k = NULL;
 }
+EXPORT_SYMBOL(ath11k_debugfs_soc_destroy);
 
 void ath11k_debugfs_fw_stats_init(struct ath11k *ar)
 {
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index b75f47dc36de..e535215e53b6 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1007,10 +1007,18 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	struct ath11k_base *ab = pci_get_drvdata(pdev);
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
+	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
+		ath11k_pci_power_down(ab);
+		ath11k_debugfs_soc_destroy(ab);
+		ath11k_qmi_deinit_service(ab);
+		goto qmi_fail;
+	}
+
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
 
 	ath11k_core_deinit(ab);
 
+qmi_fail:
 	ath11k_mhi_unregister(ab_pci);
 
 	ath11k_pci_free_irq(ab);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 8529b3328d24..619b6ec727e3 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2419,7 +2419,7 @@ ath11k_qmi_driver_event_post(struct ath11k_qmi *qmi,
 	return 0;
 }
 
-static void ath11k_qmi_event_server_arrive(struct ath11k_qmi *qmi)
+static int ath11k_qmi_event_server_arrive(struct ath11k_qmi *qmi)
 {
 	struct ath11k_base *ab = qmi->ab;
 	int ret;
@@ -2427,17 +2427,19 @@ static void ath11k_qmi_event_server_arrive(struct ath11k_qmi *qmi)
 	ret = ath11k_qmi_fw_ind_register_send(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to send FW indication QMI:%d\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = ath11k_qmi_host_cap_send(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to send host cap QMI:%d\n", ret);
-		return;
+		return ret;
 	}
+
+	return ret;
 }
 
-static void ath11k_qmi_event_mem_request(struct ath11k_qmi *qmi)
+static int ath11k_qmi_event_mem_request(struct ath11k_qmi *qmi)
 {
 	struct ath11k_base *ab = qmi->ab;
 	int ret;
@@ -2445,11 +2447,13 @@ static void ath11k_qmi_event_mem_request(struct ath11k_qmi *qmi)
 	ret = ath11k_qmi_respond_fw_mem_request(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to respond fw mem req:%d\n", ret);
-		return;
+		return ret;
 	}
+
+	return ret;
 }
 
-static void ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
+static int ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 {
 	struct ath11k_base *ab = qmi->ab;
 	int ret;
@@ -2457,7 +2461,7 @@ static void ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 	ret = ath11k_qmi_request_target_cap(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to req target capabilities:%d\n", ret);
-		return;
+		return ret;
 	}
 
 	if (ab->bus_params.fixed_bdf_addr)
@@ -2466,14 +2470,16 @@ static void ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 		ret = ath11k_qmi_load_bdf_qmi(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to load board data file:%d\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = ath11k_qmi_wlanfw_m3_info_send(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to send m3 info req:%d\n", ret);
-		return;
+		return ret;
 	}
+
+	return ret;
 }
 
 static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
@@ -2613,7 +2619,7 @@ static int ath11k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi wifi fw qmi service connected\n");
 	ath11k_qmi_driver_event_post(qmi, ATH11K_QMI_EVENT_SERVER_ARRIVE, NULL);
 
-	return 0;
+	return ret;
 }
 
 static void ath11k_qmi_ops_del_server(struct qmi_handle *qmi_hdl,
@@ -2637,6 +2643,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 					      event_work);
 	struct ath11k_qmi_driver_event *event;
 	struct ath11k_base *ab = qmi->ab;
+	int ret = 0;
 
 	spin_lock(&qmi->event_lock);
 	while (!list_empty(&qmi->event_list)) {
@@ -2650,17 +2657,17 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 
 		switch (event->type) {
 		case ATH11K_QMI_EVENT_SERVER_ARRIVE:
-			ath11k_qmi_event_server_arrive(qmi);
+			ret = ath11k_qmi_event_server_arrive(qmi);
 			break;
 		case ATH11K_QMI_EVENT_SERVER_EXIT:
 			set_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 			set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
 			break;
 		case ATH11K_QMI_EVENT_REQUEST_MEM:
-			ath11k_qmi_event_mem_request(qmi);
+			ret = ath11k_qmi_event_mem_request(qmi);
 			break;
 		case ATH11K_QMI_EVENT_FW_MEM_READY:
-			ath11k_qmi_event_load_bdf(qmi);
+			ret = ath11k_qmi_event_load_bdf(qmi);
 			break;
 		case ATH11K_QMI_EVENT_FW_READY:
 			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)) {
@@ -2688,6 +2695,9 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 			break;
 		}
 		kfree(event);
+		if (ret < 0)
+			set_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
+
 		spin_lock(&qmi->event_lock);
 	}
 	spin_unlock(&qmi->event_lock);
@@ -2740,4 +2750,5 @@ void ath11k_qmi_deinit_service(struct ath11k_base *ab)
 	ath11k_qmi_m3_free(ab);
 	ath11k_qmi_free_target_mem_chunk(ab);
 }
+EXPORT_SYMBOL(ath11k_qmi_deinit_service);
 
-- 
2.7.4

