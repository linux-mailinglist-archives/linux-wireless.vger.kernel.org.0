Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7A27A200
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 19:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgI0RS5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 13:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0RSz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 13:18:55 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68077C0613D3
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U4TXSSZnrYaMyth86PJ7flWb9nMNjKjiTTgNt7qx7A8=; b=SAbw5NLK03B3yekN7vLDh/2+NX
        87E2SR8p7YFj7UoCUEFlOGcrr+0Xw4we97SNwkxpEhZvIm1HHGd27fkgvKxHX8beLXVdwPcF+tdHn
        pJ9yczzWstABfwYRapPHr1S9cWvAVL3IvS4SKpDQJZHtEgLStt58MEXxi9QgYTfY6xWA=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kMaK6-0002oU-1X
        for linux-wireless@vger.kernel.org; Sun, 27 Sep 2020 19:18:54 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/8] mt76: mt7615: add debugfs knob for setting extended local mac addresses
Date:   Sun, 27 Sep 2020 19:18:48 +0200
Message-Id: <20200927171852.48669-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200927171852.48669-1-nbd@nbd.name>
References: <20200927171852.48669-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is primarily for testing and can be used in combination with monitor
mode to make the card respond to packets sent to a specific MAC address.
For now this is only exposed as a debug/testing feature, later on the
approach might be used to support more concurrent station interfaces

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 87 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 11 +++
 3 files changed, 100 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 00ba550fc48f..efdc61c812ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -365,6 +365,92 @@ mt7615_rf_reg_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_reg, mt7615_rf_reg_get, mt7615_rf_reg_set,
 			 "0x%08llx\n");
 
+static ssize_t
+mt7615_ext_mac_addr_read(struct file *file, char __user *userbuf,
+			 size_t count, loff_t *ppos)
+{
+	struct mt7615_dev *dev = file->private_data;
+	char buf[32 * ((ETH_ALEN * 3) + 4) + 1];
+	u8 addr[ETH_ALEN];
+	int ofs = 0;
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		if (!(dev->muar_mask & BIT(i)))
+			continue;
+
+		mt76_wr(dev, MT_WF_RMAC_MAR1,
+			FIELD_PREP(MT_WF_RMAC_MAR1_IDX, i * 2) |
+			MT_WF_RMAC_MAR1_START);
+		put_unaligned_le32(mt76_rr(dev, MT_WF_RMAC_MAR0), addr);
+		put_unaligned_le16((mt76_rr(dev, MT_WF_RMAC_MAR1) &
+				    MT_WF_RMAC_MAR1_ADDR), addr + 4);
+		ofs += snprintf(buf + ofs, sizeof(buf) - ofs, "%d=%pM\n", i, addr);
+	}
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ofs);
+}
+
+static ssize_t
+mt7615_ext_mac_addr_write(struct file *file, const char __user *userbuf,
+			  size_t count, loff_t *ppos)
+{
+	struct mt7615_dev *dev = file->private_data;
+	unsigned long idx = 0;
+	u8 addr[ETH_ALEN];
+	char buf[32];
+	char *p;
+
+	if (count > sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	buf[sizeof(buf) - 1] = '\0';
+
+	p = strchr(buf, '=');
+	if (p) {
+		*p = 0;
+		p++;
+
+		if (kstrtoul(buf, 0, &idx) || idx > 31)
+			return -EINVAL;
+	} else {
+		idx = 0;
+		p = buf;
+	}
+
+	if (!mac_pton(p, addr))
+		return -EINVAL;
+
+	if (is_valid_ether_addr(addr)) {
+		dev->muar_mask |= BIT(idx);
+	} else {
+		memset(addr, 0, sizeof(addr));
+		dev->muar_mask &= ~BIT(idx);
+	}
+
+	mt76_rmw_field(dev, MT_WF_RMAC_MORE(0), MT_WF_RMAC_MORE_MUAR_MODE, 1);
+	mt76_wr(dev, MT_WF_RMAC_MAR0, get_unaligned_le32(addr));
+	mt76_wr(dev, MT_WF_RMAC_MAR1,
+		get_unaligned_le16(addr + 4) |
+		FIELD_PREP(MT_WF_RMAC_MAR1_IDX, idx * 2) |
+		MT_WF_RMAC_MAR1_START |
+		MT_WF_RMAC_MAR1_WRITE);
+
+	mt76_rmw_field(dev, MT_WF_RMAC_MORE(0), MT_WF_RMAC_MORE_MUAR_MODE, !!dev->muar_mask);
+
+	return count;
+}
+
+static const struct file_operations fops_ext_mac_addr = {
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+	.read = mt7615_ext_mac_addr_read,
+	.write = mt7615_ext_mac_addr_write,
+};
+
 int mt7615_init_debugfs(struct mt7615_dev *dev)
 {
 	struct dentry *dir;
@@ -406,6 +492,7 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 			    &fops_reset_test);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "temperature", dir,
 				    mt7615_read_temperature);
+	debugfs_create_file("ext_mac_addr", 0600, dir, dev, &fops_ext_mac_addr);
 
 	debugfs_create_u32("rf_wfidx", 0600, dir, &dev->debugfs_rf_wf);
 	debugfs_create_u32("rf_regidx", 0600, dir, &dev->debugfs_rf_reg);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 716956b58c13..43d8256af66a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -295,6 +295,8 @@ struct mt7615_dev {
 	u32 debugfs_rf_wf;
 	u32 debugfs_rf_reg;
 
+	u32 muar_mask;
+
 #ifdef CONFIG_NL80211_TESTMODE
 	struct {
 		u32 *reg_backup;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 61623f480806..6e5db015b32c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -333,6 +333,9 @@ enum mt7615_reg_base {
 #define MT_WF_RFCR_DROP_NDPA		BIT(20)
 #define MT_WF_RFCR_DROP_UNWANTED_CTL	BIT(21)
 
+#define MT_WF_RMAC_MORE(_band)		MT_WF_RMAC((_band) ? 0x124 : 0x024)
+#define MT_WF_RMAC_MORE_MUAR_MODE	GENMASK(31, 30)
+
 #define MT_WF_RFCR1(_band)		MT_WF_RMAC((_band) ? 0x104 : 0x004)
 #define MT_WF_RFCR1_DROP_ACK		BIT(4)
 #define MT_WF_RFCR1_DROP_BF_POLL	BIT(5)
@@ -342,6 +345,14 @@ enum mt7615_reg_base {
 
 #define MT_CHFREQ(_band)		MT_WF_RMAC((_band) ? 0x130 : 0x030)
 
+#define MT_WF_RMAC_MAR0			MT_WF_RMAC(0x025c)
+#define MT_WF_RMAC_MAR1			MT_WF_RMAC(0x0260)
+#define MT_WF_RMAC_MAR1_ADDR		GENMASK(15, 0)
+#define MT_WF_RMAC_MAR1_START		BIT(16)
+#define MT_WF_RMAC_MAR1_WRITE		BIT(17)
+#define MT_WF_RMAC_MAR1_IDX		GENMASK(29, 24)
+#define MT_WF_RMAC_MAR1_GROUP		GENMASK(31, 30)
+
 #define MT_WF_RMAC_MIB_TIME0		MT_WF_RMAC(0x03c4)
 #define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
 #define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
-- 
2.28.0

