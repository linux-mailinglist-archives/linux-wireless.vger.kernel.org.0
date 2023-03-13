Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77916B7991
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCMN4F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCMN4D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:56:03 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD70767814;
        Mon, 13 Mar 2023 06:55:51 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0F5F92003EF;
        Mon, 13 Mar 2023 14:55:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678715749;
        bh=4rdaoH3eEZKr87H7nHx4rrtPi6j7OD3G/xQau6YSaVs=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Pogyvdw/s2rfbw/fF9jZk39okfiK2+55oA3No+mL60Fgc1xV/Ba/4PlS5PHCeVysR
         4d8dAL4oVp0Qe3sy7KHvEV+LFlPZ/hUY5ueyEnuTL6T0gRsCIL5vaBrvcBvemgd3kQ
         Ma82cSGimEd3fugLZFQtIDIIxtRz4M3R5vDL+ZM6NQFvUyfOV3dUWYkbPpeks45k2N
         CUBEq/ux/YeAqLIhtm1OKqeQfCWORe6s/sMJQ2epRj0qknEXdAB2fT306UHNqMUSpJ
         3On7/kUd8laG1uGO/1zVQTg/Q69XTr//0PNklutkMG3FNutU8Vmy4eYdr1tV/y1at7
         DUKDdlhrtG1Fw==
Message-ID: <3d91a067-c9c3-6d71-11a7-1289ea67f109@free.fr>
Date:   Mon, 13 Mar 2023 14:55:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Pierre-Hugues Husson <phh@phh.me>,
        linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
 <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr>
 <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
 <0450e34e-7190-104c-832a-150f15f7c825@free.fr>
In-Reply-To: <0450e34e-7190-104c-832a-150f15f7c825@free.fr>
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

On 09/03/2023 18:51, Marc Gonzalez wrote:

> On 09/03/2023 15:29, Ulf Hansson wrote:
> 
>> To narrow down the problem, I would start by preventing the WiFi
>> driver from being insmoded. To make sure it doesn't affect the SDIO
>> card detection process.
>>
>> The point is, the SDIO card should be detected properly, no matter
>> whether there is a corresponding SDIO func driver (WiFi driver)
>> available for it. For a detected SDIO/eMMC/SD card, mmc_add_card()
>> prints a message about the card in the log during initialization. It
>> could look like the below print, for example:
>>
>> "mmc2: new ultra high speed SDR104 SDIO card at address 0001".
> 
> OK, I built the WiFi driver as a module which is NOT loaded at boot time.

Still trying to bisect this heisenbug into submission... :(

So far, I've pared it down to mmc_attach_sdio()

When probe WORKS, mmc_attach_sdio() returns 0.
When probe FAILS, mmc_attach_sdio() returns ETIMEDOUT
via mmc_send_io_op_cond(host, 0, &ocr);

Wrapping mmc_send_io_op_cond() in a loop
makes it work on the second try.

Would appreciate additional guidance. Am mostly stabbing in the dark :)

Regards

