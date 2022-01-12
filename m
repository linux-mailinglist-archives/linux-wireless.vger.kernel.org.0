Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2725348C5BC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 15:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354024AbiALOO6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 09:14:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47894 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354006AbiALOOf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 09:14:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EFDC61418
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 14:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954CEC36AE5;
        Wed, 12 Jan 2022 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641996875;
        bh=cun3XwP2/Dzr36iV1nkbLpNZyyXABBCHVQBdwH8Qliw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mNCYxeE6shRQeBB1MSjQQ+FZQ9ZHLBrbzm0mDDvixJtd/tLKJbk2+PWpo//Tu2PMc
         1F7kwjmVODzalso20yu8WRU6AEX70mc1mhzjNNfu60SYRuRyaQ15E5F8lv5Jpw+wwq
         qA2no4Om4XMT2o3MPtjTeou8oAmztJeS2vrRuHgwGVKWZTCcrvYCv3F9RArcq2dAy9
         dh9n8qQgudEJywy+9mlxiFqiEi+M4GgiOAgWFCm69XWM/YTRM/sHf3FS6X9l4v0MfK
         HHafa/pzl2UWP1qwQn6K/PLGhxnutzvDhMBKVzQh1s7k5CVtWxMh7JWhEECphhLVQx
         zazEzgJbmLNAA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com
Subject: [PATCH 3/6] mt76: mt7915: introduce rdd_monitor debugfs node
Date:   Wed, 12 Jan 2022 15:13:50 +0100
Message-Id: <099d4f11a2c34db2e3312283adc3781cc0108e3a.1641996493.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641996493.git.lorenzo@kernel.org>
References: <cover.1641996493.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce rdd_monitor debugfs node in order to dump rdd2 configuration.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index e140336a4fe1..280823fc9f92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -308,6 +308,53 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(mt7915_muru_stats);
 
+static int
+mt7915_rdd_monitor(struct seq_file *s, void *data)
+{
+	struct mt7915_dev *dev = dev_get_drvdata(s->private);
+	struct cfg80211_chan_def *chandef = &dev->rdd2_chandef;
+	const char *bw;
+	int ret = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (!cfg80211_chandef_valid(chandef)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!dev->rdd2_phy) {
+		seq_puts(s, "not running\n");
+		goto out;
+	}
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
+	seq_printf(s, "channel %d (%d MHz) width %s MHz center1: %d MHz\n",
+		   chandef->chan->hw_value, chandef->chan->center_freq,
+		   bw, chandef->center_freq1);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
 static int
 mt7915_fw_debug_wm_set(void *data, u64 val)
 {
@@ -856,6 +903,8 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 				   &dev->hw_pattern);
 		debugfs_create_file("radar_trigger", 0200, dir, dev,
 				    &fops_radar_trigger);
+		debugfs_create_devm_seqfile(dev->mt76.dev, "rdd_monitor", dir,
+					    mt7915_rdd_monitor);
 	}
 
 	if (!ext_phy)
-- 
2.34.1

