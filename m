Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9843623F5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 17:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343674AbhDPPbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 11:31:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35315 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343694AbhDPPbH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 11:31:07 -0400
X-UUID: d859b297ecc5411b96d00c906075a929-20210416
X-UUID: d859b297ecc5411b96d00c906075a929-20210416
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2110974663; Fri, 16 Apr 2021 23:30:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Apr 2021 23:30:37 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Apr 2021 23:30:37 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 1/2] mt76: mt7921: add wifisys reset support in debugfs
Date:   Fri, 16 Apr 2021 23:30:35 +0800
Message-ID: <1618587036-17143-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 84D286E04426F2F02A4F9A502085D6E3F0D8BF0ABEFDFD84E245B3A78CAD577F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce chip_reset knob in mt7921 debugfs to export a way to users
able to trigger wifi reset, and group the similar operations
previously defined in chip_config in the same knob.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: reuse the same knob previously defined in chip_config
---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 024524173115..7ced843b30b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -288,19 +288,28 @@ mt7921_pm_idle_timeout_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_pm_idle_timeout, mt7921_pm_idle_timeout_get,
 			 mt7921_pm_idle_timeout_set, "%lld\n");
 
-static int mt7921_config(void *data, u64 val)
+static int mt7921_chip_reset(void *data, u64 val)
 {
 	struct mt7921_dev *dev = data;
-	int ret;
-
-	mt7921_mutex_acquire(dev);
-	ret = mt76_connac_mcu_chip_config(&dev->mt76);
-	mt7921_mutex_release(dev);
+	int ret = 0;
+
+	switch (val) {
+	case 1:
+		/* Reset wifisys directly. */
+		mt7921_reset(&dev->mt76);
+		break;
+	default:
+		/* Collect the core dump before reset wifisys. */
+		mt7921_mutex_acquire(dev);
+		ret = mt76_connac_mcu_chip_config(&dev->mt76);
+		mt7921_mutex_release(dev);
+		break;
+	}
 
 	return ret;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(fops_config, NULL, mt7921_config, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_reset, NULL, mt7921_chip_reset, "%lld\n");
 
 int mt7921_init_debugfs(struct mt7921_dev *dev)
 {
@@ -321,7 +330,7 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
 	debugfs_create_file("idle-timeout", 0600, dir, dev,
 			    &fops_pm_idle_timeout);
-	debugfs_create_file("chip_config", 0600, dir, dev, &fops_config);
+	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
 
 	return 0;
 }
-- 
2.25.1

