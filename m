Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5AF482965
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jan 2022 06:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiABFlE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 00:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiABFlC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 00:41:02 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE07C06173F
        for <linux-wireless@vger.kernel.org>; Sat,  1 Jan 2022 21:41:01 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id v15so51196994ljc.0
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jan 2022 21:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BPVOsdEqjOxajqEoJCegalHFCf3/pMHIsfcU5ymJBg=;
        b=f5VQtVdgWJBxHVNjSpPkkwFvOGIQpZeOMrpOLwtPyqAQh2ATfL6Y1fIlA87m7TPWlD
         +bDl0tr8jE46HyO2/g98YM0Nfd5iTyGEfaqibj4jcepqBu44itaFODOfAIRAhaHDm+i8
         enHuSW+sJZtaCrAP+8R5kjL9a+hC49XOLGBHWZ4z30ys/8TLiWXGH+0T9geoeZ++Qq2a
         Q5jV8QkSrUDwyC9DZoE2eTWRpv4w+lzoqxm8QI8ojGZQdwXdg+WhW6DPAK9s6C/2b7Eg
         wnfnpLHVRUMdVgYhgV0Q6XmUOUifFlPT4L4xTojREdKFFkz6hv3/ZpJS4dWyKl6G/2ak
         hVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BPVOsdEqjOxajqEoJCegalHFCf3/pMHIsfcU5ymJBg=;
        b=oMDfBzQg/5YHXeEj4F+sz9FSBhN9h0+zSuXMFm1OkvhCPSkcNNzOaYBemPncMKrkOR
         lwHEPJ8WTyiXa2yGOj6butZWOkcS2O2goL5fbir5LthIMk5xuUrLRbzjsDZ4LQ9cN1SN
         STcGiJnFGRDXlsHA2JWN3yHK51Xb375N14d+7jvgnrejLEiaYkj8Rv4+CdDvB8uWr3MX
         R5scBG3lqnm8apQWgoT8yVHscQGmHuk68xvEnFEQ7/i792I8eBRKHEPOsKkEF7ExA/Ws
         3WC4zeATuPJghOkfNEaDYtRyMw52YsXQpOtexTjxKxCV39ngkP9N/KQVdqBDODoGcM3x
         TmsQ==
X-Gm-Message-State: AOAM530e1OnnKYE8D8URxKelY+fR56vEjNlye03XiAljJxq1GNimEKp/
        OMsGSGMGTdEYWqRPd15gLMQ2FoTqGeGc3NTRWm1peg==
X-Google-Smtp-Source: ABdhPJwlq9o1i1c8yySPLmZXKqgSTy84XHmf+/Wv+oOgBlfYhtIr8GM2itL5v6JvbCXjJqGEJ1ZoeVJEbd3+k/2/yEM=
X-Received: by 2002:a05:651c:623:: with SMTP id k35mr35519889lje.133.1641102060025;
 Sat, 01 Jan 2022 21:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-9-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-9-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 06:40:47 +0100
Message-ID: <CACRpkdZx2Y6aMbOohAoa60GXT8NPg1iyw4+PzUQrs_V8b4=yrA@mail.gmail.com>
Subject: Re: [PATCH 08/34] brcmfmac: of: Fetch Apple properties
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

On Sun, Dec 26, 2021 at 4:37 PM Hector Martin <marcan@marcan.st> wrote:

> On Apple ARM64 platforms, firmware selection requires two properties
> that come from system firmware: the module-instance (aka "island", a
> codename representing a given hardware platform) and the antenna-sku.
>
> The module-instance is hard-coded in per-board DTS files, while the
> antenna-sku is forwarded by our bootloader from the Apple Device Tree
> into the FDT. Grab them from the DT so firmware selection can use
> them.
>
> The module-instance is used to construct a board_type by prepending it
> with "apple,".
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
