Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7EC6DF173
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 12:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDLKCj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDLKCh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 06:02:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4595372A3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 03:02:23 -0700 (PDT)
Message-ID: <6d5298e3-e4af-22c9-4558-fc55683f2ac2@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681293741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AT/+TeflV0CUYVPJA25hlE4wXZCvAoAyDeBgUoX72Yg=;
        b=aGlLIlwyzgiVHV4Z6BiAkXIZiKIHwcFp9/WF6n8XnYsZfhVlFULsgjwjwgJJSQ2kdomiox
        uc96I6+w69Z+Y7RTIr4/DnGngfGhk588x/bCmxYK9EU3yc2RwuiazMx4YhY5qyvgGbDv4y
        UWZaVvp9jc4n8+C+T+K1hG5eNBNzz852+DVpsVuWiSdaINSq8vY8TX+TFWqt3B4SxQGezs
        SeBtNBm2xB2GCx8ppnY2LKplzw/J7byfwMn+gDOMyKwse6H2vkBQl2LOJkODGHSxjl3C7T
        BtuoXM/keo1Cr8H+O55zuRD6a4f+d7mXw703in2i8n/UkolFO7PzqZ7glnyB9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681293741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AT/+TeflV0CUYVPJA25hlE4wXZCvAoAyDeBgUoX72Yg=;
        b=gyWX1W17q657VVQM26f78oE0YOAG8ZkIQgDeBG5gzoY6dXpAVJt3Xzyz7bhXfcCiSUgjHB
        4CX1LE99s7ICBxBw==
Date:   Wed, 12 Apr 2023 12:02:21 +0200
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
Content-Language: de-DE
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <bbcc03ad-3003-c26e-3b8d-d2340243c8bf@gmail.com>
 <26840cf1-9403-3d09-a4d2-352bc198efff@linutronix.de>
 <a25acad730c94845a16552f321eb2660@realtek.com>
 <e37633e5-5eec-5dc6-31fd-d91480b604c2@linutronix.de>
 <98be492e-71f3-f525-1d9e-fd6f0bb0200f@gmail.com>
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <98be492e-71f3-f525-1d9e-fd6f0bb0200f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 09.04.23 um 14:41 schrieb Bitterblue Smith:
> On 06/04/2023 18:09, Martin Kaistra wrote:
>> Am 06.04.23 um 02:42 schrieb Ping-Ke Shih:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>>>> Sent: Wednesday, April 5, 2023 11:31 PM
>>>> To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>>>> <pkshih@realtek.com>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>; linux-wireless@vger.kernel.org
>>>> Subject: Re: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
>>>>
>>>> Am 23.03.23 um 18:12 schrieb Bitterblue Smith:
>>>>> On 22/03/2023 19:18, Martin Kaistra wrote:
>>>>> Then I was able to turn on the AP and connect my phone to it. However,
>>>>> the system froze after a few seconds. I had `journalctl --follow`
>>>>> running. The last thing printed before the system froze was the DHCP
>>>>> stuff (discover, offer, request, ack). The phone said it was connected,
>>>>> but speedtest.net didn't have time to load before the freeze.
>>>>
>>>> Hi
>>>>
>>>> I could reproduce a frozen system with my hostapd setup, though it
>>>> doesn't happen reliably and I don't have an error message when it happens.
>>>>
>>>
>>> Using netcat would help to capture useful messages when system gets frozen.
>>>
>>> Ping-Ke
>>>
>>
>> Thanks. I got a trace by using netconsole and netcat. It is a NULL pointer dereference in rtl8xxxu_fill_txdesc_v2():
>>
>>
>>          if (rate_flags & IEEE80211_TX_RC_MCS &&
>>              !ieee80211_is_mgmt(hdr->frame_control))
>>                  rate = tx_info->control.rates[0].idx + DESC_RATE_MCS0;
>>          else
>>                  rate = tx_rate->hw_value;    <-- error happens here
>>
>>          if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
>>                  dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
>>
>> This happens when ieee80211_get_tx_rate() hits the WARN_ON_ONCE and maybe also when c->control.rates[0].idx has another invalid value.
>> See my previous comments about HAS_RATE_CONTROL.
> 
> Good job finding the problem!
> 
> ieee80211_get_tx_rate() is used since the initial commit, so only Jes
> may know why. I assume we only ever need to use the rate from mac80211
> for frame injection (IEEE80211_TX_CTRL_RATE_INJECT, currently ignored).
> 
> If c->control.rates[0].idx is negative, is c->control.rates[0].flags
> also unusable?

control.rates[0].flags seems to be 0 normally in all my tests when 
HAS_RATE_CONTROL is enabled, and when control.rates[0].idx is negative, 
I see some random values which do not look like real flags.

> 
> ieee80211_get_rts_cts_rate() probably causes the same problem.

Yes, I agree.

How should proceed? I have a v2 of this patch series ready, do I need to 
add a patch to remove the calls to ieee80211_get_tx_rate() and just set 
rate in txdesc to 0 or should we handle this separately?
