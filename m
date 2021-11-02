Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB30442E84
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Nov 2021 13:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhKBMzw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Nov 2021 08:55:52 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60916 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhKBMzv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Nov 2021 08:55:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635857597; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FYzOHkUt1Vz+16Uiiff9OxZlCKsF7IvoMoPXgSsMOgw=; b=VRrpDC28mkaesAJ5LCMnK9TWWPUrDQ8YfnX+vJySKhn2kYhZ4zCA+1dN6HcJ11SHsv1o+F6f
 +686LbWlEton+sgdFfz94h6Z2weXThj4H3k3PQEbsOoxGGfpLn7zGWtJuFuTQ6wIKpUMvqil
 98xRLDDiFakUYp3Gu9INw+RbKzU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 618134a9aeb2390556453a56 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Nov 2021 12:52:57
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72754C43460; Tue,  2 Nov 2021 12:52:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6C62C4338F;
        Tue,  2 Nov 2021 12:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A6C62C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH] ath11k: Add missing qmi_txn_cancel()
Date:   Tue,  2 Nov 2021 18:22:38 +0530
Message-Id: <1635857558-21733-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently many functions do not follow this guidance when
qmi_send_request() fails, therefore add missing
qmi_txn_cancel() in the qmi_send_request() error path.

Also remove initialization on 'struct qmi_txn'
since qmi_tx_init() performs all necessary initialization.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index fa73118de6db..25eb22cbeaeb 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1586,7 +1586,7 @@ static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 {
 	struct qmi_wlanfw_host_cap_req_msg_v01 req;
 	struct qmi_wlanfw_host_cap_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0;
 
 	memset(&req, 0, sizeof(req));
@@ -1640,6 +1640,7 @@ static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 			       QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_host_cap_req_msg_v01_ei, &req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath11k_warn(ab, "failed to send host capability request: %d\n", ret);
 		goto out;
 	}
@@ -1705,6 +1706,7 @@ static int ath11k_qmi_fw_ind_register_send(struct ath11k_base *ab)
 			       QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_ind_register_req_msg_v01_ei, req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath11k_warn(ab, "failed to send indication register request: %d\n",
 			    ret);
 		goto out;
@@ -1734,7 +1736,7 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 {
 	struct qmi_wlanfw_respond_mem_req_msg_v01 *req;
 	struct qmi_wlanfw_respond_mem_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0, i;
 	bool delayed;
 
@@ -1783,6 +1785,7 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 			       QMI_WLANFW_RESPOND_MEM_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_respond_mem_req_msg_v01_ei, req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath11k_warn(ab, "failed to respond qmi memory request: %d\n",
 			    ret);
 		goto out;
@@ -1911,7 +1914,7 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 {
 	struct qmi_wlanfw_cap_req_msg_v01 req;
 	struct qmi_wlanfw_cap_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0;
 	int r;
 
@@ -1930,6 +1933,7 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 			       QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_cap_req_msg_v01_ei, &req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath11k_warn(ab, "failed to send qmi cap request: %d\n",
 			    ret);
 		goto out;
@@ -2000,7 +2004,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 {
 	struct qmi_wlanfw_bdf_download_req_msg_v01 *req;
 	struct qmi_wlanfw_bdf_download_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	const u8 *temp = data;
 	void __iomem *bdf_addr = NULL;
 	int ret;
@@ -2245,7 +2249,7 @@ static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
 	struct qmi_wlanfw_m3_info_req_msg_v01 req;
 	struct qmi_wlanfw_m3_info_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0;
 
 	memset(&req, 0, sizeof(req));
@@ -2277,6 +2281,7 @@ static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
 			       QMI_WLANFW_M3_INFO_REQ_MSG_V01_MAX_MSG_LEN,
 			       qmi_wlanfw_m3_info_req_msg_v01_ei, &req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath11k_warn(ab, "failed to send m3 information request: %d\n",
 			    ret);
 		goto out;
@@ -2303,7 +2308,7 @@ static int ath11k_qmi_wlanfw_mode_send(struct ath11k_base *ab,
 {
 	struct qmi_wlanfw_wlan_mode_req_msg_v01 req;
 	struct qmi_wlanfw_wlan_mode_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0;
 
 	memset(&req, 0, sizeof(req));
@@ -2325,6 +2330,7 @@ static int ath11k_qmi_wlanfw_mode_send(struct ath11k_base *ab,
 			       QMI_WLANFW_WLAN_MODE_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_wlan_mode_req_msg_v01_ei, &req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath11k_warn(ab, "failed to send wlan mode request (mode %d): %d\n",
 			    mode, ret);
 		goto out;
@@ -2358,7 +2364,7 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 	struct qmi_wlanfw_wlan_cfg_resp_msg_v01 resp;
 	struct ce_pipe_config *ce_cfg;
 	struct service_to_pipe *svc_cfg;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0, pipe_num;
 
 	ce_cfg	= (struct ce_pipe_config *)ab->qmi.ce_cfg.tgt_ce;
@@ -2419,6 +2425,7 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 			       QMI_WLANFW_WLAN_CFG_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_wlan_cfg_req_msg_v01_ei, req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath11k_warn(ab, "failed to send wlan config request: %d\n",
 			    ret);
 		goto out;
-- 
2.7.4

