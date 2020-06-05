Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444A41EF58F
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2020 12:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFEKoG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jun 2020 06:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgFEKoG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jun 2020 06:44:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A828C08C5C2
        for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2020 03:44:06 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jh9pU-0002LH-4F; Fri, 05 Jun 2020 12:44:04 +0200
Date:   Fri, 5 Jun 2020 12:44:04 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH v3 5/7] rtw88: 8821c: add query rx desc support
Message-ID: <20200605104404.msgfrpjqerd2eozx@linutronix.de>
References: <20200603093804.19779-1-yhchuang@realtek.com>
 <20200603093804.19779-6-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200603093804.19779-6-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-03 17:38:02 [+0800], yhchuang@realtek.com wrote:
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
…
> +static void rtw8821c_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
> +				   struct rtw_rx_pkt_stat *pkt_stat,
> +				   struct ieee80211_rx_status *rx_status)
> +{
…
> +
> +	hdr = (struct ieee80211_hdr *)(rx_desc + desc_sz + pkt_stat->shift +
> +				       pkt_stat->drv_info_sz);

I did some counting and hdr can be max. rx_desc+147 so it is fine in
terms of a bounds check.
In ff2f20f60cb84d1684379eb5be4c2285@realtek.com you suggested to merge
the function with 8821C/8822B/8822C. Did you change your mind or will
this happen later?

> +	if (pkt_stat->phy_status) {
> +		phy_status = rx_desc + desc_sz + pkt_stat->shift;
> +		query_phy_status(rtwdev, phy_status, pkt_stat);
> +	}
> +
> +	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
> +}
> +

Sebastian
