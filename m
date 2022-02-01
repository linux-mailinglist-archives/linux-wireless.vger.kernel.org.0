Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DE34A5B2E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 12:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbiBALaP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 06:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiBALaO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 06:30:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426E3C061714
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 03:30:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EACF2B82D64
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 11:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70A5C340EB;
        Tue,  1 Feb 2022 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643715011;
        bh=SwPzFVebmUIhmTUoY6fqV/dVSwEMYk44gur2Y+CTtUE=;
        h=From:To:Cc:Subject:Date:From;
        b=XbiQu58Dyk3TflyDQGqegprhe9IH0zDIwwU9NuobXaYoXFh4Lk3IK9bdff4gQGfqh
         j+cK7Zl8I4b+z9TIiopsuxgLy6eFpcFcEf6JS/KTIfuQRAbGukgn6p2sj2hZfpQKTZ
         sH/sdUOV5/bN4++nra5NTAwX4NSHcAXKKaKpYou1PNkSPKM79SH7xWMdj6MFssf89T
         aM3WLpxMh8M/x8k/sZjwdNLlHRkB/PlMzVPk6D2fmoX38Ts8FcVB8YUmKKaivZroaX
         vkpvmGaBzQV2AXUxgUW16kdKdFYKQ1egs7GtKrptdHqTtrUVCLGt/X8Degy36FPyFk
         RiHwPUDBDrGaw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        johan.hemma@gmail.com
Subject: [PATCH] mt76: dma: initialize skip_unmap in mt76_dma_rx_fill
Date:   Tue,  1 Feb 2022 12:29:55 +0100
Message-Id: <d77b11c7ca558c46d4118c2f93893a385999012f.1643714819.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Even if it is only a false-positive since skip_buf0/skip_buf1 are only
used in mt76_dma_tx_cleanup_idx routine, initialize skip_unmap in
mt76_dma_rx_fill in order to fix the following UBSAN report:

[   13.924906] UBSAN: invalid-load in linux-5.15.0/drivers/net/wireless/mediatek/mt76/dma.c:162:13
[   13.924909] load of value 225 is not a valid value for type '_Bool'
[   13.924912] CPU: 9 PID: 672 Comm: systemd-udevd Not tainted 5.15.0-18-generic #18-Ubuntu
[   13.924914] Hardware name: LENOVO 21A0000CMX/21A0000CMX, BIOS R1MET43W (1.13 ) 11/05/2021
[   13.924915] Call Trace:
[   13.924917]  <TASK>
[   13.924920]  show_stack+0x52/0x58
[   13.924925]  dump_stack_lvl+0x4a/0x5f
[   13.924931]  dump_stack+0x10/0x12
[   13.924932]  ubsan_epilogue+0x9/0x45
[   13.924934]  __ubsan_handle_load_invalid_value.cold+0x44/0x49
[   13.924935]  ? __iommu_dma_map+0x84/0xf0
[   13.924939]  mt76_dma_add_buf.constprop.0.cold+0x23/0x85 [mt76]
[   13.924949]  mt76_dma_rx_fill.isra.0+0x102/0x1f0 [mt76]
[   13.924954]  mt76_dma_init+0xc9/0x150 [mt76]
[   13.924959]  ? mt7921_dma_enable+0x110/0x110 [mt7921e]
[   13.924966]  mt7921_dma_init+0x1e3/0x260 [mt7921e]
[   13.924970]  mt7921_register_device+0x29d/0x510 [mt7921e]
[   13.924975]  mt7921_pci_probe.part.0+0x17f/0x1b0 [mt7921e]
[   13.924980]  mt7921_pci_probe+0x43/0x60 [mt7921e]
[   13.924984]  local_pci_probe+0x4b/0x90
[   13.924987]  pci_device_probe+0x115/0x1f0
[   13.924989]  really_probe+0x21e/0x420
[   13.924992]  __driver_probe_device+0x115/0x190
[   13.924994]  driver_probe_device+0x23/0xc0
[   13.924996]  __driver_attach+0xbd/0x1d0
[   13.924998]  ? __device_attach_driver+0x110/0x110
[   13.924999]  bus_for_each_dev+0x7e/0xc0
[   13.925001]  driver_attach+0x1e/0x20
[   13.925003]  bus_add_driver+0x135/0x200
[   13.925005]  driver_register+0x95/0xf0
[   13.925008]  ? 0xffffffffc0766000
[   13.925010]  __pci_register_driver+0x68/0x70
[   13.925011]  mt7921_pci_driver_init+0x23/0x1000 [mt7921e]
[   13.925015]  do_one_initcall+0x48/0x1d0
[   13.925019]  ? kmem_cache_alloc_trace+0x19e/0x2e0
[   13.925022]  do_init_module+0x62/0x280
[   13.925025]  load_module+0xac9/0xbb0
[   13.925027]  __do_sys_finit_module+0xbf/0x120
[   13.925029]  __x64_sys_finit_module+0x18/0x20
[   13.925030]  do_syscall_64+0x5c/0xc0
[   13.925033]  ? do_syscall_64+0x69/0xc0
[   13.925034]  ? sysvec_reschedule_ipi+0x78/0xe0
[   13.925036]  ? asm_sysvec_reschedule_ipi+0xa/0x20
[   13.925039]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   13.925040] RIP: 0033:0x7fbf2b90f94d
[   13.925045] RSP: 002b:00007ffe2ec7e5d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   13.925047] RAX: ffffffffffffffda RBX: 000056106b0634e0 RCX: 00007fbf2b90f94d
[   13.925048] RDX: 0000000000000000 RSI: 00007fbf2baa3441 RDI: 0000000000000013
[   13.925049] RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
[   13.925050] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fbf2baa3441
[   13.925051] R13: 000056106b062620 R14: 000056106b0610c0 R15: 000056106b0640d0
[   13.925053]  </TASK>

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index fd4c51b6eaa0..02daeefb0761 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -468,6 +468,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 
 		qbuf.addr = addr + offset;
 		qbuf.len = len - offset;
+		qbuf.skip_unmap = false;
 		mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, NULL);
 		frames++;
 	}
-- 
2.34.1

