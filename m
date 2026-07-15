Return-Path: <linux-wireless+bounces-39132-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AiYUO3EwV2qbHAEAu9opvQ
	(envelope-from <linux-wireless+bounces-39132-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 09:02:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C475B467
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 09:02:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39132-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39132-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=jmu.edu.cn (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74B2F30179ED
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 07:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208303128B8;
	Wed, 15 Jul 2026 07:00:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366A1FE47B
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 07:00:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098833; cv=none; b=e7/dB4DiYx3CXYdcH8VuzwFux5tUedIOSaTsxTaMKSC/8H+KCcGnjTfEYl7yCh17hXtfP8VvQ0A2W+35uU4GE5Ic+5yRVlQy3oPCALPcFCIIrpSvuMCGlPImF3wL+bHNHMtmgQ/U/HWysaontfmNp0lSAWUhAXOvNJ2GHzhSYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098833; c=relaxed/simple;
	bh=4eDdTqEB1Gun4SoGkPLjKPW4NFZppzGKV9RYKPzblCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtGyMj2PN4UZl/eqaPEjOn3lHpuEfqzGxJP6aVnxKKEgeQkjAgeVh3A5y5qiHLCGMK1+F3aRHmIbCEo0xZMVQVdQPOZoyglj0hy/hAxZ8v8+Ny83RD9iSHAGZcIjMOG2ZdWMMPUsIHcgjQZg5jLrD3io4Hw47yB8jnoxLj6YTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Received: from Vostro-3710.. (unknown [113.80.141.85])
	by smtp.qiye.163.com (Hmail) with ESMTP id 463f9b657;
	Wed, 15 Jul 2026 15:00:16 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: lorenzo@kernel.org
Cc: Bo.Jiao@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	matthias.bgg@gmail.com,
	nbd@nbd.name,
	rex.lu@mediatek.com,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com,
	sujuan.chen@mediatek.com,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH mt76 v5 16/16] wifi: mt76: mt7996: Add SW path for HW-RRO v3.1
Date: Wed, 15 Jul 2026 15:00:01 +0800
Message-Id: <20260715070001.1503928-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909-mt7996-rro-rework-v5-16-7d66f6eb7795@kernel.org>
References: <20250909-mt7996-rro-rework-v5-16-7d66f6eb7795@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f64937fd903a2kunm1a12fe196dbc0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkJKVhlOGR5ISRlNTU0aT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSkhVQ0tVSk9KVUNOWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[jmu.edu.cn : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39132-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:Bo.Jiao@mediatek.com,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:matthias.bgg@gmail.com,m:nbd@nbd.name,m:rex.lu@mediatek.com,m:ryder.lee@mediatek.com,m:sean.wang@mediatek.com,m:shayne.chen@mediatek.com,m:sujuan.chen@mediatek.com,m:amadeus@jmu.edu.cn,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[amadeus@jmu.edu.cn,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amadeus@jmu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,collabora.com,lists.infradead.org,vger.kernel.org,gmail.com,nbd.name,jmu.edu.cn];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jmu.edu.cn:from_mime,jmu.edu.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C1C475B467

Hi,

> +	if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
> +		/* rxdmad_c */
> +		mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].flags = MT_WED_RRO_Q_RXDMAD_C;

This introduces the RRO_Q_RXDMAD_C flag for the MT7992 chipset.
However, the mt76_wed_dma_setup function lacks handling for
MT76_WED_RRO_Q_RXDMAD_C, causing it to return -EINVAL:

[   20.049167] mt7996e 0000:01:00.0: attaching wed device 0 version 3
[   20.114412] platform 15010000.wed: MTK WED WO Firmware Version: ..
[   20.123728] platform 15010000.wed: MTK WED WO Chip ID 00 Region 2
[   20.965401] mt7996e 0000:01:00.0: probe with driver mt7996e failed with error -22

Can you fix this?

Thanks,
Chukun

