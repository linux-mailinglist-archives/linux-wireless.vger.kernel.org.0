Return-Path: <linux-wireless+bounces-27388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78960B7DE58
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49FC16260C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A292EAB85;
	Tue, 16 Sep 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="IxgD8H9l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32A1C5486
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061585; cv=none; b=m9CWkFjNr2upgj31jtV/hHmkOnLB2vhVozjoPu7EQbBF0yVIej4A1gxjLXGSesek8yc12TC+6x6AMt+gOFdcKx+2P6QKEbBnjaUzplyTUShdTp5F7tcz0qLejymWuobHaJX9PdepDBBEzZnl9hCZeMoHD23zhaSbGAJ1cacV2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061585; c=relaxed/simple;
	bh=GtT+Ler0k8Kxb0MEWxDTD28blEbHvDaUs2lJHa+Cpg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGmyd2VVkZZxBv8hDX4Kjdk8bsMxsi1Ztd9CLTDWcT60V8uzstDx+ZU+XuVnmrn1p39ih0mHA6DOfeZDENvFd6Hr8cqSvggdvlCAHf0jFOwOmnpG+18zuqJJ2bdgZweIMAoacmagpAn/UN1eB6F54/2j0oa8W1H6hnsA8kLwiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=IxgD8H9l; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061584; x=1789597584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GtT+Ler0k8Kxb0MEWxDTD28blEbHvDaUs2lJHa+Cpg0=;
  b=IxgD8H9lHI+TZtsA7gwKaEdIHZmttn42whqOohy4kybBTA1W+uxuJEbJ
   J+gRGh70mlpN4TKO3usJlQ6I2qnobPMjfwhUZ/xQy2E8b1Au2fwnnf8sa
   JIfQvwqsNgHWe42n1RVB9JGHvAIBb4U4Q+1b2HF/YJijZWv7MhxOeveOj
   Y=;
X-CSE-ConnectionGUID: UNJTxeE6TMWf4+fREW2Sbw==
X-CSE-MsgGUID: mC2OyxpPRf6RHvdrv7bW5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99294124"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99294124"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:26:22 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:26:20 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:26:18 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 33/57] wifi: inffmac: add flowring.c/h
Date: Wed, 17 Sep 2025 03:47:53 +0530
Message-ID: <20250916221821.4387-39-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE814.infineon.com (172.23.29.40) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of the Ring buffers used for TX Data path
communication with the Infineon WLAN Device via the PCIe bus using a
shared memory.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/flowring.c  | 492 ++++++++++++++++++
 .../net/wireless/infineon/inffmac/flowring.h  |  74 +++
 2 files changed, 566 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/flowring.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/flowring.h

diff --git a/drivers/net/wireless/infineon/inffmac/flowring.c b/drivers/net/wireless/infineon/inffmac/flowring.c
new file mode 100644
index 000000000000..5724904e995c
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/flowring.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include "utils.h"
+
+#include "core.h"
+#include "debug.h"
+#include "bus.h"
+#include "proto.h"
+#include "flowring.h"
+#include "msgbuf.h"
+#include "common.h"
+
+#define INFF_FLOWRING_HIGH		1024
+#define INFF_FLOWRING_LOW		(INFF_FLOWRING_HIGH - 256)
+#define INFF_FLOWRING_INVALID_IFIDX	0xff
+
+#define INFF_FLOWRING_HASH_AP(da, fifo, ifidx) (da[5] * 2 + (fifo) + (ifidx) * 16)
+#define INFF_FLOWRING_HASH_STA(fifo, ifidx) ((fifo) + (ifidx) * 16)
+
+static const u8 inff_flowring_prio2fifo[] = {
+	0,
+	1,
+	1,
+	0,
+	2,
+	2,
+	3,
+	3
+};
+
+static const u8 ALLFFMAC[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+
+static bool
+inff_flowring_is_tdls_mac(struct inff_flowring *flow, u8 mac[ETH_ALEN])
+{
+	struct inff_flowring_tdls_entry *search;
+
+	search = flow->tdls_entry;
+
+	while (search) {
+		if (memcmp(search->mac, mac, ETH_ALEN) == 0)
+			return true;
+		search = search->next;
+	}
+
+	return false;
+}
+
+u32 inff_flowring_lookup(struct inff_flowring *flow, u8 da[ETH_ALEN],
+			 u8 prio, u8 ifidx)
+{
+	struct inff_flowring_hash *hash;
+	u16 hash_idx;
+	u32 i;
+	bool found;
+	bool sta;
+	u8 fifo;
+	u8 *mac;
+
+	fifo = inff_flowring_prio2fifo[prio];
+	sta = (flow->addr_mode[ifidx] == ADDR_INDIRECT);
+	mac = da;
+	if (!sta && (is_multicast_ether_addr(da))) {
+		mac = (u8 *)ALLFFMAC;
+		fifo = 0;
+	}
+	if ((sta) && flow->tdls_active &&
+	    (inff_flowring_is_tdls_mac(flow, da))) {
+		sta = false;
+	}
+	hash_idx =  sta ? INFF_FLOWRING_HASH_STA(fifo, ifidx) :
+			  INFF_FLOWRING_HASH_AP(mac, fifo, ifidx);
+	hash_idx &= (INFF_FLOWRING_HASHSIZE - 1);
+	found = false;
+	hash = flow->hash;
+	for (i = 0; i < INFF_FLOWRING_HASHSIZE; i++) {
+		if ((sta || (memcmp(hash[hash_idx].mac, mac, ETH_ALEN) == 0)) &&
+		    hash[hash_idx].fifo == fifo &&
+		    hash[hash_idx].ifidx == ifidx) {
+			found = true;
+			break;
+		}
+		hash_idx++;
+		hash_idx &= (INFF_FLOWRING_HASHSIZE - 1);
+	}
+	if (found)
+		return hash[hash_idx].flowid;
+
+	return INFF_FLOWRING_INVALID_ID;
+}
+
+u32 inff_flowring_create(struct inff_flowring *flow, u8 da[ETH_ALEN],
+			 u8 prio, u8 ifidx)
+{
+	struct inff_flowring_ring *ring;
+	struct inff_flowring_hash *hash;
+	u16 hash_idx;
+	u32 i;
+	bool found;
+	u8 fifo;
+	bool sta;
+	u8 *mac;
+
+	fifo = inff_flowring_prio2fifo[prio];
+	sta = (flow->addr_mode[ifidx] == ADDR_INDIRECT);
+	mac = da;
+	if (!sta && (is_multicast_ether_addr(da))) {
+		mac = (u8 *)ALLFFMAC;
+		fifo = 0;
+	}
+	if ((sta) && flow->tdls_active &&
+	    (inff_flowring_is_tdls_mac(flow, da))) {
+		sta = false;
+	}
+	hash_idx =  sta ? INFF_FLOWRING_HASH_STA(fifo, ifidx) :
+			  INFF_FLOWRING_HASH_AP(mac, fifo, ifidx);
+	hash_idx &= (INFF_FLOWRING_HASHSIZE - 1);
+	found = false;
+	hash = flow->hash;
+	for (i = 0; i < INFF_FLOWRING_HASHSIZE; i++) {
+		if (hash[hash_idx].ifidx == INFF_FLOWRING_INVALID_IFIDX &&
+		    (is_zero_ether_addr(hash[hash_idx].mac))) {
+			found = true;
+			break;
+		}
+		hash_idx++;
+		hash_idx &= (INFF_FLOWRING_HASHSIZE - 1);
+	}
+	if (found) {
+		for (i = 0; i < flow->nrofrings; i++) {
+			if (!flow->rings[i])
+				break;
+		}
+		if (i == flow->nrofrings)
+			return -ENOMEM;
+
+		ring = kzalloc(sizeof(*ring), GFP_ATOMIC);
+		if (!ring)
+			return -ENOMEM;
+
+		memcpy(hash[hash_idx].mac, mac, ETH_ALEN);
+		hash[hash_idx].fifo = fifo;
+		hash[hash_idx].ifidx = ifidx;
+		hash[hash_idx].flowid = i;
+
+		ring->hash_id = hash_idx;
+		ring->status = RING_CLOSED;
+		skb_queue_head_init(&ring->skblist);
+		flow->rings[i] = ring;
+
+		return i;
+	}
+	return INFF_FLOWRING_INVALID_ID;
+}
+
+u8 inff_flowring_tid(struct inff_flowring *flow, u16 flowid)
+{
+	struct inff_flowring_ring *ring;
+
+	ring = flow->rings[flowid];
+
+	return flow->hash[ring->hash_id].fifo;
+}
+
+static void inff_flowring_block(struct inff_flowring *flow, u16 flowid,
+				bool blocked)
+{
+	struct inff_flowring_ring *ring;
+	struct inff_bus *bus_if;
+	struct inff_pub *drvr;
+	struct inff_if *ifp;
+	bool currently_blocked;
+	int i;
+	u8 ifidx;
+	unsigned long flags;
+
+	spin_lock_irqsave(&flow->block_lock, flags);
+
+	ring = flow->rings[flowid];
+	if (ring->blocked == blocked) {
+		spin_unlock_irqrestore(&flow->block_lock, flags);
+		return;
+	}
+	ifidx = inff_flowring_ifidx_get(flow, flowid);
+
+	currently_blocked = false;
+	for (i = 0; i < flow->nrofrings; i++) {
+		if (flow->rings[i] && i != flowid) {
+			ring = flow->rings[i];
+			if (ring->status == RING_OPEN &&
+			    (inff_flowring_ifidx_get(flow, i) == ifidx)) {
+				if (ring->blocked) {
+					currently_blocked = true;
+					break;
+				}
+			}
+		}
+	}
+	flow->rings[flowid]->blocked = blocked;
+	if (currently_blocked) {
+		spin_unlock_irqrestore(&flow->block_lock, flags);
+		return;
+	}
+
+	bus_if = dev_get_drvdata(flow->dev);
+	drvr = bus_if->drvr;
+	ifp = inff_get_ifp(drvr, ifidx);
+	inff_txflowblock_if(ifp, INFF_NETIF_STOP_REASON_FLOW, blocked);
+
+	spin_unlock_irqrestore(&flow->block_lock, flags);
+}
+
+void inff_flowring_delete(struct inff_flowring *flow, u16 flowid)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(flow->dev);
+	struct inff_flowring_ring *ring;
+	struct inff_if *ifp;
+	u16 hash_idx;
+	u8 ifidx;
+	struct sk_buff *skb;
+
+	ring = flow->rings[flowid];
+	if (!ring)
+		return;
+
+	ifidx = inff_flowring_ifidx_get(flow, flowid);
+	ifp = inff_get_ifp(bus_if->drvr, ifidx);
+
+	inff_flowring_block(flow, flowid, false);
+	hash_idx = ring->hash_id;
+	flow->hash[hash_idx].ifidx = INFF_FLOWRING_INVALID_IFIDX;
+	eth_zero_addr(flow->hash[hash_idx].mac);
+	flow->rings[flowid] = NULL;
+
+	skb = skb_dequeue(&ring->skblist);
+	while (skb) {
+		inff_txfinalize(ifp, skb, false);
+		skb = skb_dequeue(&ring->skblist);
+	}
+
+	kfree(ring);
+}
+
+u32 inff_flowring_enqueue(struct inff_flowring *flow, u16 flowid,
+			  struct sk_buff *skb)
+{
+	struct inff_flowring_ring *ring;
+
+	ring = flow->rings[flowid];
+
+	skb_queue_tail(&ring->skblist, skb);
+
+	if (!ring->blocked &&
+	    (skb_queue_len(&ring->skblist) > INFF_FLOWRING_HIGH)) {
+		inff_flowring_block(flow, flowid, true);
+		inff_dbg(MSGBUF, "Flowcontrol: BLOCK for ring %d\n", flowid);
+		/* To prevent (work around) possible race condition, check
+		 * queue len again. It is also possible to use locking to
+		 * protect, but that is undesirable for every enqueue and
+		 * dequeue. This simple check will solve a possible race
+		 * condition if it occurs.
+		 */
+		if (skb_queue_len(&ring->skblist) < INFF_FLOWRING_LOW)
+			inff_flowring_block(flow, flowid, false);
+	}
+	return skb_queue_len(&ring->skblist);
+}
+
+struct sk_buff *inff_flowring_dequeue(struct inff_flowring *flow, u16 flowid)
+{
+	struct inff_flowring_ring *ring;
+	struct sk_buff *skb;
+
+	ring = flow->rings[flowid];
+	if (ring->status != RING_OPEN)
+		return NULL;
+
+	skb = skb_dequeue(&ring->skblist);
+
+	if (ring->blocked &&
+	    (skb_queue_len(&ring->skblist) < INFF_FLOWRING_LOW)) {
+		inff_flowring_block(flow, flowid, false);
+		inff_dbg(MSGBUF, "Flowcontrol: OPEN for ring %d\n", flowid);
+	}
+
+	return skb;
+}
+
+void inff_flowring_reinsert(struct inff_flowring *flow, u16 flowid,
+			    struct sk_buff *skb)
+{
+	struct inff_flowring_ring *ring;
+
+	ring = flow->rings[flowid];
+
+	skb_queue_head(&ring->skblist, skb);
+}
+
+u32 inff_flowring_qlen(struct inff_flowring *flow, u16 flowid)
+{
+	struct inff_flowring_ring *ring;
+
+	ring = flow->rings[flowid];
+	if (!ring)
+		return 0;
+
+	if (ring->status != RING_OPEN)
+		return 0;
+
+	return skb_queue_len(&ring->skblist);
+}
+
+void inff_flowring_open(struct inff_flowring *flow, u16 flowid)
+{
+	struct inff_flowring_ring *ring;
+
+	ring = flow->rings[flowid];
+	if (!ring) {
+		inff_err("Ring NULL, for flowid %d\n", flowid);
+		return;
+	}
+
+	ring->status = RING_OPEN;
+}
+
+u8 inff_flowring_ifidx_get(struct inff_flowring *flow, u16 flowid)
+{
+	struct inff_flowring_ring *ring;
+	u16 hash_idx;
+
+	ring = flow->rings[flowid];
+	hash_idx = ring->hash_id;
+
+	return flow->hash[hash_idx].ifidx;
+}
+
+struct inff_flowring *inff_flowring_attach(struct device *dev, u16 nrofrings)
+{
+	struct inff_flowring *flow;
+	u32 i;
+
+	flow = kzalloc(sizeof(*flow), GFP_KERNEL);
+	if (flow) {
+		flow->dev = dev;
+		flow->nrofrings = nrofrings;
+		spin_lock_init(&flow->block_lock);
+		for (i = 0; i < ARRAY_SIZE(flow->addr_mode); i++)
+			flow->addr_mode[i] = ADDR_INDIRECT;
+		for (i = 0; i < ARRAY_SIZE(flow->hash); i++)
+			flow->hash[i].ifidx = INFF_FLOWRING_INVALID_IFIDX;
+		flow->rings = kcalloc(nrofrings, sizeof(*flow->rings),
+				      GFP_KERNEL);
+		if (!flow->rings) {
+			kfree(flow);
+			flow = NULL;
+		}
+	}
+
+	return flow;
+}
+
+void inff_flowring_detach(struct inff_flowring *flow)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(flow->dev);
+	struct inff_pub *drvr = bus_if->drvr;
+	struct inff_flowring_tdls_entry *search;
+	struct inff_flowring_tdls_entry *remove;
+	u16 flowid;
+
+	for (flowid = 0; flowid < flow->nrofrings; flowid++) {
+		if (flow->rings[flowid])
+			inff_msgbuf_delete_flowring(drvr, flowid);
+	}
+
+	search = flow->tdls_entry;
+	while (search) {
+		remove = search;
+		search = search->next;
+		kfree(remove);
+	}
+	kfree(flow->rings);
+	kfree(flow);
+}
+
+void inff_flowring_configure_addr_mode(struct inff_flowring *flow, int ifidx,
+				       enum proto_addr_mode addr_mode)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(flow->dev);
+	struct inff_pub *drvr = bus_if->drvr;
+	u32 i;
+	u16 flowid;
+
+	if (flow->addr_mode[ifidx] != addr_mode) {
+		for (i = 0; i < ARRAY_SIZE(flow->hash); i++) {
+			if (flow->hash[i].ifidx == ifidx) {
+				flowid = flow->hash[i].flowid;
+				if (flow->rings[flowid]->status != RING_OPEN)
+					continue;
+				inff_msgbuf_delete_flowring(drvr, flowid);
+			}
+		}
+		flow->addr_mode[ifidx] = addr_mode;
+	}
+}
+
+void inff_flowring_delete_peer(struct inff_flowring *flow, int ifidx,
+			       u8 peer[ETH_ALEN])
+{
+	struct inff_bus *bus_if = dev_get_drvdata(flow->dev);
+	struct inff_pub *drvr = bus_if->drvr;
+	struct inff_flowring_hash *hash;
+	struct inff_flowring_tdls_entry *prev;
+	struct inff_flowring_tdls_entry *search;
+	u32 i;
+	u16 flowid;
+	bool sta;
+
+	sta = (flow->addr_mode[ifidx] == ADDR_INDIRECT);
+
+	search = flow->tdls_entry;
+	prev = NULL;
+	while (search) {
+		if (memcmp(search->mac, peer, ETH_ALEN) == 0) {
+			sta = false;
+			break;
+		}
+		prev = search;
+		search = search->next;
+	}
+
+	hash = flow->hash;
+	for (i = 0; i < INFF_FLOWRING_HASHSIZE; i++) {
+		if ((sta || (memcmp(hash[i].mac, peer, ETH_ALEN) == 0)) &&
+		    hash[i].ifidx == ifidx) {
+			flowid = flow->hash[i].flowid;
+			if (flow->rings[flowid]->status == RING_OPEN)
+				inff_msgbuf_delete_flowring(drvr, flowid);
+		}
+	}
+
+	if (search) {
+		if (prev)
+			prev->next = search->next;
+		else
+			flow->tdls_entry = search->next;
+		kfree(search);
+		if (!flow->tdls_entry)
+			flow->tdls_active = false;
+	}
+}
+
+void inff_flowring_add_tdls_peer(struct inff_flowring *flow, int ifidx,
+				 u8 peer[ETH_ALEN])
+{
+	struct inff_flowring_tdls_entry *tdls_entry;
+	struct inff_flowring_tdls_entry *search;
+
+	tdls_entry = kzalloc(sizeof(*tdls_entry), GFP_ATOMIC);
+	if (!tdls_entry)
+		return;
+
+	memcpy(tdls_entry->mac, peer, ETH_ALEN);
+	tdls_entry->next = NULL;
+	if (!flow->tdls_entry) {
+		flow->tdls_entry = tdls_entry;
+	} else {
+		search = flow->tdls_entry;
+		if (memcmp(search->mac, peer, ETH_ALEN) == 0)
+			goto free_entry;
+		while (search->next) {
+			search = search->next;
+			if (memcmp(search->mac, peer, ETH_ALEN) == 0)
+				goto free_entry;
+		}
+		search->next = tdls_entry;
+	}
+
+	flow->tdls_active = true;
+	return;
+
+free_entry:
+	kfree(tdls_entry);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/flowring.h b/drivers/net/wireless/infineon/inffmac/flowring.h
new file mode 100644
index 000000000000..ad502aa123f1
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/flowring.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_FLOWRING_H
+#define INFF_FLOWRING_H
+
+#define INFF_FLOWRING_HASHSIZE		512		/* has to be 2^x */
+#define INFF_FLOWRING_INVALID_ID	0xFFFFFFFF
+
+struct inff_flowring_hash {
+	u8 mac[ETH_ALEN];
+	u8 fifo;
+	u8 ifidx;
+	u16 flowid;
+};
+
+enum ring_status {
+	RING_CLOSED,
+	RING_CLOSING,
+	RING_OPEN
+};
+
+struct inff_flowring_ring {
+	u16 hash_id;
+	bool blocked;
+	enum ring_status status;
+	struct sk_buff_head skblist;
+};
+
+struct inff_flowring_tdls_entry {
+	u8 mac[ETH_ALEN];
+	struct inff_flowring_tdls_entry *next;
+};
+
+struct inff_flowring {
+	struct device *dev;
+	struct inff_flowring_hash hash[INFF_FLOWRING_HASHSIZE];
+	struct inff_flowring_ring **rings;
+	spinlock_t block_lock;	/* used to protect flow ring */
+	enum proto_addr_mode addr_mode[INFF_MAX_IFS];
+	u16 nrofrings;
+	bool tdls_active;
+	struct inff_flowring_tdls_entry *tdls_entry;
+};
+
+u32 inff_flowring_lookup(struct inff_flowring *flow, u8 da[ETH_ALEN],
+			 u8 prio, u8 ifidx);
+u32 inff_flowring_create(struct inff_flowring *flow, u8 da[ETH_ALEN],
+			 u8 prio, u8 ifidx);
+void inff_flowring_delete(struct inff_flowring *flow, u16 flowid);
+void inff_flowring_open(struct inff_flowring *flow, u16 flowid);
+u8 inff_flowring_tid(struct inff_flowring *flow, u16 flowid);
+u32 inff_flowring_enqueue(struct inff_flowring *flow, u16 flowid,
+			  struct sk_buff *skb);
+struct sk_buff *inff_flowring_dequeue(struct inff_flowring *flow, u16 flowid);
+void inff_flowring_reinsert(struct inff_flowring *flow, u16 flowid,
+			    struct sk_buff *skb);
+u32 inff_flowring_qlen(struct inff_flowring *flow, u16 flowid);
+u8 inff_flowring_ifidx_get(struct inff_flowring *flow, u16 flowid);
+struct inff_flowring *inff_flowring_attach(struct device *dev, u16 nrofrings);
+void inff_flowring_detach(struct inff_flowring *flow);
+void inff_flowring_configure_addr_mode(struct inff_flowring *flow, int ifidx,
+				       enum proto_addr_mode addr_mode);
+void inff_flowring_delete_peer(struct inff_flowring *flow, int ifidx,
+			       u8 peer[ETH_ALEN]);
+void inff_flowring_add_tdls_peer(struct inff_flowring *flow, int ifidx,
+				 u8 peer[ETH_ALEN]);
+
+#endif /* INFF_FLOWRING_H */
-- 
2.25.1


