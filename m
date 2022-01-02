Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751E1482A08
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jan 2022 07:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiABGPS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 01:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiABGPR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 01:15:17 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E892C06173F
        for <linux-wireless@vger.kernel.org>; Sat,  1 Jan 2022 22:15:17 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u13so68401631lff.12
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jan 2022 22:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWErgVPSbPgPS0cot2KuzsoxPnk5t2poaH8xxZaNOfk=;
        b=yDNjcq4g15xOFHBXQDmYyXN8EZZbyJUjHUrUfjBIRdjYkk4XhGgviRbuxzqnIhrwHI
         IAixxYAZhkVclfTndwOLRDv2dL2UFC3tvno0yBgTm6Ci0hrA+ZdiWNzdktiKBRhGGkYC
         E6EtUZpkyiqGeQxH0sK8EdwBlKyotxF5zzKj8h8sWvUTE2jqW5dOdb/cU1FUbkzE1IdF
         EXtBDALv7qNHkEoUoNMY5LVZr8458hpNNGb+T3fSDdIxhFfzPOsMhhAX1BiB2CWnlNt5
         SFU0ZapAjcGxfx6GhJHXVkO49P2FBilbj561vi4KXabYoyNo8z0uwThYrMZ7KFXNmePB
         ioBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWErgVPSbPgPS0cot2KuzsoxPnk5t2poaH8xxZaNOfk=;
        b=6XOgtKioVCFUkzVicyZ8rlzaLOA0iErhSuNJcGSO9SSIh7y0yQqQZh8P2XLNEy9FmZ
         PLWS3sToZ1dMeCVHKOuD6vb0F/e9ilR6u1b8S0fhkS9OT7I/IlaWblnEdGHOAKx8skay
         AnZxh2F5t/O5N5pd5q8qQ+qfJAhDSv9ka3sI98iLb7CizfT2Lktc+cc2aj+NAHgKXcqm
         NG7yqvobzj0LMednRiHn+C0X2UOA27pKi096H80AcRgjDHtHl/ossRp57CKJaUek5sWY
         X2LG+vD3H9hJzfT6nZlj/MqALHtj1rL9G2UjxY8MYI9cHIUdmV5B2nD7MJNkMFeDE5M+
         fjCQ==
X-Gm-Message-State: AOAM5321nx9MktnZVpcEYG0KhnB4GFethToCk9o03cnW2dtfmXcQMeH7
        qNGU89wsipoSBaEwzvexchAlb+kPpr0zKkkB9di4vw==
X-Google-Smtp-Source: ABdhPJxCopLUWq+4ft+NVnaS82/nys0iopBB2B2ZS6BEHXy52c/7c79JVhvvzJycZWI0WqHdXsCC4MjxOpz9+YpqrZs=
X-Received: by 2002:a05:6512:750:: with SMTP id c16mr37650476lfs.622.1641104115576;
 Sat, 01 Jan 2022 22:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-29-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-29-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:15:03 +0100
Message-ID: <CACRpkdYGQkTEHFNtLB=gMV-jkPWiF8mjUVv_C_rTyd7bxrYcXA@mail.gmail.com>
Subject: Re: [PATCH 28/34] brcmfmac: pcie: Replace brcmf_pcie_copy_mem_todev
 with memcpy_toio
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

> The alignment check was wrong (e.g. & 4 instead of & 3), and the logic
> was also inefficient if the length was not a multiple of 4, since it
> would needlessly fall back to copying the entire buffer bytewise.
>
> We already have a perfectly good memcpy_toio function, so just call that
> instead of rolling our own copy logic here. brcmf_pcie_init_ringbuffers
> was already using it anyway.
>
> Fixes: 9e37f045d5e7 ("brcmfmac: Adding PCIe bus layer support.")
> Signed-off-by: Hector Martin <marcan@marcan.st>

Excellent patch.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
