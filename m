Return-Path: <linux-wireless+bounces-11397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14F99516F4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 10:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D83F28624D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69637149C46;
	Wed, 14 Aug 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOzM+mpY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630E14375C;
	Wed, 14 Aug 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625236; cv=none; b=tFcZsYbqhfvqu3b3NXsO5tdS8Scqw1hhpODrWpCCwwQ9iK8KJHA9AS4usdWZbSCoZAB72I/lVjMUcnBmLU/nmQpebpcsLHh3a1ucTxnVVWVD7v5uQp9WGOPYYRT1lGVFjMV6t2WM4pkqBtXy4sKWYH0m10jYqQsztsIwz3nC6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625236; c=relaxed/simple;
	bh=UNXzIpOo4I3UGLxgdEwwuDOJCsyLxZPjEX/otvupq/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDQxt+XJDOsn8BTAzRa7dZo8Um21eIViZgDeFfLx6tyCnuPbgszaTPkzEy1gXr+xASk1HxrH2VOMhiQGuQtbn+Dh35fhlDu0iJPbuZ7/ueDFjhxAahTsRsgnbCDYyXHBtqnEVZ/3v1almG2vJLLAqyjX+3cqLrmIp94M4ZrR/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOzM+mpY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-530e2287825so5946780e87.1;
        Wed, 14 Aug 2024 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723625233; x=1724230033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v93U00J3W/G+3iiDSm+KOsmeueDudNy3zc5gSs6I6cA=;
        b=VOzM+mpYHFXFwQVGH3OTJJ9qlHl7668QlrtENaRp/G8pt22CBeYXQaeyYDPJ+gzFwW
         fq+ytL5BvTlQGsj59Fc9tpGhVWgpAKicVCkYqdRYVTNbBYwhhbw3cstBOdnhF2F0Nc4L
         Odf+exgaxmjVup42U8dPGWo6xG43hvFy7yJno+GJS9x6ocUTfwZNYV06koTV/jXNvVSy
         Q+2mg44M/PAqcy+9R36ouOG+ULe+6U8Qs/YbCBwWEHZcmmT0zFGSfctEifRqB27ePLGb
         Lx1qI90LxK3ZQVMb4b3aRbAsfymO+ok3emH7RuuMNrmTbqBC7bf99LaN6xnXcsHId94y
         uYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625233; x=1724230033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v93U00J3W/G+3iiDSm+KOsmeueDudNy3zc5gSs6I6cA=;
        b=HtTDZKj48zhHIQOz2cIaRG3JmeVx4cmD6sGbPPMXZSIhw55JTMQiOECP/B9AYtbkcf
         VcID3O+a2X3F8xR0WEfmWez0x8WY7y29xU6JhhrDHXd9gKi0vouEBWlibYKOeMd7l0IX
         c3B0ZMdtHVZ9IWwX0NkqmlP+75qUV4QPVZF7bvEokb0yAMv2QoQIkZD82FmzC5GY7eGh
         uxm1HO+SnDcEfsPIqNcdTxI5d6ecXRhd8W8m2mh+NqytIS8HkC5VFa2bSTKKlDE13phf
         mRUKPywnerUSjhNZ9R8OTJz++vB7y0EjIWmmkYvJh2hJOcLKrNV44qWghV9LJ+9n6tLE
         hOfw==
X-Forwarded-Encrypted: i=1; AJvYcCUIjKqgFDVmsL03mXA2wSz0DMbnBbTgBzFc357r75tn5AnenNWcaUi6t+cD4YUKSZvkMw9fCwZZjARHsgxudowbISMs44N8+T848cq83FSwCY0HccQvNGdShaRI+xnr4qEdWVATZs1dKv2VuXGxu3EmD0s5rpOIFDE4oaWl1pvuoBkAbQmpCeQmY5ORE8mcvd7Ck2u1ANi+eEVUWtYzHTDm
X-Gm-Message-State: AOJu0YzTOvMIwlSfYYpmR3bdfH8J9G7VJb1e112tPESPzGMORk4MqUDR
	6TL9bx5UpaB3wT58Wft2oq76UXmMDUp07X82N+GkefjZ9wozIlsU
X-Google-Smtp-Source: AGHT+IH4EjACtsvCABaDeBjsVWwwYox558+OITuZDnWDDQJqpAVHjQXpEtVnsv3StoTxLrge71ISzA==
X-Received: by 2002:a05:6512:118f:b0:516:d219:3779 with SMTP id 2adb3069b0e04-532edbd5a4emr1271567e87.58.1723625232130;
        Wed, 14 Aug 2024 01:47:12 -0700 (PDT)
Received: from latitude-fedora.localnet ([194.247.191.114])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200f42241sm1180073e87.265.2024.08.14.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:47:11 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org, krzk+dt@kernel.org,
 heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org,
 linux-rockchip@lists.infradead.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 nick@khadas.com, Sai Krishna <saikrishnag@marvell.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Subject:
 Re: [PATCH v10 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Date: Wed, 14 Aug 2024 11:47:09 +0300
Message-ID: <2269063.vFx2qVVIhK@latitude-fedora>
In-Reply-To: <721da64c-42ec-4be6-8ad3-e2685a84823a@broadcom.com>
References:
 <20240813082007.2625841-1-jacobe.zang@wesion.com>
 <20240813082007.2625841-5-jacobe.zang@wesion.com>
 <721da64c-42ec-4be6-8ad3-e2685a84823a@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Arend, Jacobe,

On Tuesday, August 13, 2024 2:57:28=E2=80=AFPM GMT+3 Arend van Spriel wrote:
> On 8/13/2024 10:20 AM, Jacobe Zang wrote:
> > WiFi modules often require 32kHz clock to function. Add support to
> > enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> > to the top of brcmf_of_probe. Change function prototypes from void
> > to int and add appropriate errno's for return values that will be
> > send to bus when error occurred.
>=20
> I was going to say it looks good to me, but....
>=20
> > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> > ---
> >=20
> >   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
> >   .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
> >   .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++--------
> >   .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
> >   .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
> >   .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++---
> >   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
> >   7 files changed, 61 insertions(+), 36 deletions(-)
>=20
> [...]
>=20
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c index
> > e406e11481a62..f19dc7355e0e8 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>=20
> [...]
>=20
> > @@ -113,33 +118,39 @@ void brcmf_of_probe(struct device *dev, enum
> > brcmf_bus_type bus_type,>=20
> >   		of_node_put(root);
> >   =09
> >   	}
> >=20
> > -	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
> > -		return;
> > -
> >=20
> >   	err =3D brcmf_of_get_country_codes(dev, settings);
> >   	if (err)
> >   =09
> >   		brcmf_err("failed to get OF country code map (err=3D%d)
\n", err);
> >   =09
> >   	of_get_mac_address(np, settings->mac);
> >=20
> > -	if (bus_type !=3D BRCMF_BUSTYPE_SDIO)
> > -		return;
> > +	if (bus_type =3D=3D BRCMF_BUSTYPE_SDIO) {
>=20
> Don't like the fact that this now has an extra indentation level and it
> offers no extra benefit. Just keep the original if-statement and return
> 0. Consequently the LPO clock code should move just before the if-stateme=
nt.
> > +		if (of_property_read_u32(np, "brcm,drive-strength",=20
&val) =3D=3D 0)
> > +			sdio->drive_strength =3D val;
> >=20
> > -	if (of_property_read_u32(np, "brcm,drive-strength", &val) =3D=3D 0)
> > -		sdio->drive_strength =3D val;
> > +		/* make sure there are interrupts defined in the node */
> > +		if (!of_property_present(np, "interrupts"))
> > +			return 0;
> >=20
> > -	/* make sure there are interrupts defined in the node */
> > -	if (!of_property_present(np, "interrupts"))
> > -		return;
> > +		irq =3D irq_of_parse_and_map(np, 0);
> > +		if (!irq) {
> > +			brcmf_err("interrupt could not be=20
mapped\n");
> > +			return 0;
> > +		}
> > +		irqf =3D irqd_get_trigger_type(irq_get_irq_data(irq));
> > +
> > +		sdio->oob_irq_supported =3D true;
> > +		sdio->oob_irq_nr =3D irq;
> > +		sdio->oob_irq_flags =3D irqf;
> > +	}
> >=20
> > -	irq =3D irq_of_parse_and_map(np, 0);
> > -	if (!irq) {
> > -		brcmf_err("interrupt could not be mapped\n");
> > -		return;
> > +	clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> > +	if (!IS_ERR_OR_NULL(clk)) {
> > +		brcmf_dbg(INFO, "enabling 32kHz clock\n");
> > +		return clk_set_rate(clk, 32768);
> > +	} else {
> > +		return PTR_ERR_OR_ZERO(clk);
> >=20
> >   	}
>=20
> Change this to:
>  > +	clk =3D devm_clk_get_optional_enabled(dev, "lpo");
>  > +	if (IS_ERR_OR_NULL(clk)) {
>  > +		return PTR_ERR_OR_ZERO(clk);

Perhaps in this case we should go for IS_ERR and PTR_ERR respectively.=20
devm_clk_get_optional_enabled would return NULL when the optional clock is =
not=20
found, so NULL is not an error state but serves as a dummy clock that can b=
e=20
used with clk_set_rate.

This way we won't skip over the interrupts initialization below in case the=
=20
clock is absent.

>  > +	}
>  > +	brcmf_dbg(INFO, "enabling 32kHz clock\n");
>  > +	clk_set_rate(clk, 32768);
>=20
> As said above this should be moved before the if-statement:
>  > -	if (bus_type !=3D BRCMF_BUSTYPE_SDIO)
>  > -		return 0;
> >=20
> > -	irqf =3D irqd_get_trigger_type(irq_get_irq_data(irq));
> >=20
> > -	sdio->oob_irq_supported =3D true;
> > -	sdio->oob_irq_nr =3D irq;
> > -	sdio->oob_irq_flags =3D irqf;
> > +	return 0;
> >=20
> >   }

Best regards,
Alexey



