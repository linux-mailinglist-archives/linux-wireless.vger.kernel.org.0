Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAF076277D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 01:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGYXpJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 19:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGYXpI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 19:45:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09199212C
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 16:45:07 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PMFBmq016324;
        Tue, 25 Jul 2023 22:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=rPIWq/m0E3eQAFg/aRa2XR7PGs/Iau/r2vO7y+NfzQ0=;
 b=l11xStX+ODe3968Mr0jnNFzxWCV9V0kQ1gdwDp9d++8GAbkjzGrZr0oUspqOP/Fe/g90
 PR7duRpBi81TxjfOm1jl18reXA58aZXCo7L1bEuUrTisiwicVA8MvhGOXINrdjt0cK60
 nGLLeeetJC8OdAcIjmB5vtd7WMsXrGL7C7xkKBGaKPP9whNK6Fz3g98nmp0vVl6+1POI
 d9Rk+2F9JB1E3b5wtL/ltlF1sSVaWZk4NCR681hYzIlldPhdmnONg81KitzgKNzjOW+c
 H68hyuGHFgJTLY4Lx7rj7M7fCqnRqgSbFpPT0DYHotUk3FSWKAnDe7TQeEq8AA1FT+oQ 9g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2cf8skuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:40:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PMekIi022984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:40:46 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 15:40:46 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH v5 04/11] wifi: ath12k: propagate EHT capabilities to userspace
Date:   Tue, 25 Jul 2023 15:40:27 -0700
Message-ID: <20230725224034.14045-5-quic_alokad@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2kRpZeFuPOR33gh_-wLjmUXIrBnhjvae
X-Proofpoint-GUID: 2kRpZeFuPOR33gh_-wLjmUXIrBnhjvae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_12,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Propagate EHT capabilities to the userspace using a new member
'eht_cap' in structure ieee80211_sband_iftype_data.

MCS-NSS capabilities are copied depending on the supported bandwidths
for the given band.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu<quic_pradeepc@quicinc.com>
---
v5: Squashed code from ath12k_mac_copy_eht_ppet_ru() into
ath12k_mac_copy_eht_ppe_thresh(). Removed the bit shifting of 'val' and
unused 'len'. Replaced hweight8 by hweight16 for
IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK. Used a varible as input to
GENMASK() instead of a hard-coded value.
v4: No change from v3.
v3: No change from v2.
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/mac.c | 111 ++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 30df1afd57d3..fcc24ef4999f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4262,6 +4262,115 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
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
+static void ath12k_mac_copy_eht_ppe_thresh(struct ath12k_wmi_ppe_threshold_arg *fw_ppet,
+					   struct ieee80211_sta_eht_cap *cap)
+{
+	u16 bit = IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
+	u8 i, nss, ru, ppet_bit_len_per_ru = IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE * 2;
+
+	u8p_replace_bits(&cap->eht_ppe_thres[0], fw_ppet->numss_m1,
+			 IEEE80211_EHT_PPE_THRES_NSS_MASK);
+
+	u16p_replace_bits((u16 *)&cap->eht_ppe_thres[0], fw_ppet->ru_bit_mask,
+			  IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+
+	for (nss = 0; nss <= fw_ppet->numss_m1; nss++) {
+		for (ru = 0;
+		     ru < hweight16(IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+		     ru++) {
+			u32 val = 0;
+
+			if ((fw_ppet->ru_bit_mask & BIT(ru)) == 0)
+				continue;
+
+			u32p_replace_bits(&val, fw_ppet->ppet16_ppet8_ru3_ru0[nss] >>
+						(ru * ppet_bit_len_per_ru),
+					  GENMASK(ppet_bit_len_per_ru - 1, 0));
+
+			for (i = 0; i < ppet_bit_len_per_ru; i++) {
+				cap->eht_ppe_thres[bit / 8] |=
+					(((val >> i) & 0x1) << ((bit % 8)));
+				bit++;
+			}
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
@@ -4290,6 +4399,8 @@ static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
 			data[idx].he_6ghz_capa.capa =
 				ath12k_mac_setup_he_6ghz_cap(cap, band_cap);
 		}
+		ath12k_mac_copy_eht_cap(band_cap, &he_cap->he_cap_elem, i,
+					&data[idx].eht_cap);
 		idx++;
 	}
 
-- 
2.39.0

