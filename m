Return-Path: <linux-wireless+bounces-18541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379AFA2975D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 18:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A53164CF9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826C24B26;
	Wed,  5 Feb 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b="QSaC9KZd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.bues.ch (bues.ch [116.203.120.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69A1519AD;
	Wed,  5 Feb 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.120.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776636; cv=none; b=Bd+egcDGUYXpjmRiPdZzZ0w/nQhyAA4FOR8v3kJgu6G3AzXYXarlqP7eiEqWnLKBQ9VvY/T2IFcF2B9tqspvSrir0PAjDO7R51SlAgp+BeJTwCPVr9BxxmXI5e5siss8po0pvEYacWEdX8IkLe6c55Hhsz0SLB47jsbRFOrAj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776636; c=relaxed/simple;
	bh=gzt3Y6bMwaAwDTrMqO5l1QM/P5g3nv4A3cPONKMK3Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehewibiVNJ7s6kIjD8iYExr/7suhjd5Z548G/A2Cywgal3Kky9P3TNuHKddgynwn7fWVK5JpRoctfn/LGpDD8UOWmEXjxw0I5qaGd9IHmjBtgzgnnX9KblGSjWQy2oigQuqdEXNUWHLnfYQCgYuTKXiZoz5Ile68irljxG5eW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b=QSaC9KZd; arc=none smtp.client-ip=116.203.120.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Date: Wed, 5 Feb 2025 18:23:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bues.ch; s=main;
	t=1738776242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXHa2sqBdx5kl+URkaqFGorX131D990W5SanQ/p4o1k=;
	b=QSaC9KZdyLhpEGGWBCi1SxDSKvk/gQWhHj/GwqSvLTNQQdndAigeCDl7A4AhRU8V72rDtW
	UbsB+Fa5gg6TwIUdYgshdhRO+X4rx5F81BrP10VbdrSZbNDFczw509rqi9tjZVDmrC/svr
	69eRX2mdbPCNWK58J2yfwVoonixzmkX2R/RsLDbhqlMqOMJKOkvLB1EgPh7SnHV+xeb0I+
	0vmlmZUWIUK3gWJNG2fN8MN9CWqNpuW+wmOmZwQZJy2jOacLdIq4DBH9S6H3VipsR9tgUq
	u5JtttZ5xICxjiI9p6deypa2QqdXNfbhNCq+XXxy2AFvAWKE1QK99t2sy90U3w==
From: Michael =?UTF-8?B?QsO8c2No?= <mb@bues.ch>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: wireless: broadcom: b43: Replace outdated
 firmware URL
Message-ID: <20250205182325.5a38c736@barney>
In-Reply-To: <20250205110614.216958-1-carnil@debian.org>
References: <20250205110614.216958-1-carnil@debian.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uuMKLn01GWEcG6Sbf8AZzW/";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/uuMKLn01GWEcG6Sbf8AZzW/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  5 Feb 2025 12:06:14 +0100
Salvatore Bonaccorso <carnil@debian.org> wrote:

> https://wireless.wiki.kernel.org site now redirects to
> https://wireless.docs.kernel.org/en/latest/ making the reference
> information for the b43 firmware inaccessible. Update the URL to the
> current location.
>=20
> Link: https://bugs.debian.org/1095062
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  drivers/net/wireless/broadcom/b43/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wirel=
ess/broadcom/b43/main.c
> index 25b4ef9d3c9a..7529afd24aed 100644
> --- a/drivers/net/wireless/broadcom/b43/main.c
> +++ b/drivers/net/wireless/broadcom/b43/main.c
> @@ -2166,7 +2166,7 @@ static void b43_print_fw_helptext(struct b43_wl *wl=
, bool error)
>  {
>  	const char text[] =3D
>  		"You must go to " \
> -		"https://wireless.wiki.kernel.org/en/users/Drivers/b43#devicefirmware =
" \
> +		"https://wireless.docs.kernel.org/en/latest/en/users/drivers/b43/devel=
opers.html#list-of-firmware " \
>  		"and download the correct firmware for this driver version. " \
>  		"Please carefully read all instructions on this website.\n";
> =20

Acked-by: Michael B=C3=BCsch <m@bues.ch>

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/uuMKLn01GWEcG6Sbf8AZzW/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmejno0ACgkQ9TK+HZCN
iw5FtBAAsu35avxN0BF/zlRtr8E4sVnqfLRz1sfAFmVTYr6zrEMmv/wZ/7SAfH5o
pBq/n4jLFRSZAh+DvYOcH+W0y1lAKOAgAeTrNVWblVXcqOCzwrFsi2KbKlrzyc+b
MQ2MpKKW9T62YS/mYtgIaNHKXjdWKkVqCIQM6VuBs6OokwWs70IyESDhY4QHTK7M
oZONxaWnR2O5lAvenvILGMZdK+nEu3MMwAVSC/ckyLVv326RMOKhTTMcpcVlAb8l
8TJFq70upEQIFEULAcyuHBqy3mwUNHJIKW5k2HzJ6UCN8OqZnBCQE8HVdyzZzjNm
W1S2ZXZCtC9Z8Td6gveEv+ZjEg8W5Jsxbc0d4vG0oDrE1LtCNbN8ofMjmg/UmvW2
7YfEuKuQ+RiSahYAGKdarAOe2dMlxQaCcx/iC73pZM5I9eaPU62tJ9DsVAzU7hu1
neZeVJUzXCo/dpyw98yU+xnM6fsmYRaXgvNTFPk8BNabRMv9nxt6Ne731pFxwN97
0sirlPmEhBT6aGkm47gOIY79xD3Swoo7xFpelCPFLBAOEEkuwii+RnL8hWyVfbb9
oxVcFUWpTZOY+TCQ1rqqTc6b2xj/mN7Na25f2C7HIwB8ByRRu3jPPcLznK5XB1cS
1tQLN7vaL9OWFg26pDuhcb6hdeaUkKolwclyyOgb39sX9o92kNg=
=8mHz
-----END PGP SIGNATURE-----

--Sig_/uuMKLn01GWEcG6Sbf8AZzW/--

