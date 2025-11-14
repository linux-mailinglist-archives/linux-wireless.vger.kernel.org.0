Return-Path: <linux-wireless+bounces-28987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B980C5D4F9
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0248635A5A4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F230CD95;
	Fri, 14 Nov 2025 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFNLCcRk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194821C16E
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126202; cv=none; b=F4K4uIt88aOiXvVvJ2tU4+bihJneLZyiPWfN4bLihftSRxV0DJJ4WIgQoD/hY+0wghpjPXZQAOmHQdziwnDlcJfdVitEzW2gkEYLNPorzYhzjN6cujwIxuPmObx3aiNW/5ssxBSe0CNvD/W+S8ePkew1KOFJvOoEYVHr8TgWkac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126202; c=relaxed/simple;
	bh=B9sQVFNQ2iult3wzpWjgBPdLQuokvzOXDSS+NbRKykU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFxA0t/vKoFfzO0+Tdi5K5JJhltKg3GiKV48WKNYo8izgrjcSF7wNSuivqQe7zmlAN/qQp9zXVlRu+i1wa8aWe3zA0MUT9Hq9EKchg/ToGviCQKQmbbZnYMAZQKTXVAeEOGgR/e8tO3u8MvrdBSczCfSaC3MGWsHEDiEm8zyCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFNLCcRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF770C19421;
	Fri, 14 Nov 2025 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763126202;
	bh=B9sQVFNQ2iult3wzpWjgBPdLQuokvzOXDSS+NbRKykU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MFNLCcRko7ggpc2psHhcp3j4YsqbyC87QS1N/ldNIbyF3Gh+wf5yq9i8JvWGXVn/6
	 FbKBr4vm1x+IYwjt2CB3iZlp7R8G/MguKrHsi3V+iZf5N619G0nMFEQQ9u2tp5jO/u
	 9y9eq/fcaelyis/5g5QHYMMnG9EL6Okx4Agrl7vfA58TysvMO2aVmeazjIZcMaiyhq
	 wQTBPImflGhVqo6ojSP/0rzhFTn6QQbMsLSjZxAsLpIehToKxA1k9ZklrGIwkew1tf
	 uGbg2bak0vybCZ1NF9H2/KT99aoSbOTEYvnmAa33uX4DxtkL4h2jfGSso5wGXS1qRC
	 E1r7DnKM2J3XA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 14 Nov 2025 14:16:23 +0100
Subject: [PATCH mt76 3/4] wifi: mt76: Move mt76_abort_scan out of
 mt76_reset_device()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt76-fix-missing-mtx-v1-3-259ebf11f654@kernel.org>
References: <20251114-mt76-fix-missing-mtx-v1-0-259ebf11f654@kernel.org>
In-Reply-To: <20251114-mt76-fix-missing-mtx-v1-0-259ebf11f654@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Move mt76_abort_scan routine out of mt76_reset_device() in order to
avoid a possible deadlock since mt76_reset_device routine is running
with mt76 mutex help and mt76_abort_scan_complete() can grab mt76 mutex
in some cases.

Fixes: b36d55610215a ("wifi: mt76: abort scan/roc on hw restart")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c   | 2 --
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5ceaf78c9ea064bf898c347c611a7ccdf9cb9ebc..5e75861bf6f990dc5745b81224faf705395e894d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -847,8 +847,6 @@ void mt76_reset_device(struct mt76_dev *dev)
 	}
 	rcu_read_unlock();
 
-	mt76_abort_scan(dev);
-
 	INIT_LIST_HEAD(&dev->wcid_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	dev->vif_mask = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1c0d310146d63bc39357d604b549c83e37c8da35..5caf818e8283438ee3c79124384636cbdd641780 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1451,6 +1451,8 @@ mt7915_mac_full_reset(struct mt7915_dev *dev)
 	if (ext_phy)
 		cancel_delayed_work_sync(&ext_phy->mac_work);
 
+	mt76_abort_scan(&dev->mt76);
+
 	mutex_lock(&dev->mt76.mutex);
 	for (i = 0; i < 10; i++) {
 		if (!mt7915_mac_restart(dev))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 1fac3815c523c05643705b9b6b7263a7fdf2e3a4..6fd732a924ab3a4bdc9224b8fd3cc53438e1db60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2420,6 +2420,8 @@ mt7996_mac_full_reset(struct mt7996_dev *dev)
 	mt7996_for_each_phy(dev, phy)
 		cancel_delayed_work_sync(&phy->mt76->mac_work);
 
+	mt76_abort_scan(&dev->mt76);
+
 	mutex_lock(&dev->mt76.mutex);
 	for (i = 0; i < 10; i++) {
 		if (!mt7996_mac_restart(dev))

-- 
2.51.1


