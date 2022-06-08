Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223CE5429DB
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiFHIuX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiFHItu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:49:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF03167F4
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 01:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0D08B8259F
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 08:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48452C34116;
        Wed,  8 Jun 2022 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654675615;
        bh=tSPhXAT3CHbQAtczvHEm45UNBrWkxU0A/wd7AtQ3NQg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iRnSKwRoUCN5pVsrPlg48zHgblPU7f5jaJzDzB3vKN53XXcCdIL/8ixQ9nVlHwND5
         aNNxrqTDUMwC3vpqZPwjJl5bljDqeP2Hj5psvsp1OKQktYUxA2NvIi0bd7BZ6OiPCw
         9gO3MrSLVWVwnJIh4VTxIxIRIguBRypzItnf0Zs0KCN0wUmFJSPZC/xas3RLtd4IOZ
         0CcOMtcYdxpuL8fxmXebS4UadjmdiysZiMOVcFFIeQjvvl/08F/rzXpJGANORvHMea
         v7C6RvTw6gcH9nWZhOx9b62AVcc5pxN3n+Ac1G1Qoz6UHjdy23jkzEW5JYPaYmn0Pr
         zYKemePZ3QuJA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <echuang@realtek.com>, <phhuang@realtek.com>
Subject: Re: [PATCH 1/3] ieee80211: add trigger frame definition
References: <20220601013917.18814-1-pkshih@realtek.com>
        <20220601013917.18814-2-pkshih@realtek.com>
Date:   Wed, 08 Jun 2022 11:06:51 +0300
In-Reply-To: <20220601013917.18814-2-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Wed, 1 Jun 2022 09:39:15 +0800")
Message-ID: <87h74vshno.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Po Hao Huang <phhuang@realtek.com>
>
> Define trigger stype of control frame, and its checking function, struct
> and trigger type within common_info of trigger.
>
> Signed-off-by: Po Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  include/linux/ieee80211.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index 75d40acb60c1c..f3b2d5b56d643 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -76,6 +76,7 @@
>  #define IEEE80211_STYPE_ACTION		0x00D0
>  
>  /* control */
> +#define IEEE80211_STYPE_TRIGGER		0x0020
>  #define IEEE80211_STYPE_CTL_EXT		0x0060
>  #define IEEE80211_STYPE_BACK_REQ	0x0080
>  #define IEEE80211_STYPE_BACK		0x0090
> @@ -295,6 +296,17 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
>  
>  #define IEEE80211_HT_CTL_LEN		4
>  
> +/* trigger type within common_info of trigger frame */
> +#define IEEE80211_TRIGGER_TYPE_MASK		0xfULL
> +#define IEEE80211_TRIGGER_TYPE_BASIC		0x0
> +#define IEEE80211_TRIGGER_TYPE_BFRP		0x1
> +#define IEEE80211_TRIGGER_TYPE_MU_BAR		0x2
> +#define IEEE80211_TRIGGER_TYPE_MU_RTS		0x3
> +#define IEEE80211_TRIGGER_TYPE_BSRP		0x4
> +#define IEEE80211_TRIGGER_TYPE_GCR_MU_BAR	0x5
> +#define IEEE80211_TRIGGER_TYPE_BQRP		0x6
> +#define IEEE80211_TRIGGER_TYPE_NFRP		0x7

Why ULL in the mask? I don't see it used anywhere else in the file.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
