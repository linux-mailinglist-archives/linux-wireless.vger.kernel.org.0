Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847CC48B270
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 17:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbiAKQk4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 11:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbiAKQkz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 11:40:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8665DC061757
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 08:40:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D97DB81C10
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 16:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB1CC36AEB;
        Tue, 11 Jan 2022 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641919253;
        bh=Y2IVdlDLNkGK89m2PZayELW8CqtVDCU90Z1d+TZxhgM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cNwevD4+aexC27qSFBbb+1YufQzl6rr29YeKDHvh1v5G+0sANGa/71YGTUpDdOJFX
         D3KWlmA76DWqV4CvACB/g7FsfEtYCoQ5ePQZGeZq4R6XOcpt2Ty6D2yONYfDCPrAlO
         37Lhf0O8WxV2yafNEh47n+SdahNc1gbKzlVC51Ba+bIHhZAhoym1QbK2Ra8JjwJ0rh
         54iKk8QJZvKTv6QAiY/MCImmHkRMKM0DRp/w4hBrxHLZzN8LHeRmBmqKCgzN581PrO
         ThlkwTAfmIE3k8SsFKnCDP3qWMzQE44OCLh9PekAPfcLI5FKWT3axYuRyESC9CmZX2
         wOAOZmzFiimWw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 4/5] mt76: mt7915: add Kconfig entry for MT7986
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
        <04237351a4cb3b773f68a1cc55d1b8c419ca06a5.1641901681.git.Bo.Jiao@mediatek.com>
Date:   Tue, 11 Jan 2022 18:40:49 +0200
In-Reply-To: <04237351a4cb3b773f68a1cc55d1b8c419ca06a5.1641901681.git.Bo.Jiao@mediatek.com>
        (Bo Jiao's message of "Tue, 11 Jan 2022 19:59:20 +0800")
Message-ID: <87bl0ijkdq.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bo Jiao <bo.jiao@mediatek.com> writes:

> From: Ryder Lee <ryder.lee@mediatek.com>
>
> This enables building support for the MT7986 SoC built-in WLAN chip.
>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
> index b8b98cb..8db1ddc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
> @@ -11,3 +11,14 @@ config MT7915E
>  	  OFDMA, spatial reuse and dual carrier modulation.
>  
>  	  To compile this driver as a module, choose M here.
> +
> +config MT7986_WMAC
> +	bool "MT7986 (SoC) WMAC support"
> +	depends on MT7915E
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select REGMAP
> +	default y
> +	help
> +	  This adds support for the built-in WMAC on MT7986 SoC devices
> +	  which has the same feature set as a MT7915, but enables 6E
> +	  support.

Same as in v1, why 'default y'?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
