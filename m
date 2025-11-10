Return-Path: <linux-wireless+bounces-28739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F35C45F7B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DABF34E7F75
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9348A3064A9;
	Mon, 10 Nov 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HGSnbnZe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E893074B2
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771052; cv=none; b=pqQWb0UYVEO1mwUCwnqVfVEMz+922GjhwdmJdxCWpqMF1WRwPiTnqHHsa4zRNDdDRRgYW1WLkE+1ynCuHbX7vDaKi6NmJngAop9kkFnPcnNv5k8rxmfYFQ03rJcugShnz+w72gPsgtk0+qaZLeDS+RSafb/hu+kUhQBCG+x6Dds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771052; c=relaxed/simple;
	bh=xZsoIKEwsTYOfFYi6DeczoAnswphiyrUKK04IT8wRgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m36enngsO6qdwx4gBAkdemZbVTecxRKGv0xBP2mbGgP8VPgrNhUsQp26dAgXN60K9Mh8bRPEqtjZ/JGXyXGpcWfDSwzBNBMhH3ArXDHAt8+IkVkhKA8CAp1JWYjePrH35+u75hkDAuWxVR7jX4gafk0ZapefLiRCA8VLmelbPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HGSnbnZe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8U5TO1809057;
	Mon, 10 Nov 2025 10:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MBnWKGytES1
	rpjJ0M024RJOS9Z0bHzkWWbFKkm6zlEo=; b=HGSnbnZeYkD//Ii2240/H8ooXg8
	mSkkxtBgWCqSzi1bWBXcYS+PehQWuCMO5InKuEMMI7oqgvL/FTbun5wOTr8KTF2M
	HvDkg60ZxfWG06nO7RQOEkfhF8ZmsLgSZ2jv2+NoXQlsRD+ZXkGIOtauvJ4ik8Xa
	yNvDdfHDlgZe6VS8dAIB02t4P6GgQujKfHlPaX/sW0vhPJJxcd7Y22udm12ZKmZp
	w3qgXh7jrMEOy5oI/O2ko7HU6J73k2fwQM7H9q9/4tiSnmYXAOxwXpn1IsNfHuTP
	OGWZwYftvPMS7+LK57O1ioq8k2IYzl7xE8CCFMef7DFbel0mDkcDKtkJpPA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab5m1hhbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbHTt008069;
	Mon, 10 Nov 2025 10:37:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbIVU008098;
	Mon, 10 Nov 2025 10:37:18 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbISI008089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:18 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id 9B079B73; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 09/12] wifi: ath12k: Move remaining SIG TLV parsing to Wi-Fi 7 module
Date: Mon, 10 Nov 2025 16:07:10 +0530
Message-Id: <20251110103713.3484779-10-quic_aloksing@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
References: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfX2jWSt9a7mO2b
 gs5t5yMTREcanf2UiW6ZTpDn/uc7jQJgXWl3ZyASInpSyzjbdsTSjlroFuFEDnyKiDA5gXm/5Ov
 6LEDF1KUYixZZWyUd6GD/ddNcXMGKkFgyD3mxF6sSFWDY3GggBw7YRVap0UtMwGDk2pDga5M5jz
 GOM4c+d4u2q6kCcpfDCzrl+oQ0LrWSxIvOX9QXB1H1F1i4q4ptshO/SaG/GWdZccLJnDjt51YIP
 A1wodEqxTMRtq7r2QuuBov+nN8fWQg5gzj2ZrIUzxL82YRlR6EnmlxxffeQrEoykkGBVzZXpVyb
 j1G+6orhCZvDeQInJzKAUE8lQhfhxJwlM3f8ssA8nY/boRg9MhoX4L4e8K6d4ZxebKe5WYFIBCo
 aZIerqrRX+DXWUrdGvJyngjmp7tsvQ==
X-Authority-Analysis: v=2.4 cv=TsXrRTXh c=1 sm=1 tr=0 ts=6911c063 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=LBsUwxzC1BzDTdBlC1kA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: FaRJWxGyHcm73LRdqaPv_ZOJYJC4c5dI
X-Proofpoint-GUID: FaRJWxGyHcm73LRdqaPv_ZOJYJC4c5dI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100092

The ath12k common monitor path still contains Wi-Fi 7 specific
SIG TLV parsing. Move these SIG TLV parsing to the Wi-Fi 7
module to improve modularity.

Relocate the following functions into wifi7/dp_mon.c and
rename them with the ath12k_wifi7_ prefix:
- ath12k_dp_mon_parse_l_sig_b()
- ath12k_dp_mon_parse_l_sig_a()
- ath12k_dp_mon_hal_rx_parse_u_sig_cmn()
- ath12k_dp_mon_hal_rx_parse_u_sig_tb()
- ath12k_dp_mon_hal_rx_parse_u_sig_mu()
- ath12k_dp_mon_hal_rx_parse_u_sig_hdr()

Export the helper symbols needed by the Wi-Fi 7 module.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Alok Singh <quic_aloksing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 265 -----------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |   7 -
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 274 +++++++++++++++++-
 3 files changed, 269 insertions(+), 277 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 1ad984cd561e..9b04a9505ea0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -75,271 +75,6 @@ ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *
 }
 EXPORT_SYMBOL(ath12k_dp_mon_rx_populate_mu_user_info);
 
-void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
-				 struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	u32 info0 = __le32_to_cpu(lsigb->info0);
-	u8 rate;
-
-	rate = u32_get_bits(info0, HAL_RX_LSIG_B_INFO_INFO0_RATE);
-	switch (rate) {
-	case 1:
-		rate = HAL_RX_LEGACY_RATE_1_MBPS;
-		break;
-	case 2:
-	case 5:
-		rate = HAL_RX_LEGACY_RATE_2_MBPS;
-		break;
-	case 3:
-	case 6:
-		rate = HAL_RX_LEGACY_RATE_5_5_MBPS;
-		break;
-	case 4:
-	case 7:
-		rate = HAL_RX_LEGACY_RATE_11_MBPS;
-		break;
-	default:
-		rate = HAL_RX_LEGACY_RATE_INVALID;
-	}
-
-	ppdu_info->rate = rate;
-	ppdu_info->cck_flag = 1;
-}
-EXPORT_SYMBOL(ath12k_dp_mon_parse_l_sig_b);
-
-void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
-				 struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	u32 info0 = __le32_to_cpu(lsiga->info0);
-	u8 rate;
-
-	rate = u32_get_bits(info0, HAL_RX_LSIG_A_INFO_INFO0_RATE);
-	switch (rate) {
-	case 8:
-		rate = HAL_RX_LEGACY_RATE_48_MBPS;
-		break;
-	case 9:
-		rate = HAL_RX_LEGACY_RATE_24_MBPS;
-		break;
-	case 10:
-		rate = HAL_RX_LEGACY_RATE_12_MBPS;
-		break;
-	case 11:
-		rate = HAL_RX_LEGACY_RATE_6_MBPS;
-		break;
-	case 12:
-		rate = HAL_RX_LEGACY_RATE_54_MBPS;
-		break;
-	case 13:
-		rate = HAL_RX_LEGACY_RATE_36_MBPS;
-		break;
-	case 14:
-		rate = HAL_RX_LEGACY_RATE_18_MBPS;
-		break;
-	case 15:
-		rate = HAL_RX_LEGACY_RATE_9_MBPS;
-		break;
-	default:
-		rate = HAL_RX_LEGACY_RATE_INVALID;
-	}
-
-	ppdu_info->rate = rate;
-}
-EXPORT_SYMBOL(ath12k_dp_mon_parse_l_sig_a);
-
-static void
-ath12k_dp_mon_hal_rx_parse_u_sig_cmn(const struct hal_mon_usig_cmn *cmn,
-				     struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	u32 common;
-
-	ppdu_info->u_sig_info.bw = le32_get_bits(cmn->info0,
-						 HAL_RX_USIG_CMN_INFO0_BW);
-	ppdu_info->u_sig_info.ul_dl = le32_get_bits(cmn->info0,
-						    HAL_RX_USIG_CMN_INFO0_UL_DL);
-
-	common = __le32_to_cpu(ppdu_info->u_sig_info.usig.common);
-	common |= IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER_KNOWN |
-		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_KNOWN |
-		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL_KNOWN |
-		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN |
-		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN |
-		  ATH12K_LE32_DEC_ENC(cmn->info0,
-				      HAL_RX_USIG_CMN_INFO0_PHY_VERSION,
-				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER) |
-		  u32_encode_bits(ppdu_info->u_sig_info.bw,
-				  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW) |
-		  u32_encode_bits(ppdu_info->u_sig_info.ul_dl,
-				  IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL) |
-		  ATH12K_LE32_DEC_ENC(cmn->info0,
-				      HAL_RX_USIG_CMN_INFO0_BSS_COLOR,
-				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR) |
-		  ATH12K_LE32_DEC_ENC(cmn->info0,
-				      HAL_RX_USIG_CMN_INFO0_TXOP,
-				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
-	ppdu_info->u_sig_info.usig.common = cpu_to_le32(common);
-
-	switch (ppdu_info->u_sig_info.bw) {
-	default:
-		fallthrough;
-	case HAL_EHT_BW_20:
-		ppdu_info->bw = HAL_RX_BW_20MHZ;
-		break;
-	case HAL_EHT_BW_40:
-		ppdu_info->bw = HAL_RX_BW_40MHZ;
-		break;
-	case HAL_EHT_BW_80:
-		ppdu_info->bw = HAL_RX_BW_80MHZ;
-		break;
-	case HAL_EHT_BW_160:
-		ppdu_info->bw = HAL_RX_BW_160MHZ;
-		break;
-	case HAL_EHT_BW_320_1:
-	case HAL_EHT_BW_320_2:
-		ppdu_info->bw = HAL_RX_BW_320MHZ;
-		break;
-	}
-}
-
-static void
-ath12k_dp_mon_hal_rx_parse_u_sig_tb(const struct hal_mon_usig_tb *usig_tb,
-				    struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	struct ieee80211_radiotap_eht_usig *usig = &ppdu_info->u_sig_info.usig;
-	enum ieee80211_radiotap_eht_usig_tb spatial_reuse1, spatial_reuse2;
-	u32 common, value, mask;
-
-	spatial_reuse1 = IEEE80211_RADIOTAP_EHT_USIG2_TB_B3_B6_SPATIAL_REUSE_1;
-	spatial_reuse2 = IEEE80211_RADIOTAP_EHT_USIG2_TB_B7_B10_SPATIAL_REUSE_2;
-
-	common = __le32_to_cpu(usig->common);
-	value = __le32_to_cpu(usig->value);
-	mask = __le32_to_cpu(usig->mask);
-
-	ppdu_info->u_sig_info.ppdu_type_comp_mode =
-				le32_get_bits(usig_tb->info0,
-					      HAL_RX_USIG_TB_INFO0_PPDU_TYPE_COMP_MODE);
-
-	common |= ATH12K_LE32_DEC_ENC(usig_tb->info0,
-				      HAL_RX_USIG_TB_INFO0_RX_INTEG_CHECK_PASS,
-				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
-
-	value |= IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD |
-		 u32_encode_bits(ppdu_info->u_sig_info.ppdu_type_comp_mode,
-				 IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE) |
-		 IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE |
-		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
-				     HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_1,
-				     spatial_reuse1) |
-		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
-				     HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_2,
-				     spatial_reuse2) |
-		 IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD |
-		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
-				     HAL_RX_USIG_TB_INFO0_CRC,
-				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC) |
-		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
-				     HAL_RX_USIG_TB_INFO0_TAIL,
-				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL);
-
-	mask |= IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD |
-		IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE |
-		IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE |
-		spatial_reuse1 | spatial_reuse2 |
-		IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD |
-		IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC |
-		IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL;
-
-	usig->common = cpu_to_le32(common);
-	usig->value = cpu_to_le32(value);
-	usig->mask = cpu_to_le32(mask);
-}
-
-static void
-ath12k_dp_mon_hal_rx_parse_u_sig_mu(const struct hal_mon_usig_mu *usig_mu,
-				    struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	struct ieee80211_radiotap_eht_usig *usig = &ppdu_info->u_sig_info.usig;
-	enum ieee80211_radiotap_eht_usig_mu sig_symb, punc;
-	u32 common, value, mask;
-
-	sig_symb = IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS;
-	punc = IEEE80211_RADIOTAP_EHT_USIG2_MU_B3_B7_PUNCTURED_INFO;
-
-	common = __le32_to_cpu(usig->common);
-	value = __le32_to_cpu(usig->value);
-	mask = __le32_to_cpu(usig->mask);
-
-	ppdu_info->u_sig_info.ppdu_type_comp_mode =
-				le32_get_bits(usig_mu->info0,
-					      HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE);
-	ppdu_info->u_sig_info.eht_sig_mcs =
-				le32_get_bits(usig_mu->info0,
-					      HAL_RX_USIG_MU_INFO0_EHT_SIG_MCS);
-	ppdu_info->u_sig_info.num_eht_sig_sym =
-				le32_get_bits(usig_mu->info0,
-					      HAL_RX_USIG_MU_INFO0_NUM_EHT_SIG_SYM);
-
-	common |= ATH12K_LE32_DEC_ENC(usig_mu->info0,
-				      HAL_RX_USIG_MU_INFO0_RX_INTEG_CHECK_PASS,
-				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
-
-	value |= IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD |
-		 IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE |
-		 u32_encode_bits(ppdu_info->u_sig_info.ppdu_type_comp_mode,
-				 IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE) |
-		 IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE |
-		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
-				     HAL_RX_USIG_MU_INFO0_PUNC_CH_INFO,
-				     punc) |
-		 IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE |
-		 u32_encode_bits(ppdu_info->u_sig_info.eht_sig_mcs,
-				 IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS) |
-		 u32_encode_bits(ppdu_info->u_sig_info.num_eht_sig_sym,
-				 sig_symb) |
-		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
-				     HAL_RX_USIG_MU_INFO0_CRC,
-				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC) |
-		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
-				     HAL_RX_USIG_MU_INFO0_TAIL,
-				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B20_B25_TAIL);
-
-	mask |= IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD |
-		IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE |
-		IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE |
-		IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE |
-		punc |
-		IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE |
-		IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS |
-		sig_symb |
-		IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC |
-		IEEE80211_RADIOTAP_EHT_USIG2_MU_B20_B25_TAIL;
-
-	usig->common = cpu_to_le32(common);
-	usig->value = cpu_to_le32(value);
-	usig->mask = cpu_to_le32(mask);
-}
-
-void
-ath12k_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
-				     struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	u8 comp_mode;
-
-	ppdu_info->eht_usig = true;
-
-	ath12k_dp_mon_hal_rx_parse_u_sig_cmn(&usig->cmn, ppdu_info);
-
-	comp_mode = le32_get_bits(usig->non_cmn.mu.info0,
-				  HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE);
-
-	if (comp_mode == 0 && ppdu_info->u_sig_info.ul_dl)
-		ath12k_dp_mon_hal_rx_parse_u_sig_tb(&usig->non_cmn.tb, ppdu_info);
-	else
-		ath12k_dp_mon_hal_rx_parse_u_sig_mu(&usig->non_cmn.mu, ppdu_info);
-}
-EXPORT_SYMBOL(ath12k_dp_mon_hal_rx_parse_u_sig_hdr);
-
 static inline enum ath12k_eht_ru_size
 hal_rx_mon_hal_ru_size_to_ath12k_ru_size(u32 hal_ru_size)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index d2bee88f561f..063d57512db7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -126,10 +126,6 @@ void
 ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *rx_tlv,
 				       struct hal_rx_mon_ppdu_info *ppdu_info,
 				       struct hal_rx_user_status *rx_user_status);
-void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
-				 struct hal_rx_mon_ppdu_info *ppdu_info);
-void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
-				 struct hal_rx_mon_ppdu_info *ppdu_info);
 void
 ath12k_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *rx_usr_info,
 				     u16 user_id,
@@ -137,7 +133,4 @@ ath12k_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *rx_usr_
 void
 ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
 				    const struct hal_rx_msdu_end *msdu_end);
-void
-ath12k_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
-				     struct hal_rx_mon_ppdu_info *ppdu_info);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index b924180007c5..2d67fd553776 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -31,6 +31,270 @@ ath12k_wifi7_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
 	ppdu_info->peer_id = HAL_INVALID_PEERID;
 }
 
+static void
+ath12k_wifi7_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
+				  struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	u32 info0 = __le32_to_cpu(lsigb->info0);
+	u8 rate;
+
+	rate = u32_get_bits(info0, HAL_RX_LSIG_B_INFO_INFO0_RATE);
+	switch (rate) {
+	case 1:
+		rate = HAL_RX_LEGACY_RATE_1_MBPS;
+		break;
+	case 2:
+	case 5:
+		rate = HAL_RX_LEGACY_RATE_2_MBPS;
+		break;
+	case 3:
+	case 6:
+		rate = HAL_RX_LEGACY_RATE_5_5_MBPS;
+		break;
+	case 4:
+	case 7:
+		rate = HAL_RX_LEGACY_RATE_11_MBPS;
+		break;
+	default:
+		rate = HAL_RX_LEGACY_RATE_INVALID;
+	}
+
+	ppdu_info->rate = rate;
+	ppdu_info->cck_flag = 1;
+}
+
+static void
+ath12k_wifi7_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
+				  struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	u32 info0 = __le32_to_cpu(lsiga->info0);
+	u8 rate;
+
+	rate = u32_get_bits(info0, HAL_RX_LSIG_A_INFO_INFO0_RATE);
+	switch (rate) {
+	case 8:
+		rate = HAL_RX_LEGACY_RATE_48_MBPS;
+		break;
+	case 9:
+		rate = HAL_RX_LEGACY_RATE_24_MBPS;
+		break;
+	case 10:
+		rate = HAL_RX_LEGACY_RATE_12_MBPS;
+		break;
+	case 11:
+		rate = HAL_RX_LEGACY_RATE_6_MBPS;
+		break;
+	case 12:
+		rate = HAL_RX_LEGACY_RATE_54_MBPS;
+		break;
+	case 13:
+		rate = HAL_RX_LEGACY_RATE_36_MBPS;
+		break;
+	case 14:
+		rate = HAL_RX_LEGACY_RATE_18_MBPS;
+		break;
+	case 15:
+		rate = HAL_RX_LEGACY_RATE_9_MBPS;
+		break;
+	default:
+		rate = HAL_RX_LEGACY_RATE_INVALID;
+	}
+
+	ppdu_info->rate = rate;
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_u_sig_cmn(const struct hal_mon_usig_cmn *cmn,
+					   struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	u32 common;
+
+	ppdu_info->u_sig_info.bw = le32_get_bits(cmn->info0,
+						 HAL_RX_USIG_CMN_INFO0_BW);
+	ppdu_info->u_sig_info.ul_dl = le32_get_bits(cmn->info0,
+						    HAL_RX_USIG_CMN_INFO0_UL_DL);
+
+	common = __le32_to_cpu(ppdu_info->u_sig_info.usig.common);
+	common |= IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER_KNOWN |
+		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_KNOWN |
+		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL_KNOWN |
+		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN |
+		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN |
+		  ATH12K_LE32_DEC_ENC(cmn->info0,
+				      HAL_RX_USIG_CMN_INFO0_PHY_VERSION,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER) |
+		  u32_encode_bits(ppdu_info->u_sig_info.bw,
+				  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW) |
+		  u32_encode_bits(ppdu_info->u_sig_info.ul_dl,
+				  IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL) |
+		  ATH12K_LE32_DEC_ENC(cmn->info0,
+				      HAL_RX_USIG_CMN_INFO0_BSS_COLOR,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR) |
+		  ATH12K_LE32_DEC_ENC(cmn->info0,
+				      HAL_RX_USIG_CMN_INFO0_TXOP,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
+	ppdu_info->u_sig_info.usig.common = cpu_to_le32(common);
+
+	switch (ppdu_info->u_sig_info.bw) {
+	default:
+		fallthrough;
+	case HAL_EHT_BW_20:
+		ppdu_info->bw = HAL_RX_BW_20MHZ;
+		break;
+	case HAL_EHT_BW_40:
+		ppdu_info->bw = HAL_RX_BW_40MHZ;
+		break;
+	case HAL_EHT_BW_80:
+		ppdu_info->bw = HAL_RX_BW_80MHZ;
+		break;
+	case HAL_EHT_BW_160:
+		ppdu_info->bw = HAL_RX_BW_160MHZ;
+		break;
+	case HAL_EHT_BW_320_1:
+	case HAL_EHT_BW_320_2:
+		ppdu_info->bw = HAL_RX_BW_320MHZ;
+		break;
+	}
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_u_sig_tb(const struct hal_mon_usig_tb *usig_tb,
+					  struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	struct ieee80211_radiotap_eht_usig *usig = &ppdu_info->u_sig_info.usig;
+	enum ieee80211_radiotap_eht_usig_tb spatial_reuse1, spatial_reuse2;
+	u32 common, value, mask;
+
+	spatial_reuse1 = IEEE80211_RADIOTAP_EHT_USIG2_TB_B3_B6_SPATIAL_REUSE_1;
+	spatial_reuse2 = IEEE80211_RADIOTAP_EHT_USIG2_TB_B7_B10_SPATIAL_REUSE_2;
+
+	common = __le32_to_cpu(usig->common);
+	value = __le32_to_cpu(usig->value);
+	mask = __le32_to_cpu(usig->mask);
+
+	ppdu_info->u_sig_info.ppdu_type_comp_mode =
+				le32_get_bits(usig_tb->info0,
+					      HAL_RX_USIG_TB_INFO0_PPDU_TYPE_COMP_MODE);
+
+	common |= ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				      HAL_RX_USIG_TB_INFO0_RX_INTEG_CHECK_PASS,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
+
+	value |= IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD |
+		 u32_encode_bits(ppdu_info->u_sig_info.ppdu_type_comp_mode,
+				 IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE) |
+		 IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE |
+		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				     HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_1,
+				     spatial_reuse1) |
+		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				     HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_2,
+				     spatial_reuse2) |
+		 IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD |
+		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				     HAL_RX_USIG_TB_INFO0_CRC,
+				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC) |
+		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				     HAL_RX_USIG_TB_INFO0_TAIL,
+				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL);
+
+	mask |= IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD |
+		IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE |
+		IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE |
+		spatial_reuse1 | spatial_reuse2 |
+		IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD |
+		IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC |
+		IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL;
+
+	usig->common = cpu_to_le32(common);
+	usig->value = cpu_to_le32(value);
+	usig->mask = cpu_to_le32(mask);
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_u_sig_mu(const struct hal_mon_usig_mu *usig_mu,
+					  struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	struct ieee80211_radiotap_eht_usig *usig = &ppdu_info->u_sig_info.usig;
+	enum ieee80211_radiotap_eht_usig_mu sig_symb, punc;
+	u32 common, value, mask;
+
+	sig_symb = IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS;
+	punc = IEEE80211_RADIOTAP_EHT_USIG2_MU_B3_B7_PUNCTURED_INFO;
+
+	common = __le32_to_cpu(usig->common);
+	value = __le32_to_cpu(usig->value);
+	mask = __le32_to_cpu(usig->mask);
+
+	ppdu_info->u_sig_info.ppdu_type_comp_mode =
+				le32_get_bits(usig_mu->info0,
+					      HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE);
+	ppdu_info->u_sig_info.eht_sig_mcs =
+				le32_get_bits(usig_mu->info0,
+					      HAL_RX_USIG_MU_INFO0_EHT_SIG_MCS);
+	ppdu_info->u_sig_info.num_eht_sig_sym =
+				le32_get_bits(usig_mu->info0,
+					      HAL_RX_USIG_MU_INFO0_NUM_EHT_SIG_SYM);
+
+	common |= ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				      HAL_RX_USIG_MU_INFO0_RX_INTEG_CHECK_PASS,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
+
+	value |= IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD |
+		 IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE |
+		 u32_encode_bits(ppdu_info->u_sig_info.ppdu_type_comp_mode,
+				 IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE) |
+		 IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE |
+		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				     HAL_RX_USIG_MU_INFO0_PUNC_CH_INFO,
+				     punc) |
+		 IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE |
+		 u32_encode_bits(ppdu_info->u_sig_info.eht_sig_mcs,
+				 IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS) |
+		 u32_encode_bits(ppdu_info->u_sig_info.num_eht_sig_sym,
+				 sig_symb) |
+		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				     HAL_RX_USIG_MU_INFO0_CRC,
+				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC) |
+		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				     HAL_RX_USIG_MU_INFO0_TAIL,
+				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B20_B25_TAIL);
+
+	mask |= IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD |
+		IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE |
+		punc |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS |
+		sig_symb |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B20_B25_TAIL;
+
+	usig->common = cpu_to_le32(common);
+	usig->value = cpu_to_le32(value);
+	usig->mask = cpu_to_le32(mask);
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
+					   struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	u8 comp_mode;
+
+	ppdu_info->eht_usig = true;
+
+	ath12k_wifi7_dp_mon_hal_rx_parse_u_sig_cmn(&usig->cmn, ppdu_info);
+
+	comp_mode = le32_get_bits(usig->non_cmn.mu.info0,
+				  HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE);
+
+	if (comp_mode == 0 && ppdu_info->u_sig_info.ul_dl)
+		ath12k_wifi7_dp_mon_hal_rx_parse_u_sig_tb(&usig->non_cmn.tb, ppdu_info);
+	else
+		ath12k_wifi7_dp_mon_hal_rx_parse_u_sig_mu(&usig->non_cmn.mu, ppdu_info);
+}
+
 static void
 ath12k_wifi7_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vht_sig,
 				    struct hal_rx_mon_ppdu_info *ppdu_info)
@@ -956,11 +1220,11 @@ ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 		break;
 
 	case HAL_PHYRX_L_SIG_B:
-		ath12k_dp_mon_parse_l_sig_b(tlv_data, ppdu_info);
+		ath12k_wifi7_dp_mon_parse_l_sig_b(tlv_data, ppdu_info);
 		break;
 
 	case HAL_PHYRX_L_SIG_A:
-		ath12k_dp_mon_parse_l_sig_a(tlv_data, ppdu_info);
+		ath12k_wifi7_dp_mon_parse_l_sig_a(tlv_data, ppdu_info);
 		break;
 
 	case HAL_PHYRX_VHT_SIG_A:
@@ -1058,7 +1322,7 @@ ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 	case HAL_RX_MPDU_END:
 		return HAL_RX_MON_STATUS_MPDU_END;
 	case HAL_PHYRX_GENERIC_U_SIG:
-		ath12k_dp_mon_hal_rx_parse_u_sig_hdr(tlv_data, ppdu_info);
+		ath12k_wifi7_dp_mon_hal_rx_parse_u_sig_hdr(tlv_data, ppdu_info);
 		break;
 	case HAL_PHYRX_GENERIC_EHT_SIG:
 		/* Handle the case where aggregation is in progress
@@ -1621,11 +1885,11 @@ ath12k_wifi7_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 
 	case HAL_MACTX_L_SIG_A:
-		ath12k_dp_mon_parse_l_sig_a(tlv_data, &tx_ppdu_info->rx_status);
+		ath12k_wifi7_dp_mon_parse_l_sig_a(tlv_data, &tx_ppdu_info->rx_status);
 		break;
 
 	case HAL_MACTX_L_SIG_B:
-		ath12k_dp_mon_parse_l_sig_b(tlv_data, &tx_ppdu_info->rx_status);
+		ath12k_wifi7_dp_mon_parse_l_sig_b(tlv_data, &tx_ppdu_info->rx_status);
 		break;
 
 	case HAL_RX_FRAME_BITMAP_ACK: {
-- 
2.34.1


