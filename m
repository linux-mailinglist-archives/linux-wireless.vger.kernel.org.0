Return-Path: <linux-wireless+bounces-18121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9CBA219B0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 10:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0731887FB3
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ABD1917EB;
	Wed, 29 Jan 2025 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mti/3CsV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544AB179BC
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141788; cv=none; b=JFGyLvb6gtyk/6Hbzo5JH6v04HmixlKh+FR8STL4OzR6pOQyyxiK+oMDO98I7OhODlNwlkKgbzq3/41xRuO5h3OhYOwYOKExvMioQGjSpVYnAzwx9XAmtkLrxqXPtKStkChacMBkZH6b1Jc/DgT5dizOotI9nil5P+pOUQtRMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141788; c=relaxed/simple;
	bh=d4zXl01PvzuNUKcagF3SUkzMe6Na++3RE8N3r47nQyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ofossxcnz4jnETQ84DM7jriseckYQflpv1vANKWS9t0+JfmptQvoR8xxadHV8qYbgqL2rncXFsNcewPm4aRiE22Ap+dN+DYZIwPpjb8sc+X+vd/tFxEcX+q3UbR3uZiq87/HVjh01iwAZ10lhwsMbcVlq+Sqt/2J2STZN061sgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mti/3CsV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8TU3Y013885;
	Wed, 29 Jan 2025 09:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B3GqbJVa9LZCTpJGBUoCVDD9F1AjiBogZwWVSdup6no=; b=Mti/3CsVqb3pmd1G
	2BHK+1qM/PFVuBoUHTgoA51WoEhCh8T14UXVhaz18ZMsiWcEqpdOoStzG4auZz3m
	dVDua1PuO4gbLuwmPGc6qqzd+J9mWe18NfWV8F/HhxCelodFoT2T8QntIxWfYsM4
	UaMgo94afVI8Sq/BR3BMl92ujG9pE4K2ccd7F8bFCC4J2copazX2b48aC+XGIUr7
	/qxOSgQg+7dzZVHqi+nEBNRnUCvYQswbYDw/gd6elV4A2t9s1U9mc0vYXFBl6SPe
	+IZDa9JthyyZ/pL0vmOp155bFaFnAGabP6OCYxpZkq9t91ULs2lRusMWcNldoLps
	R3KvxQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fguvg239-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 09:09:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50T99eWY014456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 09:09:40 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 01:09:38 -0800
Message-ID: <ee2958ba-527a-418a-18ea-06b0f4e2ad0b@quicinc.com>
Date: Wed, 29 Jan 2025 14:39:35 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/9] wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV
 parsing support
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
 <20250127104738.4174862-4-quic_periyasa@quicinc.com>
 <e710cad7-aa62-db80-3f0f-79c72282ee3e@quicinc.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <e710cad7-aa62-db80-3f0f-79c72282ee3e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e7CJ2AK_js_8DEu2v_lbC92WSPgXFF2O
X-Proofpoint-GUID: e7CJ2AK_js_8DEu2v_lbC92WSPgXFF2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=715 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290073



On 1/29/2025 11:05 AM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 1/27/2025 4:17 PM, Karthikeyan Periyasamy wrote:
>> Currently, monitor is not enabled. However, in the future, the monitor
>> will be enabled. Therefore, add necessary HAL_RX_PPDU_START_USER_INFO TLV
>> parsing support in monitor Rx path, which help to populate the EHT 
>> radiotap
>> data.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI 
>> WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp_mon.c  | 309 +++++++++++++++++++++-
>>   drivers/net/wireless/ath/ath12k/hal_rx.h  | 291 +++++++++++++++++---
>>   drivers/net/wireless/ath/ath12k/rx_desc.h |   9 -
>>   3 files changed, 553 insertions(+), 56 deletions(-)
>>

...

>> +
>> +    rtap_ru_size = hal_rx_mon_hal_ru_size_to_ath12k_ru_size(ru_size);
>> +    if (rtap_ru_size != ATH12K_EHT_RU_INVALID) {
>> +        u32 known, data;
>> +
>> +        known = __le32_to_cpu(eht->known);
>> +        known |= IEEE80211_RADIOTAP_EHT_KNOWN_RU_MRU_SIZE_OM;
>> +        eht->known = cpu_to_le32(known);
>> +
>> +        data = __le32_to_cpu(eht->data[1]);
>> +        data |=    u32_encode_bits(rtap_ru_size,
>> +                    IEEE80211_RADIOTAP_EHT_DATA1_RU_SIZE);
>> +        eht->data[1] = cpu_to_le32(data);
>> +    }
>> +
>> +    if (ru_index != HAL_EHT_RU_INVALID) {
>> +        u32 known, data;
>> +
>> +        known = __le32_to_cpu(eht->known);
>> +        known |= IEEE80211_RADIOTAP_EHT_KNOWN_RU_MRU_INDEX_OM;
>> +        eht->known = cpu_to_le32(known);
>> +
>> +        data = __le32_to_cpu(eht->data[1]);
>> +        data |=    u32_encode_bits(rtap_ru_size,
>> +                    IEEE80211_RADIOTAP_EHT_DATA1_RU_INDEX);
>> +        eht->data[1] = cpu_to_le32(data);
>> +    }
>> +
>> +    if (mon_rx_user_status && ru_index != HAL_EHT_RU_INVALID &&
>> +        rtap_ru_size != ATH12K_EHT_RU_INVALID) {
>> +        mon_rx_user_status->ul_ofdma_ru_start_index = ru_index;
>> +        mon_rx_user_status->ul_ofdma_ru_size = rtap_ru_size;
>> +
>> +        ru_width = hal_rx_ul_ofdma_ru_size_to_width(rtap_ru_size);
>> +
>> +        mon_rx_user_status->ul_ofdma_ru_width = ru_width;
>> +        mon_rx_user_status->ofdma_info_valid = 1;
>> +    }
>> +
>> +    return HAL_TLV_STATUS_PPDU_NOT_DONE;
> 
> Same comment on the need for the return value in this patch and similar 
> changes in this series.
> 

sure, will fix in the next version of this patch.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

