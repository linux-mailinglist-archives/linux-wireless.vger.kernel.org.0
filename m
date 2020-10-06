Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6019A285080
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Oct 2020 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFRNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Oct 2020 13:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFRNJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Oct 2020 13:13:09 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16EEE206DD;
        Tue,  6 Oct 2020 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602004388;
        bh=mEzpCB6JOILSIzDiPTOjaJ8MoU6a53vqkgZIfCuIkmM=;
        h=From:To:Cc:Subject:Date:From;
        b=MhRKOP1cIyjhqA1zEvKG7xIy010ppg8nfcKa2G62hEw72t3o7ITn7zKarJ9DypxZs
         V8lURDqZLDxCjvfQB4UG9mStYdoek45iGHvBtkC8C2xtbXLYpd4ye+loWV47LXJJ5Q
         LQrDNfc2yH9yCfCsqzxaUCn2hmN7ZHtRZJ1Cqs0Q=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: dma: fix possible deadlock running mt76_dma_cleanup
Date:   Tue,  6 Oct 2020 19:13:02 +0200
Message-Id: <85eb01e17c3214103bf3b4a62ab4d722d9a017a1.1602004125.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following possible deadlock reported by lockdep disabling BH
running __mt76_get_txwi/mt76_put_txwi

================================
WARNING: inconsistent lock state
5.9.0-rc6 #14 Not tainted
--------------------------------
inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
rmmod/1227 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffff888156a83530 (&dev->lock#2){+.?.}-{2:2}, at: mt76_dma_cleanup+0x125/0x150 [mt76]
{IN-SOFTIRQ-W} state was registered at:
  __lock_acquire+0x20c/0x6b0
  lock_acquire+0x9d/0x220
  _raw_spin_lock+0x2c/0x70
  mt76_dma_tx_cleanup+0xc7/0x200 [mt76]
  mt76x02_poll_tx+0x31/0xb0 [mt76x02_lib]
  napi_poll+0x3a/0x100
  net_rx_action+0xa8/0x200
  __do_softirq+0xc4/0x430
  asm_call_on_stack+0xf/0x20
  do_softirq_own_stack+0x49/0x60
  irq_exit_rcu+0x9a/0xd0
  common_interrupt+0xa4/0x190
  asm_common_interrupt+0x1e/0x40
irq event stamp: 9915
hardirqs last  enabled at (9915): [<ffffffff8124e286>] __free_pages_ok+0x336/0x3b0
hardirqs last disabled at (9914): [<ffffffff8124e24e>] __free_pages_ok+0x2fe/0x3b0
softirqs last  enabled at (9912): [<ffffffffa03aa672>] mt76_dma_rx_cleanup+0xa2/0x120 [mt76]
softirqs last disabled at (9846): [<ffffffffa03aa5ea>] mt76_dma_rx_cleanup+0x1a/0x120 [mt76]

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->lock#2);
  <Interrupt>
    lock(&dev->lock#2);

 *** DEADLOCK ***

1 lock held by rmmod/1227:
 #0: ffff88815b5eb240 (&dev->mutex){....}-{3:3}, at: driver_detach+0xb5/0x110

stack backtrace:
CPU: 1 PID: 1227 Comm: rmmod Kdump: loaded Not tainted 5.9.0-rc6-wdn-src+ #14
Hardware name: Dell Inc. Studio XPS 1340/0K183D, BIOS A11 09/08/2009
Call Trace:
 dump_stack+0x77/0xa0
 mark_lock_irq.cold+0x15/0x39
 mark_lock+0x1fc/0x500
 mark_usage+0xc7/0x140
 __lock_acquire+0x20c/0x6b0
 ? find_held_lock+0x2b/0x80
 ? sched_clock_cpu+0xc/0xb0
 lock_acquire+0x9d/0x220
 ? mt76_dma_cleanup+0x125/0x150 [mt76]
 _raw_spin_lock+0x2c/0x70
 ? mt76_dma_cleanup+0x125/0x150 [mt76]
 mt76_dma_cleanup+0x125/0x150 [mt76]
 mt76x2_cleanup+0x5a/0x70 [mt76x2e]
 mt76x2e_remove+0x18/0x30 [mt76x2e]
 pci_device_remove+0x36/0xa0
 __device_release_driver+0x16c/0x220
 driver_detach+0xcf/0x110
 bus_remove_driver+0x56/0xca
 pci_unregister_driver+0x36/0x80
 __do_sys_delete_module.constprop.0+0x127/0x200
 ? syscall_enter_from_user_mode+0x1d/0x50
 ? trace_hardirqs_on+0x1c/0xe0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7ff0da54e36b
Code: 73 01 c3 48 8b 0d 2d 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 0a 0c 00 f7 d8 64 89 01 48

Fixes: dd57a95cfddc ("mt76: move txwi handling code to dma.c, since it is mmio specific")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 214fc95b8a33..9ea6df9ecd01 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -33,13 +33,13 @@ __mt76_get_txwi(struct mt76_dev *dev)
 {
 	struct mt76_txwi_cache *t = NULL;
 
-	spin_lock(&dev->lock);
+	spin_lock_bh(&dev->lock);
 	if (!list_empty(&dev->txwi_cache)) {
 		t = list_first_entry(&dev->txwi_cache, struct mt76_txwi_cache,
 				     list);
 		list_del(&t->list);
 	}
-	spin_unlock(&dev->lock);
+	spin_unlock_bh(&dev->lock);
 
 	return t;
 }
@@ -61,9 +61,9 @@ mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 	if (!t)
 		return;
 
-	spin_lock(&dev->lock);
+	spin_lock_bh(&dev->lock);
 	list_add(&t->list, &dev->txwi_cache);
-	spin_unlock(&dev->lock);
+	spin_unlock_bh(&dev->lock);
 }
 EXPORT_SYMBOL_GPL(mt76_put_txwi);
 
-- 
2.26.2

