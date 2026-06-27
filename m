Return-Path: <linux-wireless+bounces-38208-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AMDhDhIhQGpjcAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38208-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 21:14:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 895126D2885
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 21:14:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=justthetip.ca header.s=key1 header.b=o0YtgnpS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38208-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38208-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=justthetip.ca;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E39E83029252
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 19:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B5C3451B5;
	Sat, 27 Jun 2026 19:13:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB233B6C4
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 19:13:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782587632; cv=none; b=RxBSHcnKO1Fw3oWkrSMSLX3tG9QEN8kf19W26A9uvPrPlKd0pIT2YfMyESToPsf8YMYwy0cFiCKU4SDxdm513BgQGxbUc/79zrNMAMbdV/hNT7gpr3Te06VnVUae9BJbLC3kIqbCK7uA99bGJCnZKTrYMZDwv8Kyqn23y5kPEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782587632; c=relaxed/simple;
	bh=FGC/zP+YF/PQQkGwZPuaeuoGfCHAlRt9DMUDA3jqKmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOoVa6SLyAavEWhzavPD6f9jWw5pTkXS/LY6yPhxCcs5lhjbokRPN/gtRWIX4kZ88wM9lC+ca93Klx7FGg2rjPYD/yPis4MgcETNn9ZfF6EB75ySUY8WxcDY3+EbgD5mmUcf8qb/3PjOGqbDoFZ/1OHvzcqKGq4zYnVW2BrFXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=o0YtgnpS; arc=none smtp.client-ip=91.218.175.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1782587628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/LbuPLV8G+3ghp9tHGo/cT7j2hO0ahRag2fTXp2F+Y=;
	b=o0YtgnpSWnMPCB6NNfFjt/RbAeBgcvkCoyugP/Kkz/E4TfDCW+ZSgBzwISTGISCY1FTW8u
	yezC7xY76xYIYqI0mfGsm0Aq0kGpdT8M5u55cOYMiAtEfh5Kz+yHxvcg7CRjgGCdFUBfDW
	uOpn+eUCsiQ8z1GmB0WAmXy0g1ND7UatFEmiPxn8+Sd1BQzhFH2kcVVt2opHVVNeJzNUgD
	5LKevYtqi2ZredZr85yNHMKfOEDnW09c/E5YCBvH5eDB3jmWbnH74WGrQbyYONKeHnkY3u
	/PKSxHj8oMF0cF8ip3FFAn0HkBUEO+miavp/IGnQQLDqaeFbQJr0himn1sLbcA==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	linux-wireless@vger.kernel.org
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses
Date: Sat, 27 Jun 2026 12:13:36 -0700
Message-ID: <20260627191336.20223-4-lucid_duck@justthetip.ca>
In-Reply-To: <20260627191336.20223-1-lucid_duck@justthetip.ca>
References: <20260627191336.20223-1-lucid_duck@justthetip.ca>
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
	TAGGED_FROM(0.00)[bounces-38208-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:linux-wireless@vger.kernel.org,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:mingyen.hsieh@mediatek.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,justthetip.ca:dkim,justthetip.ca:email,justthetip.ca:mid,justthetip.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 895126D2885

PKT_TYPE_TXRX_NOTIFY is an mmio-only event, but mt7615_rx_check() and
mt7615_queue_rx_skb() dispatch it to mt7615_mac_tx_free() on every bus.
mt7615_mac_tx_free() cleans the DMA tx queues with
mt76_queue_tx_cleanup(), which calls queue_ops->tx_cleanup(). Only the
mmio queue ops implement that callback; on the mt7663 USB and SDIO
buses it is NULL, so a TXRX_NOTIFY there calls a NULL pointer in the RX
worker. Same defect as the mt7921 and mt7925 patches in this series.

Drop the event on non-mmio buses via mt76_is_mmio(), as in
commit 5683e1488aa9 ("wifi: mt76: connac: do not check WED status for
non-mmio devices").

Fixes: eb99cc95c3b6 ("mt76: mt7615: introduce mt7663u support")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ce0051468501..aad232c5a6fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1601,6 +1601,8 @@ bool mt7615_rx_check(struct mt76_dev *mdev, void *data, int len)
 
 	switch (type) {
 	case PKT_TYPE_TXRX_NOTIFY:
+		if (!mt76_is_mmio(mdev))
+			return false;
 		mt7615_mac_tx_free(dev, data, len);
 		return false;
 	case PKT_TYPE_TXS:
@@ -1634,6 +1636,10 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_TXRX_NOTIFY:
+		if (!mt76_is_mmio(mdev)) {
+			dev_kfree_skb(skb);
+			break;
+		}
 		mt7615_mac_tx_free(dev, skb->data, skb->len);
 		dev_kfree_skb(skb);
 		break;
-- 
2.54.0


