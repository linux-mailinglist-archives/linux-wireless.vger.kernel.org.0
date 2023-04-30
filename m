Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6486F28DD
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Apr 2023 14:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjD3M0Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Apr 2023 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjD3M0P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Apr 2023 08:26:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24271736
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 05:26:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315735514so106404735e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682857569; x=1685449569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPN08GMxG9oyeuGHMn9O683hVvfH1MNboyZa1x+5IE8=;
        b=NkqT41M461hfje7P/Fi3FCNiAJXhCMIMxCvtD/0L0xGkCNIZ5IdZlNTRuhtXMRzqZ0
         DFG+MrRANszjvXo8lZx09L/V1Hk5I7B9/TBpR6Mcwy8cpC3YJJRG1UoFb7IPHZ/6sLrs
         TvxBytYnXx2jHkb4vWQogxeWK3SnKTtOoG/MQ7Vjiv9UhMP4+gzLB8ty1gbC9LPBhi9F
         xQbhxwMJjS/FvkQ6cJkh3NUa+35ysdwpSvoRjrC/Y3+C0PDzCedRbTkBvgWg05ngEQIW
         fgppNSvoTtM1Ppe3Txcdgykk5foaJm77fzaUhcnQ3wDHinidCuhrD+1qVHhUxvACYJBB
         ziPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682857569; x=1685449569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPN08GMxG9oyeuGHMn9O683hVvfH1MNboyZa1x+5IE8=;
        b=eSN6r8jSxM/puqMN75GxK+ymd6oK7POnyeWMxV4QArnGGMC8YuQWWB2RUCmvB4Z7GN
         5xN+caR+MMHaReAs9U2HQATWcyPesB2v5eCoGk3GvVxBvSDV5j1bPsT2MxISjGfuUVzK
         U2uUilh0iXJOTDTqB8vzWi+j8yzb2NUDQzxPApqbmgJPyOzstb4yjvlp6q9Fj6n7OTjt
         aUsui00nbEbSKREE3In1z7hOUkGCd/Gg9vWkmBdi/N4HcyJicstUdGDC9aZyLn2ZrOA7
         hZwORwZbrM5k5E2dT/WjUxeDOmbNxw7s8yof7Y9Fa9xB6SvxPRykkRArdXQUmYzdVo31
         VBuA==
X-Gm-Message-State: AC+VfDx/4wVqlTvSS5LxY/qGAHHtPzLp9dEaIiraAJ3ooOumCbBG9ZX2
        ORc9/eix1IfwYrwu1QUz91g=
X-Google-Smtp-Source: ACHHUZ6nLxQ+svp8Gg2bAoD31yFB8GU7hd0LFN8oM/ES1fLYVpJsNYzli5vw99jZE4iGSR2ffQ/HRA==
X-Received: by 2002:a5d:66d2:0:b0:2ef:eb45:2317 with SMTP id k18-20020a5d66d2000000b002efeb452317mr10805548wrw.9.1682857569167;
        Sun, 30 Apr 2023 05:26:09 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id s4-20020adfeb04000000b003047f7a7ad1sm16468848wrn.71.2023.04.30.05.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 05:26:08 -0700 (PDT)
Message-ID: <c36acc8f-5dca-ce60-043d-8da4d16a461b@gmail.com>
Date:   Sun, 30 Apr 2023 15:26:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
 <867b2c35f606434bb82ecc17d0fd9336@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <867b2c35f606434bb82ecc17d0fd9336@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 28/04/2023 09:21, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Wednesday, April 26, 2023 1:28 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
>>
>> This is a newer chip, similar to the RTL8710BU in that it uses the same
>> PHY status structs.
>>
>> Features: 2.4 GHz, b/g/n mode, 2T2R, 300 Mbps.
>>
>> It can allegedly have Bluetooth, but that's not implemented here.
>>
>> This chip can have many RFE (RF front end) types, of which type 5 is
>> the only one tested. Many of the other types need different
>> initialisation tables. They can be added if someone wants them.
>>
>> The vendor driver v5.8.6.2_35538.20191028_COEX20190910-0d02 from
>> https://github.com/BrightX/rtl8192fu was used as reference.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/Kconfig |    3 +-
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   47 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    3 +-
>>  .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 2081 +++++++++++++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         |    1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |    1 +
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  104 +-
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   15 +
>>  8 files changed, 2225 insertions(+), 30 deletions(-)
>>  create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
>>
> 
> [...]
> 
>> +static void rtl8192fu_config_kfree(struct rtl8xxxu_priv *priv, u8 channel)
>> +{
>> +       u8 bb_gain[3] = { EFUSE_UNDEFINED, EFUSE_UNDEFINED, EFUSE_UNDEFINED };
>> +       u8 bb_gain_path_mask[2] = { 0x0f, 0xf0 };
>> +       enum rtl8xxxu_rfpath rfpath;
>> +       u8 bb_gain_for_path;
>> +       u8 channel_idx;
>> +
>> +       if (channel >= 1 && channel <= 3)
>> +               channel_idx = 0;
>> +       if (channel >= 4 && channel <= 9)
>> +               channel_idx = 1;
>> +       if (channel >= 10 && channel <= 14)
>> +               channel_idx = 2;
>> +
>> +       rtl8xxxu_read_efuse8(priv, 0x1ee, &bb_gain[1]);
>> +       rtl8xxxu_read_efuse8(priv, 0x1ec, &bb_gain[0]);
>> +       rtl8xxxu_read_efuse8(priv, 0x1ea, &bb_gain[2]);
> 
> Can you define these fields in struct rtl8192fu_efuse, and access via
> the struct? 
> 
> 
>> +
>> +       if (bb_gain[1] == EFUSE_UNDEFINED)
>> +               return;
>> +
>> +       if (bb_gain[0] == EFUSE_UNDEFINED)
>> +               bb_gain[0] = bb_gain[1];
>> +
>> +       if (bb_gain[2] == EFUSE_UNDEFINED)
>> +               bb_gain[2] = bb_gain[1];
>> +
>> +       for (rfpath = RF_A; rfpath < priv->rf_paths; rfpath++) {
>> +               /* power_trim based on 55[19:14] */
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_UNKNOWN_55,
>> +                                         BIT(5), 1);
>> +
>> +               /* enable 55[14] for 0.5db step */
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, 0xf5, BIT(18), 1);
> 
> #define RF6052_REG_GAIN_CTRL 0x55
> 

Just to be sure, this is the name for 0x55 or 0xf5 ?
