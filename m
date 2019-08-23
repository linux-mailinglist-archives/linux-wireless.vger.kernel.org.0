Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415139AAB3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391180AbfHWIw0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 04:52:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfHWIw0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 04:52:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEF0010BFB3F;
        Fri, 23 Aug 2019 08:52:25 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1EAD2633C;
        Fri, 23 Aug 2019 08:52:22 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [PATCH 1/3] mt76: remove redundant mt76_txq_schedule_all
Date:   Fri, 23 Aug 2019 10:52:15 +0200
Message-Id: <1566550337-6287-2-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1566550337-6287-1-git-send-email-sgruszka@redhat.com>
References: <1566550337-6287-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Fri, 23 Aug 2019 08:52:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Waking tx queues will cause that txq's will be scheduled. Calling
mt76_txq_schedule_all() while queues are blocked is not necessary.
We will not get any skb's from ieee80211_tx_dequeue() anyway, but
patch changes that transmit of mtxq->retry_q skb's will be a bit
deferred (on the moment after channel switch or other situation
when we wake up queues).

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c      | 1 -
 drivers/net/wireless/mediatek/mt76/mt7603/main.c     | 2 --
 drivers/net/wireless/mediatek/mt76/mt7615/main.c     | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c     | 2 --
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c    | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c | 2 --
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c | 1 -
 7 files changed, 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index c328192307c4..eb33de264c8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1344,7 +1344,6 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	napi_schedule(&dev->mt76.napi[1]);
 
 	ieee80211_wake_queues(dev->mt76.hw);
-	mt76_txq_schedule_all(&dev->mt76);
 }
 
 static u32 mt7603_dma_debug(struct mt7603_dev *dev, u8 index)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 25d5b1608bc9..3a1b18795e05 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -170,8 +170,6 @@ void mt7603_init_edcca(struct mt7603_dev *dev)
 
 	clear_bit(MT76_RESET, &dev->mt76.state);
 
-	mt76_txq_schedule_all(&dev->mt76);
-
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     msecs_to_jiffies(MT7603_WATCHDOG_TIME));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 87c748715b5d..41ca44ffb058 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -158,7 +158,6 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 	clear_bit(MT76_RESET, &dev->mt76.state);
 	mutex_unlock(&dev->mt76.mutex);
 
-	mt76_txq_schedule_all(&dev->mt76);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT7615_WATCHDOG_TIME);
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index 3bc665643e51..562249eb918c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -33,8 +33,6 @@
 	}
 	mt76x02_pre_tbtt_enable(dev, true);
 
-	mt76_txq_schedule_all(&dev->mt76);
-
 	return ret;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index dc773070481d..fdc0297c1d27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -513,7 +513,6 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 		ieee80211_restart_hw(dev->mt76.hw);
 	} else {
 		ieee80211_wake_queues(dev->mt76.hw);
-		mt76_txq_schedule_all(&dev->mt76);
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 4971685aafe8..8275a211fd20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -68,8 +68,6 @@
 	tasklet_enable(&dev->dfs_pd.dfs_tasklet);
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
-	mt76_txq_schedule_all(&dev->mt76);
-
 	return ret;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index eb73cb856c81..d5bfffd6099d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -58,7 +58,6 @@ static void mt76x2u_stop(struct ieee80211_hw *hw)
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76x02_pre_tbtt_enable(dev, true);
-	mt76_txq_schedule_all(&dev->mt76);
 
 	return err;
 }
-- 
1.9.3

