Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8796ABD18
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Mar 2023 11:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCFKmB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Mar 2023 05:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCFKmA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Mar 2023 05:42:00 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ED522031;
        Mon,  6 Mar 2023 02:41:59 -0800 (PST)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 10F4F200385;
        Mon,  6 Mar 2023 11:41:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678099318;
        bh=YxoZwXxfPHJkwtwOK3O1ZHXxIHHrXn5BcsTKXsclbcU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=DGhEdtcemsd0XaJppOdYWQ2p8ksVJ1PKKr2tcQ3SLgLDiRQWgFNTty4NglLJwINog
         iuPCHcAoR4fqdyJ0D95Myb3yTSYvl23NMdqTpJKdYb7hASWmmIGc8XfKk/y9zqNawn
         xFP/NXN1rIwKb4lpGOe0HWVWAO3DXe+dyob6G11jZf7Cv1kfb/VbRak8NauAMiAvW+
         JnMtN+gDZzf0UzdsuhWQU8mvgu92sGA3gp4xTbEbWunurEYGnT3Mfg0PAAo15RveCN
         nddY+NwmjWU6QOMwiRty4nv0kn91lKCHGUM8HsZ349nvLY3A5kFQ5G0f04z+h/U5OQ
         UrAUsA2NiMT2w==
Message-ID: <6be2c348-b343-876a-a77f-a8297676de6a@free.fr>
Date:   Mon, 6 Mar 2023 11:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>
Cc:     linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
In-Reply-To: <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/03/2023 11:24, Marc Gonzalez wrote:

> OF_NAME=wifi
> OF_FULLNAME=/soc/sd@ffe03000/wifi@1
> OF_COMPATIBLE_0=brcm,bcm4329-fmac
> OF_COMPATIBLE_N=1
> SDIO_CLASS=00
> SDIO_ID=02D0:AAE7
> SDIO_REVISION=0.0
> MODALIAS=sdio:c00v02D0dAAE7
> 
> 0xaae7 = 43751
> 
> Isn't there some overlap between:
> include/linux/mmc/sdio_ids.h and
> drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h ?
> 
> Reference used: commit d2587c57ffd8dc
> "brcmfmac: add 43752 SDIO ids and initialization"
> 
> Looking at all the occurrences of 43752 to insert a 43751,
> could someone comment whether this looks reasonable?

Obviously, the commit message would have to be rewritten
for a real patch.

> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c     | 1 +
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 2 ++
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c       | 4 ++++
>  drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
>  include/linux/mmc/sdio_ids.h                                  | 1 +
>  5 files changed, 9 insertions(+)

This code (vendor upstream?) is probably relevant:
https://github.com/StreamUnlimited/broadcom-bcmdhd-4359/blob/master/include/bcmdevs.h

#define BCM4362_CHIP_ID		0x4362          /* 4362 chipcommon chipid */
#define BCM43751_CHIP_ID	0xAAE7          /* 43751 chipcommon chipid */
#define BCM43752_CHIP_ID	0xAAE8          /* 43752 chipcommon chipid */


#define BCM4362_CHIP(chipid)	((CHIPID(chipid) == BCM4362_CHIP_ID) || \
				(CHIPID(chipid) == BCM43751_CHIP_ID) || \
				(CHIPID(chipid) == BCM43752_CHIP_ID))

#define BCM4362_CHIP_GRPID	BCM4362_CHIP_ID: \
				case BCM43751_CHIP_ID: \
				case BCM43752_CHIP_ID


