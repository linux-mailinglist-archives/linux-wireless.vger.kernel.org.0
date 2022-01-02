Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBAE48296C
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jan 2022 06:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiABFpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 00:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiABFpl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 00:45:41 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE636C06173E
        for <linux-wireless@vger.kernel.org>; Sat,  1 Jan 2022 21:45:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g26so68390918lfv.11
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jan 2022 21:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EAWwXHlTYT2aAtV9nfRbh+fLObBN/Vc+dUFwa1m7hM=;
        b=NtqICEPnHTugIrKVb4uE5H+ccSsW0m2AUHJJv+DOQBjE6RAORPK6hDoTg9AbXC2ebM
         EJwGH02Af3ngq0cEoeugSzUT6K+fTw6LSWqY6IrBXV8/bPe03RlV1zEjq6c/9DmwGGWq
         6lOwOEiqI0ODRl3NYirizlaR2kCs4RfN3J/EgL5Gofg+BNcc7tZwULni42KUziQfCNzH
         Et9BLng7f+6GnQp2QKIftjDDSH6xAKST57MjiufrwQcehGlDxPS4oQojw1nGmJ0yHv4n
         f5JKbSrx6EDY4XXuoW5Kn5C73UKtdsZV5Od+pleAlvPqmq3TC8Lu+zWf0kLyOnBFLrVk
         thIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EAWwXHlTYT2aAtV9nfRbh+fLObBN/Vc+dUFwa1m7hM=;
        b=2U7t6jgYgd5tc+IIN1642D3mREifcUQ/hTZlXDCCZnZ34R4ORxm/Sn56Ac/XaZvPRW
         K6WmkM9txNytmiAT+oyX9b88BQDN7ulN22BZ4X2R0w0Ahe48Y2x7k4h073jlsnqIEIfU
         qYNRGh8iiIsSynS3r7TqkkiuLUy2+GQfO83fLCbz3er2E/nW2nIAvHEgK9Z73r/RUdt0
         TZBPG+X1rPhDJaV/2ahzxXwPQPWUeWfHTCdMw1qF+2GMN+fDUojVQLisDDjol/vIRv9/
         mH0IC4FGlEl1W4rVhQktl045dIP8IXAJfFx2A/D6koRF7mdxIcaSv2qhz3FbURGU4XBR
         xc3g==
X-Gm-Message-State: AOAM530BIXKYLJvIyqmjfPoe1XTDiEJj/6eBOXs20dzaCweLaei3/SiS
        uV6NnVBPhT2I+5CNNbgp4649uVrmL2xJN+yELedrMw==
X-Google-Smtp-Source: ABdhPJw0U8KliC+SK3yNYeECc13z2dQDpc9pC9zZPe0Q+T/G905Dw8G+V0A59RdXRZ0tYOk2WAOgABJfLlYjWXg644Q=
X-Received: by 2002:a05:6512:2303:: with SMTP id o3mr36756881lfu.362.1641102338917;
 Sat, 01 Jan 2022 21:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-10-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-10-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 06:44:30 +0100
Message-ID: <CACRpkdZfP9LSq8JgtiLrZg_JjpSP3p1ERkdsLpq12tA3HzzONA@mail.gmail.com>
Subject: Re: [PATCH 09/34] brcmfmac: pcie: Perform firmware selection for
 Apple platforms
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

> On Apple platforms, firmware selection uses the following elements:
>
>   Property         Example   Source
>   ==============   =======   ========================
> * Chip name        4378      Device ID
> * Chip revision    B1        OTP
> * Platform         shikoku   DT (ARM64) or ACPI (x86)
> * Module type      RASP      OTP
> * Module vendor    m         OTP
> * Module version   6.11      OTP
> * Antenna SKU      X3        DT (ARM64) or ??? (x86)
>
> In macOS, these firmwares are stored using filenames in this format
> under /usr/share/firmware/wifi:
>
>     C-4378__s-B1/P-shikoku-X3_M-RASP_V-m__m-6.11.txt
>
> To prepare firmwares for Linux, we rename these to a scheme following
> the existing brcmfmac convention:
>
>     brcmfmac<chip><lower(rev)>-pcie.apple,<platform>-<mod_type>-\
>         <mod_vendor>-<mod_version>-<antenna_sku>.txt
>
> The NVRAM uses all the components, while the firmware and CLM blob only
> use the chip/revision/platform/antenna_sku:
>
>     brcmfmac<chip><lower(rev)>-pcie.apple,<platform>-<antenna_sku>.bin
>
> e.g.
>
>     brcm/brcmfmac4378b1-pcie.apple,shikoku-RASP-m-6.11-X3.txt
>     brcm/brcmfmac4378b1-pcie.apple,shikoku-X3.bin
>
> In addition, since there are over 1000 files in total, many of which are
> symlinks or outright duplicates, we deduplicate and prune the firmware
> tree to reduce firmware filenames to fewer dimensions. For example, the
> shikoku platform (MacBook Air M1 2020) simplifies to just 4 files:
>
>     brcm/brcmfmac4378b1-pcie.apple,shikoku.clm_blob
>     brcm/brcmfmac4378b1-pcie.apple,shikoku.bin
>     brcm/brcmfmac4378b1-pcie.apple,shikoku-RASP-m.txt
>     brcm/brcmfmac4378b1-pcie.apple,shikoku-RASP-u.txt
>
> This reduces the total file count to around 170, of which 75 are
> symlinks and 95 are regular files: 7 firmware blobs, 27 CLM blobs, and
> 61 NVRAM config files. We also slightly process NVRAM files to correct
> some formatting issues and add a missing default macaddr= property.
>
> To handle this, the driver must try the following path formats when
> looking for firmware files:
>
>     brcm/brcmfmac4378b1-pcie.apple,shikoku-RASP-m-6.11-X3.txt
>     brcm/brcmfmac4378b1-pcie.apple,shikoku-RASP-m-6.11.txt
>     brcm/brcmfmac4378b1-pcie.apple,shikoku-RASP-m.txt
>     brcm/brcmfmac4378b1-pcie.apple,shikoku-RASP.txt
>     brcm/brcmfmac4378b1-pcie.apple,shikoku-X3.txt *
>     brcm/brcmfmac4378b1-pcie.apple,shikoku.txt
>
> * Not relevant for NVRAM, only for firmware/CLM.
>
> The chip revision nominally comes from OTP on Apple platforms, but it
> can be mapped to the PCI revision number, so we ignore the OTP revision
> and continue to use the existing PCI revision mechanism to identify chip
> revisions, as the driver already does for other chips. Unfortunately,
> the mapping is not consistent between different chip types, so this has
> to be determined experimentally.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

It's a neat hack, and I don't see anyone doing anything smarter so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
