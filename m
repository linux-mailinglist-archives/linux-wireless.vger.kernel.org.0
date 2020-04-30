Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8677C1BFB25
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgD3N5y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgD3N5x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 09:57:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA3CC035494
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 06:57:53 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jU9hF-0003xy-VQ; Thu, 30 Apr 2020 15:57:50 +0200
Date:   Thu, 30 Apr 2020 15:57:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, pkshih@realtek.com,
        linux-wireless@vger.kernel.org, briannorris@chromium.org,
        kevin_yang@realtek.com
Subject: Re: [PATCH 25/40] rtw88: 8723d: Add LC calibration
Message-ID: <20200430135749.pjtzrnsnvkknwjim@linutronix.de>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-26-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417074653.15591-26-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-17 15:46:38 [+0800], yhchuang@realtek.com wrote:
> index cf897af380c1..94784c7f0743 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> @@ -64,6 +64,33 @@ static const struct rtw_hw_reg rtw8723d_txagc[] = {
>  #define WLAN_LTR_CTRL1		0xCB004010
>  #define WLAN_LTR_CTRL2		0x01233425
>  
> +static void rtw8723d_lck(struct rtw_dev *rtwdev)
> +{
> +#define BIT_LCK		BIT(15)

please don't add defines like this within a function.

> +	u8 val_ctx;
> +	u32 lc_cal, cnt;
> +
> +	val_ctx = rtw_read8(rtwdev, REG_CTX);
> +	if ((val_ctx & BIT_MASK_CTX_TYPE) != 0)
> +		rtw_write8(rtwdev, REG_CTX, val_ctx & ~BIT_MASK_CTX_TYPE);
> +	else
> +		rtw_write8(rtwdev, REG_TXPAUSE, 0xFF);
> +	lc_cal = rtw_read_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK);
> +
> +	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, lc_cal | BIT_LCK);
> +	for (cnt = 0; cnt < 100; cnt++) {
> +		if (rtw_read_rf(rtwdev, RF_PATH_A, RF_CFGCH, BIT_LCK) != 0x1)
> +			break;
> +		mdelay(10);

Do you have any numbers on how long this takes? Like best-case, on average,
worst case? I'm asking because if the bit does not flip on the first
read then you busy-loop-delay here for 10ms. If it does not flip at all,
you busy waited a whole second without any consequence. 

It looks like this context here is not atomic so msleep() would work where.

Sebastian
