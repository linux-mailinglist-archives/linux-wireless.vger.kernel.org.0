Return-Path: <linux-wireless+bounces-25848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE053B0D800
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 13:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFCC47AF716
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7DA289811;
	Tue, 22 Jul 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BVhO6f6l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E101D53C
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183044; cv=none; b=mR9n33ensKG6vX8i86tq7bs7kZmcrRqF7mBMFbs6XgNT2fMPFik9k0lYlF4OkpyfpvhK01+tA9bPw3+9/5/Tvz0Zwt6xmoDecEg2qqHjSk96wYpV9tcvC27H2Z3TwaOgZeF8tnyii4rs+uAIWdzAfAsH34XaiKnWdel2i0yi3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183044; c=relaxed/simple;
	bh=fZuIqUx+jvOgB+3IxsdjQk0NXxK6Pz7CHKy1RsT79+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxvLieerPl3z26NTey92u9lM7Uw5uZMLSHiJT+ZWFD2uYXA67lGkyVlrLoPgpk+znnPh+nkLtlMFu+S8AwluDZKZhCgRXRhjNiUz7kl51jbivqoVPk8zRkgYUFHJCCyLgge9z8SoDYgNd7nHF6+DqfKOxsgvvcr3bXWN7PxeLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BVhO6f6l; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fZuIqUx+jvOgB+3IxsdjQk0NXxK6Pz7CHKy1RsT79+I=;
	t=1753183043; x=1754392643; b=BVhO6f6l1n7JAQn4GI76Q+sR6sfmNFKimwD7BASotwLX5HD
	KqFpNXYmHwxLzhpEqWeJMzO2B7wlKwmjcWxKVjV7UqUFffo7LNo8/jrFgBXa4GquU304rqGTn8poP
	+0XarJ6Ft0UNqe+ENoySBjgjVtHA/bGqsO3o49zBA4L9bDoom2pnx0aD+c3aU7Ai9gMTpuJHZAcjx
	xBmN3S4/j/6pwMXjqjXCVCNV+IQ5leCI2iEzCWBzfShtiMU7ZX/tYSlQjzY55RZqAxUr6UYXNtJ01
	5rcc9Fntgo7N6SHA/KOI4hlulWvE5CfFmUa2r3PARrCnAte0w6rEIUjBQlM1YHMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueAzo-0000000225A-43ZD;
	Tue, 22 Jul 2025 13:17:21 +0200
Message-ID: <fdc3952f8e70263fa0703d7742d235d31160eae2.camel@sipsolutions.net>
Subject: Re: [wireless-next 1/2] wifi: mac80211: support encoding S1G TIM PVB
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 22 Jul 2025 13:17:20 +0200
In-Reply-To: <20250722071642.875875-2-lachlan.hodges@morsemicro.com> (sfid-20250722_091728_659585_C991C363)
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
	 <20250722071642.875875-2-lachlan.hodges@morsemicro.com>
	 (sfid-20250722_091728_659585_C991C363)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-22 at 17:16 +1000, Lachlan Hodges wrote:
> An S1G PPDU TIM PVB (Partial Virtual Bitmap) follows a different
> format to non-S1G PPDU's. An S1G TIM PVB breaks down the contiguous
> AID bitmap into encoded blocks and only sends an encoded block if
> there is at least one AID with buffered unicast traffic.
>=20
> An S1G PPDU TIM represents groups of AIDS with an array of encoded
> blocks. Each encoded block represents 64 AIDs and is only present if
> at least one AID within the group of 64 is present. Each encoded
> block can contain 0 to 8 subblocks, where each subblock represents 8
> AIDs. Similarly to the encoded blocks, sublocks are only added if there
> is at least 1 AID set within that subblock. If a subblock is present,
> the subblocks bit is set in the block bitmap which precedes the
> sublock bitmap.
>=20
> As page slicing is currently not supported by mac80211, we limit the
> S1G max AID to 1600. This is due to the fact that the TIM element has
> a maximum length of 255, such that we have DTIM count + DTIM period +
> bitmap control =3D 3 bytes, leaving us with 252 bytes for encoded
> blocks. Each encoded block has a maximum size of 10 bytes (assuming
> every AID is set) leaving us with 25 * 10 + 3 =3D 253 bytes.

Looking at the spec, this seems like a bit of a simplification, since it
also allows for "Single AID" and "OLB" modes, where I think this only
covers "Block Bitmap" mode?

> Correctly encode the S1G PPDU TIM PVB utilising the TIM bitmap.

No argument there though, the transmitter doesn't _have_ to use the most
space-efficient encoding.

johannes

