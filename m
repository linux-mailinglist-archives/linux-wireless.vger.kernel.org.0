Return-Path: <linux-wireless+bounces-14746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FB9B6C17
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 19:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75991F21DDA
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 18:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191B1CB518;
	Wed, 30 Oct 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoXxepA6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98521C9EBB
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312904; cv=none; b=n2T7uYrqfO9/BOM8J3iA3zT4zleveJ+VVYnSoytcrZ73CwaEtYytTC/zxglh+V2JvHpocsKYq5J10ybx3BrOJA5a2wVR+/wuv6DZ28RmDF/oMUK5QMbJR/plVpcYFkoi+bDVtInHGD8CnIRF/zdDKp7KqHw0F1/F99UMqgdvih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312904; c=relaxed/simple;
	bh=YrW+oeMKVVlAQ7H063JZ50DV/sT7OK0FZ5VyEc7WfHQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kh/rpiDh+U07lkb7BIFWGJGIWis/Fs98c7di0rOqyBtXmdzX/9yPg5s7bjSxTme8MWkT714TADllOokoI/H072EoWpTlwOUiCHoy8WwkWg7FYheXIBknelzOruyKRvjBtkDA2+FufimTkAfHHTlyvI5DPVaXoVOqDLWzsmKNSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoXxepA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9C4C4CECE;
	Wed, 30 Oct 2024 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730312904;
	bh=YrW+oeMKVVlAQ7H063JZ50DV/sT7OK0FZ5VyEc7WfHQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=IoXxepA6Pu039nVCutwafRFxHzi4Dn2piqAfTy1XzaG/xGERCscnq9/krQ1iPMbNl
	 Q6V6xTR/PRUcgZiU8cPq9tgGbCpfnx0kXZ73+IiVgBGj+OnAAvF+9mBgu8imDDGC0B
	 Z1k5o4U5T8yyCPwt20LHBJHb7Lp56TbAqXBIc1QPLhQphTm152iXr4yVubrVWGuO+E
	 WTSjflcJkxK49mg5Sv/F6MH75NsrGe0iKG7prb4dXV1ct2gp6O/GoQCkHmasOCRNi3
	 +9KreLOfC+p/ZSiFo3GJvsOMAwM9K5s/aEqInyFOiPMev26GRUE6E3RI2Y8YyIhyTJ
	 h1XiNML83VbeQ==
From: Kalle Valo <kvalo@kernel.org>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/8] wifi: ath12k: Refactor sta state machine
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-4-kvalo@kernel.org>
	<a4b92b80-ec57-4db3-acd7-9c6c7644d7c9@quicinc.com>
	<875xpahqc5.fsf@kernel.org>
	<cd19db4a-953d-4230-85b1-695140bb185c@quicinc.com>
Date: Wed, 30 Oct 2024 20:28:21 +0200
In-Reply-To: <cd19db4a-953d-4230-85b1-695140bb185c@quicinc.com> (Aditya Kumar
	Singh's message of "Wed, 30 Oct 2024 09:35:37 +0530")
Message-ID: <87frodfnsq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> On 10/29/24 21:08, Kalle Valo wrote:
>> + aditya
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> 
>>>> +static int ath12k_mac_station_unauthorize(struct ath12k *ar,
>>>> +					  struct ath12k_link_vif *arvif,
>>>> +					  struct ath12k_link_sta *arsta)
>>>> +{
>>>> +	struct ath12k_peer *peer;
>>>> +	int ret;
>>>> +
>>>> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>>>> +
>>>> +	spin_lock_bh(&ar->ab->base_lock);
>>>> +
>>>> +	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
>>>> +	if (peer)
>>>> +		peer->is_authorized = false;
>>>> +
>>>> +	spin_unlock_bh(&ar->ab->base_lock);
>>>> +
>>>> +	/* Driver should clear the peer keys during mac80211's ref ptr
>>>> +	 * gets cleared in __sta_info_destroy_part2 (trans from
>>>> +	 * IEEE80211_STA_AUTHORIZED to IEEE80211_STA_ASSOC)
>>>
>>> I'm unable to understand this comment
>> Indeed, that's weird. Aditya, do you have any idea what the comment
>> is
>> trying to say?
>> 
>
> At present, ath12k clear the keys in ath12k_station_disassoc() which
> gets executed in state change from IEEE80211_STA_ASSOC to
> IEEE80211_STA_AUTH.
>
> However, in mac80211, once the station moves from
> IEEE80211_STA_AUTHORIZED to IEEE80211_STA_ASSOC itself, the keys are
> deleted. Please see - __sta_info_destroy_part2() ->
> ieee80211_free_sta_keys().
>
> Now, ath12k peer object (struct ath12k_peer) holds the key reference
> from mac80211 (see ath12k_peer::keys[]). Hence, once mac80211 deletes
> the key, driver should not keep a reference to it or else it could
> lead to issues.
>
> Therefore, it is important that the driver should clear the peer keys
> during transition from IEEE80211_STA_AUTHORIZED to IEEE80211_STA_ASSOC
> it self since we know that once we return from here, mac80211 is going
> to remove the keys.
>
> ath12k_mac_station_unauthorize() gets called when station moves from
> state IEEE80211_STA_AUTHORIZED to IEEE80211_STA_ASSOC hence call to
> ath12k_clear_peer_keys() is moved from ath12k_station_disassoc() to
> ath12k_mac_station_unauthorize().
>
> Is this clear now?

Super clear :) Thanks!

> May be the comment in the code could be re-written as below?
>
> /* Driver must clear the keys during the state change from
>  * IEEE80211_STA_AUTHORIZED to IEEE80211_STA_ASSOC, since after
>  * returning from here, mac80211 is going to delete the keys
>  * in __sta_info_destroy_part2(). This will ensure that the driver does
>  * not retain stale key references after mac80211 deletes the keys.
>  */

Looks good to me, I'll add that if it's ok for Jeff as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

