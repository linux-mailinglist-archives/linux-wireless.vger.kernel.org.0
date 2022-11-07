Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EAE61F7F5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 16:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiKGPuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 10:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiKGPuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 10:50:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE82B31
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 07:50:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id k2so31312960ejr.2
        for <linux-wireless@vger.kernel.org>; Mon, 07 Nov 2022 07:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auDS0VZKmE4IjAUwpCcSgaxHj8a4G5trtMwhu0qgpvY=;
        b=LmWxaf4en5QeHC3Zsy9tp+Y7dmfjqv68OCHaL58TINfQyvcg+UWTw1BI0c49lg3gAM
         x2I+1PVcYNyJlx1p3CtWUyaatxAKAryf7H570O2Kczvp4lxCN2eszWkqNQsPKrd0OSMv
         9XC8tCZN4fiQt4tvKufs0CmNFAFqJ1brd8rxXzq0SZfr1+qF48UpyBS+JU1YvYVmr42H
         Mwyetyh1ihUmDbJ++FUyb1IAk/gr5bP1DbUJPfiPHYWiJXfTeI0pV9rzB6zjuGTezVya
         YOEeFN+L3xpHXSoDDVQtw4nc6jnIEfGcDTuCWfXf2QmfOjI3SnxGRuWo8zkP6+ublg6l
         auQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auDS0VZKmE4IjAUwpCcSgaxHj8a4G5trtMwhu0qgpvY=;
        b=FxkSapaFY0SqBxiEF7EKzu2+HH7ZZqajyxjCVWRhicJNEBDqmOINfn4Iz8u9nMchMB
         o7D5tOdD6SBSA+L2k+WSnCXYiIgy1vWjL1b0xihJN0op0n3OammPWXVsx79vu6DNOVBH
         uvTuCVX+/sxZm3qXDi2gw+4Y3wCla7L6ai/ic3UIUHvmP5KAe//IBV9ce5Kts7Gdy48Y
         DClbMOqIYfQd2nmP7KObddqfeeriodoAdgQziKGtUDF5yoUd/YjDLOVjCCMxhhFYChm+
         B1hdppmUz14aF5FqfAWnJyHBrHuU0q0TZnHDHjLAmKBloXunrTVsLqt66q87wDpsxJI0
         Z7qg==
X-Gm-Message-State: ACrzQf0mAtnAK44sK0L0WHWVyFRw14jkaIHehb9TCq9MjNlJciMy5zrL
        +Y6CEGcKJCyjwt54+dei5tU=
X-Google-Smtp-Source: AMsMyM43zDRsHtfo8wUhCYHeTEBk8oXudZhm9/kCEFuBDZpYLRAEUGDeRf+yGs4iETRLUDQcRLcOcQ==
X-Received: by 2002:a17:907:3f28:b0:7ad:88f8:7644 with SMTP id hq40-20020a1709073f2800b007ad88f87644mr47590508ejc.738.1667836205354;
        Mon, 07 Nov 2022 07:50:05 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402069800b00458a03203b1sm4438453edy.31.2022.11.07.07.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:50:04 -0800 (PST)
Message-ID: <5a15aa7d-9977-e905-684e-9f19e2e70cc0@gmail.com>
Date:   Mon, 7 Nov 2022 17:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/3] wifi: rtl8xxxu: Move burst init to a function
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
 <9c3088fb5e904415b5886852fe828827@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <9c3088fb5e904415b5886852fe828827@realtek.com>
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

On 07/11/2022 04:40, Ping-Ke Shih wrote:
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
> 

Thanks, but I think the bit definitions should be added in a separate patch,
which I will send soon. Same for the changes you suggested for patch 2/3.
