Return-Path: <linux-wireless+bounces-25319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36122B02C83
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 21:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23E0A43392
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7021CA07;
	Sat, 12 Jul 2025 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlE+bTer"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB0111BF;
	Sat, 12 Jul 2025 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752346969; cv=none; b=KfcHyOrarb5MHMJZYkiz+iADiMBltLEFRCRFpSijIu20XTfqLHNYGlPOxmRomsTyDCr3ff1f4BW6NZI753SmqqgGlTA4SXOb5nKxmpusrtpBZRw6TtiekXY22/t8yoT6GpjEK2hGfTn9YUulqQUb8o6kq1sLw3seZAUygBEienU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752346969; c=relaxed/simple;
	bh=vtn00/acv8Ntu3iUdwD+nWrG9p/YSB83LIEsEWKljXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/GUFTIPkZIgN89TH119eYIC68+S3HZJsq0IdxNDXNGVzXDc690meWEMv4CKv0AQgO0QDmbfj+b9E6caqxkSPK7yuYVpvRBk0/aRem15IjoEtIm0uGTpG8ddw+mTxp70ZJSSLz/QyO6RjeN886Kbjk7NYSnAhSZw6JF6ARnh79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlE+bTer; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e81a7d90835so2582855276.1;
        Sat, 12 Jul 2025 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752346967; x=1752951767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKagfN2d5XxVdHG3XeAT69zzT+aJHWetXb6KF0S4PHA=;
        b=LlE+bTerG+UypJtRF34/uyfIloQHVbBIuDp1+e2OfGzJRDMcnJYkhcmlHjQeW2kNNv
         Y+tcZWN5+JXGsrSN5vdmSrK8vU2bie07njh/HDG56lJ2ZMDi9+hHOK/CqaxFidaLKy+N
         C7t3jj7LoAM+6PEh1Nq469HKUpXwRX7yJCZs2je/hUvz4kW6puRKURcOMeXF8QABbuag
         AXt0kuIeMi2/zMAHV5aoIW7kNAU71FTZfF8wVdSwaMJgPvSlf0b/5bW8r+28UZDHsNlp
         8W+wJl28PWETAl9ltw5epybGTxlS8xNx3Zr2Nki7kGTC4tSM5o5SeHxcou0kZkPr66K9
         npgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752346967; x=1752951767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKagfN2d5XxVdHG3XeAT69zzT+aJHWetXb6KF0S4PHA=;
        b=E+DaRV3E22QmNtqgmGUjtP7ndf32lTURvadzJEql0BklX4Wr5ZZHtDk7qKp7T8ECa3
         t2Arz+flYWdM+XpyyibDn+AFdgonXbyXoUooWKY3KUuld9dC8xQ8ZKlAnpAPIwWsOL4+
         9VEeT4U6UocQlekbqahvIcMOkWTnhQUx6t8jdpZvDQqejH6QGTs6mie+b6x+C5tdIm+R
         0RpmJYZD3ea/FqTSoCcj8qdG2qqbfHA2gcySxapOYHFi0+qNCFm4Yf94+LGMGx2SWOVt
         srbIo52NRAWI5wLBzukLt36z3HCnCa7TTNKUq/16YGB41e1dbeQJN0K5uQPop9HNxfrN
         tWaA==
X-Forwarded-Encrypted: i=1; AJvYcCVqk7i33qrCIbUMzln1hUVDm62hWI8qMTQ/949amfWVKA4rmdVR/b1ROc0CSRMG9JRaFZK92xy6kCCS9kuB@vger.kernel.org, AJvYcCWG2BsWQDY/Rf8x0jY4ekRH2FrMeJqLgPhvQk5haDbg9hf3Yrtm+SA3/LKocMMWQnTrufHiMlpkfVq9@vger.kernel.org, AJvYcCWcDLcjTTC9JDLaPvi147PXiI+fGUcIFuVA3/jMeo01lXsg9PbwQUiYLCLvmFx9uzINhrri92lnIcuplw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAqH41b3mePELUi7ogooWrVQHNNyEpbKnvWSAIJsA/t+Ribze7
	9ia1rwo0LvpPNDmCPVfJSAT8TlYkvBNNSm8VLWc2Y0E4+G4bOiOGX2fHL94ffekME5ryv0n/2Fo
	0eHAiJgOdEX/IaeKKc/Wjx6zwGRL2/lQ=
X-Gm-Gg: ASbGnctfqO3YK4WfjDZ4w3q9YDpkCTp22fK9Rkavo3vouGv3tbi8nA/zZ7+D5iyibFe
	pEMFgZnNm/+7E50aYUHHd+Mcc5aIzW9snwCLKeWbOZCC11H6P5U2TiVKQihnO4CrvwITAt3dhSm
	YLwDvEaKMNY2enAf/+CbuhS8pdNjOetayGErNAzcKrCl2Xb49p4OnQrZuZEQWE8PVP1RukwRM4Q
	IXR42Juyo5md1Sgeiue
X-Google-Smtp-Source: AGHT+IGcVwtnhZTlH9ebXa+wUvIAcCciQYTgsn0OHcrVkEU41TNWJ0CyN7Bjj8sV/x/9RM6/03LPIHWkDmUeM8sMpF4=
X-Received: by 2002:a05:690c:3687:b0:710:f39f:4d3f with SMTP id
 00721157ae682-717d786ddb7mr116815487b3.5.1752346966755; Sat, 12 Jul 2025
 12:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710200820.262295-1-rosenp@gmail.com> <20250710200820.262295-4-rosenp@gmail.com>
 <20250712101418.GD9845@wp.pl>
In-Reply-To: <20250712101418.GD9845@wp.pl>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 12 Jul 2025 12:02:35 -0700
X-Gm-Features: Ac12FXx4rcjDaaA71XVlUBA-AkCziwkS6KnteMro8jng8d1wYOSRPnIgM60fm5s
Message-ID: <CAKxU2N-RXgFKYPAqEu3iZDMAisj_K-b+ZZTGFsabWz7pMK+02A@mail.gmail.com>
Subject: Re: [PATCHv3 wireless-next 3/7] wifi: rt2800soc: allow loading from OF
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 3:14=E2=80=AFAM Stanislaw Gruszka <stf_xl@wp.pl> wr=
ote:
>
> On Thu, Jul 10, 2025 at 01:08:16PM -0700, Rosen Penev wrote:
> > Add a single binding to help the already present dts files load the
> > driver. More are possible but there doesn't seem to be a significant
> > difference between them to justify this.
> >
> > Use wifi name per dtschema requirements.
> >
> > The data field will be used to remove the custom non static probe
> > function and use of_device_get_match_data.
> >
> > Added OF dependency to SOC CONFIG as adding of_match_table without OF
> > being present makes no sense.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/net/wireless/ralink/rt2x00/Kconfig     | 2 +-
> >  drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 7 +++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/w=
ireless/ralink/rt2x00/Kconfig
> > index 3a32ceead54f..a0dc9a751234 100644
> > --- a/drivers/net/wireless/ralink/rt2x00/Kconfig
> > +++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
> > @@ -202,7 +202,7 @@ endif
> >
> >  config RT2800SOC
> >       tristate "Ralink WiSoC support"
> > -     depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
> > +     depends on OF && (SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPI=
LE_TEST)
> >       select RT2X00_LIB_SOC
> >       select RT2X00_LIB_MMIO
> >       select RT2X00_LIB_CRYPTO
> > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/n=
et/wireless/ralink/rt2x00/rt2800soc.c
> > index e73394cf6ea6..db8d01f0cdc3 100644
> > --- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> > +++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> > @@ -243,9 +243,16 @@ static int rt2800soc_probe(struct platform_device =
*pdev)
> >       return rt2x00soc_probe(pdev, &rt2800soc_ops);
> >  }
> >
> > +static const struct of_device_id rt2880_wmac_match[] =3D {
> > +     { .compatible =3D "ralink,rt2880-wifi", .data =3D &rt2800soc_ops =
},
>
> Why do .data =3D rt2800soc_ops here and use it via of_device_get_match_da=
ta()
> in patch 5, insead of just use rt2800soc_ops directly in rt2800soc_probe =
?
I see more of the former instead of the latter in drivers.
>
> Regards
> Stanislaw
>
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, rt2880_wmac_match);
> > +
> >  static struct platform_driver rt2800soc_driver =3D {
> >       .driver         =3D {
> >               .name           =3D "rt2800_wmac",
> > +             .of_match_table =3D rt2880_wmac_match,
> >       },
> >       .probe          =3D rt2800soc_probe,
> >       .remove         =3D rt2x00soc_remove,
> > --
> > 2.50.0
> >

