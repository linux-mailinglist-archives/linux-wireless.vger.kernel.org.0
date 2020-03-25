Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC1192D6F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 16:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgCYPwJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 11:52:09 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:53376 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgCYPwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 11:52:09 -0400
Received: from [192.168.254.4] (unknown [50.34.189.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 8D74713C342;
        Wed, 25 Mar 2020 08:52:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8D74713C342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1585151528;
        bh=0aedoWyQml+RdvPqBuZm22iy6O2WCBs22INQpZBreF8=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=FduHvGBnOOU52bRJP13sHgTrfwJTh5aus6UD8+kY3J4F25/hftrfvSbLjeFFBrOj0
         aMruhbbcrtrzieVVqq977bdY2YBiLxE+4v0NmNx3AyWxSo/aI4PJ+YM4PzQ7v3AuJJ
         cwCw1l/IpaOXg7fHds4whXjRDgXv9ITxmJpxug4M=
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
To:     Brian Norris <briannorris@chromium.org>,
        Tony Chuang <yhchuang@realtek.com>
References: <20200313065114.23433-1-yhchuang@realtek.com>
 <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
 <2e492e530d744713871f885e324106ef@realtek.com>
 <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
 <ce990869ebf0478d98cd7e8416b36289@realtek.com>
 <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
 <f4e7401c-c86b-8b2f-9e93-865322f71945@candelatech.com>
 <fbab3328d183406c923b30381389841f@realtek.com>
 <d45e2002e97c28acc1f9c7b9c41b5a3ba1d69452.camel@sipsolutions.net>
 <CA+ASDXM5tSmeE72+fn5K2vgR6kPE3OUbHJ_T_DVV63rFrPzv2w@mail.gmail.com>
 <3894907ca6bf4566b8716731492a869b@realtek.com>
 <CA+ASDXMi8BqccHdVXVXb0JOj4y0vcFBGdL6BB0YuzB78qzgQuQ@mail.gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <efa8c2f3-8254-8d36-20ec-9afb8ffb2339@candelatech.com>
Date:   Wed, 25 Mar 2020 08:52:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CA+ASDXMi8BqccHdVXVXb0JOj4y0vcFBGdL6BB0YuzB78qzgQuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 03/24/2020 10:16 PM, Brian Norris wrote:
> On Tue, Mar 24, 2020 at 7:55 PM Tony Chuang <yhchuang@realtek.com> wrote:
>> Brian Norris <briannorris@chromium.org> writes:
>> We want to measure the TX power, and the equipment just cannot
>> detect the signal on some rates, unless we "fix" the rate exactly.
>
> I think we all understand this now.
>
>> So NL80211_CMD_SET_TX_BITRATE_MASK is not so useful for us
>> sometimes.
>
> I'm not sure if you have directly explained why this is the case. See
> your comment earlier:
>
> "This command just mask out some of rates that are not allowed."
>
> Sure, but if you mask out all but 1 bitrate...voila! A fixed rate!

So, see this thread from a while back.  Has anyone even *tried* to use
this API you are proposing?

http://lists.infradead.org/pipermail/ath10k/2017-October/010291.html

Here is the fix I have had in my tree for a few years to let ath10k actually
set a single rate:

[greearb@ben-dt4 linux-5.4.dev.y]$ git show cccf04cc3440ddee0760249da51026bf2532f926
commit cccf04cc3440ddee0760249da51026bf2532f926
Author: Ben Greear <greearb@candelatech.com>
Date:   Tue Oct 10 13:56:29 2017 -0700

     mac80211: Revert some of e8e4f5, fixes setting single rate in ath10k.

     This lets us successfully set a single rate in ath10k again.

     Signed-off-by: Ben Greear <greearb@candelatech.com>

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 78cf453cda2c..3f248ad70805 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2886,8 +2886,10 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
                 u32 basic_rates = sdata->vif.bss_conf.basic_rates;
                 enum nl80211_band band = sdata->vif.bss_conf.chandef.chan->band;

-               if (!(mask->control[band].legacy & basic_rates))
-                       return -EINVAL;
+               if (!(mask->control[band].legacy & basic_rates)) {
+                       pr_err("%s:  WARNING: no legacy rates for band[%d] in set-bitrate-mask.\n",
+                              sdata->dev->name, band);
+               }
         }

         if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL)) {


Thanks,
Ben

>
> And this:
>
> "But actually the firmware has its own rate
> adaptive mechanism, so mask out the other rates does not mean the rate
> left will be chosen."
>
> That's entirely your fault, not the fault of the API. If your firmware
> doesn't listen to your driver, then that's either your firmware or
> your driver's fault. If you set a mask that has exactly 1 bitrate in
> it... well, that's exactly what you should tell your firmware to do.
> Not, "use this 1 bitrate, but try something else if you feel like it."
>
> Now, there are other problems, like the others that Ben mentioned: the
> rest of the mac80211 framework doesn't like it too much if you really
> disable all but 1 rate (arguably a mac80211 bug -- but not a nl80211
> bug); or maybe you want to differentiate management frames and data
> frames (and that's not what the current
> NL80211_CMD_SET_TX_BITRATE_MASK allows for).
>
> I'm still not (personally) expecting that you *must* do this all via
> the existing CMD_SET_TX_BITRATE_MASK, but to satisfy everyone involved
> here, you at least need to be clear about why you aren't.
>
> Regards,
> Brian
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
