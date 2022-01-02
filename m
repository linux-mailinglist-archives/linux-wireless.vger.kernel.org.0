Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CEC4829D6
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jan 2022 07:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiABGAy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 01:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiABGAw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 01:00:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5157BC061574
        for <linux-wireless@vger.kernel.org>; Sat,  1 Jan 2022 22:00:52 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g26so68445176lfv.11
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jan 2022 22:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTLmkAGe0nMUNWPjMKpLbDUGkN7ojNy65opvZtoCGow=;
        b=ngXXgI5MFCua4XE6UIuvOL3zYQCZkNeU6n0Khg3UpYyr3l07WCX0OrVf4nSBfQeEbq
         alRr1JnZ3PvXvKSeNKXQboDjsFpBF8CGwnT0a2KA1dWftbkA9oU/CB2gJIdOV2xbuqz5
         Zfj/reC5Hu+RzVnaphUVbKDvy9Bk9J8R0DTJZPuEYB/7fNiZmCyOJwHIHmulsQnGt47j
         qoGpu4AeEmvW/zi77f+SQnYyOjkH/NnFGRmtH9LTYCIOtDGvoU/Lei32PPFZvC7iteGl
         k7/2fp4iU7etc8itLW19f/8h/5/9OvOupfCfEhDTnUI+zu9WUF/LKZlsTck5AWcbhWe5
         h5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTLmkAGe0nMUNWPjMKpLbDUGkN7ojNy65opvZtoCGow=;
        b=PCN8kFFlAYLhhUFac1wW2OIVquJw2pM8D3FIW/7Z011JG73kDgfk5N6aea/P+KaDli
         4UN11dKwZQPfcPMQL6hdRL/oz32PypRb2uszpl//vQOaE+2Tj0uRUl+ioLzzAboph/Ey
         EWYvV2viQKFmqCQfL4OIQphzSR+FMoJQoJwkdPMruBIfC1N6nsNMDey7ZS5kNru/+P06
         XzKjOnF+M+/jdEI3SVlPhfyfuAqRcO8uWp+GEYwULEe29sQR6CPvbmqFZPiBVTrw6wEX
         llr17O+LyNlnxqA+72RtZ22qG/V6J5itzEstCqUAkpY9xao+mgSPIlsyGMkDtCQdfSOu
         mtQQ==
X-Gm-Message-State: AOAM533abKJx7ZUWcS2f7GpThV+BGOJ0CQFD1VgAzK16c0ymAbDfC5FY
        h/UqU7WVcq35LuJQ3O7SdSjA8AUK6+rIwZEpIcxIIA==
X-Google-Smtp-Source: ABdhPJycF0PZrYIBhbNaYzZXJsO4SuCYCZ+KgaA+cK/5b51H/hols6a1ZdcsP/UHLOD7kBzjTTaIwnvv1hnAoxJDvUM=
X-Received: by 2002:a05:6512:39ce:: with SMTP id k14mr19035581lfu.508.1641103250662;
 Sat, 01 Jan 2022 22:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-19-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-19-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:00:38 +0100
Message-ID: <CACRpkdZ1gRO+qyEPmKMVdMcLuOdekEMye5_4gLQCdFDF8f=r0g@mail.gmail.com>
Subject: Re: [PATCH 18/34] brcmfmac: pcie: Add IDs/properties for BCM4355
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

> This chip is present on at least these Apple T2 Macs:
>
> * hawaii: MacBook Air 13" (Late 2018)
> * hawaii: MacBook Air 13" (True Tone, 2019)
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
