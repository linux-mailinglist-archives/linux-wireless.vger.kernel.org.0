Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285E16D54EC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 00:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjDCWwa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 18:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjDCWwW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 18:52:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B35F4EE3
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 15:52:05 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333L0GsS016232;
        Mon, 3 Apr 2023 22:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=UssclH3qjL40ATwClbjF2ax2zOar4qtJFx8nQ1+6+Ws=;
 b=fnqq0pVljPFdiPIKM4pmr4eKeJhSwveQZFg7e/CPVo8RYwqOoVQ0wCg5tIQUak35O2vD
 3SeYBwYkvxQLbg1D4KtuCU6O5xodnyYFAM2ASBID6I5+g+bTJZ1B2qtEcij64jT2lzrp
 77EBKCEDfNmfCiQXrsh9Lt57J08Kvyv3yvCMobumawqlMfct6j5QZk7lgQzsW+/cjJ4j
 cSKEQWPRH137buFnCTe/I3pPH55Lu+f0qq0+tqN6sioy1ZBeiUp1bvbn49gpgzxjGjtp
 +9VHcXmO+K9dQJVhOnw0ittNpsto6gHV5lWgxxJuz/NCpZGYqdinXnwVjLpGqS78pRKu kA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pr0kx14b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 22:51:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333MpwoJ032335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 22:51:58 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 15:51:57 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Muna Sinada <quic_msinada@quicinc.com>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 05/11] wifi: ath12k: add EHT PHY modes
Date:   Mon, 3 Apr 2023 15:51:40 -0700
Message-ID: <20230403225146.14139-6-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230403225146.14139-1-quic_alokad@quicinc.com>
References: <20230403225146.14139-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6Sem0iyJDeMYK6Ahy57KDaRP1C8wsk2A
X-Proofpoint-ORIG-GUID: 6Sem0iyJDeMYK6Ahy57KDaRP1C8wsk2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_17,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030180
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Muna Sinada <quic_msinada@quicinc.com>

Add support to retrieve and configure the phy modes supported
by the hardware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v2: Changed 'target' to 'hardware' in the description.

 drivers/net/wireless/ath/ath12k/mac.c | 98 +++++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/mac.h |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.h | 13 +++-
 3 files changed, 91 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7e6fc6b941e8..22e136617687 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -182,32 +182,35 @@ ath12k_phymodes[NUM_NL80211_BANDS][ATH12K_CHAN_WIDTH_NUM] = {
 	[NL80211_BAND_2GHZ] = {
 			[NL80211_CHAN_WIDTH_5] = MODE_UNKNOWN,
 			[NL80211_CHAN_WIDTH_10] = MODE_UNKNOWN,
-			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11AX_HE20_2G,
-			[NL80211_CHAN_WIDTH_20] = MODE_11AX_HE20_2G,
-			[NL80211_CHAN_WIDTH_40] = MODE_11AX_HE40_2G,
-			[NL80211_CHAN_WIDTH_80] = MODE_11AX_HE80_2G,
+			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11BE_EHT20_2G,
+			[NL80211_CHAN_WIDTH_20] = MODE_11BE_EHT20_2G,
+			[NL80211_CHAN_WIDTH_40] = MODE_11BE_EHT40_2G,
+			[NL80211_CHAN_WIDTH_80] = MODE_UNKNOWN,
 			[NL80211_CHAN_WIDTH_80P80] = MODE_UNKNOWN,
 			[NL80211_CHAN_WIDTH_160] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_320] = MODE_UNKNOWN,
 	},
 	[NL80211_BAND_5GHZ] = {
 			[NL80211_CHAN_WIDTH_5] = MODE_UNKNOWN,
 			[NL80211_CHAN_WIDTH_10] = MODE_UNKNOWN,
-			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11AX_HE20,
-			[NL80211_CHAN_WIDTH_20] = MODE_11AX_HE20,
-			[NL80211_CHAN_WIDTH_40] = MODE_11AX_HE40,
-			[NL80211_CHAN_WIDTH_80] = MODE_11AX_HE80,
-			[NL80211_CHAN_WIDTH_160] = MODE_11AX_HE160,
-			[NL80211_CHAN_WIDTH_80P80] = MODE_11AX_HE80_80,
+			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11BE_EHT20,
+			[NL80211_CHAN_WIDTH_20] = MODE_11BE_EHT20,
+			[NL80211_CHAN_WIDTH_40] = MODE_11BE_EHT40,
+			[NL80211_CHAN_WIDTH_80] = MODE_11BE_EHT80,
+			[NL80211_CHAN_WIDTH_160] = MODE_11BE_EHT160,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_11BE_EHT80_80,
+			[NL80211_CHAN_WIDTH_320] = MODE_11BE_EHT320,
 	},
 	[NL80211_BAND_6GHZ] = {
 			[NL80211_CHAN_WIDTH_5] = MODE_UNKNOWN,
 			[NL80211_CHAN_WIDTH_10] = MODE_UNKNOWN,
-			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11AX_HE20,
-			[NL80211_CHAN_WIDTH_20] = MODE_11AX_HE20,
-			[NL80211_CHAN_WIDTH_40] = MODE_11AX_HE40,
-			[NL80211_CHAN_WIDTH_80] = MODE_11AX_HE80,
-			[NL80211_CHAN_WIDTH_160] = MODE_11AX_HE160,
-			[NL80211_CHAN_WIDTH_80P80] = MODE_11AX_HE80_80,
+			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11BE_EHT20,
+			[NL80211_CHAN_WIDTH_20] = MODE_11BE_EHT20,
+			[NL80211_CHAN_WIDTH_40] = MODE_11BE_EHT40,
+			[NL80211_CHAN_WIDTH_80] = MODE_11BE_EHT80,
+			[NL80211_CHAN_WIDTH_160] = MODE_11BE_EHT160,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_11BE_EHT80_80,
+			[NL80211_CHAN_WIDTH_320] = MODE_11BE_EHT320,
 	},
 
 };
@@ -292,6 +295,24 @@ static const char *ath12k_mac_phymode_str(enum wmi_phy_mode mode)
 		return "11ax-he40-2g";
 	case MODE_11AX_HE80_2G:
 		return "11ax-he80-2g";
+	case MODE_11BE_EHT20:
+		return "11be-eht20";
+	case MODE_11BE_EHT40:
+		return "11be-eht40";
+	case MODE_11BE_EHT80:
+		return "11be-eht80";
+	case MODE_11BE_EHT80_80:
+		return "11be-eht80+80";
+	case MODE_11BE_EHT160:
+		return "11be-eht160";
+	case MODE_11BE_EHT160_160:
+		return "11be-eht160+160";
+	case MODE_11BE_EHT320:
+		return "11be-eht320";
+	case MODE_11BE_EHT20_2G:
+		return "11be-eht20-2g";
+	case MODE_11BE_EHT40_2G:
+		return "11be-eht40-2g";
 	case MODE_UNKNOWN:
 		/* skip */
 		break;
@@ -1926,6 +1947,38 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_he(struct ath12k *ar,
 	return MODE_UNKNOWN;
 }
 
+static enum wmi_phy_mode ath12k_mac_get_phymode_eht(struct ath12k *ar,
+						    struct ieee80211_sta *sta)
+{
+	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_320)
+		if (sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[0] &
+		    IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
+			return MODE_11BE_EHT320;
+	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160) {
+		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
+			return MODE_11BE_EHT160;
+
+		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+			 IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			return MODE_11BE_EHT80_80;
+
+		ath12k_warn(ar->ab, "invalid eht phy cap info for 160 Mhz\n");
+		return MODE_11BE_EHT160;
+	}
+
+	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
+		return MODE_11BE_EHT80;
+
+	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+		return MODE_11BE_EHT40;
+
+	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
+		return MODE_11BE_EHT20;
+
+	return MODE_UNKNOWN;
+}
+
 static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 					struct ieee80211_vif *vif,
 					struct ieee80211_sta *sta,
@@ -1947,7 +2000,12 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 
 	switch (band) {
 	case NL80211_BAND_2GHZ:
-		if (sta->deflink.he_cap.has_he) {
+		if (sta->deflink.eht_cap.has_eht) {
+			if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+				phymode = MODE_11BE_EHT40_2G;
+			else
+				phymode = MODE_11BE_EHT20_2G;
+		} else if (sta->deflink.he_cap.has_he) {
 			if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
 				phymode = MODE_11AX_HE80_2G;
 			else if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
@@ -1974,8 +2032,10 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 		break;
 	case NL80211_BAND_5GHZ:
 	case NL80211_BAND_6GHZ:
-		/* Check HE first */
-		if (sta->deflink.he_cap.has_he) {
+		/* Check EHT first */
+		if (sta->deflink.eht_cap.has_eht) {
+			phymode = ath12k_mac_get_phymode_eht(ar, sta);
+		} else if (sta->deflink.he_cap.has_he) {
 			phymode = ath12k_mac_get_phymode_he(ar, sta);
 		} else if (sta->deflink.vht_cap.vht_supported &&
 		    !ath12k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 57f4295420bb..7b16b70df4fa 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -33,7 +33,7 @@ struct ath12k_generic_iter {
 #define IEEE80211_VHT_MCS_SUPPORT_0_11_MASK	GENMASK(23, 16)
 #define IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11	BIT(24)
 
-#define ATH12K_CHAN_WIDTH_NUM			8
+#define ATH12K_CHAN_WIDTH_NUM			14
 
 #define ATH12K_TX_POWER_MAX_VAL	70
 #define ATH12K_TX_POWER_MIN_VAL	0
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index fa513a24bca4..65b52a8079cd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2792,8 +2792,17 @@ enum wmi_phy_mode {
 	MODE_11AX_HE20_2G = 21,
 	MODE_11AX_HE40_2G = 22,
 	MODE_11AX_HE80_2G = 23,
-	MODE_UNKNOWN = 24,
-	MODE_MAX = 24
+	MODE_11BE_EHT20 = 24,
+	MODE_11BE_EHT40 = 25,
+	MODE_11BE_EHT80 = 26,
+	MODE_11BE_EHT80_80 = 27,
+	MODE_11BE_EHT160 = 28,
+	MODE_11BE_EHT160_160 = 29,
+	MODE_11BE_EHT320 = 30,
+	MODE_11BE_EHT20_2G = 31,
+	MODE_11BE_EHT40_2G = 32,
+	MODE_UNKNOWN = 33,
+	MODE_MAX = 33,
 };
 
 struct wmi_vdev_start_req_arg {
-- 
2.39.0

