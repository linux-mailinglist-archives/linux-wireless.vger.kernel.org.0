Return-Path: <linux-wireless+bounces-3440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776058511A6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 11:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA87C1C236DF
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C489828387;
	Mon, 12 Feb 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUyvomfo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955628370
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735381; cv=none; b=iF/9Z1QVrynagAzUmNkPrzUwxnfjdFOX51srodMayMn/idDhmKqVbZKda6iwxVGiZ7VW48wHEKWutQgk8uD1XonzuS1AT6kTmZLshCVX3ECEr0Rm8TmT+cMXd16uGq0elIJGxy0oOSy72qv9nVALck3M+dqETFtZy53EQLUtUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735381; c=relaxed/simple;
	bh=Z3tvspC6DQXGIYkvU8lPm/76dccMK9TAbLUY5+qKmPs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G7AD61Vja9qZWLEESQ/PP1eZUWaKcNkgDkOrjVNRm/+2IzXtqsveFiRxnJYWijYIushNAo+dDEUr1Pqv24UlasFf7LGsotP+u0Zz+ZPFv2eCDxUJTH2uOyASwqb4RVmYl2TBh3QnjxqdD5nX9Ya1J1Q1caMNUNhiNu3DhrIy4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUyvomfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA85C43394;
	Mon, 12 Feb 2024 10:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707735381;
	bh=Z3tvspC6DQXGIYkvU8lPm/76dccMK9TAbLUY5+qKmPs=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=QUyvomfo3rx63e6zjo1hxQQgshiXCUDSt+2e0DN5B1NSu/kEdNNZW51gLmfnZFNH6
	 4GnKpiIQBicFFOzHGJlw01+tUTOpUkMFSHUxNpbQN8c6JEfPvc6ej5ArO3LVFngpWT
	 kvirQicLMmB/Q3HFAJGc7EwHehWBxTCEAx++ZLM4N1Eju6DbaY75MKeWi22B6smN5r
	 wwC8maHHJA8mwUFaZoS07aGhu/U1XgyP+UVpaqm5qPhxb3ui8nx2g4rzp7TnZQiOTk
	 dW94ytMFM0VqYjhpdqyrn9hMHZdeAKSkDS38/N6P51omaDaqkKciYFlD3mVEsqUJ7l
	 Gj3Zf0pabwQaA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0A58610F5526; Mon, 12 Feb 2024 11:56:18 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
 linux-wireless@vger.kernel.org
Subject: Re: [RFC] mac80211: add AQL support for broadcast packets
In-Reply-To: <66bddf2f6362c9f39f06e06c0c35b6900917b9bf.camel@sipsolutions.net>
References: <20240209184730.69589-1-nbd@nbd.name> <87plx4s71y.fsf@toke.dk>
 <960efcac-0995-4a42-b90c-3e66c0f56762@nbd.name>
 <66bddf2f6362c9f39f06e06c0c35b6900917b9bf.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 12 Feb 2024 11:56:17 +0100
Message-ID: <87sf1yymr2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Sat, 2024-02-10 at 17:18 +0100, Felix Fietkau wrote:
>> 
>> > > +++ b/include/net/cfg80211.h
>> > > @@ -3385,6 +3385,7 @@ enum wiphy_params_flags {
>> > >  /* The per TXQ device queue limit in airtime */
>> > >  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	5000
>> > >  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	12000
>> > > +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_BC	50000
>> > 
>> > How did you arrive at the 50 ms figure for the limit on broadcast
>> > traffic? Seems like quite a lot? Did you experiment with different
>> > values?
>> 
>> Whenever a client is connected and in powersave mode, all multicast 
>> packets are buffered and sent after the beacon. Because of that I 
>> decided to use half of a default beacon interval.
>
> That makes some sense, I guess.

This implies that we will allow enough data to be queued up in the
hardware to spend half the next beacon interval just sending that
broadcast data? Isn't that a bit much if the goal is to prevent
broadcast from killing the network? What effect did you measure of this
patch? :)

Also, as soon as something is actually transmitted, the kernel will
start pushing more data into the HW from the queue in the host. So the
HW queue limit shouldn't be set as "this is the maximum that should be
transmitted in one go", but rather "this is the minimum time we need for
the software stack to catch up and refill the queue before it runs
empty". So from that perspective 50ms also seems a bit high?

> It does have me wondering though if we should also consider multicast
> for airtime fairness in some way?

Yeah, that would make sense. The virtual time-based scheduler that we
ended up reverting actually included airtime accounting for the
multicast queue as well. I don't recall if there was any problem with
that particular part of the change, or if it's just incidental that we
got rid of it as part of the revert. But it may be worth revisiting and
adding a similar mechanism to the round-robin scheduler...

-Toke

