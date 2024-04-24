Return-Path: <linux-wireless+bounces-6767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 910CD8B0902
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 14:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA837B21AB2
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9247815ADAD;
	Wed, 24 Apr 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pun7+FC1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A215ADA8
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961013; cv=none; b=jaFmqOcKvbUX80vJro4RPzbufMOOZgWBIIFqM4h8rpnGHZ7ms49oa3FjM9KngohgKX3m+vEs1MWqq63zzx9L+NQz7SC07AAYar1eExFmFoZSd95/+bKtR+mR6gEr8fkMp/RTDAC7lr1DgZHMWJyWxUFdVMuzNk9vZaSIAWasLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961013; c=relaxed/simple;
	bh=OX1on8q3Ad03sND9POMGUlaAeb8HEwb6ksC2BxoGMGU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=A0HpvRR/0v1OCpFkn5hZFtVXxQwtycnWMGhUB4cA1/sqkUc/tpcBVqIC2eOJRRd1AueZ7MPrmbtkRP1jzBxULAhRWE64FkmGrRVseD7j9CiegS3dQlW1uM4N2HRBULqDf1DRqrdsu5IVbyBvm5NCTZUzdjPd4nNAxRU5U27cfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pun7+FC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1347AC32782;
	Wed, 24 Apr 2024 12:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713961013;
	bh=OX1on8q3Ad03sND9POMGUlaAeb8HEwb6ksC2BxoGMGU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Pun7+FC189HqJhl6WcjO1UjNciuekhr5SuR4olEM8WJaflIO5OcXBY3Cg/23DZfc7
	 cCwWkvIfyVwegxRfkPCmEF0EmRa2SThUyhrTmXMwqE2nIXLRrR8fnuBpn//qsSWuQs
	 kEtT+qy6LKa86KIBAMLM13OtkgGMcHJTdFWWqO4iZqkHNXaXOI0hMGS1Tq3UQYlzLi
	 ELYzYbqCPfv+ykzhjnvnWqNGMsw6/O3kGe5GhTtPM+Q32ESd3qBqtUf/MykRPGktw2
	 pldpuqZCgHi/7l5EzZuxFgg/KmI+iS8wVze60G5FjLeAD32sOrMKEQIjZaHSvgt3NC
	 Rbbh29Yhc+77A==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
  ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 3/3] wifi: ath12k: Add lock to protect the hardware
 state
References: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
	<20240424065646.1666166-4-quic_periyasa@quicinc.com>
	<517caf852d37b3803bcf087a6b575f2ecdb5ba10.camel@sipsolutions.net>
	<87il07t7zq.fsf@kernel.org>
	<3dc4339f5c3f603027c2214058e7e3251652a7f0.camel@sipsolutions.net>
	<87edavt7h8.fsf@kernel.org>
	<0bfbb5549b48296e6219488d47caccd10e818700.camel@sipsolutions.net>
Date: Wed, 24 Apr 2024 15:16:50 +0300
In-Reply-To: <0bfbb5549b48296e6219488d47caccd10e818700.camel@sipsolutions.net>
	(Johannes Berg's message of "Wed, 24 Apr 2024 11:52:22 +0200")
Message-ID: <87a5ljt0p9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2024-04-24 at 12:50 +0300, Kalle Valo wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>> 
>> > On Wed, 2024-04-24 at 12:39 +0300, Kalle Valo wrote:
>> > > 
>> > > Exactly. Swithing to use wiphy_lock() definitely one of my longterm
>> > > goals in ath12k. I already started working on switching ath12k to use
>> > > wiphy_lock() but IIRC I got blocked by not being able to call
>> > > wiphy_delayed_work_cancel() without taking wiphy_lock.
>> > 
>> > That's because I didn't want to have an async version, but theoretically
>> > we could have a version of it that just cancels the timer. If you don't
>> > hold the wiphy mutex already you could even wait for it to finish. It
>> > just adds more complexity there, and I was trying to make it all a lot
>> > more obvious :)
>> 
>> Yeah, understandable. I think changing ath12k WMI event handling to use
>> wiphy_work makes sense, running them in tasklet context feels overkill.
>
> Maybe. Note that the wiphy lock _can_ create delays etc. here, if you're
> doing other configuration work at the same time, or similar. Though I
> guess eventually you need locking there anyway, to access the HW. So it
> can be a bit of a trade-off.
>
> I expect this will evolve over time even in mac80211, though so far we
> haven't seen any bad effect from it.

Good point. And now that I think of this more I don't think we can use
wiphy_work with WMI events as we are waiting some events while holding
wiphy_lock, that would end up as deadlock. So most likely we need to use
a normal workqueue with WMI events and take wiphy_lock manually in
certain cases. But I'll need to investigate more and do some
experiments.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

