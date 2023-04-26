Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F726EF30B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 13:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbjDZLFb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 07:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjDZLFa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 07:05:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDEA40F9
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 04:05:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f19b9d5358so46872685e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682507123; x=1685099123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qp3/kN2cqz2L75oT3NOK9ZGPPLkL+VEycubzlCW14Z8=;
        b=cJCVLC4IMETLNJmoRAU8GCKcRyES8O2hgbWAta9v5jxyHWXTdJjLdHHXwRXgSCdDn8
         rKD4g+EsRiSrJ5QBEcW4Vqli/Vmsm4Xip+lGrgIgS46iHTODhEOof7VxBqTwfoMa2yAu
         ieuM5gujzuoYfEYc7Yo296M+RZ6sBBWceAttaTASAO6zLNL43bj5l0ER3Frj/X6LBgeh
         u5uVqk6+zmpmKwQZ7s0ziFig68ErIbTEkQctPjLekOmrr/vCpdQyhDmroVBp70W/0VRA
         /dZpc9HIMp+6Vg3TDOON0pNG7/7KyFshdBeJ2GFy/5gfC2F78eQ6yZIAUXMaq1ouGZFv
         tueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682507123; x=1685099123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qp3/kN2cqz2L75oT3NOK9ZGPPLkL+VEycubzlCW14Z8=;
        b=P6jehxRoqRHSPTLDiUabeSrQk0ef14glZE1zGdmM3Cgs6JXMr7yVHZgBzR9KmgxJCb
         aIRMlOrx6wzgtJDp7LKrWqbdsTMfhd+ctWcVED+rC9NQqeCEKuc1valuemQsRwwJ1X9t
         AtFac5AoIs6PQXYzoqJMFDgehMsLAQNt/IRTSWQrX66F6v8pmR9k8+mOTekYX3ScFa+x
         UQbYbPfHYM2VSVyOZtXTsWD1F6UXWyd4zBVfNZJ3o3nCBCjVDAWLHaFMYs/ibQMviZk6
         p7nXoRUn26r0FwxDSJkdzpRX1Y85oyXFPSh1uTS4Kuxnffl+2jDO3KYwc5rEZosqzJpL
         6itQ==
X-Gm-Message-State: AAQBX9efewvN90xBGUnTCa9QkDCa03SEQnXcPa1M1Gd0uJCvw+yUt8Ob
        HmkiOdqEQOTREHWahfezcfM=
X-Google-Smtp-Source: AKy350ZdSqvDcjY+ZjMqo+nuW9DhOlra0UTjlLrFX8RkR3Os60hxWXpQoYgIqhEX3Y7B/51nQxYR7A==
X-Received: by 2002:a1c:4c09:0:b0:3f0:49b5:f0ce with SMTP id z9-20020a1c4c09000000b003f049b5f0cemr12985548wmf.12.1682507122875;
        Wed, 26 Apr 2023 04:05:22 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b003ee443bf0c7sm21152637wms.16.2023.04.26.04.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 04:05:22 -0700 (PDT)
Message-ID: <54497806-ae10-e4dd-aa66-cda0505c0267@gmail.com>
Date:   Wed, 26 Apr 2023 14:05:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
 <9430983b196d42ffa7f83859004ef856@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <9430983b196d42ffa7f83859004ef856@realtek.com>
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

On 26/04/2023 09:44, Ping-Ke Shih wrote:
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
> 
> It seems like you forget to add rtl8xxxu_8192f.o to Makefile.
> 

Oops, yes, I forgot.

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
> smatch reports two warnings that can be fixed by giving initial values: 
> 
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c:577 rtl8192fu_config_kfree() error: uninitialized symbol 'channel_idx'.
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c:2027 rtl8192fu_led_brightness_set() error: uninitialized symbol 'ledcfg'.
> 

Fixed, thanks.

> 
> I have not reviewed this patch entirely, and will continue in a few days.
> Just let you know these problems ahead. 
> 
> Ping-Ke
> 

