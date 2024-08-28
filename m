Return-Path: <linux-wireless+bounces-12158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C520962634
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 13:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582092819E3
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 11:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F72E16D9B9;
	Wed, 28 Aug 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mHUfYnBZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400E3FEC
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845162; cv=none; b=elLFnLNFxHKXoXMbs+TJEVS+It2ZZcpBI8pCZ6d/87xFdNCdjbKHrrnehyAXviA9+DJWFat/FQaOT9R4iRao2+xHlkRsvCMNGEGzXvH1sTbJ8GEhRTDYwqqroJAB71UM8Dksp1pVoFYTk5MhCvzof9rLc8Cd3iF5HEAcjmUgEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845162; c=relaxed/simple;
	bh=mNgN34iyfiVM/Cgq/2zec4326b/rVoEqZi9MI0W4sqQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BT/zXdTSrEpD4B4P7yl1GkFoDSQG3MGjOqv3/Dl5aY5wUwi2Lan1Y5xsePXti2mCWdPA/Y3yjdTvpBEH39jf+eVKff8r3zs7nJJEoNISXIpfS9Brae205imHH/1osFrEoqXWuTENLhmTN/4skPeoLcseAeDOkGG8gub9yWH9dHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mHUfYnBZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9ym/kK67JsDoSfwsQbgt9mCEL10exfRVUgEo1pnyNcA=;
	t=1724845161; x=1726054761; b=mHUfYnBZ/YgsvxXz9NVTYd+98tSl8qK+q+UVkxuIGidY8ye
	zQKmNwb6sX0A+gdubWUQP6fGlccBEGG+7C1TNua7/k4jz3OH7om302bha/eclaOJCWCNxnhHxHX+a
	eb9dRuWlpBbg1FE5RvLpcUDVtfAlwxGioENUUF5zAxwWrltX3woRoRIiah21pS6KbSRojyHUDS9LU
	9K0lMUw8eUhU19lF/8Fhrwv1xm2IZQ6OWahRVp0H0xG7F3V7U1a/sk3v21r8UNGpLoAKGOanOFbeW
	i0HN1jYnCAKYsX33cAF1d4nkZ8GUhiHkv4bYTtXDPleWqtdCBf8gMie1mHcmPjfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjH1C-000000072zJ-30P9;
	Wed, 28 Aug 2024 13:39:18 +0200
Message-ID: <dd210692356dfbcfedac1bebb444a726eaef519d.camel@sipsolutions.net>
Subject: Re: [PATCH v4] iw: scan: add EHT beacon info support
From: Johannes Berg <johannes@sipsolutions.net>
To: Dylan Eskew <dylan.eskew@candelatech.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 28 Aug 2024 13:39:17 +0200
In-Reply-To: <20240731162022.2943045-3-dylan.eskew@candelatech.com>
References: <20240731162022.2943045-3-dylan.eskew@candelatech.com>
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

On Wed, 2024-07-31 at 09:20 -0700, Dylan Eskew wrote:
>=20
> -	if (!(he_phy_cap[0] & ((BIT(2) | BIT(3) | BIT(4)) << 8))){
> -		for (i =3D 0; i < 4; i++)
> -			printf("%s\t\tEHT bw=3D20 MHz, max NSS for MCS %s: Rx=3D%u, Tx=3D%u\n=
",
> -			       pre, mcs[i],
> -			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
> -	} else {
> -		if (he_phy_cap[0] & (BIT(2) << 8)) {
> -			for (i =3D 0; i < 3; i++)
> -				printf("%s\t\tEHT bw <=3D 80 MHz, max NSS for MCS %s: Rx=3D%u, Tx=3D=
%u\n",
> -				       pre, mcs[i + 1],
> -				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
> -		}
> -		mcs_set +=3D 3;
> +	for (i =3D 0; i < 3; i++) {
> +		char *bw[] =3D { "<=3D 80", "160", "320" };
> +		char *mcs[] =3D { "0-9", "10-11", "12-13" };
> +		int j;
> =20
> -		if (he_phy_cap[0] & (BIT(3) << 8)) {
> -			for (i =3D 0; i < 3; i++)
> -				printf("%s\t\tEHT bw=3D160 MHz, max NSS for MCS %s: Rx=3D%u, Tx=3D%u=
\n",
> -				       pre, mcs[i + 1],
> -				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
> -		}
> +		if ((i * 3 + 2) * sizeof(mcs_set[0]) >=3D mcs_len)
> +		   break;

nit: a bunch of places here have weird indentation suddenly,


> -		mcs_set +=3D 3;
> -		if (band =3D=3D NL80211_BAND_6GHZ && (phy_cap[0] & BIT(1))) {
> -			for (i =3D 0; i < 3; i++)
> -				printf("%s\t\tEHT bw=3D320 MHz, max NSS for MCS %s: Rx=3D%u, Tx=3D%u=
\n",
> -				       pre, mcs[i + 1],
> -				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
> +		printf("%s\t\tEHT MCS and NSS set %s MHz\n", pre, bw[i]);
> +		for (j =3D 0; j < 6; j++) {
> +			__u8 nss =3D mcs_set[(i * 3) + j / 2];
> +			nss >>=3D (j % 2) * 4;
> +			nss &=3D 0xF;
> +
> +			printf("%s\t\t\t%s Max NSS that supports MCS %s: ",
> +			      pre, j % 2 ? "TX" : "RX", mcs[j / 2]);
> +			if (nss =3D=3D 0)
> +				printf("not supported\n");
> +			else
> +			   printf("%d streams\n", nss);

e.g. this especially - are you using 3 spaces for tabs and didn't see it
or something?

I'm a bit more concerned though with the changes about the EHT MCS/NSS
set. You don't have the HE stuff now, and you're not handling "20 MHz-
only non-AP STA" here any more, which seems relevant for local
capability printing?

johannes

