Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CBD6A3E30
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 10:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjB0JVS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 04:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjB0JVE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 04:21:04 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A906CC3C
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 01:18:09 -0800 (PST)
Received: (Authenticated sender: c@jia.je)
        by mail.gandi.net (Postfix) with ESMTPSA id D5C5BE0016;
        Mon, 27 Feb 2023 09:18:05 +0000 (UTC)
Message-ID: <39b1a27a-9514-a0ed-6bca-3ccd620c8b33@jia.je>
Date:   Mon, 27 Feb 2023 17:18:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU
Content-Language: en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <5a9a264d-a59b-0d91-04f0-e5b38e6aaea0@gmail.com>
From:   Jiajie Chen <c@jia.je>
In-Reply-To: <5a9a264d-a59b-0d91-04f0-e5b38e6aaea0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nice job, tested with three USB dongles with RTL8188GU chipset. Comments 
below.

On 2023/2/21 00:10, Bitterblue Smith wrote:
> This chip is found in cheap "free driver" USB adapters from Aliexpress.
> Initially they pretend to be a CD-ROM containing the driver for Windows.
> "Ejecting" switches the device to wifi mode.
>
> Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.
>
> This chip is more unique than other Realtek chips:
>
> * The registers at addresses 0x0-0xff, which all the other chips use,
>    can't be used here. New registers at 0x8000-0x80ff must be used
>    instead. And it's not a simple matter of adding 0x8000: 0x2
>    (REG_SYS_FUNC) became 0x8004, 0x80 (REG_MCU_FW_DL) became 0x8090,
>    etc.
>
> * Also there are a few new registers which must be accessed indirectly
>    because their addresses don't fit in 16 bits. No other chips seem to
>    have these.
>
> * The vendor driver compiles to 8188gu.ko, but the code calls the chip
>    RTL8710B(U) pretty much everywhere, including messages visible to the
>    user.
>
> Another difference compared to the other chips supported by rtl8xxxu is
> that it has a new PHY status struct, or three of them actually, from
> which we extract the RSSI, among other things. This is not unique,
> though, just new. The chips supported by rtw88 also use it.
>
> This was tested with a device from vendor SMIC with romver 1. It's
> possible devices from vendor UMC and/or with romver 2 will fail to
> upload the firmware. The vendor driver has that problem.
>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
>   drivers/net/wireless/realtek/rtl8xxxu/Kconfig |    2 +-
>   .../net/wireless/realtek/rtl8xxxu/Makefile    |    2 +-
>   .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  304 ++-
>   .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |    2 +
>   .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    4 +-
>   .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         |    2 +
>   .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         |    2 +
>   .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         | 1942 +++++++++++++++++
>   .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         |    2 +
>   .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |    2 +
>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  181 +-
>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   43 +
>   12 files changed, 2435 insertions(+), 53 deletions(-)
>   create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
>
[...]

> +static void rtl8710b_indirect_write32(struct rtl8xxxu_priv *priv, u32 addr, u32 val)
> +{
> +	struct device *dev = &priv->udev->dev;
> +	u8 polling_count = 0xff;
> +	u32 val32;
> +
> +	if (addr & 3) {
> +		dev_warn(dev, "%s: Aborting because 0x%x is not a multiple of 4.\n",
> +			 __func__, addr);
> +		return;
> +	}
> +
> +	mutex_lock(&priv->syson_indirect_access_mutex);
> +
> +	rtl8xxxu_write32(priv, REG_USB_HOST_INDIRECT_ADDR_8710B, addr);
> +	rtl8xxxu_write32(priv, REG_USB_HOST_INDIRECT_DATA_8710B, val);
> +	rtl8xxxu_write32(priv, REG_EFUSE_INDIRECT_CTRL_8710B, NORMAL_REG_WRITE_OFFSET);
> +
> +	do
> +		val32 = rtl8xxxu_read32(priv, REG_EFUSE_INDIRECT_CTRL_8710B);
> +	while ((val32 & BIT(31)) && (--polling_count > 0));
> +
> +	if (polling_count == 0)
> +		dev_warn(dev, "%s: Failed to write 0x%x to 0x%x, 0x806c = 0x%x\n",
> +			 __func__, val, addr, val32);
> +
> +	mutex_unlock(&priv->syson_indirect_access_mutex);
> +
> +	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_REG_WRITE)
> +		dev_info(dev, "%s(%04x) = 0x%08x\n", __func__, addr, val);
> +}
> +
> +static u32 rtl8710b_read_syson_reg(struct rtl8xxxu_priv *priv, u32 addr)
> +{
> +	return rtl8710b_indirect_read32(priv, addr | SYSON_REG_BASE_ADDR_8710B);
> +}
> +
> +static void rtl8710b_write_syson_reg(struct rtl8xxxu_priv *priv, u32 addr, u32 val)
> +{
> +	rtl8710b_indirect_write32(priv, addr | SYSON_REG_BASE_ADDR_8710B, val);
> +}
> +
> +static int rtl8710b_read_efuse8(struct rtl8xxxu_priv *priv, u16 offset, u8 *data)
> +{
> +	int i;
> +	u32 val32;
> +
> +	/* Write Address */
> +	rtl8xxxu_write32(priv, REG_USB_HOST_INDIRECT_ADDR_8710B, offset);
> +

Isn't it required to lock 'priv->syson_indirect_access_mutex' here?

> +	rtl8xxxu_write32(priv, REG_EFUSE_INDIRECT_CTRL_8710B, EFUSE_READ_OFFSET);
> +
> +	/* Poll for data read */
> +	val32 = rtl8xxxu_read32(priv, REG_EFUSE_INDIRECT_CTRL_8710B);
> +	for (i = 0; i < RTL8XXXU_MAX_REG_POLL; i++) {
> +		val32 = rtl8xxxu_read32(priv, REG_EFUSE_INDIRECT_CTRL_8710B);
> +		if (!(val32 & BIT(31)))
> +			break;
> +	}
> +
> +	if (i == RTL8XXXU_MAX_REG_POLL)
> +		return -EIO;
> +
> +	val32 = rtl8xxxu_read32(priv, REG_USB_HOST_INDIRECT_DATA_8710B);
> +
> +	*data = val32 & 0xff;
> +	return 0;
> +}
> +
> +#define EEPROM_PACKAGE_TYPE_8710B	0xF8
> +#define PACKAGE_QFN48M_U		0xee
> +#define PACKAGE_QFN48M_S		0xfe
> +
[...]
> +static int rtl8710bu_active_to_lps(struct rtl8xxxu_priv *priv)
> +{
> +	struct device *dev = &priv->udev->dev;
> +	u8 val8;
> +	u16 val16;
> +	u32 val32;
> +	int retry, retval;
> +
> +	/* Tx Pause */
> +	rtl8xxxu_write8(priv, REG_TXPAUSE, 0xff);
> +
> +	retry = 100;
> +	retval = -EBUSY;
> +	/*
> +	 * Poll 32 bit wide REG_SCH_TX_CMD for 0x00000000 to ensure no TX is pending.
> +	 */
> +	do {
> +		val32 = rtl8xxxu_read32(priv, REG_SCH_TX_CMD);
> +		if (!val32) {
> +			retval = 0;
> +			break;
> +		}
> +		udelay(10);
> +	} while (retry--);
> +
> +	if (!retry) {
> +		dev_warn(dev, "Failed to flush TX queue\n");
> +		retval = -EBUSY;
> +		return retval;
> +	}
> +
> +	/* Disable CCK and OFDM, clock gated */
> +	val8 = rtl8xxxu_read8(priv, 0x02);
> +	val8 &= ~BIT(0);
> +	rtl8xxxu_write8(priv, 0x02, val8);
> +
> +	udelay(2);
> +
> +	/*Whole BB is reset*/

There are missing spaces between "/*" and "Whole", "reset" and "*/".

> +	val8 = rtl8xxxu_read8(priv, 0x02);
> +	val8 &= ~BIT(1);
> +	rtl8xxxu_write8(priv, 0x02, val8);
> +
> +	/* Reset MAC TRX */
> +	val16 = rtl8xxxu_read16(priv, REG_CR);
> +	val16 &= 0xff00;
> +	val16 |= CR_HCI_RXDMA_ENABLE | CR_HCI_TXDMA_ENABLE;
> +	val16 &= ~CR_SECURITY_ENABLE;
> +	rtl8xxxu_write16(priv, REG_CR, val16);
> +
> +	/*Respond TxOK to scheduler*/

Same here.

> +	val8 = rtl8xxxu_read8(priv, REG_DUAL_TSF_RST);
> +	val8 |= DUAL_TSF_TX_OK;
> +	rtl8xxxu_write8(priv, REG_DUAL_TSF_RST, val8);
> +
> +	return retval;
> +}
> +
