Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DEC4719D8
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Dec 2021 12:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhLLLpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Dec 2021 06:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLLLpn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Dec 2021 06:45:43 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33671C061714
        for <linux-wireless@vger.kernel.org>; Sun, 12 Dec 2021 03:45:42 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mwNIP-0000Nr-F3; Sun, 12 Dec 2021 12:45:38 +0100
Message-ID: <b8cd1251-691c-a927-cff2-3476977667b1@leemhuis.info>
Date:   Sun, 12 Dec 2021 12:45:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 5.16] mac80211: fix rate control for retransmitted frames
Content-Language: en-BS
To:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Cc:     aaro.koskinen@iki.fi, rwbugreport@lost-in-the-void.net,
        ryder.lee@mediatek.com, Felix Fietkau <nbd@nbd.name>
References: <20211122204323.9787-1-nbd@nbd.name>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20211122204323.9787-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1639309542;98cab9b0;
X-HE-SMSGID: 1mwNIP-0000Nr-F3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

Top-posting for once, to make this easy accessible to everyone.

What is talking below fix so long to get mainlined? The patch and the
confirmation that it fixes the regressions was 19 days ago. The patch is
also in linux-next for 12 days. From my point of view as regression
tracker that seem "too long", as this is a regression that also affects
a stable kernel.

Or am I missing something?

Ciao, Thorsten

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply. That's in everyone's interest, as
what I wrote above might be misleading to everyone reading this; any
suggestion I gave thus might sent someone reading this down the wrong
rabbit hole, which none of us wants.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

#regzbot poke

On 22.11.21 21:43, Felix Fietkau wrote:
> Since retransmission clears info->control, rate control needs to be called
> again, otherwise the driver might crash due to invalid rates.
> 
> Cc: stable@vger.kernel.org # 5.14+
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Robert W <rwbugreport@lost-in-the-void.net>
> Fixes: 03c3911d2d67 ("mac80211: call ieee80211_tx_h_rate_ctrl() when dequeue")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
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
> 

