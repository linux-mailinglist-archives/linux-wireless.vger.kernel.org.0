Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2CE6F6833
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 11:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjEDJVC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 05:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjEDJVB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 05:21:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665A469A
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 02:21:00 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3444vtrr032555;
        Thu, 4 May 2023 09:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=IVwHxDG1d2XmMKPiVSxlP6JfrabaFTmj91uiYSUs/GE=;
 b=ZOs7Zp/kP8qv1SAhdLj79VvCM9UkT5oM212+gaEKyQ7Jo3ijoWnR3RFBSThjPA1bcyXP
 4qRUi5IqXwn+aoXY3+bAxj7+BJHxBBS8s+dyh0IH8M5vTonNNthfgwz+73ObBsKC4eh3
 SPp7vcp1WeFwNtxq8OVQUndT3kCfm5GyFQux5xG2Swa901dMEm5Wrr+8823cGld9DBM3
 K8L0NSY2cAm/19YuWLDOkhylwjjgo6FCU37p9yoNBxHmrk1DDfJWv6Pygk0hD5wm5OLQ
 Q35mw+BSkIH7u+0shQL79Ix3LVeG21k3z1vFA+W/jJvFGHPv8dAsUNMIbEjSa7EB5D2P 1Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc652gfta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:20:55 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3449Ktee020743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 09:20:55 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 May 2023 02:20:53 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH 2/2] ath11k: Send HT fixed rate in WMI peer fixed param
Date:   Thu, 4 May 2023 14:50:33 +0530
Message-ID: <20230504092033.3542456-3-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504092033.3542456-2-quic_mkenna@quicinc.com>
References: <20230504092033.3542456-2-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JDWEfjJSeWPa4ApSbzeBbuiCo7naq_Dy
X-Proofpoint-ORIG-GUID: JDWEfjJSeWPa4ApSbzeBbuiCo7naq_Dy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index eb46d06272de..16bf453080fe 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4302,6 +4302,54 @@ ath11k_mac_set_peer_he_fixed_rate(struct ath11k_vif *arvif,
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
@@ -4313,7 +4361,7 @@ static int ath11k_station_assoc(struct ath11k *ar,
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	struct cfg80211_bitrate_mask *mask;
-	u8 num_vht_rates, num_he_rates;
+	u8 num_ht_rates, num_vht_rates, num_he_rates;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -4341,6 +4389,7 @@ static int ath11k_station_assoc(struct ath11k *ar,
 
 	num_vht_rates = ath11k_mac_bitrate_mask_num_vht_rates(ar, band, mask);
 	num_he_rates = ath11k_mac_bitrate_mask_num_he_rates(ar, band, mask);
+	num_ht_rates = ath11k_mac_bitrate_mask_num_ht_rates(ar, band, mask);
 
 	/* If single VHT/HE rate is configured (by set_bitrate_mask()),
 	 * peer_assoc will disable VHT/HE. This is now enabled by a peer specific
@@ -4357,6 +4406,11 @@ static int ath11k_station_assoc(struct ath11k *ar,
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
@@ -4430,7 +4484,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	const u16 *vht_mcs_mask;
 	const u16 *he_mcs_mask;
 	u32 changed, bw, nss, smps, bw_prev;
-	int err, num_vht_rates, num_he_rates;
+	int err, num_ht_rates, num_vht_rates, num_he_rates;
 	const struct cfg80211_bitrate_mask *mask;
 	struct peer_assoc_params peer_arg;
 	enum wmi_phy_mode peer_phymode;
@@ -4546,6 +4600,8 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 
 	if (changed & IEEE80211_RC_SUPP_RATES_CHANGED) {
 		mask = &arvif->bitrate_mask;
+		num_ht_rates = ath11k_mac_bitrate_mask_num_ht_rates(ar, band,
+								    mask);
 		num_vht_rates = ath11k_mac_bitrate_mask_num_vht_rates(ar, band,
 								      mask);
 		num_he_rates = ath11k_mac_bitrate_mask_num_he_rates(ar, band,
@@ -4568,6 +4624,9 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
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

