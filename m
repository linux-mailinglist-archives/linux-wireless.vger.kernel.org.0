Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4574829EE
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jan 2022 07:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiABGKK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 01:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiABGKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 01:10:09 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502B0C061574
        for <linux-wireless@vger.kernel.org>; Sat,  1 Jan 2022 22:10:09 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t14so22631860ljh.8
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jan 2022 22:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfx54z3g7sfFs7JsVZzrDRW1hVLAL2mHFjv2JYjNFmE=;
        b=MO5AUuIABvQLLi+tkM6OuNl1SFRhfjnfNdZf/WF35ksOELjU+aknIlVmUV02Ge74mb
         N3E4241Z0dw7sXALiXjlHzNENbvq6pG+ee/D2LydEggYwYAa8czMTDe3mHtrOQ8e2PQm
         2xmYzsBAGAKlurQRe+J9yA0c71rgTnhonBW3Fh2rb/pu4cVvamPrnhv1qBbKx+YXBSs9
         DY8RNrjy2JeWUCKgV9ulHQY/8KTYAbQyvG1+2LvdSLzm+azP8+d1m3g8gcUuUqsjX6Kh
         9X9+2vFCALVdFZDfDXttI1v4K3ewSf+XMGm7SSRKcf55LRGb+ZYsJhypGmvUSvUqKQF0
         Cvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfx54z3g7sfFs7JsVZzrDRW1hVLAL2mHFjv2JYjNFmE=;
        b=uVNs70bUdw5zg3BI3iJGA+q/K5jx7wGO76v9+slujawWZDUVYv+RTcsVY4OFfxFEL3
         8QD2siczWyFvSfz8SyZxMhyiEzjAk4BjIL1ifPlCBOCcRaq6JH0kEZDDJvtt/BqpeOJe
         O6bEefI6JZNnW0QfHziw1EWHoIp6iNtscoUTG4T7bXQGUjZeJ73apCrBv6DTFnG7qbna
         30C094fLryuXMrSwxihNuXq3J1fVm/pa/uVEKqR+cc5GKmj4H+fxIishHEUO0oE3GJgl
         ii3PftsnHK21GTu6jxhpNEK6KCFdx8eftKWY5+dM1l+fSWUi6ieG4lzCJvwAgrhbaMr9
         yylg==
X-Gm-Message-State: AOAM533H9ydC6gjTDxSFr/yj/2C8cKTdTmuBLtEP96fsNufsR9DO1fHc
        XDfQj38lZykBeX1C8nHYQAmQkN06hptprL/Xa+sJ4Q==
X-Google-Smtp-Source: ABdhPJxWp3CGlZRZaaUTWpT7/gu8dnteeqOe+rMzZGWFHzCxm8tDGyYTI5LyPDXA6ulkKiQb/xXECrpR2ZqPp9nlH6I=
X-Received: by 2002:a2e:8810:: with SMTP id x16mr31131176ljh.78.1641103807519;
 Sat, 01 Jan 2022 22:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-23-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-23-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:09:55 +0100
Message-ID: <CACRpkdYkMMJnL9yyXJfhTc8Rn57ChB2bZWsKs=uJNKKea2DvXg@mail.gmail.com>
Subject: Re: [PATCH 22/34] brcmfmac: chip: Handle 1024-unit sizes for TCM blocks
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

> BCM4387 has trailing odd-sized blocks as part of TCM which have
> their size described as a multiple of 1024 instead of 8192. Handle this
> so we can compute the TCM size properly.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
