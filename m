Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E6D33C8C7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 22:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhCOVtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 17:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233762AbhCOVtU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 17:49:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CEAB64F07;
        Mon, 15 Mar 2021 21:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615844960;
        bh=B596pz8rLl+vMA61Iba8q4yuZVxTi5MgkS1DJZtK2O4=;
        h=From:To:Cc:Subject:Date:From;
        b=mIdQeXqPAq5Vkkn9KRIChPTW262Jm4I4AOPLkXl7sBFHmxmHHedcf+ULyJjpsx+/P
         CNguv4soa1sRjowLTEml83Fxmg+tbaxs5c928DJIwxitF2DwwpTzgsk+ei6/CqxE2J
         xCu2NDN1zxnrx+5tvxMPWQP5pNxPIy/AYS7gMNT62oCZ5ahyqIFJMQd7eSgMQanKAu
         Fniy3IhfO/PyckaPRZKfzL0CmtKuXfDdmr027uKqNXgE6aouLgAIxl3uxn0/wpTV2X
         DxsUawQXHQXNDCOvMUcyYZGRWJMCcAwRxj53K1ucU71yiFlSMEnvLleXyRb9SGDZ7a
         YLmJe2wKDbpRQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: debugfs: introduce napi_threaded node
Date:   Mon, 15 Mar 2021 22:49:15 +0100
Message-Id: <cb6e4d3169805e34c1a90620b8786659775c28c6.1615844861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce napi_threaded debugfs knob in order to enable/disable NAPI
threaded support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c | 28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index d4a6b8108971..fa48cc3a7a8f 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -25,6 +25,32 @@ mt76_reg_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mt76_reg_get, mt76_reg_set,
 			 "0x%08llx\n");
 
+static int
+mt76_napi_threaded_set(void *data, u64 val)
+{
+	struct mt76_dev *dev = data;
+
+	if (!mt76_is_mmio(dev))
+		return -EOPNOTSUPP;
+
+	if (dev->napi_dev.threaded != val)
+		return dev_set_threaded(&dev->napi_dev, val);
+
+	return 0;
+}
+
+static int
+mt76_napi_threaded_get(void *data, u64 *val)
+{
+	struct mt76_dev *dev = data;
+
+	*val = dev->napi_dev.threaded;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_napi_threaded, mt76_napi_threaded_get,
+			 mt76_napi_threaded_set, "%llu\n");
+
 int mt76_queues_read(struct seq_file *s, void *data)
 {
 	struct mt76_dev *dev = dev_get_drvdata(s->private);
@@ -102,6 +128,8 @@ struct dentry *mt76_register_debugfs(struct mt76_dev *dev)
 	debugfs_create_u32("regidx", 0600, dir, &dev->debugfs_reg);
 	debugfs_create_file_unsafe("regval", 0600, dir, dev,
 				   &fops_regval);
+	debugfs_create_file_unsafe("napi_threaded", 0600, dir, dev,
+				   &fops_napi_threaded);
 	debugfs_create_blob("eeprom", 0400, dir, &dev->eeprom);
 	if (dev->otp.data)
 		debugfs_create_blob("otp", 0400, dir, &dev->otp);
-- 
2.30.2

