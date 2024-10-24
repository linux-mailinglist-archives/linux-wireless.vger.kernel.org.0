Return-Path: <linux-wireless+bounces-14479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5799AEF38
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 20:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6C01F20F03
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0F21FF02F;
	Thu, 24 Oct 2024 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy6bYx7r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B451FBF50
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793419; cv=none; b=BKN784nWFlr7GK95P6JV9ESyAkWyS74b9/Ai6YfQVKSkPDSH2mhr0Uy/aiTnENwaRsl9pJRo7+EJKHqcZ78HGR0rbYT4ZCYiyLhJNZULBFpdxtfkad/sTIdMMQqjKlNZGOFPGyx6ovdrYQM2yWuAY5MOrfmpKaYbv4usZT8R8bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793419; c=relaxed/simple;
	bh=D1oGPE8iY8SLhbcXjgJNlgsYs6nH9gYfciNl9/OSycQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hMI6703RkoWMP0SpsZcLRLe1xf+3mxk5fgQomRDssXeLmk+1yZmbU/H973C+WdG1F6QHLt/rIe1WcEb3wm1lussr4PGabVgmWVlvo25Imdds0SJtldlbcTQKahIgrHrYJYxzxh7F2/CaEVkw8JbXbhnAp1qMmAP9AQx/CaV+YiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy6bYx7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343B9C4CEC7;
	Thu, 24 Oct 2024 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729793419;
	bh=D1oGPE8iY8SLhbcXjgJNlgsYs6nH9gYfciNl9/OSycQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qy6bYx7rToXkBdQ/acrG1YZmsbnel3MZcTAqXMHBroyZxZsPEi/RSUILGUbu37HoL
	 azTQNG3GKkt8Y+RfQMjr/XbXjZz7u0WVLvcMUTAuc63ERCD/zVsbmdvUI8kQYpY1Lh
	 gdziTx7xcx4tJPLe20wGwZzNE/GD+XCUJA7rsBbonzkLoPMCJHIJ6rJCrqlZPQVw3J
	 zr7pI8/n5MUzZwzJqYn5dIKW479kRyFlP8AoBXEGB8m3A3T6VwdlKJctsNbzNywB/2
	 CeqBY/vUluDJ3nffCzHw/gm2cd/nx3SupIFxhpCiNiBUNOMUCewCnwhhzYeEr0/nX4
	 YPqzq3mgAKDeQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/8] wifi: ath12k: MLO vdev bringup changes
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-3-kvalo@kernel.org>
	<b79d33c6-a7cc-4a23-9b85-b2481c508d07@quicinc.com>
Date: Thu, 24 Oct 2024 21:10:16 +0300
In-Reply-To: <b79d33c6-a7cc-4a23-9b85-b2481c508d07@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 08:19:02 -0700")
Message-ID: <871q05mkxj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/23/2024 6:29 AM, Kalle Valo wrote:
>
>> From: Sriram R <quic_srirrama@quicinc.com>
>> 
>> Add changes to add the link vdevs dynamically whenever a channel is assigned
>> from mac80211 for a link vdev. During vdev create, update ML address of the
>> vdev to firmware using the new WMI parameter (WMI_TAG_MLO_VDEV_CREATE_PARAMS).
>> 
>> During vdev start, notify the firmware that this link vdev is newly added and
>> also indicate all its known partners so that the firmware can take necessary
>> actions to internally update the partners on the new link being added.
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/mac.c | 90 ++++++++++++++++++++++++++-
>>  drivers/net/wireless/ath/ath12k/wmi.c | 85 ++++++++++++++++++++++++-
>>  drivers/net/wireless/ath/ath12k/wmi.h | 74 ++++++++++++++++++++++
>>  3 files changed, 244 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index f45f32f3b5f6..d4aa4540c8e6 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -648,6 +648,18 @@ struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id)
>>  	return NULL;
>>  }
>>  
>> +static bool ath12k_mac_is_ml_arvif(struct ath12k_link_vif *arvif)
>> +{
>> +	struct ath12k_vif *ahvif = arvif->ahvif;
>> +
>> +	lockdep_assert_wiphy(ahvif->ah->hw->wiphy);
>
> should we have helper functions ath12k_<foo>_to_wiphy() to abstract out the
> underlying linkages?

While working on these patches I started to like the current form, extra
abstractions are always an extra layer to check when working on the
code. Maybe we should revisit this after MLO works? It's easy to add the
new helper in a separate patch.

>> +static void
>> +ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
>> +			     struct wmi_ml_arg *ml_arg)
>> +{
>> +	struct ath12k_vif *ahvif = arvif->ahvif;
>> +	struct wmi_ml_partner_info *partner_info;
>> +	struct ieee80211_bss_conf *link_conf;
>> +	struct ath12k_link_vif *arvif_p;
>> +	unsigned long links;
>> +	u8 link_id;
>> +
>> +	lockdep_assert_wiphy(ahvif->ah->hw->wiphy);
>> +
>> +	if (!ath12k_mac_is_ml_arvif(arvif))
>> +		return;
>> +
>> +	if (hweight16(ahvif->vif->valid_links) > ATH12K_WMI_MLO_MAX_LINKS)
>> +		return;
>> +
>> +	rcu_read_lock();
>
> what is this protecting?

Access to ahvif->link[] and vif->link_conf[]. Protection for
ahvif->links_map is still not clear for me, I need to analyse that more.

> do all of the statements between here and the for loop really need RCU protection?

No, they do not need it. And actually we can could change it to
wiphy_dereference() so we don't need to take rcu_read_lock() at all.
I'll do that in v2.

>> +/* 2 word representation of MAC addr */
>> +struct wmi_mac_addr {
>> +	union {
>> +		u8 addr[6];
>> +		struct {
>> +			u32 word0;
>> +			u32 word1;
>> +		} __packed;
>> +	} __packed;
>> +} __packed;
>
> we already have:
> /* 2 word representation of MAC addr */
> struct ath12k_wmi_mac_addr_params {
> 	u8 addr[ETH_ALEN];
> 	u8 padding[2];
> } __packed;
>
> why aren't we consistently using that?

Ouch, I'll switch to using that. Thanks for the review!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

