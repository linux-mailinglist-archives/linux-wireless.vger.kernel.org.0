Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7186482A23
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jan 2022 07:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiABGT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 01:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiABGT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 01:19:28 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B2C061401
        for <linux-wireless@vger.kernel.org>; Sat,  1 Jan 2022 22:19:27 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id x4so33519827ljc.6
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jan 2022 22:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghFlkQwtpFZle9fRX3OIytUtB+LtWsXwrtzMbGq2Ook=;
        b=QWaWYEkaiKHWtUPW5E9OP5/d0ezin7XI6byBRUim488xNn77UuTFsZ0PVzkpo6YUee
         rLIO1nRF1ypdO545s1Q33dtUuCKlwXYWM5EgOv9EqY2DOfKPYvjEuc3cWzmO0gbc7Q4B
         WVSsyxTB3Viyae+3WH6QQ/qeHpYkL5eyJuj6hHCq2mdleDa4HFyWSbZTiQlNT9lnhUS8
         pizKj88ybEpzwDXgYudEk4BGAl2UQawkmEtJMTqaRhZjAuq0RErHTbzZav2p2MO5j6t8
         Wz0nevKC9MWBVXh9i9ZcPxnd2vK6icI28cvW3lAnezfjFLOQjwrqjrhiZ0MSs9qPa0ac
         cWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghFlkQwtpFZle9fRX3OIytUtB+LtWsXwrtzMbGq2Ook=;
        b=7Kdpcrc6XctBK6ApHZSnFKb8uWDk1XovqU/9MqlVyN250Wr2zOUo+6fiZ7t09CPQlS
         n5akvo7Q1aqdweClkYz8tAOfnyyreNDkMg/BumHfgiGxb+emOo2vDDxotJCYiRrnWyaa
         oh1xfoLaA03RtdK7lfUr2E2ajvLBS0pVLc5IuoBEAAstZgKfCWQKtiyCqBcEgYoeGwDp
         OPQ1arzCtvA6Bod9K+tx8FWd6Dos9cuHFsvLl9EehkUdwcuW+1/1A+XFqKelwYLgiUin
         AolvQQxudwhmt2jfn3OsY8BC7IEqS2k3vZ6XlK2Epkj/ALXl/mUmjAZvRhrXBe2alGor
         23YQ==
X-Gm-Message-State: AOAM531hspET2H6sa19VBN+JKfoQGyznVfpGmoFxYl2km/pl2zSAdrPD
        9v8JMk32APykX0lOzmtRd62D1hZW/6d+naiDRRs5Jg==
X-Google-Smtp-Source: ABdhPJw4eXqQQgKISxZskwxOq4PpMVZbJLQ7rU1C/WPZxezRc07IeaL7/JZeSzY2fgnSTEU/0k0KWPsmQ++kmflw09Y=
X-Received: by 2002:a2e:8810:: with SMTP id x16mr31143976ljh.78.1641104366005;
 Sat, 01 Jan 2022 22:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-34-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-34-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:19:13 +0100
Message-ID: <CACRpkdYHN5_XQEMjY-PSmf_1sr4Wna7T-GQhSbP4aZaefaSvUA@mail.gmail.com>
Subject: Re: [PATCH 33/34] brcmfmac: pcie: Load and provide TxCap blobs
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

On Sun, Dec 26, 2021 at 4:41 PM Hector Martin <marcan@marcan.st> wrote:

> These blobs are named .txcap_blob, and exist alongside the existing
> .clm_blob files. Use the existing firmware machinery to provide them to
> the core.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
