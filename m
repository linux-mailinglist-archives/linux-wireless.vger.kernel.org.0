Return-Path: <linux-wireless+bounces-39122-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 75GCFKfxVmpRDQEAu9opvQ
	(envelope-from <linux-wireless+bounces-39122-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 04:34:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0D75A136
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 04:34:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=justthetip.ca header.s=key1 header.b=e9sQeS6Q;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39122-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39122-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=justthetip.ca;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA1EF306EC99
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 02:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BBB2D23BC;
	Wed, 15 Jul 2026 02:34:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82425776
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 02:34:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784082848; cv=none; b=O+a7cYQg4C96HnCEO48nRWZNlq3EMYqB/yevsuuAttAhzMdx6nLcZeoijVEiLnUNsF/IeHnq0uASnL4szSOtRQ+kPniCoXRou6JyYbuMnS52TIZlS4qYheFYBM0N4NmbtzA43TogFvXg4w1SzC2wsIDl3OFuxwuFjM3r3j0q+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784082848; c=relaxed/simple;
	bh=XloxarATvvc6obZbG9ptzmyAyD6oB1YSxDo+LloYbkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0wScWFcvP9oUjYQu6TE14R+JCuP/sMsO1oyregETCyzmaYs3agmW2vNoo3pspmSEplLXbkREvIMoM5C2Kp58MHcnM+Lq2aCOni+UZZO9i+xhcpRed4opfgobgRiRVongXGc4DZICARHrvUzMNDCZHHhq+WBGQi9SeoFdp4BHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=e9sQeS6Q; arc=none smtp.client-ip=91.218.175.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1784082833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QBzn7CXfWlMFnmV74qQc7JiAa/KsrEa75UUZXtLUUkA=;
	b=e9sQeS6QsPz8PhAeRRbs+/VhE0988YSWlyFV828iS5e5FlQZbU3nVqtGks5xQj7c6GiJE9
	ZzYToa1ogGhncuzwcvXZJyCaeEktiYJSpuRdfAVnFDY8fP5x5mXg24LN1BjQ9ARrJYyrVq
	95uW0I+JZ/1hE1UEcmxFm1m8tqpVfCD+Vy63HIRp76DyIeK4RvJE84+Z3emHpcJ1LtwJCk
	oXWWV4usTXkh2zdkoXh7BnZHBrGbb4WiknUK3FoSlqMz3bMNdb3oFjyFkAWjt2slOeN1Gt
	J0o2ElOFkCu06v75dg2IQmE14ybH0PN5Ez7AaaruBKVfXRYcPs5KHbVzvkUw+w==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH wireless] wifi: mt76: mt7925: ensure tx headroom in usb_sdio_tx_prepare_skb
Date: Tue, 14 Jul 2026 19:33:48 -0700
Message-ID: <20260715023348.59506-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39122-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:deren.wu@mediatek.com,m:mingyen.hsieh@mediatek.com,m:quan.zhou@mediatek.com,m:linux-wireless@vger.kernel.org,m:stable@vger.kernel.org,m:lucid_duck@justthetip.ca,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,justthetip.ca:from_mime,justthetip.ca:mid,justthetip.ca:email,justthetip.ca:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2E0D75A136

mt7925_usb_sdio_tx_prepare_skb() pushes a TX descriptor and a USB
header onto every skb and assumes the headroom for them is already
there. That holds for locally generated traffic, where mac80211
reserves hw->extra_tx_headroom, but forwarded frames are sent through
ieee80211_8023_xmit(), which does not reserve it. Bridge a wired
interface to an mt7925u AP and the first forwarded frame that arrives
short panics the kernel:

 skbuff: skb_under_panic: len:415 put:4 tail:0x19b end:0x640 dev:wlan1
 kernel BUG at net/core/skbuff.c:212!
 Call trace:
  skb_panic+0x58/0x60 (P)
  skb_push+0x58/0x60
  mt7925_usb_sdio_tx_prepare_skb+0xf8/0x1b8 [mt7925_common]
  mt76u_tx_queue_skb+0xa0/0x1f8 [mt76_usb]
  __mt76_tx_queue_skb+0x54/0xe8 [mt76]
  mt76_txq_schedule.part.0+0x204/0x478 [mt76]
  mt76_txq_schedule_all+0x50/0x80 [mt76]
  mt792x_tx_worker+0x68/0x100 [mt792x_lib]
  __mt76_worker_fn+0x84/0x150 [mt76]

Whether a given setup hits it depends on how much headroom the ingress
netdev leaves in its rx skbs. Reproduced on a Raspberry Pi 5 bridging
onboard ethernet to a Netgear A9000; originally reported on an MT7986
router running OpenWrt. Nick Morrow's testing on a Pi 4 (bcmgenet),
which leaves more headroom, helped narrow the trigger to the ingress
path.

The same bug was fixed on mt7921 by commit 98c4d0abf5c4 ("mt76:
mt7921: don't assume adequate headroom for SDIO headers"), but mt7925
was copied from mt7921 without the fix. Add the same guard here.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Link: https://github.com/morrownr/mt76/issues/52
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 0641a7131d7c..a515147a6ccf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1427,6 +1427,10 @@ int mt7925_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
+	err = skb_cow_head(skb, MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE);
+	if (err)
+		return err;
+
 	if (sta) {
 		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
-- 
2.55.0


