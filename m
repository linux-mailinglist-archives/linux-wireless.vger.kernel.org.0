Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCFB1B0984
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgDTMjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 08:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTMjS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 08:39:18 -0400
Received: from localhost.localdomain.com (unknown [151.48.159.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D95206D4;
        Mon, 20 Apr 2020 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386357;
        bh=AHyKPZPTj6Ca5BKUIUvMXRp0TSB94uj4BbF5VIB1da0=;
        h=From:To:Cc:Subject:Date:From;
        b=zPF6gSrVsbuT3ZOEHBrFrIKVOiTUvgG0DPAmo1fHdZ3EX6t5xZG2PKKROUXD+9nbN
         XFZbtqdx3UOzn+5ZL1Je7txWPlrEGCX79PYxSlPefE7rt2W39QD/uifE2bCQTqkxOk
         nCDuYxZ/fUtt7Cm3T82DMfCcoaVqSkikVRfGyY1w=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: fix max wtbl size for 7663
Date:   Mon, 20 Apr 2020 14:39:02 +0200
Message-Id: <45500b45594b4c2e41938d9d31d4c6d060628b0f.1587386278.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Current mt7663 offload firmware can support up to 32 wtbl entries

Fixes: f40ac0f3d3c0 ("mt76: mt7615: introduce mt7663e support")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 11 ++++++++++-
 drivers/net/wireless/mediatek/mt76/util.c          |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index c9533282e7e3..ffb146840377 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -12,8 +12,9 @@
 
 #define MT7615_MAX_INTERFACES		4
 #define MT7615_MAX_WMM_SETS		4
+#define MT7663_WTBL_SIZE		32
 #define MT7615_WTBL_SIZE		128
-#define MT7615_WTBL_RESERVED		(MT7615_WTBL_SIZE - 1)
+#define MT7615_WTBL_RESERVED		(mt7615_wtbl_size(dev) - 1)
 #define MT7615_WTBL_STA			(MT7615_WTBL_RESERVED - \
 					 MT7615_MAX_INTERFACES)
 
@@ -424,6 +425,14 @@ static inline bool mt7615_firmware_offload(struct mt7615_dev *dev)
 	return dev->fw_ver > MT7615_FIRMWARE_V2;
 }
 
+static inline u16 mt7615_wtbl_size(struct mt7615_dev *dev)
+{
+	if (is_mt7663(&dev->mt76) && mt7615_firmware_offload(dev))
+		return MT7663_WTBL_SIZE;
+	else
+		return MT7615_WTBL_SIZE;
+}
+
 void mt7615_scan_work(struct work_struct *work);
 void mt7615_ps_work(struct work_struct *work);
 void mt7615_init_txpower(struct mt7615_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 8c60c450125a..07cf71242d9e 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -46,7 +46,7 @@ int mt76_wcid_alloc(unsigned long *mask, int size)
 {
 	int i, idx = 0, cur;
 
-	for (i = 0; i < size / BITS_PER_LONG; i++) {
+	for (i = 0; i < DIV_ROUND_UP(size, BITS_PER_LONG); i++) {
 		idx = ffs(~mask[i]);
 		if (!idx)
 			continue;
-- 
2.25.3

