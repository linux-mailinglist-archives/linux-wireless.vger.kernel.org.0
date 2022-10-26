Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC4A60E02F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiJZMGR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 08:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJZMGQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 08:06:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17907AB09
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 05:06:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id q9so20753069ejd.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 05:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQi0i4iHqxn/UUFsgfMajjW9/fUQ17ZgltQV23Rl6GU=;
        b=dhm2WnYsnN+DIZzePbBPbAMPQhSZgi5IapiWmYFZbv8B4IWgwAJrt4yhBu6LNbfyqY
         C9HTuD/1yIgdgVFN0uYBci2clLr1z2H9Qh+d0t40GSvK43lI7Rdq6hc+bPzW5Hjzr+iR
         ywvz8RQzJTkTd+2Mk/ktbzL5dHeyaZapg92gVHexpFun6OcQPP2fLIG/zJoMf0a19cMt
         Spypemq65fpGgfDXQl52G1YDIwKEafDZPTCEOUrSK5PDx3IalDfStVGWuwhsgHgnE6vb
         EE752s4crrF8whsg+NYfOkvcMcgPdnBeSruWZ24AyvWSV3+a2OvkHepC4aziFStfRJka
         cnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQi0i4iHqxn/UUFsgfMajjW9/fUQ17ZgltQV23Rl6GU=;
        b=3UY8GE+vI2jtvOs0yQ1jBTuNumck1H2oVl5xA/jdHv7vQu3oXtCaRoURKIuXQnhk6z
         kA5D3uyqvvl3/dcA6sqCXuNmn5fvvvpUxGyXHHWLHFXW7MuvuxSyjJBlobTzD5DaArwi
         148SHfkyQfyN/6j+e6qDnw8x/1xlpE3Z775YTiGIg8czKJ3geeUuHIt1nGWl1P6aKjMI
         cDO2x5tb3+hXeSFUhMPMC3jLy/jD8+aDXcP1xM74JsQO6XUT/akoIzijM8cGPCOTdw8h
         yuG86QrtDNhShd2ESxPQKYQMafbKxJtslTNxdZ02EO+G7JRYFG3Nk+4jZN1qcfrw+zak
         ZxFA==
X-Gm-Message-State: ACrzQf2apHwiDfRyk36sPjOrQELGk5esQI6LmXEM5hv2jXoxmT7695/9
        YYI/lQhq5+0kP+osrs3VwIeR/YcbVOE=
X-Google-Smtp-Source: AMsMyM6UQiHgRGnUgKy/W+f3ksoIP3qcAjimPpQ/MebkKYkLC+6WvyzpL0xM5vJIiGKJs1jriNRlmA==
X-Received: by 2002:a17:907:2c59:b0:7a9:1134:db02 with SMTP id hf25-20020a1709072c5900b007a91134db02mr13044853ejc.508.1666785973337;
        Wed, 26 Oct 2022 05:06:13 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id sa3-20020a1709076d0300b0074134543f82sm2932356ejc.90.2022.10.26.05.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:06:12 -0700 (PDT)
Message-ID: <ae140509-e105-42d0-f782-8abe1100b981@gmail.com>
Date:   Wed, 26 Oct 2022 15:06:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
 <25b7381d-178c-d909-015e-1acf7698ec13@gmail.com>
 <7040619d7d5c4b198b320812093d33f9@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <7040619d7d5c4b198b320812093d33f9@realtek.com>
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

On 25/10/2022 06:46, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Tuesday, October 25, 2022 4:55 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
>> Subject: [PATCH v2 2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
>>
>> The CCK RSSI calculation is incorrect for the RTL8723BU, RTL8192EU,
>> and RTL8188FU. Add new functions for these chips with code copied from
>> their vendor drivers. Use the old code only for the RTL8723AU and
>> RTL8192CU.
>>
>> I didn't notice any difference in the reported signal strength with my
>> RTL8188FU, but I didn't look very hard either.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - No change.
>> ---
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 ++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         | 32 ++++++++++++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         |  1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 23 +++++++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         | 23 +++++++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         | 29 ++++++++++++++
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 38 ++++++++++++-------
>>  7 files changed, 135 insertions(+), 14 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 86a3457fd951..7023f6accda7 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4325,6 +4325,29 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
>>  		val32 &= 0xfff00fff;
>>  		val32 |= 0x0007e000;
>>  		rtl8xxxu_write32(priv, REG_AFE_MISC, val32);
>> +
>> +		/*
>> +		 * 0x824[9] = 0x82C[9] = 0xA80[7] those registers setting
>> +		 * should be equal or CCK RSSI report may be incorrect
>> +		 */
>> +		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XA_HSSI_PARM2);
>> +		priv->cck_agc_report_type = val32 & FPGA0_HSSI_PARM2_CCK_HIGH_PWR;
>> +
>> +		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XB_HSSI_PARM2);
>> +		if (priv->cck_agc_report_type != (bool)(val32 & FPGA0_HSSI_PARM2_CCK_HIGH_PWR)) {
>> +			if (priv->cck_agc_report_type)
>> +				val32 |= FPGA0_HSSI_PARM2_CCK_HIGH_PWR;
>> +			else
>> +				val32 &= ~FPGA0_HSSI_PARM2_CCK_HIGH_PWR;
>> +			rtl8xxxu_write32(priv, REG_FPGA0_XB_HSSI_PARM2, val32);
>> +		}
>> +
>> +		val32 = rtl8xxxu_read32(priv, 0xa80);
>> +		if (priv->cck_agc_report_type)
>> +			val32 |= BIT(7);
>> +		else
>> +			val32 &= ~BIT(7);
> 
> We can give a name to 0xA80[7]: 
> 
> #define REG_AGC_RPT 0x0a80
> #define AGC_RTP_CCK BIT(7)
> 
> 
Thanks, I'll add it.
