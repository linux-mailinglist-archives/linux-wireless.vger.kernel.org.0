Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F162F74D4A2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGJLcc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJLca (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 07:32:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD64E3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 04:32:29 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qIp7v-0003nH-Fu; Mon, 10 Jul 2023 13:32:23 +0200
Message-ID: <809500b6-4eec-7a5e-5930-00e7eeebcc5e@leemhuis.info>
Date:   Mon, 10 Jul 2023 13:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [regression] STP on 80211s is broken in 6.4-rc4
Content-Language: en-US, de-DE
To:     Nicolas Escande <nico.escande@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>, nbd@nbd.name,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
References: <CT5GNZSK28AI.2K6M69OXM9RW5@syracuse> <ZIQbs0wqdRh7c0Kx@debian.me>
 <a9d02800-2cd6-a27b-7998-4c97cf2eb692@leemhuis.info>
 <CTDWJJDKSYYD.XBG1CAZB3A5W@syracuse>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CTDWJJDKSYYD.XBG1CAZB3A5W@syracuse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688988749;487c7bc5;
X-HE-SMSGID: 1qIp7v-0003nH-Fu
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16.06.23 09:45, Nicolas Escande wrote:
> On Thu Jun 15, 2023 at 2:54 PM CEST, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 10.06.23 08:44, Bagas Sanjaya wrote:
>>> On Tue, Jun 06, 2023 at 12:55:57PM +0200, Nicolas Escande wrote:
>>>>
>>>> As user of the mesh part of mac80211 on multiple products at work let me say
>>>> thank you for all the work you do on wifi, especially on 80211s, and especially
>>>> the recent improvements you made for mesh fast RX/TX & cross vendor AMSDU compat
>>>>
>>>> We upgraded our kernel from an older (5.15) to a newer 6.4. The problem is STP 
>>>> doesn't work anymore and alas we use it for now (for the better or worse).
>>>>
>>>> What I gathered so far from my setup:
>>>>  - we use ath9k & ath10k
>>>>  - in my case STP frames are received as regular packet and not as amsdu
>>>>  - the received packets have a wrong length of 44 in tcpdump
>>>>    (instead of 38 with our previous kernel)
>>>>  - llc_fixup_skb() tries to pull some 41 bytes out of a 35 bytes packet
>>>>    this makes llc_rcv() discard the frames & breaks STP
>>>>
>>>> >From bisecting the culprit seems to be 986e43b19ae9176093da35e0a844e65c8bf9ede7
>>>> (wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces)
>>>>
>>>> I guess that your changes to handle both ampdu subframes & normal frames in the
>>>> same datapath ends up putting a wrong skb->len for STP (multicast) frames ?
>>>> Honestly I don't understand enough of the 80211 internals & spec to pinpoint the
>>>> exact problem.
>>>>
>>>> It seems this change was already in the 6.3 kernel so I guess someone should
>>>> have seen it before (but I didn't find anything..) ? Maybe I missed something...
>>>>
>>>> Anyway I'm happy to provide more info or try anything you throw at me.
>> [...]
>> Hmmm, Felix did not reply. But let's ignore that for now.
> 
> I haven't seen mails from felix on the list for a few days, I'm guessing he's
> unavailable for now but I'll hapilly wait.

Still no progress. Hmmm. Are you still okay with that? I've seen no
other reports about this, so waiting is somewhat (albeit not completely)
fine for me if it is for you.

But in any case it might be good if you could recheck 6.5-rc1.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
