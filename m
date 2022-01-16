Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784DB48FCEC
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiAPMsA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:48:00 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:5741 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiAPMr5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642337277; x=1673873277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OB8Gxu/LvByKNVL6bA4RBQ5kiPk7ZJzQsiCx8l69an0=;
  b=HCXBE1qCEY5LJyC3lan46dUkC6WMrKO1JT3cNU4+phcvX5N4H+DbDH6L
   5mkUHDNzmhHwScjmtpSLBSzwIaphlL7Cp27suA/s+hflIS/C990dqOZWG
   mRP2Kh+MclouoXIobVV0+pZk2BmbQ/+FyM9Benl+tdI//YXyYOb01KLBC
   M=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 04:47:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 04:47:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:47:56 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:47:53 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 10/19] ath11k: Add QMI changes for WCN6750
Date:   Sun, 16 Jan 2022 18:17:06 +0530
Message-ID: <1642337235-8618-11-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the case of WCN6750, FW doesn't request for DDR memory
via QMI, instead it uses a fixed 12MB reserved Memory region
in the DDR which is called as MSA region. As a result, QMI
message sequence is not same as other ath11k supported devices.

Also, M3 firmware will be bundled into the FW and will be
downloaded to the target as part of Q6 boot.

This is the QMI flow in the case of WCN6750,

1) QMI firmware indication REQ/RESP
2) QMI host capability REQ/RESP
3) QMI target capability REQ/RESP
4) QMI device info REQ/RESP
5) QMI BDF download
6) QMI FW ready

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 73 +++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index ee59cb9..4745ff9 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1793,10 +1793,6 @@ static int ath11k_qmi_fw_ind_register_send(struct ath11k_base *ab)
 	req->client_id = QMI_WLANFW_CLIENT_ID;
 	req->fw_ready_enable_valid = 1;
 	req->fw_ready_enable = 1;
-	req->request_mem_enable_valid = 1;
-	req->request_mem_enable = 1;
-	req->fw_mem_ready_enable_valid = 1;
-	req->fw_mem_ready_enable = 1;
 	req->cal_done_enable_valid = 1;
 	req->cal_done_enable = 1;
 	req->fw_init_done_enable_valid = 1;
@@ -1805,6 +1801,17 @@ static int ath11k_qmi_fw_ind_register_send(struct ath11k_base *ab)
 	req->pin_connect_result_enable_valid = 0;
 	req->pin_connect_result_enable = 0;
 
+	/* WCN6750 doesn't request for DDR memory via QMI,
+	 * instead it uses a fixed 12MB reserved memory
+	 * region in DDR.
+	 */
+	if (!ab->bus_params.hybrid_bus_type) {
+		req->request_mem_enable_valid = 1;
+		req->request_mem_enable = 1;
+		req->fw_mem_ready_enable_valid = 1;
+		req->fw_mem_ready_enable = 1;
+	}
+
 	ret = qmi_txn_init(handle, &txn,
 			   qmi_wlanfw_ind_register_resp_msg_v01_ei, resp);
 	if (ret < 0)
@@ -2490,6 +2497,13 @@ static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
 	struct qmi_txn txn;
 	int ret = 0;
 
+	/* In the case of WCN6750, M3 is bundled into the FW
+	 * binary, and will be downloaded as part of Q6 boot.
+	 */
+	if (!ab->bus_params.m3_fw_support &&
+	    ab->bus_params.hybrid_bus_type)
+		return 0;
+
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
 
@@ -2821,27 +2835,6 @@ ath11k_qmi_driver_event_post(struct ath11k_qmi *qmi,
 	return 0;
 }
 
-static int ath11k_qmi_event_server_arrive(struct ath11k_qmi *qmi)
-{
-	struct ath11k_base *ab = qmi->ab;
-	int ret;
-
-	ret = ath11k_qmi_fw_ind_register_send(ab);
-	if (ret < 0) {
-		ath11k_warn(ab, "failed to send qmi firmware indication: %d\n",
-			    ret);
-		return ret;
-	}
-
-	ret = ath11k_qmi_host_cap_send(ab);
-	if (ret < 0) {
-		ath11k_warn(ab, "failed to send qmi host cap: %d\n", ret);
-		return ret;
-	}
-
-	return ret;
-}
-
 static int ath11k_qmi_event_mem_request(struct ath11k_qmi *qmi)
 {
 	struct ath11k_base *ab = qmi->ab;
@@ -2892,6 +2885,36 @@ static int ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 	return ret;
 }
 
+static int ath11k_qmi_event_server_arrive(struct ath11k_qmi *qmi)
+{
+	struct ath11k_base *ab = qmi->ab;
+	int ret;
+
+	ret = ath11k_qmi_fw_ind_register_send(ab);
+	if (ret < 0) {
+		ath11k_warn(ab, "failed to send qmi firmware indication: %d\n",
+			    ret);
+		return ret;
+	}
+
+	ret = ath11k_qmi_host_cap_send(ab);
+	if (ret < 0) {
+		ath11k_warn(ab, "failed to send qmi host cap: %d\n", ret);
+		return ret;
+	}
+
+	if (!ab->bus_params.hybrid_bus_type)
+		return ret;
+
+	ret = ath11k_qmi_event_load_bdf(qmi);
+	if (ret < 0) {
+		ath11k_warn(ab, "qmi failed to download BDF:%d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 					  struct sockaddr_qrtr *sq,
 					  struct qmi_txn *txn,
-- 
2.7.4

