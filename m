Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763B16CF6B5
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 01:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjC2XMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 19:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjC2XMH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 19:12:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0588C4EEF
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 16:12:05 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32THBMqQ000519;
        Wed, 29 Mar 2023 23:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=/zd8ZWYG1TKpWTiGMBhbradjJIW8OH0HyBYkDHrn49M=;
 b=RLx5lirYEfysvdBvWgH2I2G1McWnIGa9FuPgZiAr6KUrNw0gL8OohEcL5o+TF0AkR0Ea
 8p43dXT0Y0goXlIGYVi4SFYJ7RdDNwSiRcdTKmF/Ns7NoXnopFz5r1x5w0+5HoB+lISB
 XBHHeBl35yRZJvmesjBKmrQnhcP4iwZGiLP+aC+xbG3jX85K8R5tDcwK4ACTpZpCG0tk
 ZhCHTwTf99FXFZ2lJAobu1kt/gphpc0zJFFO/L1m1cxVJ1ChKS79yezDqajlCdgy5vaq
 A/aputYpnYnzogvCo8aysxD8stHTwrzWsVgtx9mlOMBqXJumt75sNLLUEXmSUwRIAYi8 oA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmq959bb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 23:12:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32TNBxGN003379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 23:11:59 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 29 Mar 2023 16:11:58 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH 04/11] wifi: ath12k: propagate EHT capabilities to userspace
Date:   Wed, 29 Mar 2023 16:11:38 -0700
Message-ID: <20230329231145.20171-5-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230329231145.20171-1-quic_alokad@quicinc.com>
References: <20230329231145.20171-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dpEtvztnb7TZBZRHF8Wzr2FxdGPHNfR3
X-Proofpoint-ORIG-GUID: dpEtvztnb7TZBZRHF8Wzr2FxdGPHNfR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_14,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290173
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Propagate the EHT capabilities to the userspace using a new
member 'eht_cap' in structure ieee80211_sband_iftype_data.

MCS-NSS capabilities are copied depending on the supported bandwidths
for the given band.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu<quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 128 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.c |   7 +-
 2 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e5ba7a01d571..7e6fc6b941e8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4259,6 +4259,132 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
 		ath12k_gen_ppe_thresh(&band_cap->he_ppet, he_cap->ppe_thres);
 }
 
+static void
+ath12k_mac_copy_eht_mcs_nss(struct ath12k_band_cap *band_cap,
+			    struct ieee80211_eht_mcs_nss_supp *mcs_nss,
+			    const struct ieee80211_he_cap_elem *he_cap,
+			    const struct ieee80211_eht_cap_elem_fixed *eht_cap)
+{
+	if ((he_cap->phy_cap_info[0] &
+	     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0)
+		memcpy(&mcs_nss->only_20mhz, &band_cap->eht_mcs_20_only,
+		       sizeof(struct ieee80211_eht_mcs_nss_supp_20mhz_only));
+
+	if (he_cap->phy_cap_info[0] &
+	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
+	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G))
+		memcpy(&mcs_nss->bw._80, &band_cap->eht_mcs_80,
+		       sizeof(struct ieee80211_eht_mcs_nss_supp_bw));
+
+	if (he_cap->phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
+		memcpy(&mcs_nss->bw._160, &band_cap->eht_mcs_160,
+		       sizeof(struct ieee80211_eht_mcs_nss_supp_bw));
+
+	if (eht_cap->phy_cap_info[0] & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
+		memcpy(&mcs_nss->bw._320, &band_cap->eht_mcs_320,
+		       sizeof(struct ieee80211_eht_mcs_nss_supp_bw));
+}
+
+static void ath12k_mac_copy_eht_ppet_ru(u32 ppet, u8 ppe_thres[], int ru)
+{
+	int i;
+	u32 val = 0;
+	u8 ppet_size_ru = IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE * 2;
+	u8 bit = IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
+
+	u32p_replace_bits(&val, ppet >> (ru * ppet_size_ru),
+			  GENMASK(ppet_size_ru - 1, 0));
+
+	val = ((val >> IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE) & GENMASK(2, 0)) |
+	      ((val & GENMASK(2, 0)) << IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE);
+
+	for (i = ppet_size_ru - 1; i >= 0; i--) {
+		ppe_thres[bit / 8] |= (((val >> i) & 0x1) << ((bit % 8)));
+		bit++;
+	}
+}
+
+static void ath12k_mac_copy_eht_ppe_thresh(struct ath12k_wmi_ppe_threshold_arg *fw_ppet,
+					   struct ieee80211_sta_eht_cap *cap)
+{
+	int nss, ru;
+	u8 len = 0;
+
+	len = hweight8(fw_ppet->ru_bit_mask);
+	len *= (1 + fw_ppet->numss_m1);
+
+	len = (len * IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE) +
+	      IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
+	len = DIV_ROUND_UP(len, 8);
+
+	u8p_replace_bits(&cap->eht_ppe_thres[0], fw_ppet->numss_m1,
+			 IEEE80211_EHT_PPE_THRES_NSS_MASK);
+
+	u16p_replace_bits((u16 *)&cap->eht_ppe_thres[0], fw_ppet->ru_bit_mask,
+			  IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+
+	for (nss = 0; nss <= fw_ppet->numss_m1; nss++) {
+		for (ru = 0;
+		     ru < hweight8(IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+		     ru++) {
+			if ((fw_ppet->ru_bit_mask & BIT(ru)) == 0)
+				continue;
+
+			ath12k_mac_copy_eht_ppet_ru(fw_ppet->ppet16_ppet8_ru3_ru0[nss],
+						    cap->eht_ppe_thres, ru);
+		}
+	}
+}
+
+static void ath12k_mac_copy_eht_cap(struct ath12k_band_cap *band_cap,
+				    struct ieee80211_he_cap_elem *he_cap_elem,
+				    int iftype,
+				    struct ieee80211_sta_eht_cap *eht_cap)
+{
+	struct ieee80211_eht_cap_elem_fixed *eht_cap_elem = &eht_cap->eht_cap_elem;
+
+	memset(eht_cap, 0, sizeof(struct ieee80211_sta_eht_cap));
+	eht_cap->has_eht = true;
+	memcpy(eht_cap_elem->mac_cap_info, band_cap->eht_cap_mac_info,
+	       sizeof(eht_cap_elem->mac_cap_info));
+	memcpy(eht_cap_elem->phy_cap_info, band_cap->eht_cap_phy_info,
+	       sizeof(eht_cap_elem->phy_cap_info));
+
+	switch (iftype) {
+	case NL80211_IFTYPE_AP:
+		eht_cap_elem->phy_cap_info[0] &=
+			~IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ;
+		eht_cap_elem->phy_cap_info[4] &=
+			~IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO;
+		eht_cap_elem->phy_cap_info[5] &=
+			~IEEE80211_EHT_PHY_CAP5_TX_LESS_242_TONE_RU_SUPP;
+		break;
+	case NL80211_IFTYPE_STATION:
+		eht_cap_elem->phy_cap_info[7] &=
+			~(IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
+			  IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
+			  IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ);
+		eht_cap_elem->phy_cap_info[7] &=
+			~(IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
+			  IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ |
+			  IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ);
+		break;
+	default:
+		break;
+	}
+
+	ath12k_mac_copy_eht_mcs_nss(band_cap, &eht_cap->eht_mcs_nss_supp,
+				    he_cap_elem, eht_cap_elem);
+
+	if (eht_cap_elem->phy_cap_info[5] &
+	    IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT)
+		ath12k_mac_copy_eht_ppe_thresh(&band_cap->eht_ppet, eht_cap);
+}
+
 static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
 					     struct ath12k_pdev_cap *cap,
 					     struct ieee80211_sband_iftype_data *data,
@@ -4287,6 +4413,8 @@ static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
 			data[idx].he_6ghz_capa.capa =
 				ath12k_mac_setup_he_6ghz_cap(cap, band_cap);
 		}
+		ath12k_mac_copy_eht_cap(band_cap, &he_cap->he_cap_elem, i,
+					&data[idx].eht_cap);
 		idx++;
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 89c3bf759bd4..2d3094ec19c0 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4068,9 +4068,10 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 	cap_band->eht_cap_info_internal = le32_to_cpu(cap_info_internal);
 }
 
-static int ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
-						 struct ath12k_wmi_mac_phy_caps_ext_params *caps,
-						 struct ath12k_pdev *pdev)
+static int
+ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
+				      struct ath12k_wmi_mac_phy_caps_ext_params *caps,
+				      struct ath12k_pdev *pdev)
 {
 	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
 		ath12k_wmi_eht_caps_parse(pdev, NL80211_BAND_2GHZ,
-- 
2.39.0

