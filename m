Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E3765C6E9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 20:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjACTGR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 14:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbjACTFu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 14:05:50 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED85D108
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 11:05:48 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id x22so76257664ejs.11
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jan 2023 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uh5a5cO0lZCTM50ZOxBulkzEARd46aLU8k4b4iCP91k=;
        b=BptARzjuOm7ZCDoYWDiKzt8yI+FZ76b/ucto5uu/beUXgChYhmY+nOXjxqMBeq6Hi/
         e4SCgMHofX/mRtOBa4g/0IX99tvalEufzyE2a0sFUHQpPIqI/GBN47YrwOExDGm760HV
         pYXXc/w4DdYAkNmwUqJFt54EFyIY1ZdSb/v+3ptU0lcCPSRfBTe6W9gek32P9T65db+h
         jYd16rlfqVB0GVHVcfgw7TSzoXRs65lL0PslubbllXNgMtzeY61H0iZyEfy1ooh+lDqs
         ZJM62YY39ihJylHaYOz9a4DXBVaG9MfwC+SV4uPLC0VbAbk5wpSiVhd4Q5nWwLMwoEXB
         ufWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh5a5cO0lZCTM50ZOxBulkzEARd46aLU8k4b4iCP91k=;
        b=zQXeR0uc/9kdKMKM/5BLTpHnPHC7dfDBnozMIgejNbsAQQaf1Fe0T3ugoC5x7/AX+q
         8Q9uOIHOdB5koyH/k23DGuPckdZ8nwfGgUoHejLNk3VmdmXiwxNyXiFKGE26qrhugQ1A
         sJqpCSNY3ftvvdjuGJ9d1skCoYACBMsi5Bif2hR1wE9Oty7uD16T+zDRGz5fIv1JvlQ4
         gFjMueTikBorzWOI602Oj33NccIRGEzK8ZvnI5/UyX8LoinOxae4pV35GkEvt2ImfYzQ
         Gs+uBiU/yZHWLgBDMdLFYsjDEuOqYtcclsOZUawCsnhL/wlgYHZSpsBgM8a/eHlIV9Bz
         DxuQ==
X-Gm-Message-State: AFqh2kpkszACHK+LsV2GkiLphGwu/22zXz7m3Pi+TMCRr3Jyd20hdEsW
        XY50WyKo836LDAgkoZcMPBg=
X-Google-Smtp-Source: AMrXdXvigqaeEGj9d0F05S9KZpXqy8H5rI+x09QwDXHpht0r+OkKKdGiVS/uGtBYZvGRu+Gtizv2Sg==
X-Received: by 2002:a17:906:f6d7:b0:7c1:5169:3ed6 with SMTP id jo23-20020a170906f6d700b007c151693ed6mr44475415ejb.48.1672772747502;
        Tue, 03 Jan 2023 11:05:47 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id o22-20020a17090608d600b0080b3299ebddsm14681916eje.13.2023.01.03.11.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 11:05:46 -0800 (PST)
Message-ID: <8a46c9b9-6986-904f-94cc-be4a3cdbf0e6@gmail.com>
Date:   Tue, 3 Jan 2023 21:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: Report the RSSI to the firmware
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <6fcaaead-876c-68d1-a049-f1e7f7ff81e7@gmail.com>
 <ec58ba471076464282fdd1ce7d093449@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <ec58ba471076464282fdd1ce7d093449@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/01/2023 10:05, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Saturday, December 31, 2022 12:52 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH 1/2] wifi: rtl8xxxu: Report the RSSI to the firmware
>>
>> Or in the case of RTL8188EU, report the RSSI to the rate control code.
>>
>> The rate control code for RTL8188EU is less likely to switch to a lower
>> rate when the RSSI is high. The firmware-based rate control in the other
>> chips probably works the same way.
>>
>> This affects all the chips, but it was only tested with RTL8188EU,
>> RTL8188FU, and RTL8192EU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 23 +++++++++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |  6 ++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         |  1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         |  1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         |  1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  1 +
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 34 +++++++++++++++++++
>>  8 files changed, 68 insertions(+)
>>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index fd97c040948a..f5fd3c448587 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4461,6 +4461,37 @@ void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
>>  	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
>>  }
>>
>> +void rtl8xxxu_gen1_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi)
>> +{
>> +	struct h2c_cmd h2c;
>> +	const int h2c_size = 3;
> 
> Shouldn't it be 4?
> 
> 		struct {
> 			u8 cmd;
> 			u8 macid;
> 			u8 unknown0;
> 			u8 rssi;  // you fill this field.
> 

I probably copied that from the vendor driver, which doesn't count the
cmd field. But it turns out it doesn't matter. 3 and 4 will have the
same effect here. rtl8xxxu_gen1_h2c_cmd() only checks if the size is
greater than 4 or not.

But I suppose 4 is less confusing, so I'll change it.

>> +
>> +	memset(&h2c, 0, sizeof(struct h2c_cmd));
>> +
>> +	h2c.rssi_report.cmd = H2C_SET_RSSI;
>> +	h2c.rssi_report.macid = macid;
>> +	h2c.rssi_report.rssi = rssi;
>> +
>> +	rtl8xxxu_gen1_h2c_cmd(priv, &h2c, h2c_size);
>> +}
>> +
> 
> [...]
> 
> 

