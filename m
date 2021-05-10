Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A032137925B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhEJPSz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 11:18:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58495 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237185AbhEJPQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 11:16:49 -0400
X-UUID: 751e7d6c85c94a24a50f43a48a4590cb-20210510
X-UUID: 751e7d6c85c94a24a50f43a48a4590cb-20210510
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 981774547; Mon, 10 May 2021 23:15:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 May 2021 23:14:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 May 2021 23:14:58 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 5/9] mt76: mt7921: add deep sleep control to runtime-pm knob
Date:   Mon, 10 May 2021 23:14:53 +0800
Message-ID: <1620659697-12048-5-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
References: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CCBB3211708E0EF760A2CB976ADB5631F7BA46BBC0C58AF42C74A748AE02A7212000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add addtional the deep sleep control to runtime-pm knob to
allow us to control driver switching between the full power
mode and the deep sleep mode the firmware is able to support.

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/debugfs.c    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 6ee423dd4027..b41d70be948b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -247,6 +247,9 @@ mt7921_pm_set(void *data, u64 val)
 	ieee80211_iterate_active_interfaces(mphy->hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_pm_interface_iter, mphy->priv);
+
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, !!pm->enable);
+
 	mt7921_mutex_release(dev);
 
 	return 0;
@@ -264,6 +267,20 @@ mt7921_pm_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7921_pm_get, mt7921_pm_set, "%lld\n");
 
+static int
+mt7921_deep_sleep_set(void *data, u64 val)
+{
+	struct mt7921_dev *dev = data;
+
+	mt7921_mutex_acquire(dev);
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, !!val);
+	mt7921_mutex_release(dev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ds, NULL, mt7921_deep_sleep_set, "%lld\n");
+
 static int
 mt7921_pm_stats(struct seq_file *s, void *data)
 {
@@ -355,6 +372,7 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "runtime_pm_stats", dir,
 				    mt7921_pm_stats);
+	debugfs_create_file("deep-sleep", 0600, dir, dev, &fops_ds);
 
 	return 0;
 }
-- 
2.25.1

