Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F82213613
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgGCIQc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgGCIQa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:30 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79821207FF;
        Fri,  3 Jul 2020 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764189;
        bh=UBes1j4vjYhY4PDH2ZniNzUObt9xb2hHJ5Z92aAHH1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ax1NaOkU6d7dw9/ixGrB5hlKqHuYasmWKRlXC6+3ERmtT+B+R6qf4olvnNMxvgLOE
         g3/pKrZ1EpHnjaQelmQczPi0613Ns8h1ZNmw/DlgM/YYoVihOrs/3CTznzWQojUeFl
         xKHeNEELtRV1LYuAq5GgIHDMrRL5v39HE9zCBe5w=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 05/22] mt76: mt7615: wake device before accessing regmap in debugfs
Date:   Fri,  3 Jul 2020 10:15:44 +0200
Message-Id: <13592f72b6da4ded4ebf96477cc5fb6a9d318cd8.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make sure the device is in full-power before reading regs in debugfs

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 8bb7c64db738..8894a0ab407b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -6,11 +6,16 @@ static int
 mt7615_radar_pattern_set(void *data, u64 val)
 {
 	struct mt7615_dev *dev = data;
+	int err;
 
 	if (!mt7615_wait_for_mcu_init(dev))
 		return 0;
 
-	return mt7615_mcu_rdd_send_pattern(dev);
+	mt7615_mutex_acquire(dev);
+	err = mt7615_mcu_rdd_send_pattern(dev);
+	mt7615_mutex_release(dev);
+
+	return err;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_pattern, NULL,
@@ -84,7 +89,10 @@ mt7615_fw_debug_set(void *data, u64 val)
 		return 0;
 
 	dev->fw_debug = val;
+
+	mt7615_mutex_acquire(dev);
 	mt7615_mcu_fw_log_2_host(dev, dev->fw_debug ? 2 : 0);
+	mt7615_mutex_release(dev);
 
 	return 0;
 }
@@ -111,6 +119,8 @@ mt7615_reset_test_set(void *data, u64 val)
 	if (!mt7615_wait_for_mcu_init(dev))
 		return 0;
 
+	mt7615_mutex_acquire(dev);
+
 	skb = alloc_skb(1, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
@@ -118,6 +128,8 @@ mt7615_reset_test_set(void *data, u64 val)
 	skb_put(skb, 1);
 	mt76_tx_queue_skb_raw(dev, 0, skb, 0);
 
+	mt7615_mutex_release(dev);
+
 	return 0;
 }
 
@@ -167,9 +179,13 @@ mt7615_ampdu_stat_read(struct seq_file *file, void *data)
 {
 	struct mt7615_dev *dev = file->private;
 
+	mt7615_mutex_acquire(dev);
+
 	mt7615_ampdu_stat_read_phy(&dev->phy, file);
 	mt7615_ampdu_stat_read_phy(mt7615_ext_phy(dev), file);
 
+	mt7615_mutex_release(dev);
+
 	return 0;
 }
 
@@ -221,7 +237,10 @@ static int mt7615_read_temperature(struct seq_file *s, void *data)
 		return 0;
 
 	/* cpu */
+	mt7615_mutex_acquire(dev);
 	temp = mt7615_mcu_get_temperature(dev, 0);
+	mt7615_mutex_release(dev);
+
 	seq_printf(s, "Temperature: %d\n", temp);
 
 	return 0;
@@ -233,6 +252,8 @@ mt7615_queues_acq(struct seq_file *s, void *data)
 	struct mt7615_dev *dev = dev_get_drvdata(s->private);
 	int i;
 
+	mt7615_mutex_acquire(dev);
+
 	for (i = 0; i < 16; i++) {
 		int j, wmm_idx = i % MT7615_MAX_WMM_SETS;
 		int acs = i / MT7615_MAX_WMM_SETS;
@@ -253,6 +274,8 @@ mt7615_queues_acq(struct seq_file *s, void *data)
 		seq_printf(s, "AC%d%d: queued=%d\n", wmm_idx, acs, qlen);
 	}
 
+	mt7615_mutex_release(dev);
+
 	return 0;
 }
 
-- 
2.26.2

