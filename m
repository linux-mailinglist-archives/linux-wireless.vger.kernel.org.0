Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480B3638FD9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 19:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKYSd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 13:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKYSd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 13:33:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEE812D29
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 10:33:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s12so7438270edd.5
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 10:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iG0epPcef7+KSTnic3Ddd3RNMo6ECgEDQNOgDmy5GYo=;
        b=aPeM1OpndZE87zmgJ/tHwN729ZZwlwvT2EqNUWwE7FOv96fy1Mkftc4B1DJmO0RkIO
         xtZ6CoGtxVYIxfvchI3vNq8/noEbMV1c/hs143pL9idQ//wl3hSvd1aAvqSR+uudnbcQ
         k4WrbS/75PCt9uzmK7mGp7/erUsbdoMzzY70ELlb74r0kWqQ9i2km9LNyw8P/oSoRvZE
         1xTJX8wSYHeSUDtEicdu1qE/hbEQZDqG5P3m/TItWPVBCQ3TUaA5HsWfdkrx67SY+xNq
         uDmvZnXmqU8TIfuchtmNl5u1NCajTCtB8miQgqeZ+43cgUx9Fyn2HBc3OU7c1aJAYGX1
         gqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iG0epPcef7+KSTnic3Ddd3RNMo6ECgEDQNOgDmy5GYo=;
        b=PPi8bFeOOYXbWIyHnNiHF+e8Xt4R8XIDRt8HCTctbVtUmvfdtwAHDHs3A7huMA0hDk
         jPA2bwwiqQXBaHtrVWUE7Wi/e4duVQrO7cZsjzu0VpEsFhcjt5Of+kNJnGHaREBSIzIw
         zsO/+3o0awsM1ce4cQKB3Eqttk8JGUxmCxfpTsjdZaNkc+sES0DxW5k/ApLR39dY/KMF
         lltXmwq08q+HiugZhnFkmRSWroCYQ7NDv6/pi8vWIalBXd1/6miFIZYsKm4V5BkQC/J+
         nQxNp0WIFkyth2xrS99tcqHs37qRU/BFQGpt6RpDWqFwy2KHnNt/ZMh5cQIgqqr6cgtg
         eKfQ==
X-Gm-Message-State: ANoB5pkRk2BWc4mU3DQdqQGiJP84neKVeZBdKwrSkeU8EkhI08TzEf2j
        NEFsUZXk3K6Zs7/TmmaKaPUPRGZGkS8=
X-Google-Smtp-Source: AA0mqf4EjzQjV5J5VFOAMQ/E3qOo2K5lNNFjyXXsxgAzb2uQOB1QiwCv97k+lgiDGczCn0uR0emCUg==
X-Received: by 2002:a05:6402:184a:b0:469:4d00:9f95 with SMTP id v10-20020a056402184a00b004694d009f95mr28190142edy.64.1669401203251;
        Fri, 25 Nov 2022 10:33:23 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709063d7100b007adf2e4c6f7sm1848302ejf.195.2022.11.25.10.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 10:33:22 -0800 (PST)
Message-ID: <7ac45dd4-8314-d81d-72d9-a6e71fd390f7@gmail.com>
Date:   Fri, 25 Nov 2022 20:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: Fix the channel width reporting
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <00489244-ba7c-797a-28f0-8788a40f7974@gmail.com>
 <5992feea33944726b62d63951f118e7e@realtek.com>
 <9837ba7eda3b4bec83e1630591bfc956@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <9837ba7eda3b4bec83e1630591bfc956@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/11/2022 10:16, Ping-Ke Shih wrote:
> 
>> -----Original Message-----
>> From: Ping-Ke Shih <pkshih@realtek.com>
>> Sent: Friday, November 25, 2022 4:05 PM
>> To: Bitterblue Smith <rtl8821cerfe2@gmail.com>; linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
>> Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: Fix the channel width reporting
>>
>>
>>
>>> -----Original Message-----
>>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>> Sent: Thursday, November 24, 2022 5:31 AM
>>> To: linux-wireless@vger.kernel.org
>>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>>> Subject: [PATCH 1/2] wifi: rtl8xxxu: Fix the channel width reporting
>>>
>>> The gen 2 chips RTL8192EU and RTL8188FU periodically send the driver
>>> reports about the TX rate, and the driver passes these reports to
>>> sta_statistics. The reports from RTL8192EU may or may not include the
>>> channel width. The reports from RTL8188FU do not include it.
>>>
>>> Only access the c2h->ra_report.bw field if the report (skb) is big
>>> enough.
>>>
>>> The other problem fixed here is that the code was actually never
>>> changing the channel width initially reported by
>>> rtl8xxxu_bss_info_changed because the value of RATE_INFO_BW_20 is 0.
>>>
>>> Fixes: 0985d3a410ac ("rtl8xxxu: Feed current txrate information for mac80211")
>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>> ---
>>>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> index 28f136064297..1c29d0bf09e2 100644
>>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> @@ -5569,7 +5569,6 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
>>>  			rarpt->txrate.flags = 0;
>>>  			rate = c2h->ra_report.rate;
>>>  			sgi = c2h->ra_report.sgi;
> 
> Additional one question about small size of report (skb).
> Is it possible you can't access .sgi and .rate too?
> 
I don't think so, because they are in the first byte of the payload.
The payload would have to be 0 bytes long, which is not very useful.
Also, the RTL8192EU and RTL8188FU drivers access the first byte
unconditionally.

>>> -			bw = c2h->ra_report.bw;
>>>
>>>  			if (rate < DESC_RATE_MCS0) {
>>>  				rarpt->txrate.legacy =
>>> @@ -5586,8 +5585,13 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
>>>  						RATE_INFO_FLAGS_SHORT_GI;
>>>  				}
>>>
>>> -				if (bw == RATE_INFO_BW_20)
>>> -					rarpt->txrate.bw |= RATE_INFO_BW_20;
>>> +				if (skb->len >= 2 + 7) {
>>
>> I think 2 is header length of C2H, and 7 is sizeof(c2h->ra_report), so we can
>> have:
>> #define RTL8XXXU_C2H_HDR_LEN 2
>>
>> Then, replace this statement with
>>
>> if (skb->len >= RTL8XXXU_C2H_HDR_LEN + sizeof(c2h->ra_report))

That sounds good.

>>
>> By the way, I found 'struct rtl8723bu_c2h' miss '__packed'.
>>

I will add it.

>> --
>> Ping-Ke
>>
>>
>> ------Please consider the environment before printing this e-mail.

