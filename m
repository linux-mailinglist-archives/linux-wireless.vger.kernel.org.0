Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214E865309F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 13:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiLUMO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 07:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLUMO0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 07:14:26 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353DC220CD;
        Wed, 21 Dec 2022 04:14:25 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m18so36346225eji.5;
        Wed, 21 Dec 2022 04:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAZPv0Vt+5frz1B6uHNIq3BKzCQcwhRuSmIZNKwA36M=;
        b=iw3vDirpPhUoDCIgjPPh3gyjFSp8Vo1WVZRdVGpc0ficOXDwOpSyYRgVNaYcKNXf71
         jgqFFiIER8IVLnjirnypZl/JdBc9pySJglI61guR2aNJ46OfcGaFgNqCL3utKRjDbiEo
         euxnSxz2XQV3hiDBW/mnCvR/pSHbvakk5RRoBQ097HziCHdung1NhnStmTGLKI9SCyy5
         GTGXN9zzZX16AhzVz1JcLJ1bi4W+FEw9ozuqzCz54yeGP4lo3q+wDuae8OPey+SR1WMS
         Jhfh6Y1nGdUVVlvR5sw+8/y9nMDD7Omo9lPlghFxS7miGBR/xb/f70Ie1UhD1W2JH7lJ
         dNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAZPv0Vt+5frz1B6uHNIq3BKzCQcwhRuSmIZNKwA36M=;
        b=k72eoOdMfZa9Unnj5eDsGVAd20O63D1ujlTVrQrt8NpQxsIqmPn0fVEFIue/8agVrd
         2RfW4U3X0ySBi2YSaOBj2RDpDw3Nj/LrojNPZGe+fBGT7MVEZOWFrxeIvdI9ZExIwXIq
         qJZtM4R7iG/+XFzJe/S+7MGLGnZAbjsvWsuQI9TTWYGqZY0CUS9I+kgJau3Z3emSx5n8
         BO7TKYPG9sfHX43E/fzivqhLYmmaKg1tk8ey4rKrP4V2i5Uf131bEszVkaz5Wr88uJiv
         LeyKeCtFKsepXs4PDl96VsKzXW7AN6wFW/DUkAInRDbBSa/7V37/powAB9nWgvpf0hV+
         4/Wg==
X-Gm-Message-State: AFqh2koCuLF2ou7NDWiYXjlpHsg7T/wH1VXBSv7LoSSfbDjh9Thg6UV7
        ly7o+10huRLGn8B5XRWtZPo=
X-Google-Smtp-Source: AMrXdXudT0UlY85eAzXGOU0R87PDATyBfegH4yXLcmdns/OhHekZwbRwJerj9jH9yqFCbg7dl0UGIA==
X-Received: by 2002:a17:907:a07c:b0:841:13b0:7238 with SMTP id ia28-20020a170907a07c00b0084113b07238mr265566ejc.25.1671624863538;
        Wed, 21 Dec 2022 04:14:23 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906971100b007c0b6e1c7fdsm7013302ejx.104.2022.12.21.04.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 04:14:23 -0800 (PST)
Message-ID: <0c92d4bf-42d0-2094-a576-ad32cdb7b531@gmail.com>
Date:   Wed, 21 Dec 2022 14:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] wifi: rtl8xxxu: fixing transmisison failure for rtl8192eu
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "JunASAKA@zzy040330.moe" <JunASAKA@zzy040330.moe>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
References: <20221217030659.12577-1-JunASAKA@zzy040330.moe>
 <3b4124ebabcb4ceaae89cd9ccf84c7de@realtek.com>
 <33b2b585-c5b1-5888-bcee-ca74ce809a44@gmail.com>
 <fb0a7d6c0897464550ed7ee75c6318c525a0f001.camel@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <fb0a7d6c0897464550ed7ee75c6318c525a0f001.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21/12/2022 03:42, Ping-Ke Shih wrote:
> On Tue, 2022-12-20 at 15:03 +0200, Bitterblue Smith wrote:
>> On 20/12/2022 07:44, Ping-Ke Shih wrote:
>>>
>>>> -----Original Message-----
>>>> From: Jun ASAKA <JunASAKA@zzy040330.moe>
>>>> Sent: Saturday, December 17, 2022 11:07 AM
>>>> To: Jes.Sorensen@gmail.com
>>>> Cc: kvalo@kernel.org; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; 
>>>> pabeni@redhat.com;
>>>> linux-wireless@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Jun
>>>> ASAKA
>>>> <JunASAKA@zzy040330.moe>
>>>> Subject: [PATCH] wifi: rtl8xxxu: fixing transmisison failure for rtl8192eu
>>>>
>>>> Fixing transmission failure which results in
>>>> "authentication with ... timed out". This can be
>>>> fixed by disable the REG_TXPAUSE.
>>>>
>>>> Signed-off-by: Jun ASAKA <JunASAKA@zzy040330.moe>
>>>> ---
>>>>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
>>>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
>>>> index a7d76693c02d..9d0ed6760cb6 100644
>>>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
>>>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
>>>> @@ -1744,6 +1744,11 @@ static void rtl8192e_enable_rf(struct rtl8xxxu_priv *priv)
>>>>  	val8 = rtl8xxxu_read8(priv, REG_PAD_CTRL1);
>>>>  	val8 &= ~BIT(0);
>>>>  	rtl8xxxu_write8(priv, REG_PAD_CTRL1, val8);
>>>> +
>>>> +	/*
>>>> +	 * Fix transmission failure of rtl8192e.
>>>> +	 */
>>>> +	rtl8xxxu_write8(priv, REG_TXPAUSE, 0x00);
>>>
>>> I trace when rtl8xxxu set REG_TXPAUSE=0xff that will stop TX.
>>> The occasions include RF calibration, LPS mode (called by power off), and
>>> going to stop. So, I think RF calibration does TX pause but not restore
>>> settings after calibration, and causes TX stuck. As the flow I traced,
>>> this patch looks reasonable. But, I wonder why other people don't meet
>>> this problem.
>>>
>> Other people have this problem too:
>> https://bugzilla.kernel.org/show_bug.cgi?id=196769
>> https://bugzilla.kernel.org/show_bug.cgi?id=216746
> 
> In the threads, you have answered my question with
> "kernel 4.8.0 works, but 4.9.? does not work."
> 
>>
>> The RF calibration does restore REG_TXPAUSE at the end. What happens is
>> when you plug in the device, something (mac80211? wpa_supplicant?) calls
>> rtl8xxxu_start(), then rtl8xxxu_stop(), then rtl8xxxu_start() again.
>> rtl8xxxu_stop() sets REG_TXPAUSE to 0xff and nothing sets it back to 0.
>>
> 
> You are correct. That is clear to me. I miss the point that RF calibration
> does backup/restore registers containing REG_TXPAUSE.
> 
> Then, I think my reviewed-by can be still applied, right?
> 
> Ping-Ke
> 
Yes.
