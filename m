Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6C1BF5DD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD3Kuy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3Kux (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 06:50:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B564FC035494
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 03:50:53 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jU6mJ-0000V2-3E; Thu, 30 Apr 2020 12:50:51 +0200
Date:   Thu, 30 Apr 2020 12:50:51 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com
Subject: Re: [PATCH v3 3/8] rtw88: 8723d: Add set_channel
Message-ID: <20200430105051.5aom7pn6ng2vubz3@linutronix.de>
References: <20200429095656.19315-1-yhchuang@realtek.com>
 <20200429095656.19315-4-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200429095656.19315-4-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-29 17:56:51 [+0800], yhchuang@realtek.com wrote:
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> index 653cfa9445fc..4e6ee00697be 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> @@ -287,6 +287,168 @@ static void rtw8723d_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
…
> +static void rtw8723d_cfg_notch(struct rtw_dev *rtwdev, u8 channel, bool notch)
> +{
> +	if (!notch)

Would it make sense in pull in the code from the no_notch label up here
and avoid the goto?

> +		goto no_notch;
> +
> +	switch (channel) {
> +	case 13:
> +		rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_MASK_RXDSP, 0xB);
> +		rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_EN_RXDSP, 0x1);
> +		rtw_write32(rtwdev, REG_OFDM1_CSI1, 0x04000000);
> +		rtw_write32(rtwdev, REG_OFDM1_CSI2, 0x00000000);
> +		rtw_write32(rtwdev, REG_OFDM1_CSI3, 0x00000000);
> +		rtw_write32(rtwdev, REG_OFDM1_CSI4, 0x00000000);
> +		rtw_write32_mask(rtwdev, REG_OFDM1_CFOTRK, BIT_EN_CFOTRK, 0x1);
> +		break;
> +	case 14:
> +		rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_MASK_RXDSP, 0x5);
> +		rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_EN_RXDSP, 0x1);
> +		rtw_write32(rtwdev, REG_OFDM1_CSI1, 0x00000000);
> +		rtw_write32(rtwdev, REG_OFDM1_CSI2, 0x00000000);
> +		rtw_write32(rtwdev, REG_OFDM1_CSI3, 0x00000000);
> +		rtw_write32(rtwdev, REG_OFDM1_CSI4, 0x00080000);
> +		rtw_write32_mask(rtwdev, REG_OFDM1_CFOTRK, BIT_EN_CFOTRK, 0x1);
> +		break;
> +	default:
> +		rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_EN_RXDSP, 0x0);
> +		rtw_write32_mask(rtwdev, REG_OFDM1_CFOTRK, BIT_EN_CFOTRK, 0x0);
> +		break;
> +	}
> +
> +	return;
> +
> +no_notch:
> +	rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_MASK_RXDSP, 0x1f);
> +	rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_EN_RXDSP, 0x0);
> +	rtw_write32(rtwdev, REG_OFDM1_CSI1, 0x00000000);
> +	rtw_write32(rtwdev, REG_OFDM1_CSI2, 0x00000000);
> +	rtw_write32(rtwdev, REG_OFDM1_CSI3, 0x00000000);
> +	rtw_write32(rtwdev, REG_OFDM1_CSI4, 0x00000000);
> +	rtw_write32_mask(rtwdev, REG_OFDM1_CFOTRK, BIT_EN_CFOTRK, 0x0);
> +}
> +
> +static void rtw8723d_spur_cal(struct rtw_dev *rtwdev, u8 channel)
> +{
> +	bool notch = false;
> +
> +	if (channel < 13)
> +		goto do_notch;

if you reverse the if statement, then you could avoid the goto.

> +
> +	notch = rtw8723d_check_spur_ov_thres(rtwdev, channel, SPUR_THRES);
> +
> +do_notch:
> +	rtw8723d_cfg_notch(rtwdev, channel, notch);
> +}
> +
> +static void rtw8723d_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
> +{
> +	u32 rf_cfgch[2];

Would it make sense to use rf_cfgch_A rf_cfgch_B instead the array?

> +	rf_cfgch[0] = rtw_read_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK);
> +	rf_cfgch[1] = rtw_read_rf(rtwdev, RF_PATH_B, RF_CFGCH, RFREG_MASK);
> +
> +	rf_cfgch[0] &= ~RFCFGCH_CHANNEL_MASK;
> +	rf_cfgch[1] &= ~RFCFGCH_CHANNEL_MASK;
> +	rf_cfgch[0] |= (channel & RFCFGCH_CHANNEL_MASK);
> +	rf_cfgch[1] |= (channel & RFCFGCH_CHANNEL_MASK);
> +
> +	rf_cfgch[0] &= ~RFCFGCH_BW_MASK;
> +	switch (bw) {
> +	case RTW_CHANNEL_WIDTH_20:
> +		rf_cfgch[0] |= RFCFGCH_BW_20M;
> +		break;
> +	case RTW_CHANNEL_WIDTH_40:
> +		rf_cfgch[0] |= RFCFGCH_BW_40M;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, rf_cfgch[0]);
> +	rtw_write_rf(rtwdev, RF_PATH_B, RF_CFGCH, RFREG_MASK, rf_cfgch[1]);
> +
> +	rtw8723d_spur_cal(rtwdev, channel);
> +}
…
> +static void rtw8723d_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
> +				    u8 primary_ch_idx)
> +{
> +	const struct rtw_backup_info *cck_dfir =
> +			channel <= 13 ? cck_dfir_cfg[0] : cck_dfir_cfg[1];
> +	int i;

If you move the assignment of `cck_dfir' here the definition block
would look a nicer.

> +
> +	for (i = 0; i < CCK_DFIR_NR; i++, cck_dfir++)
> +		rtw_write32(rtwdev, cck_dfir->reg, cck_dfir->val);
> +
> +	switch (bw) {
> +	case RTW_CHANNEL_WIDTH_20:
> +		rtw_write32_mask(rtwdev, REG_FPGA0_RFMOD, BIT_MASK_RFMOD, 0x0);
> +		rtw_write32_mask(rtwdev, REG_FPGA1_RFMOD, BIT_MASK_RFMOD, 0x0);
> +		rtw_write32_mask(rtwdev, REG_BBRX_DFIR, BIT_RXBB_DFIR_EN, 1);
> +		rtw_write32_mask(rtwdev, REG_BBRX_DFIR, BIT_MASK_RXBB_DFIR, 0xa);
> +		break;
> +	case RTW_CHANNEL_WIDTH_40:
> +		rtw_write32_mask(rtwdev, REG_FPGA0_RFMOD, BIT_MASK_RFMOD, 0x1);
> +		rtw_write32_mask(rtwdev, REG_FPGA1_RFMOD, BIT_MASK_RFMOD, 0x1);
> +		rtw_write32_mask(rtwdev, REG_BBRX_DFIR, BIT_RXBB_DFIR_EN, 0);
> +		rtw_write32_mask(rtwdev, REG_CCK0_SYS, BIT_CCK_SIDE_BAND,
> +				 (primary_ch_idx == RTW_SC_20_UPPER ? 1 : 0));
> +		break;
> +	default:
> +		break;
> +	}
> +}

Sebastian
