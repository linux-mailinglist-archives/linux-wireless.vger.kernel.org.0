Return-Path: <linux-wireless+bounces-21365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0017A835DF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 03:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827F54470FC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 01:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040521991DB;
	Thu, 10 Apr 2025 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSLiPBhj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F65BA33;
	Thu, 10 Apr 2025 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249378; cv=none; b=Z8hvYBTil84C1crbPLG3oAQotOv4nR6jqiCSo6ogcwJwclp8ALqHeeSneQeo0DvWdAqcfNPr5Hlz1h9XsMHX6XKi+B9piVX/x0LMyw/zc9Hvm0ob8TuPvtoYhoFb6OqPsuHh7HhYYGTPslTNZqhA780GpPnBF0k7pDKN4xlwuz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249378; c=relaxed/simple;
	bh=FE5mg5D/FN4YxnnYwiIXf8DA/W0lGp9e0a8+yjUH2fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBQN6LngAmcRzUk/nmjLBUsbWdMHfKbjrqM4DvlIPkBIbrfCXd4BpKkKIHZfDfw4a7b32eoSF3XA+MjUa9ENMz9NuKc6W1KHbXEmwznQ7OmCbNxmEqLy0zT8A+LBPhV6EG7idbO7LXBro/u+QaJbm9rsZzGDHR3zX56e7daT3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSLiPBhj; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e6e1cd3f1c5so266544276.0;
        Wed, 09 Apr 2025 18:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744249376; x=1744854176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+pLSC11elsCS/6G5qk4DJNIoM6zld73Dfy4WuRuhA4=;
        b=YSLiPBhjzWkfL25vqZ4c8uaBnprlwvAgKemjoO5GiU1W8BGpwFA0IpH5znWpan7mQf
         3CSxVBYbekkji+BxIcjVdIT0UVaEJ+tx8c5hRoqmDwRcJiOlbilRoyPlNXyvh6oX3xXT
         F8pySR06s8KjAwhz8k31ibxwD8KULK6n8VcsmDbf2Pw9wG1QREs1GxOsLSZI3xF90wNl
         fdor0yNnIzTQlTNEQWfiM+W7W3A/OZuZQuSH4Wbd4+D02RXuwS/f4CerrWtwh4G3vAiZ
         YCxTnSzk72JjlojzociGNKrvJl4GcvgjYsYcql202lwy7u/YdkX8UWtKJydZCYV4amVO
         Drdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744249376; x=1744854176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+pLSC11elsCS/6G5qk4DJNIoM6zld73Dfy4WuRuhA4=;
        b=YQi5qIfKcf19VX4W2ED+F5lBas5b5dnmiIEvHE2bRtVx5jFO+ZzHsR12cFngRljY27
         Y665zbBwWHGncHyEPOyjRELI/5uSULQY+pfSVxJSbGiXhEJMlhLZAWbRAPV3DTFj9CTc
         VUOH6YYWQ1NXKZrBwtylmT/kBRz4F+oMG1PTKKcBjlqnud5NbeTq52VgIaksQ8GGewyg
         FPJXlGo4adiqkwmgxSHJipIAeIWDQv/X1IsTz6SNTdbr+2bdHvVZbLnqvXYh3UxAsz/e
         r/QEKS+bKIX+GtO+1D3v5eaRW959URsaJCHpvEp16m9KmYL1HB3oMUuE/ra9iZludSI5
         Wzgw==
X-Forwarded-Encrypted: i=1; AJvYcCWaAJHDpHlvpa8rKW3xccqBulF/4iTAOn/UxprkSL00GXcaGlx7LkEtO1mWTUG1SCs2rVGkVuVp27YLHgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOsvFmCF4Onb6p2gKUw/Vqc1gBnrb2XS9UMQ1fpRY5kvMzuGM
	OkS4ILexyg1T94bfSfjiz1ZQSIrNObGpvMS14edUGnqqNA+2HlWxMWtxUfmmH18BQTPDyi2DPyr
	9gT2GxfpWVfcuoN1zUyYCZj7zVYqvcA==
X-Gm-Gg: ASbGnctZM+cN98kW3wXF9AIqnxnFQF9Xa2FtR187DLkunr3IhEQXM2QX8IkBXI7SOrH
	Am9EYrZ1jjIpyBaHWQRC95uI5SMwycNEnsEA3vvjlW/dy41IeZRXam5ENBNR7EaNB6c7iiQQPg4
	FbNggL+/MgKDyynmcj1p9bGX3adnpdKDP0dLg=
X-Google-Smtp-Source: AGHT+IGsUvTGRc4LfHfAtpGZm6PYwsb1DTq6D9tF/s/WMOl7uLwiGys2RtGoUMjI6FJv3Tl76eEvvS83n8Lf7wJSJow=
X-Received: by 2002:a05:6902:478c:b0:e6b:834d:f0f5 with SMTP id
 3f1490d57ef6-e703e1f9984mr1932648276.39.1744249376163; Wed, 09 Apr 2025
 18:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410004130.49620-1-rosenp@gmail.com>
In-Reply-To: <20250410004130.49620-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 9 Apr 2025 18:42:45 -0700
X-Gm-Features: ATxdqUEJb1ak6ViqGrp-RQbdrNKzRMl9LIVcUePjvSUpiyC72rKUHkX2lRQFDoA
Message-ID: <CAKxU2N8y6Kj6hfx4LxC+K0Jc9VRYfE-LHBVBAaC-4EcXy_6GqQ@mail.gmail.com>
Subject: Re: [PATCH net-next] wifi: ath9k: use devm for irq and ioremap resource
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:41=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrote=
:
>
> Avoids having to manually free. Both of these get called and removed in
> probe only and are safe to convert.
>
> devm_platform_ioremap_resource is different as it also calls
> devm_request_memory_region, which requires non overlapping memory
> regions. Luckily, that seems to be the case.
>
> Tested on a TP-Link Archer C7v2.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
whoops. net-next should not be in the title.
> ---
>  drivers/net/wireless/ath/ath9k/ahb.c | 22 ++++++----------------
>  drivers/net/wireless/ath/ath9k/pci.c |  9 +++------
>  2 files changed, 9 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/=
ath/ath9k/ahb.c
> index d4805e02b927..636a487bf9b4 100644
> --- a/drivers/net/wireless/ath/ath9k/ahb.c
> +++ b/drivers/net/wireless/ath/ath9k/ahb.c
> @@ -74,7 +74,6 @@ static int ath_ahb_probe(struct platform_device *pdev)
>         void __iomem *mem;
>         struct ath_softc *sc;
>         struct ieee80211_hw *hw;
> -       struct resource *res;
>         const struct platform_device_id *id =3D platform_get_device_id(pd=
ev);
>         int irq;
>         int ret =3D 0;
> @@ -86,16 +85,10 @@ static int ath_ahb_probe(struct platform_device *pdev=
)
>                 return -EINVAL;
>         }
>
> -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (res =3D=3D NULL) {
> -               dev_err(&pdev->dev, "no memory resource found\n");
> -               return -ENXIO;
> -       }
> -
> -       mem =3D devm_ioremap(&pdev->dev, res->start, resource_size(res));
> -       if (mem =3D=3D NULL) {
> +       mem =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(mem)) {
>                 dev_err(&pdev->dev, "ioremap failed\n");
> -               return -ENOMEM;
> +               return PTR_ERR(mem);
>         }
>
>         irq =3D platform_get_irq(pdev, 0);
> @@ -118,16 +111,16 @@ static int ath_ahb_probe(struct platform_device *pd=
ev)
>         sc->mem =3D mem;
>         sc->irq =3D irq;
>
> -       ret =3D request_irq(irq, ath_isr, IRQF_SHARED, "ath9k", sc);
> +       ret =3D devm_request_irq(&pdev->dev, irq, ath_isr, IRQF_SHARED, "=
ath9k", sc);
>         if (ret) {
>                 dev_err(&pdev->dev, "request_irq failed\n");
> -               goto err_free_hw;
> +               return ret;
>         }
>
>         ret =3D ath9k_init_device(id->driver_data, sc, &ath_ahb_bus_ops);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to initialize device\n");
> -               goto err_irq;
> +               goto err_free_hw;
>         }
>
>         ah =3D sc->sc_ah;
> @@ -137,8 +130,6 @@ static int ath_ahb_probe(struct platform_device *pdev=
)
>
>         return 0;
>
> - err_irq:
> -       free_irq(irq, sc);
>   err_free_hw:
>         ieee80211_free_hw(hw);
>         return ret;
> @@ -152,7 +143,6 @@ static void ath_ahb_remove(struct platform_device *pd=
ev)
>                 struct ath_softc *sc =3D hw->priv;
>
>                 ath9k_deinit_device(sc);
> -               free_irq(sc->irq, sc);
>                 ieee80211_free_hw(sc->hw);
>         }
>  }
> diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/=
ath/ath9k/pci.c
> index 27d4034c814e..48c7cae11e37 100644
> --- a/drivers/net/wireless/ath/ath9k/pci.c
> +++ b/drivers/net/wireless/ath/ath9k/pci.c
> @@ -965,9 +965,9 @@ static int ath_pci_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>         }
>
>         if (!msi_enabled)
> -               ret =3D request_irq(pdev->irq, ath_isr, IRQF_SHARED, "ath=
9k", sc);
> +               ret =3D devm_request_irq(&pdev->dev, pdev->irq, ath_isr, =
IRQF_SHARED, "ath9k", sc);
>         else
> -               ret =3D request_irq(pdev->irq, ath_isr, 0, "ath9k", sc);
> +               ret =3D devm_request_irq(&pdev->dev, pdev->irq, ath_isr, =
0, "ath9k", sc);
>
>         if (ret) {
>                 dev_err(&pdev->dev, "request_irq failed\n");
> @@ -979,7 +979,7 @@ static int ath_pci_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>         ret =3D ath9k_init_device(id->device, sc, &ath_pci_bus_ops);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to initialize device\n");
> -               goto err_init;
> +               goto err_irq;
>         }
>
>         sc->sc_ah->msi_enabled =3D msi_enabled;
> @@ -991,8 +991,6 @@ static int ath_pci_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>
>         return 0;
>
> -err_init:
> -       free_irq(sc->irq, sc);
>  err_irq:
>         ieee80211_free_hw(hw);
>         return ret;
> @@ -1006,7 +1004,6 @@ static void ath_pci_remove(struct pci_dev *pdev)
>         if (!is_ath9k_unloaded)
>                 sc->sc_ah->ah_flags |=3D AH_UNPLUGGED;
>         ath9k_deinit_device(sc);
> -       free_irq(sc->irq, sc);
>         ieee80211_free_hw(sc->hw);
>  }
>
> --
> 2.49.0
>

