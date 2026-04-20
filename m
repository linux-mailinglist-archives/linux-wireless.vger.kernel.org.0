Return-Path: <linux-wireless+bounces-35091-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGL8JCBv5mmBwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35091-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:23:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E99D1432C31
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 963703080027
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FDC3A6B95;
	Mon, 20 Apr 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJnMl8gI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11303A6B89
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706337; cv=none; b=LFun9cOJP8RjEbVbE9Y9C7bW+j9LWrH+9nA69nKXgDBq/siuH7tIlven6FxgHTXz7CxmLJ6BtMn6J8n1JrlzuZOf3YfRQ+pqka97YYDSYn7Y8VASAZaNhEz/iECPOof2ZSOAtsR/Agel3GLG/M8/w3uNrjXG3rMiLS3+uEA3LWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706337; c=relaxed/simple;
	bh=KC1IZs0ghLE5Koj5LmIlZCjbgQ+Nr+LAsTcaZYnYsJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teqOLIDRCNb3cXgM90T2zY4dYS4igyKTmeXE8ky0d5TyBNRp2L9aeKh56TefG/ddpbMBuF/b8YBHfC9RsNEBW7KjqjlltA+dHtd6kreXRxltFPHWX50rAZJ1AcTb6Kd2e/Kzm3vCO3tOilUGnL0P5A/JESgbuPS6BZOdj/v5SPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJnMl8gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCB2C19425;
	Mon, 20 Apr 2026 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776706337;
	bh=KC1IZs0ghLE5Koj5LmIlZCjbgQ+Nr+LAsTcaZYnYsJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJnMl8gIWdxvW+Ttg+0PneRXOIhlYhk1kv2qknZY5p5pIUzJ+B/Syl34uzwUbbpI8
	 iZMg9I6ZM0ftkggqQTFKEKgNGJuBecR1+4LY+hu8hxNK+xME8IPJQyD8zizFVxqowA
	 FJRVgS6DmHKVM5hP1VK1X41himi7Qi7DLhsN+maqUy30+QJVYg4K6xzSECJZVrfpV4
	 /amM0ytsd8b6Oi+qOOxYi0qCKgZuplS5yT6vA6LK5YqbqqOyuyZ9Pc0H3FvjojSqvD
	 nxqnIWmg20WN1A+CwLx48nA+bYTQF/MjJVOmn/YPUj4uGppJGlkkDaG5sJs4IIG5KX
	 fpzBI4FEjgHUA==
Date: Mon, 20 Apr 2026 19:32:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: use hrtimer_setup() in mt76x02u beacon init
Message-ID: <aeZjHg6FRZG5PRP0@lore-desk>
References: <321f7c0e-2ae7-4633-beac-51bcfac4f4bb.ref@yahoo.com>
 <321f7c0e-2ae7-4633-beac-51bcfac4f4bb@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VLSH78VkQ8UMr+TG"
Content-Disposition: inline
In-Reply-To: <321f7c0e-2ae7-4633-beac-51bcfac4f4bb@yahoo.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-35091-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E99D1432C31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--VLSH78VkQ8UMr+TG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Replace the two-step hrtimer initialization pattern with a single
> consolidated call to hrtimer_setup().
> The legacy approach of calling hrtimer_init() followed by manual
> assignment to timer.function is deprecated. The new hrtimer_setup()
> helper atomically initializes the timer and assigns the callback
> function in one operation, eliminating the race-prone intermediate
> state where the timer is initialized but lacks a handler.
>=20
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> ---
>  mt76x02_usb_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mt76x02_usb_core.c b/mt76x02_usb_core.c
> index c94c2f661..3a28a8cc1 100644
> --- a/mt76x02_usb_core.c
> +++ b/mt76x02_usb_core.c
> @@ -264,8 +264,8 @@ void mt76x02u_init_beacon_config(struct mt76x02_dev *=
dev)
>  	};
>  	dev->beacon_ops =3D &beacon_ops;
> =20
> -	hrtimer_init(&dev->pre_tbtt_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -	dev->pre_tbtt_timer.function =3D mt76x02u_pre_tbtt_interrupt;
> +	hrtimer_setup(&dev->pre_tbtt_timer, mt76x02u_pre_tbtt_interrupt, CLOCK_=
MONOTONIC,
> +		      HRTIMER_MODE_REL);

I guess we are already using hrtimer_setup():
https://github.com/torvalds/linux/blob/master/drivers/net/wireless/mediatek=
/mt76/mt76x02_usb_core.c#L267

Regards,
Lorenzo

>  	INIT_WORK(&dev->pre_tbtt_work, mt76x02u_pre_tbtt_work);
> =20
>  	mt76x02_init_beacon_config(dev);
> --=20
> 2.53.0
>=20

--VLSH78VkQ8UMr+TG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaeZjHgAKCRA6cBh0uS2t
rKB1AP9AZBny06kt1GgK8YkxVrCtUFQmkhHeURkzB9bPzb6oQgEAqfDRrdqZy3c0
wHZqjEqJj8IgC71Kr3ZqQikYOc150AE=
=yJZV
-----END PGP SIGNATURE-----

--VLSH78VkQ8UMr+TG--

