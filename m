Return-Path: <linux-wireless+bounces-31016-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB94LdpOcGlvXQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31016-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 04:58:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA8250B1E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 04:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39783748C77
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9C33E95B1;
	Tue, 20 Jan 2026 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yuf7OtuU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751173D34B2
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904872; cv=pass; b=mtBJLQDES0HqEdX2Olqrki0pQ904vnYaDOH3QCEQNw/j74ipjVwRsMSHO2imPlRehcfuvOdkiyftBdrN1RGknsSgjT/EKPdTvdMLBUq9NfTDdl1MEHLHbq0Ylb0Uk7JtQpr6HFRh6BHcca/RAKWEibp6eA08fGfjmgNZtU5C34o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904872; c=relaxed/simple;
	bh=07idC1GmCrNrfYK8Qy2V4mxBASfpPWP6F+yFcUb/4fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACY9FQKsaFFfIrHdc5Z0lN8ZxM9SbIz6uFMG94mN640E1pPa07b+85zf2AVgu/QuT1hk/PjLbi/wP9wvrL+/zsPrGxUg3MkZYR2cpbAyZ2eDRgm4IubftUYiD1zsrL4LK6ZPWJKtRf6FlbqJxAZToSVfibogNubnWIcUThzIAe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yuf7OtuU; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-382f087e6c9so28471041fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:27:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904867; cv=none;
        d=google.com; s=arc-20240605;
        b=ZjRMudMem0TUtBvOmTUShbst3gPxhGwaSh9xpI2fDxgII9cMkPk1ckKBj32PNo0iXY
         P7lBTz/60DAGgQoSiWJ6ob5PObgA26CoEO5ECGDUmwbzOmTP1lD/NZq+Sgv4U5fRYMw1
         AzFpjBRvJ6DkL09Wm8Ira6BIMcUweQvcWtmpm6QI0MVLv7PwaQH5HC9keoeGoEM8p51L
         tCk5ONq9T7Z23unQ0FQ5DBcjZK1Siywl/2E4RIuXMb5xg/uC/bvSmc4d2LaqtT7KzdAk
         qzkYGmSqI+Mu30KWrxymWS2lWdbfzu7vGFqgGWUooblXUpthkFXeHGw5/sPr1VrwCKh9
         dThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zcWF83k9wfYKZ/pKRWhqE/Kqb04cd3WQEzcDFN468g=;
        fh=l8AiBsJSnrGAZjfD8yc2B8i7xhUp06yT/6pX5+iSOrc=;
        b=Hf6QsbNWpo6bQLVgWdf7J59mwdvRrOAKHQrWPqftLcKjhx4ULWLUxfVFZ8Thz2kc+L
         BKN0/y2MR73a9lBlgAK8T7d2c1ky6dqdR+JpR9bRCre760OuHji59YEoKG3gJuE8cUUv
         +e6yV0KayHINwC+Lltz5h1VaRjH+vhvTaV7Fm0qBXIoacG8axR4K09Tuiu+dPGoU5O/r
         upT8iAAhtY7QgWJEGStXMfrxd3MxS/DK1wQ9OB/etzL/GWqMoVDePnqoZ25GK5lr4ip0
         L/Ib6asWd3wRDEHPbFANrrwt+Hhpf/RvPYq30BbWz4loS4uQTDf3MMECESQMbfyWgIz1
         wS0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768904867; x=1769509667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zcWF83k9wfYKZ/pKRWhqE/Kqb04cd3WQEzcDFN468g=;
        b=Yuf7OtuUDfS5/lsLHSZMaQDKnJWqMRmw1ckG7aEY7USvvKCMTFqSy4gQCm4oHm6lGd
         vNQT++mqJwJdtwXaVABNudNiRl1N62sQ/JEGIJnbpvaStn5Ge4X5CIf2Om9vS51ejGIs
         T/Qpp3fvGwfaVrtp7bojdmD9YAGlLBRERmoKwtHXa52V9mVdvbUEU9YZhNfccZqnWqed
         8x8slOqi1oUuyGd1g5hoCp5HEcKY8FGUcuTS0C0Vm17cJWfgUW7+pENTrUf3ntWtwDSp
         Bi3s5M8cN356hZqJeB18ft6QYI51/fTORWoVp+k8aRPcylMRhopubtMgulYYOj7M0vRE
         7zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904867; x=1769509667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zcWF83k9wfYKZ/pKRWhqE/Kqb04cd3WQEzcDFN468g=;
        b=LVZEkSkaCax9MqzgNgua3NChhj05/RjN3+Qfd7uUxcLgV/UJmAoEV1IcAunLwBuPX/
         cMpmNYzbNQUJ3ibISxEjYUsruOVOyL5HBlQI5+QCby7TR/YmvShhmy4z4QZC/KSHeX8W
         AkNvdYkoC616iq9Dgvg1Hp4kfWvfXahds7pk00lZT+HjK02lO7EmOPEzP59KTx27eNv2
         GeQSZbQxIoCfhdLiID5xKEA3BSpMjBNG+O8MJ+pIdYj68mYtJNUqgDWYhPXG2Ka+z0dk
         QdHvnUmtigFL/oxEV14jUmVsUfBaJDS5L6BVAWtLItgH8/aOce82+uFsuiQ+G2Cd+LKR
         Ulyw==
X-Forwarded-Encrypted: i=1; AJvYcCV7HohevlOTVCx+ScFbKIZCte5pLdLpeT6eg3v5y1GecWeV58VncCl2z7eZocxYHumaX3z3hfNe8wVFtYytOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl1+LgIeBxKHkl5yx5h12opVteMe3JWA3tHvhjfkM/jEde2SfU
	kLM9+bIzpJpQjn8j8BzBekz8pzEKh91YCL1s11HBnIlZPgfIa9MerCxmFbaQRmBJfuFSVIgzcUu
	4nB4MZTN9GndsjPDPAAJcoRcYjg1HZzKEg44QsICsXNAWKgtQp7SV
X-Gm-Gg: AZuq6aLFs7uWH/cpW2lM1AS33/BtUp/BpMc73GGyioqmlresKQYc2TqbteA8mOULVCI
	vfG7rIkF2ymZywHi39yHwEu0UhpPgJMmpCldZOnya94hihpL4P+NKQvWh+mnd0Bjt+RcTEu6tJW
	kxWDCUOY1zOfa8q61ufc1WVR/hDykr28CGWxt/rTLsSkYfyTrdyb84irpWpAvUd4EETRkASJNLG
	5HNbnIaW9wE1Eg6/Dxbj15hpZTRORCH09r0FMppnozUIkl4QnaPGHc2EvTwxyLbh+t697q4zCu6
	ixjVxw==
X-Received: by 2002:a05:6512:8011:20b0:59b:b3df:cd79 with SMTP id
 2adb3069b0e04-59bb3dfcdf6mr2962095e87.10.1768904867209; Tue, 20 Jan 2026
 02:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com> <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Jan 2026 11:27:11 +0100
X-Gm-Features: AZwV_QjFjXjc-U8euh4MC9z2kFcNJA0P9wX41pDZQ4VLxKcd4e9zNglVFRdV4L4
Message-ID: <CAPDyKFrinbj0QdL4rAP7zCvcnc6kGRQDTbiq1H0nRd+-B+HWnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31016-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,baylibre.com:email,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 2DA8250B1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Johannes, please pick this via your tree. And sorry for the delay in
reviewing this!

Kind regards
Uffe

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

