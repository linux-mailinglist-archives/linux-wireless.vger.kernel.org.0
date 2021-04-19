Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA91364795
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbhDSP6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 11:58:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48650 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239800AbhDSP6q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 11:58:46 -0400
X-UUID: 134ea7d3511f43a1b7248903a18b444b-20210419
X-UUID: 134ea7d3511f43a1b7248903a18b444b-20210419
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 585444657; Mon, 19 Apr 2021 23:58:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 23:58:07 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Apr 2021 23:58:07 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7921: fix possible invalid register access
Date:   Mon, 19 Apr 2021 23:58:05 +0800
Message-ID: <1618847885-10680-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Disable the interrupt and synchronze for the pending irq handlers to ensure
the irq tasklet is not being scheduled after the suspend to avoid the
possible invalid register access acts when the host pcie controller is
suspended.

[17932.910534] mt7921e 0000:01:00.0: pci_pm_suspend+0x0/0x22c returned 0 after 21375 usecs
[17932.910590] pcieport 0000:00:00.0: calling pci_pm_suspend+0x0/0x22c @ 18565, parent: pci0000:00
[17932.910602] pcieport 0000:00:00.0: pci_pm_suspend+0x0/0x22c returned 0 after 8 usecs
[17932.910671] mtk-pcie 11230000.pcie: calling platform_pm_suspend+0x0/0x60 @ 22783, parent: soc
[17932.910674] mtk-pcie 11230000.pcie: platform_pm_suspend+0x0/0x60 returned 0 after 0 usecs

...

17933.615352] x1 : 00000000000d4200 x0 : ffffff8269ca2300
[17933.620666] Call trace:
[17933.623127]  mt76_mmio_rr+0x28/0xf0 [mt76]
[17933.627234]  mt7921_rr+0x38/0x44 [mt7921e]
[17933.631339]  mt7921_irq_tasklet+0x54/0x1d8 [mt7921e]
[17933.636309]  tasklet_action_common+0x12c/0x16c
[17933.640754]  tasklet_action+0x24/0x2c
[17933.644418]  __do_softirq+0x16c/0x344
[17933.648082]  irq_exit+0xa8/0xac
[17933.651224]  scheduler_ipi+0xd4/0x148
[17933.654890]  handle_IPI+0x164/0x2d4
[17933.658379]  gic_handle_irq+0x140/0x178
[17933.662216]  el1_irq+0xb8/0x180
[17933.665361]  cpuidle_enter_state+0xf8/0x204
[17933.669544]  cpuidle_enter+0x38/0x4c
[17933.673122]  do_idle+0x1a4/0x2a8
[17933.676352]  cpu_startup_entry+0x24/0x28
[17933.680276]  rest_init+0xd4/0xe0
[17933.683508]  arch_call_rest_init+0x10/0x18
[17933.687606]  start_kernel+0x340/0x3b4
[17933.691279] Code: aa0003f5 d503201f f953eaa8 8b344108 (b9400113)
[17933.697373] ---[ end trace a24b8e26ffbda3c5 ]---
[17933.767846] Kernel panic - not syncing: Fatal exception in interrupt

Fixes: ffa1bf97425b ("mt76: mt7921: introduce PM support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 40e2086d075c..c2c8ff979e6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -195,7 +195,6 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	mt76_for_each_q_rx(mdev, i) {
 		napi_disable(&mdev->napi[i]);
 	}
-	tasklet_kill(&dev->irq_tasklet);
 
 	pci_enable_wake(pdev, pci_choose_state(pdev, state), true);
 
@@ -210,6 +209,9 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 
 	/* disable interrupt */
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+	synchronize_irq(pdev->irq);
+	tasklet_kill(&dev->irq_tasklet);
 
 	err = mt7921_mcu_fw_pmctrl(dev);
 	if (err)
-- 
2.25.1

