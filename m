Return-Path: <linux-wireless+bounces-4915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B564088023A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 17:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D461C23075
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 16:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE5785C6A;
	Tue, 19 Mar 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dnzEI9O7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728DB85C58
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865389; cv=none; b=G3GjRlDJx6BgCrJT77EL+EKx+j/bEC1YoxkBXjntaI//NkDbz1IymV6tvwWBkwJlyoQlXkss58/2nqTKMgQlFICuI48mUex1gwSncui/YyfUt3J8M8F0A3VTowz/bL/am6e3985QZKEYzKMGPTdYdCqJUiuNZBvEBg0rx0pcKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865389; c=relaxed/simple;
	bh=Sr0WFgYA8/TI9VTftw9J2kpxCSaByMpH5TL2mrioQVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bS/T1zXYHwmf24zWVEakjLG97yvP1S7OaOk7R6fRGPzwAY70fp4kgxhHRNLES4C/hegh04he1+IjzBfcH4UdBH7mC/rkRhFe5f100JdFWQGOC+zelZvBiGbpTw+GvswGLimAfJNWKa2F6mLj8ehc9qSnemiGnckbvDgNhco0iRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dnzEI9O7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JBDvAU018807;
	Tue, 19 Mar 2024 16:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UhwONOCVo89AMBkpYVNTSiLDSlYoWdTO9A1OS2Xp3Ao=; b=dn
	zEI9O7Eg6NT+MvhKvJONxMlZoGpWtrp6izQIM3EFlruATRJSkqJ1dDNcVUg6gwyQ
	1pWI+Ma6GX5uPJGjkv9Xq+A68FLj7/It5n8SlvLzbCaF4q0+vggO4uBd7p6V9eJg
	U/UEZkGVEgvxQJipwAQiTDoEoGXcPoN3ic0M3bLyuUgVG0arZtrXvo6zxmz4yGTk
	ZeGFsxnJ+23+Cc1t/qYWp0nW+DjtvfAPB+QWNXS60qIqJGajiWhlfWSwk5OqnI1/
	354H/sl//KWSl/rvYrgE0TFUkbv1+5XGHTEy4h1HLW3Fix6GxnVuSJaKH2+gOG0b
	EctpMjhOaBvmrpDm2y/Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy4gf9hdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 16:23:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JGN2SL017738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 16:23:02 GMT
Received: from [10.50.62.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 09:23:00 -0700
Message-ID: <6989461b-295e-4886-9d39-64f15cc01074@quicinc.com>
Date: Tue, 19 Mar 2024 21:52:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] wifi: ath12k: support get_survey mac op for
 single wiphy
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-13-quic_ramess@quicinc.com>
 <036abbcc-eb90-48db-a82e-5565bcc336ef@quicinc.com>
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <036abbcc-eb90-48db-a82e-5565bcc336ef@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TAo5pE-sRnz6I_9ENKNpybTChxAkkBAB
X-Proofpoint-ORIG-GUID: TAo5pE-sRnz6I_9ENKNpybTChxAkkBAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=939 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190125



On 3/13/2024 4:55 AM, Jeff Johnson wrote:
> On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> The radio for which the survey info needs to be collected
>> depends on the channel idx which could be based on the band.
>> Use the idx to identify the appropriate sband since multiple
>> bands could be combined for single wiphy case.
>>
>> Also use the channel idx and sband to identify the corresponding
>> radio on which the survey results needs to be populated.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 25 ++++++++++++++++---------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 6123d7db2edc..a31003f8325d 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -7821,7 +7821,6 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
>>   static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>>   				    struct survey_info *survey)
>>   {
>> -	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>>   	struct ath12k *ar;
>>   	struct ieee80211_supported_band *sband;
>>   	struct survey_info *ar_survey;
>> @@ -7830,12 +7829,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>>   	if (idx >= ATH12K_NUM_CHANS)
>>   		return -ENOENT;
>>   
>> -	ar = ath12k_ah_to_ar(ah, 0);
>> -
>> -	ar_survey = &ar->survey[idx];
>> -
>> -	mutex_lock(&ar->conf_mutex);
>> -
>>   	sband = hw->wiphy->bands[NL80211_BAND_2GHZ];
>>   	if (sband && idx >= sband->n_channels) {
>>   		idx -= sband->n_channels;
>> @@ -7850,6 +7843,21 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>>   		goto exit;
>>   	}
>>   
>> +	ar = ath12k_mac_get_ar_by_chan(hw, &sband->channels[idx]);
>> +	if (!ar) {
>> +		if (sband->channels[idx].flags & IEEE80211_CHAN_DISABLED) {
>> +			ret = 0;
>> +			memset(survey, 0, sizeof(*survey));
>> +			goto exit;
>> +		}
>> +		ret = -ENOENT;
>> +		goto exit;
>> +	}
>> +
>> +	ar_survey = &ar->survey[idx];
>> +
>> +	mutex_lock(&ar->conf_mutex);
>> +
>>   	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[idx]);
>>   
>>   	spin_lock_bh(&ar->data_lock);
>> @@ -7861,9 +7869,8 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>>   	if (ar->rx_channel == survey->channel)
>>   		survey->filled |= SURVEY_INFO_IN_USE;
>>   
>> -exit:
>>   	mutex_unlock(&ar->conf_mutex);
>> -
>> +exit:
> 
> goto should normally only be used when there is centralized cleanup.
> since now there is no cleanup required, all of the goto exit calls should just
> directly return the appropriate error
> 
Sure, this sneaked through while rebasing, thanks for pointing out. Will 
fix it in next version.
>>   	return ret;
>>   }
>>   
> 

