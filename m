Return-Path: <linux-wireless+bounces-9501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B65914AF5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 14:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7303F1C21FFA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CE913B2A5;
	Mon, 24 Jun 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etUcCmwu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91331137906
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233380; cv=none; b=peh43OhnrLMhYX8jAQIHcEKf4dCGB93nbbjFLnPV0oERx7+ZztSldyDOX97jm2azJG3NixslBAea00Hl1rQYa0RsEXuJVOvrvJ4OPw4bQ4e4+Bfy7Z06Q0Mu4sDPJhGah1qst4EfxO5x3RTxH6BTvOHVJ/iCgHbS2evFg9m3xTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233380; c=relaxed/simple;
	bh=QHMIKV+OMJshxzS1p9AfngEmc6LPOD9dDqtEtMpXq8I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=E32DW2OPUvsgWzQ/0z02tbcdZVxIGd1tlyNdpoXFOWmKt6rxNYOKcLKDpBb0k/RP1ZIaOayX9I5Cg0KyGHI90vK2PlGpckCimj6axoJQvpjxrdsUi5Gdf+w0KICIk4Ujj2cr2XVNBDRlboXK8Kp3HaqRmwnrIo1PUTeSHgjo4us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etUcCmwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE08C2BBFC;
	Mon, 24 Jun 2024 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719233380;
	bh=QHMIKV+OMJshxzS1p9AfngEmc6LPOD9dDqtEtMpXq8I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=etUcCmwuCjBBfZr6UL/fPvJKR+dywX+Lrq6LhGO/Wk6gPssR28kKD9mYZlRjC1ayC
	 pwyoVSQwSo9gX0PxYddzTAotMA5Xmw2O0yR3EO4/DV0MZFPEkF4n5giXBNqvZqgX9i
	 EDDxfyX/ZC/F97SxKdcwNrnBNwje0Nj0fhHOOvCCwZQfTbm4qTWCAdp2DcuItEqcmW
	 z3FygDpKjcUaZ/RATL/dNT4NlSQV+DWCQcbldZOL+C8l2V3DZGcoBQZ/OpNeSPt6Zc
	 3EP4lpL0pP6A8iWrbZDdjc+ZKPDTDP2kvbXzFItXGI6eSt/LHFex+Ptjjp4YkqmWM9
	 YjUBvlqF1PPNA==
From: Kalle Valo <kvalo@kernel.org>
To: "Peer, Ilan" <ilan.peer@intel.com>
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
  "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "Berg, Johannes" <johannes.berg@intel.com>
Subject: Re: [PATCH 6/7] wifi: cfg80211: Add support for interface usage
 notification
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
	<20240605135233.23d15e758640.I7a62740a6868416acaed01e41157b3c0a7a41b4d@changeid>
	<875xummndx.fsf@kernel.org>
	<DM4PR11MB60436A9107BCBC27294DBF22E9C52@DM4PR11MB6043.namprd11.prod.outlook.com>
	<87ed92nngq.fsf@kernel.org>
	<DM4PR11MB60435B5F50827F6ED8E8115EE9CC2@DM4PR11MB6043.namprd11.prod.outlook.com>
Date: Mon, 24 Jun 2024 15:49:37 +0300
In-Reply-To: <DM4PR11MB60435B5F50827F6ED8E8115EE9CC2@DM4PR11MB6043.namprd11.prod.outlook.com>
	(Ilan Peer's message of "Sun, 16 Jun 2024 14:58:59 +0000")
Message-ID: <87sex2ijz2.fsf@kernel.org>
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
>> >
>> > As depicted above, the need to inform the driver about the intended
>> > usage of the interface is real.
>> 
>> Sure, I can understand the need is real. This just feels like an ugly workaround,
>> not a proper solution.
>> 
>
> If you have a different solution in mind, please share.

Yeah, fix the root cause :)

>> And the documentation for this is quite vague, I'm worried how do we get
>> similarly working drivers? Let's say if I were to implement a user space
>> application for this, or a driver implementation for that matter, it would be a
>> guessing game for me. For example, what's "soon" in this context? 5 mins, 50
>> secs or 5 secs? Can the mac80211 operation sleep?
>> 
>
> I understand this is not clear. The intention was to say that by the
> time the interface is enabled,
> the interface type might change, and that the driver should be aware
> of that. I can try to better express
> this in the command and documentation.
>
>> So user space is now always supposed to always call this nl80211 command
>> and at what stage exactly? Or is it optional? But if it's optional what's the point
>> of adding it?
>> 
>
> It is optional. User space should use it when it expects the interface type to
> change before the interface is activated.

If this is optional for user space (wpasupplicant, iwd etc.) then the
driver cannot rely on it being called, no? So this command cannot be
used for anything important because it's optional. Also I'm worried how
this will give a different user experience based on if the user space
calls this optional command or not.

The way I see that this is designed just to workaround one iwlwifi bug,
not really as a generic nl80211 command which could be useful for all
drivers. But I'm more than happy to be proven wrong!

>> > We encountered several P2P cases in which an interface was added and
>> > P2P Group Ownership Negotiation and P2P Invitation signalling were
>> > completed successfully, but the P2P Group Session establishment failed
>> > since the interface type changed from P2P Client to P2P GO and the
>> > local device was no longer able to accommodate the P2P GO operation
>> > due to resource constraints.
>> >
>> > With this new API, user space can now inform the driver about the
>> > intended usage of the interface so the driver will make the resources
>> > available for all possible interface types. With this the information
>> > exchanged during the P2P signalling would correctly reflect state and
>> > the P2P group session would be able to be established.
>> 
>> Why not allocate the resources during driver initialisation? Or when changing
>> the interface? Why need this weird interface?
>> 
>
> Allocating resources to all possible interface combinations etc. is waste as
> not all allocations would eventually be used. 

Sure, in ath11k/ath12k we have problems with resource allocation as
well, for example how to allocate firmware memory (number of clients vs
size data buffers etc), and we really should find a solution for that.
Quite a few people are pushing for INI files to be able to configure
wireless driver resource allocation but I cannot see how that would be
accepted to upstream. It would be great find some type of dynamic
configuration solution for wireless drivers, for example devlink or
similar.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

