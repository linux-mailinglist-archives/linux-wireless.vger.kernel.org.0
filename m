Return-Path: <linux-wireless+bounces-4678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B487A99C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8272826CA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF14A07;
	Wed, 13 Mar 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G1szpV+N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B933F9
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340626; cv=none; b=iN6dT2bNIxLqgOAkRs5ziVrWWdpunPYTiHDRRDj2X0q9jiKQFG+5Vnr+OiXCOH+ufocft8Mc1D2h4rZ7Lqw+pQFJcbKEhN/QKeOuZ7BSMb056ZQfX4Oc+TMSBAV+UAanVagG9tXDuEnVwHRidVzZ2OVhFXbwBWX28s7nTVjVzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340626; c=relaxed/simple;
	bh=BI1ciAuvc+Mwnh9Tz5OwcgQsyW6Czzpjb6wi51eNO2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gpa3svrRQLQYOCDBl+kxhYxZ7wt8eg2IqZ+74pFU6DN8h3RRLOkAnHMyI1GulWxDR+e7SjRVc6V4ptLGpD7kNTlroQIMCcoykyvtEr8cy7FpsDlZpUdtcj+VQ1fwDTVQCkPvYxAFyy/V2IxyzYKuKcSr+y12/V17frXTR3uV74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G1szpV+N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DCT8Gt015082;
	Wed, 13 Mar 2024 14:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YkdLPGDVKjXyJZngVh/SWpPUlnu9njnMlTlWOPTomVQ=; b=G1
	szpV+NnvK86caIJZwL2EEYu58Epwj3WwE9gmkDXZENSsIynljE/U9l6439jArZJ2
	EmRk8R0BUlWNzhZKbcNhUWeL4tY7r3GYrK+JYUOShUv30yfLxSuPGTx2hQBin6kC
	8GxPdstNvJLt1agkHPnSIO2kPm/VWTcvFreNynSy9Qb7zATcWlrTxu6a2BKSR1mf
	9uTAiwdn/FFkVVcsc9ITAa4kCBIoTa63+HjLDzqb2mz4unyr3toibwFulzeIurrM
	RlAs6ZEyR2R3QFt4/mO78w5+ZSnV9uw5eNaIFuV1nZ1lsfsIN45wtsMVtrIyMjWe
	y+D9J65J4tZGchX98cJg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuc5f89jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 14:37:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DEaxUF027528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 14:36:59 GMT
Received: from [10.50.3.124] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 07:36:56 -0700
Message-ID: <de83c4fd-84de-432c-89c0-afc38b9adc77@quicinc.com>
Date: Wed, 13 Mar 2024 20:06:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] wifi: ath12k: vdev statemachine changes for
 single wiphy
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-5-quic_ramess@quicinc.com>
 <4db3a534-42c6-4469-9ad1-764ab0018e8b@quicinc.com>
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <4db3a534-42c6-4469-9ad1-764ab0018e8b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MFAYqV3ERIX8TO4rmudmu-jhGDbsV1_X
X-Proofpoint-ORIG-GUID: MFAYqV3ERIX8TO4rmudmu-jhGDbsV1_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130109



On 3/13/2024 3:55 AM, Jeff Johnson wrote:
> On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> With single wiphy, multiple radios are combined into a single wiphy.
>> Since any channel can be assigned to a vif being brought up,
>> the vdev cannot be created during add_interface(). Hence defer the
>> vdev creation till channel assignment.
>>
>> If only one radio is part of the wiphy, then the existing logic
>> is maintained, i.e vdevs are created during add interface and
>> started during channel assignment. This ensures no functional changes
>> to single pdev devices which has only one radio in the SoC.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.h |   1 +
>>   drivers/net/wireless/ath/ath12k/hw.h   |   1 +
>>   drivers/net/wireless/ath/ath12k/mac.c  | 203 +++++++++++++++++--------
>>   3 files changed, 144 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index 53bcf9416efd..70daec38d486 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -251,6 +251,7 @@ struct ath12k_vif {
>>   		} ap;
>>   	} u;
>>   
>> +	bool is_created;
>>   	bool is_started;
>>   	bool is_up;
>>   	u32 aid;
>> diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
>> index 87965980b938..e34c4f76c1ec 100644
>> --- a/drivers/net/wireless/ath/ath12k/hw.h
>> +++ b/drivers/net/wireless/ath/ath12k/hw.h
>> @@ -80,6 +80,7 @@
>>   #define TARGET_RX_PEER_METADATA_VER_V1A	2
>>   #define TARGET_RX_PEER_METADATA_VER_V1B	3
>>   
>> +#define ATH12K_HW_DEFAULT_QUEUE		0
>>   #define ATH12K_HW_MAX_QUEUES		4
>>   #define ATH12K_QUEUE_LEN		4096
>>   
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 4afaba3ba934..b6afef81a2d8 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -5780,64 +5780,24 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
>>   	ath12k_mac_update_vif_offload(arvif);
>>   }
>>   
>> -static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>> -				       struct ieee80211_vif *vif)
>> +static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
>>   {
>> -	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>> -	struct ath12k *ar;
>> -	struct ath12k_base *ab;
>> +	struct ath12k_hw *ah = ar->ah;
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct ieee80211_hw *hw = ah->hw;
>>   	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>>   	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
>>   	struct ath12k_wmi_peer_create_arg peer_param;
>>   	u32 param_id, param_value;
>>   	u16 nss;
>>   	int i;
>> -	int ret;
>> -	int bit;
>> -
>> -	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
>> +	int ret, vdev_id;
>>   
>> -	ar = ath12k_ah_to_ar(ah, 0);
>> -	ab = ar->ab;
>> -
>> -	mutex_lock(&ar->conf_mutex);
>> -
>> -	if (vif->type == NL80211_IFTYPE_AP &&
>> -	    ar->num_peers > (ar->max_num_peers - 1)) {
>> -		ath12k_warn(ab, "failed to create vdev due to insufficient peer entry resource in firmware\n");
>> -		ret = -ENOBUFS;
>> -		goto err;
>> -	}
>> -
>> -	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
>> -		ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
>> -			    TARGET_NUM_VDEVS);
>> -		ret = -EBUSY;
>> -		goto err;
>> -	}
>> -
>> -	memset(arvif, 0, sizeof(*arvif));
>> +	lockdep_assert_held(&ar->conf_mutex);
>>   
>>   	arvif->ar = ar;
>> -	arvif->vif = vif;
>> -
>> -	INIT_LIST_HEAD(&arvif->list);
>> -
>> -	/* Should we initialize any worker to handle connection loss indication
>> -	 * from firmware in sta mode?
>> -	 */
>> -
>> -	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
>> -		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
>> -		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
>> -		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
>> -		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
>> -		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
>> -	}
>> -
>> -	bit = __ffs64(ab->free_vdev_map);
>> -
>> -	arvif->vdev_id = bit;
>> +	vdev_id = __ffs64(ab->free_vdev_map);
>> +	arvif->vdev_id = vdev_id;
>>   	arvif->vdev_subtype = WMI_VDEV_SUBTYPE_NONE;
>>   
>>   	switch (vif->type) {
>> @@ -5861,7 +5821,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>>   		break;
>>   	case NL80211_IFTYPE_MONITOR:
>>   		arvif->vdev_type = WMI_VDEV_TYPE_MONITOR;
>> -		ar->monitor_vdev_id = bit;
>> +		ar->monitor_vdev_id = vdev_id;
>>   		break;
>>   	case NL80211_IFTYPE_P2P_DEVICE:
>>   		arvif->vdev_type = WMI_VDEV_TYPE_STA;
>> @@ -5872,7 +5832,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>>   		break;
>>   	}
>>   
>> -	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac add interface id %d type %d subtype %d map %llx\n",
>> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev create id %d type %d subtype %d map %llx\n",
>>   		   arvif->vdev_id, arvif->vdev_type, arvif->vdev_subtype,
>>   		   ab->free_vdev_map);
>>   
>> @@ -5890,6 +5850,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>>   	}
>>   
>>   	ar->num_created_vdevs++;
>> +	arvif->is_created = true;
>>   	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM created, vdev_id %d\n",
>>   		   vif->addr, arvif->vdev_id);
>>   	ar->allocated_vdev_map |= 1LL << arvif->vdev_id;
>> @@ -5990,8 +5951,6 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>>   	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
>>   		ath12k_mac_monitor_vdev_create(ar);
>>   
>> -	mutex_unlock(&ar->conf_mutex);
>> -
>>   	return ret;
>>   
>>   err_peer_del:
>> @@ -6017,6 +5976,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>>   err_vdev_del:
>>   	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
>>   	ar->num_created_vdevs--;
>> +	arvif->is_created = false;
>>   	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
>>   	ab->free_vdev_map |= 1LL << arvif->vdev_id;
>>   	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
>> @@ -6025,9 +5985,104 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>>   	spin_unlock_bh(&ar->data_lock);
>>   
>>   err:
>> +	arvif->ar = NULL;
>> +	return ret;
>> +}
>> +
>> +static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
>> +						    struct ieee80211_vif *vif,
>> +						    struct ieee80211_chanctx_conf *ctx)
>> +{
>> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	struct ath12k_hw *ah = hw->priv;
>> +	struct ath12k_base *ab;
>> +	struct ath12k *ar;
>> +	int ret;
>> +	u8 bit;
>> +
>> +	if (arvif->ar) {
>> +		WARN_ON(!arvif->is_created);
>> +		goto out;
>> +	}
>> +
>> +	if (ah->num_radio == 1)
>> +		ar = ah->radio;
>> +	else if (ctx)
>> +		ar = ath12k_get_ar_by_ctx(hw, ctx);
>> +	else
>> +		return NULL;
>> +
>> +	if (!ar)
>> +		goto out;
> 
> why does this goto out instead of just return NULL?
yeah, we can. Thanks for pointing out, will fix it in next version.
> 
>> +
>> +	ab = ar->ab;
>> +
>> +	mutex_lock(&ar->conf_mutex);
>> +
>> +	if (vif->type == NL80211_IFTYPE_AP &&
>> +	    ar->num_peers > (ar->max_num_peers - 1)) {
>> +		ath12k_warn(ab, "failed to create vdev due to insufficient peer entry resource in firmware\n");
>> +		ret = -ENOBUFS;
>> +		goto unlock;
> 
> nothing is done with ret so setting it is pointless
> 
Sure, will remove this and below instance too.
>> +	}
>> +
>> +	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
>> +		ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
>> +			    TARGET_NUM_VDEVS);
>> +		ret = -EBUSY;
>> +		goto unlock;
> 
> nothing is done with ret so setting it is pointless
> 
>> +	}
>> +
>> +	ret = ath12k_mac_vdev_create(ar, vif);
>> +	if (ret) {
>> +		ath12k_warn(ab, "failed to create vdev %d ret %d", bit, ret);
>> +		goto unlock;
>> +	}
>> +
>> +	/* TODO If the vdev is created during channel assign and not during
>> +	 * add_interface(), Apply any parameters for the vdev which were received
>> +	 * after add_interface, corresponding to this vif.
>> +	 */
>> +unlock:
>>   	mutex_unlock(&ar->conf_mutex);
>> +out:
>> +	return arvif->ar;
>> +}
>>   
>> -	return ret;
>> +static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>> +				       struct ieee80211_vif *vif)
>> +{
>> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	int i;
>> +
>> +	memset(arvif, 0, sizeof(*arvif));
>> +
>> +	arvif->vif = vif;
>> +
>> +	INIT_LIST_HEAD(&arvif->list);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
>> +		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
>> +		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
>> +		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
>> +		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
>> +		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
>> +	}
>> +
>> +	/* Allocate Default Queue now and reassign during actual vdev create */
>> +	vif->cab_queue = ATH12K_HW_DEFAULT_QUEUE;
>> +	for (i = 0; i < ARRAY_SIZE(vif->hw_queue); i++)
>> +		vif->hw_queue[i] = ATH12K_HW_DEFAULT_QUEUE;
>> +
>> +	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
>> +
>> +	/* For single radio wiphy(i.e ah->num_radio is 1), create the vdev
>> +	 * during add_interface itself, for multi radio wiphy, defer the vdev
>> +	 * creation until channel_assign to determine the radio on which the
>> +	 * vdev needs to be created
>> +	 */
>> +	ath12k_mac_assign_vif_to_vdev(hw, vif, NULL);
>> +	return 0;
>>   }
>>   
>>   static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif)
>> @@ -6058,14 +6113,16 @@ static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif
>>   static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
>>   					   struct ieee80211_vif *vif)
>>   {
>> -	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>>   	struct ath12k *ar;
>>   	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>>   	struct ath12k_base *ab;
>>   	unsigned long time_left;
>>   	int ret;
>>   
>> -	ar = ath12k_ah_to_ar(ah, 0);
>> +	if (!arvif->is_created)
>> +		return;
>> +
>> +	ar = arvif->ar;
>>   	ab = ar->ab;
>>   
>>   	mutex_lock(&ar->conf_mutex);
>> @@ -6107,6 +6164,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
>>   	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
>>   	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
>>   	ar->num_created_vdevs--;
>> +	arvif->is_created = false;
>>   
>>   	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM deleted, vdev_id %d\n",
>>   		   vif->addr, arvif->vdev_id);
>> @@ -6759,14 +6817,21 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
>>   				 struct ieee80211_bss_conf *link_conf,
>>   				 struct ieee80211_chanctx_conf *ctx)
>>   {
>> -	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>>   	struct ath12k *ar;
>>   	struct ath12k_base *ab;
>>   	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>>   	int ret;
>>   	struct ath12k_wmi_peer_create_arg param;
>>   
>> -	ar = ath12k_ah_to_ar(ah, 0);
>> +	/* For multi radio wiphy, the vdev was not created during add_interface
>> +	 * create now since we have a channel ctx now to assign to a specific ar/fw
>> +	 */
>> +	ar = ath12k_mac_assign_vif_to_vdev(hw, vif, ctx);
>> +	if (!ar) {
>> +		WARN_ON(1);
>> +		return -EINVAL;
>> +	}
>> +
>>   	ab = ar->ab;
>>   
>>   	mutex_lock(&ar->conf_mutex);
>> @@ -6842,13 +6907,22 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
>>   				   struct ieee80211_bss_conf *link_conf,
>>   				   struct ieee80211_chanctx_conf *ctx)
>>   {
>> -	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>>   	struct ath12k *ar;
>>   	struct ath12k_base *ab;
>>   	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>>   	int ret;
>>   
>> -	ar = ath12k_ah_to_ar(ah, 0);
>> +	/* The vif is expected to be attached to an ar's VDEV.
>> +	 * We leave the vif/vdev in this function as is
>> +	 * and not delete the vdev symmetric to assign_vif_chanctx()
>> +	 * the VDEV will be deleted and unassigned either during
>> +	 * remove_interface() or when there is a change in channel
>> +	 * that moves the vif to a new ar
>> +	 */
>> +	if (!arvif->is_created)
>> +		return;
>> +
>> +	ar = arvif->ar;
>>   	ab = ar->ab;
>>   
>>   	mutex_lock(&ar->conf_mutex);
>> @@ -6900,13 +6974,20 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
>>   				 int n_vifs,
>>   				 enum ieee80211_chanctx_switch_mode mode)
>>   {
>> -	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>>   	struct ath12k *ar;
>>   
>> -	ar = ath12k_ah_to_ar(ah, 0);
>> +	ar = ath12k_get_ar_by_ctx(hw, vifs->old_ctx);
>> +	if (!ar)
>> +		return -EINVAL;
>>   
>>   	mutex_lock(&ar->conf_mutex);
>>   
>> +	/* Switching channels across radio is not allowed */
>> +	if (ar != ath12k_get_ar_by_ctx(hw, vifs->new_ctx)) {
>> +		mutex_unlock(&ar->conf_mutex);
>> +		return -EINVAL;
>> +	}
>> +
>>   	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
>>   		   "mac chanctx switch n_vifs %d mode %d\n",
>>   		   n_vifs, mode);
> 

