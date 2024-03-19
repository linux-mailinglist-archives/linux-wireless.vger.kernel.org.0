Return-Path: <linux-wireless+bounces-4913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CDF880198
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 17:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B22B23794
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28581AB4;
	Tue, 19 Mar 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C0pw7eIM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59915208B0
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864774; cv=none; b=HaWygtqEZGu0asy7JlsiHAWoF3DRKQoZi94UBMJWut8Ga+YCXtLZDNGC6JSUOPkgRgz4MNTbvLGaCSkX9VQWYPufThAY4fpG5U1jIWY2CFErJFJ/BcGxmytR5SaXyiKDaR2tDjt8RJpuVd32M79ohc1MZ7P9qKXd7erg2a8Nz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864774; c=relaxed/simple;
	bh=sPVNE6YVk3gY/ivPsHf4ez14TkqIYH4Q/XNZvMVT6EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CrOI1CyGpsayqa/eTNggfc80iW9QPc0qOupLx+Mdqkj9cSd8fHBniAiiMUxchNehf6RklTtV3EpW6BNl9827kUZKKExCw/QgU0ia/uXl8lo3iG0cGUqgc44yzqXc8u45uy7iMBOiIshHSp9VvCHRYtcOo468QMmqTTZf2TCWIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C0pw7eIM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J6oB7I020509;
	Tue, 19 Mar 2024 16:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ASaGlPTqr00h4Zhm0C2CUrWCAWnnP6KdDmtlh81VPiY=; b=C0
	pw7eIM+ViJWp1UqrfMvnDhJ0S5uNItKw6/xEriuHSvLHv7eIqWonnU76V8ECXcPV
	7hr0T6WJFjoAwh9c/+D7TcxW0B793yT62fvvNDC0s2cChtnKSR9rHta53kBBrRgh
	oNuiTc84NFWtu4/e1vXxqLMDFKgizJ8a4w9t7/b1IVQBu9I1PrRsGQNr6mhZoEJG
	a98xjhwM9HFsV7iicx3Ju4S7T8BUoNA89PsN3SnjN3GYqjlRRGpUTVwOpmH8sCzO
	jk0dsvHo3ZxBsYmnTHfxb1Yv3t58rH4UHs/ETAK9mkepE5jPSBd6CdYwt2feCE9r
	FIGXVCOLYbypeCv5FCvQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy1jhsswb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 16:12:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JGCn5e023130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 16:12:49 GMT
Received: from [10.50.62.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 09:12:44 -0700
Message-ID: <5ed217ce-092e-4a93-93b9-7962500534de@quicinc.com>
Date: Tue, 19 Mar 2024 21:42:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] wifi: ath12k: Cache vdev configs before vdev
 create
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-8-quic_ramess@quicinc.com>
 <0beccca3-ffca-4eb1-b152-e31e9f3b3e21@quicinc.com>
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <0beccca3-ffca-4eb1-b152-e31e9f3b3e21@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w8qXyAm78F3O5F-3Y-F9mlplGoU_Cm2W
X-Proofpoint-GUID: w8qXyAm78F3O5F-3Y-F9mlplGoU_Cm2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403190124



On 3/13/2024 4:31 AM, Jeff Johnson wrote:
> On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
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
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.h |  19 ++++
>>   drivers/net/wireless/ath/ath12k/mac.c  | 116 +++++++++++++++++++------
>>   2 files changed, 107 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index 70daec38d486..fe151aa90687 100644
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
>> +	struct ath12k_vif_cache cache;
> 
> is there a reason this isn't a *cache?
> this allocation is only needed for the time between when a vdev is created and
> when a channel is assigned, so why not have a dynamic allocation that is only
> around for that time? otherwise for every vdev you waste this memory for the
> lifetime of the vdev.
> 
There is no specific reason behind it.
Your point makes sense, we need not have this for lifetime of the vdev. 
Shall we have cache as such and have *tx_conf and *key_conf as 
dynamically allocated members ?
That way we can allocate them whenever corresponding config is received 
and have it in cache.
>>   };
>>   
>>   struct ath12k_vif_iter {
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 6d2176b0a556..fab92f08fdb7 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -3021,12 +3021,14 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
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
>> +		arvif->cache.bss_conf_changed |= changed;
> 
> why don't you need to save the actual *info as well?
> 
info(ieee80211_bss_conf) can be obtained from arvif->vif(ieee80211_vif) 
whenever needed.
>>   		return;
>> +	}
>>   
>>   	mutex_lock(&ar->conf_mutex);
>>   
>> @@ -3517,12 +3519,11 @@ static int ath12k_clear_peer_keys(struct ath12k_vif *arvif,
>>   	return first_errno;
>>   }
>>   
>> -static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>> -				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
>> -				 struct ieee80211_key_conf *key)
>> +static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
>> +			      struct ieee80211_vif *vif, struct ieee80211_sta *sta,
>> +			      struct ieee80211_key_conf *key)
>>   {
>> -	struct ath12k *ar;
>> -	struct ath12k_base *ab;
>> +	struct ath12k_base *ab = ar->ab;
>>   	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>>   	struct ath12k_peer *peer;
>>   	struct ath12k_sta *arsta;
>> @@ -3530,28 +3531,11 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>   	int ret = 0;
>>   	u32 flags = 0;
>>   
>> -	/* BIP needs to be done in software */
>> -	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
>> -		return 1;
>> -
>> -	ar = ath12k_get_ar_by_vif(hw, vif);
>> -	if (!ar) {
>> -		WARN_ON_ONCE(1);
>> -		return -EINVAL;
>> -	}
>> -	ab = ar->ab;
>> +	lockdep_assert_held(&ar->conf_mutex);
>>   
>> -	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags))
>> +	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
>>   		return 1;
>>   
>> -	if (key->keyidx > WMI_MAX_KEY_INDEX)
>> -		return -ENOSPC;
>> -
>> -	mutex_lock(&ar->conf_mutex);
>> -
>>   	if (sta)
>>   		peer_addr = sta->addr;
>>   	else if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
>> @@ -3643,6 +3627,43 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>   	spin_unlock_bh(&ab->base_lock);
>>   
>>   exit:
>> +	return ret;
>> +}
>> +
>> +
>> +static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>> +				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
>> +				 struct ieee80211_key_conf *key)
>> +{
>> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	struct ath12k *ar;
>> +	int ret;
>> +
>> +	/* BIP needs to be done in software */
>> +	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
>> +	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
>> +	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
>> +	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
>> +		return 1;
>> +
>> +	if (key->keyidx > WMI_MAX_KEY_INDEX)
>> +		return -ENOSPC;
>> +
>> +	ar = ath12k_get_ar_by_vif(hw, vif);
>> +	if (!ar) {
>> +		/* ar is expected to be valid when sta ptr is available */
>> +		if (sta) {
>> +			WARN_ON_ONCE(1);
>> +			return -EINVAL;
>> +		}
>> +		arvif->cache.key_conf.cmd = cmd;
>> +		arvif->cache.key_conf.key = key;
>> +		arvif->cache.key_conf.changed = true;
>> +		return 0;
>> +	}
>> +
>> +	mutex_lock(&ar->conf_mutex);
>> +	ret = ath12k_mac_set_key(ar, cmd, vif, sta, key);
>>   	mutex_unlock(&ar->conf_mutex);
>>   	return ret;
>>   }
>> @@ -4477,7 +4498,10 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
>>   
>>   	ar = ath12k_get_ar_by_vif(hw, vif);
>>   	if (!ar) {
>> -		/* TODO cache the info and apply after vdev is created */
>> +		/* cache the info and apply after vdev is created */
>> +		arvif->cache.tx_conf.changed = true;
>> +		arvif->cache.tx_conf.ac = ac;
>> +		arvif->cache.tx_conf.tx_queue_params = *params;
>>   		return -EINVAL;
>>   	}
>>   
>> @@ -6121,6 +6145,41 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
>>   	return ret;
>>   }
>>   
>> +static void ath12k_mac_vif_cache_flush(struct ath12k *ar,  struct ieee80211_vif *vif)
>> +{
>> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	struct ath12k_base *ab = ar->ab;
>> +	int ret;
>> +
>> +	lockdep_assert_held(&ar->conf_mutex);
>> +
>> +	if (arvif->cache.tx_conf.changed) {
>> +		ret = ath12k_mac_conf_tx(arvif, 0, arvif->cache.tx_conf.ac,
>> +					 &arvif->cache.tx_conf.tx_queue_params);
>> +		if (ret)
>> +			ath12k_warn(ab,
>> +				    "unable to apply tx config parameters to vdev %d\n",
>> +				    ret);
>> +	}
>> +
>> +	if (arvif->cache.bss_conf_changed)
>> +		ath12k_mac_bss_info_changed(ar, arvif, &vif->bss_conf,
>> +					    arvif->cache.bss_conf_changed);
>> +
>> +	if (arvif->cache.key_conf.changed) {
>> +		ret = ath12k_mac_set_key(ar, arvif->cache.key_conf.cmd,
>> +					 vif, NULL,
>> +					 arvif->cache.key_conf.key);
>> +		if (ret) {
>> +			WARN_ON_ONCE(1);
>> +			ath12k_warn(ab, "unable to apply set key param to vdev %d ret %d\n",
>> +				    arvif->vdev_id, ret);
>> +		}
>> +	}
>> +
>> +	memset(&arvif->cache, 0, sizeof(struct ath12k_vif_cache));
> 
> sizeof(arvif->cache)
> 
>> +}
>> +
>>   static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
>>   						    struct ieee80211_vif *vif,
>>   						    struct ieee80211_chanctx_conf *ctx)
>> @@ -6203,10 +6262,11 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
>>   		goto unlock;
>>   	}
>>   
>> -	/* TODO If the vdev is created during channel assign and not during
>> +	/* If the vdev is created during channel assign and not during
>>   	 * add_interface(), Apply any parameters for the vdev which were received
>>   	 * after add_interface, corresponding to this vif.
>>   	 */
>> +	ath12k_mac_vif_cache_flush(ar, vif);
>>   unlock:
>>   	mutex_unlock(&ar->conf_mutex);
>>   out:
> 

