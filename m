Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC13440C6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 13:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhCVMVV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhCVMVO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 08:21:14 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B72C061763
        for <linux-wireless@vger.kernel.org>; Mon, 22 Mar 2021 05:21:13 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id l13so7314831vst.8
        for <linux-wireless@vger.kernel.org>; Mon, 22 Mar 2021 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XGgimpglaRwteb/Bgl+pO/u/VHpnAlSvFxg2F0n2KCo=;
        b=p6ePlsePjZxtZiq6dspm5RqfO23b/cRwiaAUzyGDHXFYH5sx1t4bJGWn0FOttl90Fl
         9l+Pfmy1A5eZFy/TSoAvoVzQdfoD2qAan4ZvPA6wRfZWyReRLg4ebDoHO03QxuwMUSbG
         Xw/8chYtadgBTlSZOweb9p+3rtNCRRcjugB/lnaBMco22zR1SkNQM6lzIQNj8EexBez6
         v7JH/YONvbt8dLTbvqGS0sAH1lBuk1leff10dNlL9TDI1CpIRaVwIzuXwq2+NNyRsGqx
         z1w0fgf4bGexsX5E3k40FkRmO1RTFVZAOD6tpBLRoVWKOKlZDiXK9Zj5nr2RvdtstoJq
         nujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XGgimpglaRwteb/Bgl+pO/u/VHpnAlSvFxg2F0n2KCo=;
        b=J/Q6i0P3LDt7aoSylvNn6YNCBO6pd7Js7GJCrEdovayT8ePCoktyDHBAl1KuI22MsS
         LMW4XFCp7vfMxnSnQLvmLGfwGylZi1Vsfmjd4bZ9X8SFzgJ9fpY8STWixoyJ0gPpjRTS
         Vy83iNmx8t2o5D5inYb1EudPRvtOE9AFQhkh96dej58m9VGJw77Ot0lHqde1if6fgmNC
         VvNS7YQZb/T6dzINjOFlNEw9pELI/5ijt35g+o1dCSoM6Bt7XqtPV5rAGdrVbv2Sjlsf
         IF9JVpL2WVMm7H8zdLZGP/MKGDeh832HYp06SCvgLUglEX7C/rQssLzj1CQOhqwQhe70
         tePA==
X-Gm-Message-State: AOAM532764+lmLn6/ZvjZY2zZxFlpm/GzV1JNEA1WkULkKQbMIbcRz6H
        u413PYZRLQ3nRgVcFC9Pu82LEWduUIuwJ48kexctgw==
X-Google-Smtp-Source: ABdhPJxi1HPq3PGcbuB9unHpIbKlJszyykT5Ik5ywDW/5koSttdd0dNdIDei/RcqxPZPwkzSrOy7RcSt9jXbJOzDcy4=
X-Received: by 2002:a67:2a85:: with SMTP id q127mr8477457vsq.19.1616415672109;
 Mon, 22 Mar 2021 05:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210315132501.441681-1-Jerome.Pouiller@silabs.com> <20210315132501.441681-9-Jerome.Pouiller@silabs.com>
In-Reply-To: <20210315132501.441681-9-Jerome.Pouiller@silabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Mar 2021 13:20:35 +0100
Message-ID: <CAPDyKFqJf=vUqpQg3suDCadKrFTkQWFTY_qp=+yDK=_Lu9gJGg@mail.gmail.com>
Subject: Re: [PATCH v5 08/24] wfx: add bus_sdio.c
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 15 Mar 2021 at 14:25, Jerome Pouiller
<Jerome.Pouiller@silabs.com> wrote:
>
> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> ---
>  drivers/net/wireless/silabs/wfx/bus_sdio.c | 259 +++++++++++++++++++++
>  1 file changed, 259 insertions(+)
>  create mode 100644 drivers/net/wireless/silabs/wfx/bus_sdio.c

[...]

> +static const struct sdio_device_id wfx_sdio_ids[] =3D {
> +       { SDIO_DEVICE(SDIO_VENDOR_ID_SILABS, SDIO_DEVICE_ID_SILABS_WF200)=
 },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(sdio, wfx_sdio_ids);
> +
> +struct sdio_driver wfx_sdio_driver =3D {
> +       .name =3D "wfx-sdio",
> +       .id_table =3D wfx_sdio_ids,
> +       .probe =3D wfx_sdio_probe,
> +       .remove =3D wfx_sdio_remove,
> +       .drv =3D {
> +               .owner =3D THIS_MODULE,
> +               .of_match_table =3D wfx_sdio_of_match,

It's not mandatory to support power management, like system
suspend/resume. However, as this looks like this is a driver for an
embedded SDIO device, you probably want this.

If that is the case, please assign the dev_pm_ops here and implement
the ->suspend|resume() callbacks.

[...]

Kind regards
Uffe
