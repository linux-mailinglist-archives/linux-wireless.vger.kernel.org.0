Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46FC58357C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 01:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiG0XBv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 19:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiG0XBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 19:01:44 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD120F56
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 16:01:42 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.75])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AE86C1C0063;
        Wed, 27 Jul 2022 23:01:40 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7983C80078;
        Wed, 27 Jul 2022 23:01:40 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 18AFD13C2B6;
        Wed, 27 Jul 2022 16:01:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 18AFD13C2B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1658962900;
        bh=at+iEdlDVxVAKQNcJKd7PyKXREmExs0VaGmwWj8gzHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddzgGHRGXCfFJaUlHhHerF0hnO1qda0XAYLMOUgnbP2JSWQpAOaB/Le8CcSfR0WWr
         lGUang3D5Pxf+Cz9gET5DpYdAJKUQMIKO0WpAW4dH+3Znoci4I6RbVY/vbKn0W2vgq
         k4E+Ep/PNinZqoYVmjMMpAFo23+HkCNMDpbe2NA8=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 06/12] wifi: mt76: mt7915: add support for tx-overrides
Date:   Wed, 27 Jul 2022 16:01:16 -0700
Message-Id: <20220727230122.29842-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220727230122.29842-1-greearb@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1658962901-GJCSCuM-P_Gw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Allow setting fixied rate on transmit without using full testmode
logic.

The goal of tx-overrides is to allow receiver sensitivity and other
types of testing.  Assumption is that the packets we care about
are larger data frames, so exclude smaller packets and non
data packets.

Setting transmit count to '0' means transmit once, but flag
the packet as no-ack.

Allows adjusting the tx power from default value, from -8 to +8
dbm.  Adjusting above 0 is probably not a good idea.

The station wtbl logic to read rate-ctrl settings does not work when
fixed rates are used.  So, read sgi settings from the txo configuration
in this case.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   4 +
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 225 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 149 +++++++++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 +
 4 files changed, 350 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 62a5e2ad6764..682b554fbcb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -611,6 +611,7 @@ struct mt76_testmode_ops {
 
 struct mt76_testmode_data {
 	enum mt76_testmode_state state;
+	u8 txo_active; /* tx overrides are active */
 
 	u32 param_set[DIV_ROUND_UP(NUM_MT76_TM_ATTRS, 32)];
 	struct sk_buff *tx_skb;
@@ -625,6 +626,9 @@ struct mt76_testmode_data {
 	u8 tx_rate_ldpc;
 	u8 tx_rate_stbc;
 	u8 tx_ltf;
+	u8 txbw; /* specify TX bandwidth: 0 20Mhz, 1 40Mhz, 2 80Mhz, 3 160Mhz */
+	u8 tx_xmit_count; /* 0 means no-ack, 1 means one transmit, etc */
+	u8 tx_dynbw; /* 0:  dynamic bw disabled, 1: dynamic bw enabled */
 
 	u8 tx_antenna_mask;
 	u8 tx_spe_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index f71d80cd4002..6ff1ce6e4cfc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -633,6 +633,229 @@ mt7915_fw_util_wa_show(struct seq_file *file, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(mt7915_fw_util_wa);
 
+struct mt7915_txo_worker_info {
+	char *buf;
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
+	struct ieee80211_hw *hw = dev->mphy.hw;
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
+		"tpc: adjust power from defaults, in 1/2 db units 0 - 31, 16 is default\n"
+		"bw is 0-3 for 20-160\n"
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
@@ -1057,6 +1280,8 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 		debugfs_create_devm_seqfile(dev->mt76.dev, "rdd_monitor", dir,
 					    mt7915_rdd_monitor);
 	}
+	debugfs_create_file("set_rate_override", 0600, dir,
+			    dev, &fops_set_rate_override);
 
 	if (!ext_phy)
 		dev->debugfs_dir = dir;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 800028a713a0..17bc64960f04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -177,6 +177,15 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 						       rx_cur);
 		}
 
+		/* If we are in tx-override mode, then wtbl doesn't provide useful report
+		 * for the SGI/LGI stuff, so just get it from the override struct.
+		 */
+		if (msta->test.txo_active) {
+			msta->wcid.rate_he_gi = msta->test.tx_rate_sgi;
+			msta->wcid.rate_short_gi = msta->test.tx_rate_sgi;
+			continue;
+		}
+
 		/*
 		 * We don't support reading GI info from txs packets.
 		 * For accurate tx status reporting and AQL improvement,
@@ -906,21 +915,32 @@ mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
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
+	int xmit_count = 1;
 
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
@@ -961,20 +981,24 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
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
@@ -988,10 +1012,24 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 
 	txwi[2] |= cpu_to_le32(MT_TXD2_FIX_RATE);
 
-	le32p_replace_bits(&txwi[3], 1, MT_TXD3_REM_TX_COUNT);
+	if (msta->test.txo_active) {
+		s8 txp = td->tx_power[0] - 16;
+
+		/* Support per-skb txpower, p.15 of tx doc, DW2 29:24. */
+		le32p_replace_bits(&txwi[2], txp, MT_TXD2_POWER_OFFSET);
+
+		xmit_count = td->tx_xmit_count;
+		if (xmit_count == 0) {
+			xmit_count = 1;
+			txwi[3] |= cpu_to_le32(MT_TXD3_NO_ACK);
+		}
+	}
+
+	le32p_replace_bits(&txwi[3], xmit_count, MT_TXD3_REM_TX_COUNT);
 	if (td->tx_rate_mode < MT76_TM_TX_MODE_HT)
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 
+	/* TODO:  Take tx_dynbw into account in txo mode. */
 	val = MT_TXD6_FIXED_BW |
 	      FIELD_PREP(MT_TXD6_BW, bw) |
 	      FIELD_PREP(MT_TXD6_TX_RATE, rateval) |
@@ -1015,9 +1053,29 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 
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
@@ -1282,8 +1340,29 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
 
-	if (mt76_testmode_enabled(mphy))
-		mt7915_mac_write_txwi_tm(mphy->priv, txwi, skb);
+#ifdef CONFIG_NL80211_TESTMODE
+	{
+		struct mt7915_sta *msta;
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		__le16 fc;
+
+		if (!is_8023)
+			fc = hdr->frame_control;
+
+		msta = container_of(wcid, struct mt7915_sta, wcid);
+		if (mt76_testmode_enabled(mphy) ||
+		    (msta->test.txo_active &&
+		     /* Only do txo overrides for (larger) data frames, this
+		      * generally allows connection mgt frames to pass but still
+		      * lets us force the data packets we care about.
+		      */
+		     skb->len >= 400 &&
+		     (is_8023 ||
+		      ((ieee80211_is_data_qos(fc) || ieee80211_is_data(fc)) &&
+		       (!(ieee80211_is_qos_nullfunc(fc) || ieee80211_is_nullfunc(fc)))))))
+			mt7915_mac_write_txwi_tm(mphy->priv, wcid, txwi, skb);
+	}
+#endif
 }
 
 int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
@@ -1699,7 +1778,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 	struct ieee80211_supported_band *sband;
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_phy *mphy;
-	struct ieee80211_tx_info *info;
+	struct ieee80211_tx_info *info = NULL;
 	struct sk_buff_head list;
 	struct rate_info rate = {};
 	struct sk_buff *skb = NULL;
@@ -1724,8 +1803,6 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		info->status.ampdu_len = 1;
 		info->status.ampdu_ack_len = !!(info->flags &
 						IEEE80211_TX_STAT_ACK);
-
-		info->status.rates[0].idx = -1;
 	}
 
 	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
@@ -1757,6 +1834,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
 		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		if (info)
+			info->status.rates[0].idx = rate.mcs;
 		break;
 	case MT_PHY_TYPE_HT:
 	case MT_PHY_TYPE_HT_GF:
@@ -1766,6 +1845,10 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		rate.flags = RATE_INFO_FLAGS_MCS;
 		if (wcid->rate_short_gi)
 			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		if (info) {
+			info->status.rates[0].idx = rate.mcs + rate.nss * 8;
+			info->status.rates[0].flags |= IEEE80211_TX_RC_MCS;
+		}
 		break;
 	case MT_PHY_TYPE_VHT:
 		if (rate.mcs > 9)
@@ -1774,6 +1857,10 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
 		if (wcid->rate_short_gi)
 			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		if (info) {
+			info->status.rates[0].idx = (rate.nss << 4) | rate.mcs;
+			info->status.rates[0].flags |= IEEE80211_TX_RC_VHT_MCS;
+		}
 		break;
 	case MT_PHY_TYPE_HE_SU:
 	case MT_PHY_TYPE_HE_EXT_SU:
@@ -1785,6 +1872,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		rate.he_gi = wcid->rate_he_gi;
 		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
 		rate.flags = RATE_INFO_FLAGS_HE_MCS;
+		if (info)
+			info->status.rates[0].idx = (rate.nss << 4) | rate.mcs;
 		break;
 	default:
 		WARN_ON_ONCE(true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index fa755bfa223f..e5008190472f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -132,6 +132,8 @@ struct mt7915_sta {
 
 	struct mt76_connac_sta_key_conf bip;
 
+	struct mt76_testmode_data test;
+
 	struct {
 		u8 flowid_mask;
 		struct mt7915_twt_flow flow[MT7915_MAX_STA_TWT_AGRT];
-- 
2.20.1

