Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2399697E92
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 15:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBOOnA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 09:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjBOOm7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 09:42:59 -0500
X-Greylist: delayed 587 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Feb 2023 06:42:56 PST
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC8D14EAC
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 06:42:56 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 4F99A3FAF5;
        Wed, 15 Feb 2023 15:33:05 +0100 (CET)
Message-ID: <b12bf08c-f8b8-d561-f85a-475ec5677710@somainline.org>
Date:   Wed, 15 Feb 2023 15:33:04 +0100
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
        <angelogioacchino.delregno@somainline.org>
In-Reply-To: <20230209110659.25447-1-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

