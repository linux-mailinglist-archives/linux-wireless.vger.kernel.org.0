Return-Path: <linux-wireless+bounces-8889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B8C905894
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB0A1C20400
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8F181B87;
	Wed, 12 Jun 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BekjCp3W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784E18133A
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209145; cv=none; b=b0NhAEwk4xzlEbLFQFicyT0dW+sYrh1XPNct54aUrt++3g9htT1Aa1uxAGBPgcPL4OBhEBxpGg88RgY/ppGjhpXBJiS2ptrqQ6yXVVjHYm8neug7o0cgJl12WdEeKAH2QecYeSl6s+PMjTjLQHG7iMlCV/25mFiMKleNWBsNFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209145; c=relaxed/simple;
	bh=xTODCO3Xxhe6CnYM9IeMSAyicX7oEntJ/H4ne4NuHSI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eh2PJRsyEvJI+i6En/R60uZCOq0Y6w9FNoNDtUhAoWUQR56R7rkK7YW+SfJ+bchpYzlx8G9G8cXvc7ygDHo9KXtYu+c+UHb8XuzwZQ7VyBy/Ayfmh2CGOPwUk5KzKzlM2vr6kwGbsKGHXVA7Dg66HCGNtcmedGCuLK1sje0CuYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BekjCp3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E3BC32786;
	Wed, 12 Jun 2024 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718209144;
	bh=xTODCO3Xxhe6CnYM9IeMSAyicX7oEntJ/H4ne4NuHSI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BekjCp3WXmFFYqat9VCVup7d2Ds0OWrha4P89LzYk6JyZ1femQMWpHzc6qGxuKZ1I
	 8zRTZPglsm7MreyXZQ1UHpqAtLpIssplIwudC+SQINfXDxw+yMiYedYwPNIFauUDhF
	 pMQbIx7MC1siXWqZC2fDoql0i7Q7AqiQnDZs4UVxyx0pNCbSdcngosUKtsBzR3dg7V
	 1dRkmvM6uwt5zjXlF05zRGtml4MOy8P95kxmiZESDWVxbk/7wdSydEyb4VTrLUgf4b
	 i7H9HRvB0AJtevUtHAaPwYWxD9Dhi3zecibMnAcgvAuq3bAgdBZHnoYGlISf9ug74B
	 KzpeGeu3HG09w==
From: Kalle Valo <kvalo@kernel.org>
To: "Peer, Ilan" <ilan.peer@intel.com>
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
  "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "Berg, Johannes" <johannes.berg@intel.com>,  iil_jenkins iil_jenkins
 <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Subject: Re: [PATCH 6/7] wifi: cfg80211: Add support for interface usage
 notification
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
	<20240605135233.23d15e758640.I7a62740a6868416acaed01e41157b3c0a7a41b4d@changeid>
	<875xummndx.fsf@kernel.org>
	<DM4PR11MB60436A9107BCBC27294DBF22E9C52@DM4PR11MB6043.namprd11.prod.outlook.com>
Date: Wed, 12 Jun 2024 19:19:01 +0300
In-Reply-To: <DM4PR11MB60436A9107BCBC27294DBF22E9C52@DM4PR11MB6043.namprd11.prod.outlook.com>
	(Ilan Peer's message of "Sun, 9 Jun 2024 07:35:07 +0000")
Message-ID: <87ed92nngq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Peer, Ilan" <ilan.peer@intel.com> writes:

> Hi,
>
>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Thursday, 6 June 2024 12:28
>> To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
>> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org; Peer, Ilan
>> <ilan.peer@intel.com>; Berg, Johannes <johannes.berg@intel.com>;
>> iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
>> Subject: Re: [PATCH 6/7] wifi: cfg80211: Add support for interface usage
>> notification
>> 
>> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>> 
>> > From: Ilan Peer <ilan.peer@intel.com>
>> >
>> > In some cases, when an interface is added by user space, user space
>> > might not know yet what is the intended type of the interface, e.g.,
>> > before a P2P Group Ownership Negotiation (GON) an interface is added
>> > but only at the end of the GON flow the final interface type is
>> > determined. This doesn't allow the kernel drivers to prepare for the
>> > actual interface type, e.g., make resources available for the
>> > interface type etc.
>> >
>> > Generally, adding an interface doesn't necessarily imply that it will
>> > actually be used soon, and as described the interface might not be
>> > used with the type it's added as.
>> >
>> > This new API allows user space to indicate that it does indeed intend
>> > to use the interface soon, along with the types (of which the
>> > interface must be one) that may be selected for that usage. This will
>> > allow the underlying driver to adjust resources accordingly.
>> >
>> > Signed-off-by: Ilan Peer <ilan.peer@intel.com>
>> > Reviewed-by: Johannes Berg <johannes.berg@intel.com>
>> > Tested-by: iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
>> 
>> This new command just looks weird to me, do we really need it? I would
>> expect to see a workaround like this in out-of-tree drivers but not in upstream.
>> 
>
> As depicted above, the need to inform the driver about the intended
> usage of the interface is real.

Sure, I can understand the need is real. This just feels like an ugly
workaround, not a proper solution.

And the documentation for this is quite vague, I'm worried how do we get
similarly working drivers? Let's say if I were to implement a user space
application for this, or a driver implementation for that matter, it
would be a guessing game for me. For example, what's "soon" in this
context? 5 mins, 50 secs or 5 secs? Can the mac80211 operation sleep?

So user space is now always supposed to always call this nl80211 command
and at what stage exactly? Or is it optional? But if it's optional
what's the point of adding it?

> We encountered several P2P cases in which an interface was added and
> P2P Group Ownership Negotiation and P2P Invitation signalling were
> completed successfully, but the P2P Group Session establishment failed
> since the interface type changed from P2P Client to P2P GO and the
> local device was no longer able to accommodate the P2P GO operation
> due to resource constraints.
>
> With this new API, user space can now inform the driver about the
> intended usage of the interface so the driver will
> make the resources available for all possible interface types. With
> this the information exchanged during the P2P signalling
> would correctly reflect state and the P2P group session would be able
> to be established.

Why not allocate the resources during driver initialisation? Or when
changing the interface? Why need this weird interface?

For easier reading below are all the patches, including the iwlwifi
patch. Honestly, this just looks like something like a workaround for a
problem in your firmware or something like that.

https://patchwork.kernel.org/project/linux-wireless/patch/20240605135233.23d15e758640.I7a62740a6868416acaed01e41157b3c0a7a41b4d@changeid/

https://patchwork.kernel.org/project/linux-wireless/patch/20240605135233.4d602acf0e65.I01fecab3b41961038f37ca6e0e3039c5fe9bb6bf@changeid/

https://patchwork.kernel.org/project/linux-wireless/patch/20240605140556.21582e74a0e0.I7c423d03b4412d77509bd31bd41e4573f76c0e84@changeid/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

