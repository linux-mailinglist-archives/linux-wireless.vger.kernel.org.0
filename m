Return-Path: <linux-wireless+bounces-3534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A88530D9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8D6B22B00
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 12:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA5A3FB38;
	Tue, 13 Feb 2024 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYFZEM9G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0F482C5;
	Tue, 13 Feb 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828423; cv=none; b=oxbRbGriiPHmgHwn0cauUZWGbQK9b3JR7TUPU+CaW8+QQ1tnUY5u+Jm3t7y0pv1buDb0Asn3a6by/6qYB9CCYHWKwlc+rH7JePFZJjVDlPuqve5ocU/PQWeb01WRcJDeTkbDxPxL29HCXZm+8uLoH/Vxok/hmztpJ7Ao6NDVnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828423; c=relaxed/simple;
	bh=ibiGJboJTfQ6hkBcMBe0/M8209wHG/L69hcfvadoVPM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eUhiXyR/dV9DclgyMLWJhFaafgCD/f5iyRHL5tHBwVViZqr5Bin4nVQHPxTEcas8FkTymNP2R0M8a2TRUdESnlaPxw5PpP1qx00GH/0py4Z6/zkxTHJ2tPdIe86DyVfZmGlj+zpbQ/82Avsbmc+TEkuRs/QnQY7By2M6bOIV5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYFZEM9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4084CC433C7;
	Tue, 13 Feb 2024 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707828422;
	bh=ibiGJboJTfQ6hkBcMBe0/M8209wHG/L69hcfvadoVPM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BYFZEM9GTodP4AbhNpUupzuajOUW6p2yyPLZ+8CX/X8COQBZBjo71arQBWjQoXmXw
	 sxByx7TUCPKZbezAybecmkluELHlsTozmKHOMD41azTRdF/QCCTUhX67O2HnDKG/Sf
	 fGmdTpiSzz8Al7V3OKPOF/lnUBXnK0JPW8lJqhw8oxP1r+Cl0IBW7BozrFjCjzqNIJ
	 /kQNDoXlmWNiLb5YFraRX+CLW+TIU/f0yCpV530HYd+35MUUAdQQBkjdYHUqvfgh38
	 s4igZWvuVBlp80uCCm52UtpZwgDZn4uRycrs0EmNgKJ+D28VPCBcGBU8ZifwsNX28Q
	 oNxBNDdyWwwIA==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Vinayak Yadawad <vinayak.yadawad@broadcom.com>,
  linux-wireless@vger.kernel.org,  jithu.jance@broadcom.com,  Arend van
 Spriel <arend.vanspriel@broadcom.com>,  netdev@vger.kernel.org,  Jakub
 Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
References: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	<87mss6f8jh.fsf@kernel.org>
	<2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
Date: Tue, 13 Feb 2024 14:46:59 +0200
In-Reply-To: <2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
	(Johannes Berg's message of "Mon, 12 Feb 2024 20:58:51 +0100")
Message-ID: <8734twfs58.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> So looks to me like Broadcom doesn't want its (real) drivers to work in
> upstream, so I guess we really ought to just stop accommodating for them
> in the wireless stack... This only works if we collaborate, and I've
> said this before: I can't maintain something well that I cannot see (and
> possibly change) the user(s) of.
>
> I guess if Broadcom's plans change they can start by submitting drivers
> that actually use the relevant infrastructure.
>
> And note that I've said this to Qualcomm before: I don't really want to
> and can't (well) maintain a lot of stuff in the tree that exists there
> solely to make out-of-tree drivers happy.

Yeah, we need to make a hard stance here and solve this "throw patches
over the wall and run away as fast as you can" model which corporations
use. If kernel.org wireless is important for you, or your company, then
help us! Don't just expect that we do everything for you, that doesn't
scale.

> And @Broadcom: we really _want_ you to contribute upstream. But that
> shouldn't be dumping APIs over the wall when you need them and letting
> us sort out everything else ...

A practical tip I can give to Broadcom is to remind that you have a
great engineer with upstream knowledge: Arend. I recommend utilising him
and asking for guidance anything upstream wireless related. Even better
if all the code coming from Broadcom would go through him.

And thenever you add a new feature to the stack, add support to
brcm80211 driver at the same time. This help Broadcom to get the feature
you need to upstream and the upstream community would have a better
Broadcom driver.

Arend, sorry for dumping more work for you :D

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

