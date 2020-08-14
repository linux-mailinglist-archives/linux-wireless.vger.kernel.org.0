Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BAD244548
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgHNHLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:11:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29707 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgHNHK5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:10:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389057; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5p0rpyVONNvSq3vtngaZFAIvvvAtNq5wSzTX8ppsx4o=; b=bpinIdZYkbHFCEHT4HV1BjEauyQraDLNn2yAR78MQ/cD+V7sa2HMdguDchG7A/+wHCWw3cUY
 Q90juIWs5GWbPcLseNmaGWc8PdTJAWpPh8GAXlVxeUQtpOaBjIfTrLymjaOEYBHVgjepCBii
 RtvyElzQF+Prn+aF3jWI0AaLngw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5f3638f73f2ce110208a38ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3EFB3C433C9; Fri, 14 Aug 2020 07:10:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DEC66C433C6;
        Fri, 14 Aug 2020 07:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DEC66C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 08/11] ath11k: fix memory OOB access in qmi_decode
Date:   Fri, 14 Aug 2020 10:10:27 +0300
Message-Id: <1597389030-13887-9-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

The decoded_size is wrongly assigned in ath11k_qmi_msg_handlers and it results
in out of boundary access in qmi_decode. The correct decoded_size should be
calculated from the related ind_msg structure.

This issue is exposed with QCA6390 because it needs 11 small memory chunks
which are stored in qmi_wlanfw_request_mem_ind_msg_v01 and hence the
decoded_size exceeds the wrongly assigend decoded_size.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 8 ++++----
 drivers/net/wireless/ath/ath11k/qmi.h | 8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index b386ab4bd806..529886b1f068 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2477,21 +2477,21 @@ static const struct qmi_msg_handler ath11k_qmi_msg_handlers[] = {
 		.type = QMI_INDICATION,
 		.msg_id = QMI_WLFW_REQUEST_MEM_IND_V01,
 		.ei = qmi_wlanfw_request_mem_ind_msg_v01_ei,
-		.decoded_size = sizeof(qmi_wlanfw_request_mem_ind_msg_v01_ei),
+		.decoded_size = sizeof(struct qmi_wlanfw_request_mem_ind_msg_v01),
 		.fn = ath11k_qmi_msg_mem_request_cb,
 	},
 	{
 		.type = QMI_INDICATION,
 		.msg_id = QMI_WLFW_FW_MEM_READY_IND_V01,
 		.ei = qmi_wlanfw_mem_ready_ind_msg_v01_ei,
-		.decoded_size = sizeof(qmi_wlanfw_mem_ready_ind_msg_v01_ei),
+		.decoded_size = sizeof(struct qmi_wlanfw_fw_mem_ready_ind_msg_v01),
 		.fn = ath11k_qmi_msg_mem_ready_cb,
 	},
 	{
 		.type = QMI_INDICATION,
 		.msg_id = QMI_WLFW_FW_READY_IND_V01,
 		.ei = qmi_wlanfw_fw_ready_ind_msg_v01_ei,
-		.decoded_size = sizeof(qmi_wlanfw_fw_ready_ind_msg_v01_ei),
+		.decoded_size = sizeof(struct qmi_wlanfw_fw_ready_ind_msg_v01),
 		.fn = ath11k_qmi_msg_fw_ready_cb,
 	},
 	{
@@ -2499,7 +2499,7 @@ static const struct qmi_msg_handler ath11k_qmi_msg_handlers[] = {
 		.msg_id = QMI_WLFW_COLD_BOOT_CAL_DONE_IND_V01,
 		.ei = qmi_wlanfw_cold_boot_cal_done_ind_msg_v01_ei,
 		.decoded_size =
-			sizeof(qmi_wlanfw_cold_boot_cal_done_ind_msg_v01_ei),
+			sizeof(struct qmi_wlanfw_fw_cold_cal_done_ind_msg_v01),
 		.fn = ath11k_qmi_msg_cold_boot_cal_done_cb,
 	},
 };
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index d55ce6cf7222..60e904683165 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -267,6 +267,14 @@ struct qmi_wlanfw_fw_mem_ready_ind_msg_v01 {
 	char placeholder;
 };
 
+struct qmi_wlanfw_fw_ready_ind_msg_v01 {
+	char placeholder;
+};
+
+struct qmi_wlanfw_fw_cold_cal_done_ind_msg_v01 {
+	char placeholder;
+};
+
 #define QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN	0
 #define QMI_WLANFW_CAP_RESP_MSG_V01_MAX_LEN	207
 #define QMI_WLANFW_CAP_REQ_V01			0x0024
-- 
2.7.4

