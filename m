Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7AE1E6765
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404951AbgE1Q1a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 12:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404861AbgE1Q13 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 12:27:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BCCC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 09:27:29 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeLNP-0004es-9a; Thu, 28 May 2020 18:27:27 +0200
Date:   Thu, 28 May 2020 18:27:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH 7/7] rtw88: 8821c: add phy calibration
Message-ID: <20200528162727.57bxyoi76bqpacge@linutronix.de>
References: <20200520052335.22466-1-yhchuang@realtek.com>
 <20200520052335.22466-8-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520052335.22466-8-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-20 13:23:35 [+0800], yhchuang@realtek.com wrote:
> From: Tzu-En Huang <tehuang@realtek.com>
> 
> In order to get a better tramit EVM, we need to perform calibration

s/tramit/transmit/ ?

> after association.
> The calibration needed for 8821c is called iq calibration, which is
> done in firmware. Implement the callback function for triggering
> firmware to do it.
> 
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8821c.c | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> index 7169e6fb9ca9..749569eab912 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> @@ -555,6 +555,39 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
>  	rtw_write32_clr(rtwdev, 0xb58, BIT(0));
>  }
>  
> +static void rtw8821c_do_iqk(struct rtw_dev *rtwdev)
> +{
> +	static int do_iqk_cnt;
> +	struct rtw_iqk_para para = {.clear = 0, .segment_iqk = 0};
> +	u32 rf_reg, iqk_fail_mask;
> +	int counter;
> +	bool reload;
> +
> +	if (rtw_is_assoc(rtwdev))
> +		para.segment_iqk = 1;
> +
> +	rtw_fw_do_iqk(rtwdev, &para);
> +
> +	for (counter = 0; counter < 300; counter++) {
> +		rf_reg = rtw_read_rf(rtwdev, RF_PATH_A, RF_DTXLOK, RFREG_MASK);
> +		if (rf_reg == 0xabcde)
> +			break;
> +		msleep(20);
> +	}
> +	rtw_write_rf(rtwdev, RF_PATH_A, RF_DTXLOK, RFREG_MASK, 0x0);
> +
> +	reload = !!rtw_read32_mask(rtwdev, REG_IQKFAILMSK, BIT(16));
> +	iqk_fail_mask = rtw_read32_mask(rtwdev, REG_IQKFAILMSK, GENMASK(7, 0));
> +	rtw_dbg(rtwdev, RTW_DBG_PHY,
> +		"iqk counter=%d reload=%d do_iqk_cnt=%d n_iqk_fail(mask)=0x%02x\n",
> +		counter, reload, ++do_iqk_cnt, iqk_fail_mask);
> +}
> +
> +static void rtw8821c_phy_calibration(struct rtw_dev *rtwdev)
> +{
> +	rtw8821c_do_iqk(rtwdev);

Why this extra step? You could name it rtw8821c_phy_calibration_iqk().

> +}
> +

Sebastian
