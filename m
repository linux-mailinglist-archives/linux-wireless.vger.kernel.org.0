Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686363FE8EB
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Sep 2021 07:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhIBFxt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Sep 2021 01:53:49 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:55406 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236573AbhIBFxs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Sep 2021 01:53:48 -0400
X-UUID: 134f060d8f1b4c75a293380cda4bf6db-20210902
X-UUID: 134f060d8f1b4c75a293380cda4bf6db-20210902
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 904648352; Thu, 02 Sep 2021 13:52:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 13:52:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 13:52:47 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v6 2/2] mt76: mt7615: fix hwmon temp sensor mem use-after-free
Date:   Thu, 2 Sep 2021 13:52:04 +0800
Message-ID: <9b5e38c8ac84ded6af5969e7780a7c23ec154857.1630561595.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <101c24cfc81ed5819d93c60cf2e96bdd6ce97c47.1630561595.git.ryder.lee@mediatek.com>
References: <101c24cfc81ed5819d93c60cf2e96bdd6ce97c47.1630561595.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Without this change, garbage is seen in the hwmon name and sensors output
for mt7615 is garbled.

Fixes: 109e505ad944 ("mt76: mt7615: add thermal sensor device support")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v6:  Use devm_kasprintf to add a generic prefix "mt7615-" on wiphy name.
v5:  Use devm_kstrdup on the wiphy name as suggested.
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 05235a60d413..e053548cafd2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -49,12 +49,14 @@ int mt7615_thermal_init(struct mt7615_dev *dev)
 {
 	struct wiphy *wiphy = mt76_hw(dev)->wiphy;
 	struct device *hwmon;
+	const char *name;
 
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return 0;
 
-	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev,
-						       wiphy_name(wiphy), dev,
+	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7615-%s",
+			      wiphy_name(wiphy));
+	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, dev,
 						       mt7615_hwmon_groups);
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
-- 
2.29.2

