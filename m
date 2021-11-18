Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086734554AB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 07:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhKRGTu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 01:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbhKRGTr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 01:19:47 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1AEC061570
        for <linux-wireless@vger.kernel.org>; Wed, 17 Nov 2021 22:16:48 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mnaiz-0007WA-J0; Thu, 18 Nov 2021 07:16:45 +0100
Message-ID: <cfac5f5c-83d7-e0d9-5368-07ca041ebaed@leemhuis.info>
Date:   Thu, 18 Nov 2021 07:16:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] rt2x00: do not mark device gone on EPROTO errors during
 start
Content-Language: en-US
To:     Stanislaw Gruszka <stf_xl@wp.pl>, Exuvo <exuvo@exuvo.se>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <87czop5j33.fsf@tynnyri.adurom.net>
 <6366d9bd-9752-dbc2-8970-442bdc6e8eea@leemhuis.info>
 <7d353dd2-2ffb-6d5e-9983-f983c8b4f6da@leemhuis.info>
 <20211109073127.ga109212@wp.pl> <20211109120737.ga120005@wp.pl>
 <c81f829d-fd87-7580-fb9a-1a84958f890f@exuvo.se>
 <cc85b4e8a038417b865069c6578acf50@grupawp.pl> <87wnlgo5rp.fsf@codeaurora.org>
 <20211110080141.GA123566@wp.pl>
 <b3b9c143-485f-5fe1-312c-c64a8ce33f8a@exuvo.se>
 <20211111141003.GA134627@wp.pl>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20211111141003.GA134627@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637216208;7b594112;
X-HE-SMSGID: 1mnaiz-0007WA-J0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking. Thx for this fix.

On 11.11.21 15:10, Stanislaw Gruszka wrote:
> As reported by Exuvo is possible that we have lot's of EPROTO errors
> during device start i.e. firmware load. But after that device works
> correctly. Hence marking device gone by few EPROTO errors done by
> commit e383c70474db ("rt2x00: check number of EPROTO errors") caused
> regression - Exuvo device stop working after kernel update. To fix
> disable the check during device start.
> 
> Reported-and-tested-by: Exuvo <exuvo@exuvo.se>

FWIW: In case you need to send an improved patch, could you
please add this before the 'Reported-by:' (see at (¹) below for the
reasoning):

Link:
https://lore.kernel.org/linux-wireless/bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se/

And if the patch is already good to go: could the subsystem maintainer
please add it when applying?

> Fixes: e383c70474db ("rt2x00: check number of EPROTO errors")

What's the plan to getting this merged? Just wondering, because there
*afaics* wasn't any activity for a week now. Yes, e383c70474db was a
commit for v5.2-rc1, so it's not a new regression that needs to be
handled really urgently. But it's still a regression that would be good
to get fixed rather sooner than later, as there might be still people
out there then might run into this on a update.

Ciao, Thorsten (carrying his Linux kernel regression tracker hat)


(¹) Long story: The commit message would benefit from a link to the
regression report, for reasons explained in
Documentation/process/submitting-patches.rst. To quote:

```
If related discussions or any other background information behind the
change can be found on the web, add 'Link:' tags pointing to it. In case
your patch fixes a bug, for example, add a tag with a URL referencing
the report in the mailing list archives or a bug tracker; [...]
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

#regzbot poke

> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> index e4473a551241..74c3d8cb3100 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> @@ -25,6 +25,9 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_dev *rt2x00dev, int status)
>  	if (status == -ENODEV || status == -ENOENT)
>  		return true;
>  
> +	if (!test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags))
> +		return false;
> +
>  	if (status == -EPROTO || status == -ETIMEDOUT)
>  		rt2x00dev->num_proto_errs++;
>  	else
> 
