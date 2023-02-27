Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662066A41B2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 13:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjB0MbL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 07:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0MbK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 07:31:10 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE3B1DB87
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 04:31:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f13so25069705edz.6
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 04:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4ChK6qsG9qf9pdVBpoW1GNYrUF2g2qzj0Ci3Y8MPJE=;
        b=Jko7vCh49bfiHu6H/QUj9ItSDjuqzDwWdaqyZytpTWBeCeO1XjQ8B1jiJK0cqK6uwe
         EvBfBsqjdBa2hRaxN1DZIoE7tNXEX1xk0rGIf85yxrgpE1ifhIyL+uPByRts4NPMy/4G
         TwOMjLoBbYOyThS3/qUq8homy3hAvKraOZh18BzCns7488FUxmb6ce3pHuceqLDzqqGo
         kMuuvSo9NqKv3FDGk1tNimWNtYYqqpZD/85PkCA4sWflt+dXPwrDsVb3iJA9ARSFEi9l
         svshryGAQ1sB6w0Q9ZfjAGoMsxOGtjS5nZp/uUU0vkVeit7Z5euq3ydH+3XD+JBRvGt8
         GIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4ChK6qsG9qf9pdVBpoW1GNYrUF2g2qzj0Ci3Y8MPJE=;
        b=M1VnCbPSItyRkKckjTXCh1ukldoF0QRZFazX0dVyXpAvqoZei1SylRxpgvCUTzTqSf
         ydtVOEJI/1KiyQ9ubUE5vNiM8fNBvbBmhuiMmqWSXaw4adDn9m9eEsg6pjMEjOkyJYzs
         jw9Idnfg1qo5a8qH1aXf5cmkL1/D5ymK39fGOqMsyv8oKzLaTbm69VbV1N6JeRvCUZld
         2ud69L5fD9Pg0mgN+/QF6WOBG1IyLF4lMIh/voWR4C6t9jnLZA1YKrvSEzGqFw5g0WWC
         1LiEXLpwYOrXPO2JEES7bFmhMhgWJfUUxGci/7nM7b9IT14RIbn/jjSRBaYPeeAMuigX
         oaCA==
X-Gm-Message-State: AO0yUKUqniv+jOXy5Y6za/c/eW4SzbQFp6MNIn+SrxgsVZgAypDZeEJ2
        roseEohDg62wPz+gRSnZ2JPH5rgkM9M=
X-Google-Smtp-Source: AK7set8PU8rwQfhmLAxmXRNiBTk5Om9uNkWdaIaDfqJ8dfUwH3Eag4eC24TbbkX/9ZRbWZ3xITVL0w==
X-Received: by 2002:aa7:d3c8:0:b0:4af:6e95:72b4 with SMTP id o8-20020aa7d3c8000000b004af6e9572b4mr13430781edr.15.1677501067184;
        Mon, 27 Feb 2023 04:31:07 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id u30-20020a50d51e000000b004af58e57db5sm3078515edi.5.2023.02.27.04.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 04:31:06 -0800 (PST)
Message-ID: <b8e6be05-b70c-a8a2-291f-c148145b9643@gmail.com>
Date:   Mon, 27 Feb 2023 14:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU
To:     Jiajie Chen <c@jia.je>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <5a9a264d-a59b-0d91-04f0-e5b38e6aaea0@gmail.com>
 <39b1a27a-9514-a0ed-6bca-3ccd620c8b33@jia.je>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <39b1a27a-9514-a0ed-6bca-3ccd620c8b33@jia.je>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 27/02/2023 11:18, Jiajie Chen wrote:
> Nice job, tested with three USB dongles with RTL8188GU chipset. Comments below.
> 

Cool! Are the chips made by UMC or SMIC? See this line in dmesg:
usb 1-2: RTL8710BU rev A (SMIC) romver 1, 1T1R, TX queues 3, WiFi=1, BT=0, GPS=0, HI PA=0

> On 2023/2/21 00:10, Bitterblue Smith wrote:
>> This chip is found in cheap "free driver" USB adapters from Aliexpress.
>> Initially they pretend to be a CD-ROM containing the driver for Windows.
>> "Ejecting" switches the device to wifi mode.
>>
>> Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.
>>
>> This chip is more unique than other Realtek chips:
>>
>> * The registers at addresses 0x0-0xff, which all the other chips use,
>>    can't be used here. New registers at 0x8000-0x80ff must be used
>>    instead. And it's not a simple matter of adding 0x8000: 0x2
>>    (REG_SYS_FUNC) became 0x8004, 0x80 (REG_MCU_FW_DL) became 0x8090,
>>    etc.
>>
>> * Also there are a few new registers which must be accessed indirectly
>>    because their addresses don't fit in 16 bits. No other chips seem to
>>    have these.
>>
>> * The vendor driver compiles to 8188gu.ko, but the code calls the chip
>>    RTL8710B(U) pretty much everywhere, including messages visible to the
>>    user.
>>
>> Another difference compared to the other chips supported by rtl8xxxu is
>> that it has a new PHY status struct, or three of them actually, from
>> which we extract the RSSI, among other things. This is not unique,
>> though, just new. The chips supported by rtw88 also use it.
>>
>> This was tested with a device from vendor SMIC with romver 1. It's
>> possible devices from vendor UMC and/or with romver 2 will fail to
>> upload the firmware. The vendor driver has that problem.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>   drivers/net/wireless/realtek/rtl8xxxu/Kconfig |    2 +-
>>   .../net/wireless/realtek/rtl8xxxu/Makefile    |    2 +-
>>   .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  304 ++-
>>   .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |    2 +
>>   .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    4 +-
>>   .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         |    2 +
>>   .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         |    2 +
>>   .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         | 1942 +++++++++++++++++
>>   .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         |    2 +
>>   .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |    2 +
>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  181 +-
>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   43 +
>>   12 files changed, 2435 insertions(+), 53 deletions(-)
>>   create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
>>
> [...]
> 
>> +static void rtl8710b_indirect_write32(struct rtl8xxxu_priv *priv, u32 addr, u32 val)
>> +{
>> +    struct device *dev = &priv->udev->dev;
>> +    u8 polling_count = 0xff;
>> +    u32 val32;
>> +
>> +    if (addr & 3) {
>> +        dev_warn(dev, "%s: Aborting because 0x%x is not a multiple of 4.\n",
>> +             __func__, addr);
>> +        return;
>> +    }
>> +
>> +    mutex_lock(&priv->syson_indirect_access_mutex);
>> +
>> +    rtl8xxxu_write32(priv, REG_USB_HOST_INDIRECT_ADDR_8710B, addr);
>> +    rtl8xxxu_write32(priv, REG_USB_HOST_INDIRECT_DATA_8710B, val);
>> +    rtl8xxxu_write32(priv, REG_EFUSE_INDIRECT_CTRL_8710B, NORMAL_REG_WRITE_OFFSET);
>> +
>> +    do
>> +        val32 = rtl8xxxu_read32(priv, REG_EFUSE_INDIRECT_CTRL_8710B);
>> +    while ((val32 & BIT(31)) && (--polling_count > 0));
>> +
>> +    if (polling_count == 0)
>> +        dev_warn(dev, "%s: Failed to write 0x%x to 0x%x, 0x806c = 0x%x\n",
>> +             __func__, val, addr, val32);
>> +
>> +    mutex_unlock(&priv->syson_indirect_access_mutex);
>> +
>> +    if (rtl8xxxu_debug & RTL8XXXU_DEBUG_REG_WRITE)
>> +        dev_info(dev, "%s(%04x) = 0x%08x\n", __func__, addr, val);
>> +}
>> +
>> +static u32 rtl8710b_read_syson_reg(struct rtl8xxxu_priv *priv, u32 addr)
>> +{
>> +    return rtl8710b_indirect_read32(priv, addr | SYSON_REG_BASE_ADDR_8710B);
>> +}
>> +
>> +static void rtl8710b_write_syson_reg(struct rtl8xxxu_priv *priv, u32 addr, u32 val)
>> +{
>> +    rtl8710b_indirect_write32(priv, addr | SYSON_REG_BASE_ADDR_8710B, val);
>> +}
>> +
>> +static int rtl8710b_read_efuse8(struct rtl8xxxu_priv *priv, u16 offset, u8 *data)
>> +{
>> +    int i;
>> +    u32 val32;
>> +
>> +    /* Write Address */
>> +    rtl8xxxu_write32(priv, REG_USB_HOST_INDIRECT_ADDR_8710B, offset);
>> +
> 
> Isn't it required to lock 'priv->syson_indirect_access_mutex' here?
> 

Probably not. This function is called only from rtl8710bu_identify_chip()
and rtl8710b_read_efuse(), and they are only called from rtl8xxxu_probe().
rtl8710b_read_syson_reg() and rtl8710b_write_syson_reg() are only called
after rtl8xxxu_probe() returns.

>> +    rtl8xxxu_write32(priv, REG_EFUSE_INDIRECT_CTRL_8710B, EFUSE_READ_OFFSET);
>> +
>> +    /* Poll for data read */
>> +    val32 = rtl8xxxu_read32(priv, REG_EFUSE_INDIRECT_CTRL_8710B);
>> +    for (i = 0; i < RTL8XXXU_MAX_REG_POLL; i++) {
>> +        val32 = rtl8xxxu_read32(priv, REG_EFUSE_INDIRECT_CTRL_8710B);
>> +        if (!(val32 & BIT(31)))
>> +            break;
>> +    }
>> +
>> +    if (i == RTL8XXXU_MAX_REG_POLL)
>> +        return -EIO;
>> +
>> +    val32 = rtl8xxxu_read32(priv, REG_USB_HOST_INDIRECT_DATA_8710B);
>> +
>> +    *data = val32 & 0xff;
>> +    return 0;
>> +}
>> +
>> +#define EEPROM_PACKAGE_TYPE_8710B    0xF8
>> +#define PACKAGE_QFN48M_U        0xee
>> +#define PACKAGE_QFN48M_S        0xfe
>> +
> [...]
>> +static int rtl8710bu_active_to_lps(struct rtl8xxxu_priv *priv)
>> +{
>> +    struct device *dev = &priv->udev->dev;
>> +    u8 val8;
>> +    u16 val16;
>> +    u32 val32;
>> +    int retry, retval;
>> +
>> +    /* Tx Pause */
>> +    rtl8xxxu_write8(priv, REG_TXPAUSE, 0xff);
>> +
>> +    retry = 100;
>> +    retval = -EBUSY;
>> +    /*
>> +     * Poll 32 bit wide REG_SCH_TX_CMD for 0x00000000 to ensure no TX is pending.
>> +     */
>> +    do {
>> +        val32 = rtl8xxxu_read32(priv, REG_SCH_TX_CMD);
>> +        if (!val32) {
>> +            retval = 0;
>> +            break;
>> +        }
>> +        udelay(10);
>> +    } while (retry--);
>> +
>> +    if (!retry) {
>> +        dev_warn(dev, "Failed to flush TX queue\n");
>> +        retval = -EBUSY;
>> +        return retval;
>> +    }
>> +
>> +    /* Disable CCK and OFDM, clock gated */
>> +    val8 = rtl8xxxu_read8(priv, 0x02);
>> +    val8 &= ~BIT(0);
>> +    rtl8xxxu_write8(priv, 0x02, val8);
>> +
>> +    udelay(2);
>> +
>> +    /*Whole BB is reset*/
> 
> There are missing spaces between "/*" and "Whole", "reset" and "*/".
> 

Right. I'll fix that.

>> +    val8 = rtl8xxxu_read8(priv, 0x02);
>> +    val8 &= ~BIT(1);
>> +    rtl8xxxu_write8(priv, 0x02, val8);
>> +
>> +    /* Reset MAC TRX */
>> +    val16 = rtl8xxxu_read16(priv, REG_CR);
>> +    val16 &= 0xff00;
>> +    val16 |= CR_HCI_RXDMA_ENABLE | CR_HCI_TXDMA_ENABLE;
>> +    val16 &= ~CR_SECURITY_ENABLE;
>> +    rtl8xxxu_write16(priv, REG_CR, val16);
>> +
>> +    /*Respond TxOK to scheduler*/
> 
> Same here.
> 
>> +    val8 = rtl8xxxu_read8(priv, REG_DUAL_TSF_RST);
>> +    val8 |= DUAL_TSF_TX_OK;
>> +    rtl8xxxu_write8(priv, REG_DUAL_TSF_RST, val8);
>> +
>> +    return retval;
>> +}
>> +

