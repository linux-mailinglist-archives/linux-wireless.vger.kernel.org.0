Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4A4829F6
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jan 2022 07:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiABGLt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 01:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiABGLt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 01:11:49 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794B3C061401
        for <linux-wireless@vger.kernel.org>; Sat,  1 Jan 2022 22:11:48 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id r22so50979215ljk.11
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jan 2022 22:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLYs6RPdlYoNdW+4UL3boVj/wZ9DVO7dQZSS21vPQg8=;
        b=k1AOt9g7ctt0LaNkr2kqTxIjq3+DWOMbt5ZOTBEJA6LntouCvz3cYAhESGIrt+jF0n
         ThCPNtuYU7nqQ93Bv0wFNIvD4gbfeV0LShkAxf5Pr0L5cPrKs2+YInUWDDQu7k7SJ5p6
         dW8xprCt6mIhj1AUY+0jhZHcBb5vkt7Q955Netg7siEtQuDgaeEx8X8gGl62VSvtVW2N
         gBkrprBk9ggy11Y8xjCLCx2NbSC3yW+m+PUtZyybJOs9RAu1Jw0ErbEyapVGNta+aa2K
         zhHVlyN89pAO2JUBqUUrUym51c9J7skKnHoo0d0iNNhQOeAFJzN5W29j3j0hQ7FocYqU
         wI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLYs6RPdlYoNdW+4UL3boVj/wZ9DVO7dQZSS21vPQg8=;
        b=fEWtlqObId4XX94OENof6qK0siM2S4un5m3AzbFLhC4cj0a/HBncrYH48zzKgBzjE8
         ZenBF965Pzmv/KH5f3jCY94XiqH1Z/41Kzr8smYnXZ/53LItiuPo3ehLLYASx1sLdSor
         wW9RruVbci3HbIb5bRcV+nFJAi+TyJ8KACZD3Pgl0gt/CIHTYnUrSzUprPQCJZiyAaOX
         vijRcFE/5R865SeGaIRRjm3paZApUi6bq8Yi/7FmSQ8Tl+Di65sYfD++GSrqLa7Uw1FO
         VdwJuSigq8fvrP6GxqJHcYazAULzW1GA2ETL5vh26MhzaN4WeO/kt5upION6c4ofj7VB
         Dd4Q==
X-Gm-Message-State: AOAM530WHY7VDyP5MZIpNvi4Wsu8EtTMC5sd6YacxR0PUZZrEUWQ/Zjw
        gsafjZAcng+b6nKkWmJNhqe/jhqStxnOZopd6sRM1g==
X-Google-Smtp-Source: ABdhPJwgIObPmwk+diSjYih9QUhroCYQGoR5YghpXUjDlvzhjBXtDoMBCB6FepG9wKcYRFCuczmvG4SeU5CjPd2DRiI=
X-Received: by 2002:a2e:7c01:: with SMTP id x1mr33723616ljc.145.1641103906802;
 Sat, 01 Jan 2022 22:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-25-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-25-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:11:34 +0100
Message-ID: <CACRpkdZJnXhzDRhZt97Svf5pU5T_Xc2mfxFFnibNda7JJ8fiFQ@mail.gmail.com>
Subject: Re: [PATCH 24/34] brcmfmac: feature: Add support for setting feats
 based on WLC version
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

> The "wlc_ver" iovar returns information on the WLC and EPI versions.
> This can be used to determine whether the PMKID_V2 and _V3 features are
> supported.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
