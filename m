Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE353EB304
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 10:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbhHMIz6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 04:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbhHMIz5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 04:55:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1111C0617AE
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 01:55:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m17so10914153ljp.7
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRJ2425isHE00uMB5hvHaCbM2rZD365pwhUWk5w/BXc=;
        b=O9Ic7VzFR8Dxy+IG/c1pNtqijWlKbBK7f6mns/c0w8a+Hv1MlD/c2azRHt2h8eCHki
         2ykgSXbimIgKjVTUKejS8RpeDqvQ7vJlJZ0PRDWjHC0q94Um+P0d6NNafrXc/DzIwd3j
         DhlLUlLslIPq/qoiISxGwmuDuY3QQ7LIDf3ZBhmBXqEOaShyV1XhbZcW1zvf5qfKKbkZ
         EDUXyj+x+a88Gnnx0gecrVUjmfkT2Fa9xwaErfFN0GZn3Pb7eCsBlgmObCfHAkTYD5RZ
         SXOdajB+Ancj1czXHJkbrJsD+rcoIvbMYKBO+two5/S8TNvsGa9rtHXI96SRtI/0Gj6i
         aiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRJ2425isHE00uMB5hvHaCbM2rZD365pwhUWk5w/BXc=;
        b=r9rWZ8fBf+9WGw1YGiJgMpSkBoqHAMZG6AvnhWJFOZXgDbPMdjuXMBtcam24+pig+f
         suzlO6lbE3paerAPEbMQrgjy9A+WtYOxhNW/CcaAa6ZC5PaGo4cvjZV6vlPsc4882273
         YXOKzi3JEXJO1WLyWlrHf7GAwE5k2SIAj7M2LEChLLsngU7GCjLk4p5XnwaE8NeT6/Pu
         dO/2UmBDLH5P2rRaUPCYq9CX3LVGM6IqXhYAZ4anCFgRfaCe2W7CVPDbynMlK7hk6w70
         W4cafBzg93ZnBK678rn7hby/e14G70o1sWw/SUbbBltruq0+NNhKPw+IJFrxlTNbH8xa
         g+bQ==
X-Gm-Message-State: AOAM533V9ddijon5a1WWR9CGR/S5J2MDo8mTZYVMYv6EIm5YaBhC9X0S
        wmmTv8V084XW2XHjbenjzgwTsHE8g9iPFzXBbQvsrw==
X-Google-Smtp-Source: ABdhPJxSOmQyZLGDAfWS7wB1WYvUYNHu0jF1ziU0U66IHngmPPPTVdHMrjUAzXEsLsm9wp1PpzXbRbTevw4fjF17lhA=
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr1100690ljp.74.1628844929180;
 Fri, 13 Aug 2021 01:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210812170300.1047330-1-trix@redhat.com>
In-Reply-To: <20210812170300.1047330-1-trix@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Aug 2021 10:55:17 +0200
Message-ID: <CACRpkdYTsEFPBhByKCoA71D-LiJ4iptQcRkzB96HFUPJKxyBkg@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Fix fallback logic to use firmware's canonical path
To:     trix@redhat.com
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 12, 2021 at 7:03 PM <trix@redhat.com> wrote:

> From: Tom Rix <trix@redhat.com>
>
> Static analysis reports this problem
> firmware.c:709:6: warning: Branch condition evaluates to a garbage value
>         if (ret) {
>             ^~~
>
> In brcmf_fw_get_firmwares(), ret is only set if the alt_path control
> flow is taken.  Initialize ret to -1, so the canonical path is taken
> if alt_path is not.
>
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks!

But we are working on a more generic solution to this and other
problems in a patch that Dmitry has asked Kalle to merge.
https://lore.kernel.org/linux-wireless/20210808180510.8753-1-digetx@gmail.com/

Yours,
Linus Walleij
