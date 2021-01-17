Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA22F9597
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 22:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbhAQVqx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 16:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbhAQVqw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 16:46:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A694920791;
        Sun, 17 Jan 2021 21:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610919971;
        bh=4FnvBrMMH5TTVWdDw31mrvcyuCrgJfBNS1jkcQuaNNU=;
        h=From:To:Cc:Subject:Date:From;
        b=BkdZLB7WhuivlrpzwwS3VA0WBc8t2lWmAJvhTjIBrGgC//JB3TB4P5PQ1jdvsS2rf
         w/7Zo46vIbEPSuCP8fUhm9AIBN5VCTDIO7oV0gszO+tYmSvuulc9V8gI+df9LEtMJU
         FaF9sru+vXe+kbbnya13eOPCuuy6isoxxa783lh5vztviqnnL1O2P9t1AfpFr7uBar
         iXUsx767QS1M6WZL2cPuCrrMNKg77hwY6Sywrxg11kcqHGIlmdwU0DxKUva/+ETDt9
         YK0jA30/gISDZ7s485MKKW7vtuUFPfn3+d6iJnoj42qpzWDjnwPyNjtZaCX9FqDmET
         BKXdUFda5pImQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, kuba@kernel.org,
        matthias_berndt@gmx.de, mozlima@gmail.com
Subject: [PATCH wireless-drivers] mt7601u: fix kernel crash unplugging the device
Date:   Sun, 17 Jan 2021 22:46:01 +0100
Message-Id: <3b85219f669a63a8ced1f43686de05915a580489.1610919247.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following kernel crash unplugging the usb dongle

Hardware name: Hewlett-Packard 500-539ng/2B2C, BIOS 80.06 04/01/2015
Workqueue: usb_hub_wq hub_event
RIP: 0010:skb_trim+0x2c/0x30
RSP: 0000:ffffb4c88005bba8 EFLAGS: 00010206
RAX: 000000004ad483ee RBX: ffff9a236625dee0 RCX: 000000000000662f
RDX: 000000000000000c RSI: 0000000000000000 RDI: ffff9a2343179300
RBP: ffff9a2343179300 R08: 0000000000000001 R09: 0000000000000000
R10: ffff9a23748f7840 R11: 0000000000000001 R12: ffff9a236625e4d4
R13: ffff9a236625dee0 R14: 0000000000001080 R15: 0000000000000008
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd410a34ef8 CR3: 00000001416ee001 CR4: 00000000001706f0
Call Trace:
 mt7601u_tx_status+0x3e/0xa0 [mt7601u]
 mt7601u_dma_cleanup+0xca/0x110 [mt7601u]
 mt7601u_cleanup+0x22/0x30 [mt7601u]
 mt7601u_disconnect+0x22/0x60 [mt7601u]
 usb_unbind_interface+0x8a/0x270
 ? kernfs_find_ns+0x35/0xd0
 __device_release_driver+0x17a/0x230
 device_release_driver+0x24/0x30
 bus_remove_device+0xdb/0x140
 device_del+0x18b/0x430
 ? kobject_put+0x98/0x1d0
 usb_disable_device+0xc6/0x1f0
 usb_disconnect.cold+0x7e/0x20a
 hub_event+0xbf3/0x1870
 process_one_work+0x1b6/0x350
 worker_thread+0x53/0x3e0
 ? process_one_work+0x350/0x350
 kthread+0x11b/0x140
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x22/0x30

Fixes: 23377c200b2eb ("mt7601u: fix possible memory leak when the device is disconnected")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt7601u/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
index 47710da5b2a5..af7d1ecb777c 100644
--- a/drivers/net/wireless/mediatek/mt7601u/dma.c
+++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
@@ -309,7 +309,6 @@ static int mt7601u_dma_submit_tx(struct mt7601u_dev *dev,
 	}
 
 	e = &q->e[q->end];
-	e->skb = skb;
 	usb_fill_bulk_urb(e->urb, usb_dev, snd_pipe, skb->data, skb->len,
 			  mt7601u_complete_tx, q);
 	ret = usb_submit_urb(e->urb, GFP_ATOMIC);
@@ -327,6 +326,7 @@ static int mt7601u_dma_submit_tx(struct mt7601u_dev *dev,
 
 	q->end = (q->end + 1) % q->entries;
 	q->used++;
+	e->skb = skb;
 
 	if (q->used >= q->entries)
 		ieee80211_stop_queue(dev->hw, skb_get_queue_mapping(skb));
-- 
2.29.2

