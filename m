Return-Path: <linux-wireless+bounces-38778-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IMp1FqHaTWq4/AEAu9opvQ
	(envelope-from <linux-wireless+bounces-38778-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 07:05:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C64721B37
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 07:05:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=Nr+1f+M9;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38778-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38778-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 103953016D18
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 05:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7D3ACF0B;
	Wed,  8 Jul 2026 05:05:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDDC3B7777
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 05:05:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487131; cv=none; b=q7RJAcjbbOZ2x7PwfkjPQ5qC29OmNQpoUNcLB3SisaBnyrj8EJu6hBy+nN+1G9DWrAPNNe9kf/GIpw9LtpJqSTJMG8X5eRNkkp29Bcia/FkR7Y9QJWUwEIRwyJf9HKDxXNr0YUKAEh9X5pjvAbhmuAYfYxnsqnQKCBEMCJ1yIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487131; c=relaxed/simple;
	bh=A5EH4vrpCYxkHq9d3wTWMZ1A/AycKXK0ePR/KubP8MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chD6daATCyGWDMvzFnlkTGT9nzGZqNW3aKQcZcr7teox/+X+z8jEIBOdRRYpPRlGQhOkiBtaQhdQiuKmS6lfQJla8ktr3d+Xv1Z2UKPCjxcj2f/IJ1NbdhGR6YLPwiXwNhYU0o2PYMn47mJgh7WIIrx6aEnDqdNX7LRh9ufitf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Nr+1f+M9; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b691cb44so1229155e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 22:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783487126; x=1784091926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2bRMxPUxBcXrhb0PApy6D/IVMbVi3E/LkCHcDJDbkO0=;
        b=Nr+1f+M9jHTQu372R03NlEyMtbyRXt41oHGfE4XxwYQIMKaMKnWrxYk3Bmr9sTPtoy
         xO/69O1l7kyb4+Ao5IrGiXu9GXxIjm8W08aiuRKiqUZgQUhVrsAckppKxcswptvwq5RL
         p07oywDpRg3T8Wn64lkVxlq34PEcGdstgN6EMTvu3MktVFlf7tB56soXK3YsapKkGNf2
         aBXGHlHw85EyeJ/7Zj9UlaaYcyoW+WikBUISxJmNBfyUO7SJtYBQPv71+g+pLmiNw4be
         icIGUF0925R1kKZTjvBhDZK4ZF9oyVVFoP9QbVwGCePyGkTq3whTuExRLearv1d6s1Q2
         270g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783487126; x=1784091926;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2bRMxPUxBcXrhb0PApy6D/IVMbVi3E/LkCHcDJDbkO0=;
        b=Zh6Jk5icuAmXrhW4jjz8MvwVxUE2PIdWAzGd7iP7SfP9w+zyaWNCwFGebIOucPk2BN
         0Cs9HLF+pnoFWEB4NVgYOcdO1RklHCwNYBcQRFCjEIiPxjdMXfqKQxoehCqkw91pz1I5
         MTLIc2EGUImQ20yWMIeF807BfPaGUNxn6av7nY5L/Foz+7LiwjaFdR3xHiVhR+uBe4FR
         2mIrynLsaZ+no1NWevwe3E2SC03dGmwwLN3aa5L17hAglanE07yoRvnMBhDgd8GsvOmz
         nswR5v5ITzrTNt/8YFnlgJqOI+6q8FIOetXDRbSj14W41ltLBb2V1wD49O37K5ebMOUi
         hpUw==
X-Forwarded-Encrypted: i=1; AHgh+RqUeWmiSwpOZowylEjrDTcKUbxadezBw/KKGobXssTeZt0yhVbqkYS+GEiYGGNNqF9pCCBPEvfPP9ERPiXnDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCubrntsnuZ1PdbBFOkOi42csHA+ZvZ5wYEQJ7QPHMnN+ONud5
	4vi9pwKiJARr4Ors2pMoAvuGteAF5OrUzxA05XAxNJNDpp3nnEzfR1QU4mzbJg5hfQY=
X-Gm-Gg: AfdE7ckzh6U3V/+2F4LWJeECQWwlfHVI6cMyLWTf4R9gxO8J5ctTRcuiT/uDAjVlN5h
	MPukbzW1ilNVhx42AjtNzXSY8uaoiAKb1gM0Hk0FSW0V+iZisKVq1xuPcxdojh14NhiM1Smz61M
	E8EzMCH0UPzKOWeB+mu+41R1zU9Owk77cdWsyWdo8HBhUtCqTip6Mf47NaimAqFKtl8XqDt7Y0x
	NwwtP7fAIhyuoUG+9KnX8Q5ZdC/UzKzfccUO+pWXkULM14rCCc/cYYI9hiiDNfCOZPgPdkjz+LO
	nTxxg9m6eTvcMBr2VoXF4wcd8y/NBW83PLK18mBXL8zDd3pjY7bi498RYowWbjAqGQTWs3JgBll
	R4dXIaVxBFJcmLllGAayAJZLmPAwJIz0ig8fBXTC+thq2ySxwSVETHSR2gdE3LIcp8fTN+oUXrW
	+oNniecvRH8K63D/E2Bg==
X-Received: by 2002:a05:600c:4fd4:b0:493:e3ea:b23f with SMTP id 5b1f17b1804b1-493e6861ac2mr6417425e9.10.1783487126073;
        Tue, 07 Jul 2026 22:05:26 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493e0f5bc78sm131093755e9.14.2026.07.07.22.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:05:25 -0700 (PDT)
Date: Wed, 8 Jul 2026 07:05:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Heidelberg <david@ixit.cz>, Mark Greer <mgreer@animalcreek.com>, 
	Simon Horman <horms@kernel.org>, Tomasz Unger <tomasz.unger@yahoo.pl>, 
	oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v1 07/12] nfc: Drop __maybe_unused from of_device_id
 tables
Message-ID: <ak3YSbzhmHi75INN@monoceros>
References: <cover.1783091699.git.u.kleine-koenig@baylibre.com>
 <031ea0ae38838df3261f844eb13e9841769b49a7.1783091699.git.u.kleine-koenig@baylibre.com>
 <c5b1dec1-de39-4359-9cee-86cfac87b358@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="khemwuvx25deahm2"
Content-Disposition: inline
In-Reply-To: <c5b1dec1-de39-4359-9cee-86cfac87b358@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:david@ixit.cz,m:mgreer@animalcreek.com,m:horms@kernel.org,m:tomasz.unger@yahoo.pl,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-38778-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ixit.cz,animalcreek.com,kernel.org,yahoo.pl,lists.linux.dev,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,monoceros:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1C64721B37


--khemwuvx25deahm2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 07/12] nfc: Drop __maybe_unused from of_device_id
 tables
MIME-Version: 1.0

On Tue, Jul 07, 2026 at 07:28:57PM +0200, Krzysztof Kozlowski wrote:
> On 03/07/2026 17:46, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> > Referencing these arrays in MODULE_DEVICE_TABLE() is enough to convince
> > the compiler that they are used even if the drivers are built-in (since
> > 5ab23c7923a1 ("modpost: Create modalias for builtin modules"). So the
> > __maybe_unused marking can be removed without introducing a compiler
> > warning.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
> > ---
> >  drivers/nfc/nfcmrvl/i2c.c  | 2 +-
> >  drivers/nfc/nfcmrvl/spi.c  | 2 +-
> >  drivers/nfc/pn533/i2c.c    | 2 +-
> >  drivers/nfc/pn544/i2c.c    | 2 +-
> >  drivers/nfc/s3fwrn5/i2c.c  | 2 +-
> >  drivers/nfc/st-nci/i2c.c   | 2 +-
> >  drivers/nfc/st-nci/spi.c   | 2 +-
> >  drivers/nfc/st21nfca/i2c.c | 2 +-
> >  drivers/nfc/st95hf/core.c  | 2 +-
> >  drivers/nfc/trf7970a.c     | 2 +-
> >  10 files changed, 10 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
> > index 66877a7d03f2..687d2979b881 100644
> > --- a/drivers/nfc/nfcmrvl/i2c.c
> > +++ b/drivers/nfc/nfcmrvl/i2c.c
> > @@ -245,7 +245,7 @@ static void nfcmrvl_i2c_remove(struct i2c_client *c=
lient)
> >  }
> > =20
> > =20
> > -static const struct of_device_id of_nfcmrvl_i2c_match[] __maybe_unused=
 =3D {
> > +static const struct of_device_id of_nfcmrvl_i2c_match[] =3D {
> >  	{ .compatible =3D "marvell,nfc-i2c", },
> >  	{},
>=20
> This (and probably others) should re-introduce warnings on !MODULE and
> !OF builds (and other cases).

With an x86_64 allnoconfig and just the things enabled to make this
driver build (i.e. I2C and a few NFC related switches, but neither OF
nor MODULES) the driver builds fine even with W=3D1. If I drop
MODULE_DEVICE_TABLE() the warning appears. So unless proven otherwise I
claim the commit log and the patch are correct.

Best regards
Uwe

--khemwuvx25deahm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpN2pEACgkQj4D7WH0S
/k6Lzwf8DSkcD2KNkgrjPQ9dJBBjqHuxUaPDXFNacjjVAgwT6Pwfd+C7HF0KG1bs
BqtoTI9+PXKyjz2yPy6tJFV8pq6GqGUAaDrtvBxhkUd9h4nK3BFWFlO7Z1HyiTgs
syyZLelwtqqHOw74m5y5p2LDyRQj4VwwaFs1HxReBCEuCuVanb28I1/wONclUzMB
+3lIl+0yVrDpvO3PknOzLV5gQo39ZyjaJr61mUr/ef2o5QxGvNE1MI1H/qaseYKI
P0F0uWcnw/aUZxb2XL9+g8DFcSWUsBfx/zqKCivAMmnkgiyGS0GkzEE99yJ5sged
CfYwRmwSUEwwsfH+5kQUm0TAa7CkaQ==
=Jkjp
-----END PGP SIGNATURE-----

--khemwuvx25deahm2--

