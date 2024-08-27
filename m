Return-Path: <linux-wireless+bounces-12071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E2961369
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 17:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64DABB22C8B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386AA1C6F5A;
	Tue, 27 Aug 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZZ7u2f1e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20364A
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774218; cv=none; b=mciHbGVf29N2+58Pvmfj+8G6uTfi2QUkEsCgGclUH8TuRKDRF2jjV10qOjhDdWYpA90HhpKYtGvzvQIKlhYsos8cbNderUgF/aho7uRSNjcy4yzwsXzOm3vh6tUAemjGd3On1EfYMZNeyBi5B8NKfWqKNxu+KjksnFjozjGIQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774218; c=relaxed/simple;
	bh=pgCHzt6Y0cMJ2Pevil3gY+QPZjwopUWKiYr0ptYka3k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z+ZHG4fydhGxzerCsshqVRKMZe1aRYzZChlcTru3O/s0fc2rhO6b+ObxmqqakSUnCkey83Ap641TReLuiLeQePk2cYWz/kZCUkzyl8tkv+y7NDV7UL3r5EJKuCzrHHJKCfZoc8fqPnGp0evRQFdWBYgJQ8SakwSlf3AOY/fP9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZZ7u2f1e; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oMlpNk/3oYYu+0JQsrcKC7pkmJbIAfM6XBbjgv6XNrA=;
	t=1724774216; x=1725983816; b=ZZ7u2f1eSmsHmUkTk84R1gxhqp2pnFZypLgzVr0yuDSBGwN
	7x7oRuxc9knSjv21yLmEwHcpXDVw/wf07R3py1Ftthp7EiNj8NfVBdP4JYQcZC/UqgGrbzodTHP7g
	dwTySibYsEd0ZVRU36jYVIsT1JO6sEv9lADo1y+7jN8+LWGpNru8zcnBRzoiUr3o3I+JTwhcdejK2
	CTofh0/cV4nefTCZzsUbLaDngshwDsQvvYutJzZQlHlyfpZt02wSFw4TI33nFOtMcfYuT3nmWkVMu
	Qno0IZlf/fj3M8IF350tnoeMvYqooECmrHaY9UWi+Fbpar0+Get1d57tjeWnvEaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1siyYv-000000050Zr-3f2X;
	Tue, 27 Aug 2024 17:56:54 +0200
Message-ID: <7ccb9c8ccb0dd16539ac064a35d6bf6b31d0bf0d.camel@sipsolutions.net>
Subject: Re: Per MLO link TX stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 27 Aug 2024 17:56:53 +0200
In-Reply-To: <c896c0d6-b43f-ba6d-336a-eca15c60529f@candelatech.com>
References: <c896c0d6-b43f-ba6d-336a-eca15c60529f@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-07-12 at 10:52 -0700, Ben Greear wrote:
> Hello,
>=20
> I've been trying to get better per MLO link stats.  I see that the rx pat=
h
> stats are there, but in the tx path, I do not see anything other than 'de=
flink'
> getting updated.

Yeah, nobody really cared too much about statistics yet. I know. Sorry.
Not much time to work on it either now.

> And, at least with iwlwifi, I cannot find any way to actually see what li=
nk-id
> was used to transmit a frame in the tx status callbacks (or anywhere else=
 I looked).

You can probably derive that from the band for iwlwifi, since it only
supports one active link on each 2.4 / 5 / 6 GHz if at all. And the band
I guess you'd get from the LMAC ID or something. Should be in there
somewhere... IOW, I think it's possible, but I'm also not entirely sure
how we'd do it.

> In the case where there is a single active link, then I can hack somethin=
g together
> that should be at least mostly right, but that won't fix any future radio=
 that can
> do 2+ active links.
>=20
> Any suggestions for best path forward on this?

I really think we also need to do some work on the API/cfg80211 level,
and have link station statistics in cfg80211 instead of full station,
and then combine them to (older) userspace in cfg80211, i.e. if
userspace doesn't request broken out per-link statistics. There's
probably a bunch of work here, and I only have a vague idea of how it
should be done...

