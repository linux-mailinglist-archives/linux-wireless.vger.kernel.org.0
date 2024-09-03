Return-Path: <linux-wireless+bounces-12396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D3E96A357
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0910F1F21F43
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5160188A1F;
	Tue,  3 Sep 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N/KIvPUs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12B1885A2
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378746; cv=none; b=Yw7p4yNHjVng/W4kp5CKUyocotMcEjciBZVQddsZE0s9dKbveXWzu7I8jKmN8qsuxjiyMsHgglm/888ZR0h/8Bdji8/TrrktQCxDntwVS8di7P9Ep1qAZZLS3fYBKgLdavogu/OUVWDY0U/eETkQNijjbYRTurPe0TRy5462P0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378746; c=relaxed/simple;
	bh=hT2ARd2B5jXaFHA/22ApPc30vh73M73KfxEL3R+0Rqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg1GLTiFeRKFoBIo3Gy5q5sz9XO7BSEVOAT0lJXCqRSfBRAKFTKAsK/AIbXWFh+ilNLKPSBvNljzBf4tOKfjpue1q8QVLwa7vVoPf12u3RAi3oFxeJZF/EvV6LOcdxtLRQJ5gB9HoFkmOjH6Rt4TI5kMBCdf/wDMT4UwX6Vizwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N/KIvPUs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a1d78e7b0so159523066b.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2024 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725378742; x=1725983542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DuEfnvjjt6m1/doYMjeYKF5Vb/dLCWma3sPSNO69eh8=;
        b=N/KIvPUsav4dNfjuiy4gWwAaDuUkL4Sd8Yy+TPinpTeg0WpahMZ9FGbA38rbJMNbY2
         iyOLkLpfu4yuDwGsSTrffT8V1iBwMdmaVPRxKzihl/1WjNFPpz3UoghU9BVy3DoxPgZ7
         l2tB9TBj9CzCfgYEVn/fshj9Jfza9dh1ThbLJ6OKOk4pNRBRcto93tekNgfQZySjJo3q
         TEFYGjLus7e/I/1NYkfBk8amiBMTTyoCZde4UkzgliGhA/x3NG/dSf4JbQ3vXr8Ej42n
         gfu6rVfcwx33AHup6NiDSyWBiM8rlZ9Q78gUWKWFW8L/y2dxxaR8JeaiEbMtV1XVz/IM
         hjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378742; x=1725983542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuEfnvjjt6m1/doYMjeYKF5Vb/dLCWma3sPSNO69eh8=;
        b=nYd4tUSzGQRhsTmaqjWtQou2opEc5ApX7jWM6MiRpRmeecjettxXmcse8s3Hp0TV4T
         50/X9chfaPQLwQs1ixOd1xm+rP+Tl3oGUtfWEDNryFirvZKCIPUJe2596WNaTfCpk2xC
         wp8Oren2+IGE0iGIIfMaWvs1hONg/uz6wR+QymYcdeBCeAh8L3EzcEgPat76h5fkswv+
         Htwuw2NyLQUE1aGvB2774h+KPCSx2Vh3wil7Wy+k8AYz3Et22ez8seiKgmP7a57CcCQg
         nzxlB2YhRS/oWTB2S5HYRhB0iX4Vky2hjAczdVVs7ZxODnzWSWVvZy6/8+7NzAF6CT9a
         riaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/gDnD8uxywbxlrCg1BbWhcoj6KXQzNsG4kLA7rxTTEPsPHfcrQD9+CYjODusu/qUJCOER33NToQcAVBBDtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYKAecS5ii3S8Fgb49qqn7cxBZL/4felQNdLn0n30UcQBHY4D
	oSMBpv63gda2LMPYjTjD5OMTY81sD37a2rKxTe1uxhD/K+ECK9JzJHOI/wgGex0=
X-Google-Smtp-Source: AGHT+IGX8n0w2RrQgN7NxW87zoP0ZbH3F+TZlJRkbLUatpnJln6Op8KzPk3dbNz6NHkJ9YOZ5PBNdQ==
X-Received: by 2002:a17:907:86a9:b0:a86:73cb:99ef with SMTP id a640c23a62f3a-a89faf0fc8dmr584529166b.39.1725378742211;
        Tue, 03 Sep 2024 08:52:22 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb2a3sm701051566b.3.2024.09.03.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:52:21 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:52:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org, heiko@sntech.de, 
	yisen.zhuang@huawei.com, salil.mehta@huawei.com, hauke@hauke-m.de, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, mcoquelin.stm32@gmail.com, 
	wellslutw@gmail.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com, 
	ajay.kathat@microchip.com, claudiu.beznea@tuxon.dev, kvalo@kernel.org, 
	jacky_chou@aspeedtech.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] net: ftgmac100: Convert using
 devm_clk_get_enabled() in ftgmac100_setup_clk()
Message-ID: <7mfqy5mcwxrppb25j57za7jzk6d5llexfgnngl66tle3ic32yy@63cj63tsh3xh>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
 <20240831021334.1907921-6-lizetao1@huawei.com>
 <nyfm5mxrrvfeu7s25qzjxbatvgnppq7exmca3sccmm6lz7nxan@xxsdgcrueoen>
 <0becf4e0-2f66-4c26-b0b3-59ee232eaaef@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="se74eiqu42ro53lu"
Content-Disposition: inline
In-Reply-To: <0becf4e0-2f66-4c26-b0b3-59ee232eaaef@huawei.com>


--se74eiqu42ro53lu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 03, 2024 at 06:46:48PM +0800, Li Zetao wrote:
> =E5=9C=A8 2024/9/3 16:09, Uwe Kleine-K=C3=B6nig =E5=86=99=E9=81=93:
> > On Sat, Aug 31, 2024 at 10:13:27AM +0800, Li Zetao wrote:
> > > Use devm_clk_get_enabled() instead of devm_clk_get() +
> > > clk_prepare_enable(), which can make the clk consistent with the devi=
ce
> > > life cycle and reduce the risk of unreleased clk resources. Since the
> > > device framework has automatically released the clk resource, there is
> > > no need to execute clk_disable_unprepare(clk) on the error path, drop
> > > the cleanup_clk label, and the original error process can return dire=
ctly.
> > >=20
> > > Signed-off-by: Li Zetao <lizetao1@huawei.com>
> > > ---
> > >   drivers/net/ethernet/faraday/ftgmac100.c | 27 ++++++---------------=
---
> > >   1 file changed, 7 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/e=
thernet/faraday/ftgmac100.c
> > > index 4c546c3aef0f..eb57c822c5ac 100644
> > > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > > @@ -1752,13 +1752,10 @@ static int ftgmac100_setup_clk(struct ftgmac1=
00 *priv)
> > >   	struct clk *clk;
> > >   	int rc;
> > > -	clk =3D devm_clk_get(priv->dev, NULL /* MACCLK */);
> > > +	clk =3D devm_clk_get_enabled(priv->dev, NULL /* MACCLK */);
> > >   	if (IS_ERR(clk))
> > >   		return PTR_ERR(clk);
> > >   	priv->clk =3D clk;
> > > -	rc =3D clk_prepare_enable(priv->clk);
> > > -	if (rc)
> > > -		return rc;
> > >   	/* Aspeed specifies a 100MHz clock is required for up to
> > >   	 * 1000Mbit link speeds. As NCSI is limited to 100Mbit, 25MHz
> > > @@ -1767,21 +1764,17 @@ static int ftgmac100_setup_clk(struct ftgmac1=
00 *priv)
> > >   	rc =3D clk_set_rate(priv->clk, priv->use_ncsi ? FTGMAC_25MHZ :
> > >   			  FTGMAC_100MHZ);
> > >   	if (rc)
> > > -		goto cleanup_clk;
> > > +		return rc;
> > >   	/* RCLK is for RMII, typically used for NCSI. Optional because it'=
s not
> > >   	 * necessary if it's the AST2400 MAC, or the MAC is configured for
> > >   	 * RGMII, or the controller is not an ASPEED-based controller.
> > >   	 */
> > > -	priv->rclk =3D devm_clk_get_optional(priv->dev, "RCLK");
> > > -	rc =3D clk_prepare_enable(priv->rclk);
> > > -	if (!rc)
> > > -		return 0;
> > > +	priv->rclk =3D devm_clk_get_optional_enabled(priv->dev, "RCLK");
> > > +	if (IS_ERR(priv->rclk))
> > > +		return PTR_ERR(priv->rclk);
> > > -cleanup_clk:
> > > -	clk_disable_unprepare(priv->clk);
> > > -
> > > -	return rc;
> > > +	return 0;
> >=20
> > You're changing semantics here. Before your patch ftgmac100_setup_clk()
> > was left with priv->clk disabled; now you keep it enabled.
> Before my patch, ftgmac100_setup_clk() was only left with priv->clk disab=
led
> when error occurs, and was left with priv->clk enabled when no error occu=
rs
> because when enabling priv->rclk successfully, it will return 0 directly,
> and when enabling priv->rclk failed, it will disable priv->clk.
>=20
> It turns out that the code logic is a bit counter-intuitive, but the
> readability has been improved after adjustments.

Indeed. This is IMHO worth mentioning in the commit log to prevent the
next reviewer stumble over the same code construct.

Best regards
Uwe

--se74eiqu42ro53lu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbXMLEACgkQj4D7WH0S
/k5L/wf9Gs22UgHjYPS/+O96Cu4w4UcP3q7nPHpOoDSXi2BXtkrd7ABWKXFV2G9v
0DkiId7UylOmQ86aa7znTZywltkTX8AItXV6lq02kZPov3/57jw8RcpHRc694mrH
PxmFxBPFAtoh5SlzCoBzgViqv+dfxcd9r4yniENbBn1gH2j1SH/XsJRypXr8PaUy
HHvPiIhlO4ylM2U3QM3ojnUNGER5I5Oq2Ge8PYhd7B118KogrbcAlMm52+cN+Emt
M+kDaR5zXhRN/Xlknj3YnVNtzyYxfF6iNjOLSVQue1CxjbsHXwYWt+gUMwZ9U7mi
M/GMHgxWenCtKXfzEgHtrXqAzvSsNA==
=H+qA
-----END PGP SIGNATURE-----

--se74eiqu42ro53lu--

