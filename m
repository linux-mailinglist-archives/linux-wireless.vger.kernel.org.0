Return-Path: <linux-wireless+bounces-15451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB649D0FD3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 12:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDC21F22D2B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 11:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F49198A08;
	Mon, 18 Nov 2024 11:35:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0A194A7C
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929746; cv=none; b=tAJZPpetqJ/O8dQrCpvDgxo8JMorxvhGZhTO0UnG9jkeZHYRljsB964zVp5KUNR/MRVLtr4DFqr7cDmJ/+1UL2ZARuPcAXLORApOeIRPQODKEaO7CHLi1GTcEmG7I/nsdZW4PeHKB64Ir9rynpVekqPhs2aK7O6IZebz+k57o8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929746; c=relaxed/simple;
	bh=VoBiJ/uCzd9vE9syDFIu5G1aE5menWx73xgBxSq3Elk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEIyIRTo6Q9//QoUy+DcCslCqkVPePF5409L4azuiZfWdsPuGUjl3aJIlAFiWgFxKv2kWUIGqiLfCxi9/FFRqNmD7b/NYpPqZWpXQzw91h2yWUlHVXNMNF3qflEOoLSvVM98q56clvaBX83LkxkOrkkqm7Qw2eNftUO2kKIX1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from [IPV6:2003:c5:9731:6b90::32b] (p200300c597316B90000000000000032B.dip0.t-ipconnect.de [IPv6:2003:c5:9731:6b90::32b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 5AFC8FA132;
	Mon, 18 Nov 2024 12:29:23 +0100 (CET)
Message-ID: <c17462eb-5013-46f8-90fd-bc9c8b0431a5@simonwunderlich.de>
Date: Mon, 18 Nov 2024 12:29:22 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath9k: Add RX inactivity detection and reset chip when it
 occurs
Content-Language: en-US
To: Simon Wunderlich <sw@simonwunderlich.de>,
 Sven Eckelmann <se@simonwunderlich.de>, Kalle Valo <kvalo@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
References: <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
 <3288096.AJdgDx1Vlc@ripper> <87msic78no.fsf@toke.dk>
 <5009451.31r3eYUQgx@prime>
From: Hamdi Issam <ih@simonwunderlich.de>
In-Reply-To: <5009451.31r3eYUQgx@prime>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/24 17:03, Simon Wunderlich wrote:
> On Wednesday, November 6, 2024 3:12:59 PM CET Toke Høiland-Jørgensen wrote:
>> Sven Eckelmann <se@simonwunderlich.de> writes:
>>> Hi,
>>>
>>> Thank you for submitting the patch.
>>>
>>> On Wednesday, 6 November 2024 13:41:44 CET Toke Høiland-Jørgensen wrote:
>>>> Since this is based on ideas by all three people, but not actually
>>>> directly derived from any of the patches, I'm including Suggested-by
>>>> tags from Simon, Sven and Felix below, which should hopefully serve as
>>>> proper credit.
>>> At least for me, this is more than enough. Thanks.
>>>
>>> I don't have the setup at the moment to test it again - maybe Issam can do
>>> this. One concern I would have (because I don't find the notes regarding
>>> this problem), is whether this check is now breaking because we count
>>> more things. In the past, rxlp/rxok was used for the check. And now I
>>> don't know whether the count for the other ones were still increasing.
>>>
>>> * RXHP (rather sure that "high priority frame" wasn't increasing)
>>> * RXEOL ("no RX descriptors available" - I would guess no, but I can't say
>>> for>
>>>    sure)
>>>
>>> * RXORN ("FIFO overrun" I would guess no, but I can't say for sure)
>>>
>>> Reviewed-by: Sven Eckelmann <se@simonwunderlich.de>
>> Great, thanks for the review! I'll let it sit in patchwork for a little
>> while to give people a chance to test it out before sending it over to
>> Kalle to be applied :)
>>
>> -Toke
> Hi Toke,
>
> this looks good to me in general. I'm not sure either about the particular RX
> interrupts. We can test this by putting the AP in a shield box and verify that
> the counters are actually increasing, and that should be good enough.
>
> Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
>
> Thank you!
>        Simon

Hi Toke,

I have tested this patch in mesh mode, and it functions as expected.

I conducted the test by placing one node inside a shield box and the 
other outside, then verified whether a reset occurred due to RX path 
inactivity.

Tested-by: Issam Hamdi <ih@simonwunderlich.de>

Regards,

Issam


-


