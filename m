Return-Path: <linux-wireless+bounces-4677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A095487A973
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC241F21B2D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B9344369;
	Wed, 13 Mar 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UzSNmJKT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19D41238
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340182; cv=none; b=BRCjLHTNPvpkJGgqRTyIAFszyfp/DcAdRd1p4l4e+NK5yV0aQ0wT+6ndZF+EY4xrbjaiIC+TVhj1xB/rA58ujClgUvqqeZ+QZfgBLqE/A+xJCPbONxqID28JJDqjtuY22JzmelDBZat3QyQ6Ia0jsZ2StmoVXaoyllMwKUQeCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340182; c=relaxed/simple;
	bh=5oovRTaAGxbnyhZw1XfyewoD27xRAGCEs6TvbM6kxS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oQtjrdUAgF8XV2rEmgS311P+tWzzIuk5xpGqxCKksoGKjgldbMltgQUmTD9OL7r3aJkMRqhXGIhFUIAe5Nntx1LYl6iSmffHO+T/QXSS4lmFSa307U8ak/llXUSsJnlTgsh0W/6bh5XmYN6x/kir0s9sW+StYdqc8Wdr/sHhtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UzSNmJKT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DBeaau031954;
	Wed, 13 Mar 2024 14:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3L7o+Q5kYPDGQ4JA6xkUXXqVu4EhxmxDgK+lxY6TYOc=; b=Uz
	SNmJKTJaJV5mJ/9a2c4yU4Idj1ZHCSP9mpvJXuNSsMxQ/DDjzeILnaW0i0NfjLyB
	WzR+Yi2pO4VIq9HlpGwPXIb/uhLqTL63KDYgdT4BjuiFzYR2QqCq17VqqWbUq6tC
	9oLY1waSlG0ofkKANV3T/CX6riaknmh5pV3YTZNww/xk/uNTmp8ejg8eBRbNSBhZ
	PJHC0EZDMCjLlSyl5ZkuPABcrypsM6vUNxt9uhw3nU1ZA84bIZwmlBA2yrb6rrfb
	/4yR4ObAofPQfkuFLsqFQsoDaZz5tmL3c5ucD63q/YMHo8EQlrzrS/FYpwFyv6MI
	+yE0iiX9mtXu6GPt02WQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtw4ft51d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 14:29:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DETWjL027979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 14:29:32 GMT
Received: from [10.50.3.124] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 07:29:30 -0700
Message-ID: <20d3457d-2d06-4088-81bd-893bf2712092@quicinc.com>
Date: Wed, 13 Mar 2024 19:59:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] wifi: ath12k: modify ath12k mac start/stop ops
 for single wiphy
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-4-quic_ramess@quicinc.com>
 <c0756266-1f45-4b31-83e8-a8b8c31fafc6@quicinc.com>
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <c0756266-1f45-4b31-83e8-a8b8c31fafc6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OeTqjtksM--eG9WDGVoGqkXzOX3_K_oH
X-Proofpoint-ORIG-GUID: OeTqjtksM--eG9WDGVoGqkXzOX3_K_oH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403130108



On 3/13/2024 3:43 AM, Jeff Johnson wrote:
> On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> When mac80211 does drv start/stop, apply the state change
>> for all the radios within the wiphy in ath12k.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 43 +++++++++++++++++++--------
>>   1 file changed, 31 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 0f33f5615170..4afaba3ba934 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -243,6 +243,7 @@ static const u32 ath12k_smps_map[] = {
>>   
>>   static int ath12k_start_vdev_delay(struct ath12k *ar,
>>   				   struct ath12k_vif *arvif);
>> +static void ath12k_mac_stop(struct ath12k *ar);
>>   
>>   static const char *ath12k_mac_phymode_str(enum wmi_phy_mode mode)
>>   {
>> @@ -5472,23 +5473,39 @@ static int ath12k_mac_start(struct ath12k *ar)
>>   	return ret;
>>   }
>>   
>> +static void ath12k_drain_tx(struct ath12k_hw *ah)
>> +{
>> +	struct ath12k *ar;
>> +	int i;
>> +
>> +	for_each_ar(i, ah, ar)
>> +		ath12k_mac_drain_tx(ar);
>> +}
>> +
>>   static int ath12k_mac_op_start(struct ieee80211_hw *hw)
>>   {
>>   	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>> -	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
>> -	struct ath12k_base *ab = ar->ab;
>> -	int ret;
>> +	struct ath12k *ar;
>> +	int ret, i;
>>   
>> -	ath12k_mac_drain_tx(ar);
>> +	ath12k_drain_tx(ah);
>>   
>> -	ret = ath12k_mac_start(ar);
>> -	if (ret) {
>> -		ath12k_err(ab, "fail to start mac operations in pdev idx %d ret %d\n",
>> -			   ar->pdev_idx, ret);
>> -		return ret;
>> +	for_each_ar(i, ah, ar) {
>> +		ret = ath12k_mac_start(ar);
>> +		if (ret) {
>> +			ath12k_err(ar->ab, "fail to start mac operations in pdev idx %d ret %d\n",
>> +				   ar->pdev_idx, ret);
>> +			goto fail_start;
>> +		}
>>   	}
>>   
>>   	return 0;
>> +fail_start:
>> +	for (; i > 0; i--) {
> 
> should this be >= 0? otherwise you never stop radio 0
Ah! yes, will fix it in next version
> also note that this has a dependency upon how the macro is implemented since
> that determines when i is incremented.
Yeah, we'll fall to fail_start only if we had to break prematurely (i.e. 
before i could reach ah->num_radios).
> 
>> +		ar = ath12k_ah_to_ar(ah, i);
>> +		ath12k_mac_stop(ar);
>> +	}
>> +	return ret;
>>   }
>>   
>>   int ath12k_mac_rfkill_config(struct ath12k *ar)
>> @@ -5584,11 +5601,13 @@ static void ath12k_mac_stop(struct ath12k *ar)
>>   static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
>>   {
>>   	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>> -	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
>> +	struct ath12k *ar;
>> +	int i;
>>   
>> -	ath12k_mac_drain_tx(ar);
>> +	ath12k_drain_tx(ah);
>>   
>> -	ath12k_mac_stop(ar);
>> +	for_each_ar(i, ah, ar)
>> +		ath12k_mac_stop(ar);
>>   }
>>   
>>   static u8
> 

