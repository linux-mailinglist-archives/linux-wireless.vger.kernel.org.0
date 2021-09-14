Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E740AB75
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 12:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhINKNP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 06:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhINKNN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 06:13:13 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E99C061574
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 03:11:56 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4H7zfK0b4KzQk3L;
        Tue, 14 Sep 2021 12:11:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Subject: Re: [EXT] Re: mwifiex cmd timeout on one pci variant
To:     Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
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
From:   =?UTF-8?Q?Jonas_Dre=c3=9fler?= <verdre@v0yd.nl>
Message-ID: <af5cff45-da9d-26b7-fd00-c4e91344cfc1@v0yd.nl>
Date:   Tue, 14 Sep 2021 12:11:46 +0200
MIME-Version: 1.0
In-Reply-To: <YThQiMn7YHzPRwnJ@atmark-techno.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6765918B4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dominique,

regarding the firmware version, as you can see in the commit updating 
the firmware binaries 
(https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/mrvl/pcie8897_uapsta.bin?id=1a5773c0c89ee44cee51a285d5c7c1063cdb0891), 
indeed the version numbering differs between the different versions of 
the card (usb/usb, pcie/usb, pcie/uart(?)).

Anyway, if you manage to find newer firmware for any of those versions, 
I'd be happy if you could point me to that, apparently they just fixed a 
critical vulnerability in the Windows firmware again (see 
https://support.microsoft.com/en-us/surface/surface-pro-5th-gen-update-history-5203144a-90c1-63df-ce0b-7ec7ff32ff10), 
I wouldn't be surprised if our firmware is also affected by that.

About the command timeout, I have no idea why the fix isn't working for 
you, but well, my analysis of the issue is also just a (not exactly 
educated) guess, so it might as well be a completely different problem 
and my fix is just a lucky hack.

I'd kinda hope though that my proposed patches finally wake up some 
people at NXP and motivate them to take a look at that firmware repo again.

Jonas

On 9/8/21 7:56 AM, Dominique MARTINET wrote:
> Sharvari Harisangam wrote on Wed, Sep 08, 2021 at 05:45:53AM +0000:
>> Use firmware from https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/mrvl
>> for mwifiex driver.
> 
> Thanks, that's the first firmware I was using; it's currently at
> 16.68.1.p179 which is why I'm surprised Jonas said the latest would be
> 15.68.19.p21.
> 
> I think it's just a different variant of the driver now though,
> a binary grep matches 15.68.19.p21 for pcie8897_uapsta.bin but I my
> driver loads pcieuart8997_combo_v4.bin
> I hadn't noticed the first number didn't match, but that likely confirms
> it.
> 
> Sorry for the noise on firmware version, I'm still interested in
> understanding why the command timeouts.
> 

