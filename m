Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A660DC92
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiJZHyW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 03:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJZHyV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 03:54:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF7748E7
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 00:54:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fy4so19089917ejc.5
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf4TIwGMW+LisNcEE+k81jWjQJtPjkQICj28ZJKoIGo=;
        b=vhm/x6sSUww51xloScgtarLTZZzmMZbFWZRVkeC0Osw0my2DoV3M3vzSdyxola5xyI
         HsMk/RV7j/pMTBifhurbo3Wy+Am6VBJdO0eGd9dYqoaMxjUloE2k3ciiXbmOErj9s/wq
         XHrRUg+cSeoXGZeAhnQQWRi7LXrLkvQLhmJeWrs6XYM5GRCaqZhn25apTMU1Y94CpyYL
         7Q0mJQYiJX0npCc73aLcptaIOBafdVxDuGx6jl/FAhmGZSB27Lcv2KSNUBJ5mw3c4b+q
         5c8LKw/bJhuuYVu4aoX3SKy4hO6ObZyIGrcpB+qvDdI6ZgIUWnCTcW93nuLoOPyNAv7v
         rI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rf4TIwGMW+LisNcEE+k81jWjQJtPjkQICj28ZJKoIGo=;
        b=nnHswYQDeK4N+fcmXkzkGjxXueixm+XQZ9mJ/fn9KLjL1wkQueXToPCAFodWT7WL/a
         ErmipTispOdGCTLfDWyZs/J7ho7rlqTnvp4uVV72vwObs8nWs2/b/QHKHlapCs1O0pXF
         BJj6jzfPJ+TEcWwn0k8rd8foOf3pdxlN8DO7f/dl5szyWsgcmpD6ytlBlX8g9KoGf/Li
         A25kpZo04parZMlWiD5S4xL15cxFtZkjYOYaOFC4/oqtNLmhbhcCCNhG76Lts5qmIzcv
         4ju1GmaxBIXeWhKRmwCXmltwfMq2cb7C95VXZfflMULkKaVeNVrSB6BfJolRJuxRmOIW
         Vnag==
X-Gm-Message-State: ACrzQf1t0FaDlx4/G0aERkr4hFu54FrgkR1CnvTF6JN14RHUwf8NW4u/
        a7/H0F0ZSnPzWP+KbnUOEF6OKh03HoyfysDKG4sLNmZ4tV1vhw==
X-Google-Smtp-Source: AMsMyM4dMRU+poTZe52S8umRjz5aQD6FguXnMk8T1if6KtZUJnv+0Jf4xVP3POU+AxRWW9cI5UxPKOO+eNytBihSJGQ=
X-Received: by 2002:a17:906:dc8f:b0:7a5:8160:1995 with SMTP id
 cs15-20020a170906dc8f00b007a581601995mr15502439ejc.500.1666770859459; Wed, 26
 Oct 2022 00:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221024122828.9692-1-linus.walleij@linaro.org>
In-Reply-To: <20221024122828.9692-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Oct 2022 09:54:08 +0200
Message-ID: <CACRpkdYbs5uvZXHqP0G=rZVFAYiF24TYCPVcd7fjzRe1Agwucg@mail.gmail.com>
Subject: Re: [PATCH] bcma: Use the proper include
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 24, 2022 at 2:28 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> The <linux/bcma/bcma_driver_chipcommon.h> is including the legacy
> header <linux/gpio.h> to obtain struct gpio_chip. Instead, include
> <linux/gpio/driver.h> where this struct is defined.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I'm squashing this with the other patch and resending due to the co-dependence
found by the kernel test robot.

Yours,
Linus Walleij
