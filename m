Return-Path: <linux-wireless+bounces-15535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6659D4296
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 20:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B4E2845D7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 19:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E1158A13;
	Wed, 20 Nov 2024 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTh19gyb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE313D62B
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131174; cv=none; b=MaSLPBE1WFBq47RWId2C3J0TuEHncGr6Q+X1DjG+/3Ymv4KoQIRRaL3N/OSRJTW3Eu7Kac5LzYVOb1FyNt6kcJPlOP/XlGHjTB5Zxpz+XUmu6lPgwm0/m8+0t9lxN4nt2YQ7lDpV59m/xewaLcWtd0kXzU876RFVxYDmaYrP0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131174; c=relaxed/simple;
	bh=8RViDHVQohi3sNBuWakf9/jPFYOFlqXp6zZeaqIbCbA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=S50I+LAhIbWFQVpkgfDMGXaeQaxZfzLgIGNofm1NEKpKkOBdd6ejwjBVLIPTWZBr2GKeP+By9QHeTCthnQAu0/c7kZJIWHWoH2vTSNQSwBgletEixJ77Tk8dGqiuKVDNDMUsGXv4odGs4JIgv8P8a6WT3ld5QYcIOof3nHP9gDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTh19gyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02CAC4CECD;
	Wed, 20 Nov 2024 19:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732131173;
	bh=8RViDHVQohi3sNBuWakf9/jPFYOFlqXp6zZeaqIbCbA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=UTh19gybPp/R/wnVizKE5kSr51Oo1t2T1dIq75NIovzR/3yV9jq5Jm5w91xTOl8B9
	 mA07DR2WFvAfSfZESxRXlY1NMFzPiPHasjgrLp3Ygr3CzB9lCs0T7jc6yLp/zOg90U
	 0vWiblIpIk/AQt0G8s1ziYOhWGqmL9H3oqy4Vgwr3/mB1NOz8Xqf2vIqzFwXGEKx8I
	 IulMhhLoNt5k57B27IEVBRIa0o8Y7S/JGQILov62Te83HCV9FHXSKBrIShkv1XlaJV
	 hMrgdfTGZdhmW5jP6SSvQGC+TfBoFEETsfU8xMgxpY1i0WE9p26iuO/kxB4eeAVuL1
	 9Lr8hwhggJ3ZQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/8] wifi: ath12k: Add MLO station state change handling
References: <20241106142617.660901-1-kvalo@kernel.org>
	<20241106142617.660901-2-kvalo@kernel.org>
	<2e706d58-5d83-4867-9963-c62441cdd4da@quicinc.com>
	<87y11o2x9h.fsf@kernel.org>
	<97f3f465-6ebd-4ca1-b672-4c8c7f42220d@quicinc.com>
Date: Wed, 20 Nov 2024 21:32:50 +0200
In-Reply-To: <97f3f465-6ebd-4ca1-b672-4c8c7f42220d@quicinc.com> (Baochen
	Qiang's message of "Wed, 13 Nov 2024 10:55:22 +0800")
Message-ID: <87bjy9zonx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

>>>> +static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
>>>> +					      struct ath12k_sta *ahsta,
>>>> +					      u8 link_id)
>>>> +{
>>>> +	struct ath12k_link_sta *arsta;
>>>> +
>>>> +	lockdep_assert_wiphy(ah->hw->wiphy);
>>>> +
>>>> +	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
>>>> +		return;
>>>> +
>>>> +	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
>>>> +
>>>> +	if (WARN_ON(!arsta))
>>>> +		return;
>>>> +
>>>> +	ath12k_mac_unassign_link_sta(ah, ahsta, link_id);
>>>> +
>>>> +	arsta->link_id = ATH12K_INVALID_LINK_ID;
>>>> +	arsta->ahsta = NULL;
>>>> +	arsta->arvif = NULL;
>>>
>>> if arsta is not deflink and would be freed, can we avoid these
>>> cleanup?
>> 
>> I think that's something we can cleanup later if needed. Sure, it's
>> extra assignments but it's not really doing any harm.
> exactly, but ideally we should avoid unnecessary effort if possible.
>
>> 
>>>> +	if (arsta != &ahsta->deflink)
>>>> +		kfree(arsta);
>>>
>>> I know the actual free happens here, but why split them?
>> 
>> You mean why have a separate function ath12k_mac_unassign_link_sta() and
>> instead just have all code the in
>> ath12k_mac_free_unassign_link_sta()?
>
> yes. such that we can have synchronize_rcu() and kfree() located together.

Ok, I think I now get what you mean. Does this look better:

static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
					      struct ath12k_sta *ahsta,
					      u8 link_id)
{
	struct ath12k_link_sta *arsta;

	lockdep_assert_wiphy(ah->hw->wiphy);

	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
		return;

	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
	if (WARN_ON(!arsta))
		return;

	ahsta->links_map &= ~BIT(link_id);
	rcu_assign_pointer(ahsta->link[link_id], NULL);

	if (arsta == &ahsta->deflink) {
		arsta->link_id = ATH12K_INVALID_LINK_ID;
		arsta->ahsta = NULL;
		arsta->arvif = NULL;
		return;
	}

	synchronize_rcu();
	kfree(arsta);
}

BTW your lines are really long, please check your settings:

https://patchwork.kernel.org/project/linux-wireless/patch/20241106142617.660901-2-kvalo@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

