Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F96D9BDE
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 17:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjDFPKo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbjDFPKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 11:10:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389AD9ECD
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 08:10:00 -0700 (PDT)
Message-ID: <e37633e5-5eec-5dc6-31fd-d91480b604c2@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680793797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taoE3YV12z4keWkzaBb9BXJPAf8iIKmU2a+QjtCQIZI=;
        b=Zlu9ogO9KpqfMmDE1IKuNJ9vyTlLV8x5y4x3xlZxTCxkQHwKgiW8Svu+y2JZE6OaHkWf3C
        tBul/HQ0Pywiq+HlxO4/XW812m6p/AiN41gsJko4gK1SPsGxZ7Zsj3GAPPsHyBVAL6uzQd
        1OzEE0M8YXF/E0P05Uo/Ge3AvepbtfLt7wn4YdPpyt8y3C2k5IqG45cAFg5PlU6f4B6+hq
        gctObMqemDbTC1cBuYEzLVaJDcvB74goTLt/IponKx1FpxT0P4/qhLWaCC5FFQDjC+LYmM
        1vXAdBBrWsfTnPh7PQPOfSTrPOa4dhzNe1vJ2XevFN6mVsZ7x9dUFe5EUIQ3rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680793797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taoE3YV12z4keWkzaBb9BXJPAf8iIKmU2a+QjtCQIZI=;
        b=DRj/UaWnUxRTi9e6GzLkTpvJSMtAjV7DM07cbvGN6QBaRdQ2O21yIJIhERXUTzDd3Nnc/1
        jve11k8IXUJJq7BA==
Date:   Thu, 6 Apr 2023 17:09:57 +0200
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <bbcc03ad-3003-c26e-3b8d-d2340243c8bf@gmail.com>
 <26840cf1-9403-3d09-a4d2-352bc198efff@linutronix.de>
 <a25acad730c94845a16552f321eb2660@realtek.com>
Content-Language: de-DE
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <a25acad730c94845a16552f321eb2660@realtek.com>
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

Am 06.04.23 um 02:42 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Wednesday, April 5, 2023 11:31 PM
>> To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>; linux-wireless@vger.kernel.org
>> Subject: Re: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
>>
>> Am 23.03.23 um 18:12 schrieb Bitterblue Smith:
>>> On 22/03/2023 19:18, Martin Kaistra wrote:
>>> Then I was able to turn on the AP and connect my phone to it. However,
>>> the system froze after a few seconds. I had `journalctl --follow`
>>> running. The last thing printed before the system froze was the DHCP
>>> stuff (discover, offer, request, ack). The phone said it was connected,
>>> but speedtest.net didn't have time to load before the freeze.
>>
>> Hi
>>
>> I could reproduce a frozen system with my hostapd setup, though it
>> doesn't happen reliably and I don't have an error message when it happens.
>>
> 
> Using netcat would help to capture useful messages when system gets frozen.
> 
> Ping-Ke
> 

Thanks. I got a trace by using netconsole and netcat. It is a NULL 
pointer dereference in rtl8xxxu_fill_txdesc_v2():


         if (rate_flags & IEEE80211_TX_RC_MCS &&
             !ieee80211_is_mgmt(hdr->frame_control))
                 rate = tx_info->control.rates[0].idx + DESC_RATE_MCS0;
         else
                 rate = tx_rate->hw_value;    <-- error happens here

         if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
                 dev_info(dev, "%s: TX rate: %d, pkt size %u\n",

This happens when ieee80211_get_tx_rate() hits the WARN_ON_ONCE and 
maybe also when c->control.rates[0].idx has another invalid value.
See my previous comments about HAS_RATE_CONTROL.
