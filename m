Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF5B1E65E3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 17:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404334AbgE1PWw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404237AbgE1PWu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 11:22:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26251C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 08:22:50 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeKMp-0003P3-6A; Thu, 28 May 2020 17:22:47 +0200
Date:   Thu, 28 May 2020 17:22:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH 4/7] rtw88: 8821c: add set channel support
Message-ID: <20200528152247.oqwtgd6pbfypxis5@linutronix.de>
References: <20200520052335.22466-1-yhchuang@realtek.com>
 <20200520052335.22466-5-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520052335.22466-5-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-20 13:23:32 [+0800], yhchuang@realtek.com wrote:
> From: Tzu-En Huang <tehuang@realtek.com>
> 
> To let 8821c connect to change to different 2.4G and 5G channels,
> this commit implements the callback function for set channel.
> Set the required chip setting for 8821c, which includes mac, bb and
> rf related settings.

8821c is capable of 2.4G and 5G.

Implement rtw_chip_ops::set_channel() to set 2G and 5G channels. This
includes MAC, BB and RF related settings.

> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> index df95a095df73..e3b52caf9ab3 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> @@ -94,6 +94,9 @@ static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
>  
>  	/* post init after header files config */
>  	rtw_write32_set(rtwdev, REG_RXPSEL, BIT_RX_PSEL_RST);
> +	rtwdev->chip->ch_param[0] = rtw_read32_mask(rtwdev, REG_TXSF2, MASKDWORD);
> +	rtwdev->chip->ch_param[1] = rtw_read32_mask(rtwdev, REG_TXSF6, MASKDWORD);
> +	rtwdev->chip->ch_param[2] = rtw_read32_mask(rtwdev, 0xaac, MASKDWORD);

The first two are the same as in 8822b. Would you mind providing a
define for 0xaac?

>  	rtw_phy_init(rtwdev);
>  }

Sebastian
