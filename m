Return-Path: <linux-wireless+bounces-18122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637BA219B2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 10:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4CD3A4FB2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA8199EB7;
	Wed, 29 Jan 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hzQ115nk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55EC179BC
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141911; cv=none; b=NVc4jrm/gWbCwOseiu2kg5gIMwKCYiOYmkMnBHMoeUyLwOrkgQNPjENbKsyGmaft/Wx7NITMPQHcZd5Ssm87iIEivGC4j7yOnsvWEb2xm7G7RTjTO8QKySHVet3JlLdJy7fuS0Hdw10QLhJJZLBs3ER632JCZR1p1zGTcbE7JUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141911; c=relaxed/simple;
	bh=4wMmvgN0YF3RF46m9l7OOjpBd9W3G74u+ER2+fQ7UIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=utTbdTUrQJU/iQ6WYp1IWD8Au7yNMpRz4ELxFBYsMnYFgFelL1r69E7DYzL7hFNMRozxFW+24PdVwhlcbJSSdP38N/HXBWe/9B8HwJ70JviIRx8JQpDFuM+hPIn7BKURZY9rWkpcBYmMvLAfLB6jgnE7HUoSThFRSRoTcsnTcLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hzQ115nk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8VYjH020680;
	Wed, 29 Jan 2025 09:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ANrtnz4n2h21MFndKVtQ258xZz1BO3fOOSXmQxoj698=; b=hzQ115nkIe90Yp3h
	/Q0+als0WEq306nwLVJgOpRyA4a+rgdHwz8BskweAr6EjOrQ4jXa+mjuoG9zD+Rr
	ZYrGdY+sjLr+9gt4h5Sj+Yrql6qlZCE8iR6mpO8waBGforN8HcpDQnjt3G/+WFWB
	sOBJbnSC3xjJrKqXCve9t3AFbz80oWkWqxzvEmtu+FSs86DB3Ji1MilC+Me5rEco
	hqBFP6sGkVK/+ips3GYcQseF6VuAVkDZc3J3KMrPDUcH6BiGEx0XvsuTK//BOT6S
	RYAQHBOvySOwmml1YQK8LB5I1iC/gTg9ABmRqqXvBzBlfir19OF2+DSTkr8pgb32
	M8uhXQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fgw8r248-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 09:11:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50T9BjHm010886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 09:11:45 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 01:11:43 -0800
Message-ID: <47e7f716-79bd-abb1-1e66-24441fa78427@quicinc.com>
Date: Wed, 29 Jan 2025 14:41:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV
 parsing support
Content-Language: en-US
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
 <20250127104738.4174862-3-quic_periyasa@quicinc.com>
 <78f22259-5574-16b3-872c-15f714fdc471@quicinc.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <78f22259-5574-16b3-872c-15f714fdc471@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PU0pLJdNORMHCd_WhqZFia06nazssqft
X-Proofpoint-ORIG-GUID: PU0pLJdNORMHCd_WhqZFia06nazssqft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290074



On 1/29/2025 10:58 AM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 1/27/2025 4:17 PM, Karthikeyan Periyasamy wrote:
>> Currently, monitor is not enabled. However, in the future, the monitor
>> will be enabled. Therefore, add the necessary HAL_PHYRX_GENERIC_EHT_SIG
>> TLV parsing support in monitor Rx path, which help to populate the EHT
>> radiotap data.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI 
>> WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp_mon.c | 571 +++++++++++++++++++++--
>>   drivers/net/wireless/ath/ath12k/hal_rx.h | 136 +++++-
>>   2 files changed, 661 insertions(+), 46 deletions(-)
>>

...

>> +
>> +static enum hal_rx_mon_status
>> +ath12k_dp_mon_hal_rx_parse_eht_sig_non_ofdma(const void *tlv,
>> +                         struct hal_rx_mon_ppdu_info *ppdu_info)
>> +{
>> +    const struct hal_eht_sig_non_ofdma_cmn_eb *eb = tlv;
>> +
>> +    ath12k_dp_mon_hal_rx_parse_usig_overflow(tlv, ppdu_info);
>> +    ath12k_dp_mon_hal_rx_parse_non_ofdma_users(eb, ppdu_info);
>> +
>> +    if (ath12k_dp_mon_hal_rx_is_mu_mimo_user(&ppdu_info->u_sig_info))
>> +        
>> ath12k_dp_mon_hal_rx_parse_eht_mumimo_user(&eb->user_field.mu_mimo,
>> +                               ppdu_info);
>> +    else
>> +        
>> ath12k_dp_mon_hal_rx_parse_eht_non_mumimo_user(&eb->user_field.n_mu_mimo,
>> +                                   ppdu_info);
>> +
>> +    return HAL_TLV_STATUS_PPDU_NOT_DONE;
>> +}
>> +
>> +static enum hal_rx_mon_status
>> +ath12k_dp_mon_hal_rx_parse_ru_allocation(const struct 
>> hal_eht_sig_ofdma_cmn_eb *eb,
>> +                     struct hal_rx_mon_ppdu_info *ppdu_info)
>> +{
>> +    const struct hal_eht_sig_ofdma_cmn_eb1 *ofdma_cmn_eb1 = &eb->eb1;
>> +    const struct hal_eht_sig_ofdma_cmn_eb2 *ofdma_cmn_eb2 = &eb->eb2;
>> +    struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
>> +    enum ieee80211_radiotap_eht_data ru_123, ru_124, ru_125, ru_126;
>> +    enum ieee80211_radiotap_eht_data ru_121, ru_122, ru_112, ru_111;
>> +    u32 data;
>> +
>> +    ru_123 = IEEE80211_RADIOTAP_EHT_DATA4_RU_ALLOC_CC_1_2_3;
>> +    ru_124 = IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_4;
>> +    ru_125 = IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_5;
>> +    ru_126 = IEEE80211_RADIOTAP_EHT_DATA6_RU_ALLOC_CC_1_2_6;
>> +    ru_121 = IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_1;
>> +    ru_122 = IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_2;
>> +    ru_112 = IEEE80211_RADIOTAP_EHT_DATA2_RU_ALLOC_CC_1_1_2;
>> +    ru_111 = IEEE80211_RADIOTAP_EHT_DATA1_RU_ALLOC_CC_1_1_1;
>> +
>> +    switch (ppdu_info->u_sig_info.bw) {
>> +    case HAL_EHT_BW_320_2:
>> +    case HAL_EHT_BW_320_1:
>> +        data = __le32_to_cpu(eht->data[4]);
>> +        /* CC1 2::3 */
>> +        data |=    
>> IEEE80211_RADIOTAP_EHT_DATA4_RU_ALLOC_CC_1_2_3_KNOWN |
>> +            ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
>> +                        HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_3,
>> +                        ru_123);
>> +        eht->data[4] = cpu_to_le32(data);
>> +
>> +        data = __le32_to_cpu(eht->data[5]);
>> +        /* CC1 2::4 */
>> +        data |=    
>> IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_4_KNOWN |
>> +            ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
>> +                        HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_4,
>> +                        ru_124);
>> +
>> +        /* CC1 2::5 */
>> +        data |=    
>> IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_5_KNOWN |
>> +            ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
>> +                        HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_5,
>> +                        ru_125);
>> +        eht->data[5] = cpu_to_le32(data);
>> +
>> +        data = __le32_to_cpu(eht->data[6]);
>> +        /* CC1 2::6 */
>> +        data |=    
>> IEEE80211_RADIOTAP_EHT_DATA6_RU_ALLOC_CC_1_2_6_KNOWN |
>> +            ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
>> +                        HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_6,
>> +                        ru_126);
>> +        eht->data[6] = cpu_to_le32(data);
>> +
>> +        fallthrough;
>> +    case HAL_EHT_BW_160:
>> +        data = __le32_to_cpu(eht->data[3]);
>> +        /* CC1 2::1 */
>> +        data |=    
>> IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_1_KNOWN |
>> +            ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
>> +                        HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_1,
>> +                        ru_121);
>> +        /* CC1 2::2 */
>> +        data |=    
>> IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_2_KNOWN |
>> +            ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
>> +                        HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_2,
>> +                        ru_122);
>> +        eht->data[3] = cpu_to_le32(data);
>> +
>> +        fallthrough;
>> +    case HAL_EHT_BW_80:
>> +        data = __le32_to_cpu(eht->data[2]);
>> +        /* CC1 1::2 */
>> +        data |=    
>> IEEE80211_RADIOTAP_EHT_DATA2_RU_ALLOC_CC_1_1_2_KNOWN |
>> +            ATH12K_LE64_DEC_ENC(ofdma_cmn_eb1->info0,
>> +                        HAL_RX_EHT_SIG_OFDMA_EB1_RU_ALLOC_1_2,
>> +                        ru_112);
>> +        eht->data[2] = cpu_to_le32(data);
>> +
>> +        fallthrough;
>> +    case HAL_EHT_BW_40:
>> +        fallthrough;
>> +    case HAL_EHT_BW_20:
>> +        data = __le32_to_cpu(eht->data[1]);
>> +        /* CC1 1::1 */
>> +        data |=    
>> IEEE80211_RADIOTAP_EHT_DATA1_RU_ALLOC_CC_1_1_1_KNOWN |
>> +            ATH12K_LE64_DEC_ENC(ofdma_cmn_eb1->info0,
>> +                        HAL_RX_EHT_SIG_OFDMA_EB1_RU_ALLOC_1_1,
>> +                        ru_111);
>> +        eht->data[1] = cpu_to_le32(data);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    return HAL_TLV_STATUS_PPDU_NOT_DONE;
>> +}
>> +
>> +static enum hal_rx_mon_status
>> +ath12k_dp_mon_hal_rx_parse_eht_sig_ofdma(const void *tlv,
>> +                     struct hal_rx_mon_ppdu_info *ppdu_info)
>> +{
>> +    const struct hal_eht_sig_ofdma_cmn_eb *ofdma = tlv;
>> +
>> +    ath12k_dp_mon_hal_rx_parse_usig_overflow(tlv, ppdu_info);
>> +    ath12k_dp_mon_hal_rx_parse_ru_allocation(ofdma, ppdu_info);
>> +
>> +    
>> ath12k_dp_mon_hal_rx_parse_eht_non_mumimo_user(&ofdma->user_field.n_mu_mimo,
>> +                               ppdu_info);
>> +
>> +    return HAL_TLV_STATUS_PPDU_NOT_DONE;
>> +}
>> +
> 
> Same comment as the previous one, make it void as the return code
> seems not very much useful.
> 

sure, will fix in the next version of the patch.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

