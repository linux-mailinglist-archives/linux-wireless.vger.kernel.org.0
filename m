Return-Path: <linux-wireless+bounces-294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704A2800B30
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 13:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09801C20F3D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8092555F;
	Fri,  1 Dec 2023 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG2Cbeai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDA25558
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 12:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439F5C433C7;
	Fri,  1 Dec 2023 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701434438;
	bh=d5Is7DQQkDJQMABKZBG5rDA8xuTnzdXWxPreoL723b0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=WG2CbeairoHsy0gK2p97pSYlOfS093EuRS0fW5qaFiw1EKDUd5+2w656xYh8Y59+9
	 dI7NHtmY4JtBeDVaraF2UTZan7aHmY/V3l1li7Pvfi5SGnfu+BTmvUCwVadvrJ8I6G
	 /aGgUBg1oMs9UFImNjeZBZsot9G2c6qEHfIUUNDrccqp0Mk4krsTYistNW22igei6X
	 0PufkONn8ybPJVt4Q4QYUosjCNS1cVObmGKMjyosmFUsvoLbArQ7LGWVwIwMSbzUGf
	 YdyaXzlnyMmGp3eOhpByaI4WCd6cJPYWKGIJ32EEicdWHi97+O4mzP46LPZisLY1hC
	 3KYyeN+NuIM1A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in the
 RX
 path
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
References: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 jernej.skrabec@gmail.com, pkshih@realtek.com, ulf.hansson@linaro.org,
 tony0620emma@gmail.com, lukas@mntre.com,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170143443423.2072551.2418172782235693510.kvalo@kernel.org>
Date: Fri,  1 Dec 2023 12:40:36 +0000 (UTC)

Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Lukas reports skb_over_panic errors on his Banana Pi BPI-CM4 which comes
> with an Amlogic A311D (G12B) SoC and a RTL8822CS SDIO wifi/Bluetooth
> combo card. The error he observed is identical to what has been fixed
> in commit e967229ead0e ("wifi: rtw88: sdio: Check the HISR RX_REQUEST
> bit in rtw_sdio_rx_isr()") but that commit didn't fix Lukas' problem.
> 
> Lukas found that disabling or limiting RX aggregation works around the
> problem for some time (but does not fully fix it). In the following
> discussion a few key topics have been discussed which have an impact on
> this problem:
> - The Amlogic A311D (G12B) SoC has a hardware bug in the SDIO controller
>   which prevents DMA transfers. Instead all transfers need to go through
>   the controller SRAM which limits transfers to 1536 bytes
> - rtw88 chips don't split incoming (RX) packets, so if a big packet is
>   received this is forwarded to the host in it's original form
> - rtw88 chips can do RX aggregation, meaning more multiple incoming
>   packets can be pulled by the host from the card with one MMC/SDIO
>   transfer. This Depends on settings in the REG_RXDMA_AGG_PG_TH
>   register (BIT_RXDMA_AGG_PG_TH limits the number of packets that will
>   be aggregated, BIT_DMA_AGG_TO_V1 configures a timeout for aggregation
>   and BIT_EN_PRE_CALC makes the chip honor the limits more effectively)
> 
> Use multiple consecutive reads in rtw_sdio_read_port() and limit the
> number of bytes which are copied by the host from the card in one
> MMC/SDIO transfer. This allows receiving a buffer that's larger than
> the hosts max_req_size (number of bytes which can be transferred in
> one MMC/SDIO transfer). As a result of this the skb_over_panic error
> is gone as the rtw88 driver is now able to receive more than 1536 bytes
> from the card (either because the incoming packet is larger than that
> or because multiple packets have been aggregated).
> 
> In case of an receive errors (-EILSEQ has been observed by Lukas) we
> need to drain the remaining data from the card's buffer, otherwise the
> card will return corrupt data for the next rtw_sdio_read_port() call.
> 
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
> Reported-by: Lukas F. Hartmann <lukas@mntre.com>
> Closes: https://lore.kernel.org/linux-wireless/CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com/
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Lukas F. Hartmann <lukas@mntre.com>
> Reported-by: Lukas F. Hartmann <lukas@mntre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Lukas F. Hartmann <lukas@mntre.com>

Patch applied to wireless-next.git, thanks.

00384f565a91 wifi: rtw88: sdio: Honor the host max_req_size in the RX path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231120115726.1569323-1-martin.blumenstingl@googlemail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


