Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64E83E4ADB
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 19:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhHIR3c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 13:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234340AbhHIR3b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 13:29:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0832C60560;
        Mon,  9 Aug 2021 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628530151;
        bh=ImR67/pfm7mjLoaA6raBLDZpWdhGEilfX/j1+CCgTJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JclW8ohkS7a2i+lbI4dIH5bgh4ux0Cb0JE0tOX0/JjKSdO9PG+Nk1GQzhAb1UJN4R
         O74d1LOPpoSDUK98CJm3S9zT6IVq80DSyi93NpdEruyL5v8W7F4mWJglgrL6aX4ZA7
         RQRuOY5J/+24CZmZ1sW2kgec9NsiLDb2Dfof1QTe9gJNU1KL3zYDfaEIkbK0kkqmeQ
         u6xe9D0v4VA+6GzIt4s/xzYD8P69k4eaKO+Bv/0eGfvO+rZ5QdPg9qXOnLyOM8pBu7
         g3/oJqaXYm4pW8AbrUWw9OTgFud1k00wtILr4bwGOTG61AmKO3U8Y0u6oa2PsiWl5Y
         OdVIRcksS8Cjw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v2 mac80211-next 7/7] mt76: mt7915: add twt_stats knob in debugfs
Date:   Mon,  9 Aug 2021 19:28:33 +0200
Message-Id: <410b334bee0703a22b4d9509b7dc7f1073d86882.1628529781.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628529781.git.lorenzo@kernel.org>
References: <cover.1628529781.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce twt_stats knob in debugfs in order to dump established
agreements

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 1a48b09d0cb7..c54239e84243 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -335,6 +335,32 @@ mt7915_read_rate_txpower(struct seq_file *s, void *data)
 	return 0;
 }
 
+static int
+mt7915_twt_stats(struct seq_file *s, void *data)
+{
+	struct mt7915_dev *dev = dev_get_drvdata(s->private);
+	struct mt7915_twt_flow *iter;
+
+	rcu_read_lock();
+
+	seq_puts(s, "     wcid |       id |    flags |      exp | mantissa");
+	seq_puts(s, " | duration |            tsf |\n");
+	list_for_each_entry_rcu(iter, &dev->twt_list, list)
+		seq_printf(s,
+			"%9d | %8d | %5c%c%c%c | %8d | %8d | %8d | %14lld |\n",
+			iter->wcid, iter->id,
+			iter->sched ? 's' : 'u',
+			iter->protection ? 'p' : '-',
+			iter->trigger ? 't' : '-',
+			iter->flowtype ? '-' : 'a',
+			iter->exp, iter->mantissa,
+			iter->duration, iter->tsf);
+
+	rcu_read_unlock();
+
+	return 0;
+}
+
 int mt7915_init_debugfs(struct mt7915_dev *dev)
 {
 	struct dentry *dir;
@@ -352,6 +378,8 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
+				    mt7915_twt_stats);
 	/* test knobs */
 	debugfs_create_file("radar_trigger", 0200, dir, dev,
 			    &fops_radar_trigger);
-- 
2.31.1

