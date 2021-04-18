Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD9C3636CA
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhDRQqp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232291AbhDRQqp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37E996101E;
        Sun, 18 Apr 2021 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764377;
        bh=niXP5WXX4SN7ofupoo66EXBu0NvWD0d7lxl9KQfiIeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCy5BtJbcg0YugvdlD1h9nE8cC8aOIU4RLFhLyP/PIbM+SgFZZOQ+Wf+YKEMvaouT
         GVSFWerWFeDjYgbga22GZG47/dAQurTOf16UaVoB14D8mUVT0c9nXeoFUQLx16Jj44
         x9VgoPWL6l11KeAY5PU6uE/kxvyMRUZIdkyVWrqjZ2CEfKe7KjGAmpsRJEQ1E6ZzM5
         KV89jRhPThY/oSMESLWQ+rKyRsnl0sJme9rJDABUiGqOgXufCrbdLskJb/DX4RLfUM
         /UYYR/W0UNuQLgRl6dE5WaWWrm3qPyurGVNWFY+M3foCmNEWrd3pVGRc8QEu9vrwE2
         uxG/S2WyNvMOA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 16/19] mt76: connac: use waitqueue for runtime-pm
Date:   Sun, 18 Apr 2021 18:45:42 +0200
Message-Id: <3a23a827d4ed990bb89bdfa988d0c3c072ce06ac.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Simplify the code using a wait_queue_head_t instead of a completion to
wait the chip is fully awake in mt76_connac_pm_wake routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7921/init.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 3ef6bcdf38c4..894b2588e075 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -508,7 +508,7 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	INIT_WORK(&dev->pm.wake_work, mt7615_pm_wake_work);
 	spin_lock_init(&dev->pm.wake.lock);
 	mutex_init(&dev->pm.mutex);
-	init_completion(&dev->pm.wake_cmpl);
+	init_waitqueue_head(&dev->pm.wait);
 	spin_lock_init(&dev->pm.txq_lock);
 	set_bit(MT76_STATE_PM, &dev->mphy.state);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7615_mac_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index adbc726149a9..747bf90f9d8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1919,7 +1919,7 @@ void mt7615_pm_wake_work(struct work_struct *work)
 	}
 
 	ieee80211_wake_queues(mphy->hw);
-	complete_all(&dev->pm.wake_cmpl);
+	wake_up(&dev->pm.wait);
 }
 
 void mt7615_pm_power_save_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 116d800c9f9d..e3937f6d3640 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -53,7 +53,7 @@ struct mt76_connac_pm {
 	} tx_q[IEEE80211_NUM_ACS];
 
 	struct work_struct wake_work;
-	struct completion wake_cmpl;
+	wait_queue_head_t wait;
 
 	struct {
 		spinlock_t lock;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index a263921d9f42..66f1667481e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -17,10 +17,10 @@ int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 	if (!test_bit(MT76_STATE_PM, &phy->state))
 		return 0;
 
-	if (queue_work(dev->wq, &pm->wake_work))
-		reinit_completion(&pm->wake_cmpl);
-
-	if (!wait_for_completion_timeout(&pm->wake_cmpl, 3 * HZ)) {
+	queue_work(dev->wq, &pm->wake_work);
+	if (!wait_event_timeout(pm->wait,
+				!test_bit(MT76_STATE_PM, &phy->state),
+				3 * HZ)) {
 		ieee80211_wake_queues(phy->hw);
 		return -ETIMEDOUT;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index ce0e231ab772..2d8dba000d0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -225,7 +225,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	INIT_WORK(&dev->pm.wake_work, mt7921_pm_wake_work);
 	spin_lock_init(&dev->pm.wake.lock);
 	mutex_init(&dev->pm.mutex);
-	init_completion(&dev->pm.wake_cmpl);
+	init_waitqueue_head(&dev->pm.wait);
 	spin_lock_init(&dev->pm.txq_lock);
 	set_bit(MT76_STATE_PM, &dev->mphy.state);
 	INIT_LIST_HEAD(&dev->phy.stats_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 90ede75cfba8..7b5323181fac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1530,7 +1530,7 @@ void mt7921_pm_wake_work(struct work_struct *work)
 	}
 
 	ieee80211_wake_queues(mphy->hw);
-	complete_all(&dev->pm.wake_cmpl);
+	wake_up(&dev->pm.wait);
 }
 
 void mt7921_pm_power_save_work(struct work_struct *work)
-- 
2.30.2

