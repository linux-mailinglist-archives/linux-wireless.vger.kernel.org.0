Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D524C3E9A85
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhHKVpv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:45:51 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:58450 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232212AbhHKVpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:19 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.48.61])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id EEB3F2005E
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:51 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B3217C0070
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:51 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 00A8013C2BC;
        Wed, 11 Aug 2021 14:44:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 00A8013C2BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718291;
        bh=i5oeDBHi/e687OJ0AVoEccXnXu7tCfqappsSLtfOngg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSAnVLwp9E+1qPWi0bXlOr3QpAiFTDYgSx0zaPw3J/8WEtD3Uo1DUC/WQRam+itQE
         mLwKXq+3WpuuLWGTjuQO6YJpzJRCbGSybwX/k/6Vj1GgRUx/UUtyotzwpOd7mrkQGN
         h9I9CuzfgCfhlwO/W3RQ0gYa8s9w3bcuS+SfQwIg=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 07/15] mt76: mt7915:  ethtool group-5 rx stats information
Date:   Wed, 11 Aug 2021 14:44:31 -0700
Message-Id: <20210811214439.17458-8-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718292-m0ViCENeW0vW
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Add ethtool support for rx-nss, rx-bw, rx-mode stats.
These are only valid when the group-5 rx stats are
enabled.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 ++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 42 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 10 +++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f1cff26cbc36..697dbf62c35f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -424,6 +424,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	u8 qos_ctl = 0;
 	__le16 fc = 0;
 	int i, idx;
+	struct mt7915_sta_stats *mstats = NULL;
 
 	memset(status, 0, sizeof(*status));
 
@@ -451,6 +452,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		struct mt7915_sta *msta;
 
 		msta = container_of(status->wcid, struct mt7915_sta, wcid);
+		mstats = &msta->stats;
 		spin_lock_bh(&dev->sta_poll_lock);
 		if (list_empty(&msta->poll_list))
 			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
@@ -654,8 +656,19 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 				WARN_ON_ONCE(nss > 4);
 			}
 
+			if (mstats) {
+				if (nss > 3)
+					mstats->rx_nss[3]++;
+				else
+					mstats->rx_nss[nss - 1]++;
+
+				mstats->rx_mode[mode]++;
+			}
+
 			switch (FIELD_GET(MT_CRXV_FRAME_MODE, v2)) {
 			case IEEE80211_STA_RX_BW_20:
+				if (mstats)
+					mstats->rx_bw_20++;
 				break;
 			case IEEE80211_STA_RX_BW_40:
 				if (mode & MT_PHY_TYPE_HE_EXT_SU &&
@@ -663,14 +676,24 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 					status->bw = RATE_INFO_BW_HE_RU;
 					status->he_ru =
 						NL80211_RATE_INFO_HE_RU_ALLOC_106;
+					if (mstats) {
+						mstats->rx_bw_he_ru++;
+						mstats->rx_ru_106++;
+					}
 				} else {
 					status->bw = RATE_INFO_BW_40;
+					if (mstats)
+						mstats->rx_bw_40++;
 				}
 				break;
 			case IEEE80211_STA_RX_BW_80:
 				status->bw = RATE_INFO_BW_80;
+				if (mstats)
+					mstats->rx_bw_80++;
 				break;
 			case IEEE80211_STA_RX_BW_160:
+				if (mstats)
+					mstats->rx_bw_160++;
 				status->bw = RATE_INFO_BW_160;
 				break;
 			default:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 427b275f123a..1ce4260557c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1123,6 +1123,27 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_mcs_9",
 	"v_tx_mcs_10",
 	"v_tx_mcs_11",
+
+	/* per-vif rx counters */
+	"v_rx_nss1",
+	"v_rx_nss2",
+	"v_rx_nss3",
+	"v_rx_nss4",
+	"v_rx_mode_cck",
+	"v_rx_mode_ofdm",
+	"v_rx_mode_ht",
+	"v_rx_mode_ht_gf",
+	"v_rx_mode_vht",
+	"v_rx_mode_he_su",
+	"v_rx_mode_he_ext_su",
+	"v_rx_mode_he_tb",
+	"v_rx_mode_he_mu",
+	"v_rx_bw_20",
+	"v_rx_bw_40",
+	"v_rx_bw_80",
+	"v_rx_bw_160",
+	"v_rx_bw_he_ru",
+	"v_rx_ru_106",
 };
 
 #define MT7915_SSTATS_LEN ARRAY_SIZE(mt7915_gstrings_stats)
@@ -1190,6 +1211,27 @@ static void mt7915_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	for (q = 0; q < 12; q++)
 		data[ei++] += mstats->tx_mcs[q];
 
+	/* rx stats */
+	for (q = 0; q < ARRAY_SIZE(mstats->rx_nss); q++)
+		data[ei++] += mstats->rx_nss[q];
+
+	data[ei++] += mstats->rx_mode[MT_PHY_TYPE_CCK];
+	data[ei++] += mstats->rx_mode[MT_PHY_TYPE_OFDM];
+	data[ei++] += mstats->rx_mode[MT_PHY_TYPE_HT];
+	data[ei++] += mstats->rx_mode[MT_PHY_TYPE_HT_GF];
+	data[ei++] += mstats->rx_mode[MT_PHY_TYPE_VHT];
+	data[ei++] += mstats->rx_mode[MT_PHY_TYPE_HE_SU];
+	data[ei++] += mstats->rx_mode[MT_PHY_TYPE_HE_EXT_SU];
+	data[ei++] += mstats->rx_mode[MT_PHY_TYPE_HE_TB];
+	data[ei++] += mstats->rx_mode[MT_PHY_TYPE_HE_MU];
+
+	data[ei++] += mstats->rx_bw_20;
+	data[ei++] += mstats->rx_bw_40;
+	data[ei++] += mstats->rx_bw_80;
+	data[ei++] += mstats->rx_bw_160;
+	data[ei++] += mstats->rx_bw_he_ru;
+	data[ei++] += mstats->rx_ru_106;
+
 	wi->worker_stat_count = ei - wi->initial_stat_idx;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b446a5c73aa5..1f0be4fbee35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -73,6 +73,16 @@ struct mt7915_sta_stats {
 	unsigned long tx_bw[4]; /* 20, 40, 80, 160 */
 	unsigned long tx_nss[4]; /* 1, 2, 3, 4 */
 	unsigned long tx_mcs[16]; /* mcs idx */
+
+	/* This section requires group-5 in rxd to be enabled. */
+	u32 rx_nss[4]; /* rx-nss histogram */
+	u32 rx_mode[MT_PHY_TYPE_HE_LAST]; /* rx mode histogram */
+	u32 rx_bw_20;
+	u32 rx_bw_40;
+	u32 rx_bw_80;
+	u32 rx_bw_160;
+	u32 rx_bw_he_ru;
+	u32 rx_ru_106;
 };
 
 struct mt7915_sta_key_conf {
-- 
2.20.1

