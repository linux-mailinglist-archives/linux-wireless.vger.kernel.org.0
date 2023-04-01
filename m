Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661916D3411
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 23:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDAVYP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Apr 2023 17:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDAVYO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Apr 2023 17:24:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAF310D3
        for <linux-wireless@vger.kernel.org>; Sat,  1 Apr 2023 14:24:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x3so103058390edb.10
        for <linux-wireless@vger.kernel.org>; Sat, 01 Apr 2023 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpelpIbHuZ7W/j3oWkI7EazXXLRl/r4/AfUp4bXNvOE=;
        b=bANqpncLPUZsO4AqKtfdL0ItxDMAe2yRqc2m14rNwON8WGI2BcxK84ncN16B3xoOmn
         duR01o83Gk/q1SSneYoulIWJ8myQ+SEmtgSN1khFhWDkH+D/BvMax20JYCiqIitYKgC3
         qnMlopkIP+eqCnWoginO5BRPrqYxMgBluGaLnIfa8ViiOrtrJ7IG+mryRiuioeGpfMyC
         X+6Vn/UTJx/WIXUCQh89QA8H2xUPkklx9B5nHL0g19OA/PJ4yKdMO3F6PHY6y/szr5WY
         vAhAXyOhnXRmQFERLJiiuPfv/flA5l4jQQdlUcommHeP167qy3avKXZBf/21WYe7JZz/
         XUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpelpIbHuZ7W/j3oWkI7EazXXLRl/r4/AfUp4bXNvOE=;
        b=uZ1SHKYa1YuXjQZz+de9P/Q2rMq/R2mi1zWWeu4z0W1bbh8kJNWNscfDMg+KrhYxIc
         jyubIWAriwPIqBMC6BFzn4nr0trfhCMxKj4QDiLv8rLJ2KMKGcM54UzpKy4i8QBEqgam
         +zOE6MyurSfjEMv7YALyC3Kzl58HsMgj6+88RZaNKuYwrslvbLnjcwKeKuCz3LdwPIs3
         icTNLaF7CG4l7MNmvJRIDsJTh3sZaqUmtXhx6XxHIL2kJW3vwNdzjd5JHKXWbl001u0S
         jiOm8eI+aww8/mOaLeqLUEMEc9ZULpu8kDmmny2y0D2GzJSditWinvwGaYF0zc6GXjFE
         zXHQ==
X-Gm-Message-State: AAQBX9ftQ8GRRykzZ1LkzDOBN8pcmcvQ1hN3Uuag+kXykpAZpfero1Dz
        hzYL48SOhvoLwN6rwUYTC0g=
X-Google-Smtp-Source: AKy350Ztmx/6e4xXDiYW0VFNqIzct5LTMpyAFjwGy+/Lahm3eWOjM/kf3Dc+P7xJTYQRqTB/ZOMAYA==
X-Received: by 2002:a17:907:c248:b0:931:ce20:db8e with SMTP id tj8-20020a170907c24800b00931ce20db8emr32948343ejc.51.1680384252008;
        Sat, 01 Apr 2023 14:24:12 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906825800b008bc8ad41646sm2468272ejx.157.2023.04.01.14.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 14:24:11 -0700 (PDT)
Message-ID: <2dd49e4e-6628-eb2e-1168-0cc926c4d1fb@gmail.com>
Date:   Sun, 2 Apr 2023 00:24:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: Clean up some messy ifs
Content-Language: en-US
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <eb152b5b-fe65-3783-a3d9-71c9cb7ef9d3@gmail.com>
 <CAGRGNgUoEoN9Tm8=1LRtznbwm2KqiArtUHjXXZht0Nz1ZPunow@mail.gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CAGRGNgUoEoN9Tm8=1LRtznbwm2KqiArtUHjXXZht0Nz1ZPunow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01/04/2023 07:23, Julian Calaby wrote:
> Hi Bitterblue,
> 
> On Sat, Apr 1, 2023 at 7:18 AM Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> Add some new members to rtl8xxxu_fileops and use them instead of
>> checking priv->rtl_chip.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  5 ++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |  1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  5 ++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         |  1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         |  9 +++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  3 +++
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 26 +++++--------------
>>  7 files changed, 31 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>> index 6a82ec47568e..af8436070ba7 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>> @@ -1883,6 +1883,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
>>         .rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
>>         .tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
>>         .has_tx_report = 1,
>> +       .init_reg_pkt_life_time = 1,
> 
> I'm sure it's safe, but the fops structs that don't set the
> ampdu_max_time and ustime_tsf_edca values feel odd.
> 
They don't set those because they don't use them. Maybe one day
I will initialise all the members -- I read somewhere that it's
good practice -- but that's not what this patch is about.

>>         .gen2_thermal_meter = 1,
>>         .adda_1t_init = 0x0b1b25a0,
>>         .adda_1t_path_on = 0x0bdb25a0,
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>> index 82dee1fed477..dfb250adb168 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>> @@ -1746,6 +1746,11 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
>>         .has_tx_report = 1,
>>         .gen2_thermal_meter = 1,
>>         .needs_full_init = 1,
>> +       .init_reg_rxfltmap = 1,
>> +       .init_reg_pkt_life_time = 1,
>> +       .init_reg_hmtfr = 1,
>> +       .ampdu_max_time = 0x70,
>> +       .ustime_tsf_edca = 0x28,
> 
> The original code had comments for why the 8188fu had different values
> for ampdu_max_time and ustime_tsf_edca. Should they be copied here?
> 
I don't know if those comments are that useful.

>>         .adda_1t_init = 0x03c00014,
>>         .adda_1t_path_on = 0x03c00014,
>>         .trxff_boundary = 0x3f7f,
> 
> Thanks,
> 

