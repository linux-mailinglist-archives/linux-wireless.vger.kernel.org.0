Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41AE6DBFE0
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Apr 2023 14:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDIMmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Apr 2023 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDIMl7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Apr 2023 08:41:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9F144B7
        for <linux-wireless@vger.kernel.org>; Sun,  9 Apr 2023 05:41:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jw24so18190928ejc.3
        for <linux-wireless@vger.kernel.org>; Sun, 09 Apr 2023 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681044108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+DDRK2sZcwj3lFDBSe9XMQVLnnS6EDbTcDvoDsgglY=;
        b=G9THau9+lKX5FkBC+M6W4rQQHUuRbgffs5vcqoGyY6q/53osVR44ABVXPyzYC2cn7n
         yYzTpDATQYyTlBt/3lgLgAtdwK4vYjhMsMQy97rRsYOKyvAhKA8LfzSMoauONcVgLdcZ
         t1k9qzUk8Hv9sk9fCuHklxWhlvV1BQklCP12jLy2X7+rShTMUkWh5Y7CE19r+rOh7Afe
         lzUnG3brZz1Y5hUdPAnzoVANie9jTmQZVwBzk9HWaV1WBLMlc2Ic8mOTFn5K/DcI12iY
         eQE6RZYhUAI92GJBpusGYNTVinZC8+fx+RDARayq8ljFAm/PwXxwa96ZMSmwowWx9C6J
         eO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681044108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+DDRK2sZcwj3lFDBSe9XMQVLnnS6EDbTcDvoDsgglY=;
        b=xK9pVt9RX+NtucwDKKNGYYlh71OxDGECD9tWRkaULFMK56/9SUKGH4sHNd4oJiym9i
         2DkXvzbYXAcbYcl/VZTiwUCrWIxpst5+ZfppaNSL3Uu/AbdPc/VbfjAmyXAEhwHf95vr
         SVFRbN2Xx1wD8nOog4ksYwTGXzIQrzt0OI4BdJmoDAivnDy5NxtAba0u3jRyck4r1ago
         Bin4unqX8DUaUTxyqrM5gDplNDabvQL1d32vNj571JJenifZz4n5TwZt4NqEDOLaMgGF
         An+Gw6FlYf2QBh1cEzgPDlU1TOKabS+1V03dsEdLzC1Qxcp3sUgcWowN/n124w8vhYgH
         QCrA==
X-Gm-Message-State: AAQBX9fCtRwKTWYFZsfrY+xROUT4GIujXZDct/lvqwrTDfbiqDnBTZLn
        mTtUrMTzyzo1yHjNzAL8D7A=
X-Google-Smtp-Source: AKy350YgM2YKfJPJpgH39QrBJBkoFvAfNLBA++VICa9UBAzW6P/yzAKn4lWiF8EGO7D/YHgRO9nfUg==
X-Received: by 2002:a17:906:6c93:b0:94a:5503:e919 with SMTP id s19-20020a1709066c9300b0094a5503e919mr2798562ejr.35.1681044108249;
        Sun, 09 Apr 2023 05:41:48 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id lc22-20020a170906dff600b00933c52c2a0esm4125116ejc.173.2023.04.09.05.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 05:41:47 -0700 (PDT)
Message-ID: <98be492e-71f3-f525-1d9e-fd6f0bb0200f@gmail.com>
Date:   Sun, 9 Apr 2023 15:41:46 +0300
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
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <e37633e5-5eec-5dc6-31fd-d91480b604c2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/04/2023 18:09, Martin Kaistra wrote:
> Am 06.04.23 um 02:42 schrieb Ping-Ke Shih:
>>
>>
>>> -----Original Message-----
>>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>>> Sent: Wednesday, April 5, 2023 11:31 PM
>>> To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>>> <pkshih@realtek.com>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>; linux-wireless@vger.kernel.org
>>> Subject: Re: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
>>>
>>> Am 23.03.23 um 18:12 schrieb Bitterblue Smith:
>>>> On 22/03/2023 19:18, Martin Kaistra wrote:
>>>> Then I was able to turn on the AP and connect my phone to it. However,
>>>> the system froze after a few seconds. I had `journalctl --follow`
>>>> running. The last thing printed before the system froze was the DHCP
>>>> stuff (discover, offer, request, ack). The phone said it was connected,
>>>> but speedtest.net didn't have time to load before the freeze.
>>>
>>> Hi
>>>
>>> I could reproduce a frozen system with my hostapd setup, though it
>>> doesn't happen reliably and I don't have an error message when it happens.
>>>
>>
>> Using netcat would help to capture useful messages when system gets frozen.
>>
>> Ping-Ke
>>
> 
> Thanks. I got a trace by using netconsole and netcat. It is a NULL pointer dereference in rtl8xxxu_fill_txdesc_v2():
> 
> 
>         if (rate_flags & IEEE80211_TX_RC_MCS &&
>             !ieee80211_is_mgmt(hdr->frame_control))
>                 rate = tx_info->control.rates[0].idx + DESC_RATE_MCS0;
>         else
>                 rate = tx_rate->hw_value;    <-- error happens here
> 
>         if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
>                 dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
> 
> This happens when ieee80211_get_tx_rate() hits the WARN_ON_ONCE and maybe also when c->control.rates[0].idx has another invalid value.
> See my previous comments about HAS_RATE_CONTROL.

Good job finding the problem!

ieee80211_get_tx_rate() is used since the initial commit, so only Jes
may know why. I assume we only ever need to use the rate from mac80211
for frame injection (IEEE80211_TX_CTRL_RATE_INJECT, currently ignored).

If c->control.rates[0].idx is negative, is c->control.rates[0].flags
also unusable?

ieee80211_get_rts_cts_rate() probably causes the same problem.
