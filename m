Return-Path: <linux-wireless+bounces-3130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C1E849F44
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BEC1C21713
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA333CD9;
	Mon,  5 Feb 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPkkiTrC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16A32C90
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149279; cv=none; b=kdvYqTvWbWO8M1t0Wm8h261n+V8kbFcfTaPUMa9BMzVxnpu0gFnn6JjU8UvbgQd6OJyOyNswX7cqEDR7W/M+TKzYnIHv1CGIIeE874Nc5+4tNMyGLOpxfogsVQ+CAF90tVXddcf3sSKB8sxw0r5DMPzTJywCoEbS3/M8Ki6Q5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149279; c=relaxed/simple;
	bh=u/tdxtONYEe8qMQ5xAm9sEia0kTIy2tXT0RURmRTv0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihLqXPwefAVfSrTeY9G8kxqC5aUy0kpbi/yA1Qa/NnK3hHOc+891ZN23spAjC3TlYO3DtqduWxYa38lztJ85AoEmgxZIak4DNH1k6+/lnfL6OnfY4jrtHyM3VOtoyVtpE0XA7ajedbw1XO4crqQep1uOSY9eE7U9kFRn7G7yAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oPkkiTrC; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59a45d8ec91so1775573eaf.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Feb 2024 08:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707149276; x=1707754076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GhsVM/adS9vpjWA6Lr2DjRuOomXm3++4vE/uCT9yL/I=;
        b=oPkkiTrCl4LvOV9dtPA+cStkxKx0d0aicNuu9YjoKYIKpOByZxUa9V7Fz0kGBUbgBM
         0AYeRycfYkXAbQKzV5vuM6kJingu9hLzWlPrz+D5HMCx6p/+x5dUUCCNZgl0P/aBAyKN
         US/WjuoesNmcIcFK7UQv2C8bo3fotFGpFWfYOftzkRDdUFA/ZDBYjl8iDr0W7KNd5Imf
         ho/PXeSzqKAwPDH7EWWkzFXhX1vsm09bwl5LsKqTX+o9qku6o6lhkuykXeYL+peaPT5d
         XsPI++e6wneKBKO5sjIbh8O0HPUom5iv+fDL0XatkVZsePrXAGnriP+GugF3q72w/Yz6
         4YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149276; x=1707754076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhsVM/adS9vpjWA6Lr2DjRuOomXm3++4vE/uCT9yL/I=;
        b=jxj5bYf0175StzYUIx7SZzqg1/+xiQwXsjvhq4MvPQLvAB8jst5YpzXJjwqS587kQh
         PLABHmnksA3RSSGTkIU+IITTQmWIfvmE+pcjKvvl3aYGG57kTwfnuTsavihxCBPdEzSH
         p975jkG6r+HUYyHrj7JyYPCdmlCoBTM38bvKQTmO8YwNYwO6oQydq9LG8te7prZT9ik+
         yJUfV61svV1yaJ0PDpsyhhu93HorFnqhZTgZbC6GQedylq+aNx/x3M09TkyWpLsDDxAn
         P76mNeujbWQdSr79BgPm23XxCYSJ7IqKZe+TXhG12xslW4HmS7WVNW3wH9F0Qkq4h1In
         GCsQ==
X-Gm-Message-State: AOJu0YyTBZJJsa+4RHZFTweQejjIM5RDcWLxGTpIBcjEk+bJwAvHAUf8
	zjN2xG7QHpKQ1TIEscpqpWU0zoLu/9dxZ7/uTAzGgwOTHW5p8ETZJvXK9FlPSBuhb6RjUgmHMP7
	eNFCTNU7EQ+b258MUVvJ3t6sXQJOCE1U/T72mSA==
X-Google-Smtp-Source: AGHT+IHZ2u/3DJCHrxp3p5K0kiW9ap5TEVnWFWWUOBXKP62k5AYYZH/Tv0b8MtAUMi2IwAMLCXfJASG4PMP3iwry+sg=
X-Received: by 2002:a05:6359:428f:b0:178:bf01:1d with SMTP id
 kp15-20020a056359428f00b00178bf01001dmr234543rwb.25.1707149275789; Mon, 05
 Feb 2024 08:07:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202121050.977223-1-fiona.klute@gmx.de> <20240202121050.977223-10-fiona.klute@gmx.de>
In-Reply-To: <20240202121050.977223-10-fiona.klute@gmx.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Feb 2024 17:07:19 +0100
Message-ID: <CAPDyKFqRjNTvApfKou1xQn0_x5C9LXGwFHMw4OyvFcgwsrA4Zg@mail.gmail.com>
Subject: Re: [PATCH 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
To: Fiona Klute <fiona.klute@gmx.de>
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-mmc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, 
	=?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 13:11, Fiona Klute <fiona.klute@gmx.de> wrote:
>
> This driver uses the new rtw8703b chip driver code.
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For SDIO

Kind regards
Uffe

> ---
>  drivers/net/wireless/realtek/rtw88/Kconfig    | 18 ++++++++++
>  drivers/net/wireless/realtek/rtw88/Makefile   |  6 ++++
>  .../net/wireless/realtek/rtw88/rtw8723cs.c    | 34 +++++++++++++++++++
>  include/linux/mmc/sdio_ids.h                  |  1 +
>  4 files changed, 59 insertions(+)
>  create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723cs.c
>
> diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
> index 07b5b2f6ee..22838ede03 100644
> --- a/drivers/net/wireless/realtek/rtw88/Kconfig
> +++ b/drivers/net/wireless/realtek/rtw88/Kconfig
> @@ -31,6 +31,10 @@ config RTW88_8822C
>  config RTW88_8723X
>         tristate
>
> +config RTW88_8703B
> +       tristate
> +       select RTW88_8723X
> +
>  config RTW88_8723D
>         tristate
>         select RTW88_8723X
> @@ -126,6 +130,20 @@ config RTW88_8723DS
>
>           802.11n SDIO wireless network adapter
>
> +config RTW88_8723CS
> +       tristate "Realtek 8723CS SDIO wireless network adapter"
> +       depends on MMC
> +       select RTW88_CORE
> +       select RTW88_SDIO
> +       select RTW88_8703B
> +       help
> +         Select this option to enable support for 8723CS chipset (EXPERIMENTAL)
> +
> +         This module adds support for the 8723CS 802.11n SDIO
> +         wireless network adapter.
> +
> +         If you choose to build a module, it'll be called rtw88_8723cs.
> +
>  config RTW88_8723DU
>         tristate "Realtek 8723DU USB wireless network adapter"
>         depends on USB
> diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
> index 22516c9846..8f47359b43 100644
> --- a/drivers/net/wireless/realtek/rtw88/Makefile
> +++ b/drivers/net/wireless/realtek/rtw88/Makefile
> @@ -47,6 +47,12 @@ rtw88_8822cu-objs            := rtw8822cu.o
>  obj-$(CONFIG_RTW88_8723X)      += rtw88_8723x.o
>  rtw88_8723x-objs               := rtw8723x.o
>
> +obj-$(CONFIG_RTW88_8703B)      += rtw88_8703b.o
> +rtw88_8703b-objs               := rtw8703b.o rtw8703b_tables.o
> +
> +obj-$(CONFIG_RTW88_8723CS)     += rtw88_8723cs.o
> +rtw88_8723cs-objs              := rtw8723cs.o
> +
>  obj-$(CONFIG_RTW88_8723D)      += rtw88_8723d.o
>  rtw88_8723d-objs               := rtw8723d.o rtw8723d_table.o
>
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
> new file mode 100644
> index 0000000000..8d38d36be8
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
> +
> +#include <linux/mmc/sdio_func.h>
> +#include <linux/mmc/sdio_ids.h>
> +#include <linux/module.h>
> +#include "main.h"
> +#include "rtw8703b.h"
> +#include "sdio.h"
> +
> +static const struct sdio_device_id rtw_8723cs_id_table[] = {
> +       {
> +               SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
> +                           SDIO_DEVICE_ID_REALTEK_RTW8723CS),
> +               .driver_data = (kernel_ulong_t)&rtw8703b_hw_spec,
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(sdio, rtw_8723cs_id_table);
> +
> +static struct sdio_driver rtw_8723cs_driver = {
> +       .name = "rtw8723cs",
> +       .id_table = rtw_8723cs_id_table,
> +       .probe = rtw_sdio_probe,
> +       .remove = rtw_sdio_remove,
> +       .drv = {
> +               .pm = &rtw_sdio_pm_ops,
> +               .shutdown = rtw_sdio_shutdown
> +       }};
> +module_sdio_driver(rtw_8723cs_driver);
> +
> +MODULE_AUTHOR("Fiona Klute <fiona.klute@gmx.de>");
> +MODULE_DESCRIPTION("Realtek 802.11n wireless 8723cs driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 7fada7a714..7cddfdac2f 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -124,6 +124,7 @@
>  #define SDIO_DEVICE_ID_REALTEK_RTW8723DS_2ANT  0xd723
>  #define SDIO_DEVICE_ID_REALTEK_RTW8723DS_1ANT  0xd724
>  #define SDIO_DEVICE_ID_REALTEK_RTW8821DS       0xd821
> +#define SDIO_DEVICE_ID_REALTEK_RTW8723CS       0xb703
>
>  #define SDIO_VENDOR_ID_SIANO                   0x039a
>  #define SDIO_DEVICE_ID_SIANO_NOVA_B0           0x0201
> --
> 2.43.0
>

