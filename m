Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4040C34B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 12:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhIOKIQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 06:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhIOKIP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 06:08:15 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95508C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 03:06:56 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4H8bV51YszzQkSX;
        Wed, 15 Sep 2021 12:06:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Subject: Re: [EXT] Re: mwifiex cmd timeout on one pci variant
To:     Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Xinming Hu <huxinming820@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>
References: <YTg/f5mHQ6jjHDt6@atmark-techno.com>
 <YThLznrMQ4EYUDEl@atmark-techno.com>
 <AM0PR04MB4529E0C28F43288E189D8F50FCD49@AM0PR04MB4529.eurprd04.prod.outlook.com>
 <YThQiMn7YHzPRwnJ@atmark-techno.com>
 <af5cff45-da9d-26b7-fd00-c4e91344cfc1@v0yd.nl>
 <YUFP3InQ+NYLpqRB@atmark-techno.com>
From:   =?UTF-8?Q?Jonas_Dre=c3=9fler?= <verdre@v0yd.nl>
Message-ID: <9337f5b5-71e4-ce35-b7ce-872fdf3d91a0@v0yd.nl>
Date:   Wed, 15 Sep 2021 12:06:46 +0200
MIME-Version: 1.0
In-Reply-To: <YUFP3InQ+NYLpqRB@atmark-techno.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04FBD183C
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/15/21 3:43 AM, Dominique MARTINET wrote:
> Hi Jonas,
> 
> Jonas Dreßler wrote on Tue, Sep 14, 2021 at 12:11:46PM +0200:
>> regarding the firmware version, as you can see in the commit updating the
>> firmware binaries (https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/mrvl/pcie8897_uapsta.bin?id=1a5773c0c89ee44cee51a285d5c7c1063cdb0891),
>> indeed the version numbering differs between the different versions of the
>> card (usb/usb, pcie/usb, pcie/uart(?)).
> 
> Right. The update frequency is also quite different, so I'm assuming the
> pcie/uart version I'm using has a lot of vulnerabilities left open as
> well...
> 
> 
>> Anyway, if you manage to find newer firmware for any of those versions, I'd
>> be happy if you could point me to that, apparently they just fixed a
>> critical vulnerability in the Windows firmware again (see https://support.microsoft.com/en-us/surface/surface-pro-5th-gen-update-history-5203144a-90c1-63df-ce0b-7ec7ff32ff10),
>> I wouldn't be surprised if our firmware is also affected by that.
> 
> That sounds like a safe bet..
> I assume the firmwares are not compatible and we can't just load these?

Yeah, they're quite similar and seem to descend from the same codebase, 
but the APIs between the kernel driver and the firmware are very different.

> 
> 
>> About the command timeout, I have no idea why the fix isn't working for you,
>> but well, my analysis of the issue is also just a (not exactly educated)
>> guess, so it might as well be a completely different problem and my fix is
>> just a lucky hack.
> 
> Right, it really depends on why the firmware crashed, but we have no way
> of investigating that at the moment.

One more thing that comes to mind after reading this discussion 
https://lore.kernel.org/linux-wireless/eb555433-ade1-e89e-30e4-f4c1c24c25e7@gmail.com/ 
is that maybe the read-back is really only serving the purpose of a 
udelay(), so if you want you can try playing around with that a bit 
instead of the read-back.

> 
>> I'd kinda hope though that my proposed patches finally wake up some people
>> at NXP and motivate them to take a look at that firmware repo again.
> 
> If it works well enough it could be a reason not to bother :D
> Alternatively if they can't spend time on it maybe open the firmware
> code (under NDA? my company probably already has one with NXP..), but
> my problem will need more time to reach them through regular channels.
> 
