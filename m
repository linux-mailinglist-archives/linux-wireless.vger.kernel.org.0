Return-Path: <linux-wireless+bounces-25615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3FEB091F5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 18:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0336318945B0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79B82FCE2D;
	Thu, 17 Jul 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="LOF66W3d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC072FCE2A
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770119; cv=none; b=o52FTJYtZ2Gsj04EVfTdRxW9JXzgCnt3wqG2vjZwULsRt83ez7K7g/3iDI4TKgPDiGqvMkNHbFfRsCwdGEyZjh9NbCBpvZPhdjKCVZJrUuCbLsTqEY+OT6Vpg8KhlWKTTI5BY7THHXbO8B+fAu/QMB4nvsFYLt9biuGIYcLscR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770119; c=relaxed/simple;
	bh=tgDMqxJFkm8oby4Jw8aqaL2aHLXZ1DQ6it0nwKkoblA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gz3gFnkOB3uDVoUucm9qEuarBZtqGy/Fksp6uXOmReWMtMup0POS11PukW120nnZGVlTj0k3LLtNKm12O42+I7ejgRKpoVuhm+94U43w1gtvisrBElMP6k2qOUy+9+EFpoVrbDJWZUEKXovHSQ13SHKwixk4J82NfbMRqCbLmus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=LOF66W3d; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1752769689;
	bh=tgDMqxJFkm8oby4Jw8aqaL2aHLXZ1DQ6it0nwKkoblA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LOF66W3d9igU/++YmHQq/jxCih16ThS5KmSAuJCht4pN+WdnmpKFSZbaMol4Hly3A
	 eNCPAezaQSox9fxMh2SmCHhyDFLT46BePAQ7yzv2ElZn/tjz+DaDorFSKKi3B8zf5K
	 1f7Efz+3P/MtVclWupC58GXMGXFyzUVwGyotjP5w=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH wireless] wifi: mac80211: Do not schedule stopped TXQs
Date: Thu, 17 Jul 2025 18:25:46 +0200
Message-ID: <20250717162547.94582-2-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250717162547.94582-1-Alexander@wetzel-home.de>
References: <20250717162547.94582-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ignore TXQs with the flag IEEE80211_TXQ_STOP when scheduling a queue.

The flag is only set after all fragments have been dequeued and won't
allow dequeueing other frames as long as the flag is set.

For drivers using ieee80211_txq_schedule_start() this prevents an
loop trying to push the queued frames while IEEE80211_TXQ_STOP is set:

After setting IEEE80211_TXQ_STOP the driver will call
ieee80211_return_txq(). Which calls __ieee80211_schedule_txq(), detects
that there sill are frames in the queue and immediately restarts the
stopped TXQ. Which can't dequeue any frame and thus starts over the loop.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
Fixes: ba8c3d6f16a1 ("mac80211: add an intermediate software queue implementation")
---
 net/mac80211/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d58b80813bdd..4a9b258300fe 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4098,7 +4098,9 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 
 	spin_lock_bh(&local->active_txq_lock[txq->ac]);
 
-	has_queue = force || txq_has_queue(txq);
+	has_queue = force ||
+		    (!test_bit(IEEE80211_TXQ_STOP, &txqi->flags) &&
+		     txq_has_queue(txq));
 	if (list_empty(&txqi->schedule_order) &&
 	    (has_queue || ieee80211_txq_keep_active(txqi))) {
 		/* If airtime accounting is active, always enqueue STAs at the
-- 
2.50.0


