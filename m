Return-Path: <linux-wireless+bounces-9142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD090C7C3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AF51C21D9A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24B15666E;
	Tue, 18 Jun 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvXl7c0f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A353154BE2;
	Tue, 18 Jun 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702185; cv=none; b=OcQaAi6NOD5gqD35xHh5dnTQQ1SdSWM4gDNKVqVpLpzv06AAWhoclxeK01TF6axGOZ2rrQxBp8LszNH/n1yOhsn1M4hSrIuMBBh2EXkFh2/CkX/aleszSoukzjA10FTdskoGU+SVIWd1Y/o+GPUy60BCQML0lmhNFScVFrT23KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702185; c=relaxed/simple;
	bh=gJYgxijDZLRQX7vJE03ZtXSpHCoLXF6IHeSC1ttxfRE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gP7WZO2BZDDxtC0x0IXQBKWM4mFN2Ha0/2k8hKpDyIy9C95iM9dJN8qKgzV/lmZcJE547f2k5Lw9Vv2IPM3BuOTfdICyNDxBVZBypwa60ofwGK9L20ubRcgX/Pbq7IULSkeDC8/plQUdoJllcSA70u5KssPFcgEEqYRE7gI7IWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvXl7c0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A67C4AF1D;
	Tue, 18 Jun 2024 09:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718702184;
	bh=gJYgxijDZLRQX7vJE03ZtXSpHCoLXF6IHeSC1ttxfRE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ZvXl7c0fqJPirKBWXh00KMCuEMH04R1OF6W1/cCtAOroxdGUuti24F0zDD9CHxGZR
	 t2rZtMmT91W0ioShq/gabu/Nf3xNNks2U6sy5FBsNGhSxsTS3eBdTCe8aZgrCIqjGX
	 6uFeWklSQ4eovKwqIZOLWwNSMUXpTdTasfkACtKK5J/80bXph4cEULZguJQxY4OUj/
	 AcUZ5+2vqRc/ZdI3IPaZyLemWheYT5kAsvQbTg/uQsT13r7OueoFHqsmK774WQZ4MF
	 v7eL+H7bkTPSa1xKivbRb35CILQhNy/KmXjFjDKOgQLFIkVBFNLtVBhYXsdf5VEgmA
	 xCfxVT8ek7Heg==
From: Kalle Valo <kvalo@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Johannes Berg <johannes.berg@intel.com>,  Michael Nemanov
 <michael.nemanov@ti.com>,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless v2] wifi: wlcore: fix wlcore AP mode
References: <E1sClp4-00Evu7-8v@rmk-PC.armlinux.org.uk>
	<Zm1CKAKCnuc94oIi@shell.armlinux.org.uk> <87tthrn8gf.fsf@kernel.org>
	<ZnA4QpyOdcYxg8LE@shell.armlinux.org.uk>
Date: Tue, 18 Jun 2024 12:16:21 +0300
In-Reply-To: <ZnA4QpyOdcYxg8LE@shell.armlinux.org.uk> (Russell King's message
	of "Mon, 17 Jun 2024 14:21:06 +0100")
Message-ID: <87a5jimx0a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

> On Mon, Jun 17, 2024 at 01:56:48PM +0300, Kalle Valo wrote:
>> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
>> 
>> > I see all my TI Wilink patches have been marked as "deferred" in the
>> > wireless patchwork. Please could you explain what the plan is with
>> > these patches, especially this one which fixes a serious frustrating
>> > failing that makes AP mode on this hardware very unreliable and thus
>> > useless.
>> 
>> I'm just swamped with patches, I'll try to look at these soon.
>> 
>> I wish that TI would take a more active role in upstream, for example
>> reviewing and testing patches would help a lot.
>
> I believe the problem has been that TI have had an attitude of "we
> only support people using 4.19.38, if you can't reproduce the problem
> there we aren't interested". To see the versions they support:
>
> https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7
>
> basically, all are ancient.
>
> They also appear take the attitude that all the kernel code is ripe
> for them to hack about with - whcih is why this fix has had to be
> reworked so it isn't removing NL80211_FEATURE_FULL_AP_CLIENT_STATE
> for _all_ kernel wireless drivers!
>
> Also, I think they also require one to use their hostapd and
> wpa_supplicant, probably for a similar reason. I know that in some
> of the patches they've hacked in API changes...
>
> Then one can see the attitude of lock-step firmware and driver
> upgrade - you can't use 8.9.1.x.x firmware with their older driver,
> and you can't use 8.9.0.x.x with their newer driver. That, of course,
> is not acceptable to mainline.
>
> So, given all this, IMHO it's probably a good thing TI aren't trying
> to submit their stuff upstream... that is, unless they are willing
> to learn how to "do things correctly".
>
> Maybe I'm being too hard on TI's wireless division, but that seems to
> be what has been going on.

Yeah, the all you describe above is very common in wireless vendors :/
But vendors do learn, Realtek is a great example of that. Let's hope
that TI does too.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

