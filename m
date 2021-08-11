Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8F3E9A8C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhHKVqK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:46:10 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:59022 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232311AbhHKVpp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:45 -0400
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F35A024AE46
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:45:14 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.27])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 72EC72A0073
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 39AD160006C
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C622013C2B3;
        Wed, 11 Aug 2021 14:44:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C622013C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718291;
        bh=BiEWB8o6owcOnUktXjVZaW60qbwySxnpZwVYxYQTSJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+thDWcB2TXKTNlcfruTUsxusgiaBOlfk3v2MBfAykxVDjXM64LXi77JI4vGHJRDN
         2fpnHtXRm9iA54D9egRDEHFfZ9jm67kxMrxtGPmkol6yPtzlgUi9x5nSC868tBMKxa
         1c3T1C+49jrPhnpC/nmgt+VNEIZ0PUuzRrZgLQHI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 10/15] mt76: mt7915:  add ethtool tx/rx pkts/bytes
Date:   Wed, 11 Aug 2021 14:44:34 -0700
Message-Id: <20210811214439.17458-11-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718292-6PuCd124k4fr
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
index 7ca06b8c9671..9883d1e55f5b 100644
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
 
@@ -1341,6 +1344,8 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 	u16 wcid_idx;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_tx_rate *rate;
+	struct mt7915_phy *phy = &dev->phy;
+	struct mib_stats *mib = &phy->mib;
 
 	mt7915_txp_skb_unmap(mdev, t);
 	if (!t->skb)
@@ -1422,6 +1427,8 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 	/* Apply the values that this txfree path reports */
 	rate->count = tx_cnt;
 	if (tx_status == 0) {
+		mib->tx_pkts_nic++;
+		mib->tx_bytes_nic += t->skb->len;
 		info->flags |= IEEE80211_TX_STAT_ACK;
 		info->status.ampdu_ack_len = 1;
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 22ceb46be4bf..4f609a5d38a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1030,6 +1030,10 @@ static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
 }
 
 static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
+	"tx_pkts_nic", /* from driver, phy tx-ok skb */
+	"tx_bytes_nic", /* from driver, phy tx-ok bytes */
+	"rx_pkts_nic", /* from driver, phy rx OK skb */
+	"rx_bytes_nic", /* from driver, phy rx OK bytes */
 	"tx_ampdu_cnt",
 	"tx_stop_q_empty_cnt",
 	"tx_mpdu_attempts",
@@ -1265,6 +1269,13 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	if (!phy)
 		return;
 
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
index 2d7c84946e40..1a0d7d62c582 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -125,6 +125,13 @@ struct mt7915_vif {
 
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

