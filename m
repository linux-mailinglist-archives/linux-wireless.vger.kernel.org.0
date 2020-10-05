Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5054E2831BC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJEISq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 04:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJEISp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 04:18:45 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830862075A;
        Mon,  5 Oct 2020 08:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601885925;
        bh=cu+JDuo9kNgYtCtYbMvbBuwUYhgV7zuo+xFhfstVv40=;
        h=From:To:Cc:Subject:Date:From;
        b=GDhxySEAjex2l629tA4Gjs8g+62Bol7qKGSE2snc8WjdHzk/61XjU7DDzC8oL5O96
         3wB8kUbDZsxEq4gZuSVDCEQRHAuA0tlbM1KbflZilFuLHvASLkyVv4KwOWEMx2C0Uv
         da0gjk1J98yKq6ZuxMO4RXXmV5fbD+Ljt+es09Fk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: introduce quota debugfs node for mt7663s
Date:   Mon,  5 Oct 2020 10:18:33 +0200
Message-Id: <1b22a809e1609c31b8131ac692223f27e497dbed.1601885683.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add sched_quota debugfs node for mt7663s. Scheduling quota stats
are useful for debugging

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/debugfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 8272a980af8a..5f6ef389af3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -466,6 +466,20 @@ static const struct file_operations fops_ext_mac_addr = {
 	.write = mt7615_ext_mac_addr_write,
 };
 
+static int
+mt7663s_sched_quota_read(struct seq_file *s, void *data)
+{
+	struct mt7615_dev *dev = dev_get_drvdata(s->private);
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+
+	seq_printf(s, "pse_data_quota\t%d\n", sdio->sched.pse_data_quota);
+	seq_printf(s, "ple_data_quota\t%d\n", sdio->sched.ple_data_quota);
+	seq_printf(s, "pse_mcu_quota\t%d\n", sdio->sched.pse_mcu_quota);
+	seq_printf(s, "sched_deficit\t%d\n", sdio->sched.deficit);
+
+	return 0;
+}
+
 int mt7615_init_debugfs(struct mt7615_dev *dev)
 {
 	struct dentry *dir;
@@ -513,6 +527,9 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	debugfs_create_u32("rf_regidx", 0600, dir, &dev->debugfs_rf_reg);
 	debugfs_create_file_unsafe("rf_regval", 0600, dir, dev,
 				   &fops_rf_reg);
+	if (mt76_is_sdio(&dev->mt76))
+		debugfs_create_devm_seqfile(dev->mt76.dev, "sched-quota", dir,
+					    mt7663s_sched_quota_read);
 
 	return 0;
 }
-- 
2.26.2

