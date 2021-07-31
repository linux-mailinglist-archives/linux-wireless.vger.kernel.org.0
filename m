Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C628D3DC2A8
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jul 2021 04:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhGaCRm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Jul 2021 22:17:42 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:60846 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231464AbhGaCRl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Jul 2021 22:17:41 -0400
X-UUID: 9f53958af566410cb811042340d5a19b-20210731
X-UUID: 9f53958af566410cb811042340d5a19b-20210731
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1074251285; Sat, 31 Jul 2021 10:17:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 31 Jul 2021 10:17:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 31 Jul 2021 10:17:30 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ben Greear <greearb@candelatech.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v4 1/2] mt76: mt7915: fix hwmon temp sensor mem use-after-free
Date:   Sat, 31 Jul 2021 10:17:27 +0800
Message-ID: <9f5b0cf6c4296d3a9e78a95516cf26d1db4baba9.1627696765.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Without this change, garbage is seen in the hwmon name
and sensors output for mt7915 is garbled.

With the change:

mt7915-pci-1400
Adapter: PCI adapter
temp1:        +49.0°C

Fixes: d6938251bb5b (mt76: mt7915: add thermal sensor device support)
Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v4:  Simplify flow.
v3:  Add 'fixes' tag to aid backports.
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 77c7486d6a5c..a1b9e1b3f700 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -155,13 +155,13 @@ static void mt7915_unregister_thermal(struct mt7915_phy *phy)
 	thermal_cooling_device_unregister(phy->cdev);
 }
 
-static int mt7915_thermal_init(struct mt7915_phy *phy)
+static int mt7915_thermal_init(struct mt7915_phy *phy, const char *prefix)
 {
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
 	struct thermal_cooling_device *cdev;
 	struct device *hwmon;
 
-	cdev = thermal_cooling_device_register(wiphy_name(wiphy), phy,
+	cdev = thermal_cooling_device_register(prefix, phy,
 					       &mt7915_thermal_ops);
 	if (!IS_ERR(cdev)) {
 		if (sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
@@ -175,7 +175,7 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 		return 0;
 
 	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev,
-						       wiphy_name(wiphy), phy,
+						       prefix, phy,
 						       mt7915_hwmon_groups);
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
@@ -403,7 +403,7 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	if (ret)
 		goto error;
 
-	ret = mt7915_thermal_init(phy);
+	ret = mt7915_thermal_init(phy, KBUILD_MODNAME "-ext");
 	if (ret)
 		goto error;
 
@@ -853,7 +853,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt7915_thermal_init(&dev->phy);
+	ret = mt7915_thermal_init(&dev->phy, KBUILD_MODNAME);
 	if (ret)
 		return ret;
 
-- 
2.29.2

