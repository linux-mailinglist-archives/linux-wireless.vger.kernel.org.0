Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E132F2BA023
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 03:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgKTCBK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 21:01:10 -0500
Received: from z5.mailgun.us ([104.130.96.5]:34164 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgKTCBK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 21:01:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605837669; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=r9XryZ5RU1fnuUpbNWQf5uUlzmUELpY5+zv6hzIZGbY=; b=vTpvSC00wCLGFgF3dVE5dptoM0Y0Q+eWBcbWZwZ4NKmjKHlAXgQdeIr+st7uALF4P6i/G3sM
 L+g5xPc6STok06W4wRdaVC7EI7Gg4ILXMw0N3I5E7wJpOTjCHbkX2BxqiZ+EXRoJWSNuHbjh
 r3jw/b1zP5sNSWGVBRVSgex6t6c=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fb7234fa5c560669c46f49b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 02:00:47
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F16B5C43462; Fri, 20 Nov 2020 02:00:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from z203.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B06CC433ED;
        Fri, 20 Nov 2020 02:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B06CC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bqiang@codeaurora.org
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: fix "rmmod ath11k_pci" failure after QMI sequence fails
Date:   Fri, 20 Nov 2020 10:00:28 +0800
Message-Id: <20201120020028.12063-1-bqiang@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If board.bin file is missing, QMI sequence fails,
which results in failure of "rmmod ath11k_pci".
This patch fixes this issue.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1
Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h  |  3 ++-
 drivers/net/wireless/ath/ath11k/debug.c |  1 +
 drivers/net/wireless/ath/ath11k/pci.c   |  9 +++++++
 drivers/net/wireless/ath/ath11k/qmi.c   | 35 ++++++++++++++++---------
 4 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 11448755c06d..2ddf690a9d21 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -188,7 +188,8 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_REGISTERED,
 	ATH11K_FLAG_FW_RESTART_FOR_HOST,
 	ATH11K_FLAG_CORE_STOPPED,
-	ATH11K_FLAG_CORE_STARTING
+	ATH11K_FLAG_CORE_STARTING,
+	ATH11K_FLAG_QMI_FAIL,
 };
 
 enum ath11k_monitor_flags {
diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 51226a4ec50f..ef8b3a88d342 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -1072,6 +1072,7 @@ void ath11k_debug_soc_destroy(struct ath11k_base *ab)
 	debugfs_remove_recursive(ab->debugfs_ath11k);
 	ab->debugfs_ath11k = NULL;
 }
+EXPORT_SYMBOL(ath11k_debug_soc_destroy);
 
 void ath11k_debug_fw_stats_init(struct ath11k *ar)
 {
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 43a8bffc4ba0..b59741796ac2 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1184,7 +1184,16 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	cancel_work_sync(&ab->update_11d_work);
 	cancel_work_sync(&ab->rfkill_work);
 	cancel_work_sync(&ab->reset_work);
+
+	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
+		ath11k_hif_power_down(ab);
+		ath11k_debug_soc_destroy(ab);
+		ath11k_qmi_deinit_service(ab);
+		goto qmi_fail;
+	}
+
 	ath11k_core_deinit(ab);
+qmi_fail:
 	ath11k_mhi_unregister(ab_pci);
 
 	ath11k_pci_free_irq(ab);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 83a083a2d097..075fd94d92df 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2501,7 +2501,7 @@ ath11k_qmi_driver_event_post(struct ath11k_qmi *qmi,
 	return 0;
 }
 
-static void ath11k_qmi_event_server_arrive(struct ath11k_qmi *qmi)
+static int ath11k_qmi_event_server_arrive(struct ath11k_qmi *qmi)
 {
 	struct ath11k_base *ab = qmi->ab;
 	int ret;
@@ -2509,17 +2509,19 @@ static void ath11k_qmi_event_server_arrive(struct ath11k_qmi *qmi)
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
+	return 0;
 }
 
-static void ath11k_qmi_event_mem_request(struct ath11k_qmi *qmi)
+static int ath11k_qmi_event_mem_request(struct ath11k_qmi *qmi)
 {
 	struct ath11k_base *ab = qmi->ab;
 	int ret;
@@ -2527,11 +2529,13 @@ static void ath11k_qmi_event_mem_request(struct ath11k_qmi *qmi)
 	ret = ath11k_qmi_respond_fw_mem_request(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to respond fw mem req:%d\n", ret);
-		return;
+		return ret;
 	}
+
+	return 0;
 }
 
-static void ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
+static int ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 {
 	struct ath11k_base *ab = qmi->ab;
 	int ret;
@@ -2539,7 +2543,7 @@ static void ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 	ret = ath11k_qmi_request_target_cap(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to req target capabilities:%d\n", ret);
-		return;
+		return ret;
 	}
 
 	if (ab->bus_params.fixed_bdf_addr) {
@@ -2551,14 +2555,16 @@ static void ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 
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
+	return 0;
 }
 
 static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
@@ -2715,6 +2721,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 					      event_work);
 	struct ath11k_qmi_driver_event *event;
 	struct ath11k_base *ab = qmi->ab;
+	int ret = 0;
 
 	spin_lock(&qmi->event_lock);
 	while (!list_empty(&qmi->event_list)) {
@@ -2730,17 +2737,17 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 
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
 			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags) &&
@@ -2762,6 +2769,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 			ath11k_core_qmi_firmware_ready(ab);
 			ab->qmi.cal_done = 1;
 			set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
+			clear_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
 
 			break;
 		case ATH11K_QMI_EVENT_COLD_BOOT_CAL_DONE:
@@ -2771,6 +2779,8 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 			break;
 		}
 		kfree(event);
+		if (ret < 0)
+			set_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
 		spin_lock(&qmi->event_lock);
 	}
 	spin_unlock(&qmi->event_lock);
@@ -2831,4 +2841,5 @@ void ath11k_qmi_deinit_service(struct ath11k_base *ab)
 	destroy_workqueue(ab->qmi.event_wq);
 	ath11k_qmi_free_resource(ab);
 }
+EXPORT_SYMBOL(ath11k_qmi_deinit_service);
 
-- 
2.25.1

