Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF0D7990
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfJOPQ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 11:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733070AbfJOPQ4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 11:16:56 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A9520854;
        Tue, 15 Oct 2019 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571152615;
        bh=bvxXAUsrRVf8mbCehV9PGMx2g4QVI7tpLjTELPiBtIg=;
        h=From:To:Cc:Subject:Date:From;
        b=bm8QDh7jZJusV9cstVWD1hz46MCAPKKZn8vUriink/6eavt8hhIJ0CVJYcuD0C7yz
         bX4PIMmldV66RxB34CJnONjl203mtVIuvUAMC7gUyzq1Y4pkMl7if/155aCGLlQwlE
         BC3TeYJq/Hz2gTimttYmkIVHdIn5kusDObZ8BoQ8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v2] mt76: refactor cc_lock locking scheme
Date:   Tue, 15 Oct 2019 17:16:43 +0200
Message-Id: <252d75b5139a7acb4bdc28c8131e408c2483d8ac.1571151935.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Read busy counters not holding cc_lock spinlock since usb read can't be
performed in interrupt context. Move cc_active and cc_rx counters out of
cc_lock since they are not modified in interrupt context.
Grab cc_lock updating cur_cc_bss_rx in mt76_airtime_report and do not
hold rx_lock in mt76_update_survey.
Moreover grab mt76 mutex in mt76_get_survey before running
mt76_update_survey. This patch fixes the following 'schedule while
atomic'

[  291.790866] BUG: scheduling while atomic: iw/2161/0x00000202
[  291.791002] Preemption disabled at:
[  291.791007] [<0000000000000000>] 0x0
[  291.791015] CPU: 0 PID: 2161 Comm: iw Tainted: G W 5.4.= 0-rc2-3-ARCH-00104-g9e208aa06c21 #1
[  291.791017] Hardware name: LENOVO 2349QM6/2349QM6, BIOS G1ETC2WW (2.82=) 08/07/2019
[  291.791019] Call Trace:
[  291.791042]  dump_stack+0x5c/0x80
[  291.791049]  __schedule_bug.cold+0x8e/0x9b
[  291.791055]  __schedule+0x5f8/0x770
[  291.791062]  schedule+0x43/0xd0
[  291.791068]  schedule_preempt_disabled+0x14/0x20
[  291.791074]  __mutex_lock.isra.0+0x18a/0x530
[  291.791099]  mt76u_rr+0x1f/0x40 [mt76_usb]
[  291.791113]  mt76x02_update_channel+0x22/0x40 [mt76x02_lib]
[  291.791122]  mt76_update_survey+0x42/0xe0 [mt76]
[  291.791129]  mt76_get_survey+0x2f/0x1b0 [mt76]
[  291.791170]  ieee80211_dump_survey+0x5e/0x140 [mac80211]
[  291.791217]  nl80211_dump_survey+0x13c/0x2f0 [cfg80211]
[  291.791222]  ? __kmalloc_reserve.isra.0+0x2d/0x70
[  291.791225]  ? __alloc_skb+0x96/0x1d0
[  291.791229]  netlink_dump+0x17b/0x370
[  291.791247]  __netlink_dump_start+0x16f/0x1e0
[  291.791253]  genl_family_rcv_msg+0x396/0x410
[  291.791290]  ? nl80211_prepare_wdev_dump+0x1b0/0x1b0 [cfg80211]
[  291.791297]  ? _raw_spin_unlock_irqrestore+0x20/0x40
[  291.791312]  ? __wake_up_common_lock+0x8a/0xc0
[  291.791316]  genl_rcv_msg+0x47/0x90
[  291.791320]  ? genl_family_rcv_msg+0x410/0x410
[  291.791323]  netlink_rcv_skb+0x49/0x110
[  291.791329]  genl_rcv+0x24/0x40
[  291.791333]  netlink_unicast+0x171/0x200
[  291.791340]  netlink_sendmsg+0x208/0x3d0
[  291.791358]  sock_sendmsg+0x5e/0x60
[  291.791361]  ___sys_sendmsg+0x2ae/0x330
[  291.791368]  ? filemap_map_pages+0x272/0x390
[  291.791374]  ? _raw_spin_unlock+0x16/0x30
[  291.791379]  ? __handle_mm_fault+0x112f/0x1390
[  291.791388]  __sys_sendmsg+0x59/0xa0
[  291.791396]  do_syscall_64+0x5b/0x1a0
[  291.791400]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  291.791404] RIP: 0033:0x7f5d0c7f37b7
[  291.791418] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 0=
0 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[  291.791421] RSP: 002b:00007ffe8b5d0538 EFLAGS: 00000246 ORIG_RAX: 0000= 00000000002e
[  291.791426] RAX: ffffffffffffffda RBX: 000055a038e6c390 RCX: 00007f5d0= c7f37b7
[  291.791430] RDX: 0000000000000000 RSI: 00007ffe8b5d0570 RDI: 000000000= 0000003
[  291.791434] RBP: 000055a038e718c0 R08: 000055a038e6c02a R09: 000000000= 0000002
[  291.791438] R10: 000055a03808cb00 R11: 0000000000000246 R12: 000055a03= 8e71780
[  291.791440] R13: 00007ffe8b5d0570 R14: 000055a038e717d0 R15: 000055a03= 8e718c0
[  291.791480] NOHZ: local_softirq_pending 202

Fixes: 168aea24f4bb ("mt76: mt76x02u: enable survey support")
Tested-by: Markus Theil <markus.theil@tu-ilmenau.de>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- disable BH in mt76_update_survey holding cc_lock
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 29 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  3 ++
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index a962abce98f8..6535921fcea4 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -432,8 +432,6 @@ void mt76_update_survey(struct mt76_dev *dev)
 	if (!test_bit(MT76_STATE_RUNNING, &dev->state))
 		return;
 
-	spin_lock_bh(&dev->cc_lock);
-
 	if (dev->drv->update_survey)
 		dev->drv->update_survey(dev);
 
@@ -442,15 +440,11 @@ void mt76_update_survey(struct mt76_dev *dev)
 						  dev->survey_time));
 	dev->survey_time = cur_time;
 
-	spin_unlock_bh(&dev->cc_lock);
-
 	if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME) {
-		spin_lock_bh(&dev->rx_lock);
-		spin_lock(&dev->cc_lock);
+		spin_lock_bh(&dev->cc_lock);
 		state->cc_bss_rx += dev->cur_cc_bss_rx;
 		dev->cur_cc_bss_rx = 0;
-		spin_unlock(&dev->cc_lock);
-		spin_unlock_bh(&dev->rx_lock);
+		spin_unlock_bh(&dev->cc_lock);
 	}
 }
 EXPORT_SYMBOL_GPL(mt76_update_survey);
@@ -485,6 +479,7 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	struct mt76_channel_state *state;
 	int ret = 0;
 
+	mutex_lock(&dev->mutex);
 	if (idx == 0 && dev->drv->update_survey)
 		mt76_update_survey(dev);
 
@@ -494,8 +489,10 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		sband = &dev->sband_5g;
 	}
 
-	if (idx >= sband->sband.n_channels)
-		return -ENOENT;
+	if (idx >= sband->sband.n_channels) {
+		ret = -ENOENT;
+		goto out;
+	}
 
 	chan = &sband->sband.channels[idx];
 	state = mt76_channel_state(dev, chan);
@@ -511,14 +508,18 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 			survey->filled |= SURVEY_INFO_TIME_BSS_RX;
 	}
 
-	spin_lock_bh(&dev->cc_lock);
-	survey->time = div_u64(state->cc_active, 1000);
 	survey->time_busy = div_u64(state->cc_busy, 1000);
-	survey->time_bss_rx = div_u64(state->cc_bss_rx, 1000);
 	survey->time_rx = div_u64(state->cc_rx, 1000);
+	survey->time = div_u64(state->cc_active, 1000);
+
+	spin_lock_bh(&dev->cc_lock);
+	survey->time_bss_rx = div_u64(state->cc_bss_rx, 1000);
 	survey->time_tx = div_u64(state->cc_tx, 1000);
 	spin_unlock_bh(&dev->cc_lock);
 
+out:
+	mutex_unlock(&dev->mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mt76_get_survey);
@@ -622,7 +623,9 @@ mt76_airtime_report(struct mt76_dev *dev, struct mt76_rx_status *status,
 	u32 airtime;
 
 	airtime = mt76_calc_rx_airtime(dev, status, len);
+	spin_lock(&dev->cc_lock);
 	dev->cur_cc_bss_rx += airtime;
+	spin_unlock(&dev->cc_lock);
 
 	if (!wcid || !wcid->sta)
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 41f7c01045b8..2c0bd9aa1987 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -1024,8 +1024,11 @@ void mt76x02_update_channel(struct mt76_dev *mdev)
 
 	state = mdev->chan_state;
 	state->cc_busy += mt76_rr(dev, MT_CH_BUSY);
+
+	spin_lock_bh(&dev->mt76.cc_lock);
 	state->cc_tx += dev->tx_airtime;
 	dev->tx_airtime = 0;
+	spin_unlock_bh(&dev->mt76.cc_lock);
 }
 EXPORT_SYMBOL_GPL(mt76x02_update_channel);
 
-- 
2.21.0

