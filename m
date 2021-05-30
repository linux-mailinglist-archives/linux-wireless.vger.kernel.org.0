Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2F7394E9A
	for <lists+linux-wireless@lfdr.de>; Sun, 30 May 2021 02:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhE3AOq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 May 2021 20:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhE3AOp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 May 2021 20:14:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E9C061574
        for <linux-wireless@vger.kernel.org>; Sat, 29 May 2021 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=G7xPkRf+65WCG4SwlbSC5DlQAgHtnEDuFnB77YvEGJU=; b=wyQTs0DXvlrOVv3L2dBPR9W3Eb
        C8+HfuUAghyf32k0UK7/Bmvj7d6b+B3ZSBO935usdVNN4rtckEXlcdaGfNpgxxa5HMl5niKjM4VUc
        +oNGCVNWKOCCXAm2G9pnVmbw6jDg+ed/TvNUu8kqsxuvwSEU4HzgC8UuMbBpoR/jMADLtHaVpG82+
        4vPhv6aZoPw/V5dxc1FKSG6KKSNs9rBpFwTI7AHpaoZo4BOSr1mYzK0zwBuZMGDqOm9eOmjMglfTp
        kK7WzUDXfGJhc469iKNIMhcV+3hq3DTZWyhwpvZE/f93l2Bu/EA4eMZhmvYR0OXhbDQ+yKpTCCmY8
        +AIUEQWQ==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ln94l-008eGA-Ak; Sun, 30 May 2021 00:13:07 +0000
Subject: Re: [PATCH v2] wireless: carl9170: fix LEDS build errors & warnings
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20210529164420.11454-1-rdunlap@infradead.org>
 <febdec96-d30c-4af4-be2c-02c52665d448@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <efbc453e-78ac-f9f6-efe4-dc6a6daddda9@infradead.org>
Date:   Sat, 29 May 2021 17:13:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <febdec96-d30c-4af4-be2c-02c52665d448@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Christian,

On 5/29/21 10:42 AM, Christian Lamparter wrote:
> On 29/05/2021 18:44, Randy Dunlap wrote:
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
>> Fix this by making CARL9170_LEDS always set/enabled if certain
>> conditions are met: LEDS_CLASS=y or LEDS_CLASS=CARL9170, just as
>> this is done for Mediatek MT76.
>>
> 
> Hmm, that commit was really a long time ago. In fact it was part of
> the initial series for that driver (from September 2010)
> 1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")
> 
> From what I can tell, the "bool / tristate" of LED_CLASS flipped
> from tristate (2006) to bool (2010) and back to tristate (2012).
> 
> And since MAC80211_LEDS is involved it seems that the latest change
> from Arnd:
> b64acb28da83 ("ath9k: fix build error with LEDS_CLASS=m")
> 
> So, the "select" stuff was present from the start, but it
> hasn't been kept up to date I guess.
> 
>> Fixes: 1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Kalle Valo <kvalo@codeaurora.org>
>> Cc: Christian Lamparter <chunkeey@googlemail.com>
>> Cc: linux-wireless@vger.kernel.org
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> v2: modify as suggesed by Arnd
>>
>>   drivers/net/wireless/ath/carl9170/Kconfig |   12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> --- linux-next-20210528.orig/drivers/net/wireless/ath/carl9170/Kconfig
>> +++ linux-next-20210528/drivers/net/wireless/ath/carl9170/Kconfig
>> @@ -15,16 +15,10 @@ config CARL9170
>>         If you choose to build a module, it'll be called carl9170.
>>     config CARL9170_LEDS
>> -    bool "SoftLED Support"
>> -    depends on CARL9170
>> -    select MAC80211_LEDS
>> -    select LEDS_CLASS
>> -    select NEW_LEDS
>> +    bool
>>       default y
>> -    help
>> -      This option is necessary, if you want your device' LEDs to blink
>> -
>> -      Say Y, unless you need the LEDs for firmware debugging.
>> +    depends on CARL9170
>> +    depends on LEDS_CLASS=y || LEDS_CLASS=CARL9170
> 
> What happens if CARL9170=M|Y, LED_CLASS=M|Y but MAC80211_LEDS=N?
> (with =N, I mean of course: # CONFIG_MAC80211_LEDS is not set. )
> From what I can tell, in this case, the driver will create the LEDs
> devices just fine. But since the triggers aren't available (because
> they are provided by MAC80211_LEDS) these LEDs will be still called
> "tx" and "assoc" but are completely "brainless"/"off".
> 
> (carl9170 sets sane default triggers for the LEDS in carl9170_led_register)
> ---
>        err = carl9170_led_register_led(ar, 0, "tx",
>                                        ieee80211_get_tx_led_name(ar->hw));
>        if (err)
>                goto fail;
> 
>        if (ar->features & CARL9170_ONE_LED)
>                return 0;
> 
>        err = carl9170_led_register_led(ar, 1, "assoc",
>                                        ieee80211_get_assoc_led_name(ar->hw));
> ---
> 
> I would have liked to keep that extra dependency to MAC80211_LEDS.
> Would this work with depends/imply? Or will this break in a different way?

I like that idea.  I've give it a whirl of testing...

thanks.
-- 
~Randy

