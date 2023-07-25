Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE97627AC
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 02:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGZAOo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 20:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGZAOm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 20:14:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951411AD
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 17:14:41 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PMTQMQ031918;
        Tue, 25 Jul 2023 22:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=cwkzPECGYxpBhWSbL4//HcImfCCAre4nuwo8asDnHSY=;
 b=lstLYA4DNjji9qvuhP2O8THoVzr/fyF3cF66KEDFPkw+YozHp4swzplbsxLwZFsNHo8A
 mFnG+qd/YwB/xllnvE5j9qZgv1ifqOG5SZacxIFbxtPEjvfKs5VzQX/gr6cQLawtocob
 AGmkK6Fb5olnIyMRdPhvhdXK+QgOfQVSPPihEPcW00+mQg3MNzcITKe3pN0xCxjh++iN
 XeXRcuFI+RbMc5OjBUHtolTuMdyvncCWWRJnOl0xzkC0t6K4F0aAv20qmuKco7foKTjz
 S9OPmXTuXN0Rtnd323waB3oMWvKq4vfuPyOXFzKAFxcF7m8FQvnCcJ/oKQrYv3irLcQD PQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2aq69t79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:40:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PMelZh028371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:40:47 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 15:40:47 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH v5 06/11] wifi: ath12k: prepare EHT peer assoc parameters
Date:   Tue, 25 Jul 2023 15:40:29 -0700
Message-ID: <20230725224034.14045-7-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230725224034.14045-1-quic_alokad@quicinc.com>
References: <20230725224034.14045-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iz-WIM-TinrV1W_sPx2iVgVdYIA7l60i
X-Proofpoint-ORIG-GUID: iz-WIM-TinrV1W_sPx2iVgVdYIA7l60i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_12,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new parameters and prepare the association data for an EHT peer.
MCS data uses the format described in IEEE P802.11be/D2.0, May 2022,
9.4.2.313.4, convert it into the format expected by the firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
v5: Cleaned up bit shifting of val in ath12k_mac_set_eht_ppe_threshold().
Used hweight16() instead of hweight8() for
IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK.
Instead of using peer_phymode to decide between a 20 MHz-only peer and
a peer supporting bandwidths <= 80 MHz, ath12k_peer_assoc_h_eht() uses
HE capabilities.
v4: No change from v3.
v3: Incremented peer_eht_mcs_count for IEEE80211_STA_RX_BW_160 in
ath12k_peer_assoc_h_eht().
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/mac.c | 144 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  17 +++
 2 files changed, 161 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 379090ba107f..6fc645dfa96f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2067,6 +2067,149 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	WARN_ON(phymode == MODE_UNKNOWN);
 }
 
+static void ath12k_mac_set_eht_mcs(u8 rx_tx_mcs7, u8 rx_tx_mcs9,
+				   u8 rx_tx_mcs11, u8 rx_tx_mcs13,
+				   u32 *rx_mcs, u32 *tx_mcs)
+{
+	*rx_mcs = 0;
+	u32p_replace_bits(rx_mcs,
+			  u8_get_bits(rx_tx_mcs7, IEEE80211_EHT_MCS_NSS_RX),
+			  WMI_EHT_MCS_NSS_0_7);
+	u32p_replace_bits(rx_mcs,
+			  u8_get_bits(rx_tx_mcs9, IEEE80211_EHT_MCS_NSS_RX),
+			  WMI_EHT_MCS_NSS_8_9);
+	u32p_replace_bits(rx_mcs,
+			  u8_get_bits(rx_tx_mcs11, IEEE80211_EHT_MCS_NSS_RX),
+			  WMI_EHT_MCS_NSS_10_11);
+	u32p_replace_bits(rx_mcs,
+			  u8_get_bits(rx_tx_mcs13, IEEE80211_EHT_MCS_NSS_RX),
+			  WMI_EHT_MCS_NSS_12_13);
+
+	*tx_mcs = 0;
+	u32p_replace_bits(tx_mcs,
+			  u8_get_bits(rx_tx_mcs7, IEEE80211_EHT_MCS_NSS_TX),
+			  WMI_EHT_MCS_NSS_0_7);
+	u32p_replace_bits(tx_mcs,
+			  u8_get_bits(rx_tx_mcs9, IEEE80211_EHT_MCS_NSS_TX),
+			  WMI_EHT_MCS_NSS_8_9);
+	u32p_replace_bits(tx_mcs,
+			  u8_get_bits(rx_tx_mcs11, IEEE80211_EHT_MCS_NSS_TX),
+			  WMI_EHT_MCS_NSS_10_11);
+	u32p_replace_bits(tx_mcs,
+			  u8_get_bits(rx_tx_mcs13, IEEE80211_EHT_MCS_NSS_TX),
+			  WMI_EHT_MCS_NSS_12_13);
+}
+
+static void ath12k_mac_set_eht_ppe_threshold(const u8 *ppe_thres,
+					     struct ath12k_wmi_ppe_threshold_arg *ppet)
+{
+	u32 bit_pos = IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE, val;
+	u8 nss, ru, i;
+	u8 ppet_bit_len_per_ru = IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE * 2;
+
+	ppet->numss_m1 = u8_get_bits(ppe_thres[0], IEEE80211_EHT_PPE_THRES_NSS_MASK);
+	ppet->ru_bit_mask = u16_get_bits(get_unaligned_le16(ppe_thres),
+					 IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+
+	for (nss = 0; nss <= ppet->numss_m1; nss++) {
+		for (ru = 0;
+		     ru < hweight16(IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+		     ru++) {
+			if ((ppet->ru_bit_mask & BIT(ru)) == 0)
+				continue;
+
+			val = 0;
+			for (i = 0; i < ppet_bit_len_per_ru; i++) {
+				val |= (((ppe_thres[bit_pos / 8] >>
+					  (bit_pos % 8)) & 0x1) << i);
+				bit_pos++;
+			}
+			ppet->ppet16_ppet8_ru3_ru0[nss] |=
+					(val << (ru * ppet_bit_len_per_ru));
+		}
+	}
+}
+
+static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    struct ath12k_wmi_peer_assoc_arg *arg)
+{
+	const struct ieee80211_sta_eht_cap *eht_cap = &sta->deflink.eht_cap;
+	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	const struct ieee80211_eht_mcs_nss_supp_bw *bw;
+	u32 *rx_mcs, *tx_mcs;
+
+	if (!sta->deflink.he_cap.has_he || !eht_cap->has_eht)
+		return;
+
+	arg->eht_flag = true;
+
+	if ((eht_cap->eht_cap_elem.phy_cap_info[5] &
+	     IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) &&
+	    eht_cap->eht_ppe_thres[0] != 0)
+		ath12k_mac_set_eht_ppe_threshold(eht_cap->eht_ppe_thres,
+						 &arg->peer_eht_ppet);
+
+	memcpy(arg->peer_eht_cap_mac, eht_cap->eht_cap_elem.mac_cap_info,
+	       sizeof(eht_cap->eht_cap_elem.mac_cap_info));
+	memcpy(arg->peer_eht_cap_phy, eht_cap->eht_cap_elem.phy_cap_info,
+	       sizeof(eht_cap->eht_cap_elem.phy_cap_info));
+
+	rx_mcs = arg->peer_eht_rx_mcs_set;
+	tx_mcs = arg->peer_eht_tx_mcs_set;
+
+	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_320:
+		bw = &eht_cap->eht_mcs_nss_supp.bw._320;
+		ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
+				       bw->rx_tx_mcs9_max_nss,
+				       bw->rx_tx_mcs11_max_nss,
+				       bw->rx_tx_mcs13_max_nss,
+				       &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_320],
+				       &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_320]);
+		arg->peer_eht_mcs_count++;
+		fallthrough;
+	case IEEE80211_STA_RX_BW_160:
+		bw = &eht_cap->eht_mcs_nss_supp.bw._160;
+		ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
+				       bw->rx_tx_mcs9_max_nss,
+				       bw->rx_tx_mcs11_max_nss,
+				       bw->rx_tx_mcs13_max_nss,
+				       &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_160],
+				       &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_160]);
+		arg->peer_eht_mcs_count++;
+		fallthrough;
+	default:
+		if ((he_cap->he_cap_elem.phy_cap_info[0] &
+		     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0) {
+			const struct ieee80211_eht_mcs_nss_supp_20mhz_only *bw_20 =
+					&eht_cap->eht_mcs_nss_supp.only_20mhz;
+
+			ath12k_mac_set_eht_mcs(bw_20->rx_tx_mcs7_max_nss,
+					       bw_20->rx_tx_mcs9_max_nss,
+					       bw_20->rx_tx_mcs11_max_nss,
+					       bw_20->rx_tx_mcs13_max_nss,
+					       &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80],
+					       &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80]);
+		} else {
+			bw = &eht_cap->eht_mcs_nss_supp.bw._80;
+			ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
+					       bw->rx_tx_mcs9_max_nss,
+					       bw->rx_tx_mcs11_max_nss,
+					       bw->rx_tx_mcs13_max_nss,
+					       &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80],
+					       &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80]);
+		}
+
+		arg->peer_eht_mcs_count++;
+		break;
+	}
+}
+
 static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
@@ -2086,6 +2229,7 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	ath12k_peer_assoc_h_ht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_vht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_he(ar, vif, sta, arg);
+	ath12k_peer_assoc_h_eht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_qos(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_smps(sta, arg);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 67604224046b..23cdb3543fc2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2583,6 +2583,7 @@ struct ath12k_wmi_soc_hal_reg_caps_params {
 
 #define WMI_MAX_EHTCAP_MAC_SIZE  2
 #define WMI_MAX_EHTCAP_PHY_SIZE  3
+#define WMI_MAX_EHTCAP_RATE_SET  3
 
 /* Used for EHT MCS-NSS array. Data at each array index follows the format given
  * in IEEE P802.11be/D2.0, May 20229.4.2.313.4.
@@ -2596,6 +2597,15 @@ struct ath12k_wmi_soc_hal_reg_caps_params {
 #define WMI_MAX_EHT_SUPP_MCS_2G_SIZE  2
 #define WMI_MAX_EHT_SUPP_MCS_5G_SIZE  4
 
+#define WMI_EHTCAP_TXRX_MCS_NSS_IDX_80    0
+#define WMI_EHTCAP_TXRX_MCS_NSS_IDX_160   1
+#define WMI_EHTCAP_TXRX_MCS_NSS_IDX_320   2
+
+#define WMI_EHT_MCS_NSS_0_7    GENMASK(3, 0)
+#define WMI_EHT_MCS_NSS_8_9    GENMASK(7, 4)
+#define WMI_EHT_MCS_NSS_10_11  GENMASK(11, 8)
+#define WMI_EHT_MCS_NSS_12_13  GENMASK(15, 12)
+
 struct ath12k_wmi_caps_ext_params {
 	__le32 hw_mode_id;
 	union {
@@ -3565,6 +3575,13 @@ struct ath12k_wmi_peer_assoc_arg {
 	bool twt_responder;
 	bool twt_requester;
 	struct ath12k_wmi_ppe_threshold_arg peer_ppet;
+	bool eht_flag;
+	u32 peer_eht_cap_mac[WMI_MAX_EHTCAP_MAC_SIZE];
+	u32 peer_eht_cap_phy[WMI_MAX_EHTCAP_PHY_SIZE];
+	u32 peer_eht_mcs_count;
+	u32 peer_eht_rx_mcs_set[WMI_MAX_EHTCAP_RATE_SET];
+	u32 peer_eht_tx_mcs_set[WMI_MAX_EHTCAP_RATE_SET];
+	struct ath12k_wmi_ppe_threshold_arg peer_eht_ppet;
 };
 
 struct wmi_peer_assoc_complete_cmd {
-- 
2.39.0

