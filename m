Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F9D6E2BDD
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 23:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDNVtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 17:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDNVtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 17:49:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF153E7F
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 14:49:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50489b16e6aso4503540a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681508960; x=1684100960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mlxse6cpmDWdjnEk2Pei778dacAoRMWQiqDarPRFbqs=;
        b=SVme9sit6RL9v6yl0TTl4HrRHTSxDNZ1MheEcEZ+xhak0PNW9q0rIgP+exqUpzayfZ
         ifSi1bMsMGhmnu/XyxPeibmmBcObaI338Z91chuBMOuOiZrPE9OcCRoGt7Mzb5GWbRG5
         awJVHV5+iNNB2Lh594nBWerdXNDuAZgS7zk/U2jJkksvAXcYf6cSojttjUFyXvGGZoTQ
         ti37Vbos7pJT5OB0Ep5sjyR4fRkuOXvf/iY0sNuiVUvsGeQ7z3dIFicJn+4cf9sPopar
         V6tAoYIxq45KRpvIFoHDNmYRp2yTDvmj4/aljiXta4xq6LuDxJn4LyPBmBY8Njc4rd5j
         45Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681508960; x=1684100960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mlxse6cpmDWdjnEk2Pei778dacAoRMWQiqDarPRFbqs=;
        b=bLhcwZE7h/i+ohL6Tx/WPB0JNDjKu2OuzQCMKg+OqTDTK6JJAKD3MOUGa2tcd0pQw9
         mtXVtFaonig3qUZ/KZ4YpYocNeocEJ+IEpheCeL+fAGNXPxB65zvbY6K1paccu3RMFbb
         LndKjcnX1wKSJMorxlpd2o2vMMSSuyckC9O5dWtny+VecbsoMgF1YXM7CXPpbsuNKhYZ
         02bVP6HBSXUzWOWJAWt3m3QUCHAR1suZu+X/xFeKBNqKlmUtM29nluvC9F3p6hWgmR19
         aAXIDZe/4G/CuKIA9FXtzw+UGXFBOgx5WGiG0LF4z1G5sorZkH4DJgboVIrm9gldsND7
         FpQg==
X-Gm-Message-State: AAQBX9d0AkqOkc+n0x9/z0wHOaCJ429zJU2XzKwpq5HIrlwHRCk4RsT4
        02jybIcik8w4oSIZICvY3E9tObe5E3Q=
X-Google-Smtp-Source: AKy350ZC2npq2OmQKnvNVNV5q0Qu/8ey1tADVN7iAK6zIPGw4XnU3jkf9VBNeVO2I0E/EqAttqyqrw==
X-Received: by 2002:a50:ed0f:0:b0:504:aeb5:89c3 with SMTP id j15-20020a50ed0f000000b00504aeb589c3mr7897749eds.5.1681508960278;
        Fri, 14 Apr 2023 14:49:20 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id t3-20020a05640203c300b004fce9ff4830sm2521732edw.88.2023.04.14.14.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 14:49:19 -0700 (PDT)
Message-ID: <8fd2b0ae-9abd-134c-058e-e67bbeb0e8b8@gmail.com>
Date:   Sat, 15 Apr 2023 00:49:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
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
 <6d5298e3-e4af-22c9-4558-fc55683f2ac2@linutronix.de>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <6d5298e3-e4af-22c9-4558-fc55683f2ac2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/04/2023 13:02, Martin Kaistra wrote:
> Am 09.04.23 um 14:41 schrieb Bitterblue Smith:
>> On 06/04/2023 18:09, Martin Kaistra wrote:
>>> Am 06.04.23 um 02:42 schrieb Ping-Ke Shih:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>>>>> Sent: Wednesday, April 5, 2023 11:31 PM
>>>>> To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>>>>> <pkshih@realtek.com>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>; linux-wireless@vger.kernel.org
>>>>> Subject: Re: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
>>>>>
>>>>> Am 23.03.23 um 18:12 schrieb Bitterblue Smith:
>>>>>> On 22/03/2023 19:18, Martin Kaistra wrote:
>>>>>> Then I was able to turn on the AP and connect my phone to it. However,
>>>>>> the system froze after a few seconds. I had `journalctl --follow`
>>>>>> running. The last thing printed before the system froze was the DHCP
>>>>>> stuff (discover, offer, request, ack). The phone said it was connected,
>>>>>> but speedtest.net didn't have time to load before the freeze.
>>>>>
>>>>> Hi
>>>>>
>>>>> I could reproduce a frozen system with my hostapd setup, though it
>>>>> doesn't happen reliably and I don't have an error message when it happens.
>>>>>
>>>>
>>>> Using netcat would help to capture useful messages when system gets frozen.
>>>>
>>>> Ping-Ke
>>>>
>>>
>>> Thanks. I got a trace by using netconsole and netcat. It is a NULL pointer dereference in rtl8xxxu_fill_txdesc_v2():
>>>
>>>
>>>          if (rate_flags & IEEE80211_TX_RC_MCS &&
>>>              !ieee80211_is_mgmt(hdr->frame_control))
>>>                  rate = tx_info->control.rates[0].idx + DESC_RATE_MCS0;
>>>          else
>>>                  rate = tx_rate->hw_value;    <-- error happens here
>>>
>>>          if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
>>>                  dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
>>>
>>> This happens when ieee80211_get_tx_rate() hits the WARN_ON_ONCE and maybe also when c->control.rates[0].idx has another invalid value.
>>> See my previous comments about HAS_RATE_CONTROL.
>>
>> Good job finding the problem!
>>
>> ieee80211_get_tx_rate() is used since the initial commit, so only Jes
>> may know why. I assume we only ever need to use the rate from mac80211
>> for frame injection (IEEE80211_TX_CTRL_RATE_INJECT, currently ignored).
>>
>> If c->control.rates[0].idx is negative, is c->control.rates[0].flags
>> also unusable?
> 
> control.rates[0].flags seems to be 0 normally in all my tests when HAS_RATE_CONTROL is enabled, and when control.rates[0].idx is negative, I see some random values which do not look like real flags.
> 
>>
>> ieee80211_get_rts_cts_rate() probably causes the same problem.
> 
> Yes, I agree.
> 
> How should proceed? I have a v2 of this patch series ready, do I need to add a patch to remove the calls to ieee80211_get_tx_rate() and just set rate in txdesc to 0 or should we handle this separately?

Adding a patch to the series sounds good to me. Remove the calls
to ieee80211_get_tx_rate() and ieee80211_get_rts_cts_rate(), remove
tx_info->control.rates[0].flags, send management and control frames
with 1M.

About ieee80211_get_rts_cts_rate(), we can go back to sending RTS
with the 24M rate, like the vendor drivers do. It's unclear why
commit a748a11038f8 ("rtl8xxxu: Obtain RTS rates from mac80211")
changed this.
