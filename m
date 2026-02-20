Return-Path: <linux-wireless+bounces-32052-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGOzBzU1mGn/CgMAu9opvQ
	(envelope-from <linux-wireless+bounces-32052-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 11:19:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E57166C6D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 11:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 819883032DF1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0037830DD1F;
	Fri, 20 Feb 2026 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="iS+zoyC5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26915624B
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582768; cv=none; b=t64i65GEgMRH8zAMLyI/kwPqcFiNpXWmdzMFJtyelthX41oeQzX8PdaCDNMydl0e0YEBrI1HMIxU3Cjc6W0SnVndBfICdknF+0FqExFnDE4vqvosKXvzP00lj7Ei+v3JIf5cG74ihW6pXdjZ7lD4Dcrm5Cg+iASg7I6mg1iZpFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582768; c=relaxed/simple;
	bh=UnkpEkowG5e7Fdh9qGpydUmEnUzI9qD4clSZ2ZTDZ5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3d1J6LOOsdXaG6e7CoqYyNZgy09tNf3RbnL0TNFU0pA/i/Q/V+6p4Pi8FGzylH+Wrb2RdeoMGUo/nHZJeCgLwElrjGEehUuH2XLvrdY+ESaw3RpA4epBJwwFWyC0Xo1JNic2tc4jMgNVZg6NUyOvJx/L+p7tHMud2rvPBvw64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=iS+zoyC5; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8875C41F93;
	Fri, 20 Feb 2026 11:09:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1771582177; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZEnBQTzrEXfGRJZ0vwGdsn5LJQVzUrtWPfVR8wUTzHo=;
	b=iS+zoyC5cE/li4csAMJpwWo/TAfqMWhlRJ6jl+TzPXKxZy8/ATYT2bBiJRsKhD4L+IrYR1
	acFVUQQD9i2WFKqcem/0+89Vf4U42vF7PzJJGZXX+XeqJb9yfO8yYkK1y8O6NgqOlHrl23
	7LLP3qi1LZRdAPBRkHn6E+Z2l+JX3CJfrE5WTaEg6dJ6xtz+0t/6TJoApcKVzh4+60LV+q
	jzTgxdnVK7cNenVUIhtS5u8gt0NoIS3o4N29RXy+Lpsx5jYOMD+ECil8nVbZIz7/SFVftM
	qnaqnrsrTjvQxsElPDKyofeafCNFAKo7fUc3K3u/0908NbXHj73xDXhu1nYf6Q==
Message-ID: <39e814ff-2ea2-4984-9e8a-2902fef7c4bc@manjaro.org>
Date: Fri, 20 Feb 2026 11:09:33 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] wifi: mt76: mt7921: handle MT7902 irq_map quirk
 with mutable copy
To: sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Sean Wang <sean.wang@mediatek.com>, Xiong Huang <xiong.huang@mediatek.com>
References: <20260219004007.19733-1-sean.wang@kernel.org>
 <20260219004007.19733-3-sean.wang@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20260219004007.19733-3-sean.wang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[manjaro.org,quarantine];
	R_DKIM_ALLOW(-0.20)[manjaro.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32052-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[manjaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[philm@manjaro.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93E57166C6D
X-Rspamd-Action: no action

Hi Sean,

on Linus master tree we still have 'mt76_mmio_init(&dev->mt76, 
pcim_iomap_table(pdev)[0]);', hence your patch currently won't apply.

On 2/19/26 01:39, sean.wang@kernel.org wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>
> MT7902 PCIe requires a different wm2_complete_mask value, so introduce a
> mutable per-device copy of the default irq_map and override the field
> only for this chip. Other devices continue using the shared const
> template.
>
> This is a prerequisite patch before enabling MT7902 PCIe support.
>
> Co-developed-by: Xiong Huang <xiong.huang@mediatek.com>
> Signed-off-by: Xiong Huang <xiong.huang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> index 65c7fe671137..5f857a21f362 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -327,6 +327,20 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>   	dev->hif_ops = &mt7921_pcie_ops;
>   	dev->irq_map = &irq_map;
>   	mt76_mmio_init(&dev->mt76, regs);
> +
> +	if (id->device == 0x7902) {
> +		struct mt792x_irq_map *map;
> +
> +		/* MT7902 needs a mutable copy because wm2_complete_mask differs */
> +		map = devm_kmemdup(&pdev->dev, &irq_map,
> +				   sizeof(irq_map), GFP_KERNEL);
> +		if (!map)
> +			return -ENOMEM;
> +
> +		map->rx.wm2_complete_mask = 0;
> +		dev->irq_map = map;
> +	}
> +
>   	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
>   
>   	dev->phy.dev = dev;


-- 
Best, Philip


