Return-Path: <linux-wireless+bounces-18140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1766A21C07
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 12:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CF87A036C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83791AF0AE;
	Wed, 29 Jan 2025 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WaljcnQm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07DC19DF60
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149543; cv=none; b=SrGaJNjlbzfphDMmlRwYZLnyj1TKG1GkYc1iooxhaUG/LVSsPpQa841p6tGKvksvwsSKI7HWGijapa3jHV00bLmiwzup7w3FPCSrXprSi9XqkfHO84VPOrihZXGMY/W5j78xytvZuhBph1sZk0qYqfiB0IJjAc1kwSsRpV+TBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149543; c=relaxed/simple;
	bh=VQ6Froh//FToCdjvS6MmwCXCFpixqdI2LWgD85HYyv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tsTtEGLKWyp+6PLO4N0rR+4Qk4TRU9GfnU8AxIIufmijDa4KDj/svWLbkS0j2aPJm3OKbP2ojYYTAUMkJCpiN5w0xJO5OtpXNKZlKZ7qMEFATZUZHeaGM72hQXVSATQHzqy0QOxRq+EpBsWmmr1HbrX7XXJbw4mERw7xen2G1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WaljcnQm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8TQgQ028147;
	Wed, 29 Jan 2025 11:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ze7mrcmcgGA2sAegdTKV4u6m+DscwuEWPaBYuZHuIFM=; b=WaljcnQmFs8A/TO7
	wPm74jw8r42VYVg0tiPGbP/OiqqzjQmH+xUHu/o+lKPjvO4VHSWrTPPu5RRVuyTe
	OPowoj+Vj3qQohoZpBEezUVLnbwQzcru8GzmA0/9OtIwwInyCLsquy+NRyrpLZxz
	HuXqTIQrsG7dY3bTvwezA1taSCBh6FA/XngtK5fIW5esOR4+UsT7Oa27vwrzGbAv
	n35nrR7V4Ao5NiIKNPOb9E7dEgyvb3aLHPqeCmmkXlOeTrljAQaD4q3+L1M+O9UH
	VTKvb0EG9WbN/t4+p9UW+FBwwzrO4kJVU8Oj4GpRmV/8tpxfNdpAf1dP4BwBChTB
	krbb5Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fguxg9hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 11:18:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TBItl8013577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 11:18:55 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 03:18:52 -0800
Message-ID: <62daf3e1-171f-2079-296a-eee39c811d6e@quicinc.com>
Date: Wed, 29 Jan 2025 16:48:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV
 parsing support
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20250129105810.1094359-1-quic_periyasa@quicinc.com>
 <20250129105810.1094359-2-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250129105810.1094359-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OSgjAud-6jM1sNWj1rYqkTj8h0gV_XwP
X-Proofpoint-GUID: OSgjAud-6jM1sNWj1rYqkTj8h0gV_XwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290092



On 1/29/2025 4:28 PM, Karthikeyan Periyasamy wrote:
> Currently, monitor is not enabled. However, in the future, the monitor
> will be enabled. Therefore, add the necessary HAL_PHYRX_GENERIC_U_SIG TLV
> parsing support in monitor Rx path, which help to populate the EHT
> radiotap data.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 205 ++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/hal_rx.h |  60 +++++++
>   2 files changed, 264 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 4e9a60181c06..61fd481b7a3b 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -10,6 +10,9 @@
>   #include "dp_tx.h"
>   #include "peer.h"
>   
> +#define ATH12K_LE32_DEC_ENC(value, dec_bits, enc_bits)	\
> +		u32_encode_bits(le32_get_bits(value, dec_bits), enc_bits)
> +
>   static void
>   ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
>   				   struct hal_rx_user_status *rx_user_status)
> @@ -562,6 +565,187 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
>   	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
>   }
>   
> +static void
> +ath12k_dp_mon_hal_rx_parse_u_sig_cmn(const struct hal_mon_usig_cmn *cmn,
> +				     struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	u32 common;
> +	u8 bw;
> +
> +	bw = le32_get_bits(cmn->info0, HAL_RX_USIG_CMN_INFO0_BW);
> +
> +	common = __le32_to_cpu(ppdu_info->usig.common);
> +	common |= IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER_KNOWN |
> +		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_KNOWN |
> +		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL_KNOWN |
> +		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN |
> +		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN |
> +		  ATH12K_LE32_DEC_ENC(cmn->info0,
> +				      HAL_RX_USIG_CMN_INFO0_PHY_VERSION,
> +				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER) |
> +		  u32_encode_bits(bw, IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW) |
> +		  ATH12K_LE32_DEC_ENC(cmn->info0,
> +				      HAL_RX_USIG_CMN_INFO0_UL_DL,
> +				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL) |
> +		  ATH12K_LE32_DEC_ENC(cmn->info0,
> +				      HAL_RX_USIG_CMN_INFO0_BSS_COLOR,
> +				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR) |
> +		  ATH12K_LE32_DEC_ENC(cmn->info0,
> +				      HAL_RX_USIG_CMN_INFO0_TXOP,
> +				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
> +	ppdu_info->usig.common = cpu_to_le32(common);
> +
> +	switch (bw) {
> +	default:
> +		fallthrough;
> +	case HAL_EHT_BW_20:
> +		ppdu_info->bw = HAL_RX_BW_20MHZ;
> +		break;
> +	case HAL_EHT_BW_40:
> +		ppdu_info->bw = HAL_RX_BW_40MHZ;
> +		break;
> +	case HAL_EHT_BW_80:
> +		ppdu_info->bw = HAL_RX_BW_80MHZ;
> +		break;
> +	case HAL_EHT_BW_160:
> +		ppdu_info->bw = HAL_RX_BW_160MHZ;
> +		break;
> +	case HAL_EHT_BW_320_1:
> +	case HAL_EHT_BW_320_2:
> +		ppdu_info->bw = HAL_RX_BW_320MHZ;
> +		break;
> +	}
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_u_sig_tb(const struct hal_mon_usig_tb *usig_tb,
> +				    struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	enum ieee80211_radiotap_eht_usig_tb spatial_reuse1, spatial_reuse2;
> +	u32 common, value, mask;
> +
> +	spatial_reuse1 = IEEE80211_RADIOTAP_EHT_USIG2_TB_B3_B6_SPATIAL_REUSE_1;
> +	spatial_reuse2 = IEEE80211_RADIOTAP_EHT_USIG2_TB_B7_B10_SPATIAL_REUSE_2;
> +
> +	common = __le32_to_cpu(ppdu_info->usig.common);
> +	value = __le32_to_cpu(ppdu_info->usig.value);
> +	mask = __le32_to_cpu(ppdu_info->usig.mask);
> +
> +	common |= ATH12K_LE32_DEC_ENC(usig_tb->info0,
> +				      HAL_RX_USIG_TB_INFO0_RX_INTEG_CHECK_PASS,
> +				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
> +
> +	value |= IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD |
> +		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
> +				     HAL_RX_USIG_TB_INFO0_PPDU_TYPE_COMP_MODE,
> +				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE) |
> +		 IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE |
> +		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
> +				     HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_1,
> +				     spatial_reuse1) |
> +		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
> +				     HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_2,
> +				     spatial_reuse2) |
> +		 IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD |
> +		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
> +				     HAL_RX_USIG_TB_INFO0_CRC,
> +				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC) |
> +		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
> +				     HAL_RX_USIG_TB_INFO0_TAIL,
> +				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL);
> +
> +	mask |= IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD |
> +		IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE |
> +		IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE |
> +		spatial_reuse1 | spatial_reuse2 |
> +		IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD |
> +		IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC |
> +		IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL;
> +
> +	ppdu_info->usig.common = cpu_to_le32(common);
> +	ppdu_info->usig.value = cpu_to_le32(value);
> +	ppdu_info->usig.mask = cpu_to_le32(mask);
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_u_sig_mu(const struct hal_mon_usig_mu *usig_mu,
> +				    struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	enum ieee80211_radiotap_eht_usig_mu sig_symb, punc;
> +	u32 common, value, mask;
> +
> +	sig_symb = IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS;
> +	punc = IEEE80211_RADIOTAP_EHT_USIG2_MU_B3_B7_PUNCTURED_INFO;
> +
> +	common = __le32_to_cpu(ppdu_info->usig.common);
> +	value = __le32_to_cpu(ppdu_info->usig.value);
> +	mask = __le32_to_cpu(ppdu_info->usig.mask);
> +
> +	common |= ATH12K_LE32_DEC_ENC(usig_mu->info0,
> +				      HAL_RX_USIG_MU_INFO0_RX_INTEG_CHECK_PASS,
> +				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
> +
> +	value |= IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD |
> +		 IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE |
> +		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
> +				     HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE,
> +				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE) |
> +		 IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE |
> +		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
> +				     HAL_RX_USIG_MU_INFO0_PUNC_CH_INFO,
> +				     punc) |
> +		 IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE |
> +		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
> +				     HAL_RX_USIG_MU_INFO0_EHT_SIG_MCS,
> +				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS) |
> +		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
> +				     HAL_RX_USIG_MU_INFO0_NUM_EHT_SIG_SYM,
> +				     sig_symb) |
> +		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
> +				     HAL_RX_USIG_MU_INFO0_CRC,
> +				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC) |
> +		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
> +				     HAL_RX_USIG_MU_INFO0_TAIL,
> +				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B20_B25_TAIL);
> +
> +	mask |= IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD |
> +		IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE |
> +		IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE |
> +		IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE |
> +		punc |
> +		IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE |
> +		IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS |
> +		sig_symb |
> +		IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC |
> +		IEEE80211_RADIOTAP_EHT_USIG2_MU_B20_B25_TAIL;
> +
> +	ppdu_info->usig.common = cpu_to_le32(common);
> +	ppdu_info->usig.value = cpu_to_le32(value);
> +	ppdu_info->usig.mask = cpu_to_le32(mask);
> +}
> +
> +static void
> +ath12k_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
> +				     struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	const struct hal_mon_usig_cmn *usig_cmn = &usig->cmn;
> +	u8 comp_mode;
> +	bool ap_ppdu;
> +
> +	ppdu_info->eht_usig = true;
> +
> +	ath12k_dp_mon_hal_rx_parse_u_sig_cmn(&usig->cmn, ppdu_info);
> +
> +	ap_ppdu = le32_get_bits(usig_cmn->info0, HAL_RX_USIG_CMN_INFO0_UL_DL);
> +	comp_mode = le32_get_bits(usig->non_cmn.mu.info0,
> +				  HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE);
> +
> +	if (comp_mode == 0 && ap_ppdu)
> +		ath12k_dp_mon_hal_rx_parse_u_sig_tb(&usig->non_cmn.tb, ppdu_info);
> +	else
> +		ath12k_dp_mon_hal_rx_parse_u_sig_mu(&usig->non_cmn.mu, ppdu_info);
> +}
> +
>   static enum hal_rx_mon_status
>   ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>   				  struct ath12k_mon_data *pmon,
> @@ -774,6 +958,9 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>   		return HAL_RX_MON_STATUS_MSDU_END;
>   	case HAL_RX_MPDU_END:
>   		return HAL_RX_MON_STATUS_MPDU_END;
> +	case HAL_PHYRX_GENERIC_U_SIG:
> +		ath12k_dp_mon_hal_rx_parse_u_sig_hdr(tlv_data, ppdu_info);
> +		break;
>   	case HAL_DUMMY:
>   		return HAL_RX_MON_STATUS_BUF_DONE;
>   	case HAL_RX_PPDU_END_STATUS_DONE:
> @@ -971,7 +1158,23 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
>   		rxs->ampdu_reference = ampdu_id;
>   	}
>   
> -	if (ppduinfo->he_mu_flags) {
> +	if (ppduinfo->eht_usig) {
> +		struct ieee80211_radiotap_tlv *tlv;
> +		struct ieee80211_radiotap_eht_usig *usig;
> +		u16 len = sizeof(*usig);
> +
> +		rxs->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
> +		rxs->encoding = RX_ENC_EHT;
> +
> +		skb_reset_mac_header(mon_skb);
> +
> +		tlv = skb_push(mon_skb, sizeof(*tlv) + len);
> +		tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT_USIG);
> +		tlv->len = cpu_to_le16(len);
> +
> +		usig = (struct ieee80211_radiotap_eht_usig *)tlv->data;
> +		*usig = ppduinfo->usig;
> +	} else if (ppduinfo->he_mu_flags) {
>   		rxs->flag |= RX_FLAG_RADIOTAP_HE_MU;
>   		rxs->encoding = RX_ENC_HE;
>   		ptr = skb_push(mon_skb, sizeof(struct ieee80211_radiotap_he_mu));
> diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
> index 96954b2f7ca6..2da16f27e76c 100644
> --- a/drivers/net/wireless/ath/ath12k/hal_rx.h
> +++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
> @@ -235,6 +235,8 @@ struct hal_rx_mon_ppdu_info {
>   	bool is_ampdu;
>   	u8 medium_prot_type;
>   	bool ppdu_continuation;
> +	bool eht_usig;
> +	struct ieee80211_radiotap_eht_usig usig;
>   };
>   
>   #define HAL_RX_PPDU_START_INFO0_PPDU_ID			GENMASK(15, 0)
> @@ -678,6 +680,64 @@ enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
>   	return ret;
>   }
>   
> +enum hal_eht_bw {
> +	HAL_EHT_BW_20,
> +	HAL_EHT_BW_40,
> +	HAL_EHT_BW_80,
> +	HAL_EHT_BW_160,
> +	HAL_EHT_BW_320_1,
> +	HAL_EHT_BW_320_2,
> +};
> +
> +#define HAL_RX_USIG_CMN_INFO0_PHY_VERSION	GENMASK(2, 0)
> +#define HAL_RX_USIG_CMN_INFO0_BW		GENMASK(5, 3)
> +#define HAL_RX_USIG_CMN_INFO0_UL_DL		BIT(6)
> +#define HAL_RX_USIG_CMN_INFO0_BSS_COLOR		GENMASK(12, 7)
> +#define HAL_RX_USIG_CMN_INFO0_TXOP		GENMASK(19, 13)
> +#define HAL_RX_USIG_CMN_INFO0_DISREGARD		GENMASK(25, 20)
> +#define HAL_RX_USIG_CMN_INFO0_VALIDATE		BIT(26)
> +
> +struct hal_mon_usig_cmn {
> +	__le32 info0;
> +} __packed;
> +
> +#define HAL_RX_USIG_TB_INFO0_PPDU_TYPE_COMP_MODE	GENMASK(1, 0)
> +#define HAL_RX_USIG_TB_INFO0_VALIDATE			BIT(2)
> +#define HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_1		GENMASK(6, 3)
> +#define HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_2		GENMASK(10, 7)
> +#define HAL_RX_USIG_TB_INFO0_DISREGARD_1		GENMASK(15, 11)
> +#define HAL_RX_USIG_TB_INFO0_CRC			GENMASK(19, 16)
> +#define HAL_RX_USIG_TB_INFO0_TAIL			GENMASK(25, 20)
> +#define HAL_RX_USIG_TB_INFO0_RX_INTEG_CHECK_PASS	BIT(31)
> +
> +struct hal_mon_usig_tb {
> +	__le32 info0;
> +} __packed;
> +
> +#define HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE	GENMASK(1, 0)
> +#define HAL_RX_USIG_MU_INFO0_VALIDATE_1			BIT(2)
> +#define HAL_RX_USIG_MU_INFO0_PUNC_CH_INFO		GENMASK(7, 3)
> +#define HAL_RX_USIG_MU_INFO0_VALIDATE_2			BIT(8)
> +#define HAL_RX_USIG_MU_INFO0_EHT_SIG_MCS		GENMASK(10, 9)
> +#define HAL_RX_USIG_MU_INFO0_NUM_EHT_SIG_SYM		GENMASK(15, 11)
> +#define HAL_RX_USIG_MU_INFO0_CRC			GENMASK(20, 16)
> +#define HAL_RX_USIG_MU_INFO0_TAIL			GENMASK(26, 21)
> +#define HAL_RX_USIG_MU_INFO0_RX_INTEG_CHECK_PASS	BIT(31)
> +
> +struct hal_mon_usig_mu {
> +	__le32 info0;
> +} __packed;
> +
> +union hal_mon_usig_non_cmn {
> +	struct hal_mon_usig_tb tb;
> +	struct hal_mon_usig_mu mu;
> +};
> +
> +struct hal_mon_usig_hdr {
> +	struct hal_mon_usig_cmn cmn;
> +	union hal_mon_usig_non_cmn non_cmn;
> +} __packed;
> +
>   void ath12k_hal_reo_status_queue_stats(struct ath12k_base *ab,
>   				       struct hal_tlv_64_hdr *tlv,
>   				       struct hal_reo_status *status);

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

