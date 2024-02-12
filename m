Return-Path: <linux-wireless+bounces-3455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E9851519
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 14:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD12B1C2188D
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32F93C06A;
	Mon, 12 Feb 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw92NdO3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFCF3BB50
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743729; cv=none; b=NcVy5JS887dYTWnyKv7QJNlxB9W0wmzWngb0jOPsrLID/ZDUvC/x46AS9kCa1jp1f5cKX1YH3P2ueha/2w61s4+EnPSwPXuRRP09rPn0pFPmteRWJI3rQk6E62jl3awmyEnmr2/Erddr88DibRyT04eDV52gGNbw9ffSyTnlITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743729; c=relaxed/simple;
	bh=24M0v7n939VC6aUYM1vxIxc/JhIgpm52zvlZjhM5u8I=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c63STHmGDE6MxUbsOH06/PEoLUY/JE535ZorruwsFI6pJ7hi+rsQ8s2D45FaskKg4pRMFvFZ1Caul0+ea8qFEmcLF1k4s/1x11ZkZjfb6Zdtacnihe9hwmpMXVYYM40W+awLsEGNBi4rDU3GIP/LJD35oegPIjOCYdRb8e7JmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw92NdO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CCCC433F1;
	Mon, 12 Feb 2024 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743729;
	bh=24M0v7n939VC6aUYM1vxIxc/JhIgpm52zvlZjhM5u8I=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=pw92NdO3cJS+I6y7yUW7giFEAS7NEEag10JIS5C40pl6ViGp8IlaOF+hk9YfUpAW6
	 li+XGjAZMuQD7jWZVl5kJAQU4Qu2GfKuMJ/y+AjEmAu1LEU4oY7jN9EOWUjEsOF5rh
	 g2XzsCGoyNOf+LvtcDwPvEm7MADQkd/VmiTNUScRYlpndLL//1o7vfgUX6Ppj4cvis
	 unmy12wZBznsQX3R61bNomyRgxcNspGTWOodSn1jO07ZVAth8Bk0cst/5xxSMzTP/Z
	 /ZT6/OI0kzrek8ZP+G98AE9YDfopjSYDi+vjHvrZk/m0UKLM7XpL0UIu7SfpUGfh2o
	 xyOganaWaYKjQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5747C10F5556; Mon, 12 Feb 2024 14:15:26 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: Re: [RFC] mac80211: add AQL support for broadcast packets
In-Reply-To: <9922ecf9-d243-40a1-809b-9739d3269177@nbd.name>
References: <20240209184730.69589-1-nbd@nbd.name> <87plx4s71y.fsf@toke.dk>
 <960efcac-0995-4a42-b90c-3e66c0f56762@nbd.name>
 <66bddf2f6362c9f39f06e06c0c35b6900917b9bf.camel@sipsolutions.net>
 <87sf1yymr2.fsf@toke.dk> <9922ecf9-d243-40a1-809b-9739d3269177@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 12 Feb 2024 14:15:26 +0100
Message-ID: <87eddhzuvl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Felix Fietkau <nbd@nbd.name> writes:

> On 12.02.24 11:56, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>>=20
>>> On Sat, 2024-02-10 at 17:18 +0100, Felix Fietkau wrote:
>>>>=20
>>>> > > +++ b/include/net/cfg80211.h
>>>> > > @@ -3385,6 +3385,7 @@ enum wiphy_params_flags {
>>>> > >  /* The per TXQ device queue limit in airtime */
>>>> > >  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	5000
>>>> > >  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	12000
>>>> > > +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_BC	50000
>>>> >=20
>>>> > How did you arrive at the 50 ms figure for the limit on broadcast
>>>> > traffic? Seems like quite a lot? Did you experiment with different
>>>> > values?
>>>>=20
>>>> Whenever a client is connected and in powersave mode, all multicast=20
>>>> packets are buffered and sent after the beacon. Because of that I=20
>>>> decided to use half of a default beacon interval.
>>>
>>> That makes some sense, I guess.
>>=20
>> This implies that we will allow enough data to be queued up in the
>> hardware to spend half the next beacon interval just sending that
>> broadcast data? Isn't that a bit much if the goal is to prevent
>> broadcast from killing the network? What effect did you measure of this
>> patch? :)
>
> I didn't do any real measurements with this patch yet. How much=20
> broadcast data is actually sent after the beacon is still up to the=20
> driver/hardware, so depending on that, the limit might even be less than=
=20
> 50ms. I also wanted to be conservative in limiting buffering in order to=
=20
> avoid potential regressions. While 50ms may seem like much, I believe it=
=20
> is still a significant improvement over the current state, which is=20
> unlimited.
>
>> Also, as soon as something is actually transmitted, the kernel will
>> start pushing more data into the HW from the queue in the host. So the
>> HW queue limit shouldn't be set as "this is the maximum that should be
>> transmitted in one go", but rather "this is the minimum time we need for
>> the software stack to catch up and refill the queue before it runs
>> empty". So from that perspective 50ms also seems a bit high?
>
> When broadcast buffering is enabled, the driver/hardware typically=20
> prepares the set of packets to be transmitted before the beacon is sent.=
=20
> Any packet not ready by then will be sent in the next round.
> I added the 50ms limit based on that assumption.

Ah, so even if this is being done in software it's happening in the
driver, so post-TXQ dequeue? OK, in that case I guess it makes sense;
would love to see some numbers, of course, but I guess the debugfs
additions in this patch will make it possible to actually monitor the
queue lengths seen in the wild :)

>>> It does have me wondering though if we should also consider multicast
>>> for airtime fairness in some way?
>>=20
>> Yeah, that would make sense. The virtual time-based scheduler that we
>> ended up reverting actually included airtime accounting for the
>> multicast queue as well. I don't recall if there was any problem with
>> that particular part of the change, or if it's just incidental that we
>> got rid of it as part of the revert. But it may be worth revisiting and
>> adding a similar mechanism to the round-robin scheduler...
>
> The round-robin scheduler already has some consideration of multicast -=20
> it always puts the multicast queues last in the active_txqs list.

Ah, right. Hmm, not quite clear to me how that works out in terms of
fairness, but it should at least prevent the MC queue from blocking
everything else...

-Toke

