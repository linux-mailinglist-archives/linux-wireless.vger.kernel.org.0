Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08E2C5448
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 13:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389522AbgKZMz0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 07:55:26 -0500
Received: from mx3.wp.pl ([212.77.101.10]:45911 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388892AbgKZMz0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 07:55:26 -0500
Received: (wp-smtpd smtp.wp.pl 29100 invoked from network); 26 Nov 2020 13:55:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1606395321; bh=Bcpqgz9nMC2b2yCKgxveFN6YnzZXtZhxC3XIUSSDvEk=;
          h=From:To:Cc:Subject;
          b=NyIPWsx+/63rBuc7QnaUYu7BqucKTBx+fYv1c9l+dPQLRX5aKiX5zgAoihSncPq9N
           BXIS3yl4w2FBjoBzqkWbvXXyeg7oVEXA/eQvgjsQ9fPmhWNL2j6PzV3oBGic91pcq6
           OEjOgAUX8ONxXAhVHZ6M01+1P6hft5NmEDrflaQ8=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-wireless@vger.kernel.org>; 26 Nov 2020 13:55:21 +0100
From:   stf_xl@wp.pl
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH 5.10] mt76: usb: fix crash on device removal
Date:   Thu, 26 Nov 2020 13:55:20 +0100
Message-Id: <20201126125520.72912-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: a93846a6806ef607c3e3a836b105f205
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [AbKU]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Stanislaw Gruszka <stf_xl@wp.pl>

Currently 'while (q->queued > 0)' loop was removed from mt76u_stop_tx()
code. This causes crash on device removal as we try to cleanup empty
queue:

[   96.495571] kernel BUG at include/linux/skbuff.h:2297!
[   96.498983] invalid opcode: 0000 [#1] SMP PTI
[   96.501162] CPU: 3 PID: 27 Comm: kworker/3:0 Not tainted 5.10.0-rc5+ #11
[   96.502754] Hardware name: LENOVO 20DGS08H00/20DGS08H00, BIOS J5ET48WW (1.19 ) 08/27/2015
[   96.504378] Workqueue: usb_hub_wq hub_event
[   96.505983] RIP: 0010:skb_pull+0x2d/0x30
[   96.507576] Code: 00 00 8b 47 70 39 c6 77 1e 29 f0 89 47 70 3b 47 74 72 17 48 8b 87 c8 00 00 00 89 f6 48 01 f0 48 89 87 c8 00 00 00 c3 31 c0 c3 <0f> 0b 90 0f 1f 44 00 00 53 48 89 fb 48 8b bf c8 00 00 00 8b 43 70
[   96.509296] RSP: 0018:ffffb11b801639b8 EFLAGS: 00010287
[   96.511038] RAX: 000000001c6939ed RBX: ffffb11b801639f8 RCX: 0000000000000000
[   96.512964] RDX: ffffb11b801639f8 RSI: 0000000000000018 RDI: ffff90c64e4fb800
[   96.514710] RBP: ffff90c654551ee0 R08: ffff90c652bce7a8 R09: ffffb11b80163728
[   96.516450] R10: 0000000000000001 R11: 0000000000000001 R12: ffff90c64e4fb800
[   96.519749] R13: 0000000000000010 R14: 0000000000000020 R15: ffff90c64e352ce8
[   96.523455] FS:  0000000000000000(0000) GS:ffff90c96eec0000(0000) knlGS:0000000000000000
[   96.527171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   96.530900] CR2: 0000242556f18288 CR3: 0000000146a10002 CR4: 00000000003706e0
[   96.534678] Call Trace:
[   96.538418]  mt76x02u_tx_complete_skb+0x1f/0x50 [mt76x02_usb]
[   96.542231]  mt76_queue_tx_complete+0x23/0x50 [mt76]
[   96.546028]  mt76u_stop_tx.cold+0x71/0xa2 [mt76_usb]
[   96.549797]  mt76x0u_stop+0x2f/0x90 [mt76x0u]
[   96.553638]  drv_stop+0x33/0xd0 [mac80211]
[   96.557449]  ieee80211_do_stop+0x558/0x860 [mac80211]
[   96.561262]  ? dev_deactivate_many+0x298/0x2d0
[   96.565101]  ieee80211_stop+0x16/0x20 [mac80211]

Fix that by adding while loop again. We need loop, not just single
check, to clean all pending entries.

Additionally move mt76_worker_disable/enable after !mt76_has_tx_pending()
as we want to tx_worker to run to process tx queues, while we wait for
exactly that.

I was a bit worried about accessing q->queued without lock, but
mt76_worker_disable() -> kthread_park() should assure this value will
be seen updated on other cpus.

Fixes: fe5b5ab52e9d ("mt76: unify queue tx cleanup code")
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 7d3f0a2e5fa0..f1ae9ff835b2 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -1020,8 +1020,6 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 {
 	int ret;
 
-	mt76_worker_disable(&dev->tx_worker);
-
 	ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(&dev->phy),
 				 HZ / 5);
 	if (!ret) {
@@ -1040,6 +1038,8 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 				usb_kill_urb(q->entry[j].urb);
 		}
 
+		mt76_worker_disable(&dev->tx_worker);
+
 		/* On device removal we maight queue skb's, but mt76u_tx_kick()
 		 * will fail to submit urb, cleanup those skb's manually.
 		 */
@@ -1048,18 +1048,19 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 			if (!q)
 				continue;
 
-			entry = q->entry[q->tail];
-			q->entry[q->tail].done = false;
-
-			mt76_queue_tx_complete(dev, q, &entry);
+			while (q->queued > 0) {
+				entry = q->entry[q->tail];
+				q->entry[q->tail].done = false;
+				mt76_queue_tx_complete(dev, q, &entry);
+			}
 		}
+
+		mt76_worker_enable(&dev->tx_worker);
 	}
 
 	cancel_work_sync(&dev->usb.stat_work);
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
-	mt76_worker_enable(&dev->tx_worker);
-
 	mt76_tx_status_check(dev, NULL, true);
 }
 EXPORT_SYMBOL_GPL(mt76u_stop_tx);
-- 
2.25.4

