Return-Path: <linux-wireless+bounces-3276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7984C71F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 10:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409BE284AE8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A02376A;
	Wed,  7 Feb 2024 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eluqGIJm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA723766
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297555; cv=none; b=nI1YqqqxbD1ve+qo8U+C84MCY3an2C6tsE2EmXtbe/WhzSDwnbtuX0000DugDK8LU1lDc5di34OLSYnbHpvAN1qwFWktAaThrQljQdSNFWSlewS8GH88HHms9JZM4L5+ZxWa5wFxtu7Vp4NxRJwdngHiNsrAE7acXwVaR6/PZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297555; c=relaxed/simple;
	bh=Cut9LWt+2/3OWLPgtzP6Xr9K4J1ks5L1UhObNIN4+jE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VasgUItcMhPLLw8RDz6sd7dyBZ0NI57L9ICQ0iN/Of2LEjIyjCFac0epQ84VDe1LjTFbgDGSyp6LMjfzjrC/9job8+IC07ArdREYrW5O6evlx0Ogty6jaIQYHyQEFwm2rMQZhl9HlBDkbVBVb7jGqwVYUdTXehrfor0WTONluOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eluqGIJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D01C433F1;
	Wed,  7 Feb 2024 09:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707297554;
	bh=Cut9LWt+2/3OWLPgtzP6Xr9K4J1ks5L1UhObNIN4+jE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eluqGIJmvQG518cOLj7cST5d5xP7d++ptwXSodAwyb6N5S1Fqo0e+TWrw0MAnNYWA
	 DwF4wobrlYq6ZXJw3AAifipCpnhT04TU7f8vgZCaoZfKIJ4M6hiMbrqoHfmiMpOKiZ
	 GaozoyzZT6N37PnSyfBZd6Co3v9j3oHRe922zqayfHrUwrnSbSVCi+JGegJKBsfyww
	 zcfTxkkW+Cel9/iV5iUQQLQyTenGxgtoXibMNi0kaqxFpulxRZAeyWZLkKmimqu6uH
	 EnF0HOET7dNz35nsqb1h0rXMWL1IdywwejbqUDtD4YQTbAk6aum5/cXrqicZa5eaj1
	 Hm9H/KIW7vrPQ==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sergei Trofimovich <slyich@gmail.com>,  linux-wireless@vger.kernel.org,
  wireless-regdb@lists.infradead.org,  Chen-Yu Tsai <wens@kernel.org>,
  Seth Forshee <sforshee@kernel.org>
Subject: Re: wireless-regdb key change broke crda tests after 37dcea0e6e5
References: <ZcIXGjzrZrXPCBcp@nz.home>
	<455bafff0d609eb182ba30a5fbf319888e0e961d.camel@sipsolutions.net>
	<20240206222757.238a24f8@nz.home>
	<240506b19c6671cfce2587f4c1152359066146c7.camel@sipsolutions.net>
Date: Wed, 07 Feb 2024 11:19:11 +0200
In-Reply-To: <240506b19c6671cfce2587f4c1152359066146c7.camel@sipsolutions.net>
	(Johannes Berg's message of "Wed, 07 Feb 2024 08:58:34 +0100")
Message-ID: <87v870hbsg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2024-02-06 at 22:27 +0000, Sergei Trofimovich wrote:
>> 
>> Great point! `nixpkgs` uses `crda` only as a `hostapd` depend and
>> looking at modern `hostapd` it does not use it at all. I'll spend some
>> time removing it downstream. Thank you!
>
> Note that hostapd never directly depended on crda, it just needs/wants
> it to have the correct regulatory information in the kernel (crda puts
> it there) after switching the country (hostapd can do that if possible)
> and then hostapd retrieves the information.
>
> But in any case, the whole step with crda is no longer needed if you
> have the regulatory file (and possibly signature) in place, the firmware
> will load them as firmware files.

I assume you mean: the kernel will load them as firmware files.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

