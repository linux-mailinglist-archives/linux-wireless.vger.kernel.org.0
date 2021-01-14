Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1DC2F6712
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbhANRLj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 12:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbhANRLj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 12:11:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A284123B1C;
        Thu, 14 Jan 2021 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610644257;
        bh=mcVu179EQmQ2dsA/z1BhV+rbOBlPLXyi4n0Y+HZHha0=;
        h=From:To:Cc:Subject:Date:From;
        b=K2hlPoOCN+xzq7zdAJB3cMUa8hagwcdRO8ttj6B+JDxp1Ap0eMSULvElg6TZUT4Y2
         aN2jOpyeOqItenVvJU+C9jh6mvo06O1ANJRg/ylvroXVbGb+btdMQ8Rlq4iE/NOVaH
         oFfcKmmfgJO9SJ7iY5BJ4qsEK4E2HbL1/bIcIB3djDkMwOx+wYGQnbH72bU7CK5b54
         c8FWYhHBFKQ3hoOmqVLJToQHlu0ipoV4UF+Brqb8syDR4AAnvOAopxSVMw8CQDQ3bZ
         8t8S8N+IiURRLQQxuQnUTxaPtRw0uNoZ8eMsMTp/PxMRPw9Htb9riZ30SdRjQw1rHa
         B/ZRtWeOFtWiQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, kuba@kernel.org, nbd@nbd.name,
        matthias_berndt@gmx.de, mozlima@gmail.com
Subject: [PATCH wireless-drivers] mt7601u: fix rx buffer refcounting
Date:   Thu, 14 Jan 2021 18:10:52 +0100
Message-Id: <62b2380c8c2091834cfad05e1059b55f945bd114.1610643952.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following crash due to erroneous page refcounting:

[   32.445919] BUG: Bad page state in process swapper/1  pfn:11f65a
[   32.447409] page:00000000938f0632 refcount:0 mapcount:-128 mapping:0000000000000000 index:0x0 pfn:0x11f65a
[   32.449605] flags: 0x8000000000000000()
[   32.450421] raw: 8000000000000000 ffffffff825b0148 ffffea00045ae988 0000000000000000
[   32.451795] raw: 0000000000000000 0000000000000001 00000000ffffff7f 0000000000000000
[   32.452999] page dumped because: nonzero mapcount
[   32.453888] Modules linked in:
[   32.454492] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.11.0-rc2+ #1976
[   32.455695] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
[   32.457157] Call Trace:
[   32.457636]  <IRQ>
[   32.457993]  dump_stack+0x77/0x97
[   32.458576]  bad_page.cold+0x65/0x96
[   32.459198]  get_page_from_freelist+0x46a/0x11f0
[   32.460008]  __alloc_pages_nodemask+0x10a/0x2b0
[   32.460794]  mt7601u_rx_tasklet+0x651/0x720
[   32.461505]  tasklet_action_common.constprop.0+0x6b/0xd0
[   32.462343]  __do_softirq+0x152/0x46c
[   32.462928]  asm_call_irq_on_stack+0x12/0x20
[   32.463610]  </IRQ>
[   32.463953]  do_softirq_own_stack+0x5b/0x70
[   32.464582]  irq_exit_rcu+0x9f/0xe0
[   32.465028]  common_interrupt+0xae/0x1a0
[   32.465536]  asm_common_interrupt+0x1e/0x40
[   32.466071] RIP: 0010:default_idle+0x18/0x20
[   32.468981] RSP: 0018:ffffc90000077f00 EFLAGS: 00000246
[   32.469648] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   32.470550] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81aac3dd
[   32.471463] RBP: ffff88810022ab00 R08: 0000000000000001 R09: 0000000000000001
[   32.472335] R10: 0000000000000046 R11: 0000000000005aa0 R12: 0000000000000000
[   32.473235] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   32.474139]  ? default_idle_call+0x4d/0x200
[   32.474681]  default_idle_call+0x74/0x200
[   32.475192]  do_idle+0x1d5/0x250
[   32.475612]  cpu_startup_entry+0x19/0x20
[   32.476114]  secondary_startup_64_no_verify+0xb0/0xbb
[   32.476765] Disabling lock debugging due to kernel taint

Fixes: c869f77d6abb ("add mt7601u driver")
Co-developed-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt7601u/dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
index 5f99054f535b..47710da5b2a5 100644
--- a/drivers/net/wireless/mediatek/mt7601u/dma.c
+++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
@@ -152,8 +152,7 @@ mt7601u_rx_process_entry(struct mt7601u_dev *dev, struct mt7601u_dma_buf_rx *e)
 
 	if (new_p) {
 		/* we have one extra ref from the allocator */
-		__free_pages(e->p, MT_RX_ORDER);
-
+		put_page(e->p);
 		e->p = new_p;
 	}
 }
-- 
2.29.2

