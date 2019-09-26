Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6D3BF7D7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfIZRrh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:37 -0400
Received: from nbd.name ([46.4.11.11]:55238 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfIZRrg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Z5jfoaKH5ITkg7FKfzrLWNwn3hOgsa2IcUlB827tVCs=; b=dbed80oQqgQzul+Bg7xs9pSpHB
        O5CIZ2EV1y8X8jDK9PwTPi07NNDGCs+9ijY2CXQzgOMeZ+C54EgUJOD1XwFuW27YUBGD0CcTRZWrJ
        l3xvyfJTI5SKy/3Kr6f3v0c6HRzTrWP2/oZ89kuNaMlo8T05+I5PEopl8ZoQRh8y3Id4=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXrZ-0000ya-8S
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:33 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B419B69B6A82; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 10/15] mt76: mt76x02: track approximate tx airtime for airtime fairness and survey
Date:   Thu, 26 Sep 2019 19:47:27 +0200
Message-Id: <20190926174732.42375-10-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Estimate by calculating duration for EWMA packet size + estimated A-MPDU
length on tx status events

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/airtime.c  | 48 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  1 +
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 49 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  6 +++
 .../net/wireless/mediatek/mt76/mt76x02_txrx.c | 10 +++-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  4 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  1 +
 .../net/wireless/mediatek/mt76/mt76x2/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |  1 +
 12 files changed, 117 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/airtime.c b/drivers/net/wireless/mediatek/mt76/airtime.c
index d5bc4d713a88..55116f395f9a 100644
--- a/drivers/net/wireless/mediatek/mt76/airtime.c
+++ b/drivers/net/wireless/mediatek/mt76/airtime.c
@@ -276,3 +276,51 @@ u32 mt76_calc_rx_airtime(struct mt76_dev *dev, struct mt76_rx_status *status,
 
 	return duration;
 }
+
+u32 mt76_calc_tx_airtime(struct mt76_dev *dev, struct ieee80211_tx_info *info,
+			 int len)
+{
+	struct mt76_rx_status stat = {
+		.band = info->band,
+	};
+	u32 duration = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(info->status.rates); i++) {
+		struct ieee80211_tx_rate *rate = &info->status.rates[i];
+		u32 cur_duration;
+
+		if (rate->idx < 0 || !rate->count)
+			break;
+
+		if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+			stat.bw = RATE_INFO_BW_80;
+		else if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+			stat.bw = RATE_INFO_BW_40;
+		else
+			stat.bw = RATE_INFO_BW_20;
+
+		stat.enc_flags = 0;
+		if (rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
+			stat.enc_flags |= RX_ENC_FLAG_SHORTPRE;
+		if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
+			stat.enc_flags |= RX_ENC_FLAG_SHORT_GI;
+
+		stat.rate_idx = rate->idx;
+		if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
+			stat.encoding = RX_ENC_VHT;
+			stat.rate_idx = ieee80211_rate_get_vht_mcs(rate);
+			stat.nss = ieee80211_rate_get_vht_nss(rate);
+		} else if (rate->flags & IEEE80211_TX_RC_MCS) {
+			stat.encoding = RX_ENC_HT;
+		} else {
+			stat.encoding = RX_ENC_LEGACY;
+		}
+
+		cur_duration = mt76_calc_rx_airtime(dev, &stat, len);
+		duration += cur_duration * rate->count;
+	}
+
+	return duration;
+}
+EXPORT_SYMBOL_GPL(mt76_calc_tx_airtime);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4f3849b4f677..49511bd06fd9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -770,6 +770,8 @@ void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  const u8 *mac);
 void mt76_sw_scan_complete(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif);
+u32 mt76_calc_tx_airtime(struct mt76_dev *dev, struct ieee80211_tx_info *info,
+			 int len);
 
 /* internal */
 void mt76_tx_free(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 9f224f0f7c00..9621e7b16eaf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -148,6 +148,7 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		.txwi_size = sizeof(struct mt76x02_txwi),
 		.drv_flags = MT_DRV_TX_ALIGNED4_SKBS |
 			     MT_DRV_SW_RX_AIRTIME,
+		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02_tx_prepare_skb,
 		.tx_complete_skb = mt76x02_tx_complete_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 259bd2a55b23..ade6312c7367 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -205,6 +205,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.drv_flags = MT_DRV_SW_RX_AIRTIME,
+		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02u_tx_prepare_skb,
 		.tx_complete_skb = mt76x02u_tx_complete_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 50b0131f85bf..0ca0bbfe8769 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -81,6 +81,7 @@ struct mt76x02_dev {
 	u8 txdone_seq;
 	DECLARE_KFIFO_PTR(txstatus_fifo, struct mt76x02_tx_status);
 	spinlock_t txstatus_fifo_lock;
+	u32 tx_airtime;
 
 	struct sk_buff *rx_head;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index d32efc0b100d..d4f37140fede 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -483,8 +483,8 @@ mt76x02_mac_fill_tx_status(struct mt76x02_dev *dev, struct mt76x02_sta *msta,
 	phy = FIELD_GET(MT_RXWI_RATE_PHY, st->rate);
 
 	if (st->pktid & MT_PACKET_ID_HAS_RATE) {
-		first_rate = st->rate & ~MT_RXWI_RATE_INDEX;
-		first_rate |= st->pktid & MT_RXWI_RATE_INDEX;
+		first_rate = st->rate & ~MT_PKTID_RATE;
+		first_rate |= st->pktid & MT_PKTID_RATE;
 
 		mt76x02_mac_process_tx_rate(&rate[0], first_rate,
 					    dev->mt76.chandef.chan->band);
@@ -537,10 +537,20 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 	struct ieee80211_tx_status status = {
 		.info = &info
 	};
+	static const u8 ac_to_tid[4] = {
+		[IEEE80211_AC_BE] = 0,
+		[IEEE80211_AC_BK] = 1,
+		[IEEE80211_AC_VI] = 4,
+		[IEEE80211_AC_VO] = 6
+	};
 	struct mt76_wcid *wcid = NULL;
 	struct mt76x02_sta *msta = NULL;
 	struct mt76_dev *mdev = &dev->mt76;
 	struct sk_buff_head list;
+	u32 duration = 0;
+	u8 cur_pktid;
+	u32 ac = 0;
+	int len;
 
 	if (stat->pktid == MT_PACKET_ID_NO_ACK)
 		return;
@@ -570,10 +580,10 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 
 	if (!status.skb && !(stat->pktid & MT_PACKET_ID_HAS_RATE)) {
 		mt76_tx_status_unlock(mdev, &list);
-		rcu_read_unlock();
-		return;
+		goto out;
 	}
 
+
 	if (msta && stat->aggr && !status.skb) {
 		u32 stat_val, stat_cache;
 
@@ -586,10 +596,10 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 		    stat->wcid == msta->status.wcid && msta->n_frames < 32) {
 			msta->n_frames++;
 			mt76_tx_status_unlock(mdev, &list);
-			rcu_read_unlock();
-			return;
+			goto out;
 		}
 
+		cur_pktid = msta->status.pktid;
 		mt76x02_mac_fill_tx_status(dev, msta, status.info,
 					   &msta->status, msta->n_frames);
 
@@ -597,6 +607,7 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 		msta->n_frames = 1;
 		*update = 0;
 	} else {
+		cur_pktid = stat->pktid;
 		mt76x02_mac_fill_tx_status(dev, msta, status.info, stat, 1);
 		*update = 1;
 	}
@@ -607,6 +618,30 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 
 	if (!status.skb)
 		ieee80211_tx_status_ext(mt76_hw(dev), &status);
+
+	if (status.skb) {
+		len = status.skb->len;
+		ac = skb_get_queue_mapping(status.skb);
+	} else if (msta) {
+		len = status.info->status.ampdu_len * ewma_pktlen_read(&msta->pktlen);
+		ac = FIELD_GET(MT_PKTID_AC, cur_pktid);
+	} else {
+		goto out;
+	}
+
+	if (!len)
+		goto out;
+
+	duration = mt76_calc_tx_airtime(&dev->mt76, status.info, len);
+
+	spin_lock_bh(&dev->mt76.cc_lock);
+	dev->tx_airtime += duration;
+	spin_unlock_bh(&dev->mt76.cc_lock);
+
+	if (msta)
+		ieee80211_sta_register_airtime(status.sta, ac_to_tid[ac], duration, 0);
+
+out:
 	rcu_read_unlock();
 }
 
@@ -987,6 +1022,8 @@ void mt76x02_update_channel(struct mt76_dev *mdev)
 
 	state = mdev->chan_state;
 	state->cc_busy += mt76_rr(dev, MT_CH_BUSY);
+	state->cc_tx += dev->tx_airtime;
+	dev->tx_airtime = 0;
 }
 EXPORT_SYMBOL_GPL(mt76x02_update_channel);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index 48de8eb82856..7d946aa77182 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -23,11 +23,16 @@ struct mt76x02_tx_status {
 #define MT_VIF_WCID(_n)		(254 - ((_n) & 7))
 #define MT_MAX_VIFS		8
 
+#define MT_PKTID_RATE		GENMASK(4, 0)
+#define MT_PKTID_AC		GENMASK(6, 5)
+
 struct mt76x02_vif {
 	struct mt76_wcid group_wcid; /* must be first */
 	u8 idx;
 };
 
+DECLARE_EWMA(pktlen, 8, 8);
+
 struct mt76x02_sta {
 	struct mt76_wcid wcid; /* must be first */
 
@@ -35,6 +40,7 @@ struct mt76x02_sta {
 	struct mt76x02_tx_status status;
 	int n_frames;
 
+	struct ewma_pktlen pktlen;
 };
 
 #define MT_RXINFO_BA			BIT(0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
index f27aade34c1e..13825f642087 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
@@ -158,7 +158,9 @@ int mt76x02_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	/* encode packet rate for no-skb packet id to fix up status reporting */
 	if (pid == MT_PACKET_ID_NO_SKB)
 		pid = MT_PACKET_ID_HAS_RATE |
-		      (le16_to_cpu(txwi->rate) & MT_RXWI_RATE_INDEX);
+		      (le16_to_cpu(txwi->rate) & MT_RXWI_RATE_INDEX) |
+		      FIELD_PREP(MT_PKTID_AC,
+				 skb_get_queue_mapping(tx_info->skb));
 
 	txwi->pktid = pid;
 
@@ -171,6 +173,12 @@ int mt76x02_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!wcid || wcid->hw_key_idx == 0xff || wcid->sw_iv)
 		tx_info->info |= MT_TXD_INFO_WIV;
 
+	if (sta) {
+		struct mt76x02_sta *msta = (struct mt76x02_sta *)sta->drv_priv;
+
+		ewma_pktlen_add(&msta->pktlen, tx_info->skb->len);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76x02_tx_prepare_skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 203420087ac4..4294ffc0478b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -104,7 +104,9 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 	/* encode packet rate for no-skb packet id to fix up status reporting */
 	if (pid == MT_PACKET_ID_NO_SKB)
 		pid = MT_PACKET_ID_HAS_RATE |
-		      (le16_to_cpu(txwi->rate) & MT_RXWI_RATE_INDEX);
+		      (le16_to_cpu(txwi->rate) & MT_PKTID_RATE) |
+		      FIELD_PREP(MT_PKTID_AC,
+				 skb_get_queue_mapping(tx_info->skb));
 
 	txwi->pktid = pid;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index aec73a0295e8..f5695ebdb225 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -264,6 +264,7 @@ int mt76x02_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.hw_key_idx = -1;
 	mt76x02_mac_wcid_setup(dev, idx, mvif->idx, sta->addr);
 	mt76x02_mac_wcid_set_drop(dev, idx, false);
+	ewma_pktlen_init(&msta->pktlen);
 
 	if (vif->type == NL80211_IFTYPE_AP)
 		set_bit(MT_WCID_FLAG_CHECK_PS, &msta->wcid.flags);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 5304b6ecda26..6253ec5fbd72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -23,6 +23,7 @@ mt76pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		.txwi_size = sizeof(struct mt76x02_txwi),
 		.drv_flags = MT_DRV_TX_ALIGNED4_SKBS |
 			     MT_DRV_SW_RX_AIRTIME,
+		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02_tx_prepare_skb,
 		.tx_complete_skb = mt76x02_tx_complete_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 81be59c60155..e6d778456e5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -26,6 +26,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.drv_flags = MT_DRV_SW_RX_AIRTIME,
+		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02u_tx_prepare_skb,
 		.tx_complete_skb = mt76x02u_tx_complete_skb,
-- 
2.17.0

