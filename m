Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4600749C107
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 03:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiAZCFh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 21:05:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35602 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236092AbiAZCFg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 21:05:36 -0500
X-UUID: 648b016f2fa14e1d96dc999208f0e4d6-20220126
X-UUID: 648b016f2fa14e1d96dc999208f0e4d6-20220126
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 367398257; Wed, 26 Jan 2022 10:05:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 10:05:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 10:05:30 +0800
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix mcs_map in mt7915_mcu_set_sta_he_mcs()
Date:   Wed, 26 Jan 2022 10:05:29 +0800
Message-ID: <20220126020529.12000-2-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220126020529.12000-1-chui-hao.chiu@mediatek.com>
References: <20220126020529.12000-1-chui-hao.chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Should use peer's bandwidth instead of chandef->width to
get correct mcs_map.

Fixes: 76be6c076c077 ("mt76: mt7915: add .set_bitrate_mask() callback")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 29 +++++--------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 66f8daf3168c..efcadd69ecd7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -86,24 +86,12 @@ mt7915_mcu_get_sta_nss(u16 mcs_map)
 
 static void
 mt7915_mcu_set_sta_he_mcs(struct ieee80211_sta *sta, __le16 *he_mcs,
-			  const u16 *mask)
+			  u16 mcs_map)
 {
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct cfg80211_chan_def *chandef = &msta->vif->phy->mt76->chandef;
+	enum nl80211_band band = msta->vif->phy->mt76->chandef.chan->band;
+	const u16 *mask = msta->vif->bitrate_mask.control[band].he_mcs;
 	int nss, max_nss = sta->rx_nss > 3 ? 4 : sta->rx_nss;
-	u16 mcs_map;
-
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_80P80:
-		mcs_map = le16_to_cpu(sta->he_cap.he_mcs_nss_supp.rx_mcs_80p80);
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		mcs_map = le16_to_cpu(sta->he_cap.he_mcs_nss_supp.rx_mcs_160);
-		break;
-	default:
-		mcs_map = le16_to_cpu(sta->he_cap.he_mcs_nss_supp.rx_mcs_80);
-		break;
-	}
 
 	for (nss = 0; nss < max_nss; nss++) {
 		int mcs;
@@ -760,11 +748,9 @@ static void
 mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		      struct ieee80211_vif *vif)
 {
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct ieee80211_he_cap_elem *elem = &sta->he_cap.he_cap_elem;
-	enum nl80211_band band = msta->vif->phy->mt76->chandef.chan->band;
-	const u16 *mcs_mask = msta->vif->bitrate_mask.control[band].he_mcs;
+	struct ieee80211_he_mcs_nss_supp mcs_map;
 	struct sta_rec_he *he;
 	struct tlv *tlv;
 	u32 cap = 0;
@@ -854,22 +840,23 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 
 	he->he_cap = cpu_to_le32(cap);
 
+	mcs_map = sta->he_cap.he_mcs_nss_supp;
 	switch (sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		if (elem->phy_cap_info[0] &
 		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
 			mt7915_mcu_set_sta_he_mcs(sta,
 						  &he->max_nss_mcs[CMD_HE_MCS_BW8080],
-						  mcs_mask);
+						  le16_to_cpu(mcs_map.rx_mcs_80p80));
 
 		mt7915_mcu_set_sta_he_mcs(sta,
 					  &he->max_nss_mcs[CMD_HE_MCS_BW160],
-					  mcs_mask);
+					  le16_to_cpu(mcs_map.rx_mcs_160));
 		fallthrough;
 	default:
 		mt7915_mcu_set_sta_he_mcs(sta,
 					  &he->max_nss_mcs[CMD_HE_MCS_BW80],
-					  mcs_mask);
+					  le16_to_cpu(mcs_map.rx_mcs_80));
 		break;
 	}
 
-- 
2.29.2

