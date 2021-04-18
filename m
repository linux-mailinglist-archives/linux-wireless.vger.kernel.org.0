Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D643636C9
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhDRQqo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235116AbhDRQqo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB5DF6135A;
        Sun, 18 Apr 2021 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764375;
        bh=gWWC0kLj+/onH16d7Y7k/H4oCo8jS8ZOCSlLf1GA1s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9nC6kcNBE/xByhWUG/uePEXx7sPGJHxEBfVt9ivilIpD+h5dSBkf2IrT5KCJ9Spo
         /dYZlBctafJTBohLc4uiL9CaasnYaARJVWpJxOWgGMhOE2dKxJPbQ9zkXfOLUxsWfZ
         GQmIAppCexXTjArfrKQU/SsYw0MxybMGQJhH7h5lvg33tcZVupUfubK7imBzOhhlUs
         g+iI8nCg9OlXUmFFKY+MdSltlNV/HWobnDCWVSyo//aLUQY15/G/j77cpCJPbxBOEd
         qlcg2GCIs7jQExSdLHliSaD0h1SCOLmtHqxpcVQz944Gt/WbuwmIWciJG6TaUiwENB
         M+71GQtSxQTAA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 15/19] mt76: connac: do not run mt76_txq_schedule_all directly
Date:   Sun, 18 Apr 2021 18:45:41 +0200
Message-Id: <06a3ef66e14927d527e9f9137858ae8762b31e82.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to not break runtime-pm, do run mt76_txq_schedule_all in
mt7615_set_channel/mt7921_set_channel but rely on mt76_worker_schedule

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index a3e53d3aec02..39733b351ac4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -351,8 +351,7 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 
 	mt7615_mutex_release(dev);
 
-	mt76_txq_schedule_all(phy->mt76);
-
+	mt76_worker_schedule(&dev->mt76.tx_worker);
 	if (!mt76_testmode_enabled(phy->mt76))
 		ieee80211_queue_delayed_work(phy->mt76->hw,
 					     &phy->mt76->mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 95e1775c5c00..255a931675bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -395,8 +395,7 @@ int mt7921_set_channel(struct mt7921_phy *phy)
 	clear_bit(MT76_RESET, &phy->mt76->state);
 	mt7921_mutex_release(dev);
 
-	mt76_txq_schedule_all(phy->mt76);
-
+	mt76_worker_schedule(&dev->mt76.tx_worker);
 	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mt76->mac_work,
 				     MT7921_WATCHDOG_TIME);
 
-- 
2.30.2

