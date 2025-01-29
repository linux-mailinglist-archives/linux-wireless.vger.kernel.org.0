Return-Path: <linux-wireless+bounces-18141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CCCA21C08
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 12:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2423D3A18C5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59D1AF0AE;
	Wed, 29 Jan 2025 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AyA04Iim"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED51AD403
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149589; cv=none; b=lWEwOb2YBjaI13whlz3tNJahrNTZ2h7UC3Jj0s5S93wJah5DScbwVBiNnNADbWAkaaeynSsnu9WM5c6H0TukuM68qeH9TYAAVzb+v91e9VRI17+WCT10mvNLvR2AEPcedAHkrL+Yjr/ne0dVbgwNehklm3hdMp+wauMukBhZM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149589; c=relaxed/simple;
	bh=9suhfsEMmIUkIPMf+CLk/qn+nvxyF6AxE3KYg4tisBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mdQemgHsaT7a9OkW7ASB5gjAwBFuOiN03jf0lF6M9ufsIFO3/pQkIjdSHA7ayKeOAnDsSEa1PeiPx9/igX/sy6weJ164yUts158pqWB+w84o876yQsxeRBSmcnAbCeWmSYxLcTmhbozEaXI89VT7ofPDzMKTFe4bmQrKkL3tpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AyA04Iim; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T4vc9S024510;
	Wed, 29 Jan 2025 11:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j+lJiQ3WIbQ3lK98/C2JBmoRPM0T9RDXXtj7uBxAROg=; b=AyA04IimgUGWzlaf
	vK+qxQUuVvBCOTxlG/wEfPhQ+EdChNvrnXceJ6Zb8UfOhKlVUtCX7ifgFAuzRQVr
	rJAXIkf3sFyDMqxvRQd0X5KN8suvwVgUM8kToxbOJsb9oswsnBelCZz2BSzH4dG0
	rmNUp3TJLayEt11c1yrIrbUv1LZFzNBl0KKHK51PO2WVN2OReWzymbQln8wXu8EG
	8nAgzJypsfRl3B8kBUt7KTEjbbFpwylzghRIEtYQQk2HtxUCO9s/L/2xpCCX7EFp
	DVdG+gxMdpGOlfrqxJ1+djqdnl4CRA9Sfb5u5q5KKCVpkHt49mCpKTVyTMX6eANm
	RAibBQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fdrx0kp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 11:19:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TBJhrl015116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 11:19:43 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 03:19:40 -0800
Message-ID: <58974643-c050-6434-574d-abe409924006@quicinc.com>
Date: Wed, 29 Jan 2025 16:49:37 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV
 parsing support
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20250129105810.1094359-1-quic_periyasa@quicinc.com>
 <20250129105810.1094359-3-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250129105810.1094359-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cz4G11i46W7ilwBHxp81q9Mruzmz8UF8
X-Proofpoint-ORIG-GUID: cz4G11i46W7ilwBHxp81q9Mruzmz8UF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290092



On 1/29/2025 4:28 PM, Karthikeyan Periyasamy wrote:
> Currently, monitor is not enabled. However, in the future, the monitor
> will be enabled. Therefore, add the necessary HAL_PHYRX_GENERIC_EHT_SIG
> TLV parsing support in monitor Rx path, which help to populate the EHT
> radiotap data.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 548 +++++++++++++++++++++--
>   drivers/net/wireless/ath/ath12k/hal_rx.h | 136 +++++-
>   2 files changed, 638 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 61fd481b7a3b..dd17607d470d 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -13,6 +13,9 @@
>   #define ATH12K_LE32_DEC_ENC(value, dec_bits, enc_bits)	\
>   		u32_encode_bits(le32_get_bits(value, dec_bits), enc_bits)
>   
> +#define ATH12K_LE64_DEC_ENC(value, dec_bits, enc_bits) \
> +		u32_encode_bits(le64_get_bits(value, dec_bits), enc_bits)
> +
>   static void
>   ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
>   				   struct hal_rx_user_status *rx_user_status)
> @@ -570,11 +573,13 @@ ath12k_dp_mon_hal_rx_parse_u_sig_cmn(const struct hal_mon_usig_cmn *cmn,
>   				     struct hal_rx_mon_ppdu_info *ppdu_info)
>   {
>   	u32 common;
> -	u8 bw;
>   
> -	bw = le32_get_bits(cmn->info0, HAL_RX_USIG_CMN_INFO0_BW);
> +	ppdu_info->u_sig_info.bw = le32_get_bits(cmn->info0,
> +						 HAL_RX_USIG_CMN_INFO0_BW);
> +	ppdu_info->u_sig_info.ul_dl = le32_get_bits(cmn->info0,
> +						    HAL_RX_USIG_CMN_INFO0_UL_DL);
>   
> -	common = __le32_to_cpu(ppdu_info->usig.common);
> +	common = __le32_to_cpu(ppdu_info->u_sig_info.usig.common);
>   	common |= IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER_KNOWN |
>   		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_KNOWN |
>   		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL_KNOWN |
> @@ -583,19 +588,19 @@ ath12k_dp_mon_hal_rx_parse_u_sig_cmn(const struct hal_mon_usig_cmn *cmn,
>   		  ATH12K_LE32_DEC_ENC(cmn->info0,
>   				      HAL_RX_USIG_CMN_INFO0_PHY_VERSION,
>   				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER) |
> -		  u32_encode_bits(bw, IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW) |
> -		  ATH12K_LE32_DEC_ENC(cmn->info0,
> -				      HAL_RX_USIG_CMN_INFO0_UL_DL,
> -				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL) |
> +		  u32_encode_bits(ppdu_info->u_sig_info.bw,
> +				  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW) |
> +		  u32_encode_bits(ppdu_info->u_sig_info.ul_dl,
> +				  IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL) |
>   		  ATH12K_LE32_DEC_ENC(cmn->info0,
>   				      HAL_RX_USIG_CMN_INFO0_BSS_COLOR,
>   				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR) |
>   		  ATH12K_LE32_DEC_ENC(cmn->info0,
>   				      HAL_RX_USIG_CMN_INFO0_TXOP,
>   				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
> -	ppdu_info->usig.common = cpu_to_le32(common);
> +	ppdu_info->u_sig_info.usig.common = cpu_to_le32(common);
>   
> -	switch (bw) {
> +	switch (ppdu_info->u_sig_info.bw) {
>   	default:
>   		fallthrough;
>   	case HAL_EHT_BW_20:
> @@ -621,24 +626,28 @@ static void
>   ath12k_dp_mon_hal_rx_parse_u_sig_tb(const struct hal_mon_usig_tb *usig_tb,
>   				    struct hal_rx_mon_ppdu_info *ppdu_info)
>   {
> +	struct ieee80211_radiotap_eht_usig *usig = &ppdu_info->u_sig_info.usig;
>   	enum ieee80211_radiotap_eht_usig_tb spatial_reuse1, spatial_reuse2;
>   	u32 common, value, mask;
>   
>   	spatial_reuse1 = IEEE80211_RADIOTAP_EHT_USIG2_TB_B3_B6_SPATIAL_REUSE_1;
>   	spatial_reuse2 = IEEE80211_RADIOTAP_EHT_USIG2_TB_B7_B10_SPATIAL_REUSE_2;
>   
> -	common = __le32_to_cpu(ppdu_info->usig.common);
> -	value = __le32_to_cpu(ppdu_info->usig.value);
> -	mask = __le32_to_cpu(ppdu_info->usig.mask);
> +	common = __le32_to_cpu(usig->common);
> +	value = __le32_to_cpu(usig->value);
> +	mask = __le32_to_cpu(usig->mask);
> +
> +	ppdu_info->u_sig_info.ppdu_type_comp_mode =
> +				le32_get_bits(usig_tb->info0,
> +					      HAL_RX_USIG_TB_INFO0_PPDU_TYPE_COMP_MODE);
>   
>   	common |= ATH12K_LE32_DEC_ENC(usig_tb->info0,
>   				      HAL_RX_USIG_TB_INFO0_RX_INTEG_CHECK_PASS,
>   				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
>   
>   	value |= IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD |
> -		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
> -				     HAL_RX_USIG_TB_INFO0_PPDU_TYPE_COMP_MODE,
> -				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE) |
> +		 u32_encode_bits(ppdu_info->u_sig_info.ppdu_type_comp_mode,
> +				 IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE) |
>   		 IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE |
>   		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
>   				     HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_1,
> @@ -662,24 +671,35 @@ ath12k_dp_mon_hal_rx_parse_u_sig_tb(const struct hal_mon_usig_tb *usig_tb,
>   		IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC |
>   		IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL;
>   
> -	ppdu_info->usig.common = cpu_to_le32(common);
> -	ppdu_info->usig.value = cpu_to_le32(value);
> -	ppdu_info->usig.mask = cpu_to_le32(mask);
> +	usig->common = cpu_to_le32(common);
> +	usig->value = cpu_to_le32(value);
> +	usig->mask = cpu_to_le32(mask);
>   }
>   
>   static void
>   ath12k_dp_mon_hal_rx_parse_u_sig_mu(const struct hal_mon_usig_mu *usig_mu,
>   				    struct hal_rx_mon_ppdu_info *ppdu_info)
>   {
> +	struct ieee80211_radiotap_eht_usig *usig = &ppdu_info->u_sig_info.usig;
>   	enum ieee80211_radiotap_eht_usig_mu sig_symb, punc;
>   	u32 common, value, mask;
>   
>   	sig_symb = IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS;
>   	punc = IEEE80211_RADIOTAP_EHT_USIG2_MU_B3_B7_PUNCTURED_INFO;
>   
> -	common = __le32_to_cpu(ppdu_info->usig.common);
> -	value = __le32_to_cpu(ppdu_info->usig.value);
> -	mask = __le32_to_cpu(ppdu_info->usig.mask);
> +	common = __le32_to_cpu(usig->common);
> +	value = __le32_to_cpu(usig->value);
> +	mask = __le32_to_cpu(usig->mask);
> +
> +	ppdu_info->u_sig_info.ppdu_type_comp_mode =
> +				le32_get_bits(usig_mu->info0,
> +					      HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE);
> +	ppdu_info->u_sig_info.eht_sig_mcs =
> +				le32_get_bits(usig_mu->info0,
> +					      HAL_RX_USIG_MU_INFO0_EHT_SIG_MCS);
> +	ppdu_info->u_sig_info.num_eht_sig_sym =
> +				le32_get_bits(usig_mu->info0,
> +					      HAL_RX_USIG_MU_INFO0_NUM_EHT_SIG_SYM);
>   
>   	common |= ATH12K_LE32_DEC_ENC(usig_mu->info0,
>   				      HAL_RX_USIG_MU_INFO0_RX_INTEG_CHECK_PASS,
> @@ -687,20 +707,17 @@ ath12k_dp_mon_hal_rx_parse_u_sig_mu(const struct hal_mon_usig_mu *usig_mu,
>   
>   	value |= IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD |
>   		 IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE |
> -		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
> -				     HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE,
> -				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE) |
> +		 u32_encode_bits(ppdu_info->u_sig_info.ppdu_type_comp_mode,
> +				 IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE) |
>   		 IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE |
>   		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
>   				     HAL_RX_USIG_MU_INFO0_PUNC_CH_INFO,
>   				     punc) |
>   		 IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE |
> -		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
> -				     HAL_RX_USIG_MU_INFO0_EHT_SIG_MCS,
> -				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS) |
> -		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
> -				     HAL_RX_USIG_MU_INFO0_NUM_EHT_SIG_SYM,
> -				     sig_symb) |
> +		 u32_encode_bits(ppdu_info->u_sig_info.eht_sig_mcs,
> +				 IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS) |
> +		 u32_encode_bits(ppdu_info->u_sig_info.num_eht_sig_sym,
> +				 sig_symb) |
>   		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
>   				     HAL_RX_USIG_MU_INFO0_CRC,
>   				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC) |
> @@ -719,33 +736,411 @@ ath12k_dp_mon_hal_rx_parse_u_sig_mu(const struct hal_mon_usig_mu *usig_mu,
>   		IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC |
>   		IEEE80211_RADIOTAP_EHT_USIG2_MU_B20_B25_TAIL;
>   
> -	ppdu_info->usig.common = cpu_to_le32(common);
> -	ppdu_info->usig.value = cpu_to_le32(value);
> -	ppdu_info->usig.mask = cpu_to_le32(mask);
> +	usig->common = cpu_to_le32(common);
> +	usig->value = cpu_to_le32(value);
> +	usig->mask = cpu_to_le32(mask);
>   }
>   
>   static void
>   ath12k_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
>   				     struct hal_rx_mon_ppdu_info *ppdu_info)
>   {
> -	const struct hal_mon_usig_cmn *usig_cmn = &usig->cmn;
>   	u8 comp_mode;
> -	bool ap_ppdu;
>   
>   	ppdu_info->eht_usig = true;
>   
>   	ath12k_dp_mon_hal_rx_parse_u_sig_cmn(&usig->cmn, ppdu_info);
>   
> -	ap_ppdu = le32_get_bits(usig_cmn->info0, HAL_RX_USIG_CMN_INFO0_UL_DL);
>   	comp_mode = le32_get_bits(usig->non_cmn.mu.info0,
>   				  HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE);
>   
> -	if (comp_mode == 0 && ap_ppdu)
> +	if (comp_mode == 0 && ppdu_info->u_sig_info.ul_dl)
>   		ath12k_dp_mon_hal_rx_parse_u_sig_tb(&usig->non_cmn.tb, ppdu_info);
>   	else
>   		ath12k_dp_mon_hal_rx_parse_u_sig_mu(&usig->non_cmn.mu, ppdu_info);
>   }
>   
> +static void
> +ath12k_dp_mon_hal_aggr_tlv(struct hal_rx_mon_ppdu_info *ppdu_info,
> +			   u16 tlv_len, const void *tlv_data)
> +{
> +	if (tlv_len <= HAL_RX_MON_MAX_AGGR_SIZE - ppdu_info->tlv_aggr.cur_len) {
> +		memcpy(ppdu_info->tlv_aggr.buf + ppdu_info->tlv_aggr.cur_len,
> +		       tlv_data, tlv_len);
> +		ppdu_info->tlv_aggr.cur_len += tlv_len;
> +	}
> +}
> +
> +static inline bool
> +ath12k_dp_mon_hal_rx_is_frame_type_ndp(const struct hal_rx_u_sig_info *usig_info)
> +{
> +	if (usig_info->ppdu_type_comp_mode == 1 &&
> +	    usig_info->eht_sig_mcs == 0 &&
> +	    usig_info->num_eht_sig_sym == 0)
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline bool
> +ath12k_dp_mon_hal_rx_is_non_ofdma(const struct hal_rx_u_sig_info *usig_info)
> +{
> +	u32 ppdu_type_comp_mode = usig_info->ppdu_type_comp_mode;
> +	u32 ul_dl = usig_info->ul_dl;
> +
> +	if ((ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_MU_MIMO && ul_dl == 0) ||
> +	    (ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_MU_OFDMA && ul_dl == 0) ||
> +	    (ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_MU_MIMO  && ul_dl == 1))
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline bool
> +ath12k_dp_mon_hal_rx_is_ofdma(const struct hal_rx_u_sig_info *usig_info)
> +{
> +	if (usig_info->ppdu_type_comp_mode == 0 && usig_info->ul_dl == 0)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_eht_sig_ndp(const struct hal_eht_sig_ndp_cmn_eb *eht_sig_ndp,
> +				       struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
> +	u32 known, data;
> +
> +	known = __le32_to_cpu(eht->known);
> +	known |= IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_NSS_S |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_BEAMFORMED_S |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_DISREGARD_S |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_CRC1 |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_TAIL1;
> +	eht->known = cpu_to_le32(known);
> +
> +	data = __le32_to_cpu(eht->data[0]);
> +	data |= ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
> +				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_SPATIAL_REUSE,
> +				    IEEE80211_RADIOTAP_EHT_DATA0_SPATIAL_REUSE);
> +	/* GI and LTF size are separately indicated in radiotap header
> +	 * and hence will be parsed from other TLV
> +	 */
> +	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
> +				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_NUM_LTF_SYM,
> +				    IEEE80211_RADIOTAP_EHT_DATA0_EHT_LTF);
> +
> +	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
> +				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_CRC,
> +				    IEEE80211_RADIOTAP_EHT_DATA0_CRC1_O);
> +
> +	data |= ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
> +				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_DISREGARD,
> +				    IEEE80211_RADIOTAP_EHT_DATA0_DISREGARD_S);
> +	eht->data[0] = cpu_to_le32(data);
> +
> +	data = __le32_to_cpu(eht->data[7]);
> +	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
> +				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_NSS,
> +				    IEEE80211_RADIOTAP_EHT_DATA7_NSS_S);
> +
> +	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
> +				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_BEAMFORMED,
> +				    IEEE80211_RADIOTAP_EHT_DATA7_BEAMFORMED_S);
> +	eht->data[7] = cpu_to_le32(data);
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_usig_overflow(const struct hal_eht_sig_usig_overflow *ovflow,
> +					 struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
> +	u32 known, data;
> +
> +	known = __le32_to_cpu(eht->known);
> +	known |= IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_LDPC_EXTRA_SYM_OM |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_PRE_PADD_FACOR_OM |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_PE_DISAMBIGUITY_OM |
> +		 IEEE80211_RADIOTAP_EHT_KNOWN_DISREGARD_O;
> +	eht->known = cpu_to_le32(known);
> +
> +	data = __le32_to_cpu(eht->data[0]);
> +	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
> +				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_SPATIAL_REUSE,
> +				    IEEE80211_RADIOTAP_EHT_DATA0_SPATIAL_REUSE);
> +
> +	/* GI and LTF size are separately indicated in radiotap header
> +	 * and hence will be parsed from other TLV
> +	 */
> +	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
> +				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_NUM_LTF_SYM,
> +				    IEEE80211_RADIOTAP_EHT_DATA0_EHT_LTF);
> +
> +	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
> +				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_LDPC_EXTA_SYM,
> +				    IEEE80211_RADIOTAP_EHT_DATA0_LDPC_EXTRA_SYM_OM);
> +
> +	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
> +				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_PRE_FEC_PAD_FACTOR,
> +				    IEEE80211_RADIOTAP_EHT_DATA0_PRE_PADD_FACOR_OM);
> +
> +	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
> +				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_DISAMBIGUITY,
> +				    IEEE80211_RADIOTAP_EHT_DATA0_PE_DISAMBIGUITY_OM);
> +
> +	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
> +				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_DISREGARD,
> +				    IEEE80211_RADIOTAP_EHT_DATA0_DISREGARD_O);
> +	eht->data[0] = cpu_to_le32(data);
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_non_ofdma_users(const struct hal_eht_sig_non_ofdma_cmn_eb *eb,
> +					   struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
> +	u32 known, data;
> +
> +	known = __le32_to_cpu(eht->known);
> +	known |= IEEE80211_RADIOTAP_EHT_KNOWN_NR_NON_OFDMA_USERS_M;
> +	eht->known = cpu_to_le32(known);
> +
> +	data = __le32_to_cpu(eht->data[7]);
> +	data |=	ATH12K_LE32_DEC_ENC(eb->info0,
> +				    HAL_RX_EHT_SIG_NON_OFDMA_INFO0_NUM_USERS,
> +				    IEEE80211_RADIOTAP_EHT_DATA7_NUM_OF_NON_OFDMA_USERS);
> +	eht->data[7] = cpu_to_le32(data);
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_eht_mumimo_user(const struct hal_eht_sig_mu_mimo *user,
> +					   struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	struct hal_rx_eht_info *eht_info = &ppdu_info->eht_info;
> +	u32 user_idx;
> +
> +	if (eht_info->num_user_info >= ARRAY_SIZE(eht_info->user_info))
> +		return;
> +
> +	user_idx = eht_info->num_user_info++;
> +
> +	eht_info->user_info[user_idx] |=
> +		IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN |
> +		IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
> +		IEEE80211_RADIOTAP_EHT_USER_INFO_CODING_KNOWN |
> +		IEEE80211_RADIOTAP_EHT_USER_INFO_SPATIAL_CONFIG_KNOWN_M |
> +		ATH12K_LE32_DEC_ENC(user->info0,
> +				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_STA_ID,
> +				    IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID) |
> +		ATH12K_LE32_DEC_ENC(user->info0,
> +				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_CODING,
> +				    IEEE80211_RADIOTAP_EHT_USER_INFO_CODING) |
> +		ATH12K_LE32_DEC_ENC(user->info0,
> +				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_MCS,
> +				    IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
> +		ATH12K_LE32_DEC_ENC(user->info0,
> +				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_SPATIAL_CODING,
> +				    IEEE80211_RADIOTAP_EHT_USER_INFO_SPATIAL_CONFIG_M);
> +
> +	ppdu_info->mcs = le32_get_bits(user->info0,
> +				       HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_MCS);
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_eht_non_mumimo_user(const struct hal_eht_sig_non_mu_mimo *user,
> +					       struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	struct hal_rx_eht_info *eht_info = &ppdu_info->eht_info;
> +	u32 user_idx;
> +
> +	if (eht_info->num_user_info >= ARRAY_SIZE(eht_info->user_info))
> +		return;
> +
> +	user_idx = eht_info->num_user_info++;
> +
> +	eht_info->user_info[user_idx] |=
> +		IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN |
> +		IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
> +		IEEE80211_RADIOTAP_EHT_USER_INFO_CODING_KNOWN |
> +		IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O |
> +		IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_KNOWN_O |
> +		ATH12K_LE32_DEC_ENC(user->info0,
> +				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_STA_ID,
> +				    IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID) |
> +		ATH12K_LE32_DEC_ENC(user->info0,
> +				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_CODING,
> +				    IEEE80211_RADIOTAP_EHT_USER_INFO_CODING) |
> +		ATH12K_LE32_DEC_ENC(user->info0,
> +				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_MCS,
> +				    IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
> +		ATH12K_LE32_DEC_ENC(user->info0,
> +				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_NSS,
> +				    IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O) |
> +		ATH12K_LE32_DEC_ENC(user->info0,
> +				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_BEAMFORMED,
> +				    IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_O);
> +
> +	ppdu_info->mcs = le32_get_bits(user->info0,
> +				       HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_MCS);
> +
> +	ppdu_info->nss = le32_get_bits(user->info0,
> +				       HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_NSS) + 1;
> +}
> +
> +static inline bool
> +ath12k_dp_mon_hal_rx_is_mu_mimo_user(const struct hal_rx_u_sig_info *usig_info)
> +{
> +	if (usig_info->ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_SU &&
> +	    usig_info->ul_dl == 1)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_eht_sig_non_ofdma(const void *tlv,
> +					     struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	const struct hal_eht_sig_non_ofdma_cmn_eb *eb = tlv;
> +
> +	ath12k_dp_mon_hal_rx_parse_usig_overflow(tlv, ppdu_info);
> +	ath12k_dp_mon_hal_rx_parse_non_ofdma_users(eb, ppdu_info);
> +
> +	if (ath12k_dp_mon_hal_rx_is_mu_mimo_user(&ppdu_info->u_sig_info))
> +		ath12k_dp_mon_hal_rx_parse_eht_mumimo_user(&eb->user_field.mu_mimo,
> +							   ppdu_info);
> +	else
> +		ath12k_dp_mon_hal_rx_parse_eht_non_mumimo_user(&eb->user_field.n_mu_mimo,
> +							       ppdu_info);
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_ru_allocation(const struct hal_eht_sig_ofdma_cmn_eb *eb,
> +					 struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	const struct hal_eht_sig_ofdma_cmn_eb1 *ofdma_cmn_eb1 = &eb->eb1;
> +	const struct hal_eht_sig_ofdma_cmn_eb2 *ofdma_cmn_eb2 = &eb->eb2;
> +	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
> +	enum ieee80211_radiotap_eht_data ru_123, ru_124, ru_125, ru_126;
> +	enum ieee80211_radiotap_eht_data ru_121, ru_122, ru_112, ru_111;
> +	u32 data;
> +
> +	ru_123 = IEEE80211_RADIOTAP_EHT_DATA4_RU_ALLOC_CC_1_2_3;
> +	ru_124 = IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_4;
> +	ru_125 = IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_5;
> +	ru_126 = IEEE80211_RADIOTAP_EHT_DATA6_RU_ALLOC_CC_1_2_6;
> +	ru_121 = IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_1;
> +	ru_122 = IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_2;
> +	ru_112 = IEEE80211_RADIOTAP_EHT_DATA2_RU_ALLOC_CC_1_1_2;
> +	ru_111 = IEEE80211_RADIOTAP_EHT_DATA1_RU_ALLOC_CC_1_1_1;
> +
> +	switch (ppdu_info->u_sig_info.bw) {
> +	case HAL_EHT_BW_320_2:
> +	case HAL_EHT_BW_320_1:
> +		data = __le32_to_cpu(eht->data[4]);
> +		/* CC1 2::3 */
> +		data |=	IEEE80211_RADIOTAP_EHT_DATA4_RU_ALLOC_CC_1_2_3_KNOWN |
> +			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
> +					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_3,
> +					    ru_123);
> +		eht->data[4] = cpu_to_le32(data);
> +
> +		data = __le32_to_cpu(eht->data[5]);
> +		/* CC1 2::4 */
> +		data |=	IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_4_KNOWN |
> +			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
> +					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_4,
> +					    ru_124);
> +
> +		/* CC1 2::5 */
> +		data |=	IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_5_KNOWN |
> +			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
> +					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_5,
> +					    ru_125);
> +		eht->data[5] = cpu_to_le32(data);
> +
> +		data = __le32_to_cpu(eht->data[6]);
> +		/* CC1 2::6 */
> +		data |=	IEEE80211_RADIOTAP_EHT_DATA6_RU_ALLOC_CC_1_2_6_KNOWN |
> +			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
> +					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_6,
> +					    ru_126);
> +		eht->data[6] = cpu_to_le32(data);
> +
> +		fallthrough;
> +	case HAL_EHT_BW_160:
> +		data = __le32_to_cpu(eht->data[3]);
> +		/* CC1 2::1 */
> +		data |=	IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_1_KNOWN |
> +			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
> +					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_1,
> +					    ru_121);
> +		/* CC1 2::2 */
> +		data |=	IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_2_KNOWN |
> +			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
> +					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_2,
> +					    ru_122);
> +		eht->data[3] = cpu_to_le32(data);
> +
> +		fallthrough;
> +	case HAL_EHT_BW_80:
> +		data = __le32_to_cpu(eht->data[2]);
> +		/* CC1 1::2 */
> +		data |=	IEEE80211_RADIOTAP_EHT_DATA2_RU_ALLOC_CC_1_1_2_KNOWN |
> +			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb1->info0,
> +					    HAL_RX_EHT_SIG_OFDMA_EB1_RU_ALLOC_1_2,
> +					    ru_112);
> +		eht->data[2] = cpu_to_le32(data);
> +
> +		fallthrough;
> +	case HAL_EHT_BW_40:
> +		fallthrough;
> +	case HAL_EHT_BW_20:
> +		data = __le32_to_cpu(eht->data[1]);
> +		/* CC1 1::1 */
> +		data |=	IEEE80211_RADIOTAP_EHT_DATA1_RU_ALLOC_CC_1_1_1_KNOWN |
> +			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb1->info0,
> +					    HAL_RX_EHT_SIG_OFDMA_EB1_RU_ALLOC_1_1,
> +					    ru_111);
> +		eht->data[1] = cpu_to_le32(data);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_eht_sig_ofdma(const void *tlv,
> +					 struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	const struct hal_eht_sig_ofdma_cmn_eb *ofdma = tlv;
> +
> +	ath12k_dp_mon_hal_rx_parse_usig_overflow(tlv, ppdu_info);
> +	ath12k_dp_mon_hal_rx_parse_ru_allocation(ofdma, ppdu_info);
> +
> +	ath12k_dp_mon_hal_rx_parse_eht_non_mumimo_user(&ofdma->user_field.n_mu_mimo,
> +						       ppdu_info);
> +}
> +
> +static void
> +ath12k_dp_mon_parse_eht_sig_hdr(struct hal_rx_mon_ppdu_info *ppdu_info,
> +				const void *tlv_data)
> +{
> +	ppdu_info->is_eht = true;
> +
> +	if (ath12k_dp_mon_hal_rx_is_frame_type_ndp(&ppdu_info->u_sig_info))
> +		ath12k_dp_mon_hal_rx_parse_eht_sig_ndp(tlv_data, ppdu_info);
> +	else if (ath12k_dp_mon_hal_rx_is_non_ofdma(&ppdu_info->u_sig_info))
> +		ath12k_dp_mon_hal_rx_parse_eht_sig_non_ofdma(tlv_data, ppdu_info);
> +	else if (ath12k_dp_mon_hal_rx_is_ofdma(&ppdu_info->u_sig_info))
> +		ath12k_dp_mon_hal_rx_parse_eht_sig_ofdma(tlv_data, ppdu_info);
> +}
> +
>   static enum hal_rx_mon_status
>   ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>   				  struct ath12k_mon_data *pmon,
> @@ -754,11 +1149,19 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>   	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
>   	const void *tlv_data = tlv->value;
>   	u32 info[7], userid;
> -	u16 tlv_tag;
> +	u16 tlv_tag, tlv_len;
>   
>   	tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
> +	tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
>   	userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
>   
> +	if (ppdu_info->tlv_aggr.in_progress && ppdu_info->tlv_aggr.tlv_tag != tlv_tag) {
> +		ath12k_dp_mon_parse_eht_sig_hdr(ppdu_info, ppdu_info->tlv_aggr.buf);
> +
> +		ppdu_info->tlv_aggr.in_progress = false;
> +		ppdu_info->tlv_aggr.cur_len = 0;
> +	}
> +
>   	switch (tlv_tag) {
>   	case HAL_RX_PPDU_START: {
>   		const struct hal_rx_ppdu_start *ppdu_start = tlv_data;
> @@ -836,6 +1239,9 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>   		case HAL_RX_PREAMBLE_11AX:
>   			ppdu_info->he_flags = 1;
>   			break;
> +		case HAL_RX_PREAMBLE_11BE:
> +			ppdu_info->is_eht = true;
> +			break;
>   		default:
>   			break;
>   		}
> @@ -961,6 +1367,21 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>   	case HAL_PHYRX_GENERIC_U_SIG:
>   		ath12k_dp_mon_hal_rx_parse_u_sig_hdr(tlv_data, ppdu_info);
>   		break;
> +	case HAL_PHYRX_GENERIC_EHT_SIG:
> +		/* Handle the case where aggregation is in progress
> +		 * or the current TLV is one of the TLVs which should be
> +		 * aggregated
> +		 */
> +		if (!ppdu_info->tlv_aggr.in_progress) {
> +			ppdu_info->tlv_aggr.in_progress = true;
> +			ppdu_info->tlv_aggr.tlv_tag = tlv_tag;
> +			ppdu_info->tlv_aggr.cur_len = 0;
> +		}
> +
> +		ppdu_info->is_eht = true;
> +
> +		ath12k_dp_mon_hal_aggr_tlv(ppdu_info, tlv_len, tlv_data);
> +		break;
>   	case HAL_DUMMY:
>   		return HAL_RX_MON_STATUS_BUF_DONE;
>   	case HAL_RX_PPDU_END_STATUS_DONE:
> @@ -1158,22 +1579,59 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
>   		rxs->ampdu_reference = ampdu_id;
>   	}
>   
> -	if (ppduinfo->eht_usig) {
> +	if (ppduinfo->is_eht || ppduinfo->eht_usig) {
>   		struct ieee80211_radiotap_tlv *tlv;
> +		struct ieee80211_radiotap_eht *eht;
>   		struct ieee80211_radiotap_eht_usig *usig;
> -		u16 len = sizeof(*usig);
> +		u16 len = 0, i, eht_len, usig_len;
> +		u8 user;
> +
> +		if (ppduinfo->is_eht) {
> +			eht_len = struct_size(eht,
> +					      user_info,
> +					      ppduinfo->eht_info.num_user_info);
> +			len += sizeof(*tlv) + eht_len;
> +		}
> +
> +		if (ppduinfo->eht_usig) {
> +			usig_len = sizeof(*usig);
> +			len += sizeof(*tlv) + usig_len;
> +		}
>   
>   		rxs->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
>   		rxs->encoding = RX_ENC_EHT;
>   
>   		skb_reset_mac_header(mon_skb);
>   
> -		tlv = skb_push(mon_skb, sizeof(*tlv) + len);
> -		tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT_USIG);
> -		tlv->len = cpu_to_le16(len);
> +		tlv = skb_push(mon_skb, len);
> +
> +		if (ppduinfo->is_eht) {
> +			tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT);
> +			tlv->len = cpu_to_le16(eht_len);
>   
> -		usig = (struct ieee80211_radiotap_eht_usig *)tlv->data;
> -		*usig = ppduinfo->usig;
> +			eht = (struct ieee80211_radiotap_eht *)tlv->data;
> +			eht->known = ppduinfo->eht_info.eht.known;
> +
> +			for (i = 0;
> +			     i < ARRAY_SIZE(eht->data) &&
> +			     i < ARRAY_SIZE(ppduinfo->eht_info.eht.data);
> +			     i++)
> +				eht->data[i] = ppduinfo->eht_info.eht.data[i];
> +
> +			for (user = 0; user < ppduinfo->eht_info.num_user_info; user++)
> +				put_unaligned_le32(ppduinfo->eht_info.user_info[user],
> +						   &eht->user_info[user]);
> +
> +			tlv = (struct ieee80211_radiotap_tlv *)&tlv->data[eht_len];
> +		}
> +
> +		if (ppduinfo->eht_usig) {
> +			tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT_USIG);
> +			tlv->len = cpu_to_le16(usig_len);
> +
> +			usig = (struct ieee80211_radiotap_eht_usig *)tlv->data;
> +			*usig = ppduinfo->u_sig_info.usig;
> +		}
>   	} else if (ppduinfo->he_mu_flags) {
>   		rxs->flag |= RX_FLAG_RADIOTAP_HE_MU;
>   		rxs->encoding = RX_ENC_HE;
> diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
> index 2da16f27e76c..959f2283294c 100644
> --- a/drivers/net/wireless/ath/ath12k/hal_rx.h
> +++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
> @@ -71,6 +71,8 @@ enum hal_rx_preamble {
>   	HAL_RX_PREAMBLE_11N,
>   	HAL_RX_PREAMBLE_11AC,
>   	HAL_RX_PREAMBLE_11AX,
> +	HAL_RX_PREAMBLE_11BA,
> +	HAL_RX_PREAMBLE_11BE,
>   	HAL_RX_PREAMBLE_MAX,
>   };
>   
> @@ -150,6 +152,37 @@ struct hal_rx_user_status {
>   
>   #define HAL_MAX_UL_MU_USERS	37
>   
> +struct hal_rx_u_sig_info {
> +	bool ul_dl;
> +	u8 bw;
> +	u8 ppdu_type_comp_mode;
> +	u8 eht_sig_mcs;
> +	u8 num_eht_sig_sym;
> +	struct ieee80211_radiotap_eht_usig usig;
> +};
> +
> +#define HAL_RX_MON_MAX_AGGR_SIZE	128
> +
> +struct hal_rx_tlv_aggr_info {
> +	bool in_progress;
> +	u16 cur_len;
> +	u16 tlv_tag;
> +	u8 buf[HAL_RX_MON_MAX_AGGR_SIZE];
> +};
> +
> +struct hal_rx_radiotap_eht {
> +	__le32 known;
> +	__le32 data[9];
> +};
> +
> +#define EHT_MAX_USER_INFO	4
> +
> +struct hal_rx_eht_info {
> +	u8 num_user_info;
> +	struct hal_rx_radiotap_eht eht;
> +	u32 user_info[EHT_MAX_USER_INFO];
> +};
> +
>   struct hal_rx_mon_ppdu_info {
>   	u32 ppdu_id;
>   	u32 last_ppdu_id;
> @@ -236,7 +269,10 @@ struct hal_rx_mon_ppdu_info {
>   	u8 medium_prot_type;
>   	bool ppdu_continuation;
>   	bool eht_usig;
> -	struct ieee80211_radiotap_eht_usig usig;
> +	struct hal_rx_u_sig_info u_sig_info;
> +	bool is_eht;
> +	struct hal_rx_eht_info eht_info;
> +	struct hal_rx_tlv_aggr_info tlv_aggr;
>   };
>   
>   #define HAL_RX_PPDU_START_INFO0_PPDU_ID			GENMASK(15, 0)
> @@ -647,6 +683,104 @@ struct hal_rx_resp_req_info {
>   #define HAL_RX_MPDU_ERR_MPDU_LEN		BIT(6)
>   #define HAL_RX_MPDU_ERR_UNENCRYPTED_FRAME	BIT(7)
>   
> +#define HAL_RX_EHT_SIG_NDP_CMN_INFO0_SPATIAL_REUSE	GENMASK(3, 0)
> +#define HAL_RX_EHT_SIG_NDP_CMN_INFO0_GI_LTF		GENMASK(5, 4)
> +#define HAL_RX_EHT_SIG_NDP_CMN_INFO0_NUM_LTF_SYM	GENMASK(8, 6)
> +#define HAL_RX_EHT_SIG_NDP_CMN_INFO0_NSS		GENMASK(10, 7)
> +#define HAL_RX_EHT_SIG_NDP_CMN_INFO0_BEAMFORMED		BIT(11)
> +#define HAL_RX_EHT_SIG_NDP_CMN_INFO0_DISREGARD		GENMASK(13, 12)
> +#define HAL_RX_EHT_SIG_NDP_CMN_INFO0_CRC		GENMASK(17, 14)
> +
> +struct hal_eht_sig_ndp_cmn_eb {
> +	__le32 info0;
> +} __packed;
> +
> +#define HAL_RX_EHT_SIG_OVERFLOW_INFO0_SPATIAL_REUSE		GENMASK(3, 0)
> +#define HAL_RX_EHT_SIG_OVERFLOW_INFO0_GI_LTF			GENMASK(5, 4)
> +#define HAL_RX_EHT_SIG_OVERFLOW_INFO0_NUM_LTF_SYM		GENMASK(8, 6)
> +#define HAL_RX_EHT_SIG_OVERFLOW_INFO0_LDPC_EXTA_SYM		BIT(9)
> +#define HAL_RX_EHT_SIG_OVERFLOW_INFO0_PRE_FEC_PAD_FACTOR	GENMASK(11, 10)
> +#define HAL_RX_EHT_SIG_OVERFLOW_INFO0_DISAMBIGUITY		BIT(12)
> +#define HAL_RX_EHT_SIG_OVERFLOW_INFO0_DISREGARD			GENMASK(16, 13)
> +
> +struct hal_eht_sig_usig_overflow {
> +	__le32 info0;
> +} __packed;
> +
> +#define HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_STA_ID	GENMASK(10, 0)
> +#define HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_MCS	GENMASK(14, 11)
> +#define HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_VALIDATE	BIT(15)
> +#define HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_NSS	GENMASK(19, 16)
> +#define HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_BEAMFORMED	BIT(20)
> +#define HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_CODING	BIT(21)
> +#define HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_CRC	GENMASK(25, 22)
> +
> +struct hal_eht_sig_non_mu_mimo {
> +	__le32 info0;
> +} __packed;
> +
> +#define HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_STA_ID		GENMASK(10, 0)
> +#define HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_MCS		GENMASK(14, 11)
> +#define HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_CODING		BIT(15)
> +#define HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_SPATIAL_CODING	GENMASK(22, 16)
> +#define HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_CRC		GENMASK(26, 23)
> +
> +struct hal_eht_sig_mu_mimo {
> +	__le32 info0;
> +} __packed;
> +
> +union hal_eht_sig_user_field {
> +	struct hal_eht_sig_mu_mimo mu_mimo;
> +	struct hal_eht_sig_non_mu_mimo n_mu_mimo;
> +};
> +
> +#define HAL_RX_EHT_SIG_NON_OFDMA_INFO0_SPATIAL_REUSE		GENMASK(3, 0)
> +#define HAL_RX_EHT_SIG_NON_OFDMA_INFO0_GI_LTF			GENMASK(5, 4)
> +#define HAL_RX_EHT_SIG_NON_OFDMA_INFO0_NUM_LTF_SYM		GENMASK(8, 6)
> +#define HAL_RX_EHT_SIG_NON_OFDMA_INFO0_LDPC_EXTA_SYM		BIT(9)
> +#define HAL_RX_EHT_SIG_NON_OFDMA_INFO0_PRE_FEC_PAD_FACTOR	GENMASK(11, 10)
> +#define HAL_RX_EHT_SIG_NON_OFDMA_INFO0_DISAMBIGUITY		BIT(12)
> +#define HAL_RX_EHT_SIG_NON_OFDMA_INFO0_DISREGARD		GENMASK(16, 13)
> +#define HAL_RX_EHT_SIG_NON_OFDMA_INFO0_NUM_USERS		GENMASK(19, 17)
> +
> +struct hal_eht_sig_non_ofdma_cmn_eb {
> +	__le32 info0;
> +	union hal_eht_sig_user_field user_field;
> +} __packed;
> +
> +#define HAL_RX_EHT_SIG_OFDMA_EB1_SPATIAL_REUSE		GENMASK_ULL(3, 0)
> +#define HAL_RX_EHT_SIG_OFDMA_EB1_GI_LTF			GENMASK_ULL(5, 4)
> +#define HAL_RX_EHT_SIG_OFDMA_EB1_NUM_LFT_SYM		GENMASK_ULL(8, 6)
> +#define HAL_RX_EHT_SIG_OFDMA_EB1_LDPC_EXTRA_SYM		BIT(9)
> +#define HAL_RX_EHT_SIG_OFDMA_EB1_PRE_FEC_PAD_FACTOR	GENMASK_ULL(11, 10)
> +#define HAL_RX_EHT_SIG_OFDMA_EB1_PRE_DISAMBIGUITY	BIT(12)
> +#define HAL_RX_EHT_SIG_OFDMA_EB1_DISREGARD		GENMASK_ULL(16, 13)
> +#define HAL_RX_EHT_SIG_OFDMA_EB1_RU_ALLOC_1_1		GENMASK_ULL(25, 17)
> +#define HAL_RX_EHT_SIG_OFDMA_EB1_RU_ALLOC_1_2		GENMASK_ULL(34, 26)
> +#define HAL_RX_EHT_SIG_OFDMA_EB1_CRC			GENMASK_ULL(30, 27)
> +
> +struct hal_eht_sig_ofdma_cmn_eb1 {
> +	__le64 info0;
> +} __packed;
> +
> +#define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_1		GENMASK_ULL(8, 0)
> +#define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_2		GENMASK_ULL(17, 9)
> +#define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_3		GENMASK_ULL(26, 18)
> +#define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_4		GENMASK_ULL(35, 27)
> +#define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_5		GENMASK_ULL(44, 36)
> +#define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_6		GENMASK_ULL(53, 45)
> +#define HAL_RX_EHT_SIG_OFDMA_EB2_MCS			GNEMASK_ULL(57, 54)
> +
> +struct hal_eht_sig_ofdma_cmn_eb2 {
> +	__le64 info0;
> +} __packed;
> +
> +struct hal_eht_sig_ofdma_cmn_eb {
> +	struct hal_eht_sig_ofdma_cmn_eb1 eb1;
> +	struct hal_eht_sig_ofdma_cmn_eb2 eb2;
> +	union hal_eht_sig_user_field user_field;
> +} __packed;
> +
>   static inline
>   enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
>   {

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

