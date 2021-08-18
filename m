Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B33EFF05
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhHRIVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 04:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238006AbhHRIVk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 04:21:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 842DD604D7;
        Wed, 18 Aug 2021 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629274866;
        bh=2JuedQcEF0YJJxMoJYlvSZa/YtWg3zgqn3Ag3zPKGvQ=;
        h=From:To:Cc:Subject:Date:From;
        b=sZvCwGBGWIWh1W/Y53kVCaUPHZzd/p11jiHnZJIQUJ4bbL/eHTzwlmyfYCsiAeqSN
         NLrPRrgQnD6XsEjvcYzF+rHJBM/BkcqKKESZcgqo4N7LkL6b/qpr9fnpofE8UktNCs
         fY5DhhXjyV4MvTEBuvgfySKXjnhCzBd2cb0JrtoO5AwDWcqL2Py3NXGxDOZzWlVFJW
         +OtQUGVk7rCgVkwD29a5VUmhvKk/2Shyyru5PGiy8+yb0fRBJuznj+tuqTfSU1uQN8
         ZLXijPeu9ZiV5ZqYhj5d08Q9NvkZIlMCtvFRIGQhYJFBeWRhW4h+3OlQBtXmRrQkzl
         rFW9GLhQz5LRw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: always wake device if necessary in debugfs
Date:   Wed, 18 Aug 2021 10:20:57 +0200
Message-Id: <fcfa29c373b8bcb124d4e6a39d82dc45037a8560.1629274685.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing device wakeup in debugfs code if we are accessing chip
registers.

Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 29a24e768617..599e6e53e94f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -95,6 +95,8 @@ mt7921_tx_stats_show(struct seq_file *file, void *data)
 	struct mt7921_dev *dev = file->private;
 	int stat[8], i, n;
 
+	mt7921_mutex_acquire(dev);
+
 	mt7921_ampdu_stat_read_phy(&dev->phy, file);
 
 	/* Tx amsdu info */
@@ -104,6 +106,8 @@ mt7921_tx_stats_show(struct seq_file *file, void *data)
 		n += stat[i];
 	}
 
+	mt7921_mutex_release(dev);
+
 	for (i = 0; i < ARRAY_SIZE(stat); i++) {
 		seq_printf(file, "AMSDU pack count of %d MSDU in TXD: 0x%x ",
 			   i + 1, stat[i]);
@@ -124,6 +128,8 @@ mt7921_queues_acq(struct seq_file *s, void *data)
 	struct mt7921_dev *dev = dev_get_drvdata(s->private);
 	int i;
 
+	mt7921_mutex_acquire(dev);
+
 	for (i = 0; i < 16; i++) {
 		int j, acs = i / 4, index = i % 4;
 		u32 ctrl, val, qlen = 0;
@@ -143,6 +149,8 @@ mt7921_queues_acq(struct seq_file *s, void *data)
 		seq_printf(s, "AC%d%d: queued=%d\n", acs, index, qlen);
 	}
 
+	mt7921_mutex_release(dev);
+
 	return 0;
 }
 
-- 
2.31.1

