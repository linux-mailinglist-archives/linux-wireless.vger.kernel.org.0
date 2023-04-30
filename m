Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5167B6F2909
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Apr 2023 15:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjD3NWJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Apr 2023 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3NWI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Apr 2023 09:22:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3311711
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 06:22:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f1728c2a57so15445565e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682860925; x=1685452925;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ELCPocxRTLNDxdsXovbhoAZ5ticZeVZBAajvyCDcWQ=;
        b=E+Mu6DR+2F8MpwH6NGX5J1Crkmwha32tg+UtHpz1ig7syhVSgodA0sRVG+w4u0jFrb
         fmjSfn0htMkzyvOsIE9u0IgoyUdD6OjTyN0gEw9wFit4IaLBMBdx4nHe8cC75c5O3Gly
         vMtlFMsrtx3ppsklfwZFl7VyrFl4Xg4eo9zh989Qg9xhHF2sDt6MQSKaCYalgHyEV5Sd
         yJalOuZC2Ova6M8Pqk5OWjAvs2xOiLeNFrMDbWxKO8vRvMth6Gh4V+36wuxyHoMoHpTo
         scx8dicHCdeS8XGN8Lc8yS11HHd3s9gkA2+qpRBu9rUXm1U+6GQ1q+Qa/U7Y2/FVopO4
         OzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682860925; x=1685452925;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ELCPocxRTLNDxdsXovbhoAZ5ticZeVZBAajvyCDcWQ=;
        b=kZ0dQY2eQtOqTzk2lP/rQ/+rd+h2IgPFeeFlMralJyvu4exvhS8ejjL+2KQCH6EjS2
         RYw2K+4qnHMHnY6bbvFVqNGiREx1sHUAdgaFQFwcAhoAtD8D4nGypJPmQ3T/ifez4tWR
         lU2pR2gGHGJMttlD5ixz61g+cQzBiDfHAEtxUsZpoh80dCN/A5/UDGKNHOxFLy6FVZV4
         HoK4q0YM+LF+OORfeGTzUvfA3O1V/udROPJ7Xg5MigV8lbt/r53ZJb4yr4NIgT0ezURp
         MqCFPK+m8bljhWIJo+rDW3509RO1bNQeCmM7LQbWk6sGQSm38FZbhXngE0vBzJVME4Pz
         bx5w==
X-Gm-Message-State: AC+VfDwUvb963LAVO3JLTNR2C+n8eDm1DH7yoNklQ28ec0cG6LlHXTVk
        sJCF/Xc8gB00NVlXWSHSPDc=
X-Google-Smtp-Source: ACHHUZ4Np95GoWRS+uiR2n5MIyRLQoQBw3VOYtHEJuXG0RoJMGHM4jKCfJUB2vpyeuI56F2O4CYXLw==
X-Received: by 2002:a05:600c:228f:b0:3ed:2a41:8525 with SMTP id 15-20020a05600c228f00b003ed2a418525mr8206467wmf.22.1682860925379;
        Sun, 30 Apr 2023 06:22:05 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id i40-20020a05600c4b2800b003ee6aa4e6a9sm32961675wmp.5.2023.04.30.06.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 06:22:04 -0700 (PDT)
Message-ID: <b6c6b5fa-00a3-b2a7-0c7d-a98b0b3c11e8@gmail.com>
Date:   Sun, 30 Apr 2023 16:22:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
 <867b2c35f606434bb82ecc17d0fd9336@realtek.com>
 <c36acc8f-5dca-ce60-043d-8da4d16a461b@gmail.com>
Content-Language: en-US
In-Reply-To: <c36acc8f-5dca-ce60-043d-8da4d16a461b@gmail.com>
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

On 30/04/2023 15:26, Bitterblue Smith wrote:
> On 28/04/2023 09:21, Ping-Ke Shih wrote:
>>
>>
>>> -----Original Message-----
>>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>> Sent: Wednesday, April 26, 2023 1:28 AM
>>> To: linux-wireless@vger.kernel.org
>>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>>> Subject: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
>>>
>>> This is a newer chip, similar to the RTL8710BU in that it uses the same
>>> PHY status structs.
>>>
>>> Features: 2.4 GHz, b/g/n mode, 2T2R, 300 Mbps.
>>>
>>> It can allegedly have Bluetooth, but that's not implemented here.
>>>
>>> This chip can have many RFE (RF front end) types, of which type 5 is
>>> the only one tested. Many of the other types need different
>>> initialisation tables. They can be added if someone wants them.
>>>
>>> The vendor driver v5.8.6.2_35538.20191028_COEX20190910-0d02 from
>>> https://github.com/BrightX/rtl8192fu was used as reference.
>>>
>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>> ---
>>>  drivers/net/wireless/realtek/rtl8xxxu/Kconfig |    3 +-
>>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   47 +
>>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    3 +-
>>>  .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 2081 +++++++++++++++++
>>>  .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         |    1 +
>>>  .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |    1 +
>>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  104 +-
>>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   15 +
>>>  8 files changed, 2225 insertions(+), 30 deletions(-)
>>>  create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
>>>
>>
>> [...]
>>
>>> +static void rtl8192fu_config_kfree(struct rtl8xxxu_priv *priv, u8 channel)
>>> +{
>>> +       u8 bb_gain[3] = { EFUSE_UNDEFINED, EFUSE_UNDEFINED, EFUSE_UNDEFINED };
>>> +       u8 bb_gain_path_mask[2] = { 0x0f, 0xf0 };
>>> +       enum rtl8xxxu_rfpath rfpath;
>>> +       u8 bb_gain_for_path;
>>> +       u8 channel_idx;
>>> +
>>> +       if (channel >= 1 && channel <= 3)
>>> +               channel_idx = 0;
>>> +       if (channel >= 4 && channel <= 9)
>>> +               channel_idx = 1;
>>> +       if (channel >= 10 && channel <= 14)
>>> +               channel_idx = 2;
>>> +
>>> +       rtl8xxxu_read_efuse8(priv, 0x1ee, &bb_gain[1]);
>>> +       rtl8xxxu_read_efuse8(priv, 0x1ec, &bb_gain[0]);
>>> +       rtl8xxxu_read_efuse8(priv, 0x1ea, &bb_gain[2]);
>>
>> Can you define these fields in struct rtl8192fu_efuse, and access via
>> the struct? 
>>
>>
>>> +
>>> +       if (bb_gain[1] == EFUSE_UNDEFINED)
>>> +               return;
>>> +
>>> +       if (bb_gain[0] == EFUSE_UNDEFINED)
>>> +               bb_gain[0] = bb_gain[1];
>>> +
>>> +       if (bb_gain[2] == EFUSE_UNDEFINED)
>>> +               bb_gain[2] = bb_gain[1];
>>> +
>>> +       for (rfpath = RF_A; rfpath < priv->rf_paths; rfpath++) {
>>> +               /* power_trim based on 55[19:14] */
>>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_UNKNOWN_55,
>>> +                                         BIT(5), 1);
>>> +
>>> +               /* enable 55[14] for 0.5db step */
>>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, 0xf5, BIT(18), 1);
>>
>> #define RF6052_REG_GAIN_CTRL 0x55
>>
> 
> Just to be sure, this is the name for 0x55 or 0xf5 ?

Also,

#define REG_RFE_OPT62			0x0968

Is it 62 or just 2 ?
