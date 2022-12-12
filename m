Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43564A64C
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Dec 2022 18:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiLLRx3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 12:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiLLRxO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 12:53:14 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03A025F3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 09:53:12 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id x22so30047230ejs.11
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTcKFBOQf5bqEoIge80Xv7kBDx1OD8UXl5wQSn9Spdc=;
        b=FD/uwTjdGYDrFcgfXlA/Ojc2RKoa5HwzVNKQzRchi1s4YBhAs4S9wWwqyr1zRucpOu
         prh8vjcLiaoijEePAlUEA27hq5OyWnAtI8auapdQzP3U6hYYwBMlUakqwG51MEqwLyv1
         D00SGkRrvav4ozn/zwjlOqfXLjP9NDFp8LqXFssSAH4HjgF6pKQre1ByJF0Wav6Rej0H
         1DXZmco2950eRPuxZ7ZOa4KMHlM0V+qaTCViEe8kjYWL2nSiCjTEWM5nVU56bLnIYqsc
         Wnu1CqfDjsqU8chacbwYzvdXu4BJSjIsSTJZUF9JJjCaIGWfB0RBZcTh0+/WdMBvy5r6
         G4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTcKFBOQf5bqEoIge80Xv7kBDx1OD8UXl5wQSn9Spdc=;
        b=IPvpvkurZq3ujX79mniom5AA/ZJBMMkyYS4V4V50wNdWvQsyLv+tlBAWvpmpYom1tQ
         15OBCs/UHz7dbT+FBdIJ1v/YpospC8Uzo9O9deBZmExKw29fLT1br155hw7sZ4nw7SJb
         YINUR4wWaVRqfWYTEnu7Iuocg5IeWZmAKogbkYKAmDOFazJHELPI7/DjXmEQrogrmBUM
         0MXOmi34H3N4vjTRoVDNhzQc1j1mPMtGEIJDoDq8p4d4+3vVeCC4H4crFoeoKkzVCmPU
         PSR7YgZvlUrsN0rRv2hVUMqgewL6MxSgR1ADLo+OVjQvDBNj1d/JeXam2j8X9B4dblzL
         RSVw==
X-Gm-Message-State: ANoB5plNApVfuijOyFJvgMffpL76JkP2thKPhrVxmATJkzhVS5PV2Rhz
        B4FjSkFGpdQ7ZukrAXLIueI=
X-Google-Smtp-Source: AA0mqf575q0r14IKz8OXfCriae5XcwxJGIZg4Rp1zhhxPYHc/E8juC/7mET9SEsX3vWq3lveSq2v3Q==
X-Received: by 2002:a17:907:d049:b0:7c1:5467:39af with SMTP id vb9-20020a170907d04900b007c1546739afmr9154719ejc.37.1670867590849;
        Mon, 12 Dec 2022 09:53:10 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b007c0efbaa8a0sm3596868ejb.4.2022.12.12.09.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 09:53:10 -0800 (PST)
Message-ID: <a286553a-8c0e-d229-b8c8-8482e4ac9e6e@gmail.com>
Date:   Mon, 12 Dec 2022 19:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: Support new chip RTL8188EU
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
References: <00c4bd4a-10e0-02e6-4e09-f450909414ac@gmail.com>
 <a0491750eb3f4c22ac3479c3501586c9@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <a0491750eb3f4c22ac3479c3501586c9@realtek.com>
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

On 09/12/2022 09:39, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Wednesday, December 7, 2022 5:44 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>; Andrea Merello
>> <andrea.merello@gmail.com>; Taehee Yoo <ap420073@gmail.com>
>> Subject: [PATCH 1/2] wifi: rtl8xxxu: Support new chip RTL8188EU
>>
>> From: Jes Sorensen <Jes.Sorensen@gmail.com>
>>
>> This chip is found in cheap USB devices from TP-Link, D-Link, etc.
>>
>> Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.
>>
>> Chip versions older than "I cut" need software rate control. That will
>> be in the next commit. Until then MCS7 is used for all data frames.
>>
>> The "I cut" chips are not supported. They require different firmware
>> and initialisation tables. Support can be added if someone has the
>> hardware to test it.
>>
>> Co-developed-by: Andrea Merello <andrea.merello@gmail.com>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> Co-developed-by: Taehee Yoo <ap420073@gmail.com>
>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>> Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>
>> Co-developed-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> So this patch is 52 of the 57 patches found here, squashed together:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git/log/drivers/net/wireless/realtek/rtl8xxx
>> u?h=rtl8xxxu-8188eu
>>
>> Starting from c3f84ded6f76 ("rtl8xxxu: Accept firmware signature 0x88e0")
>> up to a9b05c059510 ("rtl8xxxu: Add rpt_sel entry to struct rtl8xxxu_rxdesc16").
>>
>> These patches were not needed:
>> 3170622ccb61 ("rtl8xxxu: Detect 8188eu parts correctly")
>> 8fb5bc92bce0 ("rtl8xxxu: Initialize GPIO settings for 8188eu")
>> 6ab646adb585 ("rtl8xxxu: Implement rtl8188e_set_tx_power()")
>> 2ccd1f1fc480 ("rtl8xxxu: properly detect RTL8188EU devices")
>> 809a2e000cab ("rtl8xxxu: Do not set auto rate fallback on 8188eu")
>>
>> On top of that, I made various changes required for today's kernel,
>> plus changes to match the newer vendor driver more closely, plus some
>> bug fixes.
>> ---
>>  .../net/wireless/realtek/rtl8xxxu/Makefile    |    3 +-
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   67 +-
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         | 1298 +++++++++++++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    4 +-
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  201 ++-
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   40 +-
>>  6 files changed, 1589 insertions(+), 24 deletions(-)
>>  create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> index d26df4095da0..27bd07d24889 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> @@ -36,6 +36,7 @@
>>
> 
> [...]
> 
>>
>> +struct rtl8188eu_efuse {
>> +	__le16 rtl_id;
>> +	u8 res0[0x0e];
>> +	struct rtl8192eu_efuse_tx_power tx_power_index_A;	/* 0x10 */
>> +	u8 res1[0x7e];			/* 0x3a */
>> +	u8 channel_plan;		/* 0xb8 */
>> +	u8 xtal_k;
>> +	u8 thermal_meter;
>> +	u8 iqk_lck;
>> +	u8 res2[5];
>> +	u8 rf_board_option;
>> +	u8 rf_feature_option;
>> +	u8 rf_bt_setting;
>> +	u8 eeprom_version;
>> +	u8 eeprom_customer_id;
>> +	u8 res3[3];
>> +	u8 rf_antenna_option;		/* 0xc9 */
>> +	u8 res4[6];
>> +	u8 vid;				/* 0xd0 */
>> +	u8 res5[1];
>> +	u8 pid;				/* 0xd2 */
>> +	u8 res6[1];
>> +	u8 usb_optional_function;
>> +	u8 res7[2];
>> +	u8 mac_addr[ETH_ALEN];		/* 0xd7 */
>> +	u8 res8[2];
>> +	u8 vendor_name[7];
>> +	u8 res9[2];
>> +	u8 device_name[0x0b];		/* 0xe8 */
>> +	u8 res10[2];
>> +	u8 serial[0x0b];		/* 0xf5 */
>> +	u8 res11[0x30];
>> +	u8 unknown[0x0d];		/* 0x130 */
>> +	u8 res12[0xc3];
>> +};
>> +
> 
> This is efuse layout, so it needs  __packed.
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>> new file mode 100644
>> index 000000000000..9eb9ae03ca81
>> --- /dev/null
> 
> [...]
> 
>> +static void rtl8188eu_config_channel(struct ieee80211_hw *hw)
>> +{
>> +	struct rtl8xxxu_priv *priv = hw->priv;
>> +	u32 val32, rsr;
>> +	u8 opmode;
>> +	bool ht = true;
>> +	int sec_ch_above, channel;
>> +	int i;
>> +
>> +	opmode = rtl8xxxu_read8(priv, REG_BW_OPMODE);
>> +	rsr = rtl8xxxu_read32(priv, REG_RESPONSE_RATE_SET);
>> +	channel = hw->conf.chandef.chan->hw_value;
>> +
>> +	switch (hw->conf.chandef.width) {
>> +	case NL80211_CHAN_WIDTH_20_NOHT:
>> +		ht = false;
>> +		fallthrough;
>> +	case NL80211_CHAN_WIDTH_20:
>> +		opmode |= BW_OPMODE_20MHZ;
>> +		rtl8xxxu_write8(priv, REG_BW_OPMODE, opmode);
>> +
>> +		val32 = rtl8xxxu_read32(priv, REG_FPGA0_RF_MODE);
>> +		val32 &= ~FPGA_RF_MODE;
>> +		rtl8xxxu_write32(priv, REG_FPGA0_RF_MODE, val32);
>> +
>> +		val32 = rtl8xxxu_read32(priv, REG_FPGA1_RF_MODE);
>> +		val32 &= ~FPGA_RF_MODE;
>> +		rtl8xxxu_write32(priv, REG_FPGA1_RF_MODE, val32);
>> +		break;
>> +	case NL80211_CHAN_WIDTH_40:
>> +		if (hw->conf.chandef.center_freq1 >
>> +		    hw->conf.chandef.chan->center_freq) {
>> +			sec_ch_above = 1;
>> +			channel += 2;
>> +		} else {
>> +			sec_ch_above = 0;
>> +			channel -= 2;
>> +		}
>> +
>> +		opmode &= ~BW_OPMODE_20MHZ;
>> +		rtl8xxxu_write8(priv, REG_BW_OPMODE, opmode);
>> +		rsr &= ~RSR_RSC_BANDWIDTH_40M;
>> +		if (sec_ch_above)
>> +			rsr |= RSR_RSC_LOWER_SUB_CHANNEL;
>> +		else
>> +			rsr |= RSR_RSC_UPPER_SUB_CHANNEL;
>> +		rtl8xxxu_write32(priv, REG_RESPONSE_RATE_SET, rsr);
>> +
>> +		val32 = rtl8xxxu_read32(priv, REG_FPGA0_RF_MODE);
>> +		val32 |= FPGA_RF_MODE;
>> +		rtl8xxxu_write32(priv, REG_FPGA0_RF_MODE, val32);
>> +
>> +		val32 = rtl8xxxu_read32(priv, REG_FPGA1_RF_MODE);
>> +		val32 |= FPGA_RF_MODE;
>> +		rtl8xxxu_write32(priv, REG_FPGA1_RF_MODE, val32);
>> +
>> +		/*
>> +		 * Set Control channel to upper or lower. These settings
>> +		 * are required only for 40MHz
>> +		 */
>> +		val32 = rtl8xxxu_read32(priv, REG_CCK0_SYSTEM);
>> +		val32 &= ~CCK0_SIDEBAND;
>> +		if (!sec_ch_above)
>> +			val32 |= CCK0_SIDEBAND;
>> +		rtl8xxxu_write32(priv, REG_CCK0_SYSTEM, val32);
>> +
>> +		val32 = rtl8xxxu_read32(priv, REG_OFDM1_LSTF);
>> +		val32 &= ~OFDM_LSTF_PRIME_CH_MASK; /* 0xc00 */
>> +		if (sec_ch_above)
>> +			val32 |= OFDM_LSTF_PRIME_CH_LOW;
>> +		else
>> +			val32 |= OFDM_LSTF_PRIME_CH_HIGH;
>> +		rtl8xxxu_write32(priv, REG_OFDM1_LSTF, val32);
>> +
>> +		val32 = rtl8xxxu_read32(priv, REG_FPGA0_POWER_SAVE);
>> +		val32 &= ~(FPGA0_PS_LOWER_CHANNEL | FPGA0_PS_UPPER_CHANNEL);
>> +		if (sec_ch_above)
>> +			val32 |= FPGA0_PS_UPPER_CHANNEL;
>> +		else
>> +			val32 |= FPGA0_PS_LOWER_CHANNEL;
>> +		rtl8xxxu_write32(priv, REG_FPGA0_POWER_SAVE, val32);
>> +		break;
>> +
>> +	default:
>> +		break;
>> +	}
>> +
>> +	for (i = RF_A; i < priv->rf_paths; i++) {
>> +		val32 = rtl8xxxu_read_rfreg(priv, i, RF6052_REG_MODE_AG);
>> +		val32 &= ~MODE_AG_CHANNEL_MASK;
>> +		val32 |= channel;
> 
> nit:
> 
> val32 = u32_replace_bits(val32, channel, MODE_AG_CHANNEL_MASK);
> 
> or
> 
> u32p_replace_bits(&val32, channel, MODE_AG_CHANNEL_MASK);
> 
> There are some similar changes nearby. If you want this, you can modify them as well.
> 
I changed this one, but the others are not as straightforward so I left them.

>> +		rtl8xxxu_write_rfreg(priv, i, RF6052_REG_MODE_AG, val32);
>> +	}
>> +
>> +	for (i = RF_A; i < priv->rf_paths; i++) {
>> +		val32 = rtl8xxxu_read_rfreg(priv, i, RF6052_REG_MODE_AG);
>> +		val32 &= ~MODE_AG_BW_MASK;
>> +		if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40)
>> +			val32 |= MODE_AG_BW_40MHZ_8723B;
>> +		else
>> +			val32 |= MODE_AG_BW_20MHZ_8723B;
>> +		rtl8xxxu_write_rfreg(priv, i, RF6052_REG_MODE_AG, val32);
>> +	}
>> +}
>> +
>> +static void rtl8188eu_init_aggregation(struct rtl8xxxu_priv *priv)
>> +{
>> +	u8 agg_ctrl, usb_spec;
>> +
>> +	usb_spec = rtl8xxxu_read8(priv, REG_USB_SPECIAL_OPTION);
>> +	usb_spec &= ~USB_SPEC_USB_AGG_ENABLE;
>> +	rtl8xxxu_write8(priv, REG_USB_SPECIAL_OPTION, usb_spec);
>> +
>> +	agg_ctrl = rtl8xxxu_read8(priv, REG_TRXDMA_CTRL);
>> +	agg_ctrl &= ~TRXDMA_CTRL_RXDMA_AGG_EN;
>> +	rtl8xxxu_write8(priv, REG_TRXDMA_CTRL, agg_ctrl);
>> +}
>> +
>> +static int rtl8188eu_parse_efuse(struct rtl8xxxu_priv *priv)
>> +{
>> +	struct rtl8188eu_efuse *efuse = &priv->efuse_wifi.efuse8188eu;
>> +	int i;
>> +
>> +	if (efuse->rtl_id != cpu_to_le16(0x8129))
>> +		return -EINVAL;
>> +
>> +	ether_addr_copy(priv->mac_addr, efuse->mac_addr);
>> +
>> +	memcpy(priv->cck_tx_power_index_A, efuse->tx_power_index_A.cck_base,
>> +	       sizeof(efuse->tx_power_index_A.cck_base));
>> +
>> +	memcpy(priv->ht40_1s_tx_power_index_A,
>> +	       efuse->tx_power_index_A.ht40_base,
>> +	       sizeof(efuse->tx_power_index_A.ht40_base));
>> +
>> +	priv->default_crystal_cap = efuse->xtal_k & 0x3f;
>> +
>> +	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
>> +	dev_info(&priv->udev->dev, "Product: %.11s\n", efuse->device_name);
>> +	dev_info(&priv->udev->dev, "Serial: %.11s\n", efuse->serial);
>> +
>> +	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE) {
>> +		unsigned char *raw = priv->efuse_wifi.raw;
>> +
>> +		dev_info(&priv->udev->dev,
>> +			 "%s: dumping efuse (0x%02zx bytes):\n",
>> +			 __func__, sizeof(struct rtl8188eu_efuse));
>> +		for (i = 0; i < sizeof(struct rtl8188eu_efuse); i += 8)
>> +			dev_info(&priv->udev->dev, "%02x: %8ph\n", i, &raw[i]);
> 
> print_hex_dump_bytes()?
> 
I have been meaning to get rid of this duplicated code. Every chip has a copy.
print_hex_dump_bytes() has the wrong debug level. I will use print_hex_dump().

>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void rtl8188eu_reset_8051(struct rtl8xxxu_priv *priv)
>> +{
>> +	u16 sys_func;
>> +
>> +	sys_func = rtl8xxxu_read16(priv, REG_SYS_FUNC);
>> +	sys_func &= ~SYS_FUNC_CPU_ENABLE;
>> +	rtl8xxxu_write16(priv, REG_SYS_FUNC, sys_func);
>> +
>> +	sys_func |= SYS_FUNC_CPU_ENABLE;
>> +	rtl8xxxu_write16(priv, REG_SYS_FUNC, sys_func);
>> +}
>> +
>> +static int rtl8188eu_load_firmware(struct rtl8xxxu_priv *priv)
>> +{
>> +	char *fw_name;
> 
> const char *fw_name;
> 
> as well as second parameter of rtl8xxxu_load_firmware()
> 
>> +	int ret;
>> +
>> +	fw_name = "rtlwifi/rtl8188eufw.bin";
>> +
>> +	ret = rtl8xxxu_load_firmware(priv, fw_name);
>> +
>> +	return ret;
>> +}
>> +
> 
> [...]
> 
>> +static s8 rtl8188e_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
>> +{
>> +	/* only use lna 0/1/2/3/7 */
>> +	static const s8 lna_gain_table_0[8] = {17, -1, -13, -29, -32, -35, -38, -41};
>> +	/* only use lna 3/7 */
>> +	static const s8 lna_gain_table_1[8] = {29, 20, 12, 3, -6, -15, -24, -33};
>> +
>> +	s8 rx_pwr_all = 0x00;
>> +	u8 vga_idx, lna_idx;
>> +	s8 lna_gain = 0;
>> +
>> +	lna_idx = (cck_agc_rpt & 0xE0) >> 5;
>> +	vga_idx = cck_agc_rpt & 0x1F;
> 
> #define CCK_AGC_RPT_LNA_IDX_MASK GENMASK(7, 5)
> #define CCK_AGC_RPT_VGA_IDX_MASK GENMASK(4, 0)
> 
>> +
>> +	if (priv->chip_cut >= 8) /* cut I */
>> +		lna_gain = lna_gain_table_0[lna_idx];
>> +	else
>> +		lna_gain = lna_gain_table_1[lna_idx];
>> +
>> +	rx_pwr_all = lna_gain - (2 * vga_idx);
>> +
>> +	return rx_pwr_all;
>> +}
>> +
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>> index 2c4f403ba68f..d6d9ee87e128 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>> @@ -370,7 +370,7 @@ static void rtl8188f_channel_to_group(int channel, int *group, int *cck_group)
>>  		*cck_group = *group;
>>  }
>>
>> -static void
>> +void
>>  rtl8188f_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
>>  {
>>  	u32 val32, ofdm, mcs;
>> @@ -1662,7 +1662,7 @@ static void rtl8188f_usb_quirks(struct rtl8xxxu_priv *priv)
>>  #define XTAL1	GENMASK(22, 17)
>>  #define XTAL0	GENMASK(16, 11)
>>
>> -static void rtl8188f_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
>> +void rtl8188f_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
>>  {
>>  	struct rtl8xxxu_cfo_tracking *cfo = &priv->cfo_tracking;
>>  	u32 val32;
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 3ed435401e57..c79f41459559 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -46,6 +46,7 @@ MODULE_LICENSE("GPL");
>>  MODULE_FIRMWARE("rtlwifi/rtl8723aufw_A.bin");
>>  MODULE_FIRMWARE("rtlwifi/rtl8723aufw_B.bin");
>>  MODULE_FIRMWARE("rtlwifi/rtl8723aufw_B_NoBT.bin");
>> +MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
> 
> If you need to send a firmware to linux-firmware, please send a private mail to me.
> Then, I can check and send out pull-request.
> 
This time it's not necessary because rtl8188eufw.bin is already there. The module
r8188eu from staging uses it.

>>  MODULE_FIRMWARE("rtlwifi/rtl8192cufw_A.bin");
>>  MODULE_FIRMWARE("rtlwifi/rtl8192cufw_B.bin");
>>  MODULE_FIRMWARE("rtlwifi/rtl8192cufw_TMSC.bin");
> 
> [...]
> 
> --
> Ping-Ke
> 

Thank you for reviewing. I will implement your suggestions.
