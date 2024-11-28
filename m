Return-Path: <linux-wireless+bounces-15784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD279DB7B1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 13:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7224A162EE6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 12:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1E19CC11;
	Thu, 28 Nov 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4bgbDDE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144B19C558
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797148; cv=none; b=uRw4gbeC+GhoRO+vbbyoD9lw4rBukmCVOEZbtV7AeW3NH9EJjh4wxqe+CRIUpBchiN8AWcafAlnmcJDWgvVRLx4eXRxDc0ZH0m8DNTvu6DsQ8OcmbEFHYw/83t+f+yk1xMrRSl7Z1HurQWdvD74PZl4z+M/ZsYQfSAuHN1iU0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797148; c=relaxed/simple;
	bh=z55rZ5wrhdyhw6V1NlACku/0MHLUshsG+jTuIobXNV4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oo2iAz9Mcu62OAym5GhINNcNberYEFsKZKGYzXI322iKgPBtlxJC+GIRv+gcH7dsknG/AnIMmbPaQ6rLOf8Tg8IOrRbxdWQKAKex/j01S/L1symiiHvCmr7d2vk6P+YXwujxOlB74qUFPxuZdCLEOEFVnwycVvv4y2t1QT+PfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4bgbDDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ED7C4CECE;
	Thu, 28 Nov 2024 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732797146;
	bh=z55rZ5wrhdyhw6V1NlACku/0MHLUshsG+jTuIobXNV4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=I4bgbDDEAmVhjUL35qcUKHJqdEd4qty+/dssZbML9bXvaugv9rWswMtn/WqbyCvcr
	 1waNZfrQR8mUVMbtBkNOoqpFFBzfX7wd429iBYR+v1KhvgprPiTLg7y8ou0cLuDA7/
	 cW3YrAEICxGIlhvnj+bP5l01uA1vaj2M/0KoOHKeRwUfhORUelqjLiE/2bq1wYGC/f
	 daLAJS0tL0lBbVVrizsF1JPuv5z6DlfkOcSZSKLmlOchxugHI5NKdg96XJENDBAeZn
	 7zvQnUsZ4sWk0ONk9w2YTLh2nbHlQrrXvLQi6Qqi6f228gvwVnPOhiw244mMaQ3i/a
	 a9rTHzbh7C37w==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 02/10] wifi: ath12k: ath12k_mac_op_tx(): MLO support
References: <20241126171139.2350704-1-kvalo@kernel.org>
	<20241126171139.2350704-3-kvalo@kernel.org>
	<28bdb726-a7cf-40e7-8bc4-f7602bba1e93@quicinc.com>
Date: Thu, 28 Nov 2024 14:32:23 +0200
In-Reply-To: <28bdb726-a7cf-40e7-8bc4-f7602bba1e93@quicinc.com> (Baochen
	Qiang's message of "Wed, 27 Nov 2024 10:49:13 +0800")
Message-ID: <87ttbrv8rs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 11/27/2024 1:11 AM, Kalle Valo wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>> 
>> @@ -6848,6 +6848,7 @@ static void ath12k_mgmt_over_wmi_tx_purge(struct ath12k *ar)
>>  static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work *work)
>>  {
>>  	struct ath12k *ar = container_of(work, struct ath12k, wmi_mgmt_tx_work);
>> +	struct ath12k_hw *ah = ar->ah;
>>  	struct ath12k_skb_cb *skb_cb;
>>  	struct ath12k_vif *ahvif;
>>  	struct ath12k_link_vif *arvif;
>> @@ -6865,7 +6866,15 @@ static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work
>>  		}
>>  
>>  		ahvif = ath12k_vif_to_ahvif(skb_cb->vif);
>> -		arvif = &ahvif->deflink;
>> +		if (!(ahvif->links_map & BIT(skb_cb->link_id))) {
>> +			ath12k_warn(ar->ab,
>> +				    "invalid linkid %u in mgmt over wmi tx with linkmap 0x%X\n",
>
> s/0x%X/0x%x/ ?

Fixed.

>
>> +				    skb_cb->link_id, ahvif->links_map);
>> +			ath12k_mgmt_over_wmi_tx_drop(ar, skb);
>> +			continue;
>> +		}
>> +
>> +		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[skb_cb->link_id]);
>>  		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id)) {
>>  			ret = ath12k_mac_mgmt_tx_wmi(ar, arvif, skb);
>>  			if (ret) {
>> @@ -6875,9 +6884,10 @@ static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work
>>  			}
>>  		} else {
>>  			ath12k_warn(ar->ab,
>> -				    "dropping mgmt frame for vdev %d, is_started %d\n",
>> +				    "dropping mgmt frame for vdev %d link_id %u, is_started %d\n",
>>  				    arvif->vdev_id,
>> -				    arvif->is_started);
>> +				    arvif->is_started,
>> +				    skb_cb->link_id);
>
> swap 'arvif->is_started' and 'skb_cb->link_id'.

Good catch! Fixed as well.

>> +/* Note: called under rcu_read_lock() */
>> +static u8 ath12k_mac_get_tx_link(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
>> +				 u8 link, struct sk_buff *skb, u32 info_flags)
>> +{
>> +	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>> +	struct ieee80211_link_sta *link_sta;
>> +	struct ieee80211_bss_conf *bss_conf;
>> +	struct ath12k_sta *ahsta;
>
> better to assert RCU read lock here?

You mean something like WARN_ON(!rcu_read_lock_held())? I'm not really a
fan of that, I think it's better that we discuss this also once we
document locking design properly.

>> +/* Note: called under rcu_read_lock() */
>>  static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>>  			     struct ieee80211_tx_control *control,
>>  			     struct sk_buff *skb)
>> @@ -6945,13 +7054,16 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>>  	struct ieee80211_vif *vif = info->control.vif;
>>  	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>>  	struct ath12k_link_vif *arvif = &ahvif->deflink;
>> -	struct ath12k *ar = arvif->ar;
>>  	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>>  	struct ieee80211_key_conf *key = info->control.hw_key;
>> +	struct ieee80211_sta *sta = control->sta;
>>  	u32 info_flags = info->flags;
>> +	struct ath12k *ar;
>>  	bool is_prb_rsp;
>> +	u8 link_id;
>>  	int ret;
>>  
> better to assert RCU read lock here?

Same comment here as above.

>
>> +	link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
>>  	memset(skb_cb, 0, sizeof(*skb_cb));
>>  	skb_cb->vif = vif;
>>  
>> @@ -6960,6 +7072,27 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>>  		skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
>>  	}
>>  
>> +	/* handle only for MLO case, use deflink for non MLO case */
>> +	if (vif->valid_links) {
>
> better to use ieee80211_vif_is_mld() helper?

Indeed, fixed.

I did all the changes directly in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=57ee27f3b3aa13c63978f03ce544c2f4210a9cd7

BTW when you reply please include an empty line between the quote and
your reply, this improves readability.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

