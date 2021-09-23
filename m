Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3A41610B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 16:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbhIWOcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 10:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241679AbhIWOcF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 10:32:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6762610C8;
        Thu, 23 Sep 2021 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632407433;
        bh=BKZ/klgQeOvhrRIOlu8JShuX5ASmvf5wtfV34CePDjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLvi2D9E660hIVXX20pZPbakjKt7CtHZ51uEWR4FVwjjab5kHX5O2MRowZMdGexao
         akCYdyjDQjHJoNTcy+3BBJ6ZcG+fD/2goJC7tJ2R4MUf6W4Fpq6P45BM163VX6vsoN
         6FeEbmnJCXTqeZMas5EFJWB1FhEaSP9YQ2sUldIEoKvok3JGVvRnqRgbg4XW0qKqlg
         vwVewqRoGtH1bhxL6b9Wnv1Z/A+RvebezYkGqfBspbZJCztvr32HU0b2YRe8JhWRRp
         jI2QWlK3uHy0p+9s3A60tIIsnpkABbm+KlZ1mx5WOFBexuu4QSn2KVcFlXYi5v+KLX
         azfnlP1jY/meg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v5 5/5] mt76: mt7915: add twt_stats knob in debugfs
Date:   Thu, 23 Sep 2021 16:29:34 +0200
Message-Id: <795171ffdf91076ebfbe98d04003788dfc509cd9.1632406731.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632406731.git.lorenzo@kernel.org>
References: <cover.1632406731.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce twt_stats knob in debugfs in order to dump established
agreements

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index e1cdfbe52199..1fd4861f17c4 100644
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

