Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04245636A5F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 21:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbiKWUAO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 15:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbiKWT7z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 14:59:55 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010B77AF75
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 11:59:21 -0800 (PST)
X-UUID: 094f7dc56f5c4a89a2f47b4c881df1e4-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8MqiZGksT3UxUWNd4zRXhvcbQhKNqIPwNaE5Rb34cnk=;
        b=Pk76BrZQyaRyGYF0JmN1T0EQgyXFKoeBkD7icV4tZtyClX7c/BeL/KdNKP2RlzB6r2B7rsZaSGXb62e8fCpur1TZBxZVNtYvVR2TybItFAt1xEorlHlvsVQe7NT4VzgPFNIxTDbd+akFKV76uBQiWyfnJyqtd70Lipon9CJZ5UQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:247e57fa-f757-4337-8835-2a1a486a5146,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.12,REQID:247e57fa-f757-4337-8835-2a1a486a5146,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:62cd327,CLOUDID:1b4a1ff9-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:221124035916S8LDS8ZQ,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 094f7dc56f5c4a89a2f47b4c881df1e4-20221124
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1518888270; Thu, 24 Nov 2022 03:59:15 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 24 Nov 2022 03:59:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 24 Nov 2022 03:59:13 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] wifi: mt76: mt7915: enable per bandwidth power limit support
Date:   Thu, 24 Nov 2022 03:59:11 +0800
Message-ID: <0ad3220cfe7c61480379d571700e202832d4372c.1669232969.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <9a67f1617249be2c73bb5900d2df971b682f8772.1669232969.git.ryder.lee@mediatek.com>
References: <9a67f1617249be2c73bb5900d2df971b682f8772.1669232969.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This power should override the per bandwidth max power that the
device emits.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - add a missing lock
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 200 +++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   9 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   7 +
 3 files changed, 184 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index fef0ec83185b..5c15233b1595 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -957,48 +957,198 @@ mt7915_xmit_queues_show(struct seq_file *file, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(mt7915_xmit_queues);
 
-static int
-mt7915_rate_txpower_show(struct seq_file *file, void *data)
+#define mt7915_txpower_puts(prefix, rate)					\
+({										\
+	len += scnprintf(buf + len, sz - len, "%-16s:", #prefix " (tmac)");	\
+	for (i = 0; i < mt7915_sku_group_len[rate]; i++, offs++)		\
+		len += scnprintf(buf + len, sz - len, " %6d", txpwr[offs]);	\
+	len += scnprintf(buf + len, sz - len, "\n");				\
+})
+
+#define mt7915_txpower_sets(rate, pwr, flag)			\
+({								\
+	offs += len;						\
+	len = mt7915_sku_group_len[rate];			\
+	if (mode == flag) {					\
+		for (i = 0; i < len; i++)			\
+			req.txpower_sku[offs + i] = pwr;	\
+	}							\
+})
+
+static ssize_t
+mt7915_rate_txpower_get(struct file *file, char __user *user_buf,
+			size_t count, loff_t *ppos)
 {
-	static const char * const sku_group_name[] = {
-		"CCK", "OFDM", "HT20", "HT40",
-		"VHT20", "VHT40", "VHT80", "VHT160",
-		"RU26", "RU52", "RU106", "RU242/SU20",
-		"RU484/SU40", "RU996/SU80", "RU2x996/SU160"
-	};
-	struct mt7915_phy *phy = file->private;
+	struct mt7915_phy *phy = file->private_data;
 	struct mt7915_dev *dev = phy->dev;
-	s8 txpower[MT7915_SKU_RATE_NUM], *buf;
+	static const size_t sz = 2048;
+	int i, offs = 0, len = 0;
+	ssize_t ret;
+	char *buf;
+	s8 txpwr[MT7915_SKU_RATE_NUM];
 	u32 reg;
-	int i, ret;
 
-	ret = mt7915_mcu_get_txpower_sku(phy, txpower, sizeof(txpower));
+	buf = kzalloc(sz, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = mt7915_mcu_get_txpower_sku(phy, txpwr, sizeof(txpwr));
 	if (ret)
 		return ret;
 
 	/* Txpower propagation path: TMAC -> TXV -> BBP */
-	seq_printf(file, "\nPhy %d\n", phy != &dev->phy);
+	len += scnprintf(buf + len, sz - len,
+			 "\nPhy%d Tx power table (channel %d)\n",
+			 phy != &dev->phy, phy->mt76->chandef.chan->hw_value);
+	len += scnprintf(buf + len, sz - len, "%-16s  %6s %6s %6s %6s\n",
+			 " ", "1m", "2m", "5m", "11m");
+	mt7915_txpower_puts(CCK, SKU_CCK);
+
+	len += scnprintf(buf + len, sz - len,
+			 "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s\n",
+			 " ", "6m", "9m", "12m", "18m", "24m", "36m", "48m",
+			 "54m");
+	mt7915_txpower_puts(OFDM, SKU_OFDM);
+
+	len += scnprintf(buf + len, sz - len,
+			 "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s\n",
+			 " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4",
+			 "mcs5", "mcs6", "mcs7");
+	mt7915_txpower_puts(HT20, SKU_HT_BW20);
+
+	len += scnprintf(buf + len, sz - len,
+			 "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
+			 " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+			 "mcs6", "mcs7", "mcs32");
+	mt7915_txpower_puts(HT40, SKU_HT_BW40);
+
+	len += scnprintf(buf + len, sz - len,
+			 "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
+			 " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+			 "mcs6", "mcs7", "mcs8", "mcs9", "mcs10", "mcs11");
+	mt7915_txpower_puts(VHT20, SKU_VHT_BW20);
+	mt7915_txpower_puts(VHT40, SKU_VHT_BW40);
+	mt7915_txpower_puts(VHT80, SKU_VHT_BW80);
+	mt7915_txpower_puts(VHT160, SKU_VHT_BW160);
+	mt7915_txpower_puts(HE26, SKU_HE_RU26);
+	mt7915_txpower_puts(HE52, SKU_HE_RU52);
+	mt7915_txpower_puts(HE106, SKU_HE_RU106);
+	mt7915_txpower_puts(HE242, SKU_HE_RU242);
+	mt7915_txpower_puts(HE484, SKU_HE_RU484);
+	mt7915_txpower_puts(HE996, SKU_HE_RU996);
+	mt7915_txpower_puts(HE996x2, SKU_HE_RU2x996);
 
-	for (i = 0, buf = txpower; i < ARRAY_SIZE(mt7915_sku_group_len); i++) {
-		u8 mcs_num = mt7915_sku_group_len[i];
+	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_TPC_CTRL_STAT(phy->band_idx) :
+	      MT_WF_PHY_TPC_CTRL_STAT_MT7916(phy->band_idx);
 
-		if (i >= SKU_VHT_BW20 && i <= SKU_VHT_BW160)
-			mcs_num = 10;
+	len += scnprintf(buf + len, sz - len, "\nTx power (bbp)  : %6ld\n",
+			 mt76_get_field(dev, reg, MT_WF_PHY_TPC_POWER));
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
+			size_t count, loff_t *ppos)
+{
+	struct mt7915_phy *phy = file->private_data;
+	struct mt7915_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
+	struct mt7915_mcu_txpower_sku req = {
+		.format_id = TX_POWER_LIMIT_TABLE,
+		.band_idx = phy->band_idx,
+	};
+	char buf[100];
+	int i, ret, pwr160 = 0, pwr80 = 0, pwr40 = 0, pwr20 = 0;
+	enum mac80211_rx_encoding mode;
+	u32 offs = 0, len = 0;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
 
-		mt76_seq_puts_array(file, sku_group_name[i], buf, mcs_num);
-		buf += mt7915_sku_group_len[i];
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
+
+	if (sscanf(buf, "%u %u %u %u %u",
+		   &mode, &pwr160, &pwr80, &pwr40, &pwr20) != 5) {
+		dev_warn(dev->mt76.dev,
+			 "per bandwidth power limit: Mode BW160 BW80 BW40 BW20");
+		return -EINVAL;
 	}
 
-	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_TPC_CTRL_STAT(phy->band_idx) :
-	      MT_WF_PHY_TPC_CTRL_STAT_MT7916(phy->band_idx);
+	if (mode > RX_ENC_HE)
+		return -EINVAL;
 
-	seq_printf(file, "\nBaseband transmit power %ld\n",
-		   mt76_get_field(dev, reg, MT_WF_PHY_TPC_POWER));
+	if (pwr160)
+		pwr160 = mt7915_get_power_bound(phy, pwr160);
+	if (pwr80)
+		pwr80 = mt7915_get_power_bound(phy, pwr80);
+	if (pwr40)
+		pwr40 = mt7915_get_power_bound(phy, pwr40);
+	if (pwr20)
+		pwr20 = mt7915_get_power_bound(phy, pwr20);
 
-	return 0;
+	if (pwr160 < 0 || pwr80 < 0 || pwr40 < 0 || pwr20 < 0)
+		return -EINVAL;
+
+	mutex_lock(&dev->mt76.mutex);
+	ret = mt7915_mcu_get_txpower_sku(phy, req.txpower_sku,
+					 sizeof(req.txpower_sku));
+	if (ret)
+		goto out;
+
+	mt7915_txpower_sets(SKU_CCK, pwr20, RX_ENC_LEGACY);
+	mt7915_txpower_sets(SKU_OFDM, pwr20, RX_ENC_LEGACY);
+	if (mode == RX_ENC_LEGACY)
+		goto skip;
+
+	mt7915_txpower_sets(SKU_HT_BW20, pwr20, RX_ENC_HT);
+	mt7915_txpower_sets(SKU_HT_BW40, pwr40, RX_ENC_HT);
+	if (mode == RX_ENC_HT)
+		goto skip;
+
+	mt7915_txpower_sets(SKU_VHT_BW20, pwr20, RX_ENC_VHT);
+	mt7915_txpower_sets(SKU_VHT_BW40, pwr40, RX_ENC_VHT);
+	mt7915_txpower_sets(SKU_VHT_BW80, pwr80, RX_ENC_VHT);
+	mt7915_txpower_sets(SKU_VHT_BW160, pwr160, RX_ENC_VHT);
+	if (mode == RX_ENC_VHT)
+		goto skip;
+
+	mt7915_txpower_sets(SKU_HE_RU26, pwr20, RX_ENC_HE + 1);
+	mt7915_txpower_sets(SKU_HE_RU52, pwr20, RX_ENC_HE + 1);
+	mt7915_txpower_sets(SKU_HE_RU106, pwr20, RX_ENC_HE + 1);
+	mt7915_txpower_sets(SKU_HE_RU242, pwr20, RX_ENC_HE);
+	mt7915_txpower_sets(SKU_HE_RU484, pwr40, RX_ENC_HE);
+	mt7915_txpower_sets(SKU_HE_RU996, pwr80, RX_ENC_HE);
+	mt7915_txpower_sets(SKU_HE_RU2x996, pwr160, RX_ENC_HE);
+skip:
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(TX_POWER_FEATURE_CTRL),
+				&req, sizeof(req), true);
+	if (ret)
+		goto out;
+
+	mphy->txpower_cur = max(mphy->txpower_cur,
+				max(pwr160, max(pwr80, max(pwr40, pwr20))));
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret ? ret : count;
 }
 
-DEFINE_SHOW_ATTRIBUTE(mt7915_rate_txpower);
+static const struct file_operations mt7915_rate_txpower_fops = {
+	.write = mt7915_rate_txpower_set,
+	.read = mt7915_rate_txpower_get,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
 
 static int
 mt7915_twt_stats(struct seq_file *s, void *data)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 8a2546699c3b..d8389bc8ee82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3170,12 +3170,7 @@ int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 	struct mt7915_dev *dev = phy->dev;
 	struct mt76_phy *mphy = phy->mt76;
 	struct ieee80211_hw *hw = mphy->hw;
-	struct mt7915_sku_val {
-		u8 format_id;
-		u8 limit_type;
-		u8 band_idx;
-		s8 val[MT7915_SKU_RATE_NUM];
-	} __packed req = {
+	struct mt7915_mcu_txpower_sku req = {
 		.format_id = TX_POWER_LIMIT_TABLE,
 		.band_idx = phy->band_idx,
 	};
@@ -3203,7 +3198,7 @@ int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 		}
 
 		for (j = 0; j < min_t(u8, mcs_num, len); j++)
-			req.val[idx + j] = la[j];
+			req.txpower_sku[idx + j] = la[j];
 
 		la += mcs_num;
 		idx += len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 382dcbda50bb..29b5434bfdb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -184,6 +184,13 @@ enum mt7915_chan_mib_offs {
 	MIB_NON_WIFI_TIME_V2
 };
 
+struct mt7915_mcu_txpower_sku {
+	u8 format_id;
+	u8 limit_type;
+	u8 band_idx;
+	s8 txpower_sku[MT7915_SKU_RATE_NUM];
+} __packed;
+
 struct edca {
 	u8 queue;
 	u8 set;
-- 
2.36.1

