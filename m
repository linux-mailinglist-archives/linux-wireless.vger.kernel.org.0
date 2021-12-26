Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17547F8EE
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Dec 2021 22:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhLZVCg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Dec 2021 16:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbhLZVCf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Dec 2021 16:02:35 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BBAC061759
        for <linux-wireless@vger.kernel.org>; Sun, 26 Dec 2021 13:02:34 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id t23so22625428oiw.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Dec 2021 13:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoKOFZqYbYv+X+woTmlFO64pUuH2MUVQ7sZJSSV9Cfo=;
        b=BswxkzUe9gg/ulOJpUucoDuUhmuRfURv7trDNw/xGp0trtwlmrQu7s7D1jwCxCMejF
         M1PViAp0EYb6+kyYM51DGkOT66zTdrO/F7Un5xXMQtZkmtnE95BXgA/49WbCrdc1G6ea
         Reips8FJ0hy+Qyjdr2go+ctZu7Rixl9UWaSi6dUHSeS4nSOS+fhhHALoXxD9hoXEwecL
         YMjECjmq10bBaKbD/scTR4R6r+l8ezNWbCHsBLEj5CKpG58+vuFuNFMAsvbq4+KXNNcD
         NadLS6bB+I3+ePkRhWLxQ9LGcI/t3ezHOChvF11bZywOO1QCqUtS+AY62kdfJC30Vw1B
         wK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoKOFZqYbYv+X+woTmlFO64pUuH2MUVQ7sZJSSV9Cfo=;
        b=AsJjl/ibuIqSZuVKOe93p1Loos587/eAAaSNugw+KtfJHKTlE7sO2RjKapzzAdP5El
         E6y5E5wUBuOmau63WBq4U9cx6Rnvpf23irQumX3Qf4L4hkewZsIv4CEp+R2EVrxljkgD
         xxdIe5RsKoR8h6YbzuAzVIDdv2jXKnoRD2IUadWAOZFT249/ngqhE1uWen3QpgrFB91k
         WOFnpBSeJNWcxHi/CGFhzdgR20XFPrUOX/rtHeYFApoDvguTflxGBass5b6uHcpVNwnN
         coB8LL5pdN3auq7iVh7oxZFokaXPfLfv+sAHm8/LkxP4S+SJ1jTKQwjJgesR6zyFzoO5
         89ZQ==
X-Gm-Message-State: AOAM5315IMExwHXn29VYhYLVvnQ8uabXCKlD5W9UBC4gdQBEXx/du6Mu
        nPGxLvRG0bsek6fHSfP3N0w2TcpQjaEPgnKzfQgDZw==
X-Google-Smtp-Source: ABdhPJysHej/1ZW0CGCLjGcDWMDxb/FXOm00MSyVswZ6tq+EHi5QK7iKehjci8VGehCjX0PfnY+97cxAyPy6Moi/zNw=
X-Received: by 2002:aca:5a87:: with SMTP id o129mr11644967oib.114.1640552552719;
 Sun, 26 Dec 2021 13:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-2-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-2-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Dec 2021 22:02:21 +0100
Message-ID: <CACRpkdZP0Y5FPBjSZRNFxT7m-Thek6m83r07J5KBY=ekwMuMVQ@mail.gmail.com>
Subject: Re: [PATCH 01/34] dt-bindings: net: bcm4329-fmac: Add Apple
 properties & chips
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
        SHA-cyfmac-dev-list@infineon.com,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Dec 26, 2021 at 4:36 PM Hector Martin <marcan@marcan.st> wrote:

> This binding is currently used for SDIO devices, but these chips are
> also used as PCIe devices on DT platforms and may be represented in the
> DT. Re-use the existing binding and add chip compatibles used by Apple
> T2 and M1 platforms (the T2 ones are not known to be used in DT
> platforms, but we might as well document them).
>
> Then, add properties required for firmware selection and calibration on
> M1 machines.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Makes sense to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +  brcm,cal-blob:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: A per-device calibration blob for the Wi-Fi radio. This
> +      should be filled in by the bootloader from platform configuration
> +      data, if necessary, and will be uploaded to the device if present.

This is especially nice. This way on other systems U-Boot can read the
calibration file (usually stored in a special partition) and modify the
device tree to include this, then we don't need the driver to learn
about any specific file locations for calibrations or worry about
inserting it from userspace.

Yours,
Linus Walleij
