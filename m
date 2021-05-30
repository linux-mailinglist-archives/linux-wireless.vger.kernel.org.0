Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F84395150
	for <lists+linux-wireless@lfdr.de>; Sun, 30 May 2021 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE3Odu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 May 2021 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhE3Odu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 May 2021 10:33:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A889C061574;
        Sun, 30 May 2021 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=YPRb01aMhesQxdqGA6MBTiCuI6fX275v8ray7uBqpWY=; b=VhhzXpB9WnPXTvaTHWaN57FAmj
        3Ue04bB05yPgOqU1EsVg0NIDa4UjMl6b5X1LUaM3ibtaSXvst1yTaAtkE0JuxdD5//qVsOT6tle1V
        tYcVS3yQwBI3lY1FqfldIPm3dzTla284Vbyu3c5H9TloiYjqoi26C354PuIWh6jj29WPlF2N4VotK
        gRnJit/k1fj6MgGlLZL0OqXgNM1QBDwiHfT+nZY/YoMt8CtyQSUfEfElnTq+hOwXQ7bC0K4lTvWgF
        Po6uJKyukr5DfjA2GiJ9SS3zrIChHRihFe7rY2boWGEVn2qyGMqDGc03v8XH6Jxs4ZA6769cJmAry
        Xn2kxGuw==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnMU5-009ktt-Ua; Sun, 30 May 2021 14:32:10 +0000
Subject: Re: [PATCH v3] wireless: carl9170: fix LEDS build errors & warnings
To:     Christian Lamparter <chunkeey@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20210530031134.23274-1-rdunlap@infradead.org>
 <8043ff50-d592-7666-f001-7505efa0d4c2@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c49c07d5-1d6e-5b99-30b4-bc8f48b0fde3@infradead.org>
Date:   Sun, 30 May 2021 07:32:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8043ff50-d592-7666-f001-7505efa0d4c2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/30/21 2:31 AM, Christian Lamparter wrote:
> On 30/05/2021 05:11, Randy Dunlap wrote:
>> kernel test robot reports over 200 build errors and warnings
>> that are due to this Kconfig problem when CARL9170=m,
>> MAC80211=y, and LEDS_CLASS=m.
>>
>> WARNING: unmet direct dependencies detected for MAC80211_LEDS
>>    Depends on [n]: NET [=y] && WIRELESS [=y] && MAC80211 [=y] && (LEDS_CLASS [=m]=y || LEDS_CLASS [=m]=MAC80211 [=y])
>>    Selected by [m]:
>>    - CARL9170_LEDS [=y] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_ATH [=y] && CARL9170 [=m]
>>
>> CARL9170_LEDS selects MAC80211_LEDS even though its kconfig
>> dependencies are not met. This happens because 'select' does not follow
>> any Kconfig dependency chains.
>>
>> Fix this by making CARL9170_LEDS depend on MAC80211_LEDS, where
>> the latter supplies any needed dependencies on LEDS_CLASS.
> 
> Ok, this is not what I was expecting... I though you would just
> add a "depends on / imply MAC80211_LEDS" on your v2. (this was
> based on the assumption of what mac80211,  ath9k/_htc and mt76
> solutions of the same problem looked like).

Do you want the user choice/prompt removed, like MT76 is?

> But since (I assuming here) this patch passed the build-bots
> testing with flying colors in the different config permutations.

It hasn't passed any build-bots testing that I know of.
I did 8 combinations of kconfigs (well, 2 of them were invalid),
but they all passed my own build testing.

> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> 
>> Fixes: 1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Kalle Valo <kvalo@codeaurora.org>
>> Cc: Christian Lamparter <chunkeey@gmail.com>
>> Cc: linux-wireless@vger.kernel.org
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Suggested-by: Christian Lamparter <chunkeey@gmail.com>
>> ---
>> v2: modify as suggesed by Arnd
>> v3: modify as suggested by Christian
>>
>>   drivers/net/wireless/ath/carl9170/Kconfig |    8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> --- linux-next-20210528.orig/drivers/net/wireless/ath/carl9170/Kconfig
>> +++ linux-next-20210528/drivers/net/wireless/ath/carl9170/Kconfig
>> @@ -16,13 +16,11 @@ config CARL9170
>>     config CARL9170_LEDS
>>       bool "SoftLED Support"
>> -    depends on CARL9170
>> -    select MAC80211_LEDS
>> -    select LEDS_CLASS
>> -    select NEW_LEDS
>>       default y
>> +    depends on CARL9170
>> +    depends on MAC80211_LEDS
>>       help
>> -      This option is necessary, if you want your device' LEDs to blink
>> +      This option is necessary, if you want your device's LEDs to blink.
>>           Say Y, unless you need the LEDs for firmware debugging.
> 

thanks.
-- 
~Randy

