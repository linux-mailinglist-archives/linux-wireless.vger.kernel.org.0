Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2515A9198
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 10:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiIAIGt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 04:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiIAIGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 04:06:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016F5120F99
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 01:06:43 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2813R7UW005091;
        Thu, 1 Sep 2022 08:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=mOVwm7If+w9hSE4K9qkzYm5+W6+ZStSESsvtphjo1vU=;
 b=fiPbdNwnJ0xJXB9tk6E/pupQWf+HQU5iwR50gyqW+KoBkVjoZ/pBvpwHFC03J053nPjc
 1MW2c90qZoTO89x9r8k0ILfhQ8iIGyo/LlnZIx5l1E40HaAuWte8u0+FNM5gUck2Wy8Z
 NXQJybyz8rZR5pPbXQD4YCxTb3HbfbPnUWdNlMEm0UZvhToBbscH+pw21q4JqoH9tfd+
 CzXngHVh50z4TnSCWQJRG3rcOY7wridKZo1bcJwV7T9H+5n+58/ZQ+kMBF1jcN/EYftA
 H7LZ7/mxJGXodr++F8beChcKJ2K3vhQCw5puaighJf9hG6lVQ/795mVRun9gF9jsTwyJ 4Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j9txbnb56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 08:06:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28186diD029140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 08:06:39 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 01:06:37 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2] ath11k: Add support to connect to non-transmit MBSSID profiles
Date:   Thu, 1 Sep 2022 13:36:16 +0530
Message-ID: <20220901080616.29414-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _X7yUeafIKJPD_aP7TnDgADm5NQCUOCt
X-Proofpoint-ORIG-GUID: _X7yUeafIKJPD_aP7TnDgADm5NQCUOCt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_05,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to connect to a non-transmit MBSSID AP profile.

Non-transmit MBSSID profile parameters are passed to the firmware
via WMI VDEV UP command and this helps firmware to track MBSSID
profile within the multi-BSS beacon and report beacon loss if
any.

WCN6750, QCA6390 & WCN6855 firmwares have the support and hence
enable the support on these hardwares.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
V2:
- Rebased on ToT

 drivers/net/wireless/ath/ath11k/core.c |  7 +++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  |  5 +++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 15 +++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c3e9e4f7bc24..00f2907587b1 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -106,6 +106,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.supports_multi_bssid = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -177,6 +178,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.supports_multi_bssid = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -247,6 +249,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.supports_multi_bssid = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -317,6 +320,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.supports_multi_bssid = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -387,6 +391,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.supports_multi_bssid = true,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -456,6 +461,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.supports_multi_bssid = true,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -525,6 +531,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = true,
 		.fixed_fw_mem = true,
 		.support_off_channel_tx = false,
+		.supports_multi_bssid = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index bb5ac940e470..0b5cce09d7b2 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -200,6 +200,7 @@ struct ath11k_hw_params {
 	bool hybrid_bus_type;
 	bool fixed_fw_mem;
 	bool support_off_channel_tx;
+	bool supports_multi_bssid;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7e91e347c9ff..3828286ea841 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8777,6 +8777,11 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	if (ab->hw_params.single_pdev_only && ar->supports_6ghz)
 		ieee80211_hw_set(ar->hw, SINGLE_SCAN_ON_ALL_BANDS);
 
+	if (ab->hw_params.supports_multi_bssid) {
+		ieee80211_hw_set(ar->hw, SUPPORTS_MULTI_BSSID);
+		ieee80211_hw_set(ar->hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
+	}
+
 	ieee80211_hw_set(ar->hw, SIGNAL_DBM);
 	ieee80211_hw_set(ar->hw, SUPPORTS_PS);
 	ieee80211_hw_set(ar->hw, SUPPORTS_DYNAMIC_PS);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 88ee4f9d19da..244996eec699 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -991,9 +991,13 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_vdev_up_cmd *cmd;
+	struct ieee80211_bss_conf *bss_conf;
+	struct ath11k_vif *arvif;
 	struct sk_buff *skb;
 	int ret;
 
+	arvif = ath11k_mac_get_arvif(ar, vdev_id);
+
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
@@ -1007,6 +1011,17 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	ether_addr_copy(cmd->vdev_bssid.addr, bssid);
 
+	if (arvif && arvif->vif->type == NL80211_IFTYPE_STATION) {
+		bss_conf = &arvif->vif->bss_conf;
+
+		if (bss_conf->nontransmitted) {
+			ether_addr_copy(cmd->trans_bssid.addr,
+					bss_conf->transmitter_bssid);
+			cmd->profile_idx = bss_conf->bssid_index;
+			cmd->profile_num = bss_conf->bssid_indicator;
+		}
+	}
+
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_VDEV_UP_CMDID);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to submit WMI_VDEV_UP cmd\n");

base-commit: 16424e934b2e83faa81bb7709e13be4b809d35fe
-- 
2.37.1

