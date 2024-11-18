Return-Path: <linux-wireless+bounces-15452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 946829D1069
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 13:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD80B22DA8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07989190470;
	Mon, 18 Nov 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="AGPKgAua"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3EC13A89A
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931944; cv=none; b=ai8N0Mq0mD0mgxNumKH61W0bv8OVdGJjSQAzMTf9JKR/9CicDN5FKW8O2WGIGbtpofRrWknBU7sr9hpC1eARR1n5TY0LQ0e3iYq+lOY4nwf2WDuB4gd/DMDbgQVOpWW1vcAVK88M6DBW+L+rtOvXUZF7UYUPgt3IHL6mp1At5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931944; c=relaxed/simple;
	bh=0hrdceqrbjeJBAKk6bVCbKODz3f5ZWzYzkLB/MObs9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eOkrZ8+v6aqDjZQQIVaZN+7GkL+EvM5fB6EpMOKUedLigPnzAsNSIB0XMKwpwyksBTmdCZUsZiY9FlH6hUtNr+QOhsNfUzcV1dBE9kJ4NA3BIXvzaW8haVRY/hv8o8X0c7ltIsbBXs5yKxV+koveKj+2WSMN+JG9fduZ6sJay68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=AGPKgAua; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1731931930; bh=0hrdceqrbjeJBAKk6bVCbKODz3f5ZWzYzkLB/MObs9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AGPKgAua2+aUWHpRqCcpu+iEGY0fXUSFU4bL4FS0nwooTngdaizSZ2f9b0EXHfk4Z
	 n4rqTjOTKvnlGbXlQhu/pDW/ytRjUxKJ91QB/nYHkfIYaQchK1FIc90sjLrjEakR2j
	 F1SaWDYAYnh3Z8wQfgdgoWupbembjpdZ0DKgTaDfFVI7teRR5XwfFW/6JrinF5ih1x
	 Hl79TssuJkjej6pl3S5wotMBGc0lfOlasP0PFfoXtEaXWEYbeuDaaHFWM1z6uJ18eB
	 oZSOLKWF5ZSwX/SlcThBgRWYCCNwLw7Iw1h/lPcfl+DU6XuCj58zY56WFpVaQvuL02
	 yNHl7jdKxenNg==
To: Hamdi Issam <ih@simonwunderlich.de>, Simon Wunderlich
 <sw@simonwunderlich.de>, Sven Eckelmann <se@simonwunderlich.de>, Kalle
 Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] ath9k: Add RX inactivity detection and reset chip when
 it occurs
In-Reply-To: <c17462eb-5013-46f8-90fd-bc9c8b0431a5@simonwunderlich.de>
References: <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
 <3288096.AJdgDx1Vlc@ripper> <87msic78no.fsf@toke.dk>
 <5009451.31r3eYUQgx@prime>
 <c17462eb-5013-46f8-90fd-bc9c8b0431a5@simonwunderlich.de>
Date: Mon, 18 Nov 2024 13:12:09 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87jzd0rbae.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hamdi Issam <ih@simonwunderlich.de> writes:

> On 11/6/24 17:03, Simon Wunderlich wrote:
>> On Wednesday, November 6, 2024 3:12:59 PM CET Toke H=C3=B8iland-J=C3=B8r=
gensen wrote:
>>> Sven Eckelmann <se@simonwunderlich.de> writes:
>>>> Hi,
>>>>
>>>> Thank you for submitting the patch.
>>>>
>>>> On Wednesday, 6 November 2024 13:41:44 CET Toke H=C3=B8iland-J=C3=B8rg=
ensen wrote:
>>>>> Since this is based on ideas by all three people, but not actually
>>>>> directly derived from any of the patches, I'm including Suggested-by
>>>>> tags from Simon, Sven and Felix below, which should hopefully serve as
>>>>> proper credit.
>>>> At least for me, this is more than enough. Thanks.
>>>>
>>>> I don't have the setup at the moment to test it again - maybe Issam ca=
n do
>>>> this. One concern I would have (because I don't find the notes regardi=
ng
>>>> this problem), is whether this check is now breaking because we count
>>>> more things. In the past, rxlp/rxok was used for the check. And now I
>>>> don't know whether the count for the other ones were still increasing.
>>>>
>>>> * RXHP (rather sure that "high priority frame" wasn't increasing)
>>>> * RXEOL ("no RX descriptors available" - I would guess no, but I can't=
 say
>>>> for>
>>>>    sure)
>>>>
>>>> * RXORN ("FIFO overrun" I would guess no, but I can't say for sure)
>>>>
>>>> Reviewed-by: Sven Eckelmann <se@simonwunderlich.de>
>>> Great, thanks for the review! I'll let it sit in patchwork for a little
>>> while to give people a chance to test it out before sending it over to
>>> Kalle to be applied :)
>>>
>>> -Toke
>> Hi Toke,
>>
>> this looks good to me in general. I'm not sure either about the particul=
ar RX
>> interrupts. We can test this by putting the AP in a shield box and verif=
y that
>> the counters are actually increasing, and that should be good enough.
>>
>> Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
>>
>> Thank you!
>>        Simon
>
> Hi Toke,
>
> I have tested this patch in mesh mode, and=C2=A0it functions as expected.
>
> I conducted the test by placing one node inside a shield box and the=20
> other outside, then verified whether a reset occurred due to RX path=20
> inactivity.
>
> Tested-by: Issam Hamdi <ih@simonwunderlich.de>

Great, thanks for testing! :)

-Toke

