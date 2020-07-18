Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B36224A4F
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jul 2020 11:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGRJ33 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Jul 2020 05:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgGRJ33 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Jul 2020 05:29:29 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B0C0619D2
        for <linux-wireless@vger.kernel.org>; Sat, 18 Jul 2020 02:29:28 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id m6so6065000vsl.12
        for <linux-wireless@vger.kernel.org>; Sat, 18 Jul 2020 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ti26ee0hY6W3phdmQsoDOeF7v7bPKvFPyrfMjmwB4w=;
        b=twvL69pRIwWi2+E1B/5uuKwBtq1LID3epjS5uq8iwjNLiLeKu4cB0zNPjLNpUDyGqq
         jLFKhCwvzkfxqUlNPTUTrRzEML5EqSlax9vagvSerM4iw7FTpYVL/usrvjyh6BtmhvTj
         /6+OsScpb98Jjg2CFhGoN4SyHpReTIUphE2WFewD/OaYDLKQA9iLjUaMdJa69m/QYf01
         8Uqbu9e4Ji1aIisPifz+h7nSc47NgmOz0+gEfbkoIJvv5LxG4mQVJnEDbmjT4t1rjldi
         gUG2+RZ6ilSM4dOcKhxP8Wi4IhNrgXviWBWIwtG1hYt7/LTp1Kb+R2UoMou53/anr/Iw
         zdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ti26ee0hY6W3phdmQsoDOeF7v7bPKvFPyrfMjmwB4w=;
        b=bNS9XsNJIfC7aItkATUFTMQODwkjMvuMPHXGtrIPZBVnOd4C1z5VKULJqfSzlMVMtF
         M9akFg9GuQAVeRnfjTyUfunYBVttNKKoLdyqhmep6r5ztuOGpjjCmhBEMnQhxUyMpFF3
         FWQWBYOvsdv/a48137QCr3RSauflIWowrfQbfnksBQsWyigWOkkQA01H4lAIxUPY7j/i
         asZ/Gmrbivi7rAfzYm/YcfxLrdOOsqS/4AdlJ7MluStgkqJHgp0ZYst77btpznDsNxjc
         4dkThjsKT4Qq1ARw3mNZ5SyCq+LuvTggu4Mp3stFho2P0RXHnOUaAO0M7gbWTNRMG5zi
         BMmw==
X-Gm-Message-State: AOAM530aZHjN3EgwQ1tfMSSaNuTyar79RlfLAyemX7+NqqHt/F4ndXJK
        i8TU9UWJWGBStRCQKuxqnfN/adaXP3zN+otvH0LFcw==
X-Google-Smtp-Source: ABdhPJwYKi9bfL+r1N5YF20n2KtPjYeA9rOiy9vFcPtgTtJnIhp3Wj5weSdJTA4jYgbOsylMO5xxwsGozzcGpjl6+4A=
X-Received: by 2002:a67:f888:: with SMTP id h8mr9724969vso.165.1595064568127;
 Sat, 18 Jul 2020 02:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200717051134.19160-1-ajay.kathat@microchip.com>
In-Reply-To: <20200717051134.19160-1-ajay.kathat@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sat, 18 Jul 2020 11:28:52 +0200
Message-ID: <CAPDyKFp5-6QeHLTE4gtc5u6moMsLFhOBZckDZBTD+B1RV28Z3g@mail.gmail.com>
Subject: Re: [PATCH] wilc1000: Move wilc1000 SDIO ID's from driver source to
 common header file
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Claudiu.Beznea@microchip.com, Sripad.Balwadgi@microchip.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 17 Jul 2020 at 07:11, <Ajay.Kathat@microchip.com> wrote:
>
> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Moved macros used for Vendor/Device ID from wilc1000 driver to common
> header file and changed macro name for consistency with other macros.
>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/net/wireless/microchip/wilc1000/sdio.c | 6 ++----
>  include/linux/mmc/sdio_ids.h                   | 3 +++
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
> index 36eb589263bf..3ece7b0b0392 100644
> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
> @@ -6,6 +6,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/mmc/sdio_func.h>
> +#include <linux/mmc/sdio_ids.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sdio.h>
>  #include <linux/of_irq.h>
> @@ -15,11 +16,8 @@
>
>  #define SDIO_MODALIAS "wilc1000_sdio"
>
> -#define SDIO_VENDOR_ID_WILC 0x0296
> -#define SDIO_DEVICE_ID_WILC 0x5347
> -
>  static const struct sdio_device_id wilc_sdio_ids[] = {
> -       { SDIO_DEVICE(SDIO_VENDOR_ID_WILC, SDIO_DEVICE_ID_WILC) },
> +       { SDIO_DEVICE(SDIO_VENDOR_ID_MICROCHIP_WILC, SDIO_DEVICE_ID_MICROCHIP_WILC1000) },
>         { },
>  };
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 15ed8ce9d394..519820d18e62 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -105,6 +105,9 @@
>  #define SDIO_DEVICE_ID_MEDIATEK_MT7663         0x7663
>  #define SDIO_DEVICE_ID_MEDIATEK_MT7668         0x7668
>
> +#define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
> +#define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
> +
>  #define SDIO_VENDOR_ID_SIANO                   0x039a
>  #define SDIO_DEVICE_ID_SIANO_NOVA_B0           0x0201
>  #define SDIO_DEVICE_ID_SIANO_NICE              0x0202
> --
> 2.24.0
