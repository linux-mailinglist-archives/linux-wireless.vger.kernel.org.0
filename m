Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4C46E313
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 08:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhLIHXp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 02:23:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45700 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhLIHXo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 02:23:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEF9DB823C2
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 07:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0141C004DD;
        Thu,  9 Dec 2021 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639034409;
        bh=akpGOJR1KdtmiSD/C2I1NPdeDmGcVtGewL8lxJAgHbM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fxdRs2jXbuXF5hM8my0h/u27ZOW0w9QwCfHi6fjI7DLyRdfe1oIejamcC/JIo3Q28
         e7oY4b/N/Sg0p0ivzF/Vhzfb53ESKg+COVV81bGfR/iry8t9Z4Sv0XKZxcZDgC9PTS
         WLbuHvqqDMZDgHsUURrnkxY4dfG66soR2OuqWuX39Jzrj18qLNU7UTUDfe9VQHB46A
         tlPN/dAE5oXsvDBOEMf0Cc7TSxdyWMD9YfkpimfKcwRO96LCMNlaGQIh1FLyxm1VLl
         oKxO2xrG9+SvjAir7B61G8Y5BrIo5AzcxCBMBeFHOhmLyJeqL08pcagIq1hY+KeLDB
         Exuq4pDf8VFrw==
From:   Kalle Valo <kvalo@kernel.org>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: RFC: wilc1000 module parameter to disable chip sleep
References: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
Date:   Thu, 09 Dec 2021 09:20:06 +0200
In-Reply-To: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
        (David Mosberger-Tang's message of "Wed, 08 Dec 2021 11:50:00 -0700")
Message-ID: <87bl1qnt21.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Mosberger-Tang <davidm@egauge.net> writes:

> At least on our SAMA5-based platform, the chip-sleep in the wilc1000
> driver degrades WILC1000 transmit throughput by more than three times,
> without providing significant power-savings.  Because of that, I have
> been considering adding a module parameter that would make the chip
> sleep optional.  Something along these lines:
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
> index 757bd4471fd4..421672488100 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> @@ -10,6 +10,12 @@
>  #include "cfg80211.h"
>  #include "wlan_cfg.h"
>  
> +static bool enable_sleep;
> +module_param(enable_sleep, bool, 0644);
> +MODULE_PARM_DESC(enable_sleep,
> +		 "Enable chip sleep whenever the host is done communicating\n"
> +		 "\t\t\twith the WILC1000 chip.");
> +
>  static inline bool is_wilc1000(u32 id)
>  {
>  	return (id & (~WILC_CHIP_REV_FIELD)) == WILC_1000_BASE_ID;
> @@ -18,13 +24,13 @@ static inline bool is_wilc1000(u32 id)
>  static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
>  {
>  	mutex_lock(&wilc->hif_cs);
> -	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP)
> +	if (enable_sleep && acquire == WILC_BUS_ACQUIRE_AND_WAKEUP)
>  		chip_wakeup(wilc);
>  }
>  
>  static inline void release_bus(struct wilc *wilc, enum bus_release release)
>  {
> -	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP)
> +	if (enable_sleep && release == WILC_BUS_RELEASE_ALLOW_SLEEP)
>  		chip_allow_sleep(wilc);
>  	mutex_unlock(&wilc->hif_cs);
>  }
>
> However, based on the numbers below, I'm now wondering if it wouldn't
> make more sense to remove the chip-sleep code altogether.
>
> Here is what I see: on a system configured for minimum power consumption
> (all unnecessary daemons disabled, Ethernet unplugged) I measured 1,180 mW
> when the WILC chip is in RESET (the ENABLE pin is always high on our platform).
>
> With the wilc1000-spi/wilc1000 modules loaded and the WILC chip
> running but without being associated with a WLAN network, measured
> power consumption was 1,460 mW, regardless of whether chip sleep was
> enabled or disabled.
>
> On the other hand, chip-sleep makes a huge difference for TX
> throughput and also reduces RX throughput, but to a smaller
> extent.  Specifically, I used ttcp to measure throughput on the
> test system 5 times in a row, both in TX and RX direction
> (TX meaning "ttcp -t" is run from the test system to a desktop
> machine):
>
> TX throughput ("./ttcp -t DESKTOPIPADDR" on the DUT):
> enable_sleep=1: 16777216 bytes in 41.22 real seconds = 397.50 KB/sec +++
> enable_sleep=1: 16777216 bytes in 40.67 real seconds = 402.81 KB/sec +++
> enable_sleep=1: 16777216 bytes in 41.08 real seconds = 398.83 KB/sec +++
> enable_sleep=1: 16777216 bytes in 41.35 real seconds = 396.25 KB/sec +++
>
> enable_sleep=0: 16777216 bytes in 11.12 real seconds = 1472.78 KB/sec +++
> enable_sleep=0: 16777216 bytes in 10.76 real seconds = 1523.10 KB/sec +++
> enable_sleep=0: 16777216 bytes in 11.83 real seconds = 1385.21 KB/sec +++
> enable_sleep=0: 16777216 bytes in 10.94 real seconds = 1497.66 KB/sec +++
> enable_sleep=0: 16777216 bytes in 10.13 real seconds = 1617.21 KB/sec +++
>
> RX throughput ("./ttcp -r" on the DUT):
>
> enable_sleep=1: 16777216 bytes in 8.44 real seconds = 1941.97 KB/sec +++
> enable_sleep=1: wilc1000, w/ sleep: 16777216 bytes in 12.69 real seconds = 1290.94 KB/sec +++
> enable_sleep=1: 16777216 bytes in 12.79 real seconds = 1280.93 KB/sec +++
> enable_sleep=1: 16777216 bytes in 12.39 real seconds = 1322.33 KB/sec +++
>
> enable_sleep=0: 16777216 bytes in 5.83 real seconds = 2811.94 KB/sec +++
> enable_sleep=0: 16777216 bytes in 5.75 real seconds = 2848.09 KB/sec +++
> enable_sleep=0: 16777216 bytes in 5.97 real seconds = 2744.44 KB/sec +++
> enable_sleep=0: 16777216 bytes in 6.11 real seconds = 2681.96 KB/sec +++
> enable_sleep=0: 16777216 bytes in 6.01 real seconds = 2724.09 KB/sec +++
>
>>From what I can tell, the chip-sleep code either isn't working or the chip
> sleep just isn't making any real difference in power consumption.
>
> Given this, is there any reason to keep the chip-sleep code around?

If it doesn't work I would just remove it to keep things simple. It can
always added back if somebody fixes it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
