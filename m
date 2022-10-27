Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4057E60FBBC
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiJ0PVp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Oct 2022 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbiJ0PVL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Oct 2022 11:21:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F52E6BF
        for <linux-wireless@vger.kernel.org>; Thu, 27 Oct 2022 08:20:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso6167161pjn.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Oct 2022 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjaeAzYbLpTqLeuXQuLXU8W+540Dm77JLtd+8h9XfwI=;
        b=U7U9WRCmN4GaMmx4Lj0KgpaXZgNVTlav74v2V58yG2EuJwEGUGIgqZlBj9IwgiLYPL
         ClCBmAJpg50GmmG2p6qbLM+dvXdAggMCEVokN3KQ3zc/WeRDvBfes3ZVXKSdfKntGG1+
         +pDI8vHWC3XHcVc0l+IUj/HJ0ozNi9LlVSw8zJmksSrbhKqPLxC82CL3ao3q+ik0WURC
         FX9IJ+dx1Z6y8MdQyXIQDeingcg4advsG+vwg1eDP81XU43Eie0Bp+lRXWS0yu22LOW1
         PAg0u837mpnIb7msLXdpo1Kg5sskevcT0AC2a7PC1jy05YIeU3sc6GHSiRAKLssS00M+
         oBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjaeAzYbLpTqLeuXQuLXU8W+540Dm77JLtd+8h9XfwI=;
        b=N+ESrYK6HHVK4EWfGT0SU8A89uz8vrwanvcFyO/jj7yfeQG2DLLngkPrqRVp3ogqjB
         9/bjc7Uuner5rJpZsjZu2VGNgOafz26UWD7Wi+15vEiYDHZtv5gHMMiC79YahuWlSM9H
         Vz5/KNPMsTOcQhjEFSvTZW1XNJuNsnJJVcE0BwLfNNONT+QPKQeEWYlqDmqazj/5XPso
         6pYGquyJfkXQUbemKjb6l64fEczTEwbLIBL1OjynBEFuHU4Kd0viLJhJMxtdnl8eqXU3
         4Lhd+8p0USRqCvpHEUmHr0mk5BSy97WTaA1x6iq6fozlCHEm1hgOKjsbFo4WOFvYu+8n
         S8Qw==
X-Gm-Message-State: ACrzQf08tT9LY5eVletipHSRLv28zXD4cJFODGedlzWu6F1w+dRO5fJT
        dAj6gdMG/cPbfgQuEn/CZ/3SuuWiMQ8JoASz8iI=
X-Google-Smtp-Source: AMsMyM5K92a1ey3B1I0MOdg407iGSvyn/a+OFU5xAQFWxwMPyxGMrplEhIi/ncaG2mT2cuFZ1uL2/8ztiXkHFTIrsgU=
X-Received: by 2002:a17:902:a5c9:b0:182:3c47:6e86 with SMTP id
 t9-20020a170902a5c900b001823c476e86mr49270709plq.152.1666884056219; Thu, 27
 Oct 2022 08:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221026075653.105387-1-linus.walleij@linaro.org>
In-Reply-To: <20221026075653.105387-1-linus.walleij@linaro.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 27 Oct 2022 17:20:44 +0200
Message-ID: <CAOiHx==88cy0JkCdArBqfek8=6-t1uTXu-vw_-6V17oEtgf=Yw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: bcma/brcm80211: Use the proper include
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 26 Oct 2022 at 10:05, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The <linux/bcma/bcma_driver_chipcommon.h> is including the legacy
> header <linux/gpio.h> to obtain struct gpio_chip. Instead, include
> <linux/gpio/driver.h> where this struct is defined.
>
> It turns out that the brcm80211 brcmsmac depends on this to
> bring in the symbol gpio_is_valid().
>
> The driver looks up the BCMA parent GPIO driver and checks that
> this succeeds, but then it goes on to use the deprecated GPIO
> call gpio_is_valid() to check the consistency of the .base
> member of the BCMA GPIO struct. Surely this belongs in the
> BCMA driver: we cannot have all drivers performing cosistency
> checks on the internals of things they are passed.
>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Combine two co-dependent patches
> - Collect Arend's ACK
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c | 2 +-
>  include/linux/bcma/bcma_driver_chipcommon.h            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
> index c1b9ac692d26..1cce92c5780f 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
> @@ -63,7 +63,7 @@ int brcms_led_register(struct brcms_info *wl)
>         int hwnum = -1;
>         enum gpio_lookup_flags lflags = GPIO_ACTIVE_HIGH;
>
> -       if (!bcma_gpio || !gpio_is_valid(bcma_gpio->base))
> +       if (!bcma_gpio)
>                 return -ENODEV;

A few lines above bcma_gpio is initialized with

     struct gpio_chip *bcma_gpio = &cc_drv->gpio;

and thus can never be NULL, so the whole condition can be then dropped.

I guess the intention here was to make sure the the gpio chip was
registered successfully. The bcma bus driver ignores any gpio chip
init/registration failures, so this is (in theory) a possible state.

Doing no validity check can then theoretically lead to a NULL pointer
access further down. brcms_led_register() calls
gpiochip_request_own_desc(), which calls gpiochip_get_desc() which
tries to access gc->gpiodev->ngpio. If the gpio_chip registration
failed for any reason, gc->gpiodev will be NULL => oops. The
gpio_is_valid() might have caught that as base might have been left as
-1, depending on where it failed.

So adding a check to gpiochip_get_desc() for gc->gpiodev being
populated should avoid this issue, and gpiochip_get_desc() doesn't
look like a function used in hot paths where the check would add a
performance degradation.

Regards
Jonas
