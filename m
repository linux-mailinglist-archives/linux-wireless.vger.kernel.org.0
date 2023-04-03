Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48CA6D54EB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 00:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjDCWw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 18:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjDCWwW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 18:52:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE134EEA
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 15:52:05 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333LGNYd020916;
        Mon, 3 Apr 2023 22:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=GIMtd7701M7IqRyjVymHOJeod8j1STP+f9hPniWJie4=;
 b=JsmT2BA6coeD90M+jutpIwQe9y1Nwv/X1qzsh6KnIsoxakKQLib79mB5JHN70iqABwjc
 22XqqWqQh9OkGnCD2wyHqPeSKmAyBzd3Qs4AblsX6Zc67pnkX3dibnzAVIxBVku4R/Ef
 Xbs6LF1pUAqgXyLu5zF5Nb0KdJAk7+RPl2eUxH3y6rTc75xqW2hdcQUfz/dfhaMIYV1S
 NjR7V41gJux0fdUz5tyjYgQ0vR8rmrsyO57YHUnasZLgAmWVPiZgaGLn0cSH3PElPM3g
 U21a53MzKlfIrZ3vChkO/gt5PWs9yTSW835t4XAYXe/44j9BeLpZfuITrs7yWKv4DkVU Kw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pquwwsur0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 22:51:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333MpujM031898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 22:51:56 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 15:51:56 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 02/11] wifi: ath12k: move HE capabilities processing to a new function
Date:   Mon, 3 Apr 2023 15:51:37 -0700
Message-ID: <20230403225146.14139-3-quic_alokad@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ODcl9nAjhs5WacCPKfk-7YROMvmXR--T
X-Proofpoint-GUID: ODcl9nAjhs5WacCPKfk-7YROMvmXR--T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_17,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030180
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function ath12k_mac_copy_sband_iftype_data() is currently
used HE capabilities propagation but it can be extended to
include EHT data. Move the HE specific functionality from to
ath12k_mac_copy_he_cap() to make EHT additions easier.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/mac.c | 111 +++++++++++++-------------
 1 file changed, 55 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ab718585411e..e5ba7a01d571 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4206,18 +4206,69 @@ static __le16 ath12k_mac_setup_he_6ghz_cap(struct ath12k_pdev_cap *pcap,
 	return cpu_to_le16(bcap->he_6ghz_capa);
 }
 
+static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
+				   int iftype, u8 num_tx_chains,
+				   struct ieee80211_sta_he_cap *he_cap)
+{
+	struct ieee80211_he_cap_elem *he_cap_elem = &he_cap->he_cap_elem;
+	struct ieee80211_he_mcs_nss_supp *mcs_nss = &he_cap->he_mcs_nss_supp;
+
+	he_cap->has_he = true;
+	memcpy(he_cap_elem->mac_cap_info, band_cap->he_cap_info,
+	       sizeof(he_cap_elem->mac_cap_info));
+	memcpy(he_cap_elem->phy_cap_info, band_cap->he_cap_phy_info,
+	       sizeof(he_cap_elem->phy_cap_info));
+
+	he_cap_elem->mac_cap_info[1] &=
+		IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
+
+	he_cap_elem->phy_cap_info[5] &=
+		~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK;
+	he_cap_elem->phy_cap_info[5] &=
+		~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK;
+	he_cap_elem->phy_cap_info[5] |= num_tx_chains - 1;
+
+	switch (iftype) {
+	case NL80211_IFTYPE_AP:
+		he_cap_elem->phy_cap_info[3] &=
+			~IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_MASK;
+		he_cap_elem->phy_cap_info[9] |=
+			IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+		break;
+	case NL80211_IFTYPE_STATION:
+		he_cap_elem->mac_cap_info[0] &= ~IEEE80211_HE_MAC_CAP0_TWT_RES;
+		he_cap_elem->mac_cap_info[0] |= IEEE80211_HE_MAC_CAP0_TWT_REQ;
+		he_cap_elem->phy_cap_info[9] |=
+			IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
+		break;
+	case NL80211_IFTYPE_MESH_POINT:
+		ath12k_mac_filter_he_cap_mesh(he_cap_elem);
+		break;
+	}
+
+	mcs_nss->rx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
+	mcs_nss->tx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
+	mcs_nss->rx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+	mcs_nss->tx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+	mcs_nss->rx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+	mcs_nss->tx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+
+	memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
+	if (he_cap_elem->phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
+		ath12k_gen_ppe_thresh(&band_cap->he_ppet, he_cap->ppe_thres);
+}
+
 static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
 					     struct ath12k_pdev_cap *cap,
 					     struct ieee80211_sband_iftype_data *data,
 					     int band)
 {
+	struct ath12k_band_cap *band_cap = &cap->band[band];
 	int i, idx = 0;
 
 	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
 		struct ieee80211_sta_he_cap *he_cap = &data[idx].he_cap;
-		struct ath12k_band_cap *band_cap = &cap->band[band];
-		struct ieee80211_he_cap_elem *he_cap_elem =
-				&he_cap->he_cap_elem;
 
 		switch (i) {
 		case NL80211_IFTYPE_STATION:
@@ -4230,60 +4281,8 @@ static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
 		}
 
 		data[idx].types_mask = BIT(i);
-		he_cap->has_he = true;
-		memcpy(he_cap_elem->mac_cap_info, band_cap->he_cap_info,
-		       sizeof(he_cap_elem->mac_cap_info));
-		memcpy(he_cap_elem->phy_cap_info, band_cap->he_cap_phy_info,
-		       sizeof(he_cap_elem->phy_cap_info));
-
-		he_cap_elem->mac_cap_info[1] &=
-			IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
-
-		he_cap_elem->phy_cap_info[5] &=
-			~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK;
-		he_cap_elem->phy_cap_info[5] &=
-			~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK;
-		he_cap_elem->phy_cap_info[5] |= ar->num_tx_chains - 1;
-
-		switch (i) {
-		case NL80211_IFTYPE_AP:
-			he_cap_elem->phy_cap_info[3] &=
-				~IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_MASK;
-			he_cap_elem->phy_cap_info[9] |=
-				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
-			break;
-		case NL80211_IFTYPE_STATION:
-			he_cap_elem->mac_cap_info[0] &=
-				~IEEE80211_HE_MAC_CAP0_TWT_RES;
-			he_cap_elem->mac_cap_info[0] |=
-				IEEE80211_HE_MAC_CAP0_TWT_REQ;
-			he_cap_elem->phy_cap_info[9] |=
-				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
-			break;
-		case NL80211_IFTYPE_MESH_POINT:
-			ath12k_mac_filter_he_cap_mesh(he_cap_elem);
-			break;
-		}
-
-		he_cap->he_mcs_nss_supp.rx_mcs_80 =
-			cpu_to_le16(band_cap->he_mcs & 0xffff);
-		he_cap->he_mcs_nss_supp.tx_mcs_80 =
-			cpu_to_le16(band_cap->he_mcs & 0xffff);
-		he_cap->he_mcs_nss_supp.rx_mcs_160 =
-			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-		he_cap->he_mcs_nss_supp.tx_mcs_160 =
-			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-		he_cap->he_mcs_nss_supp.rx_mcs_80p80 =
-			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-		he_cap->he_mcs_nss_supp.tx_mcs_80p80 =
-			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-
-		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
-		if (he_cap_elem->phy_cap_info[6] &
-		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
-			ath12k_gen_ppe_thresh(&band_cap->he_ppet,
-					      he_cap->ppe_thres);
 
+		ath12k_mac_copy_he_cap(band_cap, i, ar->num_tx_chains, he_cap);
 		if (band == NL80211_BAND_6GHZ) {
 			data[idx].he_6ghz_capa.capa =
 				ath12k_mac_setup_he_6ghz_cap(cap, band_cap);
-- 
2.39.0

