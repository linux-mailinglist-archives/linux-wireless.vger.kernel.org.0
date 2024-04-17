Return-Path: <linux-wireless+bounces-6425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 434C18A7E38
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 10:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD041C2133C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143AA7F47D;
	Wed, 17 Apr 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZRoAsQz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30867F479
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342487; cv=none; b=eUoV41ryyoCh9JF3pVm+kl4qL+4cr111H3195FyDYmJG2/t/vo9OAiYm8+kGJ/V/sis5FIMj7g98ULyxbjDT8uODakSTd9uTZSOuet51Rz+XRikmQasRyditRtbSnNzLClEPAHXX8fMGnPoVGVfGIV/sofoW9wbN3g68287iqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342487; c=relaxed/simple;
	bh=8HKqBkuK9XOWdikq79nMUvBa5Kdfk7JgGBOxMUWGla0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OX5UBqUk7giMe+B5NTKTDEOSNvMIuXm31YO/H0Vw4P2fsHZHnN4yK4tZ21qqpz/fBDZwKE6nOTP6Yu2G30v3E+iJmO8s5LDmg69DHweyLj606Bvfuu08CAcpxsXad/ulUPjuJFDJwW8f0wctoCVEIyQTi+gbhjcwNX6mrBu8qXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZRoAsQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F545C072AA;
	Wed, 17 Apr 2024 08:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342486;
	bh=8HKqBkuK9XOWdikq79nMUvBa5Kdfk7JgGBOxMUWGla0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FZRoAsQzfVFPIVc8ShADl2wgyVlTUlAuauDMu+AU4uDigfkzruGEP9Zw80wdJqGdb
	 yGaR3smloupIqLZgQYWGY2xrslQI2lGibi8PlQRYs7QvyjtRUWpTIJMuR3y1UpnTsk
	 0yRQDwKtnU4jFZg7hsJax3OhVz7ViJr1B2m96//ci8I2hQbsQd0+0lWPqnAYcuLuQp
	 JPw3UHIJxHOjLPA5O1syNwCRdkuwIxMduP6lssRuCEsJr83R6c3SeY133iIRb64sj4
	 XrUVcqzU+71Qw64qK5gC0EbsgRsRp/o9hYHsuEtqtUGcv0mx4ib5EWPtEsX+8WZAWm
	 LDfVvJlhdAzzw==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Martin Kaistra <martin.kaistra@linutronix.de>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,  Jes
 Sorensen <Jes.Sorensen@gmail.com>,  Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: enable MFP support
References: <20240314164850.86432-1-martin.kaistra@linutronix.de>
	<fa903f58-2362-49a1-9880-2b3fcbe1869e@gmail.com>
	<5b3af47c-7efb-4ca3-93bd-06c682dfc84f@linutronix.de>
	<1cbb57c2-3d8f-4932-9132-d46a871c944b@gmail.com>
	<1e600703-1208-4adb-a486-2a770cff55ed@linutronix.de>
	<55d21b23c729465a9c5116cb2a9dc9f5@realtek.com>
Date: Wed, 17 Apr 2024 11:28:02 +0300
In-Reply-To: <55d21b23c729465a9c5116cb2a9dc9f5@realtek.com> (Ping-Ke Shih's
	message of "Wed, 17 Apr 2024 07:23:57 +0000")
Message-ID: <87v84gwfzh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Hi Kalle,
>
> Martin Kaistra <martin.kaistra@linutronix.de> wrote:
>
>> Hi Ping-Ke,
>> 
>> Am 15.04.24 um 21:14 schrieb Bitterblue Smith:
>> > On 15/04/2024 09:49, Martin Kaistra wrote:
>> >> Am 14.04.24 um 13:32 schrieb Bitterblue Smith:
>> >>> On 14/03/2024 18:48, Martin Kaistra wrote:
>> >>>
>> >>> Also, won't you send the patch to the stable tree?
>> >>
>> >> The rtl8xxxu driver previously did not have the MFP_CAPABLE flag
>> >> set. As I am adding new functionality
>> (support for WPA3), I don't think this should go to stable.
>> >
>> > Without your patch I can't connect to my phone's hotspot
>> > when it uses WPA3:
>> >
>> > Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: nl80211: kernel
>> > reports: key setting validation failed
>> > Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: wlp3s0f3u2: WPA:
>> > Failed to configure IGTK to the driver
>> > Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: wlp3s0f3u2: RSN:
>> > Failed to configure IGTK
>> >
>> > It doesn't say anything about WPA3 or management frame
>> > protection, just prints those unhelpful errors and tries
>> > to connect over and over again. To me that looks more like
>> > fixing a bug than adding new functionality. It's just sad
>> > that people need to install kernel 6.10+ in order to support
>> > WPA3, when the patch is so small.
>> 
>> I would like to know your opinion on this. imho this patch should not go to
>> stable and I would therefore propose to just send a patch to improve the checks.
>> If you as a maintainer however say, you would like to see this in stable, then I
>> will send a revert and a new patch.
>> 
>
> We have a question about MFP support to stable tree. rtl8xxxu never supports MFP,
> and recently we have a small patch (10+ LOC) to enable that. I feel we should
> treat it as new feature, not add to stable tree. But as Bitterblue mentioned,
> it looks like a bug. Need your opinion.

I assume you are talking about this patch:

https://lore.kernel.org/all/20240314164850.86432-1-martin.kaistra@linutronix.de/

I have no strong opinion here. To me it also looks like a new feature
but it might fall within "Serious issues as reported by a user of a
distribution kernel may also be considered if they fix a notable
performance or interactivity issue" stable kernel rule:

https://docs.kernel.org/process/stable-kernel-rules.html

Maybe go with 'Option 2'? That is, wait for the commit to go to Linus'
tree, send a mail to stable maintainers explaining the situation and let
them decide. But I would be fine with 'Option 1' as well, your call :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

