Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE301372A80
	for <lists+linux-wireless@lfdr.de>; Tue,  4 May 2021 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhEDM7M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 May 2021 08:59:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55874 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230187AbhEDM7K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 May 2021 08:59:10 -0400
X-UUID: 0a11770fe8b64f6f82ae09cf97a11a9c-20210504
X-UUID: 0a11770fe8b64f6f82ae09cf97a11a9c-20210504
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 834467344; Tue, 04 May 2021 20:52:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 4 May 2021 20:52:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 May 2021 20:52:31 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: add debugfs knob to read efuse value from FW
Date:   Tue, 4 May 2021 20:52:25 +0800
Message-ID: <20210504125225.2536-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BC4AA88CC25A608AA38ABC03DA3762F8B883086173EF8A88791D8397AACCCE642000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In efuse mode, mt7915 only reads efuse values from FW which driver need.
Add a debugfs knob to read addtional efuse values from a specific field,
which is useful in some cases such as checking if rf values in efuse
are properly burned.

An example of usage:
echo 0x400 > efuse_idx
hexdump -C eeprom

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 6a8ddee..0526459 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -73,6 +73,21 @@ mt7915_radar_trigger(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_trigger, NULL,
 			 mt7915_radar_trigger, "%lld\n");
 
+static int
+mt7915_efuse_idx_set(void *data, u64 val)
+{
+	struct mt7915_dev *dev = data;
+	u8 *eep = dev->mt76.eeprom.data;
+
+	if (eep[val] == 0xff && !dev->flash_mode)
+		mt7915_mcu_get_eeprom(dev, val);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_efuse_idx, NULL,
+			 mt7915_efuse_idx_set, "0x%llx\n");
+
 static int
 mt7915_fw_debug_set(void *data, u64 val)
 {
@@ -390,6 +405,7 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 	debugfs_create_file("radar_trigger", 0200, dir, dev,
 			    &fops_radar_trigger);
 	debugfs_create_file("ser_trigger", 0200, dir, dev, &fops_ser_trigger);
+	debugfs_create_file("efuse_idx", 0200, dir, dev, &fops_efuse_idx);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "temperature", dir,
 				    mt7915_read_temperature);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower_sku", dir,
-- 
2.18.0

