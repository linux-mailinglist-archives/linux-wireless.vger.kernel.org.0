Return-Path: <linux-wireless+bounces-9314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243BE910D9E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE40328348C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72C41B29CD;
	Thu, 20 Jun 2024 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XPQEfs82"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD671B29B6
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902380; cv=none; b=izSACQbwCzSs8WowcleYC/DpxNuylLriJZuzrixkpH+F9UTU2tinW9VGArsqyLCM93UgInicni4oETjK4aGDgJ0NT9jnOBajomFcEhZvxsyXGb2sTX53rIzEF8anjCY0PM9SCuiz9mrZN1rWOQbUg/qDJY563WSAM8adPO+Xlo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902380; c=relaxed/simple;
	bh=w6wb4TQevjYlAj3L3KCo4jdq1AoSYZSJpI+OzLWavb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QQEhOQzbZUQ9PQLghwRFR2/hB3LpdDYa1tCLTDwDDwE8RJuLEODS3YV6ZoQHc+NWYFQj2xbk2Y+xKAJ8RfY30HpFl5fIGKJ6YpV9VDqX/JYnC63uy51CXcsdr+fINeCAzOnTjnKmdrjbXWuPWQaKZYryc0YiQRe1qf7kKMBt2FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XPQEfs82; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K9v7ji009875;
	Thu, 20 Jun 2024 16:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jWXhfazn4/mALi8WcvHnr+n4EOcEu2PGpjjS3xu8N3U=; b=XPQEfs82LU2zWDXd
	XiYAT3crhVqy8b0szDQJDO6RandIMuvsUHssRuQzP5L6ZVubwRqaBj8+xaZGucXi
	LSKlh2yiK+GG89DBiL3zC97YoWi19Lvqc6BEZkBNOm6IiTEa5SbgLDw28FtEY7Ym
	LtTbYap/OiceZNygeHBRXDteWs76FFlXlWF1LGCdBBlreH9jcs21XTbsk+l23yrN
	voBTEbrP30+0Ufoh5i6TS5CtUspjvDpPukvq0vBPO+7T0tX/81dcL0vQxYVFBVqU
	/hJTMLPWpqjXv/g8lL9nslmBrKc4PgiQdU1v27Qlrm5gwdZwEtNMTyluRRyXePZ7
	rGGHRA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yv8h4a55p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:52:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGqr1l015274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:52:53 GMT
Received: from [10.216.57.43] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:52:51 -0700
Message-ID: <8c6c4394-a55d-41a6-bbcb-17adc67ac513@quicinc.com>
Date: Thu, 20 Jun 2024 22:22:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240617131650.3288118-1-quic_ramess@quicinc.com>
 <20240617131650.3288118-2-quic_ramess@quicinc.com>
 <3754f5f3-0e67-4c5e-9b56-888ad5071622@quicinc.com>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <3754f5f3-0e67-4c5e-9b56-888ad5071622@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vrxzlZAkG60PjStQ53OCYfhBiCu1-Y44
X-Proofpoint-GUID: vrxzlZAkG60PjStQ53OCYfhBiCu1-Y44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200120



On 6/18/2024 1:17 PM, Baochen Qiang wrote:
> 
> 
> On 6/17/2024 9:16 PM, Rameshkumar Sundaram wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> To prepare the driver for MLO support, split the driver vif
>> data structure to scale for multiple links. This requires changing
>> the use of arvif to per link and not per hw which can now
>> comprise of multiple links.
>> Also since most configurations from mac80211 are done per link, do refactoring
>> of the driver functions to apply these configurations at link level.
>>
>> Split ath12k_vif which is the driver private of ieee80211_vif to store
>> link specific information as ath12k_link_vif. For default use cases
>> the ath12k vif will have a preallocated link vif called deflink which will
>> be used by non ML and the first link vif of ML vif.
>>
>> With MLO Support to be added, remaining link vifs will be allocated during
>> channel assignment where vdev create/start happens. These link vifs will be
>> freed during interface down.
>>
>>         		Current ath12k_vif(arvif) structure
>>
>>               +---------------+      +---------------+     +---------------+
>>               | ieee80211_vif |      | ieee80211_vif |     | ieee80211_vif |
>>               | private data  |      | private data  |     | private data  |
>>               |               |      |               |     |               |
>>               |  ath12k_vif   |      |  ath12k_vif   |     |  ath12k_vif   |
>>               |  (arvif)      |      |  (arvif)      |     |  (arvif)      |
>>               |               |      |               |     |               |
>>               |  +----------+ |      |  +----------+ |     |  +----------+ |
>>               |  |*ar (2GHz)| |      |  |*ar (5GHz)| |     |  |*ar (2GHz)| |
>>               |  +----------+ |      |  +----------+ |     |  +----------+ |
>>               |               |      |               |     |               |
>>               +---------------+      +---------------+     +---------------+
>>
>>         	Proposed ath12k_vif(ahvif) containing ath12k_link_vif(s) (arvif)
>>         	(deflink is preallocated member which is always the first link if
>>         	 ieee80211_vif is MLD and is the only link otherwise)
>>
>>         			+---------------------------------+
>>         			|     ieee80211_vif               |
>>         			|     private data                |
>>         			|                                 |
>>         			|   ath12k_vif(ahvif)             |
>>         			|                                 |
>>         			| +-------------------------------+
>>         			| |ath12k_link_vif deflink (arvif)|
>>         			| |        +---------------+      |
>>         			| |        | *ar(2GHz)     |      |
>>         			| +-------------------------------+
>>         			| +-------------------------------+
>>         			| |  ath12k_link_vif *link (arvif)|
>>         			| |        +---------------+      |
>>         			| |        | *ar(5GHz)     |      |
>>         			| +-------------------------------+
>>         			| +-------------------------------+
>>         			| |  ath12k_link_vif *link (arvif)|
>>         			| |        +---------------+      |
>>         			| |        | *ar(6GHz)     |      |
>>         			| +-------------------------------+
>>         			|                                 |
>>         			+---------------------------------+
>>
>> To refactor existing ath12k_vif to make use of link vifs, following
>> changes are made,
>>
>>   1. ath12k_vif now called by variable name ahvif stores multiple
>>   arvifs(ah12k_link_vif) and also has a back pointer to ieee80211_vif.
>>
>>   2. In this patch set, only deflink is used to be on par with the
>>   existing code. When MLO support is added the link id will be used to
>>   fetch the arvif.
>>
>>   3. For mac80211 ops which doesn't use specific link_id, the config or info
>>   is common for the vif, hence apply the config to all link vifs.
>>   The links_map in the ahvif, will be used to identify all the link vifs that
>>   are setup.
>>
>>   4. Change ath12k_vif_to_arvif() as ath12k_vif_to_ahvif() to fetch the
>>   hw level vif. The link vif can be fetched from ahvif->link[], or the
>>   deflink can be accessed via ahvif->deflink. API to access link
>>   vif(arvif) by passing link_id can be introduced with MLO Support.
>>
>>   5. The ieee80211_vif can be accessed from ahvif using ath12k_vif_to_vif()
>>
>> Locking:
>>   Currently modifications to members of arvif and arsta are protected by ar->conf_mutex
>>   and it stays as such.
>>   Now with these hw level structure (ahvif) being introduced, any modifications
>>   to its members and link objects (i.e., arvifs[] which are dynamically allocated)
>>   needs to be protected for writing and ah->conf_mutex is used for the same.
>>   Also, atomic contexts(say WMI events and certain mac_ops) that we currently have in driver
>>   will not(shouldn't be allowed) do any modifications but can read them and
>>   rcu_read_lock() is used for the same.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.h  |  69 ++-
>>   drivers/net/wireless/ath/ath12k/dp.c    |  21 +-
>>   drivers/net/wireless/ath/ath12k/dp.h    |   3 +-
>>   drivers/net/wireless/ath/ath12k/dp_rx.c |   2 +-
>>   drivers/net/wireless/ath/ath12k/dp_rx.h |   2 +-
>>   drivers/net/wireless/ath/ath12k/dp_tx.c |   9 +-
>>   drivers/net/wireless/ath/ath12k/dp_tx.h |   2 +-
>>   drivers/net/wireless/ath/ath12k/mac.c   | 733 ++++++++++++++++--------
>>   drivers/net/wireless/ath/ath12k/mac.h   |   9 +-
>>   drivers/net/wireless/ath/ath12k/p2p.c   |  17 +-
>>   drivers/net/wireless/ath/ath12k/p2p.h   |   2 +-
>>   drivers/net/wireless/ath/ath12k/peer.c  |   7 +-
>>   drivers/net/wireless/ath/ath12k/peer.h  |   4 +-
>>   drivers/net/wireless/ath/ath12k/wmi.c   |  12 +-
>>   14 files changed, 592 insertions(+), 300 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index b483899ca136..d47b6413aaad 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -229,10 +229,8 @@ struct ath12k_vif_cache {
>>   	u32 bss_conf_changed;
>>   };
>>   
>> -struct ath12k_vif {
>> +struct ath12k_link_vif {
>>   	u32 vdev_id;
>> -	enum wmi_vdev_type vdev_type;
>> -	enum wmi_vdev_subtype vdev_subtype;
>>   	u32 beacon_interval;
>>   	u32 dtim_period;
>>   	u16 ast_hash;
>> @@ -242,13 +240,38 @@ struct ath12k_vif {
>>   	u8 search_type;
>>   
>>   	struct ath12k *ar;
>> -	struct ieee80211_vif *vif;
>>   
>>   	int bank_id;
>>   	u8 vdev_id_check_en;
>>   
>>   	struct wmi_wmm_params_all_arg wmm_params;
>>   	struct list_head list;
>> +
>> +	bool is_created;
>> +	bool is_started;
>> +	bool is_up;
>> +	u8 bssid[ETH_ALEN];
>> +	struct cfg80211_bitrate_mask bitrate_mask;
>> +	struct delayed_work connection_loss_work;
>> +	int num_legacy_stations;
>> +	int rtscts_prot_mode;
>> +	int txpower;
>> +	bool rsnie_present;
>> +	bool wpaie_present;
>> +	struct ieee80211_chanctx_conf chanctx;
>> +	u8 vdev_stats_id;
>> +	u32 punct_bitmap;
>> +	u8 link_id;
>> +	struct ath12k_vif *ahvif;
>> +	struct ath12k_vif_cache *cache;
>> +};
>> +
>> +struct ath12k_vif {
>> +	enum wmi_vdev_type vdev_type;
>> +	enum wmi_vdev_subtype vdev_subtype;
>> +	struct ieee80211_vif *vif;
>> +	struct ath12k_hw *ah;
>> +
>>   	union {
>>   		struct {
>>   			u32 uapsd;
>> @@ -266,31 +289,21 @@ struct ath12k_vif {
>>   		} ap;
>>   	} u;
>>   
>> -	bool is_created;
>> -	bool is_started;
>> -	bool is_up;
>>   	u32 aid;
>> -	u8 bssid[ETH_ALEN];
>> -	struct cfg80211_bitrate_mask bitrate_mask;
>> -	struct delayed_work connection_loss_work;
>> -	int num_legacy_stations;
>> -	int rtscts_prot_mode;
>> -	int txpower;
>> -	bool rsnie_present;
>> -	bool wpaie_present;
>> -	struct ieee80211_chanctx_conf chanctx;
>>   	u32 key_cipher;
>>   	u8 tx_encap_type;
>> -	u8 vdev_stats_id;
>> -	u32 punct_bitmap;
>>   	bool ps;
>> -	struct ath12k_vif_cache *cache;
>> +
>> +	struct ath12k_link_vif deflink;
>> +	struct ath12k_link_vif __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
>> +	/* indicates bitmap of link vif created in FW */
>> +	u16 links_map;
>>   };
>>   
>>   struct ath12k_vif_iter {
>>   	u32 vdev_id;
>>   	struct ath12k *ar;
>> -	struct ath12k_vif *arvif;
>> +	struct ath12k_link_vif *arvif;
>>   };
>>   
>>   #define HAL_AST_IDX_INVALID	0xFFFF
>> @@ -426,7 +439,7 @@ struct ath12k_wbm_tx_stats {
>>   };
>>   
>>   struct ath12k_sta {
>> -	struct ath12k_vif *arvif;
>> +	struct ath12k_link_vif *arvif;
>>   
>>   	/* the following are protected by ar->data_lock */
>>   	u32 changed; /* IEEE80211_RC_* */
>> @@ -543,7 +556,7 @@ struct ath12k {
>>   	 */
>>   	struct mutex conf_mutex;
>>   	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
>> -	 * vdev_stop_status info, scan data, ath12k_sta info, ath12k_vif info,
>> +	 * vdev_stop_status info, scan data, ath12k_sta info, ath12k_link_vif info,
>>   	 * channel context data, survey info, test mode data.
>>   	 */
>>   	spinlock_t data_lock;
>> @@ -639,6 +652,11 @@ struct ath12k_hw {
>>   	enum ath12k_hw_state state;
>>   	bool regd_updated;
>>   	bool use_6ghz_regd;
>> +
>> +	/* To synchronize concurrent access of ahvif->link[]
>> +	 * between mac80211 operations.
>> +	 */
>> +	struct mutex conf_mutex;
>>   	u8 num_radio;
>>   
>>   	/* Keep last */
>> @@ -995,7 +1013,7 @@ static inline struct ath12k_skb_rxcb *ATH12K_SKB_RXCB(struct sk_buff *skb)
>>   	return (struct ath12k_skb_rxcb *)skb->cb;
>>   }
>>   
>> -static inline struct ath12k_vif *ath12k_vif_to_arvif(struct ieee80211_vif *vif)
>> +static inline struct ath12k_vif *ath12k_vif_to_ahvif(struct ieee80211_vif *vif)
>>   {
>>   	return (struct ath12k_vif *)vif->drv_priv;
>>   }
>> @@ -1005,6 +1023,11 @@ static inline struct ath12k_sta *ath12k_sta_to_arsta(struct ieee80211_sta *sta)
>>   	return (struct ath12k_sta *)sta->drv_priv;
>>   }
>>   
>> +static inline struct ieee80211_vif *ath12k_vif_to_vif(struct ath12k_vif *ahvif)
> better naming as ath12k_ahvif_to_vif()?
> 
Sure, make sense will change as suggested.

>> +{
>> +	return container_of((void *)ahvif, struct ieee80211_vif, drv_priv);
>> +}
>> +
>>   static inline struct ath12k *ath12k_ab_to_ar(struct ath12k_base *ab,
>>   					     int mac_id)
>>   {
>> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
>> index 61aa78d8bd8c..30aac0dd5a80 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp.c
>> @@ -327,20 +327,22 @@ int ath12k_dp_srng_setup(struct ath12k_base *ab, struct dp_srng *ring,
>>   }
>>   
...

>>   
>> @@ -4655,11 +4787,14 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
>>   		return;
>>   	}
>>   
>> +	rcu_read_lock();
>> +	arvif = &ahvif->deflink;
> does ath12k_vif::deflink need rcu protect? note it is not declared as rcu*, and even mac80211 uses it without holding such lock. See
Not needed, but this is going to be link specific once MLO changes are 
in and ideally we should now be obtaining ahvif->link[0] (which is 
anyway deflink as of now) as a preperation for that. Will change this to 
use link[0].
> 	ieee80211_mgd_auth() {
> 		struct ieee80211_link_data *link;
> 		...
> 		if()
> 			...
> 		else
> 			link = &sdata->deflink;
> 
> 		...
> 	}
> 
>>   	spin_lock_bh(&ar->ab->base_lock);
>>   
>>   	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
>>   	if (!peer) {
>>   		spin_unlock_bh(&ar->ab->base_lock);
>> +		rcu_read_unlock();
>>   		ath12k_warn(ar->ab, "mac sta rc update failed to find peer %pM on vdev %i\n",
>>   			    sta->addr, arvif->vdev_id);
>>   		return;

