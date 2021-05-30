Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795CE39504A
	for <lists+linux-wireless@lfdr.de>; Sun, 30 May 2021 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhE3JdZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 May 2021 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3JdY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 May 2021 05:33:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99CC061574;
        Sun, 30 May 2021 02:31:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g17so7636800wrs.13;
        Sun, 30 May 2021 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S6ywUbCoKv7Qa4mUMuVoMlplVp1I3zMlgPnkYEpCLmY=;
        b=Wogdy63ACurBVVbx7BH1JiEb4ah6J6d4uwjpXKU8cE5tzMRm/aZaO1HrG3++XyhtEA
         hhMH9JnkQ1kgu212ewbM866x8EM1Az0XMzhPrGqLhfEgFkYbpSoWOWR0mUYRVIGThT/q
         LAspoF+Ra9CCY/y43+lVYtG3a1G1L9GhhDXHtuUFvQUqj2/ZlpT8pox3gileFzwYclYP
         nrOe9CYNkC2hxa3qoEXV9kNonJkEM5wJmuN0mx71/QQGwnAclagAvFsw1hqtsiRX1Vo9
         Wlmw8i29Mby16afyss/KFKqH1F4D5oXQ7K3KHdSNalQ4uY0XndLLjZiJ3I8NNYGzdiCv
         fPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S6ywUbCoKv7Qa4mUMuVoMlplVp1I3zMlgPnkYEpCLmY=;
        b=OH0gmztByQQTY2ez3riKa83JX3HYMe8X33Dq+rdlTNGruT+n4dL3jVY7ED7ILACtr4
         pvkYbm7W5+amMsEnYLtlHqfqUeQkiwg6hYVHoa0QuZxyH6S1rBG0Mruqo4lq4J9QGiNn
         +KpzWyic0tnqYjLMxmK/ZLrEB/qCXdXeu1+CJLrJTD+h78L5aivwzSFjV4ELWWsxuptf
         PZJv3ukWrTW9YFlWx4IkbhiROezP4oVV/BGLfuAwaM8j5jRQqQWA2rbaLESQLv7c8sIe
         NKbfd6HwVJhiYo9kbYHB5YSt1PMGNKKemxGxdq58KlM2gry9U3zqD6epSJOkAqPPA3w8
         6efg==
X-Gm-Message-State: AOAM530wF8N2QfXYel3/S91+SJLU+eGix0503GJq7xpghYdCgF4BTo+b
        yqnMX1NKnW5X3jcWme6Gx4k=
X-Google-Smtp-Source: ABdhPJzshseVi5tiuaL8iU70S0hbiWDwULizguaKWW8z9Kzs1yiWbSZsX/q0hDSu8mYVjXPCdunCVw==
X-Received: by 2002:adf:ee44:: with SMTP id w4mr16283562wro.415.1622367103824;
        Sun, 30 May 2021 02:31:43 -0700 (PDT)
Received: from debian64.daheim (p200300d5ff47fa00d63d7efffebde96e.dip0.t-ipconnect.de. [2003:d5:ff47:fa00:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id t204sm20228761wmg.38.2021.05.30.02.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 02:31:43 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.94.2)
        (envelope-from <chunkeey@gmail.com>)
        id 1lnHmY-000E98-Mw; Sun, 30 May 2021 11:31:42 +0200
Subject: Re: [PATCH v3] wireless: carl9170: fix LEDS build errors & warnings
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20210530031134.23274-1-rdunlap@infradead.org>
From:   Christian Lamparter <chunkeey@gmail.com>
Message-ID: <8043ff50-d592-7666-f001-7505efa0d4c2@gmail.com>
Date:   Sun, 30 May 2021 11:31:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210530031134.23274-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/05/2021 05:11, Randy Dunlap wrote:
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
> Fix this by making CARL9170_LEDS depend on MAC80211_LEDS, where
> the latter supplies any needed dependencies on LEDS_CLASS.

Ok, this is not what I was expecting... I though you would just
add a "depends on / imply MAC80211_LEDS" on your v2. (this was
based on the assumption of what mac80211,  ath9k/_htc and mt76
solutions of the same problem looked like).

But since (I assuming here) this patch passed the build-bots
testing with flying colors in the different config permutations.

Acked-by: Christian Lamparter <chunkeey@gmail.com>

> Fixes: 1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Christian Lamparter <chunkeey@gmail.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Christian Lamparter <chunkeey@gmail.com>
> ---
> v2: modify as suggesed by Arnd
> v3: modify as suggested by Christian
> 
>   drivers/net/wireless/ath/carl9170/Kconfig |    8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> --- linux-next-20210528.orig/drivers/net/wireless/ath/carl9170/Kconfig
> +++ linux-next-20210528/drivers/net/wireless/ath/carl9170/Kconfig
> @@ -16,13 +16,11 @@ config CARL9170
>   
>   config CARL9170_LEDS
>   	bool "SoftLED Support"
> -	depends on CARL9170
> -	select MAC80211_LEDS
> -	select LEDS_CLASS
> -	select NEW_LEDS
>   	default y
> +	depends on CARL9170
> +	depends on MAC80211_LEDS
>   	help
> -	  This option is necessary, if you want your device' LEDs to blink
> +	  This option is necessary, if you want your device's LEDs to blink.
>   
>   	  Say Y, unless you need the LEDs for firmware debugging.

