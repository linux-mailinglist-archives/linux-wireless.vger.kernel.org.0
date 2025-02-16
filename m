Return-Path: <linux-wireless+bounces-19022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1907A37515
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7096188F057
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9E19ABCE;
	Sun, 16 Feb 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="eftaTH0l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7908119415E
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719952; cv=none; b=AN2m9/+kYz5OT7p6qCTlZenQddXBfhmL3GpX3YSBlupFi7s8PKTpEAfW2Nf5kR1okXwtB8qr7nmdjz2JYmr5hmryKK4ADnX+vIH6ZxDydCFrM69uq9U7XcB/XpkCGWQ52GibCADz9TgK8o3/hlNYtI8EBysnq1+oJUFEIfRhsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719952; c=relaxed/simple;
	bh=p55KjNpClbkbJXXke8jSz4UBKJ64b6g7ag6N5Gsh3yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIm+eoP6EGXbzwMcuee5mzlEWCSz8tMCjpWfgFkn60QdXL1cQS8B4vldignHghLSPVESD6f1oYRKMKurtUUFLUCseeRKFBzhVCkpz7aLiDHVZZydDTTeyWdSjuhwmirnzKh4sr7/j74/F80E1bVGpiRvgIrNbPItXaTccsmu00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=eftaTH0l; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739719938;
	bh=p55KjNpClbkbJXXke8jSz4UBKJ64b6g7ag6N5Gsh3yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eftaTH0lj04bdonOOLSmMGdNv8raBvlJ8Z9A11PxUfsRW5jGAYh4R0uYVawtMsWd2
	 8JoYTorRMq8kreOa4rlFA1bRx/q9qFZeyn318BO+jLvBIdZ+TJzb8MZals8WRs8eM1
	 aAeIUFg2VoHR+7iwZtD7I4yrm2nqFyiUbd2Pinpg=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH 06/10] wifi: mac80211: Call ieee80211_tx_h_select_key only once
Date: Sun, 16 Feb 2025 16:31:56 +0100
Message-ID: <20250216153200.1318604-7-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216153200.1318604-1-Alexander@wetzel-home.de>
References: <20250216153200.1318604-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ieee80211_tx_dequeue() already calls ieee80211_tx_h_select_key() when
needed. Move it from invoke_tx_handlers_early() to invoke_tx_handlers()
to avoid calling it twice for TXQs.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
 net/mac80211/tx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6190674c8517..0e99d6bc02c0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1693,7 +1693,6 @@ static int invoke_tx_handlers_early(struct ieee80211_tx_data *tx)
 	CALL_TXH(ieee80211_tx_h_check_assoc);
 	CALL_TXH(ieee80211_tx_h_ps_buf);
 	CALL_TXH(ieee80211_tx_h_check_control_port_protocol);
-	CALL_TXH(ieee80211_tx_h_select_key);
 
  txh_done:
 	if (unlikely(res == TX_DROP)) {
@@ -1761,6 +1760,17 @@ static int invoke_tx_handlers(struct ieee80211_tx_data *tx)
 
 	if (r)
 		return r;
+
+	r = ieee80211_tx_h_select_key(tx);
+	if (unlikely(r != TX_CONTINUE)) {
+		I802_DEBUG_INC(tx->local->tx_handlers_drop);
+		if (tx->skb)
+			ieee80211_free_txskb(&tx->local->hw, tx->skb);
+		else
+			ieee80211_purge_tx_queue(&tx->local->hw, &tx->skbs);
+		return -1;
+	}
+
 	return invoke_tx_handlers_late(tx);
 }
 
-- 
2.48.1


