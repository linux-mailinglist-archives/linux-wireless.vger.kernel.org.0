Return-Path: <linux-wireless+bounces-8860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D53390523F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CE51F22058
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E5015664C;
	Wed, 12 Jun 2024 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Gsuwcrjh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1BE15622F
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194696; cv=none; b=MiSz2fBuoruyyM6xGm0Jhsv59ZP3IoRnqr0g+sLIhLNVklsVIBudtjcF01RJnEwpFx6IRSmdAg1l2znsFi4jyxg5UkePxmaMAEcJcPCqFV0JSUxUaBbi1ultOhqznkLcIzKzZ/BViCC4bPY+LQvARIsjytxsRZo7Ujq7Tz+KQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194696; c=relaxed/simple;
	bh=gSAu3aBDw71I37ynGkuhykdPxnE5aqijttm6/CijrKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IiH/mEtYHhSrTcOcGK8mRw+ksHurX60bOCIBBzrWuNL7Qbosg0yNAfN9uAgjioDIquYvmUeOu7IzA+Hou5BzzGVfQt/g+ORd056QDYKENNNckn/V9bVQzQv5L4HuqSlz7YABWd40h4KJwcPEiCkNJx+e4ZJIoaOhPal+g0N0X1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Gsuwcrjh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/+2s6E8xDJvPjFZQsehIxe7/IVAxXv+h/0wQ8h5uzgk=;
	t=1718194694; x=1719404294; b=GsuwcrjhXQHPoDnSILMjsi/D4Va2fvNtjUBn2u0XOA9mOGi
	Bz09uJe4OD+zcfb1wrvKBQB9e/AtKJaCsGM9C5lm1uROaSv5yuuSsvxvBMbVoCrWtv6MPdHZ1zKXr
	w8YvyxMm4qDiaVpMXYsLsGva2//Cio2gq/hZGg0yu4IwOIR/i10aPJqQhCICHy04m86BfvR8kVhtv
	MxM8HOV8Yos8+lwASxbna73LO7Tst8hOI/a9YWhEr7LrkWUTShpWtcRCqdgULfLgBjTJhElnQ47vI
	MGU/4Mohoy6iKy2eKQma1bz5lr5wAR5ADkVBumqjbOyvwrQl3Ach7Vc83nWTcUfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHMvc-0000000AFaa-2md8;
	Wed, 12 Jun 2024 14:18:12 +0200
Message-ID: <68a33290c667b8e31c4c19f7b2f3c614a124845f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] iw: Scan: Add EHT beacon info support
From: Johannes Berg <johannes@sipsolutions.net>
To: Dylan Eskew <dylan.eskew@candelatech.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 12 Jun 2024 14:18:11 +0200
In-Reply-To: <20240318215733.112425-1-dylan.eskew@candelatech.com>
References: <20240318215733.112425-1-dylan.eskew@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

Sorry this took forever to bubble up on my list again ...

> +static void print_eht_capa(const uint8_t type, uint8_t len, const uint8_=
t *data,
> +			   const struct print_ies_data *ie_buffer)
> +{
> +	bool is_he =3D false;
> +	const __u16 he_phy_cap[6] =3D { 0 };
> +	unsigned char *ie =3D ie_buffer->ie;
> +	int ielen =3D ie_buffer->ielen;
> +
> +	while (ielen >=3D 2 && ielen >=3D ie[1]) {
> +		if (ie[0] =3D=3D 255 && ie[2] =3D=3D 35) {
> +			is_he =3D true;
> +			break;
> +		}
> +		ielen -=3D ie[1] + 2;
> +		ie +=3D ie[1] + 2;
> +	}
> +
> +	if (is_he) {
> +		memcpy(&((__u8 *)he_phy_cap)[0],
> +		       ie + 9, 12);
> +	}

Hm, at the very least, that could be a helper; at first I was wondering
what you even did there :)

Also, even if I see that this exists in print_capabilities(), I'm really
not convinced this is a good idea. In the print_capabilities() case it
should probably just print max A-MSDU anyway (or "(reserved for non-
VHT)" with it perhaps). Either way, we end up double-parsing this which
isn't great...

Also, you go to great lengths to get it, and then comment out the usage
of it below?


Not really sure what we should do instead - perhaps more 'elems' style
parsing like mac80211 does, and then print that way. Clearly we can't
simply iterate any more.

> @@ -2639,8 +2667,7 @@ static int print_bss_handler(struct nl_msg *msg, vo=
id *arg)
>  				       nla_len(ies)))))
>  			printf("\tInformation elements from Probe Response "
>  			       "frame:\n");
> -		print_ies(nla_data(ies), nla_len(ies),
> -			  params->unknown, params->type);
> +		print_ies(nla_data(ies), nla_len(ies), params->unknown, params->type);

why?

> -	if (!(he_phy_cap[0] & ((BIT(2) | BIT(3) | BIT(4)) << 8))){
> +	/*if (!(he_phy_cap[0] & ((BIT(2) | BIT(3) | BIT(4)) << 8))){

Don't leave commented out stuff.

johannes

