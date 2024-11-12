Return-Path: <linux-wireless+bounces-15213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CC99C5E8C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 18:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C008280FBF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3FC20B7F1;
	Tue, 12 Nov 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY90mmDl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943761FF7A2
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431453; cv=none; b=SwTUnS0PcTgzOrYSxIspBfBe6ClmMj4xYjer0/JAzEQ25UOVjmZJJQ042hdCqj+wEh8NXlTESof9dWmMxZtXoG1tBrd3KaeN7lme4wblShqTaErW1T5rYSLwuu46h3TTSFbEo4NsOC6z1pm9w1vwiTlpi2kxfeFeQe6A4dARMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431453; c=relaxed/simple;
	bh=9bdSwINWYk5CZRoQUnoiwG9Ag0Qrlyljvolp9cXLSgM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Dgsa5/LkVuyvxlgm6QifqNfBc1kZDgYzuty4niDa3VL79+gI+dIN3XurccLb4Nv1RUTatB3pdfVBQ2BaxByXw6ahjce1oMJF+Yq/NOjL9Br9I3E4L4x5ru6QcS+uCq9Q8isbhmEw9KNHc5Y6dW5SvReyrSy1uVaHQuZAQQlmdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY90mmDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0BFC4CECD;
	Tue, 12 Nov 2024 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731431453;
	bh=9bdSwINWYk5CZRoQUnoiwG9Ag0Qrlyljvolp9cXLSgM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gY90mmDlrqH/xJlfTU0pi9st/Pg4oMo5XQt5Zd/FXQEFNsW/PyuviEqn8sqgln9tz
	 OvXDoZI3Yj5HZXnn4Hnsu0d8rPoGwfM5plszqeGoZoB9HZ2A7KoRfazDCAhJPBp2eE
	 v7VKGRIIyFA4GJo42XTPvNcbl3jJo+j1XVxtTH9DjKCAO6PFKZen21d5siaxcsvrZb
	 5M8v4GzK2TxaIyYW+tL2Nkenlru8k4TJsWvzFeK4KPt1N+lbzK5ssiktoPjdZLmm1k
	 RKreVYPdsxKWW632LtK9ebXJKagutEBellsilFr/63mA6TNMXWwsJtynBXRkaqmN2m
	 rj1dqKmpUdolQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/8] wifi: ath12k: Add MLO station state change handling
References: <20241106142617.660901-1-kvalo@kernel.org>
	<20241106142617.660901-2-kvalo@kernel.org>
	<2e706d58-5d83-4867-9963-c62441cdd4da@quicinc.com>
Date: Tue, 12 Nov 2024 19:10:50 +0200
In-Reply-To: <2e706d58-5d83-4867-9963-c62441cdd4da@quicinc.com> (Baochen
	Qiang's message of "Thu, 7 Nov 2024 10:45:07 +0800")
Message-ID: <87y11o2x9h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 11/6/2024 10:26 PM, Kalle Valo wrote:
>> +static void ath12k_mac_unassign_link_sta(struct ath12k_hw *ah,
>> +					 struct ath12k_sta *ahsta,
>> +					 u8 link_id)
>> +{
>> +	lockdep_assert_wiphy(ah->hw->wiphy);
>> +
>> +	ahsta->links_map &= ~BIT(link_id);
>> +	rcu_assign_pointer(ahsta->link[link_id], NULL);
>> +
>> +	synchronize_rcu();
>
> this looks strange: generally we call synchronize_rcu() to wait for
> any RCU readers to finish, such that we can then safely free
> something. but here we do nothing ...

Same comment as in the other email, this is to make sure that we don't
continue the mac80211 call flow before all readers have the new value.
Is that a problem? And we can always optimise later.

>> +static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
>> +					      struct ath12k_sta *ahsta,
>> +					      u8 link_id)
>> +{
>> +	struct ath12k_link_sta *arsta;
>> +
>> +	lockdep_assert_wiphy(ah->hw->wiphy);
>> +
>> +	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
>> +		return;
>> +
>> +	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
>> +
>> +	if (WARN_ON(!arsta))
>> +		return;
>> +
>> +	ath12k_mac_unassign_link_sta(ah, ahsta, link_id);
>> +
>> +	arsta->link_id = ATH12K_INVALID_LINK_ID;
>> +	arsta->ahsta = NULL;
>> +	arsta->arvif = NULL;
>
> if arsta is not deflink and would be freed, can we avoid these
> cleanup?

I think that's something we can cleanup later if needed. Sure, it's
extra assignments but it's not really doing any harm.

>> +	if (arsta != &ahsta->deflink)
>> +		kfree(arsta);
>
> I know the actual free happens here, but why split them?

You mean why have a separate function ath12k_mac_unassign_link_sta() and
instead just have all code the in ath12k_mac_free_unassign_link_sta()?

> these two hunks give me the impression that we may (in the future?)
> have cases to call ath12k_mac_unassign_link_sta() alone somewhere else
> rather than directly calling ath12k_mac_free_unassign_link_sta(). am I
> feeling right? what are those cases?

At least I'm not aware of anything else calling
ath12k_mac_unassign_link_sta(). So I'll just remove that function and
move the code to ath12k_mac_free_unassign_link_sta().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

