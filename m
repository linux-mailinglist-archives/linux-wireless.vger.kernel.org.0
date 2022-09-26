Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23C95E9D78
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiIZJYe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiIZJYA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 05:24:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6238EE41
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 02:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16A58B80760
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 09:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD301C433D6;
        Mon, 26 Sep 2022 09:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664184169;
        bh=gW0C7BEO3vKcvwu6iuRQj8xlUUf92Ya0oPswiBCEuqw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bF3e/xAouvR//QDNCWbuhKaB0pK6IDxGa6eIlkBPdo6NSm6BfR9hGtSnCSIbeLv3V
         Dmph1RoO8/ew2ZRajS9/f0rUr+FRvGYx2XdhnqPrnfU7zO7oPJ7tndcTNs72/ew1cH
         g4XWn2uwbIch99TmFYICwnKLfrayShdLGXjl9J+kZn8NT8S7CjVGCigugPNelEKwRK
         2F7pmDenTOuWKWHRZOMIRYILT7cUl9p5u6iXybxKXTG/bM7zYqeWCU/RiQRcKpiCqC
         dxNc7RghLYa4MBlKoH5DNCQyuBmMybKugiPYeDxmaKC01LSP2nlfZP5zQNQ8JFwbJ3
         oF0mZzaFa+rUQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>, chris.chiu@canonical.com
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Support new chip RTL8188FU
References: <dfc6a877-e50a-87a2-08f7-7007c8083386@gmail.com>
Date:   Mon, 26 Sep 2022 12:22:45 +0300
In-Reply-To: <dfc6a877-e50a-87a2-08f7-7007c8083386@gmail.com> (Bitterblue
        Smith's message of "Sun, 18 Sep 2022 00:06:06 +0300")
Message-ID: <87bkr27amy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> This chip is found in the cheapest USB adapters, e.g. 1.17 USD with
> VAT and shipping from China included.
>
> It's a gen 2 chip, similar to the RTL8723BU, but without Bluetooth.
> Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.
>
> The vendor driver rtl8188fu version 4.3.23.6_20964.20170110 [0]
> was used as reference. The CD shipped with the device includes a
> newer driver, version 5.11.5-1-g12f7cde4b.20201102, but that one
> couldn't complete the WPA2 key exchange thing for whatever reason.
>
> [0] https://github.com/kelebek333/rtl8188fu
>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[...]

> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> new file mode 100644
> index 000000000000..5f7f9ea4d1d5
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> @@ -0,0 +1,1696 @@
> +/*
> + * RTL8XXXU mac80211 USB driver - 8188f specific subdriver
> + *
> + * Copyright (c) 2022 Bitterblue Smith <rtl8821cerfe2@gmail.com>
> + *
> + * Portions copied from existing rtl8xxxu code:
> + * Copyright (c) 2014 - 2017 Jes Sorensen <Jes.Sorensen@gmail.com>
> + *
> + * Portions, notably calibration code:
> + * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + */

Please use SPDX tags instead of the license text, you can see examples
from other rtl8xxxu files.

> +static struct rtl8xxxu_reg8val rtl8188f_mac_init_table[] = {

[...]

> +static struct rtl8xxxu_reg32val rtl8188fu_phy_init_table[] = {

[...]

> +static struct rtl8xxxu_reg32val rtl8188f_agc_table[] = {

[...]

> +static struct rtl8xxxu_rfregval rtl8188fu_radioa_init_table[] = {

[...]

> +static struct rtl8xxxu_rfregval rtl8188fu_cut_b_radioa_init_table[] = {

Can these arrays be static const?

> +/* A workaround to eliminate the 2400MHz, 2440MHz, 2480MHz spur of 8188F. */
> +static void rtl8188f_spur_calibration(struct rtl8xxxu_priv *priv, u8 channel)
> +{
> +	const u32 frequencies[14 + 1] = {
> +		[5] = 0xFCCD,
> +		[6] = 0xFC4D,
> +		[7] = 0xFFCD,
> +		[8] = 0xFF4D,
> +		[11] = 0xFDCD,
> +		[13] = 0xFCCD,
> +		[14] = 0xFF9A
> +	};
> +
> +	const u32 reg_d40[14 + 1] = {
> +		[5] = 0x06000000,
> +		[6] = 0x00000600,
> +		[13] = 0x06000000
> +	};
> +
> +	const u32 reg_d44[14 + 1] = {
> +		[11] = 0x04000000
> +	};
> +
> +	const u32 reg_d4c[14 + 1] = {
> +		[7] = 0x06000000,
> +		[8] = 0x00000380,
> +		[14] = 0x00180000
> +	};

Also can these be static const?

> +	/*enable notch filter */

Add a space after '/*':

/* enable notch filter */

I see similar problems in other comments, please go through them.

This is nitpicking, but to improve readability I prefer to have an empty
line before a comment. I saw several cases which didn't have that.

> +	if (t) {
> +		if (!priv->pi_enabled) {
> +			/*
> +			 * Switch back BB to SI mode after finishing
> +			 * IQ Calibration
> +			 */
> +			val32 = 0x01000000;
> +			rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, val32);
> +			rtl8xxxu_write32(priv, REG_FPGA0_XB_HSSI_PARM1, val32);
> +		}
> +
> +		/* Reload ADDA power saving parameters */
> +		rtl8xxxu_restore_regs(priv, adda_regs, priv->adda_backup,
> +				      RTL8XXXU_ADDA_REGS);
> +
> +		/* Reload MAC parameters */
> +		rtl8xxxu_restore_mac_regs(priv, iqk_mac_regs, priv->mac_backup);
> +
> +		/* Reload BB parameters */
> +		rtl8xxxu_restore_regs(priv, iqk_bb_regs,
> +				      priv->bb_backup, RTL8XXXU_BB_REGS);
> +
> +		/* Reload RF path */
> +		rtl8xxxu_write32(priv, REG_S0S1_PATH_SWITCH, path_sel_bb);
> +		rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_S0S1, path_sel_rf);
> +
> +		/* Restore RX initial gain */
> +		val32 = rtl8xxxu_read32(priv, REG_OFDM0_XA_AGC_CORE1);
> +		val32 &= 0xffffff00;
> +		val32 |= 0x50;
> +		rtl8xxxu_write32(priv, REG_OFDM0_XA_AGC_CORE1, val32);
> +		rtl8xxxu_write32(priv, REG_OFDM0_XA_AGC_CORE1, rx_initial_gain & 0xff);
> +
> +		/* Load 0xe30 IQC default value */
> +		rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x01008c00);
> +		rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x01008c00);
> +	}
> +}

You can avoid the indentation and extra block with:

if (!t)
        return;

> +static void rtl8188f_enable_rf(struct rtl8xxxu_priv *priv)
> +{
> +#define PPG_BB_GAIN_2G_TXA_OFFSET_8188F 0xee
> +#define PPG_BB_GAIN_2G_TX_OFFSET_MASK 0x0f

Please move the defines outside of the function (ie. few lines above).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
