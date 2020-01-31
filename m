Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3110414F204
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgAaSRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 13:17:11 -0500
Received: from nbd.name ([46.4.11.11]:59404 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAaSRK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 13:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=E+N0W7UmTxn8pR4Xbg6gHyLUy3Ys2fGDHcQ/zrfcsxM=; b=WUtmJR+vI+hTAF2SlD2kueDQFF
        5bc+UMAzbAp9KPusw523QIvddlnZXx9iTcvsDBZq7Q+yrUA274dWNH+02gQBJYW0skBNMDarI/JQM
        HnUYJUWzI/VQtSPczoU+Sd1kLuC3GKcmkz7EYuNaCvlXqYnzvF4UNzJ5VU/7GRi1ap34=;
Received: from [80.255.7.125] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixaqr-0001G5-BY
        for linux-wireless@vger.kernel.org; Fri, 31 Jan 2020 19:17:09 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 615007AFF3AB; Fri, 31 Jan 2020 19:17:08 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7615: add support for testing hardware reset
Date:   Fri, 31 Jan 2020 19:17:08 +0100
Message-Id: <20200131181708.62698-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200131181708.62698-1-nbd@nbd.name>
References: <20200131181708.62698-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Send an undersized corrupt packet to the DMA queue, which causes the
firmware to issue a full chip reset

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 158c0c183e9c..7d8e53ac51ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -98,6 +98,28 @@ mt7615_fw_debug_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug, mt7615_fw_debug_get,
 			 mt7615_fw_debug_set, "%lld\n");
 
+static int
+mt7615_reset_test_set(void *data, u64 val)
+{
+	struct mt7615_dev *dev = data;
+	struct sk_buff *skb;
+
+	if (!mt7615_wait_for_mcu_init(dev))
+		return 0;
+
+	skb = alloc_skb(1, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put(skb, 1);
+	mt76_tx_queue_skb_raw(dev, 0, skb, 0);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_reset_test, NULL,
+			 mt7615_reset_test_set, "%lld\n");
+
 static int
 mt7615_ampdu_stat_read(struct seq_file *file, void *data)
 {
@@ -264,6 +286,8 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 			   &dev->radar_pattern.power);
 	debugfs_create_file("radar_trigger", 0200, dir, dev,
 			    &fops_radar_pattern);
+	debugfs_create_file("reset_test", 0200, dir, dev,
+			    &fops_reset_test);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "temperature", dir,
 				    mt7615_read_temperature);
 
-- 
2.24.0

