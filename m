Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64306DC049
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Apr 2023 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjDIOKs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Apr 2023 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjDIOKq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Apr 2023 10:10:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419D040F3
        for <linux-wireless@vger.kernel.org>; Sun,  9 Apr 2023 07:10:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id gw13so1626268wmb.3
        for <linux-wireless@vger.kernel.org>; Sun, 09 Apr 2023 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681049436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMkoDGzFBMqLBLtmZMSvxcJNa+mnCxcNqzDW4ENsqtc=;
        b=kUPJBYdk4T4lcXf4Mq+7EGDFXGt3l2natDgYHnzwMIdqtUXV8uyE7k0irZ4J/b2q2m
         sebxTZsYRWcfDPgwLmi5f5QCUNTTtKasv4BF6flux9xv4sy++Rzu5D93SyGBzDqcKOMr
         d1TukHhsnY2wBLR3poTp140QsUNNjrJDXyK97Lr0FNouQ3b3PF1zl1Z41kPDdRbUidqy
         8wNF5O575uhf0St44lt9xdx3LySha/QyTergkEwnmG7PffUXYNzSEIt81l8EaQTv6z+x
         OgAYr+GGMZm7cLnJgikBubSjUa7LRJJJANFTo60Yo4TSd2UM85oW55eBFDEmaWu/BGl7
         HC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681049436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMkoDGzFBMqLBLtmZMSvxcJNa+mnCxcNqzDW4ENsqtc=;
        b=Loav1R2sARd7pEhDorzmjglHXUOlTXbHspH3SR/66oCm9HU55HKMeCAErSdlTM8EJF
         GyBrGnsgzePTHVYDsPRVQxYl0lMIxivFBWWzXrG5Eh8S8O8zaRikbbPheUoVScfeM4cE
         5edHm/9NHpOHqM19pUnmsrD78twQbiZtrRbV+1tMmVkfqkADH4sa7RNs698fp4AOa8iS
         DSSOUgY9PvSRQvHDEVMWy9i8KpSWC2v6uuVb6TE8Z92LdPD9pNTERZfh/wTaQQ8FXffR
         nKv8SGE9tnvMYu/pLen3HK/E7ioYlYcVmbLw/M00plW/1Jc7Ouwk6x61LAGNZoGpg8BJ
         Mwsw==
X-Gm-Message-State: AAQBX9cIwflOeZXGggvU+b5vJMqMKAjOkUOfkGnWeQ/nF+f0l5g91Skf
        49FClFdccXUAx4Fk3hxis8E=
X-Google-Smtp-Source: AKy350ab9aFqLA5jkJ8mj8m10gzuBeo29qASUIjrdPTjCsCzS2THBUDrUmaJhcMB6hJc/hoG/z4/3w==
X-Received: by 2002:a1c:770d:0:b0:3d0:6a57:66a5 with SMTP id t13-20020a1c770d000000b003d06a5766a5mr5582725wmi.0.1681049435575;
        Sun, 09 Apr 2023 07:10:35 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id iv15-20020a05600c548f00b003ef5b285f65sm14661025wmb.46.2023.04.09.07.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 07:10:35 -0700 (PDT)
Message-ID: <541f26bb-5022-2c2d-200a-68dc2c6fb5fe@gmail.com>
Date:   Sun, 9 Apr 2023 17:10:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: Clean up some messy ifs
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <eb152b5b-fe65-3783-a3d9-71c9cb7ef9d3@gmail.com>
 <04d4ca3e27924ea6b2ad6e5b00ddb424@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <04d4ca3e27924ea6b2ad6e5b00ddb424@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/04/2023 04:16, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Saturday, April 1, 2023 4:17 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH 1/2] wifi: rtl8xxxu: Clean up some messy ifs
>>
>> Add some new members to rtl8xxxu_fileops and use them instead of
>> checking priv->rtl_chip.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index c152b228606f..62dd53a57659 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -1916,7 +1916,7 @@ static int rtl8xxxu_start_firmware(struct rtl8xxxu_priv *priv)
>>         /*
>>          * Init H2C command
>>          */
>> -       if (priv->rtl_chip == RTL8723B || priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8710B)
>> +       if (priv->fops->init_reg_hmtfr)
>>                 rtl8xxxu_write8(priv, REG_HMTFR, 0x0f);
>>  exit:
>>         return ret;
>> @@ -3864,11 +3864,8 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
>>         rtl8xxxu_write8(priv, REG_HT_SINGLE_AMPDU_8723B, val8);
>>
>>         rtl8xxxu_write16(priv, REG_MAX_AGGR_NUM, 0x0c14);
>> -       if (priv->rtl_chip == RTL8723B || priv->rtl_chip == RTL8710B)
>> -               val8 = 0x5e;
>> -       else if (priv->rtl_chip == RTL8188F)
>> -               val8 = 0x70; /* 0x5e would make it very slow */
>> -       rtl8xxxu_write8(priv, REG_AMPDU_MAX_TIME_8723B, val8);
>> +       rtl8xxxu_write8(priv, REG_AMPDU_MAX_TIME_8723B,
>> +                       priv->fops->ampdu_max_time);
> 
> Should it be 
> 
> if (priv->fops->ampdu_max_time)
>     val8 = priv->fops->ampdu_max_time;> 
> rtl8xxxu_write8(priv, REG_AMPDU_MAX_TIME_8723B, val8); // this line doesn't change?
> 
> Because originally val8 is read from REG_HT_SINGLE_AMPDU_8723B and add
> HT_SINGLE_AMPDU_ENABLE bit.

No, the value read from REG_HT_SINGLE_AMPDU_8723B is not supposed to be
written to REG_AMPDU_MAX_TIME_8723B. And it never was, because only
RTL8723B, RTL8710B, and RTL8188F use this function. This was clearer in
the original version of the code, when it was used only by RTL8723B:

		val8 = rtl8xxxu_read8(priv, REG_HT_SINGLE_AMPDU_8723B);
		val8 |= BIT(7);
		rtl8xxxu_write8(priv, REG_HT_SINGLE_AMPDU_8723B, val8);

		rtl8xxxu_write16(priv, REG_MAX_AGGR_NUM, 0x0c14);
		rtl8xxxu_write8(priv, REG_AMPDU_MAX_TIME_8723B, 0x5e);

> 
> ... I review further and want to add similar comment. I wonder you do this
> intentionally, so I find rtl8xxxu_init_burst() is only used by three chips
> RTL8723B, RTL8710B and RTL8188F. I'm not sure if other people could misuse 
> this function in the future, any idea?
> 

That will be their own mistake. :)

>>         rtl8xxxu_write32(priv, REG_AGGLEN_LMT, 0xffffffff);
>>         rtl8xxxu_write8(priv, REG_RX_PKT_LIMIT, 0x18);
>>         rtl8xxxu_write8(priv, REG_PIFS, 0x00);
>> @@ -3876,16 +3873,8 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
>>                 rtl8xxxu_write8(priv, REG_FWHW_TXQ_CTRL, FWHW_TXQ_CTRL_AMPDU_RETRY);
>>                 rtl8xxxu_write32(priv, REG_FAST_EDCA_CTRL, 0x03086666);
>>         }
>> -       /*
>> -        * The RTL8710BU vendor driver uses 0x50 here and it works fine,
>> -        * but in rtl8xxxu 0x50 causes slow upload and random packet loss. Why?
>> -        */
>> -       if (priv->rtl_chip == RTL8723B)
>> -               val8 = 0x50;
>> -       else if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8710B)
>> -               val8 = 0x28; /* 0x50 would make the upload slow */
>> -       rtl8xxxu_write8(priv, REG_USTIME_TSF_8723B, val8);
>> -       rtl8xxxu_write8(priv, REG_USTIME_EDCA, val8);
>> +       rtl8xxxu_write8(priv, REG_USTIME_TSF_8723B, priv->fops->ustime_tsf_edca);
>> +       rtl8xxxu_write8(priv, REG_USTIME_EDCA, priv->fops->ustime_tsf_edca);
>>
>>         /* to prevent mac is reseted by bus. */
>>         val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL);
>> @@ -4102,7 +4091,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
>>                 RCR_APPEND_PHYSTAT | RCR_APPEND_ICV | RCR_APPEND_MIC;
>>         rtl8xxxu_write32(priv, REG_RCR, val32);
>>
>> -       if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8710B) {
>> +       if (fops->init_reg_rxfltmap) {
>>                 /* Accept all data frames */
>>                 rtl8xxxu_write16(priv, REG_RXFLTMAP2, 0xffff);
>>
>> @@ -4187,8 +4176,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
>>         if (fops->init_aggregation)
>>                 fops->init_aggregation(priv);
>>
>> -       if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8188E ||
>> -           priv->rtl_chip == RTL8710B) {
>> +       if (fops->init_reg_pkt_life_time) {
> 
> Originally, 8192E doesn't do this. Just make sure you want to do it?
> 

I did want to do it. The RTL8192EU driver sets those registers. But
maybe that change should be in a separate patch. I'll send v2 where
RTL8192E doesn't set init_reg_pkt_life_time.

>>                 rtl8xxxu_write16(priv, REG_PKT_VO_VI_LIFE_TIME, 0x0400); /* unit: 256us. 256ms */
>>                 rtl8xxxu_write16(priv, REG_PKT_BE_BK_LIFE_TIME, 0x0400); /* unit: 256us. 256ms */
>>         }
>> --
>> 2.39.2
>>
>> ------Please consider the environment before printing this e-mail.

