Return-Path: <linux-wireless+bounces-15737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283569DA10A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 04:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B258416648B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 03:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98781946B;
	Wed, 27 Nov 2024 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hb54uFlq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736B139D
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676793; cv=none; b=uGYVFRHeNqiIBAGAtzeSJ92HmuThztcveXaP6L9DrOyV3NW/Cas4gzsZYn4q9Y94mOAIyEz7f/PLOrS+LaPDdPr7QZdEv5dUMfjj3IAXQ+CwEUn3Z6NACJx9QdHM4D2Z13wL+5Y2ubj+3S7VQ+VxPJd4rsemcizWflZdRoUMXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676793; c=relaxed/simple;
	bh=b66Q0u3pUl1RRNhoTN6/KwLoKw2rdBqj/qTmWf8EOQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NMU7W5/ZQKilmza93f2V1QgUSQqMqf0XVtRFyZjo4Ibmy7nZR0sssNOahZoGO78mgIyzJWl1Fum6cRFLSzUqhrsxfV7URPFMfp304fn8nPYDeMykIhJrJIfNhaN3W62ai88AWQi1uCdKAR07pqBIbvscPtu3Cz4i6psE8RxFyaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hb54uFlq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQKLXZj007146;
	Wed, 27 Nov 2024 03:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PW3uOpBxlHu8u4PXS+/pb0FxPfm2tLGDbnnWag593E4=; b=Hb54uFlqP9YRnycQ
	Lnf/2+HjovwVqPi2TZ0EnCtF1NFWugw4AATf1CDhHvALBiJHQzt8tK/7JgG9O1IA
	PZAeOIwW6IlYwaMqpi9BXpa3mPtvymWHANKFs/A/EX+tAjyzRVgkPwc/oM3JU5Mr
	vMLCs6AfZQJXbbpqnYyxjzPcp1E9iI3DOhhA5CERzJSU32IKGD4KCW1ithlLK03g
	bPfpfwzoGogONK8eUeo7EWE5YIWF/pjox6qr9D6gI9ZrDe3xIgkV6Mvdr4XipMMj
	bP6TSUUzogqxPS2FVpY2wqWl/sTnPvcPHWgim3eTJI+yh6Ho4AxW5FylPtq5IVic
	dIX4/A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434sw9d7bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 03:06:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AR36QDG028057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 03:06:26 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 26 Nov
 2024 19:06:25 -0800
Message-ID: <abf0db61-326d-4b06-8ced-66d5f96d8dc0@quicinc.com>
Date: Wed, 27 Nov 2024 11:06:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] wifi: ath12k: do not return invalid link id for
 scan link
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241126171139.2350704-1-kvalo@kernel.org>
 <20241126171139.2350704-7-kvalo@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20241126171139.2350704-7-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PPIwrl_v5nYKaT4z458MXHddkAnEn8Sv
X-Proofpoint-ORIG-GUID: PPIwrl_v5nYKaT4z458MXHddkAnEn8Sv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270024



On 11/27/2024 1:11 AM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> When a scan request is received, driver selects a link id for which the arvif
> can be mapped. Same link is also used for getting the link conf address.
> Currently, we return 0 as link id for a non ML vif, which is correct since that
> is the default link id. Also when any of the link vif is active and the scan
> request is for a channel in the active link we return its link id. But, when we
> don't hit both of the above cases (i.e not a ML vif or no active link vif for
> the channel is present) we currently return 0 as the link id.
> 
> Bu the problemis that this might not work out always, eg., when only one link
> (eg. linkid = 1) is added to vif, then we won't find any link conf for link id
> 0 in the vif resulting in scan failure. During AP bringup, such scan failure
> causes bringup issues.  Hence avoid sending link id 0 as default. Rather use a
> default link for scan and default link address for the same. This scan vdev
> will either be deleted if another scan is requested on same vif or when AP is
> broughtup on same link or during interface cleanup.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  3 +-
>  drivers/net/wireless/ath/ath12k/mac.c  | 65 +++++++++++++++++++-------
>  drivers/net/wireless/ath/ath12k/mac.h  |  6 +++
>  3 files changed, 56 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index e246e3d3c162..f4a710d49584 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -322,10 +322,11 @@ struct ath12k_vif {
>  	bool ps;
>  
>  	struct ath12k_link_vif deflink;
> -	struct ath12k_link_vif __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
> +	struct ath12k_link_vif __rcu *link[ATH12K_NUM_MAX_LINKS];
>  	struct ath12k_vif_cache *cache[IEEE80211_MLD_MAX_NUM_LINKS];
>  	/* indicates bitmap of link vif created in FW */
>  	u16 links_map;
> +	u8 last_scan_link;
>  
>  	/* Must be last - ends in a flexible-array member.
>  	 *
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 8287c2e6b765..85cfbe1e4b9f 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -3792,6 +3792,9 @@ static void ath12k_ahvif_put_link_key_cache(struct ath12k_vif_cache *cache)
>  
>  static void ath12k_ahvif_put_link_cache(struct ath12k_vif *ahvif, u8 link_id)
>  {
> +	if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
> +		return;
> +
>  	ath12k_ahvif_put_link_key_cache(ahvif->cache[link_id]);
>  	kfree(ahvif->cache[link_id]);
>  	ahvif->cache[link_id] = NULL;
> @@ -3852,9 +3855,9 @@ static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
>  		arvif = &ahvif->deflink;
>  	} else {
>  		/* If this is the first link arvif being created for an ML VIF
> -		 * use the preallocated deflink memory
> +		 * use the preallocated deflink memory except for scan arvifs
>  		 */
> -		if (!ahvif->links_map) {
> +		if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
>  			arvif = &ahvif->deflink;
>  		} else {
>  			arvif = (struct ath12k_link_vif *)
> @@ -4154,10 +4157,10 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
>  			return link_id;
>  	}
>  
> -	/* input ar is not assigned to any of the links, use link id
> -	 * 0 for scan vdev creation.
> +	/* input ar is not assigned to any of the links of ML VIF, use scan
> +	 * link (15) for scan vdev creation.
>  	 */
> -	return 0;
> +	return ATH12K_DEFAULT_SCAN_LINK;
>  }
>  
>  static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
> @@ -4188,7 +4191,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  
>  	/* check if any of the links of ML VIF is already started on
>  	 * radio(ar) correpsondig to given scan frequency and use it,
> -	 * if not use deflink(link 0) for scan purpose.
> +	 * if not use scan link (link 15) for scan purpose.
>  	 */
>  	link_id = ath12k_mac_find_link_id_by_ar(ahvif, ar);
>  	arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
> @@ -4298,6 +4301,13 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  		spin_unlock_bh(&ar->data_lock);
>  	}
>  
> +	/* As per cfg80211/mac80211 scan design, it allows only one
> +	 * scan at a time. Hence last_scan link id is used for
> +	 * tracking the link id on which the scan is been done on
> +	 * this vif.
> +	 */
> +	ahvif->last_scan_link = arvif->link_id;
> +
>  	/* Add a margin to account for event/command processing */
>  	ieee80211_queue_delayed_work(ath12k_ar_to_hw(ar), &ar->scan.timeout,
>  				     msecs_to_jiffies(arg->max_scan_time +
> @@ -4317,14 +4327,14 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
>  					 struct ieee80211_vif *vif)
>  {
>  	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
> +	u16 link_id = ahvif->last_scan_link;
>  	struct ath12k_link_vif *arvif;
>  	struct ath12k *ar;
>  
>  	lockdep_assert_wiphy(hw->wiphy);
>  
> -	arvif = &ahvif->deflink;
> -
> -	if (!arvif->is_created)
> +	arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> +	if (!arvif || arvif->is_created)
s/arvif->is_created/!arvif->is_created/ ?

>  		return;
>  
>  	ar = arvif->ar;
> @@ -7688,10 +7698,19 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>  	u16 nss;
>  	int i;
>  	int ret, vdev_id;
> +	u8 link_id;
>  
>  	lockdep_assert_wiphy(hw->wiphy);
>  
> -	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[arvif->link_id]);
> +	/* If no link is active and scan vdev is requested
> +	 * use a default link conf for scan address purpose.
> +	 */
> +	if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
> +		link_id = ffs(vif->valid_links) - 1;
> +	else
> +		link_id = arvif->link_id;
> +
> +	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
>  	if (!link_conf) {
>  		ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",
>  			    vif->addr, arvif->link_id);
> @@ -7971,7 +7990,9 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
>  						    struct ath12k_link_vif *arvif,
>  						    struct ieee80211_chanctx_conf *ctx)
>  {
> -	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
> +	struct ath12k_vif *ahvif = arvif->ahvif;
> +	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
> +	struct ath12k_link_vif *scan_arvif;
>  	struct ath12k_hw *ah = hw->priv;
>  	struct ath12k *ar;
>  	struct ath12k_base *ab;
> @@ -7990,6 +8011,19 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
>  	if (!ar)
>  		return NULL;
>  
> +	/* cleanup the scan vdev if we are done scan on that ar
> +	 * and now we want to create for actual usage.
> +	 */
> +	if (vif->valid_links) {
better to use ieee80211_vif_is_mld()?

> +		scan_arvif = wiphy_dereference(hw->wiphy,
> +					       ahvif->link[ATH12K_DEFAULT_SCAN_LINK]);
> +		if (scan_arvif && scan_arvif->ar == ar) {
> +			ar->scan.vdev_id = -1;
> +			ath12k_mac_remove_link_interface(hw, scan_arvif);
> +			ath12k_mac_unassign_link_vif(scan_arvif);
> +		}
> +	}
> +
>  	if (arvif->ar) {
>  		/* This is not expected really */
>  		if (WARN_ON(!arvif->is_created)) {
> @@ -8194,7 +8228,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
>  
>  	lockdep_assert_wiphy(hw->wiphy);
>  
> -	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
> +	for (link_id = 0; link_id < ATH12K_NUM_MAX_LINKS; link_id++) {
>  		/* if we cached some config but never received assign chanctx,
>  		 * free the allocated cache.
>  		 */
> @@ -9042,11 +9076,8 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
>  		return -ENOMEM;
>  	}
>  
> -	if (!arvif->is_started) {
> -		ar = ath12k_mac_assign_vif_to_vdev(hw, arvif, ctx);
> -		if (!ar)
> -			return -EINVAL;
> -	} else {
> +	ar = ath12k_mac_assign_vif_to_vdev(hw, arvif, ctx);
> +	if (!ar) {
>  		ath12k_warn(arvif->ar->ab, "failed to assign chanctx for vif %pM link id %u link vif is already started",
>  			    vif->addr, link_id);
>  		return -EINVAL;
> diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
> index c13630ee479a..abdc9a6c0740 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.h
> +++ b/drivers/net/wireless/ath/ath12k/mac.h
> @@ -44,6 +44,12 @@ struct ath12k_generic_iter {
>  #define ATH12K_DEFAULT_LINK_ID	0
>  #define ATH12K_INVALID_LINK_ID	255
>  
> +/* Default link after the IEEE802.11 defined Max link id limit
> + * for driver usage purpose.
> + */
> +#define ATH12K_DEFAULT_SCAN_LINK	IEEE80211_MLD_MAX_NUM_LINKS
> +#define ATH12K_NUM_MAX_LINKS		(IEEE80211_MLD_MAX_NUM_LINKS + 1)
> +
>  enum ath12k_supported_bw {
>  	ATH12K_BW_20    = 0,
>  	ATH12K_BW_40    = 1,


