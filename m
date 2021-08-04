Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231E13DFC2E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 09:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhHDHha (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 03:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235860AbhHDHh0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 03:37:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0509760F14;
        Wed,  4 Aug 2021 07:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628062634;
        bh=qMfIBdwcbtmBUoiLS+gLaPi8FdFMHcqcAUFRaBJ9uLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8Kogg+/2bhhP3miWOXZ8mbP14ma9zDidpeicvsK/VJN6D4ZHSz/P64T+ue3Kvq1M
         Tobo7vPK7+m90ZNfACD9ebVwhfxDl8BVlzAwxIpU6Qndw26x+sUgmfiV66I6miAqtF
         53uJyYmEWkJu1MNtNCLUY5nMRCqH2JOfFgOZ9eomNMQ8UEKOppH2js1859RYd9GdCO
         C3IXaBYOqcaU170sIVAup+xlggewo6wI3nd1Okd1qf3OyT0UhJt2b8k0YvSuWoceC8
         axEnPc/Hcfv/vadcBzOWSnXGa6qAQqHdlpJsRTdjmaH/xqfadYUmkwgHlssUJg+fMd
         yBbsKyWsy5zuw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH mac80211-next 7/7] mt76: mt7915: add twt_stats knob in debugfs
Date:   Wed,  4 Aug 2021 09:36:38 +0200
Message-Id: <c15deb39ada1d7f642a7cf7bf21a60e84dde240d.1628062233.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628062233.git.lorenzo@kernel.org>
References: <cover.1628062233.git.lorenzo@kernel.org>
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

