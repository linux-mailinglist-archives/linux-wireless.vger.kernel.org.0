Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F5561458F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 09:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKAISL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 04:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKAISK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 04:18:10 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CC3D1261A
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 01:18:09 -0700 (PDT)
Message-ID: <02494022-6f02-22ba-eb9e-f57384c9238d@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1667290687;
        bh=edpnasYMHywX6fAPpEGPNxXBbHuGDe/LkdkZ2Y7RmDA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=B61cwVqtpKiMqJ18ekIaLUoQ/DsFIS8rOrKAR8ZiO5XKKLuzyPRvc3rJRTeKDnN9N
         2OBFZIEID1Mhx0QLPG/LBIj9DpTSaN/Mu7wSg42npTNJhewnFMEmpj88WvWNHB9m5d
         QkESh0NrCevJ/paVa7HVpXEvk2hTHey5zAr1Byj8=
Date:   Tue, 1 Nov 2022 09:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] wifi: mac80211: convert PS buffering into iTXQ
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
References: <20221031211815.6666-1-alexander@wetzel-home.de>
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <20221031211815.6666-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> @@ -3773,6 +3577,13 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>   			ieee80211_free_txskb(&local->hw, skb);
>   			goto begin;
>   		}
> +	} else if (vif->txq == txq &&
> +		   vif->type == NL80211_IFTYPE_AP &&
> +		   atomic_read(&tx.sdata->bss->ps.num_sta_ps)) {
> +		info->flags |= IEEE80211_TX_CTL_SEND_AFTER_DTIM;
> +
> +		if (ieee80211_hw_check(&tx.local->hw, QUEUE_CONTROL))
> +			info->hw_queue = tx.sdata->vif.cab_queue;

I forgot to drop the two lines above.

vif.cab_queue is also set in ieee80211_get_txq(), making these lines 
redundant. (As standalone they would be wrong and not always setting the 
flag when needed.)

Since I'm sure there will be more issues I won't submit a new patch 
immediately.

Alexander
