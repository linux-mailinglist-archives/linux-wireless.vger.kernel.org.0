Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E185B1E0A6B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 11:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbgEYJ1m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 05:27:42 -0400
Received: from mail.as201155.net ([185.84.6.188]:30072 "EHLO mail.as201155.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389266AbgEYJ1m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 05:27:42 -0400
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:39664 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jd9OT-0002hK-0v; Mon, 25 May 2020 11:27:37 +0200
X-CTCH-RefID: str=0001.0A782F27.5ECB8F3C.0059,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=183n2q30X9kt5G1Y+EJed/eLG0YBkkzBC4KGB3jOM8E=;
        b=CpCBJMCjF0CH1RHbOed5fvJfZz5JbQs6vDFdd0ehaqdRUCA2u+P2ai4e9llzsjTejNUcloORBir7nOCARXV0gCn0F/Od3Q0TrzQGiWH1S9A1adgueSsV7cbsyOFWRv7C1eOWOT5YJSnAAOEGvIyxc5sget8tv/TRyb+h+ogMajU=;
Subject: Re: [PATCH v13] ath10k: add LED and GPIO controlling support for
 various chipsets
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        openwrt-devel@lists.openwrt.org, Kalle Valo <kvalo@codeaurora.org>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless@vger.kernel.org
References: <1523027875-5143-1-git-send-email-kvalo@codeaurora.org>
 <2468724.JaAZLprVu6@bentobox>
 <b23e65cf-4be7-72db-7955-32eae196953e@dd-wrt.com>
 <3608947.bSrYYtX6KI@bentobox>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <309af858-7e38-17fa-a1db-6b9ce8544ef5@dd-wrt.com>
Date:   Mon, 25 May 2020 11:27:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <3608947.bSrYYtX6KI@bentobox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2a01:7700:8040:4000:a1fd:236:8557:c23a]
        by webmail.newmedia-net.de with esmtpa (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jd9KM-00053m-6T; Mon, 25 May 2020 11:23:22 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 25.05.2020 um 11:22 schrieb Sven Eckelmann:
> On Wednesday, 20 May 2020 09:39:45 CEST Sebastian Gottschall wrote:
> [...]
>> could somone clarify the state here and why it was dropped?
>> the original patch i wrote does exclude the soc chipsets, but the patch
>> was later reorganized and some part have been rewritten
>> so i'm not sure if it covers the scenario mentioned here, which i did
> [...]
>>> This patch was imported to OpenWrt in commit 61d57a2f88b9 ("mac80211: ath10k
>>> add leds support") and broke the 11s support for IPQ4019 and QCA4019 (5GHz)
>>> firmware versions 10.4-3.5.3-00053, 10.4-3.5.3-00057, 10.4-3.6-00140:
> Just noticed that there was a copy and paste error in my message. The 5GHz was
> an QCA9888 [1,2] and not an QCA4019. Otherwise the _pci error wouldn't have made
> any sense.
>
> And I can only say at the moment (remember that this was observer 14 months
> ago), that it could be reproduced easily on IPQ40xx with an QCA9888 and the
> given config running OpenWrt reboot-9440-g0f89c17b57. The diffconfig (seed) of
> the installation was:
>
>      CONFIG_TARGET_ipq40xx=y
>      CONFIG_TARGET_ipq40xx_generic=y
>      CONFIG_TARGET_ipq40xx_generic_DEVICE_openmesh_a62=y
>      CONFIG_ATH10K_LEDS=y
>      CONFIG_PACKAGE_ath10k-firmware-qca4019=y
>      # CONFIG_PACKAGE_ath10k-firmware-qca4019-ct is not set
>      CONFIG_PACKAGE_ath10k-firmware-qca9888=y
>      # CONFIG_PACKAGE_ath10k-firmware-qca9888-ct is not set
>      CONFIG_PACKAGE_kmod-ath10k=y
>      # CONFIG_PACKAGE_kmod-ath10k-ct is not set
>      # CONFIG_PACKAGE_kmod-hwmon-core is not set
>
> And it still can with this OpenWrt version. But it doesn't seem to happen with
> the most recent OpenWrt reboot-13353-gb1604b744b. But there are nearly 4000
> commits inbetween. So no idea what changed (just a timing thing or an actual
> fix - no idea).
>
> Btw. the wireless config was given in the original mail [2,3]
>
> Kind regards,
> 	Sven
maybe openwrt installs a default trigger which doesnt make sense if 
nothing is connected to the cards gpio.
we can also modify the patch to exclude the 9888 from led support. you 
just need to remove the led_pin defintion from the hw definition.
this patch is mainly for wireless routers like the netgear r7800, r9000 
and some tplink archer models. it also works on mikrotik qca988x cards.
but even if the led_pin is set, it should not trigger any action until a 
led trigger is set with sysfs. such configurations should be 
architecture specific in any way

Sebastian


