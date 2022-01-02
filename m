Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD3482A37
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jan 2022 07:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiABGXi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 01:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiABGXh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 01:23:37 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B97BC061574
        for <linux-wireless@vger.kernel.org>; Sat,  1 Jan 2022 22:23:37 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id by39so51119761ljb.2
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jan 2022 22:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgQd8mVA5Ou/dtF60Rr1+uXMaZpGfgKYwjDfuQ8htQ8=;
        b=jNm5mAS5EjqfDtNL1Kn9XGIg2+C/re/dVJe3eqlS2GgVT9Dsfokxnq73f+ZCCXYoB2
         ADTmWRj7SXDEWfM1CGvMFtKf31AgCvoor+GQ5trEA2y8r2D8bU4KVV75ZVRm8p/x0Je5
         gCBpQkSXQdQqEZqJ26Hyu3cUoBoFXVuJfys/lZf6tSy7UBfVhRkAe5W3o6sKHXLSs9WB
         ihhebtQQwzbOsOlh2nn0ATWggbUiiwUJmvwKvuApgM/xj8lK70GBmg0DDNNw4z99xkIK
         vR/K2fsxGQrRtcmQqXG6/o7qm5zrqAPWC1+7DEFzAGCOov08BXlPovIB8gL5LYSFLHVT
         UwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgQd8mVA5Ou/dtF60Rr1+uXMaZpGfgKYwjDfuQ8htQ8=;
        b=NRBfHsxXnz8zk/zAQQSX5yFt/ENdie9DW/XZkV11RBqapOHPYpgr3rHQMfMzFfySBz
         xGmAEUJs24MfnL917xED0bm3/A87WRLegnRYGL/oy9TDD2sWG2v7Jprf9IiYZFEnlsPj
         OZ+mh7ijdi+myQCYkN5/DBALFmor1+CaijlA3HOw5kb068bVwEN6iDcp/0iP+cFKFEWt
         f+5jAhvbPX40lDqnIDkQ8bqsX/1RUIc9uKoVEsRiNZgRfq0e6XoZWZzd1LOhtyRBDQ9F
         kTOO14KP9QzhFi3D/yXxRzOHCvkMv7E3OiYR5uVlFRyqxoE96XXlbqB//31wOaNF07Wv
         CVXA==
X-Gm-Message-State: AOAM533s4OXrIwN5azpMlGm/Xl9fK5gQAzFeKL3jCJgbzRc6x5g/MW97
        S8wt+PazEJP/ijGVaLI5i0ETQdwFYEUUhjK9cUq0BQ==
X-Google-Smtp-Source: ABdhPJx1bpQrYxUZGqaWXyD0VzScJihPrK6/lT6pAwBXrQOaBPvT+Wr+wnvxmv2Se+jeu73uNv6b9Zecgs+PTeWpQeg=
X-Received: by 2002:a2e:a4ac:: with SMTP id g12mr14355456ljm.183.1641104614823;
 Sat, 01 Jan 2022 22:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-24-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-24-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:23:22 +0100
Message-ID: <CACRpkdaEVsSxsp-7RCF0Gy8XcWCbGJnP7b0Q9TmMLFz33gs3jA@mail.gmail.com>
Subject: Re: [PATCH 23/34] brcmfmac: cfg80211: Add support for scan params v2
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

> This new API version is required for at least the BCM4387 firmware. Add
> support for it, with a fallback to the v1 API.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
