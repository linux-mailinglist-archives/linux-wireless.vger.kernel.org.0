Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1873736949F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbhDWO2A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 10:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238918AbhDWO2A (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 10:28:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14C096141C;
        Fri, 23 Apr 2021 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619188044;
        bh=835O6aF5aOFD0RLTg7zJDzDxfjv8h4WJpuNJyNW5v8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYE4Z7Nkyjky8w9jAVu6iu+xA7qQZwGfI61Xmax1skkkxfvNcb/9+YGCoGYIroI+x
         gOaXQycGIQqX8D8kqVdnsqfTOOB3SQbT+UniemnsBlWopKhkW7MFDpYUQPsDJqU926
         SIEbJgE25/OgjOVprC/ajwhMRVN3PSl+NT96hfusuBSx2wjYndQDDwG/SKR1qBbDVU
         MHsHMGqGQcL5u8Y7Ui34QtxXmuVCVDjilaDQFyDTUKjBo4iwMvdzZjl6nXOFr0zU2c
         L5kkodB8SovPh9WghKQSRhZiim/a8Zwb9eOTVoLYoJiUp+7DW3rxA7ZsPD48+Rqk82
         6YOyPgCPmlHsQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, kvalo@codeaurora.org
Subject: [PATCH 3/3] mt76: connac: do not schedule mac_work if the device is not running
Date:   Fri, 23 Apr 2021 16:27:11 +0200
Message-Id: <5bfd36a75799c37b12fcb54d17e77fbc2c7a0558.1619187875.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619187875.git.lorenzo@kernel.org>
References: <cover.1619187875.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not run ieee80211_queue_delayed_work for mac work if the worqueue is
not initialized yet

Fixes: b1bd7bb8121d ("mt76: connac: unschedule mac_work before going to sleep")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f81a17d56008..e2dcfee6be81 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1912,8 +1912,9 @@ void mt7615_pm_wake_work(struct work_struct *work)
 			napi_schedule(&dev->mt76.napi[i]);
 		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
 		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
-		ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
-					     MT7615_WATCHDOG_TIME);
+		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
+			ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+						     MT7615_WATCHDOG_TIME);
 	}
 
 	ieee80211_wake_queues(mphy->hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 214bd1859792..decf2d5f0ce3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1404,8 +1404,9 @@ void mt7921_pm_wake_work(struct work_struct *work)
 			napi_schedule(&dev->mt76.napi[i]);
 		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
 		mt7921_tx_cleanup(dev);
-		ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
-					     MT7921_WATCHDOG_TIME);
+		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
+			ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+						     MT7921_WATCHDOG_TIME);
 	}
 
 	ieee80211_wake_queues(mphy->hw);
-- 
2.30.2

