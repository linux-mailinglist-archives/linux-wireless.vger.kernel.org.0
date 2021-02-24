Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F1323B4E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 12:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhBXLa1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 06:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234794AbhBXLaW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 06:30:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C816860234;
        Wed, 24 Feb 2021 11:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614166179;
        bh=ps5/nopHF9fEUgUZpu3dgBnogKNlx8ahrNF0l6QkK9w=;
        h=From:To:Cc:Subject:Date:From;
        b=ZtL/IF4fdvwoutOlAGQuOZs1zZSI+XpgSh6I/HBfYtJFyYifkz5Qe+D1qc955a+gF
         1li9aADDXH72eqmujh+MGQkloaieWvv7ssBkVBDKwmvvtt1Y63yKxD2KZYyU3jiWzQ
         nS4sQmZoE/RNpJSWG2LXg08XO1La1ETMzWtX0hWwagj2mXwsj0VTrkKosvCBbq7IIn
         HnVlgNYOtVLWYKAGHGcW5DGHZxirDF/xYV8KlfvR6dxTXcCqv0RVtlrh7bIDkgmOUU
         c7t8YQovpFZdTmtRIeutxlCbYfg4MYH67DHbE080aqf6uvSGoD26kusu2x/4lDyIrj
         o2E1ApykCqVUg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: check return value of mt76_txq_send_burst in mt76_txq_schedule_list
Date:   Wed, 24 Feb 2021 12:29:34 +0100
Message-Id: <2a5884d08a07483945434e76f329ad563879291a.1614165764.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since mt76_txq_send_burst routine can report a negative error code,
check the returned value before incrementing the number of transmitted
frames in mt76_txq_schedule_list routine.
Return -EBUSY directly if the device is in reset or in power management.

Fixes: 90fdc1717b186 ("mt76: use mac80211 txq scheduling")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index b8fe8adc43a3..451ed60c6296 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -461,11 +461,11 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 	int ret = 0;
 
 	while (1) {
+		int n_frames = 0;
+
 		if (test_bit(MT76_STATE_PM, &phy->state) ||
-		    test_bit(MT76_RESET, &phy->state)) {
-			ret = -EBUSY;
-			break;
-		}
+		    test_bit(MT76_RESET, &phy->state))
+			return -EBUSY;
 
 		if (dev->queue_ops->tx_cleanup &&
 		    q->queued + 2 * MT_TXQ_FREE_THR >= q->ndesc) {
@@ -497,11 +497,16 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 		}
 
 		if (!mt76_txq_stopped(q))
-			ret += mt76_txq_send_burst(phy, q, mtxq);
+			n_frames = mt76_txq_send_burst(phy, q, mtxq);
 
 		spin_unlock_bh(&q->lock);
 
 		ieee80211_return_txq(phy->hw, txq, false);
+
+		if (unlikely(n_frames < 0))
+			return n_frames;
+
+		ret += n_frames;
 	}
 
 	return ret;
-- 
2.29.2

