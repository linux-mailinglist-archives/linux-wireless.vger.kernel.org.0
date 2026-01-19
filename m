Return-Path: <linux-wireless+bounces-30963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62999D3AE70
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 16:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6544A303A095
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C1C3816F0;
	Mon, 19 Jan 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ou3kprCJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E23803F1
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834890; cv=pass; b=VMdZkCCFpeFRyrDUOeBEK1wYY6Ljic7gM9bjtL+gUC9mZto1oHrIr7m7Jcc2gewUgLfCbV4mLjzLNezhzgDjszyD/8otLYTU8mkffYsSiTIUh2R4kuAQBKKGnTFkDbkECaiM5lU7ZSJ1JTyZB6nKZVBTWT0q/a9yL3vAmZBpKZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834890; c=relaxed/simple;
	bh=ToP/wjEEUKdgWYrBRUQfG/i07QfxwnL87suiJ07Oc6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u05sAJmV1HLC84nV/xCpC8l/8ckQjYnmEAe8Zvd997R0Kdx/JejQhs/GA42eLziDS2W+xhlmATcTP0fc6wqZL+mcqAK8d3lazpnE55SHyl1uHHlxABcOvo1aEKT06KEDF7xNK9mHL4J2ut4mOFPLvx/7EqVMp7Q7S/hLoYsLC78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ou3kprCJ; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b679cff1fso3939884e87.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 07:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768834887; cv=none;
        d=google.com; s=arc-20240605;
        b=ES8uOYBJzPR9Ciucgcp4jxUUx2N7hJRF+g61Mbeis08q8opBi0c5Fg9D8CFc115aBc
         UeSevbbqlS0dYrYveMcHeSFE5DDgVvsbwRx/745RMDQsU0pU96IQCPhIzWcLBzHaQdL1
         f5al8F8HcRyBOX5FDU8y2LlxPKEGebVVO/m8KuGAyh3FvBuOQa66aG6Ge19syXcBAa4F
         xxagE75+27kl0yoSBc8EZDeG9hAUP2xzsd9chf/KM2SoIWToy3KuIyzIwgtPYsBI23t+
         bsyHzN4OoY8CYOVXNz5mUr4/X8ZpTGB6LpABCOV4NxNQEW+ry9s6wnxGmAe/0Ug4Pxuu
         dBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7en7/xIG4SBtAoiVCkkhvxRBMacBsb7Kwqq2bQY1J8U=;
        fh=yV/F8nCIz9H0aBvhidQsC3aotqPp6bFJe4zH2/HZ4Ug=;
        b=ZHc/ic73nvSGJT6YKm6VuNrdSf2XPk3o7FU0FgAFOf9pdqMCK8AZs2nBdpiH+GV1at
         w9Lo/LfnC4bu4eEoTcFXBMd+J2bks34sDfCUKUnnA+pQ27pArGbuv3n3u17zuC7U6cF4
         S/LPITtB/HR37EOXk7zoSjWcpzM3rbv8uyRAIM5LKc5kOMrxfaRrov+wBdX3dfxN81fh
         AJRe91rYdM1OVZHrhXVLSlhyBqxD3tVdDWzZhgd7M6KSoTd2Dhg0de8wJI8YHx+adi0+
         qkBhl1V5tLL7rvvbc0A7/YUv4DtbHINRwrt5bgsebmS7LSZjywkF5NTjRCzQr6B2cyHe
         A0yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768834887; x=1769439687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7en7/xIG4SBtAoiVCkkhvxRBMacBsb7Kwqq2bQY1J8U=;
        b=Ou3kprCJfmMOcNKC5GNUv3/3TTqeJUavhAMs7QxcRK8ZAnVe7aEMKP55rx5N7JP1cV
         yrRbxIxy08vJ1pOFgLqzNfatWJPS9YkCF9SRbevo+8Lby+tWh4PROtYPi1DgB1jTI6Wn
         w/Q9Mw1eDl1ci3B4GjOmiBjleR0c8VkCCeA+O/NGF2yo1VcDaxs7Gg/u31CoxTjVT0NM
         RJkDWkhC3LGOwfkCV8hj7E14lq6BSimEFaumnqeypwe/TjsUi4U/Hgi7xGPSvXCl9QJ+
         HR4BvfUxxnS5+8pAeL2TEX3Mx6Ho0uja4nQiv979Pjii5k+a7jZ+gqoxIIa8lqyRI/AQ
         WGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768834887; x=1769439687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7en7/xIG4SBtAoiVCkkhvxRBMacBsb7Kwqq2bQY1J8U=;
        b=N6bEhVIz6uSH1UqK0H0Fc0+mnxe2tOgBgjdIlPvoNdefx7txDI6bTtzIqJDlqPIPAC
         /aAysENEe63P3g1TCu3XgIxUz9wL/VEFcpnK4QGSLrzIUJQMU08uylIlGWxR6pRbNYev
         Vj7YOKggNtazYpdSHTzuM1Pe3+kNjyHXGLdxBTQ646gAVBNxVf1ql9NRrgEh2VCNvniw
         GWhcxI7ZeC2nB2O5++UQ5GgvHw3wgzTqn7cx8jgMm3fJxfg140ofyI3D0a4dW/op3alX
         l/BsXv7jGvT4X3/zpyaB/Qk7H+qFnfj0LTwMacgtfRD25Y6ZBJd6IPRDnWGzm09AI1ZT
         ng7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7R7s6NbZ3KjIqPDoRRUpIEzypYn2LA4dbsvVUB93/SgI4C8m7bOyGfbFFEoXXJgqUJ9DBWZRrmdHQvXaKeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQxb4WlvKW3fe344k8bUPNIFXDqoHTgwScgsUO/zNCOf4hg8dO
	z3w5v3czu4KNsEuQmfxx0f5Q7zUs/zsuKL+b5Py55wcNtBnavmbOy9jpxLm2+mfNCRDk/T02B5b
	ZP5IqP4PCg5PqFu1kGMkUr6IFUtPCDip9bpcnJiwhQA==
X-Gm-Gg: AY/fxX7OBJKMIkaAbadKr9duHBSCR00xXI019j1Z6NzIHwtmsAiV4P2BNO2oZ1f3w5a
	p/zXoxKMVp9fNaquaYwGaKZHoXRVC2q080IYcvfGCZTJMBn3zzxtKddk+srLYd2nHisDVqI4CYB
	HPoslO1A8PB9Dk8cYDo1X3q4H4HWJ9T6CXSeY6VpUr8W0xgq6rc+VS869/CAyQQ1avymh+7fMFo
	8TZ3Wm62Z3vBdo2pJjquSfMh56ECfDTfpRZ50Sd/3U3Mu3CyvFlV67WdtMjvq9tC0TyMTyq
X-Received: by 2002:a05:6512:b98:b0:598:ee60:8af1 with SMTP id
 2adb3069b0e04-59baeed3ebcmr3912991e87.15.1768834886687; Mon, 19 Jan 2026
 07:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com> <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 Jan 2026 16:00:48 +0100
X-Gm-Features: AZwV_Qj4grH1RKk5qfKA25XGG5qhWfI8EZrg4Dt6c7jkFfG6Ya_nNj2n7M1gxV4
Message-ID: <CAPDyKFrman8YodyPNy6fSOYahoFKBuJRN6+Esz7ojmYqessEYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Jan 2026 at 16:47, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> To prepare sdio drivers to migrate away from struct device_driver::shutdo=
wn
> (and then eventually remove that callback) create a serdev driver shutdow=
n
> callback and migration code to keep the existing behaviour. Note this
> introduces a warning for each driver that isn't converted yet to that
> callback at register time.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/mmc/core/sdio_bus.c   | 25 +++++++++++++++++++++++++
>  include/linux/mmc/sdio_func.h |  1 +
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 10799772494a..6e5bdc2f0cc8 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -232,6 +232,15 @@ static void sdio_bus_remove(struct device *dev)
>                 pm_runtime_put_sync(dev);
>  }
>
> +static void sdio_bus_shutdown(struct device *dev)
> +{
> +       struct sdio_driver *drv =3D to_sdio_driver(dev->driver);
> +       struct sdio_func *func =3D dev_to_sdio_func(dev);
> +
> +       if (dev->driver && drv->shutdown)
> +               drv->shutdown(func);
> +}
> +
>  static const struct dev_pm_ops sdio_bus_pm_ops =3D {
>         SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
>         SET_RUNTIME_PM_OPS(
> @@ -248,6 +257,7 @@ static const struct bus_type sdio_bus_type =3D {
>         .uevent         =3D sdio_bus_uevent,
>         .probe          =3D sdio_bus_probe,
>         .remove         =3D sdio_bus_remove,
> +       .shutdown       =3D sdio_bus_shutdown,
>         .pm             =3D &sdio_bus_pm_ops,
>  };
>
> @@ -261,6 +271,14 @@ void sdio_unregister_bus(void)
>         bus_unregister(&sdio_bus_type);
>  }
>
> +static void sdio_legacy_shutdown(struct sdio_func *func)
> +{
> +       struct device *dev =3D &func->dev;
> +       struct device_driver *driver =3D dev->driver;
> +
> +       driver->shutdown(dev);
> +}
> +
>  /**
>   *     __sdio_register_driver - register a function driver
>   *     @drv: SDIO function driver
> @@ -272,6 +290,13 @@ int __sdio_register_driver(struct sdio_driver *drv, =
struct module *owner)
>         drv->drv.bus =3D &sdio_bus_type;
>         drv->drv.owner =3D owner;
>
> +       /*
> +        * This driver needs updating. Note that driver_register() warns =
about
> +        * this, so we're not adding another warning here.
> +        */
> +       if (!drv->shutdown && drv->drv.shutdown)
> +               drv->shutdown =3D sdio_legacy_shutdown;
> +

Is this added only to keep the series bisectable or are there other
(except those you fix in the series) sdio func drivers that make use
of the shutdown callback?

In any case, when are you planning to remove this?

>         return driver_register(&drv->drv);
>  }
>  EXPORT_SYMBOL_GPL(__sdio_register_driver);
> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.=
h
> index fed1f5f4a8d3..4534bf462aac 100644
> --- a/include/linux/mmc/sdio_func.h
> +++ b/include/linux/mmc/sdio_func.h
> @@ -78,6 +78,7 @@ struct sdio_driver {
>
>         int (*probe)(struct sdio_func *, const struct sdio_device_id *);
>         void (*remove)(struct sdio_func *);
> +       void (*shutdown)(struct sdio_func *);
>
>         struct device_driver drv;
>  };
> --
> 2.47.3
>

Kind regards
Uffe

