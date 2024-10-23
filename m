Return-Path: <linux-wireless+bounces-14423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E639ACEFB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C462B25FB1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921003A1DA;
	Wed, 23 Oct 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AdP6a243"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290F1BD004
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697899; cv=none; b=b6Al4h3GFhi3bUVMFwUR/5DbY0mwdibCpyuk3AsO/FsKUVKrUIxAiarIle63+fzOcZ16S0UcirkpNWIsjFRl4IQZYOonDxXYwXIQ94zxdYgJHqs3duJtrwGobaYoFw6Pu5zwClsTeJPYsEqFnB4V4+9sHJwJ+eNpFkjV2Y5NMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697899; c=relaxed/simple;
	bh=WFkGGUoBPhP/nrajUmWDM6MBo3Np9TAs3BeI8E5RWww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DPY7kU5ADgKKcyjPCAAkkwx72ATU/CpqVHikvxlcdGdgSvpl/Jg7MSc28wJ+eIy+bpccXP6FCGyf/Vawd1u4ziAnzmUs1UXxoCobzCdnlHGOgTyyoUF469zV+ACH8DK5xABbJyVd2TMU7QgGs+viw+G+uCKRUE55ktlG8fzYUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AdP6a243; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9v3aJ016005;
	Wed, 23 Oct 2024 15:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sHduossKecf4hbXroik6u8ZzJxDWaenUn4RABmxCs4Y=; b=AdP6a243VFKV5k6M
	hH/uo/Gno9Lv+Qlr7rNktxQ3J4v7fzgC889NvMliRdPDiT55uuaZVJrTIMqKT216
	S0M8up0NC7SQoDhomiBvjpMTJkt3U6WhuQIYDlJsXw+nJAwffjGI36ne8WlJtKFi
	3EcHPttpO1gQHpcuFMDRjEoPQP7n8xM9vMp4aG6dND1S2NP1ahrVCvsQfr6Z9VN7
	kNX4h6DGmyC717JyH7ap8gUeoTx22YGM+PivNck1RASYY6uJMcuFT3/2lNMCn5ie
	vs1FtiPDWYfsYY6pKuJhhzxMYnSkHgnvsCP7QbvSHd+rdfjJhe/lLoeO/p0JUng8
	g17hhQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3xjpy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:38:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NFcAdd020429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:38:10 GMT
Received: from [10.48.242.6] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 08:38:10 -0700
Message-ID: <a4b92b80-ec57-4db3-acd7-9c6c7644d7c9@quicinc.com>
Date: Wed, 23 Oct 2024 08:38:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] wifi: ath12k: Refactor sta state machine
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-4-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241023133004.2253830-4-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5gQrdkBJhrp3g4VgTnC9HzPQU0yqwjHw
X-Proofpoint-ORIG-GUID: 5gQrdkBJhrp3g4VgTnC9HzPQU0yqwjHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230096

On 10/23/2024 6:29 AM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Refactor ath12k_mac_op_sta_state(), with generic wrappers which can be used for
> both multi link stations and non-ML stations.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |   3 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 341 +++++++++++++++++--------
>  2 files changed, 242 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 06b637ba8b8f..6faa46b9adc9 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -461,6 +461,9 @@ struct ath12k_link_sta {
>  	struct ath12k_link_vif *arvif;
>  	struct ath12k_sta *ahsta;
>  
> +	/* link address similar to ieee80211_link_sta */
> +	u8 addr[ETH_ALEN];
> +
>  	/* the following are protected by ar->data_lock */
>  	u32 changed; /* IEEE80211_RC_* */
>  	u32 bw;
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index d4aa4540c8e6..3de6d605cd74 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4519,10 +4519,10 @@ ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_link_vif *arvif,
>  	return ret;
>  }
>  
> -static int ath12k_station_assoc(struct ath12k *ar,
> -				struct ath12k_link_vif *arvif,
> -				struct ath12k_link_sta *arsta,
> -				bool reassoc)
> +static int ath12k_mac_station_assoc(struct ath12k *ar,
> +				    struct ath12k_link_vif *arvif,
> +				    struct ath12k_link_sta *arsta,
> +				    bool reassoc)
>  {
>  	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
>  	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
> @@ -4609,28 +4609,19 @@ static int ath12k_station_assoc(struct ath12k *ar,
>  	return 0;
>  }
>  
> -static int ath12k_station_disassoc(struct ath12k *ar,
> -				   struct ath12k_link_vif *arvif,
> -				   struct ath12k_link_sta *arsta)
> +static int ath12k_mac_station_disassoc(struct ath12k *ar,
> +				       struct ath12k_link_vif *arvif,
> +				       struct ath12k_link_sta *arsta)
>  {
>  	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
> -	int ret;
>  
>  	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>  
>  	if (!sta->wme) {
>  		arvif->num_legacy_stations--;
> -		ret = ath12k_recalc_rtscts_prot(arvif);
> -		if (ret)
> -			return ret;
> +		return ath12k_recalc_rtscts_prot(arvif);
>  	}
>  
> -	ret = ath12k_clear_peer_keys(arvif, sta->addr);
> -	if (ret) {
> -		ath12k_warn(ar->ab, "failed to clear all peer keys for vdev %i: %d\n",
> -			    arvif->vdev_id, ret);
> -		return ret;
> -	}
>  	return 0;
>  }
>  
> @@ -4826,6 +4817,145 @@ static void ath12k_mac_dec_num_stations(struct ath12k_link_vif *arvif,
>  	ar->num_stations--;
>  }
>  
> +static void ath12k_mac_station_post_remove(struct ath12k *ar,
> +					   struct ath12k_link_vif *arvif,
> +					   struct ath12k_link_sta *arsta)
> +{
> +	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
> +	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
> +	struct ath12k_sta *ahsta = arsta->ahsta;
> +	struct ath12k_peer *peer;
> +
> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> +
> +	ath12k_mac_dec_num_stations(arvif, arsta);
> +
> +	spin_lock_bh(&ar->ab->base_lock);
> +
> +	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
> +	if (peer && peer->sta == sta) {
> +		ath12k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
> +			    vif->addr, arvif->vdev_id);
> +		peer->sta = NULL;
> +		list_del(&peer->list);
> +		kfree(peer);
> +		ar->num_peers--;
> +	}
> +
> +	spin_unlock_bh(&ar->ab->base_lock);
> +
> +	kfree(arsta->rx_stats);
> +	arsta->rx_stats = NULL;
> +
> +	if (arsta->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
> +		rcu_assign_pointer(ahsta->link[arsta->link_id], NULL);
> +		synchronize_rcu();

I've mentioned this in the past in some internal discussion and seems now is a
good time to bring this to light.

It concerns me that this happens so late in the process. In theory another
thread could already have a valid arsta pointer and could be trying to
dereference that pointer while the code above is destroying underlying data
(i.e. arsta->rx_stats).

Should we set this to NULL and synchronize RCU at the beginning of the process
so that we know all access to the struct has finished before we start
destroying the data?

Or can this not actually happen in practice due to other synchronization
mechansims? And if so, should we document that somewhere?


> +		ahsta->links_map &= ~(BIT(arsta->link_id));
> +		arsta->link_id = ATH12K_INVALID_LINK_ID;
> +		arsta->ahsta = NULL;
> +	}
> +}
> +
> +static int ath12k_mac_station_unauthorize(struct ath12k *ar,
> +					  struct ath12k_link_vif *arvif,
> +					  struct ath12k_link_sta *arsta)
> +{
> +	struct ath12k_peer *peer;
> +	int ret;
> +
> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> +
> +	spin_lock_bh(&ar->ab->base_lock);
> +
> +	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
> +	if (peer)
> +		peer->is_authorized = false;
> +
> +	spin_unlock_bh(&ar->ab->base_lock);
> +
> +	/* Driver should clear the peer keys during mac80211's ref ptr
> +	 * gets cleared in __sta_info_destroy_part2 (trans from
> +	 * IEEE80211_STA_AUTHORIZED to IEEE80211_STA_ASSOC)

I'm unable to understand this comment

> +	 */
> +	ret = ath12k_clear_peer_keys(arvif, arsta->addr);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to clear all peer keys for vdev %i: %d\n",
> +			    arvif->vdev_id, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ath12k_mac_station_authorize(struct ath12k *ar,
> +					struct ath12k_link_vif *arvif,
> +					struct ath12k_link_sta *arsta)
> +{
> +	struct ath12k_peer *peer;
> +	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
> +	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
> +	int ret;
> +
> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> +
> +	spin_lock_bh(&ar->ab->base_lock);
> +
> +	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
> +	if (peer)
> +		peer->is_authorized = true;
> +
> +	spin_unlock_bh(&ar->ab->base_lock);
> +
> +	if (vif->type == NL80211_IFTYPE_STATION && arvif->is_up) {
> +		ret = ath12k_wmi_set_peer_param(ar, sta->addr,
> +						arvif->vdev_id,
> +						WMI_PEER_AUTHORIZE,
> +						1);
> +		if (ret) {
> +			ath12k_warn(ar->ab, "Unable to authorize peer %pM vdev %d: %d\n",
> +				    sta->addr, arvif->vdev_id, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ath12k_mac_station_remove(struct ath12k *ar,
> +				     struct ath12k_link_vif *arvif,
> +				     struct ath12k_link_sta *arsta)
> +{
> +	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
> +	struct ath12k_vif *ahvif = arvif->ahvif;
> +	int ret;
> +
> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> +
> +	wiphy_work_cancel(ar->ah->hw->wiphy, &arsta->update_wk);
> +
> +	if (ahvif->vdev_type == WMI_VDEV_TYPE_STA) {
> +		ath12k_bss_disassoc(ar, arvif);
> +		ret = ath12k_mac_vdev_stop(arvif);
> +		if (ret)
> +			ath12k_warn(ar->ab, "failed to stop vdev %i: %d\n",
> +				    arvif->vdev_id, ret);
> +	}
> +
> +	ath12k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
> +
> +	ret = ath12k_peer_delete(ar, arvif->vdev_id, sta->addr);
> +	if (ret)
> +		ath12k_warn(ar->ab, "Failed to delete peer: %pM for VDEV: %d\n",
> +			    sta->addr, arvif->vdev_id);
> +	else
> +		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "Removed peer: %pM for VDEV: %d\n",
> +			   sta->addr, arvif->vdev_id);
> +
> +	ath12k_mac_station_post_remove(ar, arvif, arsta);
> +
> +	return ret;
> +}
> +
>  static int ath12k_mac_station_add(struct ath12k *ar,
>  				  struct ath12k_link_vif *arvif,
>  				  struct ath12k_link_sta *arsta)
> @@ -4933,31 +5063,37 @@ static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
>  	return bw;
>  }
>  
> -static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
> -				   struct ieee80211_vif *vif,
> -				   struct ieee80211_sta *sta,
> -				   enum ieee80211_sta_state old_state,
> -				   enum ieee80211_sta_state new_state)
> +static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
> +					    struct ath12k_link_vif *arvif,
> +					    struct ath12k_link_sta *arsta,
> +					    enum ieee80211_sta_state old_state,
> +					    enum ieee80211_sta_state new_state)
>  {
> -	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
> -	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
> -	struct ath12k *ar;
> -	struct ath12k_link_vif *arvif;
> -	struct ath12k_link_sta *arsta;
> -	struct ath12k_peer *peer;
> +	struct ath12k *ar = arvif->ar;
> +	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
> +	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
> +	struct ath12k_sta *ahsta = arsta->ahsta;
>  	int ret = 0;
>  
>  	lockdep_assert_wiphy(hw->wiphy);
>  
> -	arvif = &ahvif->deflink;
> -	arsta = &ahsta->deflink;
> +	/* IEEE80211_STA_NONE -> IEEE80211_STA_NOTEXIST: Remove the station
> +	 * from driver
> +	 */
> +	if ((old_state == IEEE80211_STA_NONE &&
> +	     new_state == IEEE80211_STA_NOTEXIST)) {
> +		/* ML sta needs separate handling */
> +		if (sta->mlo)
> +			return 0;
>  
> -	ar = ath12k_get_ar_by_vif(hw, vif);
> -	if (!ar) {
> -		WARN_ON_ONCE(1);
> -		return -EINVAL;
> +		ret = ath12k_mac_station_remove(ar, arvif, arsta);
> +		if (ret) {
> +			ath12k_warn(ar->ab, "Failed to remove station: %pM for VDEV: %d\n",
> +				    arsta->addr, arvif->vdev_id);
> +		}
>  	}
>  
> +	/* IEEE80211_STA_NOTEXIST -> IEEE80211_STA_NONE: Add new station to driver */
>  	if (old_state == IEEE80211_STA_NOTEXIST &&
>  	    new_state == IEEE80211_STA_NONE) {
>  		memset(arsta, 0, sizeof(*arsta));
> @@ -4975,56 +5111,16 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
>  		if (ret)
>  			ath12k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
>  				    sta->addr, arvif->vdev_id);
> -	} else if ((old_state == IEEE80211_STA_NONE &&
> -		    new_state == IEEE80211_STA_NOTEXIST)) {
> -		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);
>  
> -		if (ahvif->vdev_type == WMI_VDEV_TYPE_STA) {
> -			ath12k_bss_disassoc(ar, arvif);
> -			ret = ath12k_mac_vdev_stop(arvif);
> -			if (ret)
> -				ath12k_warn(ar->ab, "failed to stop vdev %i: %d\n",
> -					    arvif->vdev_id, ret);
> -		}
> -		ath12k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
> -
> -		ret = ath12k_peer_delete(ar, arvif->vdev_id, sta->addr);
> -		if (ret)
> -			ath12k_warn(ar->ab, "Failed to delete peer: %pM for VDEV: %d\n",
> -				    sta->addr, arvif->vdev_id);
> -		else
> -			ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "Removed peer: %pM for VDEV: %d\n",
> -				   sta->addr, arvif->vdev_id);
> -
> -		ath12k_mac_dec_num_stations(arvif, arsta);
> -		spin_lock_bh(&ar->ab->base_lock);
> -		peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
> -		if (peer && peer->sta == sta) {
> -			ath12k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
> -				    vif->addr, arvif->vdev_id);
> -			peer->sta = NULL;
> -			list_del(&peer->list);
> -			kfree(peer);
> -			ar->num_peers--;
> -		}
> -		spin_unlock_bh(&ar->ab->base_lock);
> -
> -		kfree(arsta->rx_stats);
> -		arsta->rx_stats = NULL;
> -
> -		if (arsta->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
> -			rcu_assign_pointer(ahsta->link[arsta->link_id], NULL);
> -			synchronize_rcu();
> -			ahsta->links_map &= ~(BIT(arsta->link_id));
> -			arsta->link_id = ATH12K_INVALID_LINK_ID;
> -			arsta->ahsta = NULL;
> -		}
> +	/* IEEE80211_STA_AUTH -> IEEE80211_STA_ASSOC: Send station assoc command for
> +	 * peer associated to AP/Mesh/ADHOC vif type.
> +	 */
>  	} else if (old_state == IEEE80211_STA_AUTH &&
>  		   new_state == IEEE80211_STA_ASSOC &&
>  		   (vif->type == NL80211_IFTYPE_AP ||
>  		    vif->type == NL80211_IFTYPE_MESH_POINT ||
>  		    vif->type == NL80211_IFTYPE_ADHOC)) {
> -		ret = ath12k_station_assoc(ar, arvif, arsta, false);
> +		ret = ath12k_mac_station_assoc(ar, arvif, arsta, false);
>  		if (ret)
>  			ath12k_warn(ar->ab, "Failed to associate station: %pM\n",
>  				    sta->addr);
> @@ -5035,40 +5131,32 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
>  		arsta->bw_prev = sta->deflink.bandwidth;
>  
>  		spin_unlock_bh(&ar->data_lock);
> +
> +	/* IEEE80211_STA_ASSOC -> IEEE80211_STA_AUTHORIZED: set peer status as
> +	 * authorized
> +	 */
>  	} else if (old_state == IEEE80211_STA_ASSOC &&
>  		   new_state == IEEE80211_STA_AUTHORIZED) {
> -		spin_lock_bh(&ar->ab->base_lock);
> +		ret = ath12k_mac_station_authorize(ar, arvif, arsta);
> +		if (ret)
> +			ath12k_warn(ar->ab, "Failed to authorize station: %pM\n",
> +				    sta->addr);
>  
> -		peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
> -		if (peer)
> -			peer->is_authorized = true;
> -
> -		spin_unlock_bh(&ar->ab->base_lock);
> -
> -		if (vif->type == NL80211_IFTYPE_STATION && arvif->is_up) {
> -			ret = ath12k_wmi_set_peer_param(ar, sta->addr,
> -							arvif->vdev_id,
> -							WMI_PEER_AUTHORIZE,
> -							1);
> -			if (ret)
> -				ath12k_warn(ar->ab, "Unable to authorize peer %pM vdev %d: %d\n",
> -					    sta->addr, arvif->vdev_id, ret);
> -		}
> +	/* IEEE80211_STA_AUTHORIZED -> IEEE80211_STA_ASSOC: station may be in removal,
> +	 * deauthorize it.
> +	 */
>  	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
>  		   new_state == IEEE80211_STA_ASSOC) {
> -		spin_lock_bh(&ar->ab->base_lock);
> -
> -		peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
> -		if (peer)
> -			peer->is_authorized = false;
> -
> -		spin_unlock_bh(&ar->ab->base_lock);
> +		ath12k_mac_station_unauthorize(ar, arvif, arsta);
> +	/* IEEE80211_STA_ASSOC -> IEEE80211_STA_AUTH: disassoc peer connected to
> +	 * AP/mesh/ADHOC vif type.
> +	 */
>  	} else if (old_state == IEEE80211_STA_ASSOC &&
>  		   new_state == IEEE80211_STA_AUTH &&
>  		   (vif->type == NL80211_IFTYPE_AP ||
>  		    vif->type == NL80211_IFTYPE_MESH_POINT ||
>  		    vif->type == NL80211_IFTYPE_ADHOC)) {
> -		ret = ath12k_station_disassoc(ar, arvif, arsta);
> +		ret = ath12k_mac_station_disassoc(ar, arvif, arsta);
>  		if (ret)
>  			ath12k_warn(ar->ab, "Failed to disassociate station: %pM\n",
>  				    sta->addr);
> @@ -5077,6 +5165,55 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
>  	return ret;
>  }
>  
> +static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
> +				   struct ieee80211_vif *vif,
> +				   struct ieee80211_sta *sta,
> +				   enum ieee80211_sta_state old_state,
> +				   enum ieee80211_sta_state new_state)
> +{
> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
> +	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
> +	struct ath12k_link_vif *arvif;
> +	struct ath12k_link_sta *arsta;
> +	int ret;
> +	u8 link_id = 0;
> +
> +	lockdep_assert_wiphy(hw->wiphy);
> +
> +	if (ieee80211_vif_is_mld(vif) && sta->valid_links) {
> +		WARN_ON(!sta->mlo && hweight16(sta->valid_links) != 1);
> +		link_id = ffs(sta->valid_links) - 1;
> +	}
> +
> +	/* Handle for non-ML station */
> +	if (!sta->mlo) {
> +		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> +		arsta = &ahsta->deflink;
> +		arsta->ahsta = ahsta;
> +
> +		if (WARN_ON(!arvif || !arsta)) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		/* vdev might be in deleted */
> +		if (WARN_ON(!arvif->ar)) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		ret = ath12k_mac_handle_link_sta_state(hw, arvif, arsta,
> +						       old_state, new_state);
> +		if (ret)
> +			goto exit;
> +	}
> +
> +	ret = 0;
> +
> +exit:
> +	return ret;
> +}
> +
>  static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
>  				       struct ieee80211_vif *vif,
>  				       struct ieee80211_sta *sta)


