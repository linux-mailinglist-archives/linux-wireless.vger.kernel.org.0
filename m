Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905E4697E6C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBOOeE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 09:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBOOeC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AD438B7A
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 06:33:48 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EDFB6602193;
        Wed, 15 Feb 2023 14:33:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676471627;
        bh=MAUAP9Z+ubwKhLvoWcUFpD46AsMhuehnGPYnsopRURA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VIpZD1hIOXiKELwyig7jOOWzYaJ9DEPCkZmRICqxZJRmy6v7k8dFPDBhFNzBgqfo3
         M/ihsAYO0fZw/l9BngO/gS1Wkspez7RXaRug0snJ7YQLt3+ySD52CZaEdGZtP3f4Bq
         gVJYUFaOhjDMpyni04oe2HkT46N0/OXNAmu/jEGSdrhkdDkHzaR0EuwVjhdan6mHH6
         w9o0DAcXS85kSAaFaVOlMTSR6NLroE1QWYKaf9QTsp+9mO1SoFAUo+nqeFBzDI7aKS
         YlZ7L7bjGqUzAJSh9gNuHtGSjyzxfMZuLPtNGTZqmFpt9DBpUSfjjOhaBQdab8tHw5
         JmSPDZSddPyaA==
Message-ID: <ee62f808-51fc-3fe3-22f6-60cbd144ae07@collabora.com>
Date:   Wed, 15 Feb 2023 15:33:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] wifi: mac80211: make rate u32 in sta_set_rate_info_rx()
Content-Language: en-US
To:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20230209110659.25447-1-shayne.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230209110659.25447-1-shayne.chen@mediatek.com>
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

Il 09/02/23 12:06, Shayne Chen ha scritto:
> The value of last_rate in ieee80211_sta_rx_stats is degraded from u32 to
> u16 after being assigned to rate variable, which causes information loss
> in STA_STATS_FIELD_TYPE and later bitfields.
> 
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

In struct ieee80211_sta_rx_stats, `last_rate` is u32, hence this local `rate`
must be u32, or information loss may happen. Agreed.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

P.S.: Sorry for sending twice, the first one got out of the wrong mailbox.

> ---
>   net/mac80211/sta_info.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index 27c737fe7fb8..bd532d3f925d 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -2418,7 +2418,7 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
>   
>   static int sta_set_rate_info_rx(struct sta_info *sta, struct rate_info *rinfo)
>   {
> -	u16 rate = READ_ONCE(sta_get_last_rx_stats(sta)->last_rate);
> +	u32 rate = READ_ONCE(sta_get_last_rx_stats(sta)->last_rate);
>   
>   	if (rate == STA_STATS_RATE_INVALID)
>   		return -EINVAL;
> 

