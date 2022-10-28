Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FAA610CF9
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ1JWh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJ1JWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 05:22:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D921C4EFB
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 02:22:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f27so11590154eje.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O83Fi5kTYRhO0BiDFXy0lgVVxdUcLpSvo7N6eOyAPTk=;
        b=InUlpa3CwRjyS+ks03Zq9bFMl8h4b+r3EVGcS6vPH/UuJSsUwlkYnvxhxJL0lkQGxD
         EMJ0ui+00AFo8jVMwSGuHE83oshHGtHbF2FMfvWj7My7EBPRPmXO8d9o/mgrf8z54whs
         M9TX1ANMatk7K4bw+bhaANQcKNHle0GezR1f6+0uWQuB5d0a3+dvKHRrGkh1xnGI5ihe
         qTReza1MOTdknogRr5IwJ+F7xn8ZIyhf+KteCaF5/haOe1rQYqGEURW8E4OxeMX1wInT
         0HfSm0l7Q9M4Emvm233SVnfSqtZazIICzv5JgIunJkUwmiXR0M2RtzhCDXImCkQNoA1G
         0iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O83Fi5kTYRhO0BiDFXy0lgVVxdUcLpSvo7N6eOyAPTk=;
        b=MvPII83mH8DFty+h8JVb5M7seX6UbAB6qoaEv8d9N/vfClu7iBhSkGiuh2u1U648GL
         y5elEFNXB/3R+fWhqgudQ+fKF4NAUcSgYM1iFuyaIQ+u9djIX5ec3ZGYQqWsV/i22d3M
         YbGxYBwwOktnxHR94MinHJRhgI5hB6EuE7kLuDm0lb7L7jWsHi7s0rILmyOoLkZWnMqY
         gqFfF/tHRuNnrTG0aNwtZoEMjYbxhIsfMmUnAspqQdecLU98IvgTt5sSi9p8Hqibejna
         GXPUFu8DjOLOLR5H8yVDID6VATFOeTGKBxW4XRZiO5gvpQDoczTfsmWXXTGizype9bbI
         SaCQ==
X-Gm-Message-State: ACrzQf0hS85FeZMCCj/IkInTGEqoJhbL/uko65QF7kCiiEYXcfmnaFqT
        dVW3HA4y9VfUsrelAL9DBufDx85rQSlTSW1Hh18QRg==
X-Google-Smtp-Source: AMsMyM7+MZ0CKywodSPI3dmfN0i3aIWBaqOKGixjcOggE49E+820zwNQ5njFUDJga2WfhYVDoRpEia0aonVJ02LgeVM=
X-Received: by 2002:a17:906:dc8f:b0:7a5:8160:1995 with SMTP id
 cs15-20020a170906dc8f00b007a581601995mr25722765ejc.500.1666948954233; Fri, 28
 Oct 2022 02:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221026075653.105387-1-linus.walleij@linaro.org> <CAOiHx==88cy0JkCdArBqfek8=6-t1uTXu-vw_-6V17oEtgf=Yw@mail.gmail.com>
In-Reply-To: <CAOiHx==88cy0JkCdArBqfek8=6-t1uTXu-vw_-6V17oEtgf=Yw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Oct 2022 11:22:22 +0200
Message-ID: <CACRpkdYy9bNPFXph426KW0U+qPDYyyRvbvc5ZhrKs8YSQz7v0w@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: bcma/brcm80211: Use the proper include
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 27, 2022 at 5:20 PM Jonas Gorski <jonas.gorski@gmail.com> wrote:

> A few lines above bcma_gpio is initialized with
>
>      struct gpio_chip *bcma_gpio = &cc_drv->gpio;
>
> and thus can never be NULL, so the whole condition can be then dropped.

I will send a v3 deleting the whole check.

> I guess the intention here was to make sure the the gpio chip was
> registered successfully. The bcma bus driver ignores any gpio chip
> init/registration failures, so this is (in theory) a possible state.
>
> Doing no validity check can then theoretically lead to a NULL pointer
> access further down. brcms_led_register() calls
> gpiochip_request_own_desc(), which calls gpiochip_get_desc() which
> tries to access gc->gpiodev->ngpio. If the gpio_chip registration
> failed for any reason, gc->gpiodev will be NULL => oops. The
> gpio_is_valid() might have caught that as base might have been left as
> -1, depending on where it failed.
>
> So adding a check to gpiochip_get_desc() for gc->gpiodev being
> populated should avoid this issue, and gpiochip_get_desc() doesn't
> look like a function used in hot paths where the check would add a
> performance degradation.

Hmmm that sounds like adding consistency checks to gpiolib for
fixing the fact that the BCMA driver ignores registration failures.
I would rather fix the BCMA driver to not do that, I'll check if I can make
a separate patch for this.

Yours,
Linus Walleij
