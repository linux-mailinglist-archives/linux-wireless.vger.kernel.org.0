Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D101D611B
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 14:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEPM4k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 08:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgEPM4k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 08:56:40 -0400
Received: from localhost.localdomain (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C71620671;
        Sat, 16 May 2020 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589633799;
        bh=t1XK2P4v4ACNzk5jRcoLJ1olEixLcO+jtsKU3wNsse8=;
        h=From:To:Cc:Subject:Date:From;
        b=jhiDY1DxcEh9Kp7JuGGL8g+hqTEANRYTTVS4NF1vKpmnf9LEAUh/EerjZ5RaVWw0G
         AH5ohlXvCIIPiYMEwMSY4xzV37twS1jbGmfGHtatAZzMQTyjin3f4Pf29hMx+TCeOg
         dNXYUj9VCFAmgffRvPF2FKgLVC8XUDcOINjmq5t4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: fix NULL pointer deref in mt7615_register_ext_phy
Date:   Sat, 16 May 2020 14:56:33 +0200
Message-Id: <c6f649da8d09ca2c879a9f475a097c8c38b18963.1589633280.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix following NULL pointer dereference in mt7615_register_ext_phy routine

[   27.648860] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000060
[   27.657697] Mem abort info:
[   27.660495]   ESR = 0x96000046
[   27.663549]   EC = 0x25: DABT (current EL), IL = 32 bits
[   27.668857]   SET = 0, FnV = 0
[   27.671910]   EA = 0, S1PTW = 0
[   27.675040] Data abort info:
[   27.677918]   ISV = 0, ISS = 0x00000046
[   27.681751]   CM = 0, WnR = 1
[   27.684717] user pgtable: 4k pages, 39-bit VAs, pgdp=000000007d8cc000
[   27.691156] [0000000000000060] pgd=000000007d281003, pud=000000007d281003, pmd=0000000000000000
[   27.699857] Internal error: Oops: 96000046 [#1] SMP
[   27.774939] CPU: 1 PID: 701 Comm: ash Not tainted 5.4.41 #0
[   27.780500] Hardware name: Bananapi BPI-R64 (DT)
[   27.785108] pstate: 60000005 (nZCv daif -PAN -UAO)
[   27.789897] pc : mt7615_register_ext_phy+0x60/0x2c8 [mt7615_common]
[   27.796156] lr : mt7615_init_debugfs+0x99c/0x18e0 [mt7615_common]
[   27.802237] sp : ffffffc0115dbcb0
[   27.805541] x29: ffffffc0115dbcb0 x28: ffffff803e309600
[   27.810843] x27: 0000000000000000 x26: 0000000000000000
[   27.816144] x25: ffffff803d936928 x24: ffffff803d936950
[   27.821447] x23: 0000000000000000 x22: 0000000fffffffe0
[   27.826749] x21: 0000000000000002 x20: ffffff8001e82620
[   27.832050] x19: 0000000000000000 x18: 0000000000000000
[   27.837352] x17: 0000000000000000 x16: 0000000000000000
[   27.842653] x15: 0000000000000000 x14: 0000000000000000
[   27.847955] x13: 0000000000000000 x12: 0000000000000000
[   27.853256] x11: 0000000000000000 x10: 0000000000000040
[   27.858558] x9 : ffffffc0112b3eb0 x8 : ffffffc0112b3ea8
[   27.863859] x7 : ffffff803e400048 x6 : 0000000000000000
[   27.869161] x5 : ffffff803e400000 x4 : 0000000000000000
[   27.874462] x3 : 0000000000000001 x2 : 0000000000007615
[   27.879764] x1 : 0000000000000068 x0 : ffffffc0088ccc58
[   27.885066] Call trace:
[   27.887505]  mt7615_register_ext_phy+0x60/0x2c8 [mt7615_common]
[   27.893416]  mt7615_init_debugfs+0x99c/0x18e0 [mt7615_common]
[   27.899156]  simple_attr_write+0xf0/0x178
[   27.903158]  debugfs_attr_write+0x4c/0x70
[   27.907159]  full_proxy_write+0x60/0x90
[   27.910987]  __vfs_write+0x18/0x40
[   27.914379]  vfs_write+0xb0/0x1b8
[   27.917685]  ksys_write+0x4c/0xc8
[   27.920989]  __arm64_sys_write+0x18/0x20

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a9f4a2286454..caefa4d37a90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -373,15 +373,6 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	if (phy)
 		return 0;
 
-	INIT_DELAYED_WORK(&phy->mac_work, mt7615_mac_work);
-	INIT_DELAYED_WORK(&phy->scan_work, mt7615_scan_work);
-	skb_queue_head_init(&phy->scan_event_list);
-
-	INIT_WORK(&phy->ps_work, mt7615_ps_work);
-	INIT_WORK(&phy->roc_work, mt7615_roc_work);
-	timer_setup(&phy->roc_timer, mt7615_roc_timer, 0);
-	init_waitqueue_head(&phy->roc_wait);
-
 	mt7615_cap_dbdc_enable(dev);
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops);
 	if (!mphy)
@@ -394,6 +385,15 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
 	mt7615_init_wiphy(mphy->hw);
 
+	INIT_DELAYED_WORK(&phy->mac_work, mt7615_mac_work);
+	INIT_DELAYED_WORK(&phy->scan_work, mt7615_scan_work);
+	skb_queue_head_init(&phy->scan_event_list);
+
+	INIT_WORK(&phy->ps_work, mt7615_ps_work);
+	INIT_WORK(&phy->roc_work, mt7615_roc_work);
+	timer_setup(&phy->roc_timer, mt7615_roc_timer, 0);
+	init_waitqueue_head(&phy->roc_wait);
+
 	mt7615_mac_set_scs(phy, true);
 
 	/*
-- 
2.26.2

