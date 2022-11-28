Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC7863B139
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 19:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiK1SZf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 13:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiK1SZT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 13:25:19 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FD6B27DCA
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 10:17:00 -0800 (PST)
Message-ID: <b99fe7bd-f97f-31dd-de4f-2314ecf4b753@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1669659417;
        bh=SRT0r2JOkkslUrmOSM/VMzWr46m5s0bBUXYBodLsGAg=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To;
        b=OvJpIvlRp0oBMZDydnZkfd3UrgXCXONvY98FPg3f9qtOIWn9h4hCcKDwZ+LIptyi+
         DhloP4fLDelqxBkrdsNiJVZGG7hVXZiMBFFgRspQuUgq7JvkbL23HFJEAjIpgjBNjB
         v7MP8jSS2AQrUA1g9gvOQM9XJGPiKdTR1r5dTWqw=
Date:   Mon, 28 Nov 2022 19:16:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Alexander Wetzel <alexander@wetzel-home.de>
Subject: Re: [PATCH v2] wifi: mac80211: integrate PS buffering into iTXQ
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
References: <20221102184005.10649-1-alexander@wetzel-home.de>
Content-Language: en-US
In-Reply-To: <20221102184005.10649-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> @@ -1579,16 +1561,39 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
>   		tmp = skb_queue_len(&pending);
>   		filtered += tmp - count;
>   		count = tmp;
> -
> -		spin_lock_irqsave(&sta->ps_tx_buf[ac].lock, flags);
> -		skb_queue_splice_tail_init(&sta->ps_tx_buf[ac], &pending);
> -		spin_unlock_irqrestore(&sta->ps_tx_buf[ac].lock, flags);
> -		tmp = skb_queue_len(&pending);
> -		buffered += tmp - count;
>   	}
>   
> +	skb_queue_head_init(&pending);
>   	ieee80211_add_pending_skbs(local, &pending);
>   
> +	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
> +		if (!sta->sta.txq[i])
> +			continue;
> +
> +		txqi = to_txq_info(sta->sta.txq[i]);
> +		clear_bit(IEEE80211_TXQ_STOP_PS, &txqi->flags);
> +	}
> +
> +	/* Make sure TX path has stopped setting txq_buffered_tids */
> +	synchronize_net();
> +

We are atomic here and can't sleep. Working on that now, but this gets 
surprisingly complex fast.
Review of the rest is still welcome but this patch must not be merged as 
it is.

It kind of looks like the current (unpatched) code is not only sending 
out filtered frames after iTXQ but also misses the required 
rcu_read_lock to be allowed to call schedule_and_wake_txq() in this 
function when called from drv_deliver_wk()...

Alexander
