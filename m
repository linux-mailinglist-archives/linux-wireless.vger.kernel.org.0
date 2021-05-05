Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8DF373E27
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhEEPL0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhEEPLZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 11:11:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01050C061574;
        Wed,  5 May 2021 08:10:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a36so2914586ljq.8;
        Wed, 05 May 2021 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DT3Fc4xJZnxmnZHXZAmBJ/q64yGckxL+AeHtyP2cBMA=;
        b=fIwIEfnbqACpLW7PZ4PS0H25eBj/ic4NKx1VRPZqCEG6XPM6NG085JoYW3XUyhd133
         CZeqeo3qohWoRASDQsNvEOiM9r3u6pfTp7QoMZNjdXXnN6TaSXTWZj+8OnxHzrjhVzAO
         SX5RotyYqGe7YAeCqx9xH79DkRWrX0miBhvpalhZr41k3Pz0MJG7wvaUU2pZF0iW99EM
         hKrqxwWr0phOdqGsTrXZgZdNGU9Of+O60nPDM2qmXw2Kgixus4hLH38RRr5s79uOwqGm
         tDUZnRhQXilVKnICxxcYJzb1YquP5DDqyPytWzGg4zc+YOhvD0/fGvWxKHzJievhiPDM
         +4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DT3Fc4xJZnxmnZHXZAmBJ/q64yGckxL+AeHtyP2cBMA=;
        b=Q4xK3CgOTQ3F1suaYb9Vmtjh4oKVdRXngqVPwolXn1PUkfRtTj8IGReqwd7/Q3uV1M
         E7m5P0GrmvGaRZgAPAPOQgYIlV5yDlmrFRIszKagnZHIrhJfngG8cExNtODn/q6uqfQb
         LzbyeDHwBoEWBYwWVCgZ6pc69dEii6+8Ee2A20xL+md3G14kmEwLrIKrHCw8g+IeqpRe
         DuLQ731NBecscN0ZEo4YkpShBY8AmZsKYmikvKEBCsyEBgQwlxSMyygVCHF7+SU+o20A
         nTVl91YjewC1G/XB7YiNecxz7CPBRlpNcZ3KYs0oQXKmpv/x2vQJxUCBbe4Iy0qyL3KN
         U1Zg==
X-Gm-Message-State: AOAM532XjP0lVKTWc7PMkL0QW0SbU9JTBqsGjn7NVvS4LIyaLxQw34xQ
        okNFBJKnhOsM0qWMgs4LI5zubPpOjXVW0mt6HVc=
X-Google-Smtp-Source: ABdhPJy5FJWNNk1Xa6D5PAeWLf2N3ogOqZtlZ02r4136vzWJT+UDlPMVz7qSWfswxDR11vi8tFTa8STDaGSDkkC57TA=
X-Received: by 2002:a2e:9d85:: with SMTP id c5mr21463224ljj.95.1620227427382;
 Wed, 05 May 2021 08:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210505140015.60013-1-krzysztof.kozlowski@canonical.com>
 <CAOCHtYiicw5bqaZU5g2QGJHG3DZKRQUwAr08NZHw81S9=hmrgw@mail.gmail.com> <7ced6d2f-7107-e612-6787-63e38e5e3edd@canonical.com>
In-Reply-To: <7ced6d2f-7107-e612-6787-63e38e5e3edd@canonical.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Wed, 5 May 2021 10:10:01 -0500
Message-ID: <CAOCHtYhPGiEX1-iBDr2SzktBZ8a_8TqYQu0NLrsqjkz48rfSaw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: am5729-beagleboneai: drop unused Broadcom WiFi properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     alexey.roslyakov@gmail.com, Drew Fustini <drew@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux kernel <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > I don't see the brcmfmac developers actually fixing it, as "out of
> > tree" work for brcmfmac is 100+ patches long:
>
>
> Thanks for explanation. I understand these are actually used by
> out-of-tree driver? That's a valid reason to add them to the binding then...
>
> >
> > https://www.cypress.com/documentation/software-and-drivers-archive/wifi-bt-linux-archive?source=search&cat=other
>
> Requires login - I am not able to get the sources.

Sorry Krzysztof,

I forgot that a login is required, here is a quick mirror (with a
screenshot of the page.)

https://rcn-ee.net/workshops/cypress-fmac/

Screenshot: https://rcn-ee.net/workshops/cypress-fmac/brcm.png

There patch with that binding:

https://rcn-ee.net/workshops/cypress-fmac/cypress-fmac-v5.4.18-2021_0114/cypress-patch-v5.4.18-2021_0114/cypress-patch/0002-non-upstream-add-sg-parameters-dts-parsing.patch

Thank You!


Regards,

--
Robert Nelson
https://rcn-ee.com/
