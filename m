Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14DB48AB9E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 11:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348523AbiAKKnF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 05:43:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52870 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiAKKnF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 05:43:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 065ED614DE
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 10:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3771C36AE3;
        Tue, 11 Jan 2022 10:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641897784;
        bh=Mb5XHIWGr7b558GEOOb2r5FHJPWDDXvblM+79XB2y0U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bOk5x51y25LRYYj3sNqKQwXDYQ1cNp0H68MAnoQIBOypNHn3Uhndxgf8RshrSdWHj
         wx7g3J3IwnlhiPKvIcEY1IBRS7qlMXLUAE3U7kpmdPn/MGerWVCK/qI/kp9uaOBk8b
         PDoXDKZM40ALOhBOn04MGQ3FyGUzgN0NKYlYw2BD8VmvOcqUuWzea8viG7D66aoTLV
         xebsVr46m6GkgCS8B32a5XN8T5uonHkLEZolWchTRVePUxohJkzv2NMaZ9NZ5D0vkM
         fQO7TgYW8xcHKp8WHifVkSVluBfIF0+65bNTJpYh8l/cqFd1MSSeQKeObFbePIiYkY
         TOYJzQVn5zRWw==
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
Subject: Re: [PATCH 4/5] mt76: mt7915: add Kconfig entry for MT7986
References: <351271a274dc236f027c58487df6b21c7dbf9fd0.1641886298.git.Bo.Jiao@mediatek.com>
        <d63ae1dfe22f90e0a9fa4ccc01152e82287ea0da.1641886298.git.Bo.Jiao@mediatek.com>
Date:   Tue, 11 Jan 2022 12:43:01 +0200
In-Reply-To: <d63ae1dfe22f90e0a9fa4ccc01152e82287ea0da.1641886298.git.Bo.Jiao@mediatek.com>
        (Bo Jiao's message of "Tue, 11 Jan 2022 15:51:07 +0800")
Message-ID: <87r19ek0y2.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bo Jiao <bo.jiao@mediatek.com> writes:

> From: Bo Jiao <Bo.Jiao@mediatek.com>
>
> This enables building support for the MT7986 SoC built-in WLAN chip.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
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

Why 'default y'?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
