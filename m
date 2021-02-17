Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3741831DAE1
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Feb 2021 14:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhBQNoo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Feb 2021 08:44:44 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:23833 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233186AbhBQNon (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Feb 2021 08:44:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613569460; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3CyA+S571AxJykjGmJEqYPdxCJUqFk+N+fLxYUZPVac=; b=uOxYU1xv5vVvkC2lnNZOffdeL1S4q9bu8W5wXVYyCYBGb4hgDf+cF/KdDloEYMnlUZHp08Hm
 +deZSKpkwNXm8x+7S7mvXHbIyyYB44naZ3jthvabLq9ffmO2jhSIfUBtq7vFLQOFYjXClw4k
 uO3VyUR4J5BJp+r+4roaquFrMc0=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 602d1d9298fd902dc2250ac9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 13:43:46
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9BEFDC433C6; Wed, 17 Feb 2021 13:43:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B22DC433ED;
        Wed, 17 Feb 2021 13:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B22DC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] ath11k: qmi: add more debug messages
Date:   Wed, 17 Feb 2021 15:43:40 +0200
Message-Id: <1613569421-14177-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To make it easier to follow the qmi event flow.

No functional changes, compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index eb1b987c9df2..69eb67a94f47 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1556,6 +1556,8 @@ static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 		req.nm_modem |= SLEEP_CLOCK_SELECT_INTERNAL_BIT;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi host cap request\n");
+
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
 	if (ret < 0)
@@ -1624,6 +1626,8 @@ static int ath11k_qmi_fw_ind_register_send(struct ath11k_base *ab)
 	if (ret < 0)
 		goto out;
 
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi indication register request\n");
+
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_IND_REGISTER_REQ_V01,
 			       QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN,
@@ -1699,6 +1703,9 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 	if (ret < 0)
 		goto out;
 
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi respond memory request delayed %i\n",
+		   delayed);
+
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_RESPOND_MEM_REQ_V01,
 			       QMI_WLANFW_RESPOND_MEM_REQ_MSG_V01_MAX_LEN,
@@ -1843,6 +1850,8 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 	if (ret < 0)
 		goto out;
 
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi target cap request\n");
+
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_CAP_REQ_V01,
 			       QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN,
@@ -2000,6 +2009,9 @@ static int ath11k_qmi_load_bdf_fixed_addr(struct ath11k_base *ab)
 		if (ret < 0)
 			goto out_qmi_bdf;
 
+		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi bdf download req fixed addr type %d\n",
+			   type);
+
 		ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 				       QMI_WLANFW_BDF_DOWNLOAD_REQ_V01,
 				       QMI_WLANFW_BDF_DOWNLOAD_REQ_MSG_V01_MAX_LEN,
@@ -2090,6 +2102,9 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 		if (ret < 0)
 			goto out_qmi_bdf;
 
+		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi bdf download request remaining %i\n",
+			   remaining);
+
 		ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 				       QMI_WLANFW_BDF_DOWNLOAD_REQ_V01,
 				       QMI_WLANFW_BDF_DOWNLOAD_REQ_MSG_V01_MAX_LEN,
@@ -2200,6 +2215,8 @@ static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
 	if (ret < 0)
 		goto out;
 
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi m3 info req\n");
+
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_M3_INFO_REQ_V01,
 			       QMI_WLANFW_M3_INFO_REQ_MSG_V01_MAX_MSG_LEN,
@@ -2246,6 +2263,8 @@ static int ath11k_qmi_wlanfw_mode_send(struct ath11k_base *ab,
 	if (ret < 0)
 		goto out;
 
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi wlan mode req mode %d\n", mode);
+
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_WLAN_MODE_REQ_V01,
 			       QMI_WLANFW_WLAN_MODE_REQ_MSG_V01_MAX_LEN,
@@ -2338,6 +2357,8 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 	if (ret < 0)
 		goto out;
 
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi wlan cfg req\n");
+
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_WLAN_CFG_REQ_V01,
 			       QMI_WLANFW_WLAN_CFG_REQ_MSG_V01_MAX_LEN,
@@ -2370,6 +2391,8 @@ void ath11k_qmi_firmware_stop(struct ath11k_base *ab)
 {
 	int ret;
 
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware stop\n");
+
 	ret = ath11k_qmi_wlanfw_mode_send(ab, ATH11K_FIRMWARE_MODE_OFF);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to send wlan mode off\n");
@@ -2382,6 +2405,8 @@ int ath11k_qmi_firmware_start(struct ath11k_base *ab,
 {
 	int ret;
 
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware start\n");
+
 	ret = ath11k_qmi_wlanfw_wlan_cfg_send(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to send wlan cfg:%d\n", ret);
-- 
2.7.4

