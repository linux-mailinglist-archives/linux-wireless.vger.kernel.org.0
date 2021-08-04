Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694053E023F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbhHDNpb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 09:45:31 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:48214 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238053AbhHDNp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 09:45:28 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.129])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BB09B2006C
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 13:45:14 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9187E500094
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 13:45:14 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id F226E13C2BB;
        Wed,  4 Aug 2021 06:45:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F226E13C2BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628084714;
        bh=FO6TtWMsahWql42kfjUGCZu8DuVUo7SoIarisvke7Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khIS/uYQGDSQMLMuGyUa4qH0imxZSrDG9ma4zF5T0TndrtB9u2GrHGO7MrSo8orHT
         jlJPz2Y3C/muo0Cd057M8WcHSh82twiyOPJwO05doqgPic4mO2azyuBwBmPHSyGlxr
         LneAkmkOyuerGOZKddT/9ZfYZ4UAHETIVcYQ8Eno=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v5 07/11] mt76: mt7915:  add support for tx-overrides
Date:   Wed,  4 Aug 2021 06:45:01 -0700
Message-Id: <20210804134505.3208-7-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804134505.3208-1-greearb@candelatech.com>
References: <20210804134505.3208-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628084715-U1YhxdiVVZJA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Allow setting fix rate on transmit without using full testmode
logic.

txpower, dynbw, retry count is not currently supported.
And, probably later need additional logic to not apply this
txo to non-data frames and to smaller frames, to allow
ARP and such to go through while also forcing test data frames
to arbitrary tx-rates (rates which very well may not be
received by peer.)

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   4 +
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 224 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  98 ++++++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 +
 4 files changed, 302 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0cbb4940f590..52f5adaee2c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -566,6 +566,7 @@ struct mt76_testmode_ops {
 
 struct mt76_testmode_data {
 	enum mt76_testmode_state state;
+	u8 txo_active; /* tx overrides are active */
 
 	u32 param_set[DIV_ROUND_UP(NUM_MT76_TM_ATTRS, 32)];
 	struct sk_buff *tx_skb;
@@ -580,6 +581,9 @@ struct mt76_testmode_data {
 	u8 tx_rate_ldpc;
 	u8 tx_rate_stbc;
 	u8 tx_ltf;
+	u8 txbw; /* specify TX bandwidth: 0 20Mhz, 1 40Mhz, 2 80Mhz, 3 160Mhz */
+	u8 tx_xmit_count; /* 0 means no-ack, 1 means one transmit, etc */
+	u8 tx_dynbw; /* 0:  dynamic bw disabled, 1: dynamic bw enabled */
 
 	u8 tx_antenna_mask;
 	u8 tx_spe_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 6be194f16548..f2ff0d3f52cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -109,6 +109,228 @@ mt7915_fw_debug_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug, mt7915_fw_debug_get,
 			 mt7915_fw_debug_set, "%lld\n");
 
+struct mt7915_txo_worker_info {
+	char* buf;
+	int sofar;
+	int size;
+};
+
+static void mt7915_txo_worker(void *wi_data, struct ieee80211_sta *sta)
+{
+	struct mt7915_txo_worker_info *wi = wi_data;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt76_testmode_data *td = &msta->test;
+	struct ieee80211_vif *vif;
+	struct wireless_dev *wdev;
+
+	if (wi->sofar >= wi->size)
+		return; /* buffer is full */
+
+	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+	wdev = ieee80211_vif_to_wdev(vif);
+
+	wi->sofar += scnprintf(wi->buf + wi->sofar, wi->size - wi->sofar,
+			       "vdev (%s) active=%d tpc=%d sgi=%d mcs=%d nss=%d"
+			       " pream=%d retries=%d dynbw=%d bw=%d\n",
+			       wdev->netdev->name,
+			       td->txo_active, td->tx_power[0],
+			       td->tx_rate_sgi, td->tx_rate_idx,
+			       td->tx_rate_nss, td->tx_rate_mode,
+			       td->tx_xmit_count, td->tx_dynbw,
+			       td->txbw);
+}
+
+static ssize_t mt7915_read_set_rate_override(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	struct mt7915_dev *dev = file->private_data;
+        struct ieee80211_hw *hw = dev->mphy.hw;
+	char *buf2;
+	int size = 8000;
+	int rv, sofar;
+	struct mt7915_txo_worker_info wi;
+	const char buf[] =
+		"This allows specify specif tx rate parameters for all DATA"
+		" frames on a vdev\n"
+		"To set a value, you specify the dev-name and key-value pairs:\n"
+		"tpc=10 sgi=1 mcs=x nss=x pream=x retries=x dynbw=0|1 bw=x enable=0|1\n"
+		"pream: 0=cck, 1=ofdm, 2=HT, 3=VHT, 4=HE_SU\n"
+		"cck-mcs: 0=1Mbps, 1=2Mbps, 3=5.5Mbps, 3=11Mbps\n"
+		"ofdm-mcs: 0=6Mbps, 1=9Mbps, 2=12Mbps, 3=18Mbps, 4=24Mbps, 5=36Mbps,"
+		" 6=48Mbps, 7=54Mbps\n"
+		"tpc is not implemented currently, bw is 0-3 for 20-160\n"
+		" For example, wlan0:\n"
+		"echo \"wlan0 tpc=255 sgi=1 mcs=0 nss=1 pream=3 retries=1 dynbw=0 bw=0"
+		" active=1\" > ...mt76/set_rate_override\n";
+
+	buf2 = kzalloc(size, GFP_KERNEL);
+	if (!buf2)
+		return -ENOMEM;
+	strcpy(buf2, buf);
+	sofar = strlen(buf2);
+
+	wi.sofar = sofar;
+	wi.buf = buf2;
+	wi.size = size;
+
+	ieee80211_iterate_stations_atomic(hw, mt7915_txo_worker, &wi);
+
+	rv = simple_read_from_buffer(user_buf, count, ppos, buf2, wi.sofar);
+	kfree(buf2);
+	return rv;
+}
+
+/* Set the rates for specific types of traffic.
+ */
+static ssize_t mt7915_write_set_rate_override(struct file *file,
+					      const char __user *user_buf,
+					      size_t count, loff_t *ppos)
+{
+	struct mt7915_dev *dev = file->private_data;
+	struct mt7915_sta *msta;
+	struct ieee80211_vif *vif;
+	struct mt76_testmode_data *td = NULL;
+	struct wireless_dev *wdev;
+	struct mt76_wcid *wcid;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	char buf[180];
+	char tmp[20];
+	char *tok;
+	int ret, i, j;
+	unsigned int vdev_id = 0xFFFF;
+	char *bufptr = buf;
+	long rc;
+	char dev_name_match[IFNAMSIZ + 2];
+
+	memset(buf, 0, sizeof(buf));
+
+	simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+
+	/* make sure that buf is null terminated */
+	buf[sizeof(buf) - 1] = 0;
+
+	/* drop the possible '\n' from the end */
+	if (buf[count - 1] == '\n')
+		buf[count - 1] = 0;
+
+	mutex_lock(&mphy->dev->mutex);
+
+	/* Ignore empty lines, 'echo' appends them sometimes at least. */
+	if (buf[0] == 0) {
+		ret = count;
+		goto exit;
+	}
+
+	/* String starts with vdev name, ie 'wlan0'  Find the proper vif that
+	 * matches the name.
+	 */
+	for (i = 0; i < ARRAY_SIZE(dev->mt76.wcid_mask); i++) {
+		u32 mask = dev->mt76.wcid_mask[i];
+		u32 phy_mask = dev->mt76.wcid_phy_mask[i];
+
+		if (!mask)
+			continue;
+
+		for (j = i * 32; mask; j++, mask >>= 1, phy_mask >>= 1) {
+			if (!(mask & 1))
+				continue;
+
+			wcid = rcu_dereference(dev->mt76.wcid[j]);
+			if (!wcid)
+				continue;
+
+			msta = container_of(wcid, struct mt7915_sta, wcid);
+
+			vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+
+			wdev = ieee80211_vif_to_wdev(vif);
+
+			if (!wdev)
+				continue;
+
+			snprintf(dev_name_match, sizeof(dev_name_match) - 1, "%s ",
+				 wdev->netdev->name);
+
+			if (strncmp(dev_name_match, buf, strlen(dev_name_match)) == 0) {
+				vdev_id = j;
+				td = &msta->test;
+				bufptr = buf + strlen(dev_name_match) - 1;
+				break;
+			}
+		}
+	}
+
+	if (vdev_id == 0xFFFF) {
+		if (strstr(buf, "active=0")) {
+			/* Ignore, we are disabling it anyway */
+			ret = count;
+			goto exit;
+		} else {
+			dev_info(dev->mt76.dev,
+				 "mt7915: set-rate-override, unknown netdev name: %s\n", buf);
+		}
+		ret = -EINVAL;
+		goto exit;
+	}
+
+#define MT7915_PARSE_LTOK(a, b)					\
+	do {								\
+		tok = strstr(bufptr, " " #a "=");			\
+		if (tok) {						\
+			char *tspace;					\
+			tok += 1; /* move past initial space */		\
+			strncpy(tmp, tok + strlen(#a "="), sizeof(tmp) - 1); \
+			tmp[sizeof(tmp) - 1] = 0;			\
+			tspace = strstr(tmp, " ");			\
+			if (tspace)					\
+				*tspace = 0;				\
+			if (kstrtol(tmp, 0, &rc) != 0)			\
+				dev_info(dev->mt76.dev,			\
+					 "mt7915: set-rate-override: " #a \
+					 "= could not be parsed, tmp: %s\n", \
+					 tmp);				\
+			else						\
+				td->b = rc;				\
+		}							\
+	} while (0)
+
+	/* TODO:  Allow configuring LTF? */
+	td->tx_ltf = 1; /* 0: HTLTF 3.2us, 1: HELTF, 6.4us, 2 HELTF 12,8us */
+
+	MT7915_PARSE_LTOK(tpc, tx_power[0]);
+	MT7915_PARSE_LTOK(sgi, tx_rate_sgi);
+	MT7915_PARSE_LTOK(mcs, tx_rate_idx);
+	MT7915_PARSE_LTOK(nss, tx_rate_nss);
+	MT7915_PARSE_LTOK(pream, tx_rate_mode);
+	MT7915_PARSE_LTOK(retries, tx_xmit_count);
+	MT7915_PARSE_LTOK(dynbw, tx_dynbw);
+	MT7915_PARSE_LTOK(bw, txbw);
+	MT7915_PARSE_LTOK(active, txo_active);
+
+	dev_info(dev->mt76.dev,
+		 "mt7915: set-rate-overrides, vdev %i(%s) active=%d tpc=%d sgi=%d mcs=%d"
+		 " nss=%d pream=%d retries=%d dynbw=%d bw=%d\n",
+		 vdev_id, dev_name_match,
+		 td->txo_active, td->tx_power[0], td->tx_rate_sgi, td->tx_rate_idx,
+		 td->tx_rate_nss, td->tx_rate_mode, td->tx_xmit_count, td->tx_dynbw,
+		 td->txbw);
+
+	ret = count;
+
+exit:
+	mutex_unlock(&mphy->dev->mutex);
+	return ret;
+}
+
+static const struct file_operations fops_set_rate_override = {
+	.read = mt7915_read_set_rate_override,
+	.write = mt7915_write_set_rate_override,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 static int
 mt7915_txs_for_no_skb_set(void *data, u64 val)
 {
@@ -377,6 +599,8 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 	debugfs_create_file("ser_trigger", 0200, dir, dev, &fops_ser_trigger);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower_sku", dir,
 				    mt7915_read_rate_txpower);
+	debugfs_create_file("set_rate_override", 0600, dir,
+			    dev, &fops_set_rate_override);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index bdcd1aae10d1..01f4aa7a6e88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -757,21 +757,31 @@ mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 }
 
 static void
-mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
+mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, struct mt76_wcid *wcid, __le32 *txwi,
 			 struct sk_buff *skb)
 {
-#ifdef CONFIG_NL80211_TESTMODE
-	struct mt76_testmode_data *td = &phy->mt76->test;
+	struct mt76_testmode_data *td;
 	const struct ieee80211_rate *r;
-	u8 bw, mode, nss = td->tx_rate_nss;
-	u8 rate_idx = td->tx_rate_idx;
+	struct mt7915_sta *msta;
+	u8 bw, mode, nss;
+	u8 rate_idx;
 	u16 rateval = 0;
 	u32 val;
 	bool cck = false;
 	int band;
 
-	if (skb != phy->mt76->test.tx_skb)
-		return;
+	msta = container_of(wcid, struct mt7915_sta, wcid);
+
+	if (msta->test.txo_active) {
+		td = &msta->test;
+	} else {
+		if (skb != phy->mt76->test.tx_skb)
+			return;
+		td = &phy->mt76->test;
+	}
+
+	nss = td->tx_rate_nss;
+	rate_idx = td->tx_rate_idx;
 
 	switch (td->tx_rate_mode) {
 	case MT76_TM_TX_MODE_HT:
@@ -812,20 +822,24 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 		break;
 	}
 
-	switch (phy->mt76->chandef.width) {
-	case NL80211_CHAN_WIDTH_40:
-		bw = 1;
-		break;
-	case NL80211_CHAN_WIDTH_80:
-		bw = 2;
-		break;
-	case NL80211_CHAN_WIDTH_80P80:
-	case NL80211_CHAN_WIDTH_160:
-		bw = 3;
-		break;
-	default:
-		bw = 0;
-		break;
+	if (msta->test.txo_active) {
+		bw = td->txbw;
+	} else {
+		switch (phy->mt76->chandef.width) {
+		case NL80211_CHAN_WIDTH_40:
+			bw = 1;
+			break;
+		case NL80211_CHAN_WIDTH_80:
+			bw = 2;
+			break;
+		case NL80211_CHAN_WIDTH_80P80:
+		case NL80211_CHAN_WIDTH_160:
+			bw = 3;
+			break;
+		default:
+			bw = 0;
+			break;
+		}
 	}
 
 	if (td->tx_rate_stbc && nss == 1) {
@@ -837,12 +851,17 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 		   FIELD_PREP(MT_TX_RATE_MODE, mode) |
 		   FIELD_PREP(MT_TX_RATE_NSS, nss - 1);
 
+	/* TODO:  Support per-skb txpower, p.15 of txpower doc, DW2 29:24. */
 	txwi[2] |= cpu_to_le32(MT_TXD2_FIX_RATE);
 
+	/* Looks like this sets tx attempt to exactly 1.
+	 * TODO:  Use td->tx_xmit_count, if in txo mode.
+	 */
 	le32p_replace_bits(&txwi[3], 1, MT_TXD3_REM_TX_COUNT);
 	if (td->tx_rate_mode < MT76_TM_TX_MODE_HT)
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 
+	/* TODO:  Take tx_dynbw into account in txo mode. */
 	val = MT_TXD6_FIXED_BW |
 	      FIELD_PREP(MT_TXD6_BW, bw) |
 	      FIELD_PREP(MT_TXD6_TX_RATE, rateval) |
@@ -866,9 +885,29 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 
 	txwi[3] &= ~cpu_to_le32(MT_TXD3_SN_VALID);
 	txwi[6] |= cpu_to_le32(val);
-	txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX,
-					  phy->test.spe_idx));
-#endif
+
+	if (msta->test.txo_active) {
+		/* see mt7915_tm_set_tx_frames */
+		static const u8 spe_idx_map[] = {0, 0, 1, 0, 3, 2, 4, 0,
+						 9, 8, 6, 10, 16, 12, 18, 0};
+		u32 spe_idx;
+
+		if (td->tx_spe_idx) {
+			spe_idx = td->tx_spe_idx;
+		} else {
+			u8 tx_ant = td->tx_antenna_mask;
+
+			if (!tx_ant) {
+				/* use antenna mask that matches our nss */
+				tx_ant = GENMASK(nss - 1, 0);
+			}
+			spe_idx = spe_idx_map[tx_ant];
+		}
+		txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX, spe_idx));
+	} else {
+		txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX,
+						  phy->test.spe_idx));
+	}
 }
 
 static void
@@ -1078,8 +1117,15 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
 
-	if (mt76_testmode_enabled(mphy))
-		mt7915_mac_write_txwi_tm(mphy->priv, txwi, skb);
+#ifdef CONFIG_NL80211_TESTMODE
+	{
+		struct mt7915_sta *msta;
+
+		msta = container_of(wcid, struct mt7915_sta, wcid);
+		if (mt76_testmode_enabled(mphy) || msta->test.txo_active)
+			mt7915_mac_write_txwi_tm(mphy->priv, wcid, txwi, skb);
+	}
+#endif
 }
 
 int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 1c0a1bf91c1c..ebbb92fd6620 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -92,6 +92,8 @@ struct mt7915_sta {
 	struct mt7915_sta_stats stats;
 
 	struct mt7915_sta_key_conf bip;
+
+	struct mt76_testmode_data test;
 };
 
 struct mt7915_vif {
-- 
2.20.1

