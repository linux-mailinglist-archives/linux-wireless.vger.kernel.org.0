Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFAA1BFF74
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgD3PCL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 11:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726421AbgD3PCL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 11:02:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CA7C035494
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 08:02:11 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jUAhS-00067K-TB; Thu, 30 Apr 2020 17:02:07 +0200
Date:   Thu, 30 Apr 2020 17:02:06 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, pkshih@realtek.com,
        linux-wireless@vger.kernel.org, briannorris@chromium.org,
        kevin_yang@realtek.com
Subject: Re: [PATCH 26/40] rtw88: 8723d: add IQ calibration
Message-ID: <20200430150206.3bw7lp7wslgeuaqx@linutronix.de>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-27-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200417074653.15591-27-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-17 15:46:39 [+0800], yhchuang@realtek.com wrote:
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> index 94784c7f0743..b66bd969e007 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
…
> +struct iqk_backup_regs {
> +	u32 adda[IQK_ADDA_REG_NUM];
> +	u8 mac8[IQK_MAC8_REG_NUM];
> +	u32 mac32[IQK_MAC32_REG_NUM];
> +	u32 bb[IQK_BB_REG_NUM];
> +
> +	u32 lte_path;
> +	u32 lte_gnt;
> +
> +	u8 btg_sel;
> +	u32 bb_sel_btg;
> +
> +	u8 igia;
> +	u8 igib;

The struct has 128 bytes. Putting btg_sel after bb_sel_btg will result
in 124 bytes. How likely is it that it will grow? I'm asking because it
is allocated on stack.

> +};
> +
> +static void rtw8723d_iqk_backup_regs(struct rtw_dev *rtwdev,
> +				     struct iqk_backup_regs *backup)
> +{
> +	int i;
> +
> +	for (i = 0; i < IQK_ADDA_REG_NUM; i++)
> +		backup->adda[i] = rtw_read32(rtwdev, iqk_adda_regs[i]);
> +
> +	for (i = 0; i < IQK_MAC8_REG_NUM; i++)
> +		backup->mac8[i] = rtw_read8(rtwdev, iqk_mac8_regs[i]);
> +	for (i = 0; i < IQK_MAC32_REG_NUM; i++)
> +		backup->mac32[i] = rtw_read32(rtwdev, iqk_mac32_regs[i]);
> +
> +	for (i = 0; i < IQK_BB_REG_NUM; i++)
> +		backup->bb[i] = rtw_read32(rtwdev, iqk_bb_regs[i]);
> +
> +	backup->igia = (u8)rtw_read32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0);
> +	backup->igib = (u8)rtw_read32_mask(rtwdev, REG_OFDM0_XBAGC1, MASKBYTE0);

igi[ab] is alreay u8, no need for cast.

> +
> +	backup->bb_sel_btg = rtw_read32(rtwdev, REG_BB_SEL_BTG);
> +}
…

> +static u8 rtw8723d_iqk_rx_path(struct rtw_dev *rtwdev,
> +			       const struct rtw_8723d_iqk_cfg *iqk_cfg,
> +			       const struct iqk_backup_regs *backup)
> +{
> +	u32 tx_x, tx_y;
> +	u8 result = 0x00;

You could avoid the explicit init of `result' (maybe even use `ret' for
less key strokes and avoiding the confusion with the `result' array used
by the other functions here) and then 

…
> +	rtw8723d_iqk_one_shot(rtwdev, false, iqk_cfg);
> +	result |= rtw8723d_iqk_check_tx_failed(rtwdev, iqk_cfg);

not or the returned value here. Since you don't collect it from multiple
functions I don't see the reason for it.

> +	if (!result)
> +		goto restore;
…
> +	rtw8723d_iqk_one_shot(rtwdev, false, iqk_cfg);
> +	result |= rtw8723d_iqk_check_rx_failed(rtwdev, iqk_cfg);

Same here.

> +restore:
> +	rtw8723d_iqk_txrx_path_post(rtwdev, iqk_cfg, backup);
> +
> +	return result;
> +}
> +
…
> +
> +static void rtw8723d_phy_calibration(struct rtw_dev *rtwdev)
> +{
> +	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
> +	s32 result[IQK_ROUND_SIZE][IQK_NR];
> +	struct iqk_backup_regs backup;

I don't know how deep you are in the call chain, but `result' takes 128
bytes and `backup' as well (this could be 124).
I'm not saying that this is bad, just that you keep an eye on it since
those two take 256 bytes.

> +	u8 i, j;
> +	u8 final_candidate = IQK_ROUND_INVALID;
> +	bool good;
> +
> +	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] Start!!!\n");
> +
> +	memset(result, 0, sizeof(result));

Sebastian
