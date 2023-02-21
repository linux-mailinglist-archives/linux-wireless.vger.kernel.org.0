Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C993869E7E2
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Feb 2023 19:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjBUSuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 13:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBUSuQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 13:50:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E152A17D
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 10:50:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b12so21160627edd.4
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 10:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLC/9kF1DqQ9l4xXuzoPfCO4YTCv5xfprbmyBxIcLc8=;
        b=pnJfvegNq5MtILzCF72/51jR1U0LR71XF668QqzkMr2KzbkLBwiOwcGZv0it8266vG
         5nbgfmyonI2RCaO2xEaTqMcmFPLxszpufPuFrjpWHMC+OEXn7PHwGZcxqdylW6ZqZGmP
         lhfyneXrUdKjnbn1RBzocdq/tlp0NAbRTwk/XGNS6CrGNxeDpIu/FmgazL7GQBIWM8dE
         XpHnUfX1Wwok3MEZIPWkjMo/gZh5UZ72O9b99bnpLIov6bEgcv1A957cbCwiDVH403Ys
         ccilWdrjaEApTP/Yyc+E4q7KhLARvtnsI8nDdRKcx92IAmbjU2XXcE3ueylW4T6m4ev9
         ddeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLC/9kF1DqQ9l4xXuzoPfCO4YTCv5xfprbmyBxIcLc8=;
        b=wPwPnm6JYt0XrYysXa5hAFd+wmLWm5l3TD8AU5uJDPaC3P3MJwBcAO13NJqZn8H02W
         iEQQVq1lTxqfpd+QyV5u3bgu6/ULYNNI6LRzDbakeynCZx1O2PaM/6Yyr+5ApB6gPDJL
         sWF2u7tw5SqJAhCxG0lFbfiY+jcCnDNTjuG19nTBumSfakJ+vAtKXPfERFtVy1MW5AaA
         1ayGSliRylHq6So19+ITq1ThcPaKzIHBKP8iy6PV4AHMVLff4EAgH2F8IutRWtYBR8u6
         +7olQJ4FOGNkmgB2Jqeuj6TWR6PaxXh3+llsgA9ISvQTljwC9kJpQ7WVcBKWtkbSG3th
         EgZA==
X-Gm-Message-State: AO0yUKUFgn9o63p/m1EVRhlLBvR+23nd5OorjIorCXWOHd4iOuAr/ttT
        KPcqyQFFAlwQLeK/6n4Mi7o=
X-Google-Smtp-Source: AK7set+UxyR5WeYX+2uiEJrGGGl7+XiZY+PIcAMn24Cch+kJIhz290t6u66L2c8tAt2WpRaZjSDVGg==
X-Received: by 2002:aa7:c6d7:0:b0:4ab:4676:f92f with SMTP id b23-20020aa7c6d7000000b004ab4676f92fmr4329949eds.37.1677005413189;
        Tue, 21 Feb 2023 10:50:13 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id u13-20020aa7d88d000000b004ab4c28a967sm2276411edq.44.2023.02.21.10.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 10:50:12 -0800 (PST)
Message-ID: <1de98de1-1c54-b6b1-b394-cafe8fa4d5f8@gmail.com>
Date:   Tue, 21 Feb 2023 20:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <5a9a264d-a59b-0d91-04f0-e5b38e6aaea0@gmail.com>
 <85c6facc8d0947e38668ed9b5f61bc48@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <85c6facc8d0947e38668ed9b5f61bc48@realtek.com>
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

On 21/02/2023 04:45, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Tuesday, February 21, 2023 12:11 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH] wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU
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
>> This was tested with a device from vendor SMIC with romver 1. It's
>> possible devices from vendor UMC and/or with romver 2 will fail to
>> upload the firmware. The vendor driver has that problem.
> 
> Can I know the version of vendor driver you use? 
> 
I have v5.2.20.2_28373.20180619 from here:
https://github.com/McMCCRU/rtl8188gu

Most likely it's a copy of Larry Finger's repo--with some fixes,
because the driver Larry Finger received from Realtek had some problems
(unrelated to the firmware upload issue).
https://github.com/lwfinger/rtl8188gu

>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/Kconfig |    2 +-
>>  .../net/wireless/realtek/rtl8xxxu/Makefile    |    2 +-
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  304 ++-
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |    2 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    4 +-
>>  .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         |    2 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         |    2 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         | 1942 +++++++++++++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         |    2 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |    2 +
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  181 +-
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   43 +
>>  12 files changed, 2435 insertions(+), 53 deletions(-)
>>  create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
>>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> index c8cee4a24755..2e5fa9479134 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> @@ -103,7 +103,8 @@ enum rtl8xxxu_rtl_chip {
>>         RTL8822B = 0x8822b,
>>         RTL8703B = 0x8703b,
>>         RTL8195A = 0x8195a,
>> -       RTL8188F = 0x8188f
>> +       RTL8188F = 0x8188f,
>> +       RTL8710B = 0x8710b
> 
> Add a trailing comma, and then you don't need to stir the last line when adding
> an new chip in the future.
> 
> [...]
> 
>>  struct rtl8xxxu_reg8val {
>>         u16 reg;
>>         u8 val;
>> @@ -1486,6 +1769,7 @@ struct rtl8xxxu_priv {
>>         struct rtl8723au_idx ht20_tx_power_diff[RTL8723B_TX_COUNT];
>>         struct rtl8723au_idx ht40_tx_power_diff[RTL8723B_TX_COUNT];
>>         struct rtl8xxxu_power_base *power_base;
>> +       u8 package_type;
>>         u32 chip_cut:4;
>>         u32 rom_rev:4;
>>         u32 is_multi_func:1;
>> @@ -1505,6 +1789,7 @@ struct rtl8xxxu_priv {
>>         u32 ep_tx_low_queue:1;
>>         u32 rx_buf_aggregation:1;
>>         u32 cck_agc_report_type:1;
>> +       u32 cck_new_agc:1;
>>         u8 default_crystal_cap;
>>         unsigned int pipe_interrupt;
>>         unsigned int pipe_in;
>> @@ -1523,6 +1808,8 @@ struct rtl8xxxu_priv {
>>
>>         struct mutex h2c_mutex;
>>
>> +       struct mutex syson_indirect_access_mutex;
>> +
> 
> I remember checkpatch will warn if you don't add a comment for mutex/lock.
> Though the naming is clear, just follow the rule.
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
>> new file mode 100644
>> index 000000000000..d80125157514
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
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
> Without a pair of brace, that looks a little odd to me, but the result should
> be correct.
> 
I think the rule is that we should not use braces when there is a single
line inside. I assumed that applies to do...while loops too.

> [...]
> 
>> +static int rtl8710bu_identify_chip(struct rtl8xxxu_priv *priv)
>> +{
>> +       struct device *dev = &priv->udev->dev;
>> +       u32 cfg0, cfg2, vendor;
>> +       u8 package_type = 0x7; /* a nonsense value */
>> +       int ret = 0;
> 
> No need '=0'. Even, don't need 'ret'. 
> Just return rtl8xxxu_config_endpoints_no_sie();
> 
> [...]
> 
>> +
>> +       ret = rtl8xxxu_config_endpoints_no_sie(priv);
>> +
>> +       return ret;
>> +}
>> +
>> +static void rtl8710b_revise_cck_tx_psf(struct rtl8xxxu_priv *priv, u8 channel)
>> +{
>> +       if (channel == 13) {
>> +               /* Normal values */
>> +               rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER2, 0x64B80C1C);
>> +               rtl8xxxu_write32(priv, REG_CCK0_DEBUG_PORT, 0x00008810);
>> +               rtl8xxxu_write32(priv, 0xaac, 0x01235667);
> 
> 0xaac is another TX filter, so
> #define REG_CCK0_TX_FILTER3		0x0aac
> 
>> +               /* Special value for channel 13 */
>> +               rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER1, 0xd1d80001);
>> +       } else if (channel == 14) {
>> +               /* Special values for channel 14 */
>> +               rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER2, 0x0000B81C);
>> +               rtl8xxxu_write32(priv, REG_CCK0_DEBUG_PORT, 0x00000000);
>> +               rtl8xxxu_write32(priv, 0xaac, 0x00003667);
>> +               /* Normal value */
>> +               rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER1, 0xE82C0001);
>> +       } else {
>> +               /* Restore normal values from the phy init table */
>> +               rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER2, 0x64B80C1C);
>> +               rtl8xxxu_write32(priv, REG_CCK0_DEBUG_PORT, 0x00008810);
>> +               rtl8xxxu_write32(priv, 0xaac, 0x01235667);
>> +               rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER1, 0xE82C0001);
>> +       }
>> +}
>> +
> 
> [...]
> 
>> +static int rtl8710b_read_efuse(struct rtl8xxxu_priv *priv)
>> +{
>> +       struct device *dev = &priv->udev->dev;
>> +       int i, ret = 0;
> 
> move these two downward to 'val32'. Declarations should be in reverse
> Xmas tree order.
> 
>> +       u8 val8, word_mask, header, extheader;
>> +       u16 efuse_addr, offset;
>> +       u32 val32;
>> +
>> +       val32 = rtl8710b_read_syson_reg(priv, REG_SYS_EEPROM_CTRL0_8710B);
>> +       priv->boot_eeprom = u32_get_bits(val32, EEPROM_BOOT);
>> +       priv->has_eeprom = u32_get_bits(val32, EEPROM_ENABLE);
>> +
> 
> [...]
> 
>> +static int rtl8710bu_active_to_lps(struct rtl8xxxu_priv *priv)
>> +{
>> +       struct device *dev = &priv->udev->dev;
>> +       u8 val8;
>> +       u16 val16;
>> +       u32 val32;
>> +       int retry, retval;
>> +
>> +       /* Tx Pause */
>> +       rtl8xxxu_write8(priv, REG_TXPAUSE, 0xff);
>> +
>> +       retry = 100;
>> +       retval = -EBUSY;
>> +       /*
>> +        * Poll 32 bit wide REG_SCH_TX_CMD for 0x00000000 to ensure no TX is pending.
>> +        */
>> +       do {
>> +               val32 = rtl8xxxu_read32(priv, REG_SCH_TX_CMD);
>> +               if (!val32) {
>> +                       retval = 0;
>> +                       break;
>> +               }
>> +               udelay(10);
>> +       } while (retry--);
>> +
>> +       if (!retry) {
>> +               dev_warn(dev, "Failed to flush TX queue\n");
>> +               retval = -EBUSY;
>> +               return retval;
>> +       }
>> +
>> +       /* Disable CCK and OFDM, clock gated */
>> +       val8 = rtl8xxxu_read8(priv, 0x02);
>> +       val8 &= ~BIT(0);
>> +       rtl8xxxu_write8(priv, 0x02, val8);
> 
> rtl8xxxu has already defined these:
> 
> #define REG_SYS_FUNC			0x0002
> #define  SYS_FUNC_BBRSTB		BIT(0)
> #define  SYS_FUNC_BB_GLB_RSTN		BIT(1)
> >> +
>> +       udelay(2);
>> +
>> +       /*Whole BB is reset*/
>> +       val8 = rtl8xxxu_read8(priv, 0x02);
>> +       val8 &= ~BIT(1);
>> +       rtl8xxxu_write8(priv, 0x02, val8);
>> +
>> +       /* Reset MAC TRX */
>> +       val16 = rtl8xxxu_read16(priv, REG_CR);
>> +       val16 &= 0xff00;
>> +       val16 |= CR_HCI_RXDMA_ENABLE | CR_HCI_TXDMA_ENABLE;
>> +       val16 &= ~CR_SECURITY_ENABLE;
>> +       rtl8xxxu_write16(priv, REG_CR, val16);
>> +
>> +       /*Respond TxOK to scheduler*/
>> +       val8 = rtl8xxxu_read8(priv, REG_DUAL_TSF_RST);
>> +       val8 |= DUAL_TSF_TX_OK;
>> +       rtl8xxxu_write8(priv, REG_DUAL_TSF_RST, val8);
>> +
>> +       return retval;
>> +}
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 620a5cc2bfdd..e223ef852899 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> 
> [...]
> 
>> @@ -1904,41 +1929,54 @@ static int rtl8xxxu_download_firmware(struct rtl8xxxu_priv *priv)
>>  {
>>         int pages, remainder, i, ret;
>>         u8 val8;
>> -       u16 val16;
>> +       u16 val16, reg_mcu_fw_dl;
> 
> nit: define reg_mcu_fw_dl separately 
> 
>>         u32 val32;
>>         u8 *fwptr;
>>
>> -       val8 = rtl8xxxu_read8(priv, REG_SYS_FUNC + 1);
>> -       val8 |= 4;
>> -       rtl8xxxu_write8(priv, REG_SYS_FUNC + 1, val8);
>> +       if (priv->rtl_chip == RTL8710B) {
>> +               reg_mcu_fw_dl = REG_8051FW_CTRL_V1_8710B;
>> +       } else {
>> +               reg_mcu_fw_dl = REG_MCU_FW_DL;
>>
> 
> [...]
> 
> Only some small suggestions.
> Thanks for this nice work. 
> 
> Ping-Ke
> 
Thank you for your review. I'll make the changes.
