Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E59394D8B
	for <lists+linux-wireless@lfdr.de>; Sat, 29 May 2021 19:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhE2RoI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 May 2021 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhE2RoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 May 2021 13:44:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D33C061574
        for <linux-wireless@vger.kernel.org>; Sat, 29 May 2021 10:42:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b9so9997172ejc.13
        for <linux-wireless@vger.kernel.org>; Sat, 29 May 2021 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xvqEjMMSqV6XM7fIINh/C8M92TM5MilczY1gYMbfKzk=;
        b=gqZH6Db8qVQ9yv+f18P8C5ojbCjZgjy0KuAAuoDveagZmlgOs486KVPThLRHD3OdeV
         W5285UyI0V6YJyG5zkIwt/wisK5k1kwQo7QB6i5JBUHtk5+I8dQVYMqCeGx4m6zqMe7R
         jhGkkDtTYfGUbQAwj2xbhx6xqvhpKnE1HJG+g57XOur580tn+DLHz2ivSvJ1Rq1TqFUc
         9Og644bC4Uav0eu4T/Vh80+Zr6WCXwUhK1xby82qPX26G+WQttuiq+RX1gQTjnpsewhv
         FRtbdEUQG8HqkPqPgqZ2O65Lyk9/z4XWKCj4zfQ5yZ55H/rURJTxzKJC/XnL9b7ZkenY
         aXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xvqEjMMSqV6XM7fIINh/C8M92TM5MilczY1gYMbfKzk=;
        b=rTUS5CsX7st+5zS81Qxh5DrRuO44EzxmaMEQgy1/kCAyi/nPD1QUzbPataPE2RupT2
         ND/i6eo5kfyLUYwT4X8yS5y/eMmZ0qBdMhJF4TL8eK1MwUs7GvMHYB1PCGPPpEsLTzHU
         FQmE7eu+Z28zcbT4aciY/fUO9Cv7PyU0wjXBHpy4edjfGiQpoHH1vDlmlE1A3UF0HVop
         IgQIgUjM0L7qZxRgXs1EGcWdsoLbA9gwCKVI/BLtQDs8WNKwGbc4MCuW3kWZn2XzH5I+
         tGW21XHcVqfLUA1cOf1HRIYzUejdqwwsnAKl3C7kVnU8H8WjJYe2kBgHscBycYNhbwrk
         C+gw==
X-Gm-Message-State: AOAM5311VfN/RsaONde2ca8fLVawGHesm9CJeo/w2q0OVudSczpDAtKy
        I1DXHKCMUUKXulTlkWf1GkI=
X-Google-Smtp-Source: ABdhPJygFuWsCMb70BEnjogeXDGr4eiexcGFXbkAGD6KgBwGiRvm9WZiJvtGcWnbx0hJewk2p9EqaA==
X-Received: by 2002:a17:906:7712:: with SMTP id q18mr15273436ejm.10.1622310148363;
        Sat, 29 May 2021 10:42:28 -0700 (PDT)
Received: from debian64.daheim (p200300d5ff345b00d63d7efffebde96e.dip0.t-ipconnect.de. [2003:d5:ff34:5b00:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id kj1sm593174ejc.10.2021.05.29.10.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 10:42:27 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.94.2)
        (envelope-from <chunkeey@gmail.com>)
        id 1ln2yg-000AqX-QR; Sat, 29 May 2021 19:42:26 +0200
Subject: Re: [PATCH v2] wireless: carl9170: fix LEDS build errors & warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20210529164420.11454-1-rdunlap@infradead.org>
From:   Christian Lamparter <chunkeey@gmail.com>
Message-ID: <febdec96-d30c-4af4-be2c-02c52665d448@gmail.com>
Date:   Sat, 29 May 2021 19:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210529164420.11454-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 29/05/2021 18:44, Randy Dunlap wrote:
> kernel test robot reports over 200 build errors and warnings
> that are due to this Kconfig problem when CARL9170=m,
> MAC80211=y, and LEDS_CLASS=m.
> 
> WARNING: unmet direct dependencies detected for MAC80211_LEDS
>    Depends on [n]: NET [=y] && WIRELESS [=y] && MAC80211 [=y] && (LEDS_CLASS [=m]=y || LEDS_CLASS [=m]=MAC80211 [=y])
>    Selected by [m]:
>    - CARL9170_LEDS [=y] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_ATH [=y] && CARL9170 [=m]
> 
> CARL9170_LEDS selects MAC80211_LEDS even though its kconfig
> dependencies are not met. This happens because 'select' does not follow
> any Kconfig dependency chains.
> 
> Fix this by making CARL9170_LEDS always set/enabled if certain
> conditions are met: LEDS_CLASS=y or LEDS_CLASS=CARL9170, just as
> this is done for Mediatek MT76.
> 

Hmm, that commit was really a long time ago. In fact it was part of
the initial series for that driver (from September 2010)
1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")

 From what I can tell, the "bool / tristate" of LED_CLASS flipped
from tristate (2006) to bool (2010) and back to tristate (2012).

And since MAC80211_LEDS is involved it seems that the latest change
from Arnd:
b64acb28da83 ("ath9k: fix build error with LEDS_CLASS=m")

So, the "select" stuff was present from the start, but it
hasn't been kept up to date I guess.

> Fixes: 1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: modify as suggesed by Arnd
> 
>   drivers/net/wireless/ath/carl9170/Kconfig |   12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> --- linux-next-20210528.orig/drivers/net/wireless/ath/carl9170/Kconfig
> +++ linux-next-20210528/drivers/net/wireless/ath/carl9170/Kconfig
> @@ -15,16 +15,10 @@ config CARL9170
>   	  If you choose to build a module, it'll be called carl9170.
>   
>   config CARL9170_LEDS
> -	bool "SoftLED Support"
> -	depends on CARL9170
> -	select MAC80211_LEDS
> -	select LEDS_CLASS
> -	select NEW_LEDS
> +	bool
>   	default y
> -	help
> -	  This option is necessary, if you want your device' LEDs to blink
> -
> -	  Say Y, unless you need the LEDs for firmware debugging.
> +	depends on CARL9170
> +	depends on LEDS_CLASS=y || LEDS_CLASS=CARL9170

What happens if CARL9170=M|Y, LED_CLASS=M|Y but MAC80211_LEDS=N?
(with =N, I mean of course: # CONFIG_MAC80211_LEDS is not set. )
 From what I can tell, in this case, the driver will create the LEDs
devices just fine. But since the triggers aren't available (because
they are provided by MAC80211_LEDS) these LEDs will be still called
"tx" and "assoc" but are completely "brainless"/"off".

(carl9170 sets sane default triggers for the LEDS in carl9170_led_register)
---
         err = carl9170_led_register_led(ar, 0, "tx",
                                         ieee80211_get_tx_led_name(ar->hw));
         if (err)
                 goto fail;

         if (ar->features & CARL9170_ONE_LED)
                 return 0;

         err = carl9170_led_register_led(ar, 1, "assoc",
                                         ieee80211_get_assoc_led_name(ar->hw));
---

I would have liked to keep that extra dependency to MAC80211_LEDS.
Would this work with depends/imply? Or will this break in a different way?

Cheers,
Christian
