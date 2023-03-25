Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0724D6C90B9
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Mar 2023 21:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjCYUdv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Mar 2023 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYUdu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Mar 2023 16:33:50 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EE501FFC
        for <linux-wireless@vger.kernel.org>; Sat, 25 Mar 2023 13:33:48 -0700 (PDT)
Message-ID: <c7fdd08a-5ca2-6b86-d45d-97ab442438e5@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1679776425;
        bh=uZ/agqinbJAZau7QZPVOv+hry1fnu0HPfbw+bMez23Q=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=ym321KLm5X2Xyo/RTK/mQtcQy5rHaw1fT8EVauMubhzv8Grc48XgXQwyP7JKsnWa0
         CpxQWiBZzIsD/0Gkk9GWBaTHu8lDk8N6Kn0nfVAi+k4XBVclfjrPsIjRKbqQdmSVDj
         /c+AbydsoVpAnsCpUSWU/1+ZVG5J+sIX59Wto/N4=
Date:   Sat, 25 Mar 2023 21:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: iwlwifi frequent drops between v6.2-rc3 and v6.3-rc1
From:   Alexander Wetzel <alexander@wetzel-home.de>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Johannes Berg <johannes.berg@intel.com>, regressions@leemhuis.info,
        regressions@lists.linux.dev, Thomas Mann <rauchwolke@gmx.net>,
        linux-wireless@vger.kernel.org
References: <9d11ed29-1114-055d-5b26-0899a5fc0d7f@oracle.com>
 <70b7f54d-95b7-e01a-1a49-e29dc72d41b2@wetzel-home.de>
Content-Language: en-US
In-Reply-To: <70b7f54d-95b7-e01a-1a49-e29dc72d41b2@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17.03.23 16:29, Alexander Wetzel wrote:
> On 17.03.23 09:53, Vegard Nossum wrote:
>>
>> Hi,
>>
>> Somewhere between e8f60cd7db24 (v6.2-rc3) and 2eb29d59ddf0 (v6.3-rc1) my
>> wifi started dropping a lot. I'm using iwlwifi and I've checked the old
>> logs that the firmware hasn't changed:
>>
>> Feb 25 16:22:33 kernel: iwlwifi 0000:04:00.0: loaded firmware version 
>> 36.e91976c0.0 8000C-36.ucode op_mode iwlmvm
>>
>> My logs look like this:
>>
>> 09:01:50 kernel: wlp4s0: Connection to AP [REDACTED]:0b:25 lost
>> 09:01:50 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-DISCONNECTED 
>> bssid=[REDACTED]:0b:25 reason=4 locally_generated=1
>> 09:01:50 NetworkManager[8368]: <warn>  [1679040110.6548] 
>> sup-iface[0x5628f2495990,wlp4s0]: connection disconnected (reason -4)
>> 09:01:50 NetworkManager[8368]: <info>  [1679040110.6656] device 
>> (wlp4s0): supplicant interface state: completed -> disconnected
>> 09:01:50 NetworkManager[8368]: <info>  [1679040110.7609] device 
>> (wlp4s0): supplicant interface state: disconnected -> scanning
>> 09:01:53 wpa_supplicant[1279]: wlp4s0: SME: Trying to authenticate 
>> with [REDACTED]:0b:25 (SSID='[REDACTED]' freq=5500 MHz)
>> 09:01:53 kernel: wlp4s0: authenticate with [REDACTED]:0b:25
>> 09:01:53 kernel: wlp4s0: send auth to [REDACTED]:0b:25 (try 1/3)
>> 09:01:53 kernel: wlp4s0: authenticated
>> 09:01:53 wpa_supplicant[1279]: wlp4s0: Trying to associate with 
>> [REDACTED]:0b:25 (SSID='[REDACTED]' freq=5500 MHz)
>> 09:01:53 kernel: wlp4s0: associate with [REDACTED]:0b:25 (try 1/3)
>> 09:01:53 kernel: wlp4s0: RX AssocResp from [REDACTED]:0b:25 
>> (capab=0x1511 status=0 aid=36)
>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.4553] device 
>> (wlp4s0): supplicant interface state: scanning -> authenticating
>> 09:01:53 kernel: wlp4s0: associated
>> 09:01:53 wpa_supplicant[1279]: wlp4s0: Associated with [REDACTED]:0b:25
>> 09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-SUBNET-STATUS-UPDATE 
>> status=0
>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.4645] device 
>> (wlp4s0): supplicant interface state: authenticating -> associating
>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.4829] device 
>> (wlp4s0): supplicant interface state: associating -> associated
>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.5175] device 
>> (wlp4s0): supplicant interface state: associated -> 4-way handshake
>> 09:01:53 kernel: wlp4s0: Connection to AP [REDACTED]:0b:25 lost
>> 09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-DISCONNECTED 
>> bssid=[REDACTED]:0b:25 reason=4 locally_generated=1
>> 09:01:53 wpa_supplicant[1279]: wlp4s0: WPA: 4-Way Handshake failed - 
>> pre-shared key may be incorrect
>> 09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-SSID-TEMP-DISABLED 
>> id=0 ssid="[REDACTED]" auth_failures=1 duration=10 reason=WRONG_KEY
>> 09:01:53 NetworkManager[8368]: <warn>  [1679040113.5685] 
>> sup-iface[0x5628f2495990,wlp4s0]: connection disconnected (reason -4)
>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.5737] device 
>> (wlp4s0): supplicant interface state: 4-way handshake -> disconnected
>> 09:01:53 NetworkManager[8368]: <info>  [1679040113.6759] device 
>> (wlp4s0): supplicant interface state: disconnected -> scanning
>>
>> I did see that somebody else reported a similar regression, but I don't
>> know if it could be the same problem or not (I see the driver is
>> different, but the fix looks generic):
>>
>> https://linux-regtracking.leemhuis.info/regzbot/regression/217119/
>>
>> The buggy commit that was identified there does seem to be within the
>> range of potential culprits:
>>
>> $ git log --oneline e8f60cd7db24..2eb29d59ddf0 | grep resumption
>> 4444bc2116ae wifi: mac80211: Proper mark iTXQs for resumption
>>
>> If people think it's the same, I could try the proposed fix -- otherwise
>> let me know what else I can do to help track this down.
>>
> 
> You are using a iwlwilf/mvm card. The fix we plan to merge for that 
> regression above won't help you. (mvm cards do not use the function we 
> serialized in the end. iwlwifi/dvm on the other uses it.)
> 
> But Johannes is working on a comparable issue affecting mvm cards.
> Check out
> https://lore.kernel.org/r/20230314103840.30771-1-jtornosm@redhat.com
> 
> That may well fix your issue.

It's surprisingly quiet here...
Are these fixes helping? Honestly I'm not very optimistic.
I expect that this is something else...

If so, we can debug that here together.

For start, I would like to see the full logs, starting from the initial 
(working) connect.

I also would like to get a confirmation, that by booting an older kernel 
(v6.2-rc3 or older) the system gets stable again. (Not that 
wpa_supplicant or the router got an update, too.)

Alexander

