Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064633F5015
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 20:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhHWSEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 14:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232071AbhHWSEF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 14:04:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E9EC613A6;
        Mon, 23 Aug 2021 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629741802;
        bh=6pYbU9x1AIKeZXK+TbaFZOdM74+ZgHIfIbcdpbRFwv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTDz6J8/JGIsItvdtJCNtx067uro4PUiUYmODAD+VVxdrwMsfIbqgHqtrVGe6wdbu
         2fLjI0H863LUALsQTcaMw1wUYSPzWkpkt7sS4TosIBhH1E3aREnrWyRJQncD+k8ptX
         LohY5GOOWjFbEFjB6CDPdGJKFM3Q9VyfwQ/Ot3Qp2h4ASqEABjSg+Ips+HXgNwf6zt
         8mOEZwsL0vkg5BOlOn8GKYq72ETqmBlE4hlyOq2udmJFBYwxf+IWX0qJUwa2po1WhJ
         Lgac/4nJCaMIQY9zQcIf5J6d9OE/Z3TPil8IDuuQdtkmLvYVdOrXQQcuV3X1os6iWS
         BTr1yMsXk09jw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v4 mac80211-next 7/7] mt76: mt7915: add twt_stats knob in debugfs
Date:   Mon, 23 Aug 2021 20:02:44 +0200
Message-Id: <e21db51e4f8b5d9de9fa616fe31a6f99bf8112c6.1629741512.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629741512.git.lorenzo@kernel.org>
References: <cover.1629741512.git.lorenzo@kernel.org>
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
index d9d18f662039..655e4f5171e4 100644
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

