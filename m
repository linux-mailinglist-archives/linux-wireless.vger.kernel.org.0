Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5014348B26
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Mar 2021 09:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhCYIGa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Mar 2021 04:06:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41878 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229979AbhCYIGP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Mar 2021 04:06:15 -0400
X-UUID: 800a1a60cd484f3f853a8099d39a9653-20210325
X-UUID: 800a1a60cd484f3f853a8099d39a9653-20210325
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 922555349; Thu, 25 Mar 2021 16:06:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Mar 2021 16:06:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Mar 2021 16:06:07 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/5] mt76: mt7615: only enable DFS test knobs for mt7615
Date:   Thu, 25 Mar 2021 16:06:01 +0800
Message-ID: <20744fae1cbe0dcc098b3112b0a5ccb0b6254587.1616657048.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E78712D97A52E628E3E6A02C6AA7D2A28D243A51270B44D3489959BDF49FF3602000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DFS knobs should not be visible to non-DFS devices.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 7ae48b4fa564..1b414220521a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -517,18 +517,23 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 			    &fops_pm_idle_timeout);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
 				    mt7615_radio_read);
-	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
-	/* test pattern knobs */
-	debugfs_create_u8("pattern_len", 0600, dir,
-			  &dev->radar_pattern.n_pulses);
-	debugfs_create_u32("pulse_period", 0600, dir,
-			   &dev->radar_pattern.period);
-	debugfs_create_u16("pulse_width", 0600, dir,
-			   &dev->radar_pattern.width);
-	debugfs_create_u16("pulse_power", 0600, dir,
-			   &dev->radar_pattern.power);
-	debugfs_create_file("radar_trigger", 0200, dir, dev,
-			    &fops_radar_pattern);
+
+	if (is_mt7615(&dev->mt76)) {
+		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
+				   &dev->hw_pattern);
+		/* test pattern knobs */
+		debugfs_create_u8("pattern_len", 0600, dir,
+				  &dev->radar_pattern.n_pulses);
+		debugfs_create_u32("pulse_period", 0600, dir,
+				   &dev->radar_pattern.period);
+		debugfs_create_u16("pulse_width", 0600, dir,
+				   &dev->radar_pattern.width);
+		debugfs_create_u16("pulse_power", 0600, dir,
+				   &dev->radar_pattern.power);
+		debugfs_create_file("radar_trigger", 0200, dir, dev,
+				    &fops_radar_pattern);
+	}
+
 	debugfs_create_file("reset_test", 0200, dir, dev,
 			    &fops_reset_test);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "temperature", dir,
-- 
2.18.0

