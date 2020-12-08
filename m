Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF52D2762
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 10:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgLHJVJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 04:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgLHJVJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 04:21:09 -0500
From:   Lorenzo Bianconi <lorenzo@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt76u: fix NULL pointer dereference in mt76u_status_worker
Date:   Tue,  8 Dec 2020 10:20:15 +0100
Message-Id: <cd44dc407cf3e5f27688105d4a75fb1c68e62b06.1607419147.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following NULL pointer dereference in mt76u_status_worker that
can occur if status thread runs before allocating tx queues

[   31.395373] BUG: kernel NULL pointer dereference, address: 000000000000002c
[   31.395769] #PF: supervisor read access in kernel mode
[   31.395985] #PF: error_code(0x0000) - not-present page
[   31.396178] PGD 0 P4D 0
[   31.396277] Oops: 0000 [#1] SMP
[   31.396430] CPU: 3 PID: 337 Comm: mt76-usb-status Not tainted 5.10.0-rc1-kvm+ #49
[   31.396703] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-3.fc33 04/01/2014
[   31.397048] RIP: 0010:mt76u_status_worker+0x2b/0x190
[   31.397931] RSP: 0018:ffffc9000076fe98 EFLAGS: 00010282
[   31.398118] RAX: 0000000000000001 RBX: ffff888111203fe8 RCX: 0000000000000000
[   31.398400] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff888111203fe8
[   31.398668] RBP: ffff888111201d00 R08: 000000000000038c R09: 000000000000009b
[   31.398952] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   31.399235] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810c987300
[   31.399494] FS:  0000000000000000(0000) GS:ffff88817bd80000(0000) knlGS:0000000000000000
[   31.399767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.399991] CR2: 000000000000002c CR3: 0000000103525000 CR4: 00000000000006a0
[   31.400236] Call Trace:
[   31.400348]  ? schedule+0x3e/0xa0
[   31.400514]  __mt76_worker_fn+0x71/0xa0
[   31.400634]  ? mt76_get_min_avg_rssi+0x110/0x110
[   31.400827]  kthread+0x118/0x130
[   31.400984]  ? __kthread_bind_mask+0x60/0x60
[   31.401212]  ret_from_fork+0x1f/0x30
[   31.401353] Modules linked in:
[   31.401480] CR2: 000000000000002c
[   31.401627] ---[ end trace 8bf174505cc34851 ]---
[   31.401798] RIP: 0010:mt76u_status_worker+0x2b/0x190
[   31.402636] RSP: 0018:ffffc9000076fe98 EFLAGS: 00010282
[   31.402829] RAX: 0000000000000001 RBX: ffff888111203fe8 RCX: 0000000000000000
[   31.403118] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff888111203fe8
[   31.403424] RBP: ffff888111201d00 R08: 000000000000038c R09: 000000000000009b
[   31.403689] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   31.403933] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810c987300
[   31.404209] FS:  0000000000000000(0000) GS:ffff88817bd80000(0000) knlGS:0000000000000000
[   31.404482] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.404726] CR2: 000000000000002c CR3: 0000000103525000 CR4: 00000000000006a0
[   31.405294] mt76x0u: probe of 1-1:1.0 failed with error -110
[   31.406007] usb 1-1: USB disconnect, device number 2
[   31.840756] usb 1-1: new high-speed USB device number 3 using xhci_hcd
[   32.461295] usb 1-1: reset high-speed USB device number 3 using xhci_hcd
[   32.659932] mt76x0u 1-1:1.0: ASIC revision: 76100002 MAC revision: 76502000
[   33.197032] mt76x0u 1-1:1.0: EEPROM ver:02 fae:01

Fixes: 9daf27e62852 ("mt76: mt76u: use dedicated thread for status work")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 7a91fd0c2b01..b95d093728b9 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -815,6 +815,8 @@ static void mt76u_status_worker(struct mt76_worker *w)
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		q = dev->phy.q_tx[i];
+		if (!q)
+			continue;
 
 		while (q->queued > 0) {
 			if (!q->entry[q->tail].done)
-- 
2.28.0

