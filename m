Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F067595387
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 09:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiHPHNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 03:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiHPHN0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 03:13:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DFB18DCE1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 21:44:40 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G31pAX000356;
        Tue, 16 Aug 2022 04:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=zIA+fZqlZx/rjs6oujnUrA96RwP+POPHbLBSEiMs9a4=;
 b=obHcGeVsQAVFlBECDkMzD8gdNVNbT5GAuKrHsKBhYVDamUNLD3CwRxLyRKiwaTPliX6s
 wdI8SShBBpKLOEX5C7K5sYqgn39LwsxRtxDO7lc7bB1u6CYJRKyHGpgriTH0gWy+qOOY
 ulaDh8sD7acm4hT1hOBxUlPTbYqqzd54pdZ4R4uYgOJ5bEgpc3JuZouYRDF5hF7XIKq9
 dBZEnaec7qEpvE4A1nY3owU1ZXs/eEQSRdLY/XRccJuiHUjn+vc0g//yqWccRBgVQtwC
 D12AvgM5Y3lpghelvCULBJ6XLGIZoCiXyz+Kzgx7ZIZiNGShs4oYTAf6LF86Vz46lohI rQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j01w0rgw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 04:43:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27G4hi9r030434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 04:43:44 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 15 Aug 2022 21:43:42 -0700
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] wifi: ath10k: Delay the unmapping of the buffer
Date:   Tue, 16 Aug 2022 10:13:10 +0530
Message-ID: <20220816044310.19101-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0Gr-GHGiIYs_-16S31hyrVni7pGrLu4w
X-Proofpoint-GUID: 0Gr-GHGiIYs_-16S31hyrVni7pGrLu4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_03,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208160018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are seeing a corner case where host receiving copy completion for WMI
command though copy engine is processing it. Once host receives the
copy completion, host is unmapping corresponding memory which results
in SMMU fault. To avoid such conditions though host receives copy
completion, as a work around we are adding a delay to unmap the memory
for WMI end point.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1

Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 15 +++++++++++++++
 drivers/net/wireless/ath/ath10k/htc.c  |  8 ++++++++
 drivers/net/wireless/ath/ath10k/hw.h   |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index d1ac64026cb3..c2fda8deb9ef 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -99,6 +99,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA988X_HW_2_0_VERSION,
@@ -138,6 +139,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9887_HW_1_0_VERSION,
@@ -178,6 +180,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -252,6 +255,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -291,6 +295,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA6174_HW_3_0_VERSION,
@@ -330,6 +335,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -373,6 +379,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = true,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
@@ -418,6 +425,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9984_HW_1_0_DEV_VERSION,
@@ -470,6 +478,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9888_HW_2_0_DEV_VERSION,
@@ -519,6 +528,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9377_HW_1_0_DEV_VERSION,
@@ -558,6 +568,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -599,6 +610,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -631,6 +643,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA4019_HW_1_0_DEV_VERSION,
@@ -677,6 +690,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = WCN3990_HW_1_0_DEV_VERSION,
@@ -709,6 +723,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.dynamic_sar_support = true,
 		.hw_restart_disconnect = true,
 		.use_fw_tx_credits = false,
+		.delay_unmap_buffer = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index 6d1784f74bea..e04b9545cca6 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -56,6 +56,14 @@ void ath10k_htc_notify_tx_completion(struct ath10k_htc_ep *ep,
 	ath10k_dbg(ar, ATH10K_DBG_HTC, "%s: ep %d skb %pK\n", __func__,
 		   ep->eid, skb);
 
+	/* A corner case where the copy completion is reaching to host but still
+	 * copy engine is processing it due to which host unmaps corresponding
+	 * memory and causes SMMU fault, hence as workaround adding delay
+	 * the unmapping memory to avoid SMMU faults.
+	 */
+	if (ar->hw_params.delay_unmap_buffer &&
+	    ep->ul_pipe_id == 3)
+		mdelay(2);
 	hdr = (struct ath10k_htc_hdr *)skb->data;
 	ath10k_htc_restore_tx_skb(ep->htc, skb);
 
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 1b99f3a39a11..9643031a4427 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -637,6 +637,8 @@ struct ath10k_hw_params {
 	bool hw_restart_disconnect;
 
 	bool use_fw_tx_credits;
+
+	bool delay_unmap_buffer;
 };
 
 struct htt_resp;
-- 
2.37.0

