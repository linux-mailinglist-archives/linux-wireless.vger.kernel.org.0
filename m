Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845C71BF5E5
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 12:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgD3KyV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 06:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726500AbgD3KyV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 06:54:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3D3C035494
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 03:54:21 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jU6pe-0000WR-Q9; Thu, 30 Apr 2020 12:54:19 +0200
Date:   Thu, 30 Apr 2020 12:54:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com
Subject: Re: [PATCH v3 5/8] rtw88: 8723d: 11N chips don't support LDPC
Message-ID: <20200430105418.v3s5obb3skhv4732@linutronix.de>
References: <20200429095656.19315-1-yhchuang@realtek.com>
 <20200429095656.19315-6-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200429095656.19315-6-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-29 17:56:53 [+0800], yhchuang@realtek.com wrote:
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -933,7 +933,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
>  	ht_cap->cap = 0;
>  	ht_cap->cap |= IEEE80211_HT_CAP_SGI_20 |
>  			IEEE80211_HT_CAP_MAX_AMSDU |
> -			IEEE80211_HT_CAP_LDPC_CODING |
> +			(rtw_chip_wcpu_11ac(rtwdev) ? IEEE80211_HT_CAP_LDPC_CODING : 0) |
>  			(1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);

What about

 	ht_cap->cap = IEEE80211_HT_CAP_SGI_20 |
 			IEEE80211_HT_CAP_MAX_AMSDU |
 			(1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
	if (rtw_chip_wcpu_11ac(rtwdev))
			ht_cap->cap |= IEEE80211_HT_CAP_LDPC_CODING;
instead?

>  	if (efuse->hw_cap.bw & BIT(RTW_CHANNEL_WIDTH_40))
>  		ht_cap->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40 |

Sebastian
