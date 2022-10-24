Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1A609F55
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJXKtr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 06:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJXKtn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 06:49:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17DD192AD
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 03:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32FF3611F6
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 10:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36F2C433C1;
        Mon, 24 Oct 2022 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666608579;
        bh=C+W+nafYk4z7vUOcRS04+/I3i+xv4J8FnbKyAzSq6+0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dV9UTvMKs7Mnf4qcTJM+AqWmyEAE1+kDs8pMMYIaParxrSG1suKDZU3pr8+kw9aL/
         Zck6jpV1m+7O2Gp9mLyS7M1hY8GzQ60GyT7VBiBUvjPxCkg8ZU1m4S35PnGuJz+AN0
         WDgt729BAREhEoWJ//jW8KVzmSbtdsbDNOtJXLv4769SuDWzkXVslFnM1H/STfPA7Z
         jYTbSVm6gY7qabupUcb4J08LmHplyWYdNBjIbDdbg+CTCk8HZphcDTZoMhK4xBetQr
         BHyJA401AuwQBkyhA8q9+TIuE7rdNPRKdGJRLkcDo9BR65ttBr0Orj3TqL+Vs2D5qt
         X0sYvahgjLckw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend Van Spriel <aspriel@gmail.com>
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/7] brcmfmac: add support for vendor-specific firmware api
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
        <CAJ65rDxy3ERmDAV1BYH_BCUM3_GnzotWpp7yYO6OtA_CZVgbzw@mail.gmail.com>
        <87sfmlo9yi.fsf@kernel.org>
        <4e5c9cc1-a00e-c3de-3186-6d4cf5694339@gmail.com>
        <e622b8bd-5490-5d8c-6209-c1ace0d1acf3@gmail.com>
Date:   Mon, 24 Oct 2022 13:49:11 +0300
In-Reply-To: <e622b8bd-5490-5d8c-6209-c1ace0d1acf3@gmail.com> (Arend Van
        Spriel's message of "Wed, 19 Oct 2022 13:58:38 +0200")
Message-ID: <87r0yxzec8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <aspriel@gmail.com> writes:

> On 7/29/2022 11:32 AM, Arend Van Spriel wrote:
>> On 7/28/2022 11:36 AM, Kalle Valo wrote:
>>> aspriel@gmail.com writes:
>>>
>>>> The driver is being used by multiple vendors who develop the firmware
>>>> api independently. So far the firmware api as used by the driver has
>>>> not diverged (yet). This change adds framework for supporting multiple
>>>> firmware apis. The vendor-specific support code has to provide a number
>>>> of callback operations. Right now it is only attach and detach callbacks
>>>> so no real functionality as the api is still common. This code only
>>>> adds WCC variant anyway, which is selected for all devices right now.
>>>>
>>>> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
>>>> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
>>>> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>
>>> [...]
>>>
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
>>>> @@ -8,6 +8,22 @@ config BRCMFMAC
>>>> . . . . . . .  interface support. If you choose to build a module, it'll be 
>>>> called
>>>> . . . . . . .  brcmfmac.ko.
>>>>
>>>> +config BRCMFMAC_VENDOR_MODULES
>>>> +. . .  bool "Use vendor-specific modules"
>>>> +. . .  depends on BRCMFMAC = m
>>>> +. . .  help
>>>> +. . . . .  This option will build separate modules for the vendor-specific
>>>> +. . . . .  firmware support. If not selected the vendor-specific support
>>>> +. . . . .  will be build in brcmfmac.ko.
>>>> +
>>>> +config BRCMFMAC_VENDOR_WCC
>>>> +. . .  bool "Broadcom WCC"
>>>> +. . .  default y
>>>> +. . .  depends on BRCMFMAC
>>>> +. . . . . . .  help
>>>> +. . . . . . . . .  This option will allow the driver to communicate with devices
>>>> +. . . . . . . . .  shipped by Broadcom WCC division.
>>>> +
>>>
>>> I'm not really a fan of these Kconfig options, I would rather have them
>>> always enabled. Why do we need these options, what would be the use case
>>> when user disables these?
>> 
>> I assume with "always enabled" you mean "drop these options". 

Yes, I meant dropping the options altogether.

>> Obviously I would prefer to keep them. The default will result in a
>> single module with all vendor support built-in, but this allows
>> people to trim down their configuration based on what they have. So
>> the choices are:
>> 
>> 1) single module with all vendor support built-in
>> 2) single module with partial vendor support built-in (as needed)
>> 
>>  . .  allows users to select vendor for their specific device not carrying
>>  . .  stuff they don't need. If they have a Cypress/Infineon device they
>>  . .  only need support for that.
>> 
>> 3) separate vendor support modules loaded as needed during device probe
>> 
>>  . .  build all (or some) vendor support modules and they are loaded into
>>  . .  memory only when they are needed for the device detected.
>
> I wanted to give this series another try, but the conversation above 
> never came to any conclusion/consensus. Maybe good to finish this before 
> resending?

Sorry, I was supposed to answer but it got piled up with other
unanswered emails.

So why I'm hesitant about these options is that Linus has multiple times
critised of adding unnecessary Kconfig options, and I agree with him.
Kconfig is quite a mess already and we need to be careful when adding
new options.

It's being a long time since I looked these patches so take this with
grain of salt, but is the memory savings from this really so
significant? From my point of view a faster way to get these to upstream
is to submit them without Kconfig options first. The options can be
added later if there's still strong need for them, and it's also easier
to show numbers to back it up.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
