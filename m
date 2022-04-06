Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403F14F6183
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiDFOTZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiDFORh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 10:17:37 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187874AE2C;
        Wed,  6 Apr 2022 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649240477; x=1680776477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yxkJQ+xpKNZwscjI29k+dfTvsCbgs3FwKWMIeqijIEY=;
  b=wsRBgaJUgq2IkDg9pDWbgvyl5+1nIQeji34K8+5F/6Zxik6Gh4OD9q5t
   PIbCOI6Yp7ZKpn+e+lcHkmMMEM26f3ELLD62QM6C6ZEZgfcWwgNBYUdBZ
   UilRY1Z2ncpENXonaEFGQ1NPmZn5rs3rTs8JWi0WQ5DMSlBo+jGtdnSrq
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Apr 2022 02:41:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 02:41:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 02:41:41 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 02:41:39 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <mka@chromium.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v4 06/12] ath11k: Add QMI changes for WCN6750
Date:   Wed, 6 Apr 2022 15:11:00 +0530
Message-ID: <20220406094107.17878-7-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406094107.17878-1-quic_mpubbise@quicinc.com>
References: <20220406094107.17878-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/net/wireless/ath/ath11k/core.c |  7 +++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/qmi.c  | 76 ++++++++++++++++----------
 3 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 8695f999acb2..8602be029606 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -101,6 +101,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = false,
 		.dbr_debug_support = true,
 		.global_reset = false,
+		.fixed_fw_mem = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -167,6 +168,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = false,
 		.dbr_debug_support = true,
 		.global_reset = false,
+		.fixed_fw_mem = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -232,6 +234,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = true,
 		.dbr_debug_support = false,
 		.global_reset = true,
+		.fixed_fw_mem = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -297,6 +300,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = false,
 		.dbr_debug_support = true,
 		.global_reset = false,
+		.fixed_fw_mem = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -362,6 +366,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = true,
 		.dbr_debug_support = false,
 		.global_reset = true,
+		.fixed_fw_mem = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -426,6 +431,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = true,
 		.dbr_debug_support = false,
 		.global_reset = true,
+		.fixed_fw_mem = false,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -487,6 +493,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = true,
 		.dbr_debug_support = false,
 		.global_reset = false,
+		.fixed_fw_mem = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 08f958c03ec4..5fdb6894209e 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -195,6 +195,7 @@ struct ath11k_hw_params {
 	bool current_cc_support;
 	bool dbr_debug_support;
 	bool global_reset;
+	bool fixed_fw_mem;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index df49f8b68556..57804c152692 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1799,10 +1799,6 @@ static int ath11k_qmi_fw_ind_register_send(struct ath11k_base *ab)
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
@@ -1811,6 +1807,17 @@ static int ath11k_qmi_fw_ind_register_send(struct ath11k_base *ab)
 	req->pin_connect_result_enable_valid = 0;
 	req->pin_connect_result_enable = 0;
 
+	/* WCN6750 doesn't request for DDR memory via QMI,
+	 * instead it uses a fixed 12MB reserved memory
+	 * region in DDR.
+	 */
+	if (!ab->hw_params.fixed_fw_mem) {
+		req->request_mem_enable_valid = 1;
+		req->request_mem_enable = 1;
+		req->fw_mem_ready_enable_valid = 1;
+		req->fw_mem_ready_enable = 1;
+	}
+
 	ret = qmi_txn_init(handle, &txn,
 			   qmi_wlanfw_ind_register_resp_msg_v01_ei, resp);
 	if (ret < 0)
@@ -2839,27 +2846,6 @@ ath11k_qmi_driver_event_post(struct ath11k_qmi *qmi,
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
@@ -2901,9 +2887,33 @@ static int ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 		return ret;
 	}
 
-	ret = ath11k_qmi_wlanfw_m3_info_send(ab);
+	return 0;
+}
+
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
 	if (ret < 0) {
-		ath11k_warn(ab, "failed to send qmi m3 info req: %d\n", ret);
+		ath11k_warn(ab, "failed to send qmi host cap: %d\n", ret);
+		return ret;
+	}
+
+	if (!ab->hw_params.fixed_fw_mem)
+		return ret;
+
+	ret = ath11k_qmi_event_load_bdf(qmi);
+	if (ret < 0) {
+		ath11k_warn(ab, "qmi failed to download BDF:%d\n", ret);
 		return ret;
 	}
 
@@ -3103,8 +3113,18 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 			break;
 		case ATH11K_QMI_EVENT_FW_MEM_READY:
 			ret = ath11k_qmi_event_load_bdf(qmi);
-			if (ret < 0)
+			if (ret < 0) {
 				set_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
+				break;
+			}
+
+			ret = ath11k_qmi_wlanfw_m3_info_send(ab);
+			if (ret < 0) {
+				ath11k_warn(ab,
+					    "failed to send qmi m3 info req: %d\n", ret);
+				set_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
+			}
+
 			break;
 		case ATH11K_QMI_EVENT_FW_READY:
 			clear_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
-- 
2.35.1

