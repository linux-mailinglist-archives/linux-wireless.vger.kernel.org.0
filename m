Return-Path: <linux-wireless+bounces-1093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8822281A125
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 15:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EE81C21D83
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE771EB4E;
	Wed, 20 Dec 2023 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuTVSssM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437801385
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 14:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D71C433C8;
	Wed, 20 Dec 2023 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703082657;
	bh=N39PxtHZcFs3qJ4hh3xlM/jq0KDCehSTsf7Y9YbXRRw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WuTVSssMIulKIbbWlo4i1oWwARMyVJUI7d0DJg80mE4ZHhFPADvIsTOei8eL3KR49
	 sMZ3I6MlXXRqUjlIbQ8VfmucTRmNQIqsC/rPl6eYyFlA3mvn5vfHq7dMmphuQVj4X2
	 O0EVsMmvuP/j2K4QDgIzb+wewQcrEHICYQe1FeoHVQVcARxDyNalvcys6bATFuOg/j
	 z0gKGoaSj+Cz+vLR7swu9qfXKQzZQQ9dIEAk109veC3tTelcNWrjjXyMFfNF07VtLk
	 1+mTQ4TxfQ0U5okWzETz/0Ah2u42SV+QNzIkjx/Zda+BnWTyXBsU5hUTpUf5bmZ0U0
	 uslLPYScy5mzA==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>,  ath11k@lists.infradead.org
Subject: Re: Ath11k warnings, and eventual phy going away requiring reboot
References: <ab00ff77-23de-43a1-9eb9-6ac036ab80e3@gmail.com>
	<87edfiqcdi.fsf@kernel.org>
	<6122eb4e-66f5-4772-b211-8fc69ac88ebe@gmail.com>
Date: Wed, 20 Dec 2023 16:30:54 +0200
In-Reply-To: <6122eb4e-66f5-4772-b211-8fc69ac88ebe@gmail.com> (James
	Prestwood's message of "Wed, 20 Dec 2023 04:42:31 -0800")
Message-ID: <87o7elosip.fsf@kernel.org>
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

> Hi Kalle,
>
> On 12/19/23 10:24 AM, Kalle Valo wrote:
>> James Prestwood <prestwoj@gmail.com> writes:
>>
>>> I noticed this after one of our devices dropped offline. The device
>>> had roamed 7 minutes prior so I doubt that had anything to do with it.
>>> But then we get this, and then tons of warnings. I'm happy to provide
>>> full stack traces but its quite a few, not sure which ones are
>>> relevant or not. After all the warnings IWD got an RTNL del link event
>>> and was unable to recover from that. It seems after that ath11k tried
>>> to power back on but failed.
>>>
>>> This is a stock 6.2 ubuntu kernel, WCN6855:
>> BTW I don't know how it's nowadays, but back in the day Ubuntu heavily
>> modified ath11k. And we can't support distro kernels anyway as we don't
>> know what they have changed in the kernel.
>
> Ok. I understand where your coming from, but at the same time Ubuntu
> is the largest linux distribution so it seems like these type of
> reports wouldn't be uncommon. OTOH maybe users just go directly to
> Ubuntu.

Isn't the recommendation that distro kernel bugs should be reported to
distro bug trackers? At least that's what I have understood. At least
our bugzilla says that:

https://bugzilla.kernel.org/

> Anyways, this is a list of patches isn't huge according to the
> changelog (for 6.2):
>
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: fix registration of 6Ghz-only ph=
y without the
> full channel
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: add support default regdb while =
searching
> board-2.bin for
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: fix memory leak in WMI firmware =
stats
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: Add missing check for ioremap
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: Ignore frags from uninitialized =
peer in dp.
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: Fix SKB corruption in REO destin=
ation ring
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: reduce the MHI timeout to 20s
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: Use platform_get_irq() to get th=
e interrupt
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: fix SAC bug on peer addition wit=
h sta band migration
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: fix deinitialization of firmware=
 resources
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: fix writing to unintended memory=
 region
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: Fix memory leak in ath11k_peer_r=
x_frag_setup
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: fix monitor mode bringup crash
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: debugfs: fix to work with multip=
le PCI devices
> =C2=A0=C2=A0=C2=A0=C2=A0 - wifi: ath11k: allow system suspend to survive =
ath11k
>
> I see the dilemma of not wanting to waste time debugging when there
> are unknown changes applied. I was hoping someone would recognize the
> behavior and could suggest a patch/kernel/firmware to try

Sure, I also get where you are coming from :) Just wanted to make sure
you know the problem with distro kernels.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

