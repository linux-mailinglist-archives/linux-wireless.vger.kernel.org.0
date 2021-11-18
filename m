Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CEF4560C6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhKRQok (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 11:44:40 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:60662 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233601AbhKRQok (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 11:44:40 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.164])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2947E2005E
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:38 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E22FDB00075
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:37 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 41BA713C2B8;
        Thu, 18 Nov 2021 08:41:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 41BA713C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637253667;
        bh=3v0xb8ptFJWVBSz+nkPgNelUV7VR/B9WdNoYnlW6jKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9ayABCeJW1whXXeyD2JKVFZbj7r93GS7BcQWKdN1Op5WwZaVDFwR/FxsWWG1uDdv
         1TBmertlzUddFrH30fQFIHMzv5/sdWf/FiVIht5nbq15a9KKbkonEtsWW/7Fl9m9Vc
         uMSUbfzniBh9+0hOqpxerkzQe0h138hLjo+6Lukk=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 08/11] mt76: mt7915: add ethtool tx/rx pkts/bytes
Date:   Thu, 18 Nov 2021 08:40:53 -0800
Message-Id: <20211118164056.2965-8-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118164056.2965-1-greearb@candelatech.com>
References: <20211118164056.2965-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1637253698-RBXa75bmoo1w
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
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  7 +++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 300928edd0d7..a97b4e64f74d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -782,6 +782,9 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			mt7915_mac_decode_he_mu_radiotap(skb, status, rxv);
 	}
 
+	mib->rx_pkts_nic++;
+	mib->rx_bytes_nic += skb->len;
+
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
 
@@ -1384,6 +1387,8 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 	u16 wcid_idx;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_tx_rate *rate;
+	struct mt7915_phy *phy = &dev->phy;
+	struct mib_stats *mib = &phy->mib;
 
 	mt7915_txp_skb_unmap(mdev, t);
 	if (!t->skb)
@@ -1465,6 +1470,8 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 	/* Apply the values that this txfree path reports */
 	rate->count = tx_cnt;
 	if (tx_status == 0) {
+		mib->tx_pkts_nic++;
+		mib->tx_bytes_nic += t->skb->len;
 		info->flags |= IEEE80211_TX_STAT_ACK;
 		info->status.ampdu_ack_len = 1;
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index f6c334721bca..c4eee951699e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1077,6 +1077,10 @@ static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
 }
 
 static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
+	"tx_pkts_nic", /* from driver, phy tx-ok skb */
+	"tx_bytes_nic", /* from driver, phy tx-ok bytes */
+	"rx_pkts_nic", /* from driver, phy rx OK skb */
+	"rx_bytes_nic", /* from driver, phy rx OK bytes */
 	"tx_ampdu_cnt",
 	"tx_stop_q_empty_cnt",
 	"tx_mpdu_attempts",
@@ -1259,6 +1263,13 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index bcbc8496516e..60881b357399 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -138,6 +138,13 @@ struct mt7915_vif {
 
 /* per-phy stats.  */
 struct mib_stats {
+	/* phy wide driver stats */
+	u32 tx_pkts_nic; /* tx OK skb */
+	u32 tx_bytes_nic; /* tx OK bytes */
+	u32 rx_pkts_nic; /* rx OK skb */
+	u32 rx_bytes_nic; /* rx OK bytes */
+
+	/* MIB counters from FW/HW */
 	u32 ack_fail_cnt;
 	u32 fcs_err_cnt;
 	u32 rts_cnt;
-- 
2.20.1

