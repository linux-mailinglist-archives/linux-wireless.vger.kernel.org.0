Return-Path: <linux-wireless+bounces-251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE507FFAED
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB325281776
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1922063;
	Thu, 30 Nov 2023 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcpwT9cr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A629F22061
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 19:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C40CC433C8;
	Thu, 30 Nov 2023 19:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701371598;
	bh=Byw3Ja8D98qaaMIkq6NR0yFqF4YxOUcmr+nbGdlYZbA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=QcpwT9cr6VnKlFKhpZTU8AJ6xS/OkxTlZHu897PUrxvEb73G+gy4AhQ1b2TCp9cGe
	 KiG3QwWb64sxola+sTovgNLk3SzvK4/rVT5CC4OfjeXQOQ5ZDIbJ+41GtdcnU84Kpp
	 Vh1xYgFovu9ScfxihtLf7I9Ej39BWAx+OSLPyK+tWdAt3FKv++Z+K5T5BqJebq7kvO
	 DJyDgINL1G+sAyc2E8JkOaLyKBJ8mEKotWKsTkRibVZwOU6TURBLhDuxE//MpOvbH/
	 d84hGgDW/B4nVNdf7YzTeb3DGrEzxRyt5qK+Z08VjafR7LfmB7r/TI/mGjq+2MNNuw
	 CX/rhxWXCzzhg==
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
Message-ID: <170137159397.1963309.4329648460865757143.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 19:13:15 +0000 (UTC)

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

Did this fix Lukas' problem? I couldn't see any answer to Ping's
question.

Patch set to Deferred.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231120115726.1569323-1-martin.blumenstingl@googlemail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


