Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839C46BECE9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 16:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCQPaG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCQPaF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 11:30:05 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB06E515D0
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 08:29:36 -0700 (PDT)
Message-ID: <70b7f54d-95b7-e01a-1a49-e29dc72d41b2@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1679066973;
        bh=pbOJG4TMXPK/lUboOXcmUNf5x0ekE9mnhvvRSt/kgNg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OXPLAgcdx8QhvPSTzdLEkHOy8yO223VFVQCJFEyNVuAkfc7RVad68cdsvQVgOu3K/
         Bx5627uv8t/ZPLgKi45I3GjL6jyDdBY3jNfxpiLACsNO/G7YEZ2d2gjztwaegeJ8ql
         JHqKie6iczHAvzmvq/IbsrSyi0cniZqM1GFlzHw4=
Date:   Fri, 17 Mar 2023 16:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: iwlwifi frequent drops between v6.2-rc3 and v6.3-rc1
Content-Language: en-US
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Thomas Mann <rauchwolke@gmx.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>, regressions@leemhuis.info,
        regressions@lists.linux.dev
References: <9d11ed29-1114-055d-5b26-0899a5fc0d7f@oracle.com>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <9d11ed29-1114-055d-5b26-0899a5fc0d7f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17.03.23 09:53, Vegard Nossum wrote:
> 
> Hi,
> 
> Somewhere between e8f60cd7db24 (v6.2-rc3) and 2eb29d59ddf0 (v6.3-rc1) my
> wifi started dropping a lot. I'm using iwlwifi and I've checked the old
> logs that the firmware hasn't changed:
> 
> Feb 25 16:22:33 kernel: iwlwifi 0000:04:00.0: loaded firmware version 
> 36.e91976c0.0 8000C-36.ucode op_mode iwlmvm
> 
> My logs look like this:
> 
> 09:01:50 kernel: wlp4s0: Connection to AP [REDACTED]:0b:25 lost
> 09:01:50 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-DISCONNECTED 
> bssid=[REDACTED]:0b:25 reason=4 locally_generated=1
> 09:01:50 NetworkManager[8368]: <warn>  [1679040110.6548] 
> sup-iface[0x5628f2495990,wlp4s0]: connection disconnected (reason -4)
> 09:01:50 NetworkManager[8368]: <info>  [1679040110.6656] device 
> (wlp4s0): supplicant interface state: completed -> disconnected
> 09:01:50 NetworkManager[8368]: <info>  [1679040110.7609] device 
> (wlp4s0): supplicant interface state: disconnected -> scanning
> 09:01:53 wpa_supplicant[1279]: wlp4s0: SME: Trying to authenticate with 
> [REDACTED]:0b:25 (SSID='[REDACTED]' freq=5500 MHz)
> 09:01:53 kernel: wlp4s0: authenticate with [REDACTED]:0b:25
> 09:01:53 kernel: wlp4s0: send auth to [REDACTED]:0b:25 (try 1/3)
> 09:01:53 kernel: wlp4s0: authenticated
> 09:01:53 wpa_supplicant[1279]: wlp4s0: Trying to associate with 
> [REDACTED]:0b:25 (SSID='[REDACTED]' freq=5500 MHz)
> 09:01:53 kernel: wlp4s0: associate with [REDACTED]:0b:25 (try 1/3)
> 09:01:53 kernel: wlp4s0: RX AssocResp from [REDACTED]:0b:25 
> (capab=0x1511 status=0 aid=36)
> 09:01:53 NetworkManager[8368]: <info>  [1679040113.4553] device 
> (wlp4s0): supplicant interface state: scanning -> authenticating
> 09:01:53 kernel: wlp4s0: associated
> 09:01:53 wpa_supplicant[1279]: wlp4s0: Associated with [REDACTED]:0b:25
> 09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-SUBNET-STATUS-UPDATE 
> status=0
> 09:01:53 NetworkManager[8368]: <info>  [1679040113.4645] device 
> (wlp4s0): supplicant interface state: authenticating -> associating
> 09:01:53 NetworkManager[8368]: <info>  [1679040113.4829] device 
> (wlp4s0): supplicant interface state: associating -> associated
> 09:01:53 NetworkManager[8368]: <info>  [1679040113.5175] device 
> (wlp4s0): supplicant interface state: associated -> 4-way handshake
> 09:01:53 kernel: wlp4s0: Connection to AP [REDACTED]:0b:25 lost
> 09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-DISCONNECTED 
> bssid=[REDACTED]:0b:25 reason=4 locally_generated=1
> 09:01:53 wpa_supplicant[1279]: wlp4s0: WPA: 4-Way Handshake failed - 
> pre-shared key may be incorrect
> 09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-SSID-TEMP-DISABLED 
> id=0 ssid="[REDACTED]" auth_failures=1 duration=10 reason=WRONG_KEY
> 09:01:53 NetworkManager[8368]: <warn>  [1679040113.5685] 
> sup-iface[0x5628f2495990,wlp4s0]: connection disconnected (reason -4)
> 09:01:53 NetworkManager[8368]: <info>  [1679040113.5737] device 
> (wlp4s0): supplicant interface state: 4-way handshake -> disconnected
> 09:01:53 NetworkManager[8368]: <info>  [1679040113.6759] device 
> (wlp4s0): supplicant interface state: disconnected -> scanning
> 
> I did see that somebody else reported a similar regression, but I don't
> know if it could be the same problem or not (I see the driver is
> different, but the fix looks generic):
> 
> https://linux-regtracking.leemhuis.info/regzbot/regression/217119/
> 
> The buggy commit that was identified there does seem to be within the
> range of potential culprits:
> 
> $ git log --oneline e8f60cd7db24..2eb29d59ddf0 | grep resumption
> 4444bc2116ae wifi: mac80211: Proper mark iTXQs for resumption
> 
> If people think it's the same, I could try the proposed fix -- otherwise
> let me know what else I can do to help track this down.
>

You are using a iwlwilf/mvm card. The fix we plan to merge for that 
regression above won't help you. (mvm cards do not use the function we 
serialized in the end. iwlwifi/dvm on the other uses it.)

But Johannes is working on a comparable issue affecting mvm cards.
Check out
https://lore.kernel.org/r/20230314103840.30771-1-jtornosm@redhat.com

That may well fix your issue.

> I don't think bisecting this is feasible for me since there are hours
> between the drops. But it's really noticeable over the stretch of
> multiple days that something has changed -- looking at the logs, the
> disconnect rate has basically tripled.
> 
> Thanks,
> 
> 
> Vegard

