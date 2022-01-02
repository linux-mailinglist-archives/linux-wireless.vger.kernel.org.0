Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1EC4829FE
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jan 2022 07:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiABGN3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 01:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiABGN2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 01:13:28 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322BAC061574
        for <linux-wireless@vger.kernel.org>; Sat,  1 Jan 2022 22:13:28 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id h15so37652583ljh.12
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jan 2022 22:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQZLwT+w1+Y2g2ul+2mg6iUoYfiNjzZt86lCdfnWPtA=;
        b=AW/ZNbPSLW468zW/twl9o/cgXt0oE2gt8F4kyzPQGwiulKCrpOaWwAM0cyUJ1FPKJk
         A6QNbIDZTy9H6jycg5ZpeCoAvVEmfyIIjdo3JyNI2Bhc+9jijMoFpYbDWad9ao1nxGzv
         l2D6ltASDWxaZJpXCGXEYIRszLKvpLrBVLODpBTSIWex436szk5LoV/gKPejKrDnng1z
         4BI5m2do8sdvrhOCT7NxgfYh1xc9b0e0LKCI6S7MtVpl6KHt977Da09LB2yfTeDOrSL6
         UEMNeDcgaXkmkUG3wWnTXp3OHn23qojCG9T0srXLdJc4wmrqdKZafnFL67r2CQFmmMiN
         BtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQZLwT+w1+Y2g2ul+2mg6iUoYfiNjzZt86lCdfnWPtA=;
        b=zw8oArstsQEiV4BDeeCq6hG+pnAu6vXaI8iYeOG9jydGf0NnzbQ1G9sQBc8xnNUL5+
         yUslBUQzbD0iNjDjA7vPIc6STkfpTX+u1RvkcGxbmVTOF8TADL84+GD3/TobY+xTXC5I
         EgWmB9u4QHmovoiMijXnJj9LedDNg9ZuRJDigEcBDzyRbXOD1nE0QJ98KuSG/AnWBn7h
         t44GoUO29T89fpW+zzygxm+XuGhdKh1/RHrUTQVh4VCARbOp6xpIkORxfhdY7ixyLx3r
         J2U7MHHbhj0pANXWbKqRBABkZA7m9dBBchl/lipMdm83Rc7kaqraO2iIpL++GGdpudQ5
         W+bg==
X-Gm-Message-State: AOAM533/Y1IOdLl3tQj0YxC4h0qndnnNxmvwQQum7bu986OHZtenVVej
        eJM8z+Vb7Y4Gy4OQhwf75aBfBL+C8LCAFQa1KCaLyQ==
X-Google-Smtp-Source: ABdhPJxM2f7u0RlwdZkYufWQhioNOnTnjJqHgjzjatwX6cpu+GxEYVnS/6kGtZs3QlqQ09MrlhCLnoOvUxy7A8YmozA=
X-Received: by 2002:a05:651c:623:: with SMTP id k35mr35568925lje.133.1641104006495;
 Sat, 01 Jan 2022 22:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-27-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-27-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:13:13 +0100
Message-ID: <CACRpkdZ4w1Ftq+UcpmYVzcESG-2tJTkUs8RViqRPv9EKmL4NLg@mail.gmail.com>
Subject: Re: [PATCH 26/34] brcmfmac: cfg80211: Pass the PMK in binary instead
 of hex
To:     Hector Martin <marcan@marcan.st>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "Daniel (Deognyoun) Kim" <dekim@broadcom.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Dec 26, 2021 at 4:40 PM Hector Martin <marcan@marcan.st> wrote:

> Apparently the hex passphrase mechanism does not work on newer
> chips/firmware (e.g. BCM4387). It seems there was a simple way of
> passing it in binary all along, so use that and avoid the hexification.
>
> OpenBSD has been doing it like this from the beginning, so this should
> work on all chips.
>
> Also clear the structure before setting the PMK. This was leaking
> uninitialized stack contents to the device.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
