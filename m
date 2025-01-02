Return-Path: <linux-wireless+bounces-17012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024F9FFBDD
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0C91883919
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6681A8F80;
	Thu,  2 Jan 2025 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="AgVtuNTM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1174156236
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835725; cv=none; b=CY93BHo2TwSgwXcQ7tLKlEH7xRg/S1HCbzpb9UgW4DeFLkdrVgAJI+ve9xjPDWgvLj9qjRvYYWuJoV+RF4TXysXgsUknw2aBA6saeHwGeXBuf4Dh2nJrHRIdeVyx06dI+oVrLiHia90hYQvbnIB/zTqR3WZWQNsKHDPRg3Emjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835725; c=relaxed/simple;
	bh=hU3zsoyQudQJkeEa5bTrRLZbbt35IrFNZx4ebX73aU4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sgj8FVsn8RYd1xDtRKtXeeye+OS+vv00F6M8EBeMHQ2edNXQwmcItMrRHsLeTQRgyynDyQ3L/3lllt1kbOpy/AVbCR2FRK7otEspUGIfrqSD4jPUehwSo3yXYFvx5u8rZ4E8/NPL3XK+nV5veOgQoK2zsosrMIP+Uc2KcqCq8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=AgVtuNTM; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=F6q0Gs2cisZX3A2+pb3h3nEtSB0K9yy33G/tF3zmInY=; b=AgVtuNTMIZjvuLk4D3hfEonSPb
	VZuPFj77avOHqEuhV1WX7DpnJXANcii4A8pxSYpncGrOYV5bbwgYUydzByCC8B394jUiIDx2dls27
	qBWa68l/vUWVv9Iwrz1WIFgm2XnoLdiPl2NGzNCooD7u+SQByKqLggSis8g/7dU67MX4=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAD-0008GS-03
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:13 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 10/24] wifi: mt76: add multi-radio support to tx scheduling
Date: Thu,  2 Jan 2025 17:34:54 +0100
Message-ID: <20250102163508.52945-10-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Look up the phy for each scheduled txq. Only run one scheduling loop per hw.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 33 ++++++++++++++-----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index ce193e625666..af0c50c983ec 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -489,7 +489,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 
 	do {
 		if (test_bit(MT76_RESET, &phy->state) || phy->offchannel)
-			return -EBUSY;
+			break;
 
 		if (stop || mt76_txq_stopped(q))
 			break;
@@ -522,24 +522,16 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 static int
 mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
-	struct mt76_queue *q = phy->q_tx[qid];
 	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_txq *txq;
 	struct mt76_txq *mtxq;
 	struct mt76_wcid *wcid;
+	struct mt76_queue *q;
 	int ret = 0;
 
 	while (1) {
 		int n_frames = 0;
 
-		if (test_bit(MT76_RESET, &phy->state) || phy->offchannel)
-			return -EBUSY;
-
-		if (dev->queue_ops->tx_cleanup &&
-		    q->queued + 2 * MT_TXQ_FREE_THR >= q->ndesc) {
-			dev->queue_ops->tx_cleanup(dev, q, false);
-		}
-
 		txq = ieee80211_next_txq(phy->hw, qid);
 		if (!txq)
 			break;
@@ -549,6 +541,16 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 		if (!wcid || test_bit(MT_WCID_FLAG_PS, &wcid->flags))
 			continue;
 
+		phy = mt76_dev_phy(dev, wcid->phy_idx);
+		if (test_bit(MT76_RESET, &phy->state) || phy->offchannel)
+			continue;
+
+		q = phy->q_tx[qid];
+		if (dev->queue_ops->tx_cleanup &&
+		    q->queued + 2 * MT_TXQ_FREE_THR >= q->ndesc) {
+			dev->queue_ops->tx_cleanup(dev, q, false);
+		}
+
 		if (mtxq->send_bar && mtxq->aggr) {
 			struct ieee80211_txq *txq = mtxq_to_txq(mtxq);
 			struct ieee80211_sta *sta = txq->sta;
@@ -578,7 +580,7 @@ void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
 	int len;
 
-	if (qid >= 4 || phy->offchannel)
+	if (qid >= 4)
 		return;
 
 	local_bh_disable();
@@ -680,9 +682,14 @@ static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 
 void mt76_txq_schedule_all(struct mt76_phy *phy)
 {
+	struct mt76_phy *main_phy = &phy->dev->phy;
 	int i;
 
 	mt76_txq_schedule_pending(phy);
+
+	if (phy != main_phy && phy->hw == main_phy->hw)
+		return;
+
 	for (i = 0; i <= MT_TXQ_BK; i++)
 		mt76_txq_schedule(phy, i);
 }
@@ -693,6 +700,7 @@ void mt76_tx_worker_run(struct mt76_dev *dev)
 	struct mt76_phy *phy;
 	int i;
 
+	mt76_txq_schedule_all(&dev->phy);
 	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {
 		phy = dev->phys[i];
 		if (!phy)
@@ -748,9 +756,6 @@ void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
 
-	if (!test_bit(MT76_STATE_RUNNING, &phy->state))
-		return;
-
 	mt76_worker_schedule(&dev->tx_worker);
 }
 EXPORT_SYMBOL_GPL(mt76_wake_tx_queue);
-- 
2.47.1


