Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C4045A5C2
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 15:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbhKWOja (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 09:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbhKWOj3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 09:39:29 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4F1C061714
        for <linux-wireless@vger.kernel.org>; Tue, 23 Nov 2021 06:36:21 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mpWu8-0006aa-9y; Tue, 23 Nov 2021 15:36:16 +0100
Message-ID: <eed56f19-12a7-89fb-3d4a-573c170b8586@leemhuis.info>
Date:   Tue, 23 Nov 2021 15:36:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 5.16] mac80211: fix rate control for retransmitted frames
Content-Language: en-BS
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, aaro.koskinen@iki.fi,
        rwbugreport@lost-in-the-void.net, ryder.lee@mediatek.com
References: <20211122204323.9787-1-nbd@nbd.name>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20211122204323.9787-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637678181;f4a68fe2;
X-HE-SMSGID: 1mpWu8-0006aa-9y
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

On 22.11.21 21:43, Felix Fietkau wrote:
> Since retransmission clears info->control, rate control needs to be called
> again, otherwise the driver might crash due to invalid rates.
> 
> Cc: stable@vger.kernel.org # 5.14+
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Robert W <rwbugreport@lost-in-the-void.net>
> Fixes: 03c3911d2d67 ("mac80211: call ieee80211_tx_h_rate_ctrl() when dequeue")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

FWIW: In case you need to send an improved patch, could you please add
this before the 'Reported-by:' (see at (¹) below for the reasoning):

Link:
https://lore.kernel.org/r/20211118132556.GD334428@darkstar.musicnaut.iki.fi/
Link:
https://lore.kernel.org/r/c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net/

And if the patch is already good to go: could the subsystem maintainer
please add it when applying? See (¹) for the reasoning.

Ciao, Thorsten

(¹) Long story: The commit message would benefit from a link to the
regression report, for reasons explained in
Documentation/process/submitting-patches.rst. To quote:

```
If related discussions or any other background information behind the
change can be found on the web, add 'Link:' tags pointing to it. In case
your patch fixes a bug, for example, add a tag with a URL referencing
the report in the mailing list archives or a bug tracker;
```

This concept is old, but the text was reworked recently to make this use
case for the Link: tag clearer. For details see:
https://git.kernel.org/linus/1f57bd42b77c

Yes, that "Link:" is not really crucial; but it's good to have if
someone needs to look into the backstory of this change sometime in the
future. But I care for a different reason. I'm tracking this regression
(and others) with regzbot, my Linux kernel regression tracking bot. This
bot will notice if a patch with a Link: tag to a tracked regression gets
posted and record that, which allowed anyone looking into the regression
to quickly gasp the current status from regzbot's webui
(https://linux-regtracking.leemhuis.info/regzbot ) or its reports. The
bot will also notice if a commit with a Link: tag to a regression report
is applied by Linus and then automatically mark the regression as
resolved then.

IOW: this tag makes my life a regression tracker a lot easier, as I
otherwise have to tell regzbot manually when the fix lands. :-/


P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply. That's in everyone's interest, as
what I wrote above might be misleading to everyone reading this; any
suggestion I gave they thus might sent someone reading this down the
wrong rabbit hole, which none of us wants.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activitie wrt to this regression. Ohh, and feel free to
ignore the following lines, they are meant for regzbot:

#regzbot ignore-activity
#regzbot ^backmonitor:
https://lore.kernel.org/r/20211118132556.GD334428@darkstar.musicnaut.iki.fi/
#regzbot ^backmonitor:
https://lore.kernel.org/r/c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net/
