Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975936FDB3A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 12:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjEJKDP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjEJKDN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 06:03:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C65659D
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 03:03:12 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A9xoU3005149;
        Wed, 10 May 2023 10:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4bgASQcPvC1E7cReDcE2RMo87sKVC/FXDjSoeGyfoa0=;
 b=jNW8H3+agrpiIjZcSAMb3Msn3zIs9cal9JKRzW8d/agFKDmYA+X1gBlqeMeWBNKwVeak
 e/jdBiiAqklE4P6PZgxw7y5tBQu2RJt231wn9y1QQOi/ML4aMyJkLxXb/OZ/PXIg5Cy1
 qJKTFNO8wNwuJGkYhuXeTPS+dBWWzkSuKrw9XI+tjMx5NabDcGQC3jJwTNapfk9WG3eU
 83tuQ8sD8ScfquXoE8g//FEXtMvfgp/kCPWwqhmfz+P+/ibNMpFBr3x//uRU0V4nZiPJ
 /jyNvPann3UfUNnaP2+buNnmpme9E1k4gx3eSm5k/LjMoFQAAWbkKcAClrbQl2L8fIK0 RA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfrut9v4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 10:03:05 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AA34KE022460
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 10:03:04 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 03:03:02 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH v2 2/2] ath11k: Send HT fixed rate in WMI peer fixed param
Date:   Wed, 10 May 2023 15:32:42 +0530
Message-ID: <20230510100242.1241752-3-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510100242.1241752-1-quic_mkenna@quicinc.com>
References: <20230510100242.1241752-1-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WBBoHuvXvDv9LenRoWmzMKeNGS2zgmfu
X-Proofpoint-ORIG-GUID: WBBoHuvXvDv9LenRoWmzMKeNGS2zgmfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Due to the firmware behavior with HT fixed rate setting,
HT fixed rate MCS with NSS > 1 are treated as NSS = 1
HT rates in the firmware and enables the HT fixed rate of
NSS = 1.

This leads to HT fixed rate is always configured for NSS = 1
even though the user sets NSS = 2 or > 1 HT fixed MCS in the
set bitrate command.

Currently HT fixed MCS is sent via WMI peer assoc command.
Fix this issue, by sending the HT fixed rate MCS in WMI peer
fixed param instead of sending in peer assoc command.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 63 ++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 33620a7a444b..c947d1c8d8c1 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4480,6 +4480,54 @@ ath11k_mac_set_peer_he_fixed_rate(struct ath11k_vif *arvif,
 	return ret;
 }
 
+static int
+ath11k_mac_set_peer_ht_fixed_rate(struct ath11k_vif *arvif,
+				  struct ieee80211_sta *sta,
+				  const struct cfg80211_bitrate_mask *mask,
+				  enum nl80211_band band)
+{
+	struct ath11k *ar = arvif->ar;
+	u8 ht_rate, nss = 0;
+	u32 rate_code;
+	int ret, i;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++) {
+		if (hweight8(mask->control[band].ht_mcs[i]) == 1) {
+			nss = i + 1;
+			ht_rate = ffs(mask->control[band].ht_mcs[i]) - 1;
+		}
+	}
+
+	if (!nss) {
+		ath11k_warn(ar->ab, "No single HT Fixed rate found to set for %pM",
+			    sta->addr);
+		return -EINVAL;
+	}
+
+	/* Avoid updating invalid nss as fixed rate*/
+	if (nss > sta->deflink.rx_nss)
+		return -EINVAL;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "Setting Fixed HT Rate for peer %pM. Device will not switch to any other selected rates",
+		   sta->addr);
+
+	rate_code = ATH11K_HW_RATE_CODE(ht_rate, nss - 1,
+					WMI_RATE_PREAMBLE_HT);
+	ret = ath11k_wmi_set_peer_param(ar, sta->addr,
+					arvif->vdev_id,
+					WMI_PEER_PARAM_FIXED_RATE,
+					rate_code);
+	if (ret)
+		ath11k_warn(ar->ab,
+			    "failed to update STA %pM HT Fixed Rate %d: %d\n",
+			    sta->addr, rate_code, ret);
+
+	return ret;
+}
+
 static int ath11k_station_assoc(struct ath11k *ar,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
@@ -4491,7 +4539,7 @@ static int ath11k_station_assoc(struct ath11k *ar,
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	struct cfg80211_bitrate_mask *mask;
-	u8 num_vht_rates, num_he_rates;
+	u8 num_ht_rates, num_vht_rates, num_he_rates;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -4519,6 +4567,7 @@ static int ath11k_station_assoc(struct ath11k *ar,
 
 	num_vht_rates = ath11k_mac_bitrate_mask_num_vht_rates(ar, band, mask);
 	num_he_rates = ath11k_mac_bitrate_mask_num_he_rates(ar, band, mask);
+	num_ht_rates = ath11k_mac_bitrate_mask_num_ht_rates(ar, band, mask);
 
 	/* If single VHT/HE rate is configured (by set_bitrate_mask()),
 	 * peer_assoc will disable VHT/HE. This is now enabled by a peer specific
@@ -4535,6 +4584,11 @@ static int ath11k_station_assoc(struct ath11k *ar,
 							band);
 		if (ret)
 			return ret;
+	} else if (sta->deflink.ht_cap.ht_supported && num_ht_rates == 1) {
+		ret = ath11k_mac_set_peer_ht_fixed_rate(arvif, sta, mask,
+							band);
+		if (ret)
+			return ret;
 	}
 
 	/* Re-assoc is run only to update supported rates for given station. It
@@ -4608,7 +4662,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	const u16 *vht_mcs_mask;
 	const u16 *he_mcs_mask;
 	u32 changed, bw, nss, smps, bw_prev;
-	int err, num_vht_rates, num_he_rates;
+	int err, num_ht_rates, num_vht_rates, num_he_rates;
 	const struct cfg80211_bitrate_mask *mask;
 	struct peer_assoc_params peer_arg;
 	enum wmi_phy_mode peer_phymode;
@@ -4724,6 +4778,8 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 
 	if (changed & IEEE80211_RC_SUPP_RATES_CHANGED) {
 		mask = &arvif->bitrate_mask;
+		num_ht_rates = ath11k_mac_bitrate_mask_num_ht_rates(ar, band,
+								    mask);
 		num_vht_rates = ath11k_mac_bitrate_mask_num_vht_rates(ar, band,
 								      mask);
 		num_he_rates = ath11k_mac_bitrate_mask_num_he_rates(ar, band,
@@ -4746,6 +4802,9 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 		} else if (sta->deflink.he_cap.has_he && num_he_rates == 1) {
 			ath11k_mac_set_peer_he_fixed_rate(arvif, sta, mask,
 							  band);
+		} else if (sta->deflink.ht_cap.ht_supported && num_ht_rates == 1) {
+			ath11k_mac_set_peer_ht_fixed_rate(arvif, sta, mask,
+							  band);
 		} else {
 			/* If the peer is non-VHT/HE or no fixed VHT/HE rate
 			 * is provided in the new bitrate mask we set the
-- 
2.25.1

