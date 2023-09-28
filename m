Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6B7B1235
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 07:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjI1FvA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 01:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjI1Fuz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 01:50:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD71126
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 22:50:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S5onPk003305;
        Thu, 28 Sep 2023 05:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=D03hRpRX5IeSBgk0xJmW6yevmR4UCPHbT5CRQlGHwrg=;
 b=j3zRRSjZnDhLen2ueNBoeWE0WfWD0oG5XpEQcKrdA21IWOeh4GSwILUtUlxI0F5V+4LE
 Wt9YqIsYwGoefv5jh4jsUA4NuRWX02zLGWaQ3hmncgdL9VboI8MyvFSYVlbJpYh73oXM
 UtsDZwr2f1xhPxqCorKmyn8L0RZPpS1YLCpqiDOBVY2MEyKwQ+wbDpb/FUH+mGF6wvyn
 rt6Qxfc6X+Y9gzVHU9r671SPotj0qAskle9Jj7hG2+IlMkztCsL1rxt1BJamFyWUJFDt
 lnzH4TXeoUublCWYABY/OqER+CX+xqNAVBhYPoUk1Z+9XdlArTBiY6bc7SC55tSo+cUr 5w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td3gg80my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:50:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S5om1e027976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:50:48 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 27 Sep 2023 22:50:47 -0700
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 4/4] wifi: ath12k: dynamically update puncturing bitmap
Date:   Thu, 28 Sep 2023 13:50:22 +0800
Message-ID: <20230928055022.9670-5-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928055022.9670-1-quic_kangyang@quicinc.com>
References: <20230928055022.9670-1-quic_kangyang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xgnoPzID2c9d9aO9KbTj__9nwCeihVZw
X-Proofpoint-ORIG-GUID: xgnoPzID2c9d9aO9KbTj__9nwCeihVZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_03,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309280048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Every time EHT Operation element changed, mac80211 will parse it and
extract the valid puncturing bitmap according to the negotiated bandwidth.

So add updates of bandwidth and puncturing bitmap in ath12k. Then
process and send them to the firmware by WMI event.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 50 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 17 +++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 85602d64b607..24968ef02978 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2486,6 +2486,32 @@ static int ath12k_mac_fils_discovery(struct ath12k_vif *arvif,
 	return ret;
 }
 
+static enum wmi_channel_width
+ath12k_mac_nlwidth_to_wmiwidth(enum nl80211_chan_width width)
+{
+	switch (width) {
+	case NL80211_CHAN_WIDTH_20:
+		return WMI_CHAN_WIDTH_20;
+	case NL80211_CHAN_WIDTH_40:
+		return WMI_CHAN_WIDTH_40;
+	case NL80211_CHAN_WIDTH_80:
+		return WMI_CHAN_WIDTH_80;
+	case NL80211_CHAN_WIDTH_160:
+		return WMI_CHAN_WIDTH_160;
+	case NL80211_CHAN_WIDTH_80P80:
+		return WMI_CHAN_WIDTH_80P80;
+	case NL80211_CHAN_WIDTH_5:
+		return WMI_CHAN_WIDTH_5;
+	case NL80211_CHAN_WIDTH_10:
+		return WMI_CHAN_WIDTH_10;
+	case NL80211_CHAN_WIDTH_320:
+		return WMI_CHAN_WIDTH_320;
+	default:
+		WARN_ON(1);
+		return WMI_CHAN_WIDTH_20;
+	}
+}
+
 static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
 					   struct ieee80211_bss_conf *info,
@@ -2507,6 +2533,27 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	mutex_lock(&ar->conf_mutex);
 
+	if (changed & BSS_CHANGED_EHT_PUNCTURING) {
+		param_id = WMI_PEER_CHWIDTH_PUNCTURE_20MHZ_BITMAP;
+		param_value = ath12k_mac_nlwidth_to_wmiwidth(info->chandef.width) |
+			      u32_encode_bits((~info->eht_puncturing),
+					      WMI_PEER_PUNCTURE_BITMAP);
+
+		ret = ath12k_wmi_set_peer_param(ar, arvif->bssid,
+						arvif->vdev_id, param_id,
+						param_value);
+		if (ret)
+			ath12k_warn(ar->ab,
+				    "Failed to set puncturing bitmap %04x "
+				    "and bandwidth %d for VDEV: %d\n",
+				    info->eht_puncturing, info->chandef.width,
+				    arvif->vdev_id);
+		else
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+				   "Set puncturing bitmap %04x and and bandwidth %d for VDEV: %d\n",
+				   info->eht_puncturing, info->chandef.width, arvif->vdev_id);
+	}
+
 	if (changed & BSS_CHANGED_BEACON_INT) {
 		arvif->beacon_interval = info->beacon_int;
 
@@ -3725,6 +3772,9 @@ static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
 	case IEEE80211_STA_RX_BW_160:
 		bw = WMI_PEER_CHWIDTH_160MHZ;
 		break;
+	case IEEE80211_STA_RX_BW_320:
+		bw = WMI_PEER_CHWIDTH_320MHZ;
+		break;
 	default:
 		ath12k_warn(ar->ab, "Invalid bandwidth %d in rc update for %pM\n",
 			    sta->deflink.bandwidth, sta->addr);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c75a6fa1f7e0..55ef3443fcc5 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2194,8 +2194,11 @@ enum wmi_peer_param {
 	WMI_PEER_SET_MAX_TX_RATE = 17,
 	WMI_PEER_SET_MIN_TX_RATE = 18,
 	WMI_PEER_SET_DEFAULT_ROUTING = 19,
+	WMI_PEER_CHWIDTH_PUNCTURE_20MHZ_BITMAP = 39,
 };
 
+#define WMI_PEER_PUNCTURE_BITMAP		GENMASK(23, 8)
+
 enum wmi_slot_time {
 	WMI_VDEV_SLOT_TIME_LONG = 1,
 	WMI_VDEV_SLOT_TIME_SHORT = 2,
@@ -2217,6 +2220,7 @@ enum wmi_peer_chwidth {
 	WMI_PEER_CHWIDTH_40MHZ = 1,
 	WMI_PEER_CHWIDTH_80MHZ = 2,
 	WMI_PEER_CHWIDTH_160MHZ = 3,
+	WMI_PEER_CHWIDTH_320MHZ = 4,
 };
 
 enum wmi_beacon_gen_mode {
@@ -2265,6 +2269,19 @@ struct ath12k_wmi_hal_reg_capabilities_ext_arg {
 	u32 high_5ghz_chan;
 };
 
+enum wmi_channel_width {
+	WMI_CHAN_WIDTH_20 = 0,
+	WMI_CHAN_WIDTH_40 = 1,
+	WMI_CHAN_WIDTH_80 = 2,
+	WMI_CHAN_WIDTH_160 = 3,
+	WMI_CHAN_WIDTH_80P80 = 4,
+	WMI_CHAN_WIDTH_5 = 5,
+	WMI_CHAN_WIDTH_10 = 6,
+	WMI_CHAN_WIDTH_165 = 7,
+	WMI_CHAN_WIDTH_160P160 = 8,
+	WMI_CHAN_WIDTH_320 = 9,
+};
+
 #define WMI_HOST_MAX_PDEV 3
 
 struct ath12k_wmi_host_mem_chunk_params {
-- 
2.34.1

