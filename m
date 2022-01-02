Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBAF4829E0
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jan 2022 07:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiABGC0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 01:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiABGCZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 01:02:25 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419CC061401
        for <linux-wireless@vger.kernel.org>; Sat,  1 Jan 2022 22:02:25 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id p7so50277660ljj.1
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jan 2022 22:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iv0K/OnJ4x9KfFHJ0rMuNgjAIOFFIZXtmp5GzA9pOGE=;
        b=kbXmk9tr198z8pao9hHrPKf2/6KoiMTCjBYI5UoO7DR6FwK3vS+Y+F9/3Ze+BxLQvp
         IfXT/GtwJfVx2IdtpbYiUqh460czkPgKS7BR+FuMiIZ0GHazwnFhrNzn6s71X0HRG0YS
         YD0Cu0h0orwxGR5rbhIMnXonf/VBgml/3NcgoalHGzb23VlOsrUO0MNKCwpAyxAr0btU
         SQhmKxoqUUVf252ZCFucZE1RDIFYSpqTAixbrZlc5Cy/Fl3bp5zJXlyHNj1u7DXAaH3w
         VSH6H6Yl/P90PN2I/McvkhjudFH7wiLqxwV80iEyjv2SjFFj2ThhJ6DmPAOccSyu4Z7t
         W6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iv0K/OnJ4x9KfFHJ0rMuNgjAIOFFIZXtmp5GzA9pOGE=;
        b=KOvSNJ1NpkK7EgSys8/rwzLmakW6VVYh89ll+/BEGkn4pERsrrFFAyinxdeZ83eLHK
         lg+y6cZLDSErMMv/9jcnffl+VQoN9G1Uue9VhXevJNITp3ZwW1n5XsD5LQB088R4MAKX
         TmEOYkrTQI801G1XgAppbFyIecv6L5GK00QCbMfoCBOOCa1gvHnbT53dVSOJ9VXMiWq1
         7lly/yYpHhbQtYFUQBzJAsH7Z0+CWlOdMHevfKg1zNe3IB9wZgK76mx+Lvr+uCSnzoxQ
         0Zr6BAplxp1XZ8a22Q95NG6s3prz4jrJefrYylwIM6Wi9cBC+6jBmFAtLWtll+sHZbRh
         1HrA==
X-Gm-Message-State: AOAM5300vbQqfZe+K77Lj2pafAt0zOHbCWOgd1oI75wSREfRUTc8t3BL
        e9zOD0WVQyNzOmB/fr/4xWV3e8u5yxIo7yhA8Vc6Ow==
X-Google-Smtp-Source: ABdhPJxvaWFPeqjDxRtZ5GOTtcaUxjX5EavoTj/qbHCqCtmPBlJ1yLcjqFSF/5y/WvhdRwObdm85gUse1YdzqzD+y7I=
X-Received: by 2002:a05:651c:623:: with SMTP id k35mr35551617lje.133.1641103343390;
 Sat, 01 Jan 2022 22:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-21-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-21-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:02:11 +0100
Message-ID: <CACRpkdY97WMk6KbQDT-_2=M7H7HrF5JDp3rPruc9oCXwm71k8w@mail.gmail.com>
Subject: Re: [PATCH 20/34] brcmfmac: pcie: Perform correct BCM4364 firmware selection
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

On Sun, Dec 26, 2021 at 4:39 PM Hector Martin <marcan@marcan.st> wrote:

> This chip exists in two revisions (B2=r3 and B3=r4) on different
> platforms, and was added without regard to doing proper firmware
> selection or differentiating between them. Fix this to have proper
> per-revision firmwares and support Apple NVRAM selection.
>
> Revision B2 is present on at least these Apple T2 Macs:
>
> kauai:    MacBook Pro 15" (Touch/2018-2019)
> maui:     MacBook Pro 13" (Touch/2018-2019)
> lanai:    Mac mini (Late 2018)
> ekans:    iMac Pro 27" (5K, Late 2017)
>
> And these non-T2 Macs:
>
> nihau:    iMac 27" (5K, 2019)
>
> Revision B3 is present on at least these Apple T2 Macs:
>
> bali:     MacBook Pro 16" (2019)
> trinidad: MacBook Pro 13" (2020, 4 TB3)
> borneo:   MacBook Pro 16" (2019, 5600M)
> kahana:   Mac Pro (2019)
> kahana:   Mac Pro (2019, Rack)
> hanauma:  iMac 27" (5K, 2020)
> kure:     iMac 27" (5K, 2020, 5700/XT)
>
> Fixes: 24f0bd136264 ("brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2")
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
