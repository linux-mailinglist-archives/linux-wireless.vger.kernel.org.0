Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4AF4EF24D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348697AbiDAOyv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 10:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348452AbiDAOnS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 10:43:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4239F2963C8;
        Fri,  1 Apr 2022 07:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82EE3B8250B;
        Fri,  1 Apr 2022 14:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55FBC2BBE4;
        Fri,  1 Apr 2022 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823657;
        bh=ckzIrfL6TdjsEI+KDgKSPG8nEY/WesOEbocmrIN68qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhYwHfshJcciMKIeH+40iYo4/7XFS2YIHGujdHcBF0Nh+eU8sqYZfBhciFaGUiC+R
         +PzKvU8UfOt5H4r2bx1Sqo1VJWsr4yJ+RCqWy788ykfA1qZ7SsdWtUx84cLHFA9wC1
         jhq3sVCpHJHQQC7Yc8oxbMFRrN28Xbd11tEtgfcIstCdMjUEmJne7WH/B5TAJoD9MX
         ZAla235kLe3JiSIFyJ/IIwJAY8EHD1zjH2Ug10LyEyHs6RxoBCc+6Gxs/9FBjb/Iy0
         GyAGyh9HNXinGrAR3UnV7jKUBASS4qLgu++tY3nN7S7f6O6FbbyYYPKUzc1hi3s+CJ
         AnO+KgDuRVOqg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>,
        lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, matthias.bgg@gmail.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.16 030/109] mt76: dma: initialize skip_unmap in mt76_dma_rx_fill
Date:   Fri,  1 Apr 2022 10:31:37 -0400
Message-Id: <20220401143256.1950537-30-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143256.1950537-1-sashal@kernel.org>
References: <20220401143256.1950537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 577298ec55dfc8b9aece54520f0258c3f93a6573 ]

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
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 5e1c1506a4c6..7aecde35cb9a 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -465,6 +465,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 
 		qbuf.addr = addr + offset;
 		qbuf.len = len - offset;
+		qbuf.skip_unmap = false;
 		mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, NULL);
 		frames++;
 	}
-- 
2.34.1

