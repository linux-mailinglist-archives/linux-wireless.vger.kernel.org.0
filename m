Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193397D73EA
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjJYTJa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJYTJ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:09:29 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEBABB
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:09:27 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DFDBEB80088
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:09:25 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 1BDDC13C2B0;
        Wed, 25 Oct 2023 12:09:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1BDDC13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260964;
        bh=DzdAPHT3x0P/bSHwr4+1t49l8Dl/GL7r+O7j72RudHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1qR7sN9YrUJ7RzcAHa0dc/OH/Lh/prxWtwveZ1epZTz8WyvvpvFG4+D6A3GxO5Bg
         EzqWwp9Rem/x23nfD6ZuZhSatbC/vmmLknFSbYh7oZqTBSmPa1WZUal1NfBwGjR530
         cLFDNJHXXy5LoHxG/i71oYybWldEmzj9iiRAnIGM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 11/12] wifi: mt76: mt7915: add ethtool tx/rx pkts/bytes
Date:   Wed, 25 Oct 2023 12:09:19 -0700
Message-Id: <20231025190920.2142693-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231025190920.2142693-1-greearb@candelatech.com>
References: <20231025190920.2142693-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260966-FwgDfzC-zSKs
X-MDID-O: us5;ut7;1698260966;FwgDfzC-zSKs;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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

These stats are provided with same name by ath10k
and some intel wired NIC drivers.  Add them to mt7915
as well to allow user-space code to more easily get some
basic stats out of the radio.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            |  6 ++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |  9 ++++++---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 12 ++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/main.c     | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |  4 +++-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  |  2 +-
 9 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 299d6f1f9649..9b5c1ee7951d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -901,6 +901,12 @@ struct mt76_dev {
 
 /* per-phy stats.  */
 struct mt76_mib_stats {
+	/* phy wide driver stats */
+	unsigned long tx_pkts_nic; /* tx OK skb */
+	unsigned long tx_bytes_nic; /* tx OK bytes */
+	unsigned long rx_pkts_nic; /* rx OK skb */
+	unsigned long rx_bytes_nic; /* rx OK bytes */
+
 	u32 ack_fail_cnt;
 	u32 fcs_err_cnt;
 	u32 rts_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 631d349ace82..ff890c800cf3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -431,8 +431,9 @@ void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
 void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 			    struct ieee80211_sta *sta,
 			    struct list_head *free_list,
-			    u32 tx_cnt, u32 tx_status, u32 ampdu);
-void mt76_connac2_tx_token_put(struct mt76_dev *dev);
+			    u32 tx_cnt, u32 tx_status, u32 ampdu,
+			    struct mt76_mib_stats *mib);
+void mt76_connac2_tx_token_put(struct mt76_dev *dev, struct mt76_mib_stats *mib);
 
 /* connac3 */
 void mt76_connac3_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index c56881bc2ab3..466be4964473 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1188,7 +1188,8 @@ EXPORT_SYMBOL_GPL(mt76_connac2_tx_check_aggr);
 void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 			    struct ieee80211_sta *sta,
 			    struct list_head *free_list,
-			    u32 tx_cnt, u32 tx_status, u32 ampdu)
+			    u32 tx_cnt, u32 tx_status, u32 ampdu,
+			    struct mt76_mib_stats *mib)
 {
 	struct mt76_wcid *wcid;
 	__le32 *txwi;
@@ -1279,6 +1280,8 @@ void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 	/* Apply the values that this txfree path reports */
 	rate->count = tx_cnt;
 	if (tx_status == 0) {
+		mib->tx_pkts_nic++;
+		mib->tx_bytes_nic += t->skb->len;
 		info->flags |= IEEE80211_TX_STAT_ACK;
 		info->status.ampdu_ack_len = 1;
 	} else {
@@ -1292,14 +1295,14 @@ void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_txwi_free);
 
-void mt76_connac2_tx_token_put(struct mt76_dev *dev)
+void mt76_connac2_tx_token_put(struct mt76_dev *dev, struct mt76_mib_stats* mib)
 {
 	struct mt76_txwi_cache *txwi;
 	int id;
 
 	spin_lock_bh(&dev->token_lock);
 	idr_for_each_entry(&dev->token, txwi, id) {
-		mt76_connac2_txwi_free(dev, txwi, NULL, NULL, 1, 0, 1);
+		mt76_connac2_txwi_free(dev, txwi, NULL, NULL, 1, 0, 1, mib);
 		dev->token_count--;
 	}
 	spin_unlock_bh(&dev->token_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index a442d1e8b04e..0e9b02246ef9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1175,7 +1175,7 @@ static void mt7915_unregister_ext_phy(struct mt7915_dev *dev)
 static void mt7915_stop_hardware(struct mt7915_dev *dev)
 {
 	mt7915_mcu_exit(dev);
-	mt76_connac2_tx_token_put(&dev->mt76);
+	mt76_connac2_tx_token_put(&dev->mt76, &dev->phy.mib);
 	mt7915_dma_cleanup(dev);
 	tasklet_disable(&dev->mt76.irq_tasklet);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 05f1b1fa4080..f6d8e08d7083 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -591,6 +591,9 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
 		mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv, mode);
 
+	mib->rx_pkts_nic++;
+	mib->rx_bytes_nic += skb->len;
+
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
 
@@ -1073,7 +1076,8 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			if (!txwi)
 				continue;
 
-			mt76_connac2_txwi_free(mdev, txwi, sta, &free_list, tx_cnt, tx_status, ampdu);
+			mt76_connac2_txwi_free(mdev, txwi, sta, &free_list, tx_cnt, tx_status,
+					       ampdu, &dev->phy.mib);
 			/* don't count retries twice, in case we are v3 */
 			tx_cnt = 1;
 		}
@@ -1110,7 +1114,7 @@ mt7915_mac_tx_free_v0(struct mt7915_dev *dev, void *data, int len)
 		/* TODO: Can we report tx_cnt, status, ampdu in this path? */
 		mt76_connac2_txwi_free(mdev, txwi, NULL, &free_list,
 				       1 /* tx_cnt */, 0 /* tx-status-ok */,
-				       1/* ampdu */);
+				       1/* ampdu */, &dev->phy.mib);
 	}
 
 	mt7915_mac_tx_free_done(dev, &free_list, wake);
@@ -1473,7 +1477,7 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	napi_disable(&dev->mt76.tx_napi);
 
 	/* token reinit */
-	mt76_connac2_tx_token_put(&dev->mt76);
+	mt76_connac2_tx_token_put(&dev->mt76, &dev->phy.mib);
 	idr_init(&dev->mt76.token);
 
 	mt7915_dma_reset(dev, true);
@@ -1666,7 +1670,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	if (mt7915_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
 		mt7915_dma_reset(dev, false);
 
-		mt76_connac2_tx_token_put(&dev->mt76);
+		mt76_connac2_tx_token_put(&dev->mt76, &dev->phy.mib);
 		idr_init(&dev->mt76.token);
 
 		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 7fb60178939b..e9b3b247c0d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1255,6 +1255,10 @@ static int mt7915_sta_set_txpwr(struct ieee80211_hw *hw,
 }
 
 static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
+	"tx_pkts_nic", /* from driver, phy tx-ok skb */
+	"tx_bytes_nic", /* from driver, phy tx-ok bytes */
+	"rx_pkts_nic", /* from driver, phy rx OK skb */
+	"rx_bytes_nic", /* from driver, phy rx OK bytes */
 	"tx_ampdu_cnt",
 	"tx_stop_q_empty_cnt",
 	"tx_mpdu_attempts",
@@ -1482,6 +1486,13 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 
 	mt7915_mac_update_stats(phy);
 
+	/* driver phy-wide stats */
+	data[ei++] = mib->tx_pkts_nic;
+	data[ei++] = mib->tx_bytes_nic;
+	data[ei++] = mib->rx_pkts_nic;
+	data[ei++] = mib->rx_bytes_nic;
+
+	/* MIB stats from FW/HW */
 	data[ei++] = mib->tx_ampdu_cnt;
 	data[ei++] = mib->tx_stop_q_empty_cnt;
 	data[ei++] = mib->tx_mpdu_attempts_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 26defc8930ef..f3e3e8761869 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -510,6 +510,7 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 	struct mt76_connac_tx_free *free = data;
 	__le32 *tx_info = (__le32 *)(data + sizeof(*free));
 	struct mt76_dev *mdev = &dev->mt76;
+	struct mt792x_phy *phy = &dev->phy;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
 	struct mt76_wcid *wcid = NULL;
@@ -565,7 +566,8 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 		if (!txwi)
 			continue;
 
-		mt76_connac2_txwi_free(mdev, txwi, sta, &free_list, tx_cnt, tx_status, ampdu);
+		mt76_connac2_txwi_free(mdev, txwi, sta, &free_list, tx_cnt, tx_status, ampdu,
+				       &phy->mib);
 	}
 
 	if (wake)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index f04e7095e181..88df129d45ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -48,7 +48,7 @@ static void mt7921e_unregister_device(struct mt792x_dev *dev)
 	cancel_work_sync(&pm->wake_work);
 	cancel_work_sync(&dev->reset_work);
 
-	mt76_connac2_tx_token_put(&dev->mt76);
+	mt76_connac2_tx_token_put(&dev->mt76, &dev->phy.mib);
 	__mt792x_mcu_drv_pmctrl(dev);
 	mt792x_dma_cleanup(dev);
 	mt792x_wfsys_reset(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index c866144ff061..e14919b8b8d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -77,7 +77,7 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 	napi_disable(&dev->mt76.napi[MT_RXQ_MCU_WA]);
 	napi_disable(&dev->mt76.tx_napi);
 
-	mt76_connac2_tx_token_put(&dev->mt76);
+	mt76_connac2_tx_token_put(&dev->mt76, &dev->phy.mib);
 	idr_init(&dev->mt76.token);
 
 	mt792x_wpdma_reset(dev, true);
-- 
2.40.0

