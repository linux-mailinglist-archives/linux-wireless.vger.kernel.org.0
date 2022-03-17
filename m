Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D914DD13D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 00:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiCQXlm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 19:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiCQXll (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 19:41:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE71D4C90
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 16:40:23 -0700 (PDT)
X-UUID: b9360739748c4c04bae11d020ca89568-20220318
X-UUID: b9360739748c4c04bae11d020ca89568-20220318
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 455812307; Fri, 18 Mar 2022 07:40:18 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Mar 2022 07:40:16 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 07:40:16 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: fix use-after-free issue in mt76_txq_schedule
Date:   Fri, 18 Mar 2022 07:40:15 +0800
Message-ID: <0635c676d886bd0a3ae1c2679e7c1d82d39cfc2d.1647560233.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix an issue caught by KASAN about use-after-free in mt76_txq_schedule
by protecting mtxq->wcid with rcu_lock between mt76_txq_schedule and
sta_info_[alloc, free].

[18853.876689] ==================================================================
[18853.876751] BUG: KASAN: use-after-free in mt76_txq_schedule+0x204/0xaf8 [mt76]
[18853.876773] Read of size 8 at addr ffffffaf989a2138 by task mt76-tx phy0/883
[18853.876786]
[18853.876810] CPU: 5 PID: 883 Comm: mt76-tx phy0 Not tainted 5.10.100-fix-510-56778d365941-kasan #5 0b01fbbcf41a530f52043508fec2e31a4215

[18853.876840] Call trace:
[18853.876861]  dump_backtrace+0x0/0x3ec
[18853.876878]  show_stack+0x20/0x2c
[18853.876899]  dump_stack+0x11c/0x1ac
[18853.876918]  print_address_description+0x74/0x514
[18853.876934]  kasan_report+0x134/0x174
[18853.876948]  __asan_report_load8_noabort+0x44/0x50
[18853.876976]  mt76_txq_schedule+0x204/0xaf8 [mt76 074e03e4640e97fe7405ee1fab547b81c4fa45d2]
[18853.877002]  mt76_txq_schedule_all+0x2c/0x48 [mt76 074e03e4640e97fe7405ee1fab547b81c4fa45d2]
[18853.877030]  mt7921_tx_worker+0xa0/0x1cc [mt7921_common f0875ebac9d7b4754e1010549e7db50fbd90a047]
[18853.877054]  __mt76_worker_fn+0x190/0x22c [mt76 074e03e4640e97fe7405ee1fab547b81c4fa45d2]
[18853.877071]  kthread+0x2f8/0x3b8
[18853.877087]  ret_from_fork+0x10/0x30
[18853.877098]
[18853.877112] Allocated by task 941:
[18853.877131]  kasan_save_stack+0x38/0x68
[18853.877147]  __kasan_kmalloc+0xd4/0xfc
[18853.877163]  kasan_kmalloc+0x10/0x1c
[18853.877177]  __kmalloc+0x264/0x3c4
[18853.877294]  sta_info_alloc+0x460/0xf88 [mac80211]
[18853.877410]  ieee80211_prep_connection+0x204/0x1ee0 [mac80211]
[18853.877523]  ieee80211_mgd_auth+0x6c4/0xa4c [mac80211]
[18853.877635]  ieee80211_auth+0x20/0x2c [mac80211]
[18853.877733]  rdev_auth+0x7c/0x438 [cfg80211]
[18853.877826]  cfg80211_mlme_auth+0x26c/0x390 [cfg80211]
[18853.877919]  nl80211_authenticate+0x6d4/0x904 [cfg80211]
[18853.877938]  genl_rcv_msg+0x748/0x93c
[18853.877954]  netlink_rcv_skb+0x160/0x2a8
[18853.877969]  genl_rcv+0x3c/0x54
[18853.877985]  netlink_unicast_kernel+0x104/0x1ec
[18853.877999]  netlink_unicast+0x178/0x268
[18853.878015]  netlink_sendmsg+0x3cc/0x5f0
[18853.878030]  sock_sendmsg+0xb4/0xd8
[18853.878043]  ____sys_sendmsg+0x2f8/0x53c
[18853.878058]  ___sys_sendmsg+0xe8/0x150
[18853.878071]  __sys_sendmsg+0xc4/0x1f4
[18853.878087]  __arm64_compat_sys_sendmsg+0x88/0x9c
[18853.878101]  el0_svc_common+0x1b4/0x390
[18853.878115]  do_el0_svc_compat+0x8c/0xdc
[18853.878131]  el0_svc_compat+0x10/0x1c
[18853.878146]  el0_sync_compat_handler+0xa8/0xcc
[18853.878161]  el0_sync_compat+0x188/0x1c0
[18853.878171]
[18853.878183] Freed by task 10927:
[18853.878200]  kasan_save_stack+0x38/0x68
[18853.878215]  kasan_set_track+0x28/0x3c
[18853.878228]  kasan_set_free_info+0x24/0x48
[18853.878244]  __kasan_slab_free+0x11c/0x154
[18853.878259]  kasan_slab_free+0x14/0x24
[18853.878273]  slab_free_freelist_hook+0xac/0x1b0
[18853.878287]  kfree+0x104/0x390
[18853.878402]  sta_info_free+0x198/0x210 [mac80211]
[18853.878515]  __sta_info_destroy_part2+0x230/0x2d4 [mac80211]
[18853.878628]  __sta_info_flush+0x300/0x37c [mac80211]
[18853.878740]  ieee80211_set_disassoc+0x2cc/0xa7c [mac80211]
[18853.878851]  ieee80211_mgd_deauth+0x4a4/0x10a0 [mac80211]
[18853.878962]  ieee80211_deauth+0x20/0x2c [mac80211]
[18853.879057]  rdev_deauth+0x7c/0x438 [cfg80211]
[18853.879150]  cfg80211_mlme_deauth+0x274/0x414 [cfg80211]
[18853.879243]  cfg80211_mlme_down+0xe4/0x118 [cfg80211]
[18853.879335]  cfg80211_disconnect+0x218/0x2d8 [cfg80211]
[18853.879427]  __cfg80211_leave+0x17c/0x240 [cfg80211]
[18853.879519]  cfg80211_leave+0x3c/0x58 [cfg80211]
[18853.879611]  wiphy_suspend+0xdc/0x200 [cfg80211]
[18853.879628]  dpm_run_callback+0x58/0x408
[18853.879642]  __device_suspend+0x4cc/0x864
[18853.879658]  async_suspend+0x34/0xf4
[18853.879673]  async_run_entry_fn+0xe0/0x37c
[18853.879689]  process_one_work+0x508/0xb98
[18853.879702]  worker_thread+0x7f4/0xcd4
[18853.879717]  kthread+0x2f8/0x3b8
[18853.879731]  ret_from_fork+0x10/0x30
[18853.879741]
[18853.879757] The buggy address belongs to the object at ffffffaf989a2000
[18853.879757]  which belongs to the cache kmalloc-8k of size 8192
[18853.879774] The buggy address is located 312 bytes inside of
[18853.879774]  8192-byte region [ffffffaf989a2000, ffffffaf989a4000)
[18853.879787] The buggy address belongs to the page:
[18853.879807] page:000000004bda2a59 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d89a0
[18853.879823] head:000000004bda2a59 order:3 compound_mapcount:0 compound_pincount:0
[18853.879839] flags: 0x8000000000010200(slab|head)
[18853.879857] raw: 8000000000010200 ffffffffbc89e208 ffffffffb7fb5208 ffffffaec000cc80
[18853.879873] raw: 0000000000000000 0000000000010001 00000001ffffffff 0000000000000000
[18853.879885] page dumped because: kasan: bad access detected
[18853.879896]
[18853.879907] Memory state around the buggy address:
[18853.879922]  ffffffaf989a2000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18853.879935]  ffffffaf989a2080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18853.879948] >ffffffaf989a2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18853.879961]                                         ^
[18853.879973]  ffffffaf989a2180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18853.879986]  ffffffaf989a2200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18853.879998] ==================================================================

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 14 +++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5b53d008eb66..81c90bdc128c 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1303,7 +1303,7 @@ mt76_sta_add(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			continue;
 
 		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
-		mtxq->wcid = wcid;
+		rcu_assign_pointer(mtxq->wcid, wcid);
 	}
 
 	ewma_signal_init(&wcid->rssi);
@@ -1379,9 +1379,21 @@ void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	int i;
 
 	mutex_lock(&dev->mutex);
 	rcu_assign_pointer(dev->wcid[wcid->idx], NULL);
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct mt76_txq *mtxq;
+
+		if (!sta->txq[i])
+			continue;
+
+		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
+		rcu_assign_pointer(mtxq->wcid, NULL);
+	}
+
 	mutex_unlock(&dev->mutex);
 }
 EXPORT_SYMBOL_GPL(mt76_sta_pre_rcu_remove);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 882fb5d2517f..e96d255fcede 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -275,7 +275,7 @@ struct mt76_wcid {
 };
 
 struct mt76_txq {
-	struct mt76_wcid *wcid;
+	struct mt76_wcid __rcu *wcid;
 
 	u16 agg_ssn;
 	bool send_bar;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 6b8c9dc80542..3fed125a0866 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -522,7 +522,7 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 
 		mtxq = (struct mt76_txq *)txq->drv_priv;
 		wcid = mtxq->wcid;
-		if (wcid && test_bit(MT_WCID_FLAG_PS, &wcid->flags))
+		if (!wcid || (wcid && test_bit(MT_WCID_FLAG_PS, &wcid->flags)))
 			continue;
 
 		spin_lock_bh(&q->lock);
-- 
2.25.1

