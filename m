Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F24F2159F6
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2020 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgGFOt4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 10:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbgGFOtz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 10:49:55 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0AC061755
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2020 07:49:55 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id l18so4902176uad.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2020 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SAUTZCKNrEvpQK8X43iPxicP+R3S1kWBry2NpIY1/dQ=;
        b=uxoutIAL0NtSt92mYsh794ORpUzNdUsYmApSv4txaGPcQv6KRB+4sVITsf6nq9FXOA
         SMfhiISK4XrJ0VABXVXUR1TCPvQ6cTUnzIrR3T4MlbiMadFBrCn5zv13duPlqPbr6OkB
         qjPJ2PnqeuNe5me+YC513P9zephNVgaarMIXcV69qxcBm31ZjpYfeS1DHgqMPuA4YOib
         EPYFm38JMv4f0j+5yGTEUn+4aOUoVUcwC1neqZxWx+wGpRH3mMcPM9R2+Vf+YZXhEH0r
         tLhBbg3hl6KInWva+x5JB+jE+KuVmgdjRLBls16epNVBORd31dlK/hK62DAH7ZYYESy3
         +Elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SAUTZCKNrEvpQK8X43iPxicP+R3S1kWBry2NpIY1/dQ=;
        b=TOb6pZQth/+KU5BgHICCSFzMwDLzW+vJTKXJV8Dkr/Nera2wbE92y4nQpzu57R7WhP
         dBWNsPc7ncNgz5OmEJ5iUM9YAgPUsFbyLMlD4FKEAsXj6N3HG8WNJu8rd1VmyE8B4Lwp
         U3IiinhndHSzsic1STLKQDd60MjnH4fXri0U7lFou/BIRTrWxNJFT19PV74SPxfwNzZW
         40GG+wNorQ/Txvot0NYCo4S/OeW8nUeUfVHKOj5Nomv6a38O7Tz0sLbwpShLgexGmm7S
         n6eQd4x5MatFYlQL2Sf9lF2Wq+oWP0CleNreRU3ATZQZBGC57JS2Cd4GHnJ++tREcmE1
         shEw==
X-Gm-Message-State: AOAM532HPsSoiPVvwhT1SDZU0Va4ey/SlaistlrKOPZt+6eD3FaoRwR1
        RdMGQcs/LTxygrIYTfpEL9wB41ryWzt4oWK66BPm7A==
X-Google-Smtp-Source: ABdhPJxgj9RMBRxUAfldh72xeG7C36VY7RNbaVfCXry+dxCiSq7RJ3pHvb56O9+k8W7z/55b0tNU1kBAdhneXVf03TI=
X-Received: by 2002:a9f:22e1:: with SMTP id 88mr34504520uan.19.1594046994591;
 Mon, 06 Jul 2020 07:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200629072144.24351-1-pali@kernel.org>
In-Reply-To: <20200629072144.24351-1-pali@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:49:17 +0200
Message-ID: <CAPDyKFp-meAG4XNgL3ixacYKpFByV-Pynz6-GRDtfT95hC-Jmw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: Move SDIO IDs from rsi_sdio driver to common
 include file
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 29 Jun 2020 at 09:22, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Define appropriate macro names for consistency with other macros.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Applied for next, thanks!

If it turns out that it's a better idea to funnel this via Kale's
wireless tree, then I can drop it - and you may consider this as an
ack instead.

Kind regards
Uffe



> ---
> Hello Ulf! I forgot to include change for rsi driver into patch series:
> "mmc: sdio: Move SDIO IDs from drivers to common include file"
> https://lore.kernel.org/linux-mmc/20200522144412.19712-1-pali@kernel.org/
> As patch series was already merged, I'm sending this patch separately.
> ---
>  drivers/net/wireless/rsi/rsi_91x_sdio.c | 8 ++++----
>  drivers/net/wireless/rsi/rsi_sdio.h     | 4 ----
>  include/linux/mmc/sdio_ids.h            | 4 ++++
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wirele=
ss/rsi/rsi_91x_sdio.c
> index 5d6143a55187..a04ff75c409f 100644
> --- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
> +++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
> @@ -1038,10 +1038,10 @@ static int rsi_probe(struct sdio_func *pfunction,
>                 goto fail_free_adapter;
>         }
>
> -       if (pfunction->device =3D=3D RSI_SDIO_PID_9113) {
> +       if (pfunction->device =3D=3D SDIO_DEVICE_ID_RSI_9113) {
>                 rsi_dbg(ERR_ZONE, "%s: 9113 module detected\n", __func__)=
;
>                 adapter->device_model =3D RSI_DEV_9113;
> -       } else  if (pfunction->device =3D=3D RSI_SDIO_PID_9116) {
> +       } else  if (pfunction->device =3D=3D SDIO_DEVICE_ID_RSI_9116) {
>                 rsi_dbg(ERR_ZONE, "%s: 9116 module detected\n", __func__)=
;
>                 adapter->device_model =3D RSI_DEV_9116;
>         } else {
> @@ -1526,8 +1526,8 @@ static const struct dev_pm_ops rsi_pm_ops =3D {
>  #endif
>
>  static const struct sdio_device_id rsi_dev_table[] =3D  {
> -       { SDIO_DEVICE(RSI_SDIO_VENDOR_ID, RSI_SDIO_PID_9113) },
> -       { SDIO_DEVICE(RSI_SDIO_VENDOR_ID, RSI_SDIO_PID_9116) },
> +       { SDIO_DEVICE(SDIO_VENDOR_ID_RSI, SDIO_DEVICE_ID_RSI_9113) },
> +       { SDIO_DEVICE(SDIO_VENDOR_ID_RSI, SDIO_DEVICE_ID_RSI_9116) },
>         { /* Blank */},
>  };
>
> diff --git a/drivers/net/wireless/rsi/rsi_sdio.h b/drivers/net/wireless/r=
si/rsi_sdio.h
> index c5cfb6238f73..9afc1d0d2684 100644
> --- a/drivers/net/wireless/rsi/rsi_sdio.h
> +++ b/drivers/net/wireless/rsi/rsi_sdio.h
> @@ -28,10 +28,6 @@
>  #include <linux/mmc/sdio_ids.h>
>  #include "rsi_main.h"
>
> -#define RSI_SDIO_VENDOR_ID   0x041B
> -#define RSI_SDIO_PID_9113    0x9330
> -#define RSI_SDIO_PID_9116    0x9116
> -
>  enum sdio_interrupt_type {
>         BUFFER_FULL         =3D 0x0,
>         BUFFER_AVAILABLE    =3D 0x2,
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 15ed8ce9d394..ab41801c5f51 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -118,6 +118,10 @@
>  #define SDIO_DEVICE_ID_SIANO_NOVA_A0           0x1100
>  #define SDIO_DEVICE_ID_SIANO_STELLAR           0x5347
>
> +#define SDIO_VENDOR_ID_RSI                     0x041b
> +#define SDIO_DEVICE_ID_RSI_9113                        0x9330
> +#define SDIO_DEVICE_ID_RSI_9116                        0x9116
> +
>  #define SDIO_VENDOR_ID_TI_WL1251               0x104c
>  #define SDIO_DEVICE_ID_TI_WL1251               0x9066
>
> --
> 2.20.1
>
