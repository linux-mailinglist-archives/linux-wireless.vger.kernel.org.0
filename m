Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA9479974
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Dec 2021 08:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhLRHj5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Dec 2021 02:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhLRHj5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Dec 2021 02:39:57 -0500
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Dec 2021 23:39:57 PST
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B7C061574
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 23:39:56 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4JGHbN3Nf5zQjg6;
        Sat, 18 Dec 2021 08:31:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1639812686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6u0ICZ1Vq3Og20K+K5O3kr4+0ZawUseX4zVdNjgfGU=;
        b=RL7x6atzXmGd8F04/B20CLYW3iKFS8VmI3WUVg10y9r6eMEqhWHd9x6spRP5E+DvLjO99B
        K7MyduLCLy6tLPNoqINZx/qSACuDv+Lln0M6+4D4ULQdHyUyKzFO3+cE4TcO0n4rEz+GvJ
        q2WhKBV1oyOJrgaEGaguT546QBSq/uiZzi5pmIAXAczJFbjJZ4JxHCJVnWovL6ABlNyJND
        T09FRXHfD8lCbof5GXbCEKfIto8JxO+aQa122hB1zbm97FaFjptG4/AAK6I7Px/TxkK1s7
        i9K4VHCE5fy4/1FKFavCFRSG3rHeyuAi7Ajtv5bZI4ZIYI4gkJTMXk8Bqiq02g==
Message-ID: <b2288492-cdbd-0310-0951-cdee77fc3a79@gorani.run>
Date:   Sat, 18 Dec 2021 16:31:17 +0900
MIME-Version: 1.0
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory rules for South
 Korea (KR)
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20210929172728.7512-1-mans0n@gorani.run>
 <20211024113821.51538-1-mans0n@gorani.run> <YXmVLUzVEgrAMLwL@ubuntu-x1>
 <4f05b6b1-084d-9046-4c63-6975c25d7615@gorani.run>
 <Yb0JAXsCnjnIQ9c9@ubuntu-x1>
From:   Sungbo Eo <mans0n@gorani.run>
In-Reply-To: <Yb0JAXsCnjnIQ9c9@ubuntu-x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-12-18 07:02, Seth Forshee wrote:
> On Sat, Oct 30, 2021 at 01:12:08AM +0900, Sungbo Eo wrote:
>> On 2021-10-28 03:06, Seth Forshee wrote:
>>> On Sun, Oct 24, 2021 at 08:38:21PM +0900, Sungbo Eo wrote:
>>>> This patch is based on MSIT Public Notification 2020-113 ("Unlicensed Radio
>>>> Equipment Established Without Notice"), officially announced on 2021-01-06.
>>>>
>>>> The PSD must not exceed 2.5 mW/MHz if the frequency range includes all or
>>>> part of 5230-5250 MHz and the bandwidth is equal to or less than 40 MHz.
>>>> This leads to the following:
>>>> * 5230-5250 @ 20 -> 17 dBm
>>>> * 5210-5250 @ 40 -> 20 dBm
>>>> Here the power limits for 80/160 MHz bandwidth are also lowered to 17 dBm,
>>>> as it's not possible to set different power limits for different bandwidths
>>>> at the moment.
>>>>
>>>> Extend the last 5 GHz frequency range to 5850 MHz.
>>>>
>>>> WiFi 6E is now allowed with the following restrictions:
>>>> * Indoor: the full 1.2 GHz range, up to 160 MHz bandwidth and 250mW EIRP
>>>> * Outdoor: the lower 500 MHz range, up to 160 MHz bandwidth and 25mW EIRP
>>>> Here only the former entry is added.
>>>>
>>>> And also update the regulatory source links.
>>>>
>>>> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
>>>> ---
>>>> v2:
>>>> * split 5150-5250 MHz band rule to accommodate the PSD limit
>>>> * remove AUTO-BW flag from 6 GHz band rule
>>>> ---
>>>>    db.txt | 17 ++++++++++++-----
>>>>    1 file changed, 12 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/db.txt b/db.txt
>>>> index 6e8dbef..387ac93 100644
>>>> --- a/db.txt
>>>> +++ b/db.txt
>>>> @@ -862,15 +862,22 @@ country KP: DFS-JP
>>>>    	(5490 - 5630 @ 20), (30), DFS
>>>>    	(5735 - 5815 @ 20), (30)
>>>> +# Source:
>>>> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196972
>>>> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196973
>>>> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196974
>>>>    country KR: DFS-JP
>>>> -	# ref: https://www.rra.go.kr
>>>>    	(2400 - 2483.5 @ 40), (23)
>>>> -	(5150 - 5250 @ 80), (23), AUTO-BW
>>>> +	(5150 - 5210 @ 40), (23), AUTO-BW
>>>> +	# max. PSD 2.5 mW/MHz in 5230-5250 MHz frequency range
>>>> +	(5210 - 5230 @ 20), (20), AUTO-BW
>>>> +	(5230 - 5250 @ 20), (17), AUTO-BW
>>>
>>> Even with 5210-5230 split out like this, 5210-5250 @ 40 still gets
>>> limited to 17 dBm by the 5230-5250 rule. So why do we need to split out
>>> 5210-5230 separate from 5150-5210?
>>
>> I did some tests with regdb and I found out that the rule to be applied
>> depends on the main 20 MHz channel. With the rules above, if I select
>> channel 48 (5230-5250) and enable VHT40, then the TX power is set to 17 dBm.
>> OTOH if I select channel 44 (5210–5230) and enable VHT40, then the TX power
>> is set to 20 dBm. I'm not sure whether my result is really correct, though.
> 
> I'm sorry, when I saw the v3 patch I realized that I forgot to reply to
> this email. I had wanted to take a look at the kernel source to try and
> understand the behavior you described.
> 
> I took a quick look, and from what I'm seeing the minimum of the power
> limits for the two ranges should be used. This is the behavior I expect.
> Can you provide more detail about how you're getting that result?
> 
> Thanks,
> Seth

I've got the result on MT7623+MT7615N AP with OpenWrt installed. (kernel 
5.10)
I set the channel and bandwidth in /etc/config/wireless (in 
OpenWrt-standard way) and checked the tx power with `iw dev wlan0 info` 
and Android WiFi Analyzer app.

# channel 48, htmode VHT40
type AP
channel 48 (5240 MHz), width: 40 MHz, center1: 5230 MHz
txpower 17.00 dBm

# channel 44, htmode VHT40
type AP
channel 44 (5220 MHz), width: 40 MHz, center1: 5230 MHz
txpower 20.00 dBm

The WiFi Analyzer app also reported higher RSSI for the channel 44 case.

I also had a quick look at net/wireless/reg.c and it seems you're right. 
Perhaps my tests were bad, I do believe your comments more than my 
result. ;)

Regards,
Sungbo
