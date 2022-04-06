Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67A54F6C7D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 23:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbiDFVWU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 17:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbiDFVWA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 17:22:00 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608142717
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 13:15:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so2497718otj.1
        for <linux-wireless@vger.kernel.org>; Wed, 06 Apr 2022 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m00inXLsYAfzvYIW/II1tW320nqaQxttADqjuEF1Tno=;
        b=X9XD4aMg2fBML82/FrVWNYY20xbSuEW3/4npswgINFhmDoQnDt5peCfWLCuHPmCFmH
         SvyoBFjt5eskmUFbJJypdVM34w+H1dVduqAabya2sBJ+GhtspfaNq9kBIdH+8yCJSTUg
         jVeRNP1hMuHtTrySN6gGy+BMUbFqeMGRJ7hEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m00inXLsYAfzvYIW/II1tW320nqaQxttADqjuEF1Tno=;
        b=XNpXHOKn0e6/q9FR6fziCIh1Jm5z2NYCUBSPhxv8S28sdrcab10lcDTGnSsY/uHwus
         RkGKMiDgVjU2ENhjDbWEkq21AGLb7y+f0RXfpPtTmrhKi/g9HaDgNycCagNkEFnbLLQO
         VEuPaHakPsnzlcla/m/+writV5hOz8ZbwTbYtJI+2lBSVhGwDBdb8SZhdVlk8SkFjd4z
         HjmtyFapAPqb21VQuESPVRtwWTvPWbr1CPdhIxr6GofamC5sZabZ4Y7Hx0798uBJ+iO7
         3ppq3uyDaZ9SzbUteR0mOE7ST9D3GExpu7r8PUcUh5gAz9G/ym5Dy5qFiMnlYW2UOwMk
         uIbg==
X-Gm-Message-State: AOAM530NbVqByVq0ZfV7E7yl4QKrAoqX97r1NBDXRp5Hmpdcivgxzyzv
        dhzEkgdeA8IpNY2hUYBeyYlI6SLpYLjn0g==
X-Google-Smtp-Source: ABdhPJw186e05S2xff4RnucTIVOiJnwRGi1PJmvtBG9n3S6qqnFY5E1l5dlzp+dE1GNQO1ZiOwJqUQ==
X-Received: by 2002:a9d:70da:0:b0:5b2:4dcf:fc74 with SMTP id w26-20020a9d70da000000b005b24dcffc74mr3501941otj.376.1649276156444;
        Wed, 06 Apr 2022 13:15:56 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id v24-20020a9d5a18000000b005ad458facbdsm7448157oth.27.2022.04.06.13.15.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 13:15:55 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id i7so3577040oie.7
        for <linux-wireless@vger.kernel.org>; Wed, 06 Apr 2022 13:15:55 -0700 (PDT)
X-Received: by 2002:a54:4593:0:b0:2ec:d27f:eec1 with SMTP id
 z19-20020a544593000000b002ecd27feec1mr4404243oib.257.1649276155184; Wed, 06
 Apr 2022 13:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAA=hcWQFNOeycXFPhrtHcQG3V8fWSShNRuAi49jtv8h1fPVUuQ@mail.gmail.com>
 <8ef5d73a-6293-a6c5-6bbb-b130266a8f0b@broadcom.com> <CAA=hcWQ_FVTVfRe91z1yHXMBLkkhi0eTq-9Lw3Tg=X6OS5Ku-Q@mail.gmail.com>
In-Reply-To: <CAA=hcWQ_FVTVfRe91z1yHXMBLkkhi0eTq-9Lw3Tg=X6OS5Ku-Q@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 6 Apr 2022 13:15:44 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPXCLjSL+mKKn-vh0fx0jdGBN-HOSDh4Dvy+93HSdRfBg@mail.gmail.com>
Message-ID: <CA+ASDXPXCLjSL+mKKn-vh0fx0jdGBN-HOSDh4Dvy+93HSdRfBg@mail.gmail.com>
Subject: Re: Support for bcm43364 wireless chipset in brcm80211/brcmfmac
To:     Jupiter <jupiter.hce@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sean Lanigan <sean@lano.id.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 6, 2022 at 1:09 PM Jupiter <jupiter.hce@gmail.com> wrote:
> Our original design was using Marvell Avastar 88W8801
> chipset, the driver mwifiex and wifiex_sdio worked well for kernel 4,
> but after NXP acquired Marvell wireless sector, NXP stopped supporting
> mainline Linux, the kernel 5 mwifiex cannot communicate to 88W8801
> chipset firmware, we were told to use the proprietary Linux driver
> sources which is incompatible to our Yocto / OE build system, we have
> no choice but to change the WiFi module.

Despite what corporations tell you, mainline Linux shouldn't be
dropping support for things just because the corporation moved on. If
you can track down the mwifiex regression (e.g., with bisection),
there's a chance we can fix it. I still see
SDIO_DEVICE_ID_MARVELL_8801 listed in the upstream driver, FWIW.

Unfortunately, without anyone paying attention (Marvell, NXP, ... or
you) that has the hardware, it can be hard to guarantee things stay
working. Hint: while I have (and care about) several Marvell chips, I
don't have that one.

Brian
