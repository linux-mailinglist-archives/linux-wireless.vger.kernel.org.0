Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89D26194F8
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Nov 2022 11:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKDK7s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Nov 2022 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKDK7r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Nov 2022 06:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2FEB4A
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 03:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 398826214E
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 10:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CE0C433C1;
        Fri,  4 Nov 2022 10:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667559585;
        bh=i3xf34hV4KKUOCbXZErRscJDNK1UhojIoXHiT48S/rw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=W4jlzmTjkWV6xyedokCnNwMFdFO2exGqNkiMusL+R9cORUsOr69wJGI16irNAbr2f
         vyJ9bbnfG6Vb59illdS1J0AGRkCYZ1kUEncP+gKEWPDTMat3vug2D4YJhTb8Zoc3y9
         59poQBK24xilqLC9aNcacYHlRM+SH3KJ9BOTWaApol6GoeINnBCdVc6REv4wmF+NXJ
         IAjaYBaLbnLtOJc+6aavkqC80cuJrTnZdV/inVqiEFFIeamce4JFzsfwpPoeIgdUL4
         rWStM/77xiQCuTKSCr1yV34+OCl5GdEWbFifncHhpipwe43/FCEBqJ244XU4DSC28G
         pFRaqUc0TBR0w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] bcma: Use the proper gpio include
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221028092332.238728-1-linus.walleij@linaro.org>
References: <20221028092332.238728-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166755958214.3283.2852214897999963611.kvalo@kernel.org>
Date:   Fri,  4 Nov 2022 10:59:44 +0000 (UTC)
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> wrote:

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
> member of the BCMA GPIO struct. The whole check can be dropped
> because the bcma_gpio is initialized in the declarations:
> 
>   struct gpio_chip *bcma_gpio = &cc_drv->gpio;
> 
> And this can never be NULL.
> 
> Cc: Jonas Gorski <jonas.gorski@gmail.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied to wireless-next.git, thanks.

2b6c0e152868 bcma: Use the proper gpio include

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221028092332.238728-1-linus.walleij@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

