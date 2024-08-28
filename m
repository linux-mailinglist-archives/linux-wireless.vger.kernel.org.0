Return-Path: <linux-wireless+bounces-12157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C08AF96260D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 13:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3F51F22C68
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D59160783;
	Wed, 28 Aug 2024 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lXhplsyR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1415ECDF
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844543; cv=none; b=k/nei7tD+3Cjd2bNIiwaqzN2+MlQOW+Jvf4Z7gJNzhuDVQ2f8jxA6bwfHvp5YSdUMdKefKnDyW9TM4Z640+SgFDREsxAKO9RJQAjU61hdn0Aj8qafGiJALsssw4F3+na3ArhhxgKeAu9Z6adEwThIZw7ldgNQsZwANYIM8YOuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844543; c=relaxed/simple;
	bh=im9LluCF10tFTMvPzaq2nb//DVWYbMJrUNDAbDP8fiE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nLU9rEzkQuc+fI/eElJ8GtRbuGzUfNn/Zkl9BazM4YPAfColTfd5FR+XsKDpsRs1Rh4pVyVtYQExABsrpIea3/OW2NTlVM6PVGQCKd9FIK2l41LrrNpiL4dNJXEhqxKXifAgwrG02KL3I2eHcI3IalGVsVqKQ4lzGsrp/mpzM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lXhplsyR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j9OwtT25G9RrT6++4ZAdPwJf7EO86ZUkKeG/Vo5QiDU=;
	t=1724844542; x=1726054142; b=lXhplsyR2TYHvDQTLwTWIslAVpPoZB88cWbnmVtw2W1g9q/
	wwTxR4Z1yd6NXG6dM0bu5A3ZD0yrfIVHB4kjZjs1G50okpTynuGupMuWbr53T32X8ys5HoUqw6u9H
	hECz+S2LIYwCbikmSfD52BCQlfqAafZcIMGR1O6aF8y/JfBvkAAeTGM7TnS5Ped28+55SvCsTS3ZK
	I2t6Rn0swit/tVgwazMy10gV5wJkq/mIwNCgb6h2SXEUkoZtZrX8PHIFIxfLo4hG4JWX7iVYRzK94
	s8lz3AtsBAfJFM4s8+OSkImbDyP2AO/0E09Ei5rcUZDPSbHqe5mDVMyKj5daHuFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjGrD-000000072CB-1vAh;
	Wed, 28 Aug 2024 13:28:59 +0200
Message-ID: <e006938d308662f44b869d008a052546bff24b5c.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: scan: Improved handling of Country String
 environment values
From: Johannes Berg <johannes@sipsolutions.net>
To: Taavi =?ISO-8859-1?Q?Eom=E4e?= <taaviw@aegrel.ee>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Date: Wed, 28 Aug 2024 13:28:58 +0200
In-Reply-To: <1670e04b-9d61-4778-9d7d-e0d1c2ebb5f8@aegrel.ee>
References: <1670e04b-9d61-4778-9d7d-e0d1c2ebb5f8@aegrel.ee>
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

Hi,

Couple of comments:

On Fri, 2024-08-09 at 22:20 +0300, Taavi Eom=C3=A4e wrote:
> The third octet in Country String (dot11CountryString) can be a reference
> to one of the tables defined in IEEE 802.11 Annex E. The hexadecimal valu=
e
> directly corresponds to a table with the same number.
>=20
> Also added handling for non-country entity and hexadecimal printout of al=
l
> values for enhanced clarity.

First off, the subject and commit message should be written in
imperative voice, "improve handling", "add handling", etc.



>=20
> Signed-off-by: Taavi Eom=C3=A4e <taaviw@aegrel.ee>
>=20
> ---
>  =C2=A0scan.c | 18 ++++++++++++++++--
>  =C2=A01 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/scan.c b/scan.c
> index faf406d..85798b8 100644
> --- a/scan.c
> +++ b/scan.c
> @@ -661,10 +661,24 @@ static const char *country_env_str(char environment=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return "Indoor only";
>  =C2=A0=C2=A0=C2=A0=C2=A0 case 'O':
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return "Outdoor only";
> +=C2=A0=C2=A0=C2=A0 case 'X':
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return "Non-country";

Please follow existing coding style with tabs. Or maybe your email
client just mangled it?

>=20
> @@ -673,7 +687,7 @@ static void print_country(const uint8_t type,=20
> uint8_t len, const uint8_t *data,
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0 printf(" %.*s", 2, data);
>=20
> -=C2=A0=C2=A0=C2=A0 printf("\tEnvironment: %s\n", country_env_str(data[2]=
));
> +=C2=A0=C2=A0=C2=A0 printf("\tEnvironment: %s (%#.2x)\n", country_env_str=
(data[2]),=20
> data[2]);
>=20

This also got line-broken so I can't apply it.

johannes

