Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CCF651A13
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 05:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiLTEpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 23:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiLTEpg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 23:45:36 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE6513DD6
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 20:45:35 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK2XkYo001989;
        Tue, 20 Dec 2022 04:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=eyaRlWh64pdyOs/RgZYtOLxNNIgrxZZn927yBG+2lXM=;
 b=l2h2CBPMZ9skwyebmuwDj+rvRE9l4Mpvtt/PxlVTyBjdZpdmcb3Sbr0GjrqjIW7pGqTj
 /sFXL3b2ZraWR2ycH4OMiA7yaPpQsXk2pVzLe505RPSebppfMZVdKMQM7q6B74jPPWSE
 IeWpfrx5/78kCWxR+mGBItMXHZqEV8EK/er4MQr5s4uTrWkZNPi4QZGjeD/t+dhfjSwV
 J3MiHl8k/MQqyPV4oNis9pYNTKaMpoap1kX7JotxyE9fh7SfJHEwgwZRZsgB9uPeznqR
 KNiK7Cxz9vh5BTRZ4akwghGKKAjWLhbo0t+FFN9RQBe8fIBHqcfuS6hkRTMKJbjDN9Po KQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh72gdnbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 04:45:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BK4jT5K012293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 04:45:29 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 20:45:27 -0800
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH] wifi: ath11k: Add support to configure FTM responder role
Date:   Tue, 20 Dec 2022 10:14:35 +0530
Message-ID: <20221220044435.10506-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rngxt95eTtt8K-K_CeCuNiWrpo8V2Nzx
X-Proofpoint-ORIG-GUID: Rngxt95eTtt8K-K_CeCuNiWrpo8V2Nzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200040
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Fine Timing Measurement(FTM) support is used to measure round trip
time between two nodes.

Enable FTM responder feature using hw_params on supported device.
Since FTM functionality is offloaded to firmware, adding the
interface allows user space to enable or disable FTM responder.
Also add support for advertising the same in extended capabilities.

QCA6390, WCN6855 and WCN6750 do not support this feature.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  8 ++++++++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 20 +++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  |  1 +
 5 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 809f47e6f90f..706dc86fe25c 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -116,6 +116,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tcl_ring_retry = true,
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
+		.ftm_responder = true,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -198,6 +199,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
+		.ftm_responder = true,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -282,6 +284,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
+		.ftm_responder = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -363,6 +366,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
+		.ftm_responder = true,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -447,6 +451,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
+		.ftm_responder = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -529,6 +534,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
+		.ftm_responder = false,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -609,6 +615,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE_WCN6750,
 		.smp2p_wow_exit = true,
 		.support_fw_mac_sequence = true,
+		.ftm_responder = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ5018_HW10,
@@ -688,6 +695,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
+		.ftm_responder = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index beb552108ac3..b01c806ffa23 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -346,6 +346,7 @@ struct ath11k_vif {
 
 	bool is_started;
 	bool is_up;
+	bool ftm_responder;
 	bool spectral_enabled;
 	bool ps;
 	u32 aid;
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 9f45d061d826..0be4e1232384 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -224,6 +224,7 @@ struct ath11k_hw_params {
 	u32 tx_ring_size;
 	bool smp2p_wow_exit;
 	bool support_fw_mac_sequence;
+	bool ftm_responder;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b198edba76eb..767a2a39ad6a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3110,7 +3110,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	u16 bitrate;
 	int ret = 0;
 	u8 rateidx;
-	u32 rate;
+	u32 rate, param;
 	u32 ipv4_cnt;
 
 	mutex_lock(&ar->conf_mutex);
@@ -3412,6 +3412,20 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (changed & BSS_CHANGED_FTM_RESPONDER &&
+	    arvif->ftm_responder != info->ftm_responder &&
+	    ar->ab->hw_params.ftm_responder &&
+	    (vif->type == NL80211_IFTYPE_AP ||
+	     vif->type == NL80211_IFTYPE_MESH_POINT)) {
+		arvif->ftm_responder = info->ftm_responder;
+		param = WMI_VDEV_PARAM_ENABLE_DISABLE_RTT_RESPONDER_ROLE;
+		ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, param,
+						    arvif->ftm_responder);
+		if (ret)
+			ath11k_warn(ar->ab, "Failed to set ftm responder %i: %d\n",
+				    arvif->vdev_id, ret);
+	}
+
 	if (changed & BSS_CHANGED_FILS_DISCOVERY ||
 	    changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP)
 		ath11k_mac_fils_discovery(arvif, info);
@@ -9113,6 +9127,10 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	wiphy_ext_feature_set(ar->hw->wiphy,
 			      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
 
+	if (ab->hw_params.ftm_responder)
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_ENABLE_FTM_RESPONDER);
+
 	ath11k_reg_init(ar);
 
 	if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8f2c07d70a4a..0a045af5419b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1073,6 +1073,7 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_ENABLE_BCAST_PROBE_RESPONSE,
 	WMI_VDEV_PARAM_FILS_MAX_CHANNEL_GUARD_TIME,
 	WMI_VDEV_PARAM_HE_LTF = 0x74,
+	WMI_VDEV_PARAM_ENABLE_DISABLE_RTT_RESPONDER_ROLE = 0x7d,
 	WMI_VDEV_PARAM_BA_MODE = 0x7e,
 	WMI_VDEV_PARAM_AUTORATE_MISC_CFG = 0x80,
 	WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE = 0x87,
-- 
2.17.1

