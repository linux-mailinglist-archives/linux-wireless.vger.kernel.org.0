Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2C6CC2AF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjC1Orl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjC1Orj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 10:47:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C3EDBC9
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 07:47:07 -0700 (PDT)
Message-ID: <7e1c9cd8-cb1e-197a-16b4-379647589ff4@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680014825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ggh+t/LXwa7PfJ2ycMPC3+Is1PMWaawB7rcmtKOCcFo=;
        b=GahKAmKIKf9Br3n8E1y6gUXk9mTU4BoyjQdRBilNJKwIMYYkRaZJ3CpX+uyHRKQf/wXrwM
        LJZaA1OUpSQ+MqcdGcCulAcNDYuI0pp17gZd7RRUyzcrQWby554i2x4M3W2qzCHrFAfE6G
        /eyGuHvN5K4yFWtXZd03jQBeTLOHBlBu+6YLzeYOUzastNIYrs/hCIKsucpTCcnKt9TNOJ
        yI6Le1n0hrrXLITHfDB6w+lFqnuEW7xmiwfVhEc7Xlj9yKMK38ukrj11v3oGpVw6QZvdST
        RKTrYmxE+xQQog8g73ytOTfQKY54Q/54lFCLFjx5uNokozCZNXBqxct3SAZbLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680014825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ggh+t/LXwa7PfJ2ycMPC3+Is1PMWaawB7rcmtKOCcFo=;
        b=LqbYrz0yl83lixHK9Mi+9f8YTzHUi0HwBfwG3COAMARDSUOzRzOaDlfp4/vCEHtScSOWoP
        3Eyon3uy5YkLzsBg==
Date:   Tue, 28 Mar 2023 16:47:05 +0200
MIME-Version: 1.0
Subject: Re: [RFC PATCH 13/14] wifi: rtl8xxxu: Clean up filter configuration
Content-Language: de-DE, en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-14-martin.kaistra@linutronix.de>
 <ab74ec9f73b741f7b0dd3b8a498d7e32@realtek.com>
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <ab74ec9f73b741f7b0dd3b8a498d7e32@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 27.03.23 um 04:06 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Thursday, March 23, 2023 1:19 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [RFC PATCH 13/14] wifi: rtl8xxxu: Clean up filter configuration
>>
>> In AP mode, RCR_CHECK_BSSID_MATCH should not be set. Rearrange RCR bits
>> to filter flags to match other realtek drivers and don't set
>> RCR_CHECK_BSSID_BEACON and RCR_CHECK_BSSID_MATCH in AP mode.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 82fbe778fc5ec..b6f811ad01333 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -6597,23 +6597,24 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
>>           * FIF_PLCPFAIL not supported?
>>           */
>>
>> -       if (*total_flags & FIF_BCN_PRBRESP_PROMISC)
>> -               rcr &= ~RCR_CHECK_BSSID_BEACON;
>> -       else
>> -               rcr |= RCR_CHECK_BSSID_BEACON;
>> +       if (priv->vif->type != NL80211_IFTYPE_AP) {
> 
> I think mac80211 configure filters depends on operating conditions, so it would
> be possible to avoid checking vif->type.

It should be possible to remove the vif->type check from 
FIF_BCN_PRBRESP_PROMISC check, but I would still need it to remove the 
CHECK_BSSID_MATCH bit in the AP mode case. Otherwise I seem to receive 
no data frames.


if (*total_flags & FIF_BCN_PRBRESP_PROMISC)
	rcr &= ~(RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH);
else
	rcr |= RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH;

if (priv->vif && priv->vif->type == NL80211_IFTYPE_AP)
	rcr &= ~RCR_CHECK_BSSID_MATCH;

Another way would be like in the rtw88 driver, where the BIT_CBSSID_DATA 
is not set again in the else case, but I am not sure, that is the right way.

> 
>> +               if (*total_flags & FIF_BCN_PRBRESP_PROMISC)
>> +                       rcr &= ~(RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH);
>> +               else
>> +                       rcr |= RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH;
>> +       } else {
>> +               rcr &= ~RCR_CHECK_BSSID_MATCH;
>> +       }
>>
>>          if (*total_flags & FIF_CONTROL)
>>                  rcr |= RCR_ACCEPT_CTRL_FRAME;
>>          else
>>                  rcr &= ~RCR_ACCEPT_CTRL_FRAME;
>>
>> -       if (*total_flags & FIF_OTHER_BSS) {
>> +       if (*total_flags & FIF_OTHER_BSS)
>>                  rcr |= RCR_ACCEPT_AP;
>> -               rcr &= ~RCR_CHECK_BSSID_MATCH;
>> -       } else {
>> +       else
>>                  rcr &= ~RCR_ACCEPT_AP;
>> -               rcr |= RCR_CHECK_BSSID_MATCH;
>> -       }
>>
>>          if (*total_flags & FIF_PSPOLL)
>>                  rcr |= RCR_ACCEPT_PM;
>> --
>> 2.30.2
> 

