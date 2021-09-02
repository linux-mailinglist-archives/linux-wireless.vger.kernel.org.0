Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ADF3FE8E8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Sep 2021 07:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhIBFxn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Sep 2021 01:53:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47678 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231831AbhIBFxm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Sep 2021 01:53:42 -0400
X-UUID: 829f045f5a7c4f3a9089fb1c2a6bf45d-20210902
X-UUID: 829f045f5a7c4f3a9089fb1c2a6bf45d-20210902
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 309807063; Thu, 02 Sep 2021 13:52:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 13:52:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 13:52:40 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ben Greear <greearb@candelatech.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v6 1/2] mt76: mt7915: fix hwmon temp sensor mem use-after-free
Date:   Thu, 2 Sep 2021 13:52:03 +0800
Message-ID: <101c24cfc81ed5819d93c60cf2e96bdd6ce97c47.1630561295.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Without this change, garbage is seen in the hwmon name and sensors output
for mt7915 is garbled. It appears that the hwmon logic does not make a
copy of the incoming string, but instead just copies a char* and expects
it to never go away.

Fixes: d6938251bb5b ("mt76: mt7915: add thermal sensor device support")
Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v6:  Use devm_kasprintf to add a generic prefix "mt7915-" on wiphy name.
	 Drop an unrelated change.
v5:  Use devm_kstrdup on the wiphy name as suggested.
v4:  Simplify flow.
v3:  Add 'fixes' tag to aid backports.
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index acc83e9f409b..f43e4077489b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -160,9 +160,12 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
 	struct thermal_cooling_device *cdev;
 	struct device *hwmon;
+	const char *name;
 
-	cdev = thermal_cooling_device_register(wiphy_name(wiphy), phy,
-					       &mt7915_thermal_ops);
+	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7915-%s",
+			      wiphy_name(wiphy));
+
+	cdev = thermal_cooling_device_register(name, phy, &mt7915_thermal_ops);
 	if (!IS_ERR(cdev)) {
 		if (sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
 				      "cooling_device") < 0)
@@ -174,8 +177,7 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return 0;
 
-	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev,
-						       wiphy_name(wiphy), phy,
+	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
 						       mt7915_hwmon_groups);
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
-- 
2.29.2

