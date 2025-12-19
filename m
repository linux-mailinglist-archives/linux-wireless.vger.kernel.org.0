Return-Path: <linux-wireless+bounces-29969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 512EECD11C2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 18:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77878305BFDB
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2641A2C11;
	Fri, 19 Dec 2025 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uUHoQ4hn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B2E2BEFE7
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164733; cv=none; b=Q+dRqDRDscgwWhtuMCa4huAH4thMISQ8KTZKQ1JcmCNUWRCNd5yVlTNFIOMOsUVE1MxaDxYnL7cVsAv/bwoYPmXxxi7Y/ikhEXdZVrzFJ7PmqGMmiIRon08jBeos3M/VHzFA4On4wuiBX38LbXLsD+KMzvW09M1vB80/yw0+uMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164733; c=relaxed/simple;
	bh=XgTsuEWYEafk1N1EYN+yKOyqRUnPUH4Kr1requmXQVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrpzPYTp+4FGTCXG6RKW14o+O9FGFWwpwT6ZOeyShGAuqG7wAzhSjsWOJr2tA5tykPh0EaXnh/t4lSGZqjqkr4UhU6RTi7UAKT6J6uAck2u0aPgKVGhr/OCxH7ENMiwSgfOaU6Tm1WQEFhWoZzS5nvzHSrlgjIb0qgyzn7huKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uUHoQ4hn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775895d69cso8509825e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 09:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766164728; x=1766769528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snESyLRhb9BgqyB60EyDqIexGhSFyAaClXjAzVuRulQ=;
        b=uUHoQ4hngx/dxSHEB4dd1gSWdULlbGG6Rleu38Fo17u6F4tSzrIsLPzRow0QtCjUso
         MUJZoseWQnotIk/PChMbkIo6uk1o4gHZcEc9a5IoAumvX/tvgO6cVO3TI8mot9SPY8Mc
         xfcdaU4Hk5MeYpZ1jKWRNpscSIb0WcsT+luPEMaeR7EQwXk5eDKl5zAWuqz62DHs5qnG
         Co90AQJMtKUXpcQ3xqt+3NlYgXkR+7iQ1PLwsViVrLFpUwLmwg4KKVxGmGgxxVlQTDgL
         rQwY6uVnQhxHGaj208spSX8pCi4ye7MalseY1Z7XsBMA3i/zP5lz1nN+aeiZEewJkjHb
         y9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766164728; x=1766769528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snESyLRhb9BgqyB60EyDqIexGhSFyAaClXjAzVuRulQ=;
        b=XRbizvQ6ycT6OTmajEBlLBBHtVVdEKm/OYRNXEz4bGG496s2UXkAQvo/mRW5sxn076
         rUh+d3Garkzx5pqaOaOXBXEG/KhMrcqvgu9adrB/0m+qcmJh2ItjwCmODXLy5o4sv9l5
         LEiyl/muS58hJxNBcKFN8uDdx92NRqtlABGPDdoO4k55swwHX0cbrdDbo/Yuc9YY21pQ
         pTkLqXnGDalCErBwV+GkXlvnHZLhzlBWce8dmN/Apr5Ag9nIMXvFPqJoowdZZZu1DGbs
         WVdupb+yl96kuJcnN7dJVH7A/UOiKaEh3zQmreB0/hSzuwOGz1Cy0ZJfKQyeWeixzt3k
         Yuag==
X-Forwarded-Encrypted: i=1; AJvYcCVV5yLwEI1ExDf099A6J0V62f+l+yiDRYJo4h8xNFl9SxoOebKnbdLUx1IZM/ZvxsEDUbWd/XuUPbTHpbfAlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx152hoD0y6YIQe4ssZhSn1FnBhUHn/Il6HNbr2dl0ESEGIVs3k
	In6xUWThlNWBqjQbPSxq4C+VMZqxwinyTcslUpKSGN9FeC4YCNWZwVsikaP6r+Jxs/k=
X-Gm-Gg: AY/fxX51ILA/ZUbo0NJtCgJ0vdkyyQ/Dd0r22V9gtiPxSfFM/KCDiqP211V7FvviBBK
	T8vyMzRyeclmYweo0J733KhStSUmoieZHReX6H6hID9NEuL/GLjbu5ZVrjS5f3NVarX14Cr+XT0
	7K5T318TwZYf9o+F6XeDXjI/YDISdwwvnyxOTRsdJynT9rE4lDXHu83Uuz7XBP4zVA53yNbnpCi
	7N3dYcp/hug/OXQ9YXknf7cwSF+hSxKWIQDamNwRPL2oIleq1OUmH1SYPRWYuDWDGpe5EcOX4KI
	xnBdsJgM02CxaRiSNrkcTptIgCJam8ML/cL4VSwpZraCU8l7cv8zWW7XYVRihWD79hAynd9vPqX
	H2+ONxXwSSAltl2kEXOZ2bij/UsmjNSCTESmkoSGotStsKFNZFZzpKSRMZXrnQ9hohep1Wv/m6D
	IH6f0e9SFEjspoZF9OVNabbJQb485AFpKArkCUxd9K4LlG+zuVcTGRQRM0ocviD9r1GvyrSBj3v
	vI=
X-Google-Smtp-Source: AGHT+IGw7Jg4BgHsr1dkCPhlhRBtoIzer1WmzRgNITRO9EqwkGKuN5VLLnDOwctsa4IAHoSzGXRzJw==
X-Received: by 2002:a05:600c:4fc6:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-47d1953bc3cmr30364955e9.5.1766164728314;
        Fri, 19 Dec 2025 09:18:48 -0800 (PST)
Received: from localhost (p200300f65f006608b2d9668c60491dc9.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b2d9:668c:6049:1dc9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47d193621c8sm51604205e9.7.2025.12.19.09.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:18:47 -0800 (PST)
Date: Fri, 19 Dec 2025 18:18:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH wifi-next] wifi: ath10k: sdio: Use pm_sleep_ptr instead
 of #ifdef CONFIG_PM_SLEEP
Message-ID: <gz2ch5zl6mp67ia3dimuyrcga6nctcjlrzdbbsdr66uaab47jx@iesjlbi2yuzk>
References: <20251217111951.3309170-4-u.kleine-koenig@baylibre.com>
 <dcd0c9e1-66ae-473b-ad37-5d028dc1bc16@oss.qualcomm.com>
 <72d6e9fa-fa28-4079-851e-00905a7b0dda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcnb4zwv5xdxpoiv"
Content-Disposition: inline
In-Reply-To: <72d6e9fa-fa28-4079-851e-00905a7b0dda@oss.qualcomm.com>


--pcnb4zwv5xdxpoiv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH wifi-next] wifi: ath10k: sdio: Use pm_sleep_ptr instead
 of #ifdef CONFIG_PM_SLEEP
MIME-Version: 1.0

On Fri, Dec 19, 2025 at 07:12:30AM -0800, Jeff Johnson wrote:
> On 12/19/2025 2:32 AM, Baochen Qiang wrote:
> >=20
> >=20
> > On 12/17/2025 7:19 PM, Uwe Kleine-K=F6nig wrote:
> >> This increases build coverage and removes an ugly #ifdef block.
> >>
> >> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> >> ---
> >> Hello,
> >>
> >> I found the patch opportunity while looking in this driver for a diffe=
rent
> >> reason.
> >>
> >> Best regards
> >> Uwe
> >>
> >>  drivers/net/wireless/ath/ath10k/sdio.c | 12 +-----------
> >>  1 file changed, 1 insertion(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wire=
less/ath/ath10k/sdio.c
> >> index c06d50db40b8..3efe744c0c96 100644
> >> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> >> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> >> @@ -2136,8 +2136,6 @@ static const struct ath10k_hif_ops ath10k_sdio_h=
if_ops =3D {
> >>  #endif
> >>  };
> >> =20
> >> -#ifdef CONFIG_PM_SLEEP
> >> -
> >>  /* Empty handlers so that mmc subsystem doesn't remove us entirely du=
ring
> >>   * suspend. We instead follow cfg80211 suspend/resume handlers.
> >>   */
> >> @@ -2175,14 +2173,6 @@ static int ath10k_sdio_pm_resume(struct device =
*device)
> >>  static SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
> >>  			 ath10k_sdio_pm_resume);
> >> =20
> >> -#define ATH10K_SDIO_PM_OPS (&ath10k_sdio_pm_ops)
> >> -
> >> -#else
> >> -
> >> -#define ATH10K_SDIO_PM_OPS NULL
> >> -
> >> -#endif /* CONFIG_PM_SLEEP */
> >> -
> >>  static int ath10k_sdio_napi_poll(struct napi_struct *ctx, int budget)
> >>  {
> >>  	struct ath10k *ar =3D container_of(ctx, struct ath10k, napi);
> >> @@ -2668,7 +2658,7 @@ static struct sdio_driver ath10k_sdio_driver =3D=
 {
> >>  	.probe =3D ath10k_sdio_probe,
> >>  	.remove =3D ath10k_sdio_remove,
> >>  	.drv =3D {
> >> -		.pm =3D ATH10K_SDIO_PM_OPS,
> >> +		.pm =3D pm_sleep_ptr(&ath10k_sdio_pm_ops),
> >>  	},
> >>  };
> >>  module_sdio_driver(ath10k_sdio_driver);
> >>
> >=20
> > won't this cause defined-but-not-used warnings if CONFIG_PM_SLEEP not e=
nabled?
>=20
> no because SIMPLE_DEV_PM_OPS() adds __maybe_unused to the dev_pm_ops

I would have claimed no because

	pm_sleep_ptr(&ath10k_sdio_pm_ops)

expands to

	0 ? &ath10k_sdio_pm_ops : NULL

if CONFIG_PM_SLEEP is disabled which the compiler counts as usage and
thus doesn't throw that warning.

Best regards
Uwe

--pcnb4zwv5xdxpoiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlFiPMACgkQj4D7WH0S
/k6wvgf+O9Myi+jHDgXNxLqCnodEuyQ3U6kbc03BR7vz8OrsGQfNCLZkU8v//z1t
1ZTqZSY7Vr92YG1ZROluzRNn2e8cuzAsoLOuNj056C8Elit84OP4i56e7lyX8q4v
cqxTNgmDsjyDx1OVsNo+TUmqDXtxqgJn+8PAgBhCfpzeRSsV6ETuDMHuucXF9Ytl
ZSwZ2iaxDdcgIeVI4GT0aZA16vHJPKTMbVZTe1f8xxKqeQMINUirrIqCHkiys5Cj
7OnsXzDK0lv90JwrE9bQjtgCim1XSbC5pcyn/3AS9ifv0cizgixjWJeHnSuwJgJo
ivnCnskCm1sy8S0TpiGJ2zCeSHI6Fw==
=WMX5
-----END PGP SIGNATURE-----

--pcnb4zwv5xdxpoiv--

