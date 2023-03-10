Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA546B4F89
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Mar 2023 18:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjCJRx2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Mar 2023 12:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjCJRxY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Mar 2023 12:53:24 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C092CC5B
        for <linux-wireless@vger.kernel.org>; Fri, 10 Mar 2023 09:53:08 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so6632105wmb.5
        for <linux-wireless@vger.kernel.org>; Fri, 10 Mar 2023 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678470787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ez+sE7/jASOrygZFOhBUqJtDHmOJ2uin/l0vrglVUd8=;
        b=CqaOuI4WwYosLGlzKgy0jNO8muan0NgrQEe1t8z/m9HOIkyO+V77RhwLTtTpsSBjTG
         F9cL9rQsYOKABTdR39OKq1dT3xGGxcKRMQA3agrjHmtfHwHYptY3ZTPas74m3akdopcJ
         UkDkttIlZwuDW6zFwg6CB7+k16femlYlZh3u1wcE47fgK5tfIuO718YsDs+FcjIKez4n
         i3m98Phr8YgGwl2NIQzm2I/FB87GHInDaCmObTHiLgWHwzMUEivr1/5pDmuxVkDlnQXV
         5ThxhhzTf0nh0PbsujN/s4AcZBDiK7dG+ae/QPuzxvUkTKaIBpdgPfTJih8Gg6hv8tDI
         Uibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678470787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez+sE7/jASOrygZFOhBUqJtDHmOJ2uin/l0vrglVUd8=;
        b=qGWyhjW/FeqJqmghKQMZnsDMfva6nP3CCCutA+kwTtEIterP+OdS8R+xW6OX1+oOgx
         ClCRDIMU2JAwItaxusyprO/5hpB+sdPIAimNGnD9En7KIP5wpTgxkEQ3eTL6JyYSnwej
         wskvuNXP5/nGXNpL822Ua/KVx2n1xCpH0RUAB9k1FXwzkaD0VQY/YDCKurBdJ5emkLiF
         NNyezJZ0qJPwkrriPFZbgaxj4nH9gsHXh4+Fthh4f6ZJgSTySbU77tXFkFc91RUZDV33
         4YGQyNlgyfSD5CffyMFhd9skjg/UWdC7GGRgSQorBkp/1Is430A9BZ3cT8HW/jmJnIlE
         kscQ==
X-Gm-Message-State: AO0yUKUSL9OToqDapaMXo5ntu3LTmDaJUTZBtHuHerp9oSW3GsFMwdYj
        zU09bDtOIzKPqeW/nFbg7p8=
X-Google-Smtp-Source: AK7set8dRTzInRdorJSr9WInQAZgZO0r3mPKRhlFFZjYRhRGzcYkRb/WIg/SSjOrtlzSBAZLVio3VQ==
X-Received: by 2002:a05:600c:3514:b0:3e2:6c6:31a6 with SMTP id h20-20020a05600c351400b003e206c631a6mr3446753wmq.9.1678470787098;
        Fri, 10 Mar 2023 09:53:07 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id l26-20020a1c791a000000b003eb68bb61c8sm558412wme.3.2023.03.10.09.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 09:53:06 -0800 (PST)
Message-ID: <07f780e8-7b9e-c3cf-02dd-48325bd1f3b7@gmail.com>
Date:   Fri, 10 Mar 2023 19:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Support new chip RTL8710BU aka
 RTL8188GU
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>, Jiajie Chen <c@jia.je>
References: <d4c5073a-4831-7353-6ea7-06dfd3cca7f2@gmail.com>
 <8c3edda0b6944d4fafe08cea89b94142@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <8c3edda0b6944d4fafe08cea89b94142@realtek.com>
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

On 10/03/2023 02:49, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Thursday, March 9, 2023 5:28 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>; Jiajie Chen <c@jia.je>
>> Subject: [PATCH v2] wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU
>>
>> This chip is found in cheap "free driver" USB adapters from Aliexpress.
>> Initially they pretend to be a CD-ROM containing the driver for Windows.
>> "Ejecting" switches the device to wifi mode.
>>
>> Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.
>>
>> This chip is more unique than other Realtek chips:
>>
>> * The registers at addresses 0x0-0xff, which all the other chips use,
>>   can't be used here. New registers at 0x8000-0x80ff must be used
>>   instead. And it's not a simple matter of adding 0x8000: 0x2
>>   (REG_SYS_FUNC) became 0x8004, 0x80 (REG_MCU_FW_DL) became 0x8090,
>>   etc.
>>
>> * Also there are a few new registers which must be accessed indirectly
>>   because their addresses don't fit in 16 bits. No other chips seem to
>>   have these.
>>
>> * The vendor driver compiles to 8188gu.ko, but the code calls the chip
>>   RTL8710B(U) pretty much everywhere, including messages visible to the
>>   user.
>>
>> Another difference compared to the other chips supported by rtl8xxxu is
>> that it has a new PHY status struct, or three of them actually, from
>> which we extract the RSSI, among other things. This is not unique,
>> though, just new. The chips supported by rtw88 also use it.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - Suggestions from Ping-Ke Shih:
>>    - Add comma after the last member of enum rtl8xxxu_rtl_chip.
>>    - Add comment about struct mutex syson_indirect_access_mutex.
>>    - Declare variables in reverse Christmas tree order in
>>      rtl8710b_read_efuse().
>>    - Remove unnecessary variable ret from rtl8710bu_identify_chip().
>>    - Add definition for register 0xaac.
>>    - Use the existing macros REG_SYS_FUNC, SYS_FUNC_BBRSTB, and
>>      SYS_FUNC_BB_GLB_RSTN instead of magic numbers in
>>      rtl8710bu_active_to_lps().
>>    - Declare reg_mcu_fw_dl separately in rtl8xxxu_download_firmware().
>>  - Add spaces after /* and before */ in some comments.
>>  - Rearrange the declarations in rtl8710b_read_efuse8() as well.
>>  - Load the right firmware based on the chip manufacturer (UMC/SMIC).
>>  - Use the mask 0xc0 instead of 0xf0 to detect the chip manufacturer in
>>    rtl8710bu_identify_chip(). There was an extra shift in the vendor
>>    driver which I missed.
>>  - Make the vid and pid fields of struct rtl8710bu_efuse two bytes
>>    each, and the filler field res7 one byte shorter.
>>
>>  - I was lazy and didn't do some things the right way in v1. I thought
>>    surely there are no more chips to support. But since then I
>>    discovered that the RTL8192FU can be bought from Aliexpress for
>>    6.66 $. :) It will need the same PHY status parsing as the RTL8710BU,
>>    which is why there are these extra changes:
>>    - Initialise priv->cck_new_agc in rtl8xxxu_init_device() always,
>>      regardless of the chip family.
>>    - Pass the PHY status structs to the CCK RSSI functions.
>>    - Move the "old AGC" CCK RSSI calculation from
>>      rtl8710bu_rx_parse_phystats_type0() to a new function
>>      rtl8710b_cck_rssi().
>>    - Rename the functions rtl8710bu_rx_parse_phystats* to
>>      jaguar2_rx_parse_phystats* and move them to rtl8xxxu_core.c.
>>    - Modify the functions jaguar2_rx_parse_phystats_type{1,2} to handle
>>      2T2R chips as well.
>> ---
> 
> [...]
> 
>> +static u32 rtl8710b_indirect_read32(struct rtl8xxxu_priv *priv, u32 addr)
>> +{
>> +       struct device *dev = &priv->udev->dev;
>> +       u32 val32, value = 0xffffffff;
>> +       u8 polling_count = 0xff;
>> +
>> +       if (addr & 3) {
> 
> if (!IS_ALIGNED(addr, 4))
> 

Nice, that's more readable.

>> +               dev_warn(dev, "%s: Aborting because 0x%x is not a multiple of 4.\n",
>> +                        __func__, addr);
>> +               return value;
>> +       }
>> +
>> +       mutex_lock(&priv->syson_indirect_access_mutex);
>> +
>> +       rtl8xxxu_write32(priv, REG_USB_HOST_INDIRECT_ADDR_8710B, addr);
>> +       rtl8xxxu_write32(priv, REG_EFUSE_INDIRECT_CTRL_8710B, NORMAL_REG_READ_OFFSET);
>> +
>> +       do
>> +               val32 = rtl8xxxu_read32(priv, REG_EFUSE_INDIRECT_CTRL_8710B);
>> +       while ((val32 & BIT(31)) && (--polling_count > 0));
> 
> Add brace is allowed for this case. Not sure if you prefer this, or miss 
> comment before.
> 

Yes, I prefer it without the braces.

>> +
>> +       if (polling_count == 0)
>> +               dev_warn(dev, "%s: Failed to read from 0x%x, 0x806c = 0x%x\n",
>> +                        __func__, addr, val32);
>> +       else
>> +               value = rtl8xxxu_read32(priv, REG_USB_HOST_INDIRECT_DATA_8710B);
>> +
>> +       mutex_unlock(&priv->syson_indirect_access_mutex);
>> +
>> +       if (rtl8xxxu_debug & RTL8XXXU_DEBUG_REG_READ)
>> +               dev_info(dev, "%s(%04x) = 0x%08x\n", __func__, addr, value);
>> +
>> +       return value;
>> +}
>> +
>> +static void rtl8710b_indirect_write32(struct rtl8xxxu_priv *priv, u32 addr, u32 val)
>> +{
>> +       struct device *dev = &priv->udev->dev;
>> +       u8 polling_count = 0xff;
>> +       u32 val32;
>> +
>> +       if (addr & 3) {
> 
> if (!IS_ALIGNED(addr, 4))
> 
>> +               dev_warn(dev, "%s: Aborting because 0x%x is not a multiple of 4.\n",
>> +                        __func__, addr);
>> +               return;
>> +       }
>> +
>> +       mutex_lock(&priv->syson_indirect_access_mutex);
>> +
>> +       rtl8xxxu_write32(priv, REG_USB_HOST_INDIRECT_ADDR_8710B, addr);
>> +       rtl8xxxu_write32(priv, REG_USB_HOST_INDIRECT_DATA_8710B, val);
>> +       rtl8xxxu_write32(priv, REG_EFUSE_INDIRECT_CTRL_8710B, NORMAL_REG_WRITE_OFFSET);
>> +
>> +       do
>> +               val32 = rtl8xxxu_read32(priv, REG_EFUSE_INDIRECT_CTRL_8710B);
>> +       while ((val32 & BIT(31)) && (--polling_count > 0));
>> +
>> +       if (polling_count == 0)
>> +               dev_warn(dev, "%s: Failed to write 0x%x to 0x%x, 0x806c = 0x%x\n",
>> +                        __func__, val, addr, val32);
>> +
>> +       mutex_unlock(&priv->syson_indirect_access_mutex);
>> +
>> +       if (rtl8xxxu_debug & RTL8XXXU_DEBUG_REG_WRITE)
>> +               dev_info(dev, "%s(%04x) = 0x%08x\n", __func__, addr, val);
>> +}
> 
> [...]
> 
> Only two minor comments, and v2 looks good to me. So, I run sparse and smatch
> to check this patch, and it reports two warnings:
> 
> 1. drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c:742 rtl8710bu_config_channel() error: uninitialized symbol 'sec_ch_above'.
> 
> This looks like a false-alarm, because 'sec_ch_above' must be set if 'ht40' is true.
> But, this should reference back much to know this. 
> Maybe, we can set 'sec_ch_above = 0' initially. 
> 

I will initialise it.

> 
> 2. drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c:1487 rtl8710bu_phy_iq_calibrate() error: uninitialized symbol 'reg_e94'.
> 
> This could be a false-alarm too. 'reg_e94' must be set if 'candidate >= 0', but
> original statement causes smatch hard to determine:
> 
>    if (reg_e94 && candidate >= 0)
> 
> swap the expressions to fix the warning:
> 
>   if (candidate >= 0 && reg_e94)
> 

Moving "if (reg_e94)" inside the previous "if (candidate >= 0)" should also
fix it, I think.

	if (candidate >= 0) {
		reg_e94 = result[candidate][0];
		reg_e9c = result[candidate][1];
		reg_ea4 = result[candidate][2];
		reg_eac = result[candidate][3];

		dev_dbg(dev, "%s: candidate is %x\n", __func__, candidate);
		dev_dbg(dev, "%s: e94=%x e9c=%x ea4=%x eac=%x\n",
			__func__, reg_e94, reg_e9c, reg_ea4, reg_eac);

		path_a_ok = true;

		if (reg_e94)
			rtl8xxxu_fill_iqk_matrix_a(priv, path_a_ok, result,
						   candidate, (reg_ea4 == 0));
	}

> 
> Ping-Ke
> 
> 

