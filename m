Return-Path: <linux-wireless+bounces-5743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA4894FB7
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 12:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F561C20CED
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201875A0FD;
	Tue,  2 Apr 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LxJ2mJwP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF65811B
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052912; cv=none; b=b8mzCt9ctd21ZYRccqXinv0rNHRmkEDWbUJKsiHuS69SFCgzd1MmfWIdxOP7NS2C/RqwM0USRTxOSt6OiWJInhEYXae1TN+ATIsZmdeZq8XnzJXt5fNJh2d0op7fFbCgtKjP7RL2PPQLDWfMqQ2c8C3Xkt1uoTCLTNMzIvYNcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052912; c=relaxed/simple;
	bh=S71XI022KsfNO9meurFQQWrREM4KT1Jq0i4xIgt5++w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qUG10lkc+HhLkNO6Sel5CsaocGa2LdMmsDO6FnXLTzbH4l0ohMKarVQ8VwRdlayp9R8cmk1x/0g5vP25oqA/Vrnp+B+O5atSIMkV0+VsTqG4ev1/itx3i6M+S2dQ/gkXuxca1hCJ0k+MbqSlyXOL28OIQzsedv3/KFvr+BMuseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LxJ2mJwP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4324lg7R008194;
	Tue, 2 Apr 2024 10:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Uijq5M5QLexX3lAYXzOTpS2vIYtEEyPlQnabq5Uywcs=; b=Lx
	J2mJwPlBXKYqHAo0OwVQOjOr94uAX4Ns9zPjkDGonE2BfS7Ixj3X/O8BvRYjmRmJ
	cfmOCy/g8Pom4ijf8XB7iP3gytRIa/Xg5MtFcATc1nyZDeM8iPCenlsHcoCNs0tB
	sbepmMGvH1eYDz9sNXd+oGVK0Fk4v1O/B530qaX7ntiZF+HQRk1TWKqFee3Xfts+
	3vkO6JmmGV02pBRqqjnoAvd8Cy7MNUHnmiWnWicj4ZeBUvVmep8Pe7+rN8QQJr0w
	N63CWcQSt9XvoHLPDZRc38NQz6Z3WFttHTN28jHn6DKeOEG9HgYCPG807B20neLg
	NhUYmWIVv89I2F+53s9g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x89428y7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 10:15:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432AF5G0014714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 10:15:05 GMT
Received: from [10.216.58.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Apr
 2024 03:15:02 -0700
Message-ID: <71c8c3e2-290a-4866-b4ed-3c7d9f101c77@quicinc.com>
Date: Tue, 2 Apr 2024 15:44:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/12] wifi: ath12k: Cache vdev configs before vdev
 create
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240401190409.2461819-1-quic_ramess@quicinc.com>
 <20240401190409.2461819-8-quic_ramess@quicinc.com>
 <c5150881-7707-4b8f-b877-e5677039b0ed@quicinc.com>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <c5150881-7707-4b8f-b877-e5677039b0ed@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pvQheEtMFKWYaTI_DLVTdxZvzvwbaMfX
X-Proofpoint-ORIG-GUID: pvQheEtMFKWYaTI_DLVTdxZvzvwbaMfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404020074



On 4/2/2024 12:56 AM, Jeff Johnson wrote:
> On 4/1/2024 12:04 PM, Rameshkumar Sundaram wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> Since the vdev create for a corresponding vif is deferred
>> until a channel is assigned, cache the information which
>> are received through mac80211 ops between add_interface()
>> and assign_vif_chanctx() and set them once the vdev is
>> created on one of the ath12k radios as the channel gets
>> assigned via assign_vif_chanctx().
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.h |  19 +++
>>   drivers/net/wireless/ath/ath12k/mac.c  | 160 +++++++++++++++++++------
>>   2 files changed, 145 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index 507f08ab3ad5..dd6c474bd507 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -214,6 +214,24 @@ enum ath12k_monitor_flags {
>>   	ATH12K_FLAG_MONITOR_ENABLED,
>>   };
>>   
>> +struct ath12k_tx_conf {
>> +	bool changed;
>> +	u16 ac;
>> +	struct ieee80211_tx_queue_params tx_queue_params;
>> +};
>> +
>> +struct ath12k_key_conf {
>> +	bool changed;
>> +	enum set_key_cmd cmd;
>> +	struct ieee80211_key_conf *key;
>> +};
>> +
>> +struct ath12k_vif_cache {
>> +	struct ath12k_tx_conf tx_conf;
>> +	struct ath12k_key_conf key_conf;
>> +	u32 bss_conf_changed;
>> +};
>> +
>>   struct ath12k_vif {
>>   	u32 vdev_id;
>>   	enum wmi_vdev_type vdev_type;
>> @@ -268,6 +286,7 @@ struct ath12k_vif {
>>   	u8 vdev_stats_id;
>>   	u32 punct_bitmap;
>>   	bool ps;
>> +	struct ath12k_vif_cache *cache;
>>   };
>>   
>>   struct ath12k_vif_iter {
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 60095d876a43..3f2d1b00ae24 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -3018,15 +3018,24 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>>   {
>>   	struct ath12k *ar;
>>   	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	struct ath12k_vif_cache *cache = arvif->cache;
>>   
>>   	ar = ath12k_get_ar_by_vif(hw, vif);
>>   
>> -	/* TODO if the vdev is not created on a certain radio,
>> +	/* if the vdev is not created on a certain radio,
>>   	 * cache the info to be updated later on vdev creation
>>   	 */
>>   
>> -	if (!ar)
>> +	if (!ar) {
>> +		if (!cache) {
>> +			cache = kzalloc(sizeof(*cache), GFP_KERNEL);
>> +			if (!cache)
>> +				return;
>> +			arvif->cache = cache;
>> +		}
> 
> since you have this core logic in several places, i'd refactor this into a
> separate function, i.e.
> ath12k_arvif_get_cache(arvif)
> 	if (!arvif->cache)
> 		arvif->cache = kzalloc(sizeof(*arvif->cache), GFP_KERNEL)
> 	return arvif->cache;
> 
> then all of the callers would have simply:
> 	cache = ath12k_arvif_get_cache(arvif);
> 	if (!cache) handle error;
> 	use cache
> 
Sure, will add get and put routines for cache and use them.
>> +		arvif->cache->bss_conf_changed |= changed;
>>   		return;
>> +	}
>>   
> 
> [...]
> 
>> @@ -6339,8 +6425,14 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
>>   	struct ath12k *ar;
>>   	int ret;
>>   
>> -	if (!arvif->is_created)
>> +	if (!arvif->is_created) {
>> +		/* if we cached some config but never received assign chanctx,
>> +		 * free the allocated cache.
>> +		 */
>> +		kfree(arvif->cache);
>> +		arvif->cache = NULL;
> 
> perhaps for the free code also have:
> ath12k_arvif_put_cache(arvif)
> 	kfree(arvif->cache);
> 	arvif->cache = NULL;
> 
>
>>   		return;
>> +	}
>>   
>>   	ar = arvif->ar;
>>   	ab = ar->ab;
> 

