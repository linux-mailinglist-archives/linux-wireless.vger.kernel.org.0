Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB197529C6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 19:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjGMRYT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGMRYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 13:24:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E61BD4
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 10:24:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9936b3d0286so142543066b.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689269055; x=1691861055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CicCvCSuZURjJ3BMndB2ugts+xrGMAmc5RbxFAH1/7c=;
        b=Zup1jjt7iEtLOP+zEiGqY4+oaVTYzz66UuLhoH7bvfXEKkug8qhabos19/vpefR2QF
         DcJculUlhSL/+Ts8y7L0Nw5bSQXUb4NcMMD+03kOl2DqrtGP3HM3JDDz8CWeg0x19pS4
         aBSxvbHgs3aUVNBmScPR7GITh26pvstTkF75Rmx4589OjhX4AOqr82iyDi8kneBEv1kl
         B7fOVxMpGdp9xnVB4i8vaSaSYQsEG08Ix9nCCeIuifJNig6tEn/XvGWVhnQue1nnmvog
         FLSV21Cp0NfW6sRMXeyDBACfgaxqm49MaDS2EKejp7GcHkeFUQUbwWQLaIWPQ3F9yl8Z
         I7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269055; x=1691861055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CicCvCSuZURjJ3BMndB2ugts+xrGMAmc5RbxFAH1/7c=;
        b=aw4PvBC3chYNbSX7mq5bD18VDWCOPEpxj1k0CfljcAuor3XWCUtCkboypKaLihAVFI
         3hyX6chbVbSHoT5GzRPZJnT7h7aXYohWmMw09JHoYDivBtdby9HJ5KXOWy0sAXGnezvU
         L2FAvM2+IET+T5DNHAo3Lctc+2UNmEKc4QWpEeMdBhd86VTfETvNf1UhHLm+FvIDNf0S
         eUwAyAA2faIHls1DWUIMqkfSPa1Zg9sppZt/UIcuAmrHjcAseeToTaI463WCToVNwCUj
         IzhN7LAyt8nBN5maDxMeUT05EOer9VLTI/HWfryXyyhmMqaRaejPbfMbtfaG/EKT5z7S
         UtyQ==
X-Gm-Message-State: ABy/qLYqQ/AiEe5eT5IWFnOcrdKt6bpNKoslV+zBhFxetsh6HJ1C3VLn
        TTlCUvuifAA3Q/O74cGEcO2JfIgO6Pw=
X-Google-Smtp-Source: APBJJlGeuS31YYurnPJJgfIgMB23jXiVZ3xwMAinl0TXcu6DdPq3eyALk9/C/7ZbrioFCrEQQd45fw==
X-Received: by 2002:a17:906:28c:b0:993:e2ba:55a2 with SMTP id 12-20020a170906028c00b00993e2ba55a2mr2204134ejf.19.1689269055035;
        Thu, 13 Jul 2023 10:24:15 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id md11-20020a170906ae8b00b009828e26e519sm4214779ejb.122.2023.07.13.10.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 10:24:14 -0700 (PDT)
Message-ID: <6894e812-975b-cb00-3ff9-4c6796158980@gmail.com>
Date:   Thu, 13 Jul 2023 20:24:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC] wifi: rtl8xxxu: Fix the TX power of RTL8192CU,
 RTL8723AU
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <52c28b65-6f28-2cc0-7281-179bb1087c2a@gmail.com>
 <509e09b7bfa445fb81f4e3dc3a83dd65@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <509e09b7bfa445fb81f4e3dc3a83dd65@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/07/2023 04:42, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Monday, July 10, 2023 2:38 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH RFC] wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
>>
>> Don't subtract 1 from the power index. This was added in commit
>> 2fc0b8e5a17d ("rtl8xxxu: Add TX power base values for gen1 parts")
>> for unknown reasons. The vendor drivers don't do this.
>>
>> Also correct the calculations of values written to
>> REG_OFDM0_X{C,D}_TX_IQ_IMBALANCE. According to the vendor driver,
>> these are used for TX power training.
>>
>> With these changes rtl8xxxu sets the TX power of RTL8192CU the same
>> as the vendor driver.
>>
>> None of this appears to have any effect on my RTL8192CU device.
>> ---
>> My RTL8192CU with rtl8xxxu has lower upload speed compared to the
>> vendor driver, so I compared the register writes and found
>> differences in the TX power stuff.
>>
>> Jes, do you remember why you subtracted 1 from the power index?
>> That has to be on purpose. The other differences look unintentional.
>> ---
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 5d102a1246a3..e111fb2b2c30 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -1510,8 +1510,8 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
>>
>>         group = rtl8xxxu_gen1_channel_to_group(channel);
>>
>> -       cck[0] = priv->cck_tx_power_index_A[group] - 1;
>> -       cck[1] = priv->cck_tx_power_index_B[group] - 1;
>> +       cck[0] = priv->cck_tx_power_index_A[group];
>> +       cck[1] = priv->cck_tx_power_index_B[group];
>>
>>         if (priv->hi_pa) {
>>                 if (cck[0] > 0x20)
>> @@ -1522,10 +1522,6 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
>>
>>         ofdm[0] = priv->ht40_1s_tx_power_index_A[group];
>>         ofdm[1] = priv->ht40_1s_tx_power_index_B[group];
>> -       if (ofdm[0])
>> -               ofdm[0] -= 1;
>> -       if (ofdm[1])
>> -               ofdm[1] -= 1;
>>
>>         ofdmbase[0] = ofdm[0] + priv->ofdm_tx_power_index_diff[group].a;
>>         ofdmbase[1] = ofdm[1] + priv->ofdm_tx_power_index_diff[group].b;
>> @@ -1614,20 +1610,22 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
>>
>>         rtl8xxxu_write32(priv, REG_TX_AGC_A_MCS15_MCS12,
>>                          mcs_a + power_base->reg_0e1c);
>> +       val8 = u32_get_bits(mcs_a + power_base->reg_0e1c, 0xff000000);
> 
> Comparing to vendor driver, I think the logic here is the same. 
> 
>>         for (i = 0; i < 3; i++) {
>>                 if (i != 2)
>> -                       val8 = (mcsbase[0] > 8) ? (mcsbase[0] - 8) : 0;
>> +                       val8 = (val8 > 8) ? (val8 - 8) : 0;
>>                 else
>> -                       val8 = (mcsbase[0] > 6) ? (mcsbase[0] - 6) : 0;
>> +                       val8 = (val8 > 6) ? (val8 - 6) : 0;
> 
> Would you like val8 = min_t(int, val8 - 6, 0); ?
> 
> Even, merge two branches into one.
>   base = i != 2 ? 8 : 6;
>   val8 = min_t(int, val8 - base, 0);
> 
> [...]
> 

I think max_t, but otherwise yes, that looks good.
