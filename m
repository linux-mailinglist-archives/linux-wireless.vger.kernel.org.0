Return-Path: <linux-wireless+bounces-34898-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEQJHykQ4WnoogAAu9opvQ
	(envelope-from <linux-wireless+bounces-34898-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 18:36:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3889411C1E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 18:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A996C300794F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2173130FF1D;
	Thu, 16 Apr 2026 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b="lRa3qkpR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.bues.ch (bues.ch [116.203.120.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36101AAE17;
	Thu, 16 Apr 2026 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.120.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357389; cv=none; b=R+H1CYr5y52KtLXPlzLYLUZSkfTXBzWU+PGdy1BwL2OJiBcJD5oQoU+G2HAB+5p6Jcgw+O6UYzsoWm8/G3tOfPaGh3OYwsOV4oH2GbyUEr6JTF8K9s5wl2qE6mbIOGX7FhEpEtl3ps9zd9xxyWQBtvkYqsSOlXuufi104F5NghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357389; c=relaxed/simple;
	bh=VOWrk46xqXuyRiulOFPS616GuflsxbK0g6eCamz83EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFliLzfh5kVTEnkyV9/b6l2RxiXgxwrICc1oAATtbjr6xvn8DQ30N2NxHGDTe6aRaLYViK8bddCgA7i0qO4mysRk8OdaSFbDlV9sY4lfWWhRj+Zu1eVY+5wARoJ+2UVz1zBKI4ej1Q3HonJJHaYhwoKgupdJ2BoTFIhwW1oarY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b=lRa3qkpR; arc=none smtp.client-ip=116.203.120.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Date: Thu, 16 Apr 2026 18:35:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bues.ch; s=main;
	t=1776357377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q3CDEh1VgXgv3KOhGWKV0nNIAi6Fa7Zf71mDyzP+GSk=;
	b=lRa3qkpRGG4ugG7ZRqg+lHrvlF84X+IXDvAFPnvgIJ1yOxEkGz01f8/4Qvv1HkbdU0PvoQ
	3LSvx1Y/Av0nSL8537YMz7pbEacBmMspL8dgerZuKlvMDUrxbBLv+mTMLdh/b2jxCDbkro
	5jTE1pCKtQMeW/Tf21GeZScz5aDA9fAdCYRkov7Jz8MoOI4s7KIjpcrWa7SkXf6v6QxRxa
	vj+gXEb9STgVsAZPQ+PQvt6rFM0J+ZrIrptmf5MlXn4tYSl4oFmHsTYxIHxEOEfhQ1fzSQ
	Uk7QrwqbHGbAf6HKEVfe2aw4lefkEpfKa7znHds0yFMQhuwCn6YYmFQ4jW1axA==
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Tristan Madani <tristmd@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: b43: fix OOB read from hardware key index
 in b43_rx()
Message-ID: <20260416183554.7add6b06@barney>
In-Reply-To: <CAOiHx=kpVH3jq_XuDKp==13yNx1AMcvVaRe4R2-bScOo5otMaA@mail.gmail.com>
References: <20260415222425.1544638-1-tristmd@gmail.com>
	<20260415222425.1544638-3-tristmd@gmail.com>
	<CAOiHx=kpVH3jq_XuDKp==13yNx1AMcvVaRe4R2-bScOo5otMaA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//0vg=Mq815_JCc8zFztXnZk";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bues.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bues.ch:s=main];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-34898-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[bues.ch:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m@bues.ch,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bues.ch:email,bues.ch:dkim,bues.ch:url]
X-Rspamd-Queue-Id: E3889411C1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Sig_//0vg=Mq815_JCc8zFztXnZk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Apr 2026 08:34:11 +0200
Jonas Gorski <jonas.gorski@gmail.com> wrote:
> > diff --git a/drivers/net/wireless/broadcom/b43/xmit.c b/drivers/net/wir=
eless/broadcom/b43/xmit.c
> > index XXXXXXX..XXXXXXX 100644
> > --- a/drivers/net/wireless/broadcom/b43/xmit.c
> > +++ b/drivers/net/wireless/broadcom/b43/xmit.c
> > @@ -704,7 +704,10 @@ void b43_rx(struct b43_wldev *dev, struct sk_buff =
*skb, const void *_rxhdr)
> >                  */
> >                 keyidx =3D b43_kidx_to_raw(dev, keyidx);
> > -               B43_WARN_ON(keyidx >=3D ARRAY_SIZE(dev->key));
> > +               if (keyidx >=3D ARRAY_SIZE(dev->key)) {
> > +                       b43dbg(dev->wl, "RX: invalid key index %u\n", k=
eyidx);
> > +                       goto drop;
> > +               } =20
>=20
> B43_WARN_ON() returns the condition's result, so if you keep it you
> can shorten this to
>=20
> if (B43_WARN_ON(keyidx >=3D ARRAY_SIZE(dev->key)))
>         goto drop;

Acked-by: Michael B=C3=BCsch <m@bues.ch>

Please also check the b43legacy driver. It may contain exactly the same cod=
e.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_//0vg=Mq815_JCc8zFztXnZk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmnhD+oACgkQ9TK+HZCN
iw4+gA/9Ff2iU8x3O005D+JjdnNz/4hJt9UxhdmH+177BDDCD9R4F7nsEKqynN+1
cecA+FYiPkR8LeaesdIjK9FiI3mVilHKPEBNJzRRzCld+mvkOQXQBJ+ElshKXVZW
oc1g5tBlIs16vZjzdBnSagJNrkwV1jKxLwvSjgGdIGhh15nIGZkBO+ZydIpSEUUY
/83voqDUPsQuLx8OyQpuf6ehmpe//vuTBN79CuNhFN/V6Aja96Lz10LgzfmUYaW4
Wti6/HL83pEeWaBGbFJMOFisgJrHbbsJlZphKRI/FqV7+Mj0Mr7euRmg+jE3W5Tu
lzC13gB3FKIy0Mqq8gwwDVrQllHZ9bvkWBAcXy6mWoc7rZrRqB08pR6F+Sfnsrrc
7nvk7q+2RknOPOr6vMNnu4wksXsMoL99UGN8u7ux6Wb7hGmuPO7dLveyUe6yzWdc
0nv9YBjOH64sItAfDIovpX4meEU32uvP/BDk9cMl7QcyuCTzg1Mkh9c6ksBP9b/z
+eYdx7H+qeopuEZ+o4PymRV2uoMzryQKTFaEP1icjBPgwVCMD4KrPslPopb2yase
99k04lggNYkCnrH6QF4+gIEBSwj24Bt8sveFcnOCb94vEakXLWLN313ZOjhhC8a2
mV6IQq6EwQJcy+LE+mHd+Ew6HkFFCg9TXvvvm7+rA/4bYj1PKaE=
=0xKO
-----END PGP SIGNATURE-----

--Sig_//0vg=Mq815_JCc8zFztXnZk--

