Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0347F8F2
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Dec 2021 22:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhLZVEU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Dec 2021 16:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhLZVEU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Dec 2021 16:04:20 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA38DC061401
        for <linux-wireless@vger.kernel.org>; Sun, 26 Dec 2021 13:04:19 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so17858779oti.11
        for <linux-wireless@vger.kernel.org>; Sun, 26 Dec 2021 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umSGSIdrVchlICBFLR5G/N8lNbhzD7RJDqjSizBvQSk=;
        b=AAnJoezNjYq+RgB0FVaE0qOPb0NdpQuB9/Qe8jy//AodWyp1GeTHxDH8eumKeHjp12
         ZmvcXRLG8tGE76xfVgM9NWtAZbROyJSWIOskMQJtdCGmxthEwy622ZEfsbyNrZK6IYyp
         hFQjvTWKRWHTMRVi8bYUr0tFVTB/11nClZUA7tx9VA9VSxEZoX44/BEtVGMufB5MgaOU
         W9awYUAf4XWPfZdMYhyknJWb6TYroxNUBt/jQfnWAvrm2OsjCB2yKfI0SPP67hZBODBj
         /s7BbrZRS7YTZsiIE2QrR/z8PysCeWYbvrUjj8RPe9skyDBBeZJCRIdPQsrrJbkBYAvu
         gkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umSGSIdrVchlICBFLR5G/N8lNbhzD7RJDqjSizBvQSk=;
        b=w7XcyK9g+kOpG1e7TFrrSeszfwXfZ9Ana8yEP9E7BcoEXU0uFM0Ch4i50j99DR7/Ev
         +lJGvA8XQGbnao4Fe0yf1cawNmAww8SYaUR85RRUK/QMCzIKUaiTM4fPZqErOLam9JVM
         DtfClsuibCKiX681UgcDCX6t90l8TimRrIoIVyN4PmBzwtDC+IasA8oTT6jsJakUa5H5
         63xyUW6Bp/ollJppHvLHOu8BPKZRYbeTGi0o4XQJefa0C2heXSFdWPm0jJsuVcvS9Zhu
         qVJMcm6/oAE+SQCF2uOtigqN7YzYBM2vD/0SL7g7WTRRAPp8mBWEj5Ibj4prMw4Nfwqn
         zm5A==
X-Gm-Message-State: AOAM530shcVdrr0E3yP6DUQ8bmLl/976nZCp6jXOu3Exqkffb6rNmxD1
        lffJvg85AxWPU2j9wIUK9Fj1nBT0gPUVIx7rj53qxA==
X-Google-Smtp-Source: ABdhPJwr9ULKZ0rT757E5oX7lhOc2VNYlgxmJ6bCA31E+J6bPLuhQUnZ9wMJbilcsfBqEDG/CDzBH88X7h8SBKjn0eA=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr10858787otg.179.1640552659134;
 Sun, 26 Dec 2021 13:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-3-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-3-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Dec 2021 22:04:07 +0100
Message-ID: <CACRpkdZ3AyAzdm+m+CKki2E3xUdWp_ebmXd8bYMMBWB-2n0hXg@mail.gmail.com>
Subject: Re: [PATCH 02/34] brcmfmac: pcie: Declare missing firmware files in pcie.c
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

On Sun, Dec 26, 2021 at 4:36 PM Hector Martin <marcan@marcan.st> wrote:

> Move one of the declarations from sdio.c to pcie.c, since it makes no
> sense in the former (SDIO support is optional), and add missing ones.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Fixes: 75729e110e68 ("brcmfmac: expose firmware config files through modinfo")

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
