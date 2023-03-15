Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DEF6BAACE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 09:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjCOIbt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjCOIbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 04:31:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75DB65476
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 01:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B820B81C69
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 08:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956B6C4339B;
        Wed, 15 Mar 2023 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678869105;
        bh=YOtQSr3wH0b1PycI4IU9Z9cc/Y20y7AOIAY/lJzq1go=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bVo/nbjlvNI8CVJ0U9z4eCZ4cNiCAdSogOWLsm4mAhecpF0MxM2DDYHZ866O3gcLZ
         ooWOvKUen+8X4K/4rzd9fvfl4wxiRDx03NzcVwqcUI1f1uzNWn9Pyp2DZgHoolESiF
         uDrNUhGbrHGCzYGFiIK4bqELzpYtudHb8WUSr5TgCfiiw3+ezLQOrmpc433xZpLXeF
         qn2ivSb96WoYeT5eqX40veDFf4dixqYBEQuewwrlBhs7H5rS7QyZO8xkWLkp/9m5/A
         85iMt7ucmy6dwI7kosZGcBkCLjtpVXQstFxSutf6mE3jr6yz5/4zfsrq0LyzdtBsYw
         ACHfv/IH2Hfog==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/5] wifi: rtw89: 8852c: add beacon filter and CQM support
References: <20230310034631.45299-1-pkshih@realtek.com>
        <20230310034631.45299-2-pkshih@realtek.com>
Date:   Wed, 15 Mar 2023 10:31:41 +0200
In-Reply-To: <20230310034631.45299-2-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 10 Mar 2023 11:46:27 +0800")
Message-ID: <87zg8emn4i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Po-Hao Huang <phhuang@realtek.com>
>
> Adding this supports beacon filter and connection quality monitor.
> To make host CPU wake up less, let firmware perform signal
> monitoring and beacon processing, then notify driver upon signal
> changes or beacon loss.
>
> This feature needs firmware 0.27.56 or newer to support it.
>
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1438,6 +1438,8 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
>  	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
>  	struct sk_buff *skb = iter_data->skb;
>  	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
> +	struct rtw89_rx_phy_ppdu *phy_ppdu =
> +		(struct rtw89_rx_phy_ppdu *)iter_data->phy_ppdu;

Why the cast? I don't think it's needed.

> @@ -3181,6 +3204,15 @@ static inline struct rtw89_fw_c2h_attr *RTW89_SKB_C2H_CB(struct sk_buff *skb)
>  #define RTW89_GET_MAC_C2H_REV_ACK_H2C_SEQ(c2h) \
>  	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
>  
> +#define RTW89_GET_MAC_BCNFLTR_RPT_MACID(c2h) \
> +	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 0))
> +#define RTW89_GET_MAC_BCNFLTR_RPT_TYPE(c2h) \
> +	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(9, 8))
> +#define RTW89_GET_MAC_BCNFLTR_RPT_EVENT(c2h) \
> +	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(11, 10))
> +#define RTW89_GET_MAC_BCNFLTR_RPT_MA(c2h) \
> +	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))

I have to admit that I every time I see this code pattern it makes me
regret it. Something like what Arnd proposed back in the day would look
so much cleaner:

https://lore.kernel.org/all/CAK8P3a1rsKZZKMKFTDWgE3usX9gYKJqUvTMxSdEuZrp8BaKdaA@mail.gmail.com/

Of course this is just a generic comment about rtw89, and has nothing to
do with this patchset, but it would be great if someone could take a
look and try out Arnd's proposal. It would be good to start with just
one or two commands and send that as an RFC to see how it looks like.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
