Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050F43CB955
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jul 2021 17:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbhGPPHn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jul 2021 11:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240693AbhGPPHk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jul 2021 11:07:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 904EF60FF3;
        Fri, 16 Jul 2021 15:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447885;
        bh=1R+eoZXo/tV2qP8G6uWnQYKp77VeuWQ7hqp7ZJ54BPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/1m7cy92JMOQZ+Mgo5xBtnHW3eVnjSQewEPNSqeq1TsXcOxcmyHLpKsjZSv7g3F5
         kPO9GPgc+pPk8kgXzBCVkWdtpcda34VsP1lCy7XZrzVp35/QCIQso/lhE9wuWToDKD
         DnWXFuehv81Mbp2myHthuSd5v9j0k1V/HlgOo986vEkNf8+18+vBOiu481lqSZpXm9
         QrwlAp4M1E09MTXK9ByyhMKfiqhwJFkhJQPdVtTHZQUZQL3q96iTMcrRAkpk2m4+hm
         dhGyXdjFbLu1DLm0WDpfjrbv6/99EH4XL0VRB41HqqCV/bjMFkFfCO+Mbam1ySegmt
         sv+s8HUkBclyw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name, ryder.lee@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [RFC mac80211-next 7/7] mt76: mt7915: add twt_stats knob in debugfs
Date:   Fri, 16 Jul 2021 17:04:06 +0200
Message-Id: <da9f8fda4ad3adb4e143157de2ffba116a87edd8.1626447537.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626447537.git.lorenzo@kernel.org>
References: <cover.1626447537.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce twt_stats knob in debugfs in order to dump established
agreements

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 1a48b09d0cb7..5ed329f720d6 100644
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
+	rcu_read_lock();
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

