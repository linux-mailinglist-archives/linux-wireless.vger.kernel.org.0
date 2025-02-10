Return-Path: <linux-wireless+bounces-18721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD20A2EEFA
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 14:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A9616484A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5D230998;
	Mon, 10 Feb 2025 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xf9BpD8H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62322E406
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195757; cv=none; b=FCLiMlOVSSWpX/+gvoAHiO1PPfHT1nEEiNEAyQC9MWfbAre17I8FRms0OQzCaD9wB299MoM0zuhqXzuPwpZNuoOBkENA1RZj6nCsjGg5xy0+kLc+AAkuToUSVnbf/viZl41IWrXxjyuu5GK6kiGr9yAOs7Gr1GchuLI8DojW4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195757; c=relaxed/simple;
	bh=0rnLw4+xExK7HPng78Uq3sF0XQrKE4dgWYE5cwg5RC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PK4CMjyOdXeAo7gFkqGKx11DcoNM6a/1toWj74MkreogT6iWWswSLBUpwXspQcaLixQiWrkVqAf/VgVjGNUqhSLnQ/iQNkbZ6pgOoYvunSk5pAWvUtChZwSM98gR3QiWaN8GY22PVz2crJHNF6LqVZ+nyGi5phNCWmSGZCFphZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xf9BpD8H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9bdjw006420;
	Mon, 10 Feb 2025 13:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uDtLDjgMJ61v2TX2UM0knNfzgLRlJx2XlE+RRyuyId0=; b=Xf9BpD8HyAMhyHLR
	CtaoNbN7A+7/jtkv7FKexq8oqq1n8+pA3YXCA17Zir4aX1t6DfcbKhV1Hms+EC16
	nmdjA8B+bfkQfuPCoGTaJJS9ATMTHZBXyoCk6kgP3kRayVqUggKZN0qg4/c6i4NW
	Qh8aYb0U+DiGBk47/ks7JK+43KE3/eHAXGroHm8rH5H8A5HdPscU3sv/b/JM9QGA
	1jCVXvBjadXjD/rIpMQpRww7B48w+Z2KEe6vy94IFNfDW2CceqHusPHyW5KT3Fbf
	YKnNqrV730mnJVhm5u9lOfvARXICNVAyMC7BfQDxgUlcC8nhfDz2VrnbXosLyeQw
	V7jEhw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0escj0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 13:55:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51ADto69013653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 13:55:50 GMT
Received: from [10.216.14.138] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Feb
 2025 05:55:47 -0800
Message-ID: <9092e428-01ac-a61b-eb07-6a075f98fab4@quicinc.com>
Date: Mon, 10 Feb 2025 19:25:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 3/9] wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV
 parsing support
Content-Language: en-US
To: Mahendran P <quic_mahep@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250206013854.174765-1-quic_periyasa@quicinc.com>
 <20250206013854.174765-4-quic_periyasa@quicinc.com>
 <d312265c-9b42-7c62-1467-205045a51a26@quicinc.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <d312265c-9b42-7c62-1467-205045a51a26@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CgJMC9_roaRasdRqAvKWPppo2bRgDhBJ
X-Proofpoint-ORIG-GUID: CgJMC9_roaRasdRqAvKWPppo2bRgDhBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100117



On 2/10/2025 4:35 PM, Mahendran P wrote:
> On 2/6/2025 7:08 AM, Karthikeyan Periyasamy wrote:
>> Currently, monitor is not enabled. However, in the future, the monitor
>> will be enabled. Therefore, add necessary HAL_RX_PPDU_START_USER_INFO TLV
>> parsing support in monitor Rx path, which help to populate the EHT radiotap
>> data.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp_mon.c  | 307 +++++++++++++++++++++-
>>   drivers/net/wireless/ath/ath12k/hal_rx.h  | 291 +++++++++++++++++---
>>   drivers/net/wireless/ath/ath12k/rx_desc.h |   9 -
>>   3 files changed, 551 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> index dd17607d470d..96e9d68618d3 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> @@ -81,7 +81,7 @@ ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *
>>   static void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vht_sig,
>>   					  struct hal_rx_mon_ppdu_info *ppdu_info)
>>   {
>> -	u32 nsts, group_id, info0, info1;
>> +	u32 nsts, info0, info1;
>>   	u8 gi_setting;
>>   
>>   	info0 = __le32_to_cpu(vht_sig->info0);
>> @@ -109,12 +109,8 @@ static void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vh
>>   	ppdu_info->bw = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_BW);
>>   	ppdu_info->beamformed = u32_get_bits(info1,
>>   					     HAL_RX_VHT_SIG_A_INFO_INFO1_BEAMFORMED);
>> -	group_id = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_GROUP_ID);
>> -	if (group_id == 0 || group_id == 63)
>> -		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
>> -	else
>> -		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
>> -	ppdu_info->vht_flag_values5 = group_id;
>> +	ppdu_info->vht_flag_values5 = u32_get_bits(info0,
>> +						   HAL_RX_VHT_SIG_A_INFO_INFO0_GROUP_ID);
>>   	ppdu_info->vht_flag_values3[0] = (((ppdu_info->mcs) << 4) |
>>   					    ppdu_info->nss);
>>   	ppdu_info->vht_flag_values2 = ppdu_info->bw;
>> @@ -134,7 +130,6 @@ static void ath12k_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
>>   	ppdu_info->ldpc = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_FEC_CODING);
>>   	ppdu_info->gi = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_GI);
>>   	ppdu_info->nss = (ppdu_info->mcs >> 3);
>> -	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
>>   }
>>   
>>   static void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
>> @@ -166,7 +161,6 @@ static void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
>>   
>>   	ppdu_info->rate = rate;
>>   	ppdu_info->cck_flag = 1;
>> -	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
>>   }
>>   
>>   static void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
>> @@ -206,7 +200,6 @@ static void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
>>   	}
>>   
>>   	ppdu_info->rate = rate;
>> -	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
>>   }
>>   
>>   static void
>> @@ -243,7 +236,6 @@ ath12k_dp_mon_parse_he_sig_b2_ofdma(const struct hal_rx_he_sig_b2_ofdma_info *of
>>   	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS);
>>   	ppdu_info->beamformed = u32_get_bits(info0,
>>   					     HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF);
>> -	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_OFDMA;
>>   }
>>   
>>   static void
>> @@ -283,7 +275,6 @@ ath12k_dp_mon_parse_he_sig_b1_mu(const struct hal_rx_he_sig_b1_mu_info *he_sig_b
>>   				HAL_RX_HE_SIG_B1_MU_INFO_INFO0_RU_ALLOCATION);
>>   	ppdu_info->ru_alloc = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
>>   	ppdu_info->he_RU[0] = ru_tones;
>> -	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
>>   }
>>   
>>   static void
>> @@ -417,7 +408,6 @@ ath12k_dp_mon_parse_he_sig_mu(const struct hal_rx_he_sig_a_mu_dl_info *he_sig_a_
>>   
>>   	ppdu_info->is_stbc = info1 &
>>   			     HAL_RX_HE_SIG_A_MU_DL_INFO1_STBC;
>> -	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
>>   }
>>   
>>   static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *he_sig_a,
>> @@ -565,7 +555,6 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
>>   	dcm = u32_get_bits(info0, HAL_RX_HE_SIG_A_SU_INFO_INFO0_DCM);
>>   	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS);
>>   	ppdu_info->dcm = dcm;
>> -	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
>>   }
>>   
>>   static void
>> @@ -1141,6 +1130,292 @@ ath12k_dp_mon_parse_eht_sig_hdr(struct hal_rx_mon_ppdu_info *ppdu_info,
>>   		ath12k_dp_mon_hal_rx_parse_eht_sig_ofdma(tlv_data, ppdu_info);
>>   }
>>   
>> +static inline enum ath12k_eht_ru_size
>> +hal_rx_mon_hal_ru_size_to_ath12k_ru_size(u32 hal_ru_size)
>> +{
>> +	switch (hal_ru_size) {
>> +	case HAL_EHT_RU_26:
>> +		return ATH12K_EHT_RU_26;
>> +	case HAL_EHT_RU_52:
>> +		return ATH12K_EHT_RU_52;
>> +	case HAL_EHT_RU_78:
>> +		return ATH12K_EHT_RU_52_26;
>> +	case HAL_EHT_RU_106:
>> +		return ATH12K_EHT_RU_106;
>> +	case HAL_EHT_RU_132:
>> +		return ATH12K_EHT_RU_106_26;
>> +	case HAL_EHT_RU_242:
>> +		return ATH12K_EHT_RU_242;
>> +	case HAL_EHT_RU_484:
>> +		return ATH12K_EHT_RU_484;
>> +	case HAL_EHT_RU_726:
>> +		return ATH12K_EHT_RU_484_242;
>> +	case HAL_EHT_RU_996:
>> +		return ATH12K_EHT_RU_996;
>> +	case HAL_EHT_RU_996x2:
>> +		return ATH12K_EHT_RU_996x2;
>> +	case HAL_EHT_RU_996x3:
>> +		return ATH12K_EHT_RU_996x3;
>> +	case HAL_EHT_RU_996x4:
>> +		return ATH12K_EHT_RU_996x4;
>> +	case HAL_EHT_RU_NONE:
>> +		return ATH12K_EHT_RU_INVALID;
>> +	case HAL_EHT_RU_996_484:
>> +		return ATH12K_EHT_RU_996_484;
>> +	case HAL_EHT_RU_996x2_484:
>> +		return ATH12K_EHT_RU_996x2_484;
>> +	case HAL_EHT_RU_996x3_484:
>> +		return ATH12K_EHT_RU_996x3_484;
>> +	case HAL_EHT_RU_996_484_242:
>> +		return ATH12K_EHT_RU_996_484_242;
>> +	default:
>> +		return ATH12K_EHT_RU_INVALID;
>> +	}
>> +}
> 
> consider using lookup table.
> 

Lookup table need static array. Really need the static for this ?

Even if we need, shall we have this in a separate future patch ?


>> +
>> +static inline u32
>> +hal_rx_ul_ofdma_ru_size_to_width(enum ath12k_eht_ru_size ru_size)
>> +{
>> +	switch (ru_size) {
>> +	case ATH12K_EHT_RU_26:
>> +		return RU_26;
>> +	case ATH12K_EHT_RU_52:
>> +		return RU_52;
>> +	case ATH12K_EHT_RU_52_26:
>> +		return RU_52_26;
>> +	case ATH12K_EHT_RU_106:
>> +		return RU_106;
>> +	case ATH12K_EHT_RU_106_26:
>> +		return RU_106_26;
>> +	case ATH12K_EHT_RU_242:
>> +		return RU_242;
>> +	case ATH12K_EHT_RU_484:
>> +		return RU_484;
>> +	case ATH12K_EHT_RU_484_242:
>> +		return RU_484_242;
>> +	case ATH12K_EHT_RU_996:
>> +		return RU_996;
>> +	case ATH12K_EHT_RU_996_484:
>> +		return RU_996_484;
>> +	case ATH12K_EHT_RU_996_484_242:
>> +		return RU_996_484_242;
>> +	case ATH12K_EHT_RU_996x2:
>> +		return RU_2X996;
>> +	case ATH12K_EHT_RU_996x2_484:
>> +		return RU_2X996_484;
>> +	case ATH12K_EHT_RU_996x3:
>> +		return RU_3X996;
>> +	case ATH12K_EHT_RU_996x3_484:
>> +		return RU_3X996_484;
>> +	case ATH12K_EHT_RU_996x4:
>> +		return RU_4X996;
>> +	default:
>> +		return RU_INVALID;
>> +	}
>> +}
> 
> same as above
> 

same here


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

