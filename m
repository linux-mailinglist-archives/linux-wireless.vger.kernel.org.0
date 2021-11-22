Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC445965B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 22:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhKVVH0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 16:07:26 -0500
Received: from fgw22-4.mail.saunalahti.fi ([62.142.5.109]:39571 "EHLO
        fgw22-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229647AbhKVVHZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 16:07:25 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-75-23-nat.elisa-mobile.fi [85.76.75.23])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id c04dfdda-4bd7-11ec-ae1c-005056bdf889;
        Mon, 22 Nov 2021 23:04:16 +0200 (EET)
Date:   Mon, 22 Nov 2021 23:04:15 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        rwbugreport@lost-in-the-void.net, ryder.lee@mediatek.com
Subject: Re: [PATCH 5.16] mac80211: fix rate control for retransmitted frames
Message-ID: <20211122210415.GB576751@darkstar.musicnaut.iki.fi>
References: <20211122204323.9787-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122204323.9787-1-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Nov 22, 2021 at 09:43:23PM +0100, Felix Fietkau wrote:
> Since retransmission clears info->control, rate control needs to be called
> again, otherwise the driver might crash due to invalid rates.
> 
> Cc: stable@vger.kernel.org # 5.14+
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Robert W <rwbugreport@lost-in-the-void.net>
> Fixes: 03c3911d2d67 ("mac80211: call ieee80211_tx_h_rate_ctrl() when dequeue")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  net/mac80211/tx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 278945e3e08a..e19f6e246642 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -1822,15 +1822,15 @@ static int invoke_tx_handlers_late(struct ieee80211_tx_data *tx)
>  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
>  	ieee80211_tx_result res = TX_CONTINUE;
>  
> +	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
> +		CALL_TXH(ieee80211_tx_h_rate_ctrl);
> +
>  	if (unlikely(info->flags & IEEE80211_TX_INTFL_RETRANSMISSION)) {
>  		__skb_queue_tail(&tx->skbs, tx->skb);
>  		tx->skb = NULL;
>  		goto txh_done;
>  	}
>  
> -	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
> -		CALL_TXH(ieee80211_tx_h_rate_ctrl);
> -
>  	CALL_TXH(ieee80211_tx_h_michael_mic_add);
>  	CALL_TXH(ieee80211_tx_h_sequence);
>  	CALL_TXH(ieee80211_tx_h_fragment);
> -- 
> 2.30.1
> 
