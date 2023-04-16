Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB01A6E3827
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjDPMkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjDPMkM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:40:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F183630CA
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:40:10 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1po1fr-0006lP-E0; Sun, 16 Apr 2023 14:40:07 +0200
Message-ID: <b1d19249-d232-2088-3b90-22017ca2ddde@leemhuis.info>
Date:   Sun, 16 Apr 2023 14:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: iwlwifi frequent drops between v6.2-rc3 and v6.3-rc1
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     regressions@lists.linux.dev
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Thomas Mann <rauchwolke@gmx.net>,
        linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>,
        Vegard Nossum <vegard.nossum@oracle.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <9d11ed29-1114-055d-5b26-0899a5fc0d7f@oracle.com>
 <70b7f54d-95b7-e01a-1a49-e29dc72d41b2@wetzel-home.de>
 <c7fdd08a-5ca2-6b86-d45d-97ab442438e5@wetzel-home.de>
 <257beca4-0c9b-66a1-37ca-aa7d37a45d5d@leemhuis.info>
In-Reply-To: <257beca4-0c9b-66a1-37ca-aa7d37a45d5d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681648811;22e297a9;
X-HE-SMSGID: 1po1fr-0006lP-E0
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12.04.23 13:38, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Vegard, any news here? Is this still happening?
> 
> And out of curiosity: how often is "[wifi started] dropping a lot"
> actually? I have seen occasional disconnects with iwlwifi myself, but I
> have no idea what's causing them -- and I think it started earlier
> already (and might have started when I switched to iwd, not sure). And
> the error messages in the log only look similar in a few cases.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke

Putting this on the backburner to reduce the noise in the list of
tracked issues:

#regzbot backburner: not bisected and lack of data to debug this further
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

> On 25.03.23 21:33, Alexander Wetzel wrote:
>> On 17.03.23 16:29, Alexander Wetzel wrote:
>>> On 17.03.23 09:53, Vegard Nossum wrote:
>>>>
>>>> Hi,
>>>>
>>>> Somewhere between e8f60cd7db24 (v6.2-rc3) and 2eb29d59ddf0 (v6.3-rc1) my
>>>> wifi started dropping a lot. I'm using iwlwifi and I've checked the old
>>>> logs that the firmware hasn't changed:
>>>>
>>>> Feb 25 16:22:33 kernel: iwlwifi 0000:04:00.0: loaded firmware version
>>>> 36.e91976c0.0 8000C-36.ucode op_mode iwlmvm
>>>>
>>>> My logs look like this:
>>>>
>>>> 09:01:50 kernel: wlp4s0: Connection to AP [REDACTED]:0b:25 lost
>>>> 09:01:50 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-DISCONNECTED
>>>> bssid=[REDACTED]:0b:25 reason=4 locally_generated=1
>>>> 09:01:50 NetworkManager[8368]: <warn>  [1679040110.6548]
>>>> sup-iface[0x5628f2495990,wlp4s0]: connection disconnected (reason -4)
>>>> 09:01:50 NetworkManager[8368]: <info>  [1679040110.6656] device
>>>> (wlp4s0): supplicant interface state: completed -> disconnected
>>>> 09:01:50 NetworkManager[8368]: <info>  [1679040110.7609] device
>>>> (wlp4s0): supplicant interface state: disconnected -> scanning
>>>> 09:01:53 wpa_supplicant[1279]: wlp4s0: SME: Trying to authenticate
>>>> with [REDACTED]:0b:25 (SSID='[REDACTED]' freq=5500 MHz)
>>>> 09:01:53 kernel: wlp4s0: authenticate with [REDACTED]:0b:25
>>>> 09:01:53 kernel: wlp4s0: send auth to [REDACTED]:0b:25 (try 1/3)
>>>> 09:01:53 kernel: wlp4s0: authenticated
>>>> 09:01:53 wpa_supplicant[1279]: wlp4s0: Trying to associate with
>>>> [REDACTED]:0b:25 (SSID='[REDACTED]' freq=5500 MHz)
>>>> 09:01:53 kernel: wlp4s0: associate with [REDACTED]:0b:25 (try 1/3)
>>>> 09:01:53 kernel: wlp4s0: RX AssocResp from [REDACTED]:0b:25
>>>> (capab=0x1511 status=0 aid=36)
>>>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.4553] device
>>>> (wlp4s0): supplicant interface state: scanning -> authenticating
>>>> 09:01:53 kernel: wlp4s0: associated
>>>> 09:01:53 wpa_supplicant[1279]: wlp4s0: Associated with [REDACTED]:0b:25
>>>> 09:01:53 wpa_supplicant[1279]: wlp4s0:
>>>> CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
>>>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.4645] device
>>>> (wlp4s0): supplicant interface state: authenticating -> associating
>>>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.4829] device
>>>> (wlp4s0): supplicant interface state: associating -> associated
>>>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.5175] device
>>>> (wlp4s0): supplicant interface state: associated -> 4-way handshake
>>>> 09:01:53 kernel: wlp4s0: Connection to AP [REDACTED]:0b:25 lost
>>>> 09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-DISCONNECTED
>>>> bssid=[REDACTED]:0b:25 reason=4 locally_generated=1
>>>> 09:01:53 wpa_supplicant[1279]: wlp4s0: WPA: 4-Way Handshake failed -
>>>> pre-shared key may be incorrect
>>>> 09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-SSID-TEMP-DISABLED
>>>> id=0 ssid="[REDACTED]" auth_failures=1 duration=10 reason=WRONG_KEY
>>>> 09:01:53 NetworkManager[8368]: <warn>  [1679040113.5685]
>>>> sup-iface[0x5628f2495990,wlp4s0]: connection disconnected (reason -4)
>>>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.5737] device
>>>> (wlp4s0): supplicant interface state: 4-way handshake -> disconnected
>>>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.6759] device
>>>> (wlp4s0): supplicant interface state: disconnected -> scanning
>>>>
>>>> I did see that somebody else reported a similar regression, but I don't
>>>> know if it could be the same problem or not (I see the driver is
>>>> different, but the fix looks generic):
>>>>
>>>> https://linux-regtracking.leemhuis.info/regzbot/regression/217119/
>>>>
>>>> The buggy commit that was identified there does seem to be within the
>>>> range of potential culprits:
>>>>
>>>> $ git log --oneline e8f60cd7db24..2eb29d59ddf0 | grep resumption
>>>> 4444bc2116ae wifi: mac80211: Proper mark iTXQs for resumption
>>>>
>>>> If people think it's the same, I could try the proposed fix -- otherwise
>>>> let me know what else I can do to help track this down.
>>>>
>>>
>>> You are using a iwlwilf/mvm card. The fix we plan to merge for that
>>> regression above won't help you. (mvm cards do not use the function we
>>> serialized in the end. iwlwifi/dvm on the other uses it.)
>>>
>>> But Johannes is working on a comparable issue affecting mvm cards.
>>> Check out
>>> https://lore.kernel.org/r/20230314103840.30771-1-jtornosm@redhat.com
>>>
>>> That may well fix your issue.
>>
>> It's surprisingly quiet here...
>> Are these fixes helping? Honestly I'm not very optimistic.
>> I expect that this is something else...
>>
>> If so, we can debug that here together.
>>
>> For start, I would like to see the full logs, starting from the initial
>> (working) connect.
>>
>> I also would like to get a confirmation, that by booting an older kernel
>> (v6.2-rc3 or older) the system gets stable again. (Not that
>> wpa_supplicant or the router got an update, too.)
>>
>> Alexander
>>
>>
