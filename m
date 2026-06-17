Return-Path: <linux-wireless+bounces-37852-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JeenKFVaMmrWywUAu9opvQ
	(envelope-from <linux-wireless+bounces-37852-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 10:27:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2523B697883
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 10:27:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=LnMU+Huf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37852-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37852-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FE4E300B477
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8950F388E64;
	Wed, 17 Jun 2026 08:26:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40838332F
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 08:26:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684819; cv=none; b=UPWjzqm4fdWMw1ZcWHZ9QaZI16hd0MrDTgYd7LU62UGO/iTlv8kO8FEDBdV8ra8XY8pykrbnMWdu3CF1d3cBW9tUUOKM0IbyJqF/BC9HI/ExI+tm5mgZPAaKCfL4mwy1TzpCM9II/bLTvmM9uAiCB1zdlO2+rlqNF8zSCOOuDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684819; c=relaxed/simple;
	bh=jEzndlSIAojArAwTTSPCoi06E6ZIWFyK7AQAAVVpRSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNtKWHXAmwvaXYl9TebDe/s1Q3Qxd0CTkFH4CjirDOJgUq0K+drqYZo5rX/qbkFjNvtcY2XM2GXQ9gJge30mogGXUYRTW11XF/nmOMrxRZ34/nCeO7UgATiGam+DlDQWRgaJxX+YlW5GSRcctCzKp0gtZW8jxTmEJKLJGaYmHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LnMU+Huf; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-461a15cce0bso1150771f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 01:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781684816; x=1782289616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJEL8IEaDnHzM92Jq9W+3xoN0C9UG9XQ7Mp38lRM0jo=;
        b=LnMU+HufKSfdPs0JkoAfj3wzNNV8dyJs10lXAmQh/jSEn0jFliag5wU6z1elL9En4o
         FKIGVkNVRORzNb9skfVQaGcz2m+JCkUGk0YRUTRoruRT+S+Pqn1TVbIQ2A5Tr6/14fan
         tDMJ1drOy0XQxI25NW74dbs+HDCebEV9XOGke8+ciIdOH9dIlxLUo27mc21lk8W9gYj2
         4B8Sk4pMx0vybKMFZ2LmCQKxamlpBMHk6shclxsO3uE07RlopUiLLZqUJCZbP2uC19kJ
         cuoirQaPba9xxHabVCSCj3w5bUcwCwCNbTydMcw1h8ZFUPnsgcP391iOw6HTXJTwMhNc
         5vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781684816; x=1782289616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJEL8IEaDnHzM92Jq9W+3xoN0C9UG9XQ7Mp38lRM0jo=;
        b=cmDIBOntrgeuEOX7OtQR/uoomg5L9oJONpaNR8tUlHJ67gvisFk1syTB22OQo60bcA
         qgXB5qQsM37CRcfwCNKxO4OKJw0rn7FbJyUXlx3pyVmASI5O/r0M+7BlkePrQdqxD28X
         NehFfDwJrX1FatFrnpwzdmxq4S6rYpdK0eT7MHIGM+34dTkVarl7V6VdPTj/vA47Wf2V
         zj5Tj1hTdDAGZ8HrdmrhTGtkstBh5x2TtOwo44bmFJE86vOiPL2AjkN921m6NGwMK8Aj
         G4TKoJTWImh0QfXSsPRG2SEHcIpRZVEnT7IAX/mkYHZZcgMii+YytYqQROW/dNHfvd8T
         JdLA==
X-Forwarded-Encrypted: i=1; AFNElJ/6JMj9i4rfEQFfLPdB1RYeW5POHSLd08MdJKB7BYVfQ5jfdoCbAS/VK2d8ScfbPgJFmoW5+wHM2YMT2Qx/Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjKqsOXnj9E3BSJRCD2TJeWErgdwjYiXsdV+5h5JDz+T586pE
	ZXyA5PtSP0Lk1hTUBclYh3FznOLRP/hIdWo25CqLFE+zA32X8mMNK7g0iB6PNb2Wn+oqR4Go65b
	o19Lz
X-Gm-Gg: AfdE7ckRQX68n8Quq1Aa11nrtEjNyI0QWg9GL8OXskisuvfc0xYqXSUMcapHEatJ5Is
	VWhfBvc2vJoK6hI2gduraMZD8yzltXnUtvbABTQ1r7EnkScnrZaSlfzK1EQLzcCv00AqvpIlCjC
	paNCkauKLj9gGFgm377OUhYNbbJe1ZzfZhX/TOFaQDa3350yLy7dAWFg94q4nvTf6DjFIb2l68l
	VYa2L/TiE+oiIAW7kfB5bffilyYLUn+pgPW0KG79q0Y3aCDY7lsKdZf3ptfHjkVUn8MHYZkZOUw
	xZ+GtsZoSgK0xH1BnmUNw2vdgJqqDi4C159/PeMK8PCiiyE0gr84sHgnUI/Hdaqdfbs5pJC3x6J
	7yLkpvxio9DtP2CFpO3G7KOpq07+y6sWJzP7GBP2HR+ss8yKRt1jrxuFoG0IZfn1do2axsv3r+G
	4Ze50IbRAWh5qw+CjQ9yrBvGXXThME8ihY+C+VSRXwYO/H2Iaa77TWbS8Ekrwa8/rWQClc+67W6
	/fC
X-Received: by 2002:a5d:649f:0:b0:460:3234:77d3 with SMTP id ffacd0b85a97d-46238dab6acmr3761099f8f.41.1781684815885;
        Wed, 17 Jun 2026 01:26:55 -0700 (PDT)
Received: from localhost (p200300f65f47db04bc2080ea3c93ea6d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:bc20:80ea:3c93:ea6d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f2ce361sm49380671f8f.31.2026.06.17.01.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:26:54 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:26:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: William Hansen-Baird <william.hansen.baird@gmail.com>
Cc: pkshih@realtek.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rtw-next 2/3] wifi: rtlwifi: convert pci ID if-statement
 to table
Message-ID: <ajJZtfguHz1BUlD5@monoceros>
References: <20260614135508.70307-1-william.hansen.baird@gmail.com>
 <20260614135508.70307-3-william.hansen.baird@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uoezc4nimoophe3c"
Content-Disposition: inline
In-Reply-To: <20260614135508.70307-3-william.hansen.baird@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:william.hansen.baird@gmail.com,m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37852-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,monoceros:mid,baylibre.com:dkim,baylibre.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2523B697883


--uoezc4nimoophe3c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH rtw-next 2/3] wifi: rtlwifi: convert pci ID if-statement
 to table
MIME-Version: 1.0

On Sun, Jun 14, 2026 at 03:55:07PM +0200, William Hansen-Baird wrote:
> Refactor the ASUSTek quirk logic from an if-statement to a standard
> pci_device_id table. This allows future devices with the same quirk
> to be added more easily and avoiding a large if-chain.
>=20
> Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wir=
eless/realtek/rtlwifi/pci.c
> index 4ef1faf649e9..03b743809258 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -31,6 +31,11 @@ static const u8 ac_to_hwq[] =3D {
>  	BK_QUEUE
>  };
> =20
> +static const struct pci_device_id rtl8723be_aspm_quirks[] =3D {
> +	{ PCI_DEVICE_SUB(PCI_ANY_ID, PCI_ANY_ID, 0x11ad, 0x1723) },
> +	{ 0 }

I recently reworked many pci_device_id arrays and en passant made the
terminator an empty initializer with a single space (i.e. `{ }`).

If you resend, adapting to that style would be nice.

Best regards
Uwe

--uoezc4nimoophe3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyWksACgkQj4D7WH0S
/k5LOgf9FpE8DbfYaqXfNs33XCPLY1nbf11lm1+bf6dp5XURTCH+yauHVoBOAHUw
MmaX2+4AG0ogHFI/t6ac+492ZvemZYiw4eHE32iezQyMlXRpbzSOO5Sp9h+zdqa9
JdnN46r0G3jSeb0fswtPOjv1MkBqq6SFd4oAgv98lG7c23y7Xr/57p5rSxjy/VqC
rtXK7h1zPus/RMMDNmGJRygB6lQVdGKxs++eCxeetTysVU4MKhKTIm+Im9cTEwIT
5dXvBCdoceMi9qeeoPjZas8Z53WTrnQK5CJTEYSq/35janBbNOUQu1NvKYGqXegZ
1nrsFwp7sZSTF8nB8Y5Kxq6oTPzybw==
=xgZK
-----END PGP SIGNATURE-----

--uoezc4nimoophe3c--

