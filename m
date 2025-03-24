Return-Path: <linux-wireless+bounces-20774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE915A6E050
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367497A2ADC
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC8B263F40;
	Mon, 24 Mar 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G1D9CZ2M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB1F263F32;
	Mon, 24 Mar 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835419; cv=none; b=LqcJXjcxTlEwz2i6kGjb9jRSWpizHa68iruuynpIinjj1B47BIaahxv/zKIqaByx6psFHCNSDH5nTXzNH0hegzmI0mlk64agDsM1UPwaBRpPwsW/nbPmYHXg/exxvSMDTyS7che5m5xijGv4tCo3w3F8uhJBntOeG/ar0JKaB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835419; c=relaxed/simple;
	bh=NBMDGMVw/F08fRozTBwYk6nvUJhjfxb10Mdd3/IJ47Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiVxP50c2liNI8sEBfqaaK5Y3j6Wr3TOUfTJuRqoS2kI2H4sHqXpDfKnkNjkenndZFZabZldnXslPKx67LHp0KMZpSKXqIuUpxrHuy1m4ODyeIc4yVmhigsyTrS9Pqet/nOLr9NQhbymjjM73B/nl9za9thr9PslDTQcCI43Yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G1D9CZ2M; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cDAKR2ABNHmvbXxmGC+5wxMnHhjXDS2h7qeBTAVP7lc=;
	t=1742835417; x=1744045017; b=G1D9CZ2MKAURRYhnOu02Iuf4H6nLZoFHpgVrVktaDIhTgr3
	GBc1YFeruiuMhL2lRSH7Y32qFMpAw/CgRuhgXRciZBp19JhtKh/T69I3Fp1NsEexiHm0B+uSmxVYV
	bFtIPLDqvysER1Ubd1Y7E3ZG0YvG2uFlyqehZ78zOgachNTLnUs+8lgp0JavH4uh8TtLYgleLo17P
	hscQ6v39GnJotBo2EcYYNcOKdMXN7SuWBpPUVPygd0fA8XKj9iwyXmaQ0QjH/bROCJ2RCLqmFV545
	uAJpdQ8L4nPn79Kum15WlhxsjQf+7fecOtG3KA+Kfsy1UWUd7RNz5ASut8y+n3SQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1twl6b-0000000481j-3PFz;
	Mon, 24 Mar 2025 17:56:55 +0100
Message-ID: <db7a40f500c0b595bc2ee0f9524bacbc592dc72d.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
From: Johannes Berg <johannes@sipsolutions.net>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 24 Mar 2025 17:56:50 +0100
In-Reply-To: <CAL+tcoB3zku2EtLT2yJ9qPCSuN2=x-T-avqcZ-LJ2Q-mU5xLVg@mail.gmail.com>
References: 
	<20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
	 <CAL+tcoB3zku2EtLT2yJ9qPCSuN2=x-T-avqcZ-LJ2Q-mU5xLVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-03-25 at 00:53 +0800, Jason Xing wrote:
>=20
> Thanks for working on this. After net-next is open, I will use this
> bit to finish the bpf timestamping in the rx path :)

:)

> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -481,9 +481,6 @@ enum {
> >         /* reserved */
> >         SKBTX_RESERVED =3D 1 << 3,
>=20
> It might conflict with the bluetooth commit [1], I presume.
>=20
> [1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blueto=
oth-next.git/commit/?id=3Dc6c3dc495a6ce5b9dfed4df08c3220207e7103bd

True, just context though, we can deal with that.

> >=20
> > -       /* generate wifi status information (where possible) */
> > -       SKBTX_WIFI_STATUS =3D 1 << 4,
> > -
>=20
> Better use SKBTX_RESERVED. No strong preference here since I'm going to u=
se it.

I can't have two called SKBTX_RESERVED, but I'm not sure it's worth
renaming it rather than removing? No strong opinion though. The context
conflict will happen either way ;)

johannes


