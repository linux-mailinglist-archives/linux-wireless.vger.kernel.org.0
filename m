Return-Path: <linux-wireless+bounces-258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A097FFB84
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5424F28199A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A852F80;
	Thu, 30 Nov 2023 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mntre.com header.i=@mntre.com header.b="uQjeu4yz"
X-Original-To: linux-wireless@vger.kernel.org
X-Greylist: delayed 569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 11:40:08 PST
Received: from softboy.mntmn.com (softboy.mntmn.com [91.250.115.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC55293;
	Thu, 30 Nov 2023 11:40:08 -0800 (PST)
From: Lukas F. Hartmann <lukas@mntre.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 softboy.mntmn.com B2C34720F02
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mntre.com;
	s=mntremail; t=1701372636;
	bh=i3XHqgENCD1BVsHIAts2MPe8L5K/nDu57j6R0DSlv1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uQjeu4yz5XLuWYHu0sgR04X0ZMiTT4rC+fprj0jQp5a1TmpLINaNaZfnUrTLNphpw
	 08BPDZawonmtUAIfa5QoIxOAG6PFvGTLT54aslQxBWUdEErSKTj9Bn8g6Yo4av9qBW
	 aL1jgZFvO+5aipvS31Y/fMwznWc8vdebF6ofnHRme6Mrodb/KLdnNM96NNGl0IKHAT
	 ALq2G/onS5XScsSvNXtdh+37F0V3/MhKE+cI3AOdSVBP5LxRu9CNPa7GSRMqatEIIW
	 RymN9SDPI5hY0I85FpwFQJ4Iw5IJSc65z82RNV6kkF+lQ/cAAN7hmV+/v2/RnBuAfR
	 jApji+lvVH6+w==
To: Kalle Valo <kvalo@kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 jernej.skrabec@gmail.com, pkshih@realtek.com, ulf.hansson@linaro.org,
 tony0620emma@gmail.com, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in
 the RX path
In-Reply-To: <170137159397.1963309.4329648460865757143.kvalo@kernel.org>
References: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
 <170137159397.1963309.4329648460865757143.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 20:30:33 +0100
Message-ID: <87edg7ujhi.fsf@mntre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Ping-Ke, Kalle, Martin,

sorry for my late reply. Yes, this patch fixes my original problems and
I have usable WiFi now. There are still some remaining problems like
connection dropouts every minute or so, but it's unrelated and a topic
of further investigation. 

Tested-by: Lukas F. Hartmann <lukas@mntre.com>

Best
Lukas
-- 
Lukas F. Hartmann, CEO
MNT Research GmbH
https://mntre.com

Kalle Valo <kvalo@kernel.org> writes:

> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
>> Lukas reports skb_over_panic errors on his Banana Pi BPI-CM4 which comes
>> with an Amlogic A311D (G12B) SoC and a RTL8822CS SDIO wifi/Bluetooth
>> combo card. The error he observed is identical to what has been fixed
>> in commit e967229ead0e ("wifi: rtw88: sdio: Check the HISR RX_REQUEST
>> bit in rtw_sdio_rx_isr()") but that commit didn't fix Lukas' problem.
>> 
>> Lukas found that disabling or limiting RX aggregation works around the
>> problem for some time (but does not fully fix it). In the following
>> discussion a few key topics have been discussed which have an impact on
>> this problem:
>> - The Amlogic A311D (G12B) SoC has a hardware bug in the SDIO controller
>>   which prevents DMA transfers. Instead all transfers need to go through
>>   the controller SRAM which limits transfers to 1536 bytes
>> - rtw88 chips don't split incoming (RX) packets, so if a big packet is
>>   received this is forwarded to the host in it's original form
>> - rtw88 chips can do RX aggregation, meaning more multiple incoming
>>   packets can be pulled by the host from the card with one MMC/SDIO
>>   transfer. This Depends on settings in the REG_RXDMA_AGG_PG_TH
>>   register (BIT_RXDMA_AGG_PG_TH limits the number of packets that will
>>   be aggregated, BIT_DMA_AGG_TO_V1 configures a timeout for aggregation
>>   and BIT_EN_PRE_CALC makes the chip honor the limits more effectively)
>> 
>> Use multiple consecutive reads in rtw_sdio_read_port() and limit the
>> number of bytes which are copied by the host from the card in one
>> MMC/SDIO transfer. This allows receiving a buffer that's larger than
>> the hosts max_req_size (number of bytes which can be transferred in
>> one MMC/SDIO transfer). As a result of this the skb_over_panic error
>> is gone as the rtw88 driver is now able to receive more than 1536 bytes
>> from the card (either because the incoming packet is larger than that
>> or because multiple packets have been aggregated).
>> 
>> In case of an receive errors (-EILSEQ has been observed by Lukas) we
>> need to drain the remaining data from the card's buffer, otherwise the
>> card will return corrupt data for the next rtw_sdio_read_port() call.
>> 
>> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
>> Reported-by: Lukas F. Hartmann <lukas@mntre.com>
>> Closes: https://lore.kernel.org/linux-wireless/CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com/
>> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>
> Did this fix Lukas' problem? I couldn't see any answer to Ping's
> question.
>
> Patch set to Deferred.
>
> -- 
> https://patchwork.kernel.org/project/linux-wireless/patch/20231120115726.1569323-1-martin.blumenstingl@googlemail.com/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

