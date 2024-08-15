Return-Path: <linux-wireless+bounces-11490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16169537B8
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 17:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A411F25D79
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612F1B3F18;
	Thu, 15 Aug 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9MIfvMZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822AD1B3F09
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737510; cv=none; b=UK2bw7bxX7YwRowtXWaJrGNpr5PUvLbriX7GrrB43UfmTYHnOYVrOgLSg4FHUPMi9ESjYvkZcyhgvk8MMSOxJmcyty7SaBIAEhfbpxblYRNvZIuNHGomlt8yaRi7syh75LA079hWCnx2kmrVks97FXVGIfEHFioCGPcKNtvZIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737510; c=relaxed/simple;
	bh=vV69M/rpZM35DO1TBNNyQ3w7yWmttvCJ05EdXdKKqWo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Z1WnAEHSHDhKFRsmRGjjH6xH+c///jgfWjokfvUMOptXtMBU+lKDNvY0cQQDD2YaLN9VnAbyx4cPkAcGPawDa/+9njaoEFY815+mcrnXU0rvXqitHkxtv5UL2zgA2N3AvZ1wAW8ETjSbLKo2fPhnTRCiQdm6wo7AyOEZ6ucYbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9MIfvMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F37DC4AF0E;
	Thu, 15 Aug 2024 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737510;
	bh=vV69M/rpZM35DO1TBNNyQ3w7yWmttvCJ05EdXdKKqWo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=l9MIfvMZQzq4+pPytYlvww/yykLHs9AIAkjSUqjVVE9Ymp/N69f7CViygMdLol9FP
	 F5h12TmWb+WXKRtBk9M/RNjdNKZ+QnEPmLyrZm5e6enhn/n5ltf2aGKU3riCRzPMQq
	 D8mwXzpS7ld4LKnqQDYi/zrlXO/OiwdPTKojc6euRxO4YAN8pR/slLaUDtAm08CQek
	 CSF9wIIlz7mGx2luFKKvv4i7SrcacAkPU4+L4H09JEp1I6qSCxcNV320C166XFOMRu
	 4ikZQofQuTtqHWCvELN9MwJj1foCmL0BbChZ034OTpH/p/MwHH+baqn0wDWvd56OI4
	 xVkpQxGd/Z3Kw==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: linux-wireless@vger.kernel.org,  ath10k@lists.infradead.org
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
	<c407064a-1c2f-46ec-ac57-32bf9cf6f5c6@gmail.com>
	<9eafac85-2262-4f92-a70b-32109f65c05a@gmail.com>
	<87r0apyjc3.fsf@kernel.org>
	<6ba02350-3c8c-4664-9d68-67cb7e90eddb@gmail.com>
Date: Thu, 15 Aug 2024 18:58:27 +0300
In-Reply-To: <6ba02350-3c8c-4664-9d68-67cb7e90eddb@gmail.com> (James
	Prestwood's message of "Thu, 15 Aug 2024 08:47:35 -0700")
Message-ID: <87ed6pydzw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Prestwood <prestwoj@gmail.com> writes:

> On 8/15/24 7:03 AM, Kalle Valo wrote:
>> James Prestwood <prestwoj@gmail.com> writes:
>>
>>> Hi,
>>>
>>> So I have no resolution to this (trying to get the AP vendor to chase
>>> it down), but I'm toying with the idea of trying to work around
>>> whatever issue the AP is having when this occurs. The only thing I can
>>> think of is that there is a 3 second delay between the authentication
>>> and reassociation, and perhaps this is causing some timeout in the AP
>>> and in turn the deauth.
>>>
>>> I'm wondering how long it should take to add/remove a key from the
>>> firmware? 3 seconds seems very long, and I question if this timeout is
>>> really necessary or was just chosen arbitrarily? Is this something
>>> that could be lowered down to e.g. 1 second without negative impacts?
>>> The code in question is in ath10k_install_key:
>>>
>>> ret =3D ath10k_send_key(arvif, key, cmd, macaddr, flags);
>>> if (ret)
>>>  =C2=A0=C2=A0=C2=A0 return ret;
>>>
>>> time_left =3D wait_for_completion_timeout(&ar->install_key_done, 3 * HZ=
);
>>> if (time_left =3D=3D 0)
>>>  =C2=A0=C2=A0=C2=A0 return -ETIMEDOUT;
>> I can't remember anymore but I'm guessing the 3s delay was chosen
>> arbitrarily just to be on the safe side and not get unnecessary
>> timeouts.
>
> Thanks, I have reduced this to 1 second and have had it running on a
> client for ~19 hours. Still am seeing the timeouts, but no more than
> prior. And even with the timeouts the roams are successful.
>
> After doing more looking in the spec I did see that there is
> dot11ReassociationDeadline which may be coming into play here. Of
> course these APs aren't advertising any TIE or even support FT
> resource requests that so its impossible to know for sure, and hostapd
> AFAICT doesn't enforce any deadlines even if you set it... But in any
> case the timeout reduction is helping immensely and avoiding a
> disconnect.

Yeah, reducing the time out might a good option. 3s feels like overkill,
especially if 1s timeout passes your tests.

But I do wonder what's the root cause here. Are you saying that SET_KEY
always works for you?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

