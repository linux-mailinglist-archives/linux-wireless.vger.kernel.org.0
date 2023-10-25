Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E27D73D9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjJYTEK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjJYTEH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:04:07 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66110E
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:04:03 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2FA06800075
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:04:01 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 9984513C2B0;
        Wed, 25 Oct 2023 12:04:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9984513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260640;
        bh=gV6kfFFHlGZREnQdqHEFwxUn0fLlcc71p2t21/K9AUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5V8fj+5Wt7Q5bJPlgktBr/xlMvXPQc9C3YuNcfCKCKVCx/6Onpgn8PXe/GQpXbW/
         Vi6VZHHEyyVpi/mlzElkyDoxAIi+4jsraSRhq7RWsAi3TCE8HplZvYKLh9+1kdAMkJ
         ytPhqryvSBOjJY5EPIU8vvvNk3KhbwfCyMnhbzlk=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 06/12] wifi: mt76: mt7915: add support for tx-overrides
Date:   Wed, 25 Oct 2023 12:03:48 -0700
Message-Id: <20231025190351.2141832-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231025190351.2141832-1-greearb@candelatech.com>
References: <20231025190351.2141832-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260641-Ph_j44dyJs75
X-MDID-O: us5;at1;1698260641;Ph_j44dyJs75;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   2 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  16 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 225 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 136 ++++++++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 +
 6 files changed, 354 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a9f3f66b4e3d..7b141fbf3497 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -670,6 +670,7 @@ struct mt76_testmode_ops {
 
 struct mt76_testmode_data {
 	enum mt76_testmode_state state;
+	u8 txo_active; /* tx overrides are active */
 
 	u32 param_set[DIV_ROUND_UP(NUM_MT76_TM_ATTRS, 32)];
 	struct sk_buff *tx_skb;
@@ -684,6 +685,9 @@ struct mt76_testmode_data {
 	u8 tx_rate_ldpc;
 	u8 tx_rate_stbc;
 	u8 tx_ltf;
+	u8 txbw; /* specify TX bandwidth: 0 20Mhz, 1 40Mhz, 2 80Mhz, 3 160Mhz */
+	u8 tx_xmit_count; /* 0 means no-ack, 1 means one transmit, etc */
+	u8 tx_dynbw; /* 0:  dynamic bw disabled, 1: dynamic bw enabled */
 
 	u8 tx_antenna_mask;
 	u8 tx_spe_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 6d5cf5e92885..6c052e6703a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -413,7 +413,7 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 				 struct ieee80211_vif *vif,
 				 bool beacon, bool mcast);
 bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
-			       __le32 *txs_data);
+			       __le32 *txs_data, struct ieee80211_tx_info *info);
 bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 				  int pid, __le32 *txs_data);
 void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index c8619dab15be..ae52e10331c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -586,7 +586,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_write_txwi);
 
 bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
-			       __le32 *txs_data)
+			       __le32 *txs_data, struct ieee80211_tx_info *info)
 {
 	struct mt76_sta_stats *stats = &wcid->stats;
 	struct ieee80211_supported_band *sband;
@@ -653,6 +653,8 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 
 		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
 		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		if (info)
+			info->status.rates[0].idx = rate.mcs;
 		break;
 	case MT_PHY_TYPE_HT:
 	case MT_PHY_TYPE_HT_GF:
@@ -662,6 +664,10 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
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
@@ -670,6 +676,10 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
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
@@ -681,6 +691,8 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		rate.he_gi = wcid->rate_he_gi;
 		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
 		rate.flags = RATE_INFO_FLAGS_HE_MCS;
+		if (info)
+			info->status.rates[0].idx = (rate.nss << 4) | rate.mcs;
 		break;
 	default:
 		return false;
@@ -731,7 +743,7 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			!!(info->flags & IEEE80211_TX_STAT_ACK);
 		info->status.rates[0].idx = -1;
 
-		mt76_connac2_mac_fill_txs(dev, wcid, txs_data);
+		mt76_connac2_mac_fill_txs(dev, wcid, txs_data, info);
 		mt76_tx_status_skb_done(dev, skb, &list);
 	}
 	mt76_tx_status_unlock(dev, &list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 6c3696c8c700..f9309699f657 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -677,6 +677,229 @@ mt7915_fw_util_wa_show(struct seq_file *file, void *data)
 
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
 static void
 mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 			   struct seq_file *file)
@@ -1245,6 +1468,8 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 		debugfs_create_devm_seqfile(dev->mt76.dev, "rdd_monitor", dir,
 					    mt7915_rdd_monitor);
 	}
+	debugfs_create_file("set_rate_override", 0600, dir,
+			    dev, &fops_set_rate_override);
 
 	if (!ext_phy)
 		dev->debugfs_dir = dir;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index ad20d10201b4..5776d47afba9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -173,6 +173,15 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
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
@@ -610,21 +619,32 @@ mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
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
@@ -665,20 +685,24 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
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
@@ -692,10 +716,24 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 
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
@@ -719,9 +757,29 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 
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
 
 void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
@@ -738,8 +796,30 @@ void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 
 	mt76_connac2_mac_write_txwi(dev, txwi, skb, wcid, key, pid, qid, changed);
 
-	if (mt76_testmode_enabled(mphy))
-		mt7915_mac_write_txwi_tm(mphy->priv, txwi, skb);
+#ifdef CONFIG_NL80211_TESTMODE
+	{
+		struct mt7915_sta *msta;
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		__le16 fc;
+		bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
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
@@ -1029,7 +1109,7 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	msta = container_of(wcid, struct mt7915_sta, wcid);
 
 	if (pid == MT_PACKET_ID_WED)
-		mt76_connac2_mac_fill_txs(&dev->mt76, wcid, txs_data);
+		mt76_connac2_mac_fill_txs(&dev->mt76, wcid, txs_data, NULL);
 	else
 		mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index d317c523b23f..960435ad2c04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -146,6 +146,8 @@ struct mt7915_sta {
 	unsigned long jiffies;
 	struct mt76_connac_sta_key_conf bip;
 
+	struct mt76_testmode_data test;
+
 	struct {
 		u8 flowid_mask;
 		struct mt7915_twt_flow flow[MT7915_MAX_STA_TWT_AGRT];
-- 
2.40.0

