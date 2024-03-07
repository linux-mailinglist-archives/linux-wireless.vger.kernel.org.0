Return-Path: <linux-wireless+bounces-4472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712D87572B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C7D284D07
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC8B1369B5;
	Thu,  7 Mar 2024 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Lch9Qr2v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921531369A5
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839809; cv=none; b=sgfxBLTQ86BhN9RDCBLWQd5aCnVKtQi3sCRV72M7bYLL/GNIXYr/pegXNZqyYBtA8yPZmABgyvwpvDJKmpBcEHQfndl5thR6qxXnJa+ek9vP41Xw63zVUHMkq+UojgrPip917sWsWlpjKNGkgufOeodK+jrDnRkVuKskyAViwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839809; c=relaxed/simple;
	bh=rz0UWo4M0Y/5XqRmFHUvTF57ACW4KzUMAQaLJ/wXVi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tdbnd+EqzqCDpEOphzXaJU3H5tim8NHeuMvDQFnQLIY+UHaD8QbtmT7jcDM1D9B58hQjtsBHCicg0oNgWkjtzTuG0f6tbb1Jk5YtGnXdgC1ieqKW0V9wVJApNuaIHgh6O88BdGEsFe0843DeVjTax6Zkvrfa+qTE+7sDN42Wqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Lch9Qr2v; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B63CF503545
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:30:06 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 67E318C006C
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:29:59 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id EEA5913C2B4;
	Thu,  7 Mar 2024 11:29:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EEA5913C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709839799;
	bh=rz0UWo4M0Y/5XqRmFHUvTF57ACW4KzUMAQaLJ/wXVi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lch9Qr2vb0iXdHMdiJJHcBup2rVm7Y9yAK36RGCUcDnovjp0J8DiRUS9Gy+QWMLsY
	 4jpEoKMZJSmtUPGfMT2Z9VVDohWwoWGYTVS7fQzfnlm/bPdbkGzlqLNNd/AV5BpHrM
	 1uBq+64mdBKAoXRrcjbiHulvQeQ9St6BZYFsUNLU=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 4/6] wifi: mt76: mt7915: Mitigate mcu communication loss.
Date: Thu,  7 Mar 2024 11:29:49 -0800
Message-ID: <20240307192951.3271156-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240307192951.3271156-1-greearb@candelatech.com>
References: <20240307192951.3271156-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1709839800-eh3T4hxW4-xa
X-MDID-O:
 us5;at1;1709839800;eh3T4hxW4-xa;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Many calls that end up sending mcu messages to the firmware hold
RTNL or other important locks.  So when radio stops answering,
the entire system becomes very sluggish.

Add timeout counter, and if radio times out 3 times in a row,
consider it dead and no longer attempt to talk to it.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c        | 14 ++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h       |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 00230f106294..4d1426093e1e 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -510,6 +510,20 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 	if (test_bit(MT76_MCU_RESET, &dev->phy.state))
 		goto error;
 
+	/* Check for non responsive radios.  Better to just stop sending it messages
+	 * than continuously block the OS (since rtnl and similar are often held while
+	 * the timeout is happening).
+	 */
+	if (dev->mcu_timeouts > MAX_MCU_TIMEOUTS) {
+		static unsigned long last_log;
+
+		if (time_after(jiffies, last_log + 5 * HZ)) {
+			last_log = jiffies;
+			mtk_dbg(dev, WRN, "mt76-dma-tx-queue-skb-raw, too many timeouts, msg is dropped.\n");
+		}
+		goto error;
+	}
+
 	if (q->queued + 1 >= q->ndesc - 1)
 		goto error;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index dd8a24cda48a..b052a9c24c73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -832,6 +832,9 @@ struct mt76_dev {
 	struct mt76_mcu mcu;
 	u32 first_failed_mcu_cmd; /* for debugging */
 	u32 last_successful_mcu_cmd; /* for debugging */
+	u32 mcu_timeouts; /* sequential timeout counter */
+	#define MAX_MCU_TIMEOUTS 3
+
 
 	struct net_device napi_dev;
 	struct net_device tx_napi_dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index c67c4f6ca2aa..f3e60fba48b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -161,11 +161,13 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	int ret = 0;
 
 	if (!skb) {
+		mdev->mcu_timeouts++;
 		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
 			cmd, seq);
 		return -ETIMEDOUT;
 	}
 
+	mdev->mcu_timeouts = 0;
 	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 	if (seq != rxd->seq &&
 	    !(rxd->eid == MCU_CMD_EXT_CID &&
-- 
2.42.0


