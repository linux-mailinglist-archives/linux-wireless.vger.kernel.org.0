Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085DD41B2BE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241599AbhI1PQq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 11:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241565AbhI1PQj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 11:16:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FEFC61213;
        Tue, 28 Sep 2021 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842100;
        bh=btf0+cZBj8wE+vw7HdI0+8nAUbKyoAUG1FzjFtkE3Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUJlC9ApJktdrZTYXJCLaHxx4WlstobkIuhdt5Wh80trT4wSWgaKPcF2bsZpGSbY0
         W6B7UGlN3AYt2zrKS1E9qc1ogY5sxSRvL3FoXKwAD4aoDsrY1p37EW9v0BOL3uPOep
         becLnCBLADuymm1mwkK578mELTtj1YQ2T3iW/00c63QNOI/zjtTEDw78zdkGHMtu9r
         qsAe3Z0jvNKoaXKdLg5q6jVN+X6+l6cttVaKXUSeisOGPRBJgrQR9klT8wMq+C+zXN
         MByMlagUKDonKMO31CUN76WRuj8H0vAIU3gyWhEH9fPlBxboEpxfxXvrgH1Ou9C1/L
         z8I2W0w5rIbcw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com, john@phrozen.org
Subject: [RFC 6/7] mt76: mt7915: introduce rdd_monitor debugfs node
Date:   Tue, 28 Sep 2021 17:14:37 +0200
Message-Id: <9f68a6177184bc463facf16f7133fc2a3c8b5943.1632841652.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632841652.git.lorenzo@kernel.org>
References: <cover.1632841652.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce rdd_monitor debugfs node in order to dump rdd2 configuration.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 2c010221e32d..7d8b7dbc5b58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -84,6 +84,36 @@ mt7915_radar_trigger(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_trigger, NULL,
 			 mt7915_radar_trigger, "%lld\n");
 
+static int
+mt7915_rdd_monitor(struct seq_file *s, void *data)
+{
+	struct mt7915_dev *dev = dev_get_drvdata(s->private);
+	struct cfg80211_chan_def *chandef = &dev->offchan_chain.chandef;
+	const char *bw;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_40:
+		bw = "40";
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		bw = "80";
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		bw = "160";
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		bw = "80P80";
+		break;
+	default:
+		bw = "20";
+		break;
+	}
+
+	seq_printf(s, " freq %d MHz bw %s MHz\n", chandef->center_freq1, bw);
+
+	return 0;
+}
+
 static int
 mt7915_fw_debug_set(void *data, u64 val)
 {
@@ -498,6 +528,8 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 				   &dev->hw_pattern);
 		debugfs_create_file("radar_trigger", 0200, dir, dev,
 				    &fops_radar_trigger);
+		debugfs_create_devm_seqfile(dev->mt76.dev, "rdd_monitor", dir,
+					    mt7915_rdd_monitor);
 	}
 
 	return 0;
-- 
2.31.1

