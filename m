Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1A31DAE0
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Feb 2021 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbhBQNon (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Feb 2021 08:44:43 -0500
Received: from z11.mailgun.us ([104.130.96.11]:21379 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhBQNok (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Feb 2021 08:44:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613569454; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=SEiY8iiyah2EzseaKLLdeaclqzXNeuCDp1g/FQQAoNE=; b=CC0RkeTA3wLz07VkfmKopwj4aKgdJW/UwfYkfrRLH16DKojOrpJRZKMA3y/SvTY2eYVqvezo
 ZwH7FQ47tjEa8TSzkLUybq+gUtILWfOFedc+k93O5qGr6jtPEMBgb0CSjRUXMXZ3P/Ppx52N
 BKalpDZ55shFUc3Zuk4hnzGwQEs=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 602d1d94666e232b38331b36 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 13:43:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4A50C433CA; Wed, 17 Feb 2021 13:43:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A5500C433ED;
        Wed, 17 Feb 2021 13:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5500C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] ath11k: qmi: cosmetic changes to error messages
Date:   Wed, 17 Feb 2021 15:43:41 +0200
Message-Id: <1613569421-14177-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613569421-14177-1-git-send-email-kvalo@codeaurora.org>
References: <1613569421-14177-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change the error messages to follow the style used in ath11k. Also include
error values in the messages which didn't have that.

No functional changes, compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 91 ++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 69eb67a94f47..297a2b60716a 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1568,7 +1568,7 @@ static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 			       QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_host_cap_req_msg_v01_ei, &req);
 	if (ret < 0) {
-		ath11k_warn(ab, "Failed to send host capability request,err = %d\n", ret);
+		ath11k_warn(ab, "failed to send host capability request: %d\n", ret);
 		goto out;
 	}
 
@@ -1577,7 +1577,7 @@ static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 		goto out;
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath11k_warn(ab, "Host capability request failed, result: %d, err: %d\n",
+		ath11k_warn(ab, "host capability request failed: %d %d\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -1633,19 +1633,19 @@ static int ath11k_qmi_fw_ind_register_send(struct ath11k_base *ab)
 			       QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_ind_register_req_msg_v01_ei, req);
 	if (ret < 0) {
-		ath11k_warn(ab, "Failed to send indication register request, err = %d\n",
+		ath11k_warn(ab, "failed to send indication register request: %d\n",
 			    ret);
 		goto out;
 	}
 
 	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
 	if (ret < 0) {
-		ath11k_warn(ab, "failed to register fw indication %d\n", ret);
+		ath11k_warn(ab, "failed to register fw indication: %d\n", ret);
 		goto out;
 	}
 
 	if (resp->resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath11k_warn(ab, "FW Ind register request failed, result: %d, err: %d\n",
+		ath11k_warn(ab, "firmware indication register request failed: %d %d\n",
 			    resp->resp.result, resp->resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -1711,14 +1711,14 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 			       QMI_WLANFW_RESPOND_MEM_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_respond_mem_req_msg_v01_ei, req);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to respond memory request, err = %d\n",
+		ath11k_warn(ab, "failed to respond qmi memory request: %d\n",
 			    ret);
 		goto out;
 	}
 
 	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed memory request, err = %d\n", ret);
+		ath11k_warn(ab, "failed to wait qmi memory request: %d\n", ret);
 		goto out;
 	}
 
@@ -1729,7 +1729,7 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 		if (delayed && resp.resp.error == 0)
 			goto out;
 
-		ath11k_warn(ab, "Respond mem req failed, result: %d, err: %d\n",
+		ath11k_warn(ab, "qmi respond memory request failed: %d %d\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -1781,7 +1781,8 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 				ab->qmi.target_mem_delayed = true;
 				return 0;
 			}
-			ath11k_err(ab, "failed to alloc memory, size: 0x%x, type: %u\n",
+
+			ath11k_err(ab, "failed to allocate dma memory for qmi (%d B type %u)\n",
 				   chunk->size,
 				   chunk->type);
 			return -EINVAL;
@@ -1857,19 +1858,19 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 			       QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_cap_req_msg_v01_ei, &req);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send target cap request, err = %d\n",
+		ath11k_warn(ab, "failed to send qmi cap request: %d\n",
 			    ret);
 		goto out;
 	}
 
 	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed target cap request %d\n", ret);
+		ath11k_warn(ab, "failed to wait qmi cap request: %d\n", ret);
 		goto out;
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath11k_warn(ab, "qmi targetcap req failed, result: %d, err: %d\n",
+		ath11k_warn(ab, "qmi cap request failed: %d %d\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -1932,7 +1933,7 @@ ath11k_qmi_prepare_bdf_download(struct ath11k_base *ab, int type,
 
 		ret = ath11k_core_fetch_bdf(ab, &bd);
 		if (ret) {
-			ath11k_warn(ab, "qmi failed to load BDF\n");
+			ath11k_warn(ab, "failed to load board file: %d\n", ret);
 			return ret;
 		}
 
@@ -1980,7 +1981,7 @@ static int ath11k_qmi_load_bdf_fixed_addr(struct ath11k_base *ab)
 
 	bdf_addr = ioremap(ab->hw_params.bdf_addr, ATH11K_QMI_BDF_MAX_SIZE);
 	if (!bdf_addr) {
-		ath11k_warn(ab, "qmi ioremap error for BDF\n");
+		ath11k_warn(ab, "failed ioremap for board file\n");
 		ret = -EIO;
 		goto out;
 	}
@@ -2026,7 +2027,7 @@ static int ath11k_qmi_load_bdf_fixed_addr(struct ath11k_base *ab)
 			goto out_qmi_bdf;
 
 		if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-			ath11k_warn(ab, "qmi BDF download failed, result: %d, err: %d\n",
+			ath11k_warn(ab, "board file download request failed: %d %d\n",
 				    resp.resp.result, resp.resp.error);
 			ret = -EINVAL;
 			goto out_qmi_bdf;
@@ -2059,7 +2060,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 	memset(&bd, 0, sizeof(bd));
 	ret = ath11k_core_fetch_bdf(ab, &bd);
 	if (ret) {
-		ath11k_warn(ab, "qmi failed to load bdf:\n");
+		ath11k_warn(ab, "failed to fetch board file: %d\n", ret);
 		goto out;
 	}
 
@@ -2119,7 +2120,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 			goto out_qmi_bdf;
 
 		if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-			ath11k_warn(ab, "qmi BDF download failed, result: %d, err: %d\n",
+			ath11k_warn(ab, "bdf download request failed: %d %d\n",
 				    resp.resp.result, resp.resp.error);
 			ret = resp.resp.result;
 			goto out_qmi_bdf;
@@ -2222,19 +2223,19 @@ static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
 			       QMI_WLANFW_M3_INFO_REQ_MSG_V01_MAX_MSG_LEN,
 			       qmi_wlanfw_m3_info_req_msg_v01_ei, &req);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send M3 information request, err = %d\n",
+		ath11k_warn(ab, "failed to send m3 information request: %d\n",
 			    ret);
 		goto out;
 	}
 
 	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed M3 information request %d\n", ret);
+		ath11k_warn(ab, "failed to wait m3 information request: %d\n", ret);
 		goto out;
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath11k_warn(ab, "qmi M3 info request failed, result: %d, err: %d\n",
+		ath11k_warn(ab, "m3 info request failed: %d %d\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -2270,7 +2271,7 @@ static int ath11k_qmi_wlanfw_mode_send(struct ath11k_base *ab,
 			       QMI_WLANFW_WLAN_MODE_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_wlan_mode_req_msg_v01_ei, &req);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send mode request, mode: %d, err = %d\n",
+		ath11k_warn(ab, "failed to send wlan mode request (mode %d): %d\n",
 			    mode, ret);
 		goto out;
 	}
@@ -2281,13 +2282,13 @@ static int ath11k_qmi_wlanfw_mode_send(struct ath11k_base *ab,
 			ath11k_warn(ab, "WLFW service is dis-connected\n");
 			return 0;
 		}
-		ath11k_warn(ab, "qmi failed set mode request, mode: %d, err = %d\n",
+		ath11k_warn(ab, "failed to wait wlan mode request (mode %d): %d\n",
 			    mode, ret);
 		goto out;
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath11k_warn(ab, "Mode request failed, mode: %d, result: %d err: %d\n",
+		ath11k_warn(ab, "wlan mode request failed (mode: %d): %d %d\n",
 			    mode, resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -2364,19 +2365,19 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 			       QMI_WLANFW_WLAN_CFG_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_wlan_cfg_req_msg_v01_ei, req);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send wlan config request, err = %d\n",
+		ath11k_warn(ab, "failed to send wlan config request: %d\n",
 			    ret);
 		goto out;
 	}
 
 	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed wlan config request, err = %d\n", ret);
+		ath11k_warn(ab, "failed to wait wlan config request: %d\n", ret);
 		goto out;
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath11k_warn(ab, "qmi wlan config request failed, result: %d, err: %d\n",
+		ath11k_warn(ab, "wlan config request failed: %d %d\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -2395,7 +2396,7 @@ void ath11k_qmi_firmware_stop(struct ath11k_base *ab)
 
 	ret = ath11k_qmi_wlanfw_mode_send(ab, ATH11K_FIRMWARE_MODE_OFF);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send wlan mode off\n");
+		ath11k_warn(ab, "qmi failed to send wlan mode off: %d\n", ret);
 		return;
 	}
 }
@@ -2409,13 +2410,13 @@ int ath11k_qmi_firmware_start(struct ath11k_base *ab,
 
 	ret = ath11k_qmi_wlanfw_wlan_cfg_send(ab);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send wlan cfg:%d\n", ret);
+		ath11k_warn(ab, "qmi failed to send wlan cfg: %d\n", ret);
 		return ret;
 	}
 
 	ret = ath11k_qmi_wlanfw_mode_send(ab, mode);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send wlan fw mode:%d\n", ret);
+		ath11k_warn(ab, "qmi failed to send wlan fw mode: %d\n", ret);
 		return ret;
 	}
 
@@ -2429,7 +2430,7 @@ static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
 
 	ret = ath11k_qmi_wlanfw_mode_send(ab, ATH11K_FIRMWARE_MODE_COLD_BOOT);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send wlan fw mode:%d\n", ret);
+		ath11k_warn(ab, "qmi failed to send wlan fw mode: %d\n", ret);
 		return ret;
 	}
 
@@ -2439,7 +2440,7 @@ static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
 				     (ab->qmi.cal_done  == 1),
 				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
 	if (timeout <= 0) {
-		ath11k_warn(ab, "Coldboot Calibration failed - wait ended\n");
+		ath11k_warn(ab, "coldboot calibration timed out\n");
 		return 0;
 	}
 
@@ -2478,13 +2479,14 @@ static int ath11k_qmi_event_server_arrive(struct ath11k_qmi *qmi)
 
 	ret = ath11k_qmi_fw_ind_register_send(ab);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send FW indication QMI:%d\n", ret);
+		ath11k_warn(ab, "failed to send qmi firmware indication: %d\n",
+			    ret);
 		return ret;
 	}
 
 	ret = ath11k_qmi_host_cap_send(ab);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send host cap QMI:%d\n", ret);
+		ath11k_warn(ab, "failed to send qmi host cap: %d\n", ret);
 		return ret;
 	}
 
@@ -2498,7 +2500,7 @@ static int ath11k_qmi_event_mem_request(struct ath11k_qmi *qmi)
 
 	ret = ath11k_qmi_respond_fw_mem_request(ab);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to respond fw mem req:%d\n", ret);
+		ath11k_warn(ab, "qmi failed to respond fw mem req: %d\n", ret);
 		return ret;
 	}
 
@@ -2512,7 +2514,8 @@ static int ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 
 	ret = ath11k_qmi_request_target_cap(ab);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to req target capabilities:%d\n", ret);
+		ath11k_warn(ab, "failed to requeqst qmi target capabilities: %d\n",
+			    ret);
 		return ret;
 	}
 
@@ -2521,13 +2524,13 @@ static int ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 	else
 		ret = ath11k_qmi_load_bdf_qmi(ab);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to load board data file:%d\n", ret);
+		ath11k_warn(ab, "failed to load board data file: %d\n", ret);
 		return ret;
 	}
 
 	ret = ath11k_qmi_wlanfw_m3_info_send(ab);
 	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to send m3 info req:%d\n", ret);
+		ath11k_warn(ab, "failed to send qmi m3 info req: %d\n", ret);
 		return ret;
 	}
 
@@ -2548,7 +2551,7 @@ static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 
 	if (msg->mem_seg_len == 0 ||
 	    msg->mem_seg_len > ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01)
-		ath11k_warn(ab, "Invalid memory segment length: %u\n",
+		ath11k_warn(ab, "invalid memory segment length: %u\n",
 			    msg->mem_seg_len);
 
 	ab->qmi.mem_seg_count = msg->mem_seg_len;
@@ -2563,14 +2566,14 @@ static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 	if (ab->bus_params.fixed_mem_region) {
 		ret = ath11k_qmi_assign_target_mem_chunk(ab);
 		if (ret) {
-			ath11k_warn(ab, "qmi failed to assign target memory: %d\n",
+			ath11k_warn(ab, "failed to assign qmi target memory: %d\n",
 				    ret);
 			return;
 		}
 	} else {
 		ret = ath11k_qmi_alloc_target_mem_chunk(ab);
 		if (ret) {
-			ath11k_warn(ab, "qmi failed to alloc target memory: %d\n",
+			ath11k_warn(ab, "failed to allocate qmi target memory: %d\n",
 				    ret);
 			return;
 		}
@@ -2664,7 +2667,7 @@ static int ath11k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,
 	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr *)sq,
 			     sizeof(*sq), 0);
 	if (ret) {
-		ath11k_warn(ab, "qmi failed to connect to remote service %d\n", ret);
+		ath11k_warn(ab, "failed to connect to qmi remote service: %d\n", ret);
 		return ret;
 	}
 
@@ -2750,7 +2753,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 		case ATH11K_QMI_EVENT_COLD_BOOT_CAL_DONE:
 			break;
 		default:
-			ath11k_warn(ab, "invalid event type: %d", event->type);
+			ath11k_warn(ab, "invalid qmi event type: %d", event->type);
 			break;
 		}
 		kfree(event);
@@ -2771,7 +2774,7 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 	ret = qmi_handle_init(&ab->qmi.handle, ATH11K_QMI_RESP_LEN_MAX,
 			      &ath11k_qmi_ops, ath11k_qmi_msg_handlers);
 	if (ret < 0) {
-		ath11k_warn(ab, "failed to initialize qmi handle\n");
+		ath11k_warn(ab, "failed to initialize qmi handle: %d\n", ret);
 		return ret;
 	}
 
@@ -2790,7 +2793,7 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 			     ATH11K_QMI_WLFW_SERVICE_VERS_V01,
 			     ab->qmi.service_ins_id);
 	if (ret < 0) {
-		ath11k_warn(ab, "failed to add qmi lookup\n");
+		ath11k_warn(ab, "failed to add qmi lookup: %d\n", ret);
 		destroy_workqueue(ab->qmi.event_wq);
 		return ret;
 	}
-- 
2.7.4

