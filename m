Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46E6E16B8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 23:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjDMVwV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 17:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDMVwR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 17:52:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C16589
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 14:52:16 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DLq1Vg022729;
        Thu, 13 Apr 2023 21:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=c4DaeBnr/uSzAKRY8741gDm4R13EVUN3Oqc+Rs2pN9M=;
 b=aDoOkVl4Q5CwCCTfxnDnOAHq/p9aLcYGhNbZgw4qex9h01b9+ZvkVjs7UcWgbO4548od
 87i+4DHMwmEQyv5ywdbwlYfSGRW5E4niAs1rjtmBKMaC58F/ijWsj9w049YJBSz0ktwD
 0IZss4l5L3/LRx0nbW+2coC1AON3qd5PgZ5YtuPaxPEff1P0e9jnl6zpYsqxbIIM+LNG
 /upMTclQC1wM23XPP2zetx3e0SyhVzkgnit2PlGCjqne9WmmCv13ipD+8MP1ulh+/i8v
 X2f4sNoi0HYCr9FjjZJr6w7WFi+gFlkzopy9wzbIMLsB3uhL4GMpDPOP7BTUl4mPhfYc sg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxd4n1qte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 21:52:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33DLqA3W012200
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 21:52:10 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 14:52:09 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH v3 06/11] wifi: ath12k: prepare EHT peer assoc parameters
Date:   Thu, 13 Apr 2023 14:51:51 -0700
Message-ID: <20230413215156.2649-7-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230413215156.2649-1-quic_alokad@quicinc.com>
References: <20230413215156.2649-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m3M9cqUmK1QZh7ngp0PIn0x1fVa4obrf
X-Proofpoint-ORIG-GUID: m3M9cqUmK1QZh7ngp0PIn0x1fVa4obrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_16,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304130194
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v3: Incremented peer_eht_mcs_count for IEEE80211_STA_RX_BW_160 in
ath12k_peer_assoc_h_eht().
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/mac.c | 145 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  17 +++
 2 files changed, 162 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 22e136617687..81ef3ea81018 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2061,6 +2061,150 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
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
+	u32 bit_pos = IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
+	u8 nss;
+
+	ppet->numss_m1 = u8_get_bits(ppe_thres[0], IEEE80211_EHT_PPE_THRES_NSS_MASK);
+	ppet->ru_bit_mask = u16_get_bits(get_unaligned_le16(ppe_thres),
+					 IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+
+	for (nss = 0; nss <= ppet->numss_m1; nss++) {
+		u8 ru;
+
+		for (ru = 0;
+		     ru < hweight8(IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+		     ru++) {
+			u32 val = 0;
+			u8 i;
+
+			if ((ppet->ru_bit_mask & BIT(ru)) == 0)
+				continue;
+
+			for (i = 0;
+			     i < IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE;
+			     i++) {
+				val >>= 1;
+				val |= ((ppe_thres[bit_pos / 8] >>
+					 (bit_pos % 8)) & 0x1) << 5;
+				bit_pos++;
+			}
+			ppet->ppet16_ppet8_ru3_ru0[nss] |=
+				(val <<
+				 (ru * IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE));
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
+	const struct ieee80211_eht_mcs_nss_supp_bw *bw;
+	u32 *rx_mcs, *tx_mcs;
+
+	if (!sta->deflink.he_cap.has_he || !eht_cap->has_eht)
+		return;
+
+	arg->eht_flag = true;
+	if ((eht_cap->eht_cap_elem.phy_cap_info[5] &
+	     IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) &&
+	    eht_cap->eht_ppe_thres[0] != 0)
+		ath12k_mac_set_eht_ppe_threshold(eht_cap->eht_ppe_thres,
+						 &arg->peer_eht_ppet);
+	memcpy(arg->peer_eht_cap_mac, eht_cap->eht_cap_elem.mac_cap_info,
+	       sizeof(eht_cap->eht_cap_elem.mac_cap_info));
+	memcpy(arg->peer_eht_cap_phy, eht_cap->eht_cap_elem.phy_cap_info,
+	       sizeof(eht_cap->eht_cap_elem.phy_cap_info));
+
+	rx_mcs = arg->peer_eht_rx_mcs_set;
+	tx_mcs = arg->peer_eht_tx_mcs_set;
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
+
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
+
+	default:
+		if (arg->peer_phymode == MODE_11BE_EHT20) {
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
@@ -2080,6 +2224,7 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	ath12k_peer_assoc_h_ht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_vht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_he(ar, vif, sta, arg);
+	ath12k_peer_assoc_h_eht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_qos(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_smps(sta, arg);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 65b52a8079cd..12fedcf2c8b4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2579,6 +2579,7 @@ struct ath12k_wmi_soc_hal_reg_caps_params {
 
 #define WMI_MAX_EHTCAP_MAC_SIZE  2
 #define WMI_MAX_EHTCAP_PHY_SIZE  3
+#define WMI_MAX_EHTCAP_RATE_SET  3
 
 /* Used for EHT MCS-NSS array. Data at each array index follows the format given
  * in IEEE P802.11be/D2.0, May 20229.4.2.313.4.
@@ -2592,6 +2593,15 @@ struct ath12k_wmi_soc_hal_reg_caps_params {
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
 struct ath12k_wmi_mac_phy_caps_ext_params {
 	__le32 hw_mode_id;
 	union {
@@ -3561,6 +3571,13 @@ struct ath12k_wmi_peer_assoc_arg {
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

