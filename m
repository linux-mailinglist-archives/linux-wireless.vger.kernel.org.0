Return-Path: <linux-wireless+bounces-28650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD38BC394A6
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 07:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4E53B8FF7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 06:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146832DC354;
	Thu,  6 Nov 2025 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lRkOCF47"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0538F1E9906
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411390; cv=none; b=GxBptJw9HhWS5y2ddHNmaQEWVMLrJ4YLNi/B/3glrJvtvx2ujTDVL9COvnRW7Nf3ppVeJkZ+gSUk1xlW9LYG7e4BGjay1MsLJyK3/pMlZHC04WK3aWWvV7pTc50Sp98/8gil3ECuw2Ex++Sr/GgUHQN9PZ0oX30gCnkrKVRPSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411390; c=relaxed/simple;
	bh=q0BV/1NfashOFvc/I/zBM4ha5tdTC2ETvzSCZhARZpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cc3AAdrbihihjbjlEUcRYGgOZDquYti82QZ8p/HA2X5ck2K05xP8XTkLm/i8TQJIKq7CftHqLgaWXpD+p9GCWWVhIV0acFt0ngvDWovuAKCe0OLAItmeokRmSWgY8/SiKCmudqTd/Z8HS3ngJODnbqyiJIRh5u/bhuR8igCOUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lRkOCF47; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d6c463e6badb11f08ac0a938fc7cd336-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uRQCbxty+oCeY3WSzE8Zyh70FUpPPnBhb+RjzJOjTts=;
	b=lRkOCF47GY6nuf+/YvQKp1XTVUnunZmUo7bntcJt5xY47wN2TGmzrp1ggq92JkqRGu9TY7YN7Vhp2xKe/3RhLMwe6yfL3fn9G3j31TkzfXNqqvDlmxC9dqlMHCetigItmjqRn0ttpqYI5r3W0doDAHCciomr7KgSLymH49WNHeE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:812a592b-00f2-4fba-9ae0-933ea0ab0d71,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:e06d31e0-3890-4bb9-a90e-2a6a4ecf6c66,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d6c463e6badb11f08ac0a938fc7cd336-20251106
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 969101957; Thu, 06 Nov 2025 14:43:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 14:43:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 14:43:00 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>,
	Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH mt76 v2 04/12] wifi: mt76: mt7996: support fixed rate for link station
Date: Thu, 6 Nov 2025 14:41:55 +0800
Message-ID: <20251106064203.1000505-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251106064203.1000505-1-shayne.chen@mediatek.com>
References: <20251106064203.1000505-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Introduce mt7996_link_sta_add_debugfs() to extend fixed rate support for
MLO link station.

Co-developed-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 72 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  1 +
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  3 +
 3 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index a000275b369b..76d623b2cafb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -953,16 +953,34 @@ bool mt7996_debugfs_rx_log(struct mt7996_dev *dev, const void *data, int len)
 #ifdef CONFIG_MAC80211_DEBUGFS
 /** per-station debugfs **/
 
-static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static int
+mt7996_queues_show(struct seq_file *s, void *data)
+{
+	struct ieee80211_sta *sta = s->private;
+
+	mt7996_sta_hw_queue_read(s, sta);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7996_queues);
+
+void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, struct dentry *dir)
+{
+	debugfs_create_file("hw-queues", 0400, dir, sta, &mt7996_queues_fops);
+}
+
+static ssize_t mt7996_link_sta_fixed_rate_set(struct file *file,
+					      const char __user *user_buf,
+					      size_t count, loff_t *ppos)
 {
 #define SHORT_PREAMBLE 0
 #define LONG_PREAMBLE 1
-	struct ieee80211_sta *sta = file->private_data;
-	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct ieee80211_link_sta *link_sta = file->private_data;
+	struct mt7996_sta *msta = (struct mt7996_sta *)link_sta->sta->drv_priv;
 	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
+	struct mt7996_sta_link *msta_link;
 	struct ra_rate phy = {};
 	char buf[100];
 	int ret;
@@ -981,12 +999,13 @@ static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
 
 	/* mode - cck: 0, ofdm: 1, ht: 2, gf: 3, vht: 4, he_su: 8, he_er: 9 EHT: 15
 	 * bw - bw20: 0, bw40: 1, bw80: 2, bw160: 3, BW320: 4
-	 * nss - vht: 1~4, he: 1~4, eht: 1~4, others: ignore
 	 * mcs - cck: 0~4, ofdm: 0~7, ht: 0~32, vht: 0~9, he_su: 0~11, he_er: 0~2, eht: 0~13
+	 * nss - vht: 1~4, he: 1~4, eht: 1~4, others: ignore
 	 * gi - (ht/vht) lgi: 0, sgi: 1; (he) 0.8us: 0, 1.6us: 1, 3.2us: 2
 	 * preamble - short: 1, long: 0
-	 * ldpc - off: 0, on: 1
 	 * stbc - off: 0, on: 1
+	 * ldpc - off: 0, on: 1
+	 * spe - off: 0, on: 1
 	 * ltf - 1xltf: 0, 2xltf: 1, 4xltf: 2
 	 */
 	if (sscanf(buf, "%hhu %hhu %hhu %hhu %hu %hhu %hhu %hhu %hhu %hu",
@@ -994,9 +1013,16 @@ static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
 		   &phy.preamble, &phy.stbc, &phy.ldpc, &phy.spe, &ltf) != 10) {
 		dev_warn(dev->mt76.dev,
 			 "format: Mode BW MCS NSS GI Preamble STBC LDPC SPE ltf\n");
-		goto out;
+		return -EINVAL;
 	}
 
+	mutex_lock(&dev->mt76.mutex);
+
+	msta_link = mt76_dereference(msta->link[link_sta->link_id], &dev->mt76);
+	if (!msta_link) {
+		ret = -EINVAL;
+		goto out;
+	}
 	phy.wlan_idx = cpu_to_le16(msta_link->wcid.idx);
 	phy.gi = cpu_to_le16(gi);
 	phy.ltf = cpu_to_le16(ltf);
@@ -1005,36 +1031,26 @@ static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
 
 	ret = mt7996_mcu_set_fixed_rate_ctrl(dev, &phy, 0);
 	if (ret)
-		return -EFAULT;
+		goto out;
 
+	ret = count;
 out:
-	return count;
+	mutex_unlock(&dev->mt76.mutex);
+	return ret;
 }
 
 static const struct file_operations fops_fixed_rate = {
-	.write = mt7996_sta_fixed_rate_set,
+	.write = mt7996_link_sta_fixed_rate_set,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static int
-mt7996_queues_show(struct seq_file *s, void *data)
-{
-	struct ieee80211_sta *sta = s->private;
-
-	mt7996_sta_hw_queue_read(s, sta);
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(mt7996_queues);
-
-void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, struct dentry *dir)
+void mt7996_link_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+				 struct ieee80211_link_sta *link_sta,
+				 struct dentry *dir)
 {
-	debugfs_create_file("fixed_rate", 0600, dir, sta, &fops_fixed_rate);
-	debugfs_create_file("hw-queues", 0400, dir, sta, &mt7996_queues_fops);
+	debugfs_create_file("fixed_rate", 0600, dir, link_sta, &fops_fixed_rate);
 }
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 08c4d9c8791b..5e0b57657e7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -2283,6 +2283,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.twt_teardown_request = mt7996_twt_teardown_request,
 #ifdef CONFIG_MAC80211_DEBUGFS
 	.sta_add_debugfs = mt7996_sta_add_debugfs,
+	.link_sta_add_debugfs = mt7996_link_sta_add_debugfs,
 #endif
 	.set_radar_background = mt7996_set_radar_background,
 	.net_fill_forward_path = mt7996_net_fill_forward_path,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 891b187566b3..65eeb37ab8c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -863,6 +863,9 @@ int mt7996_mcu_cp_support(struct mt7996_dev *dev, u8 mode);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);
+void mt7996_link_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+				 struct ieee80211_link_sta *link_sta,
+				 struct dentry *dir);
 #endif
 int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 			 bool hif2, int *irq);
-- 
2.51.0


