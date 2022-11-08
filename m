Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE0D621406
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 14:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiKHN4f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 08:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiKHN4e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 08:56:34 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B05966C8E
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 05:56:33 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id f8so9094286qkg.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Nov 2022 05:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFxBBgOzdIUT70AszUAC4fGNzQK7jxaT/pcQiXf1P3s=;
        b=Ju9b8gpC+2c7vWewNZ+HDvhR7+daerGSa7T0nf6eeUouLPhFL0SLyAlgtrbV9ew2vH
         UQJSwcgXREpOq1bM5U1vuw+uSKPCI/WmBeJM42J5eoW9YwxVjRMFBvPsfYKA92A8RuR0
         UWDcKZMHR+dy9PQHN5kGz9wTMnLfSWFHjDsShKqPwC4AJ2vkRzmToUuaqdDiGjDDsQ6n
         1hHj1hPG1nlHdvPoJUcPnAN9VxvLeXhvn7Al5KJpF0hK7FtwablBCgMhKQox1Y/L/Mm3
         0ZShnoF+ooj5JEirNJw7aB/23vA6jHkxC+EUWbR2nZY29m9Z0XQeEMjpjZP3ifKXQd/P
         bUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFxBBgOzdIUT70AszUAC4fGNzQK7jxaT/pcQiXf1P3s=;
        b=QXjymdg6SheVl5rF5ShdlqjZ04DpQmYd0ud/nARf0RisOHuaHFj+0/+aUpTtzhCvlZ
         IKbhH+x3RDP68NaErqltZ4hN+Kf02pSvlCrs2ta9POnRUK2K5Og44FbD9F6S01Oslh63
         f03d6nDdjydedyCvP/S9xhW4cqsMXk65EwU0j8uqPwPuzDQYooDwfZhXdBOtUGpsXUU+
         8cyPsheSodVRz8WywVeQ0qRk7EXIDQNqk1NTxryKvW/Az1iOlnBP9ouB7AWO6GyozEdJ
         bMhY6LDoTr5dmWLvVvumHiF9wFMygDFdWwQkydyYihcCH0HOxa1PV4tId4AbvMM5YjAm
         t+Ag==
X-Gm-Message-State: ACrzQf2/jas/AzGN/TOldsLBI+zL5SxtmEoKgMJFoDqo4nj130Y70X51
        b0OBPZRnqs85dalcfSkjFOGz7mLJyc8=
X-Google-Smtp-Source: AMsMyM642vDBflit+e/w7I9n7R01/9XinowIOPd+IZxDIC5dmoUifNalfHhs2T3m/A+RuR6hT7Oi4Q==
X-Received: by 2002:a05:620a:4449:b0:6ce:d824:d2e2 with SMTP id w9-20020a05620a444900b006ced824d2e2mr39224079qkp.183.1667915792227;
        Tue, 08 Nov 2022 05:56:32 -0800 (PST)
Received: from ?IPV6:2620:10d:c0a8:1102::1024? ([2620:10d:c091:480::88bd])
        by smtp.gmail.com with ESMTPSA id c6-20020a05622a058600b003a580cd979asm6941598qtb.58.2022.11.08.05.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 05:56:31 -0800 (PST)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <35be1ae8-d93c-6339-5cab-123377f27c2d@gmail.com>
Date:   Tue, 8 Nov 2022 08:56:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/3] wifi: rtl8xxxu: Move burst init to a function
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
 <9c3088fb5e904415b5886852fe828827@realtek.com>
In-Reply-To: <9c3088fb5e904415b5886852fe828827@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/6/22 21:40, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Sunday, November 6, 2022 6:53 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
>> Subject: [PATCH v2 1/3] wifi: rtl8xxxu: Move burst init to a function
>>
>> No changes to functionality, just moving code to make
>> rtl8xxxu_init_device look nicer.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - No change.
>> ---
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  2 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  1 +
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 89 ++++++++++---------
>>  4 files changed, 52 insertions(+), 41 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 019f8ddd418b..282ad8a9b73d 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -3886,6 +3886,52 @@ static void rtl8xxxu_init_queue_reserved_page(struct rtl8xxxu_priv *priv)
>>  	rtl8xxxu_write32(priv, REG_RQPN, val32);
>>  }
>>
>> +void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
>> +{
>> +	u8 val8;
>> +
>> +	/*
>> +	 * For USB high speed set 512B packets
>> +	 */
>> +	val8 = rtl8xxxu_read8(priv, REG_RXDMA_PRO_8723B);
>> +	val8 &= ~(BIT(4) | BIT(5));
>> +	val8 |= BIT(4);
>> +	val8 |= BIT(1) | BIT(2) | BIT(3);
> 
> I think we can fix these magic numbers along with your patch.
> 
> #define DMA_MODE BIT(1)  // set 0x1
> #define DMA_BURST_CNT GENMASK(3, 2) // set 0x3
> #define DMA_BURST_SIZE GENMASK(5, 4) // set 0x1

Thanks for providing these definitions.

Jes


