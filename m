Return-Path: <linux-wireless+bounces-27953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D672BD244F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 11:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BBFD342204
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B92F28EF;
	Mon, 13 Oct 2025 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A3RmQx9m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA12FD1B6
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347409; cv=none; b=U9Or7zzvqvOLW0I6JFEAY3QmUAy/uQnzpGvqr8rS7GtmtHLyzSuUfIisSvntr9078s1lZnWLeAw/yV0/280+8MeIQrCOPlF5XSC5O0eieTPWdlsL0XCg+OjKP8Bit/OEXtXaYNsDr326V7LZHmxc1TmYjW+rq6QXCDMw1oSVpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347409; c=relaxed/simple;
	bh=wzHuBDOU8kepU+v/s/kU0biC94VoWJWWLYgEY55sewM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1LB8NUckyta54KBOdBclOKWV/0C2g4agjBCdhJjJpAWlOJldCqKosxuf5iuhXyvd8ssYDsVc16GBl3/lBWskfTddRyiPkf4UEMs1oILglJCvKt3gIEPsyt9r4Lp9lB5A2VTNf4k/P3JHfbJSwYuvprBTtWhGfFSAuoO95RErDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A3RmQx9m; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760347405;
	bh=wzHuBDOU8kepU+v/s/kU0biC94VoWJWWLYgEY55sewM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A3RmQx9mY3Mbvkt/m+Q54nSz2oBNeLtAGVRadSuAurMJDO8WG5GtuU3NWLDCUW0NR
	 7mHvRv2tQSfuXf5GRV3kSWwsdkBPv6qDWdc8XHpNIl29XF7jL3U1YKVqz1FRYogFxq
	 okj1XCfPw+d8O5x8vjmhGzvryt8keQMKtYbVcnuPGTdorNU0v5TFZSQJgvjJjuc9tC
	 w1wNsAk2H1UActkUfKK7iLt2tkwIZOtCiIIjg9g9E9kYNRxr4jvFxDGFNgWQwyS3xj
	 Q/N970Ooa+DipdNDQbujbbbHCQF0ARayiDN+HZbWn67bGo2zGBRryYstTNlABIED59
	 DAm9WMXEV35ag==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 965E717E0CF8;
	Mon, 13 Oct 2025 11:23:24 +0200 (CEST)
Message-ID: <4716fb90-a6d3-41f0-af8f-b6eb64dca36a@collabora.com>
Date: Mon, 13 Oct 2025 11:23:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7996: fix FCS error flag check in RX
 descriptor
To: Alok Tiwari <alok.a.tiwari@oracle.com>, sean.wang@mediatek.com,
 chui-hao.chiu@mediatek.com, Bo.Jiao@mediatek.com,
 howard-yh.hsu@mediatek.com, meichia.chiu@mediatek.com,
 Money.Wang@mediatek.com, StanleyYP.Wang@mediatek.com, nbd@nbd.name,
 lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
 matthias.bgg@gmail.com, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
References: <20251013090826.753992-1-alok.a.tiwari@oracle.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251013090826.753992-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/10/25 11:08, Alok Tiwari ha scritto:
> The mt7996 driver currently checks the MT_RXD3_NORMAL_FCS_ERR bit in
> rxd1 whereas other Connac3-based drivers(mt7925) correctly check this
> bit in rxd3.
> 
> Since the MT_RXD3_NORMAL_FCS_ERR bit is defined in the fourth RX
> descriptor word (rxd3), update mt7996 to use the proper descriptor
> field. This change aligns mt7996 with mt7925 and the rest of the
> Connac3 family.
> 
> Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> index 9501def3e0e3..59744e5593b6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -527,7 +527,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
>   	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
>   		skb->ip_summed = CHECKSUM_UNNECESSARY;
>   
> -	if (rxd1 & MT_RXD3_NORMAL_FCS_ERR)
> +	if (rxd3 & MT_RXD3_NORMAL_FCS_ERR)
>   		status->flag |= RX_FLAG_FAILED_FCS_CRC;
>   
>   	if (rxd1 & MT_RXD1_NORMAL_TKIP_MIC_ERR)




