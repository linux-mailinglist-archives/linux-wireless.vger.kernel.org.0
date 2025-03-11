Return-Path: <linux-wireless+bounces-20163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD97EA5BE04
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2997716E510
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1387623A588;
	Tue, 11 Mar 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="EkQFR+Rr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED92206BD
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689412; cv=none; b=tv9+ATyktygrlw3V+ETRh9oKuv5Lc9dnr1fhylf0HD+YmN6ofnwDTJzZBnbXlRmTWedEUcO3nLfFzFtiQF/P46IzHGddbo7nuCNgEfFHhWZVAWXCw49Gw+cQmQx0vmq11odBxnOb4XUSa3ofYDWa/0bFGr2yhxDcQGtFMMMW8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689412; c=relaxed/simple;
	bh=BcMRkG/soWvQKcOcsU1YNcWcIXIuez97A5gSbEOQjho=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3vR/ngv5OkNlBOGffjlVyFA+grj8/trE2MvQ00t28QRX3RWQu5n0wfipT8Cdg7ZVyn8FVIOwnlYxnsRGEyGTEYr7jWaddivjz1dGh1bdDhUQjZ6r6wihj7jxyOVkj8Uc+ZIWO/etiHGzihvi+/L6Y9+VBpFiqVKU0uCM7667S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=EkQFR+Rr; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0uqhX57dyoWIH8t2PzPsS9ws5JDhtcSOc1h7GGuPQX4=; b=EkQFR+RrFEvGBDUIRWU5Brxeq5
	ddfXikZPkQeHOiwa0R6KWIuXh7rf2NIMZErfNlvmbTlQeCpsYOEob7WuhDMva2i34nGD2uBXUsLJL
	Yu/SLT3JaWL7hbZ08Rei18a8Ofmdxia4ZRcgokYqyr0F4zCH5Sy9YsTxavSPm/uTqZKY=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1trwyd-00Ftvh-0k
	for linux-wireless@vger.kernel.org;
	Tue, 11 Mar 2025 11:36:47 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 5/8] wifi: mt76: mt7996: use the correct vif link for scanning/roc
Date: Tue, 11 Mar 2025 11:36:42 +0100
Message-ID: <20250311103646.43346-5-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311103646.43346-1-nbd@nbd.name>
References: <20250311103646.43346-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the newly added offchannel_link pointer in vif data

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 40 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  1 +
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 162d1552602e..9dfc8106ebec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -831,7 +831,8 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
-	struct mt76_vif_link *mvif;
+	struct mt76_vif_link *mlink = NULL;
+	struct mt7996_vif *mvif;
 	u16 tx_count = 15;
 	u32 val;
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
@@ -839,11 +840,18 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
 				    BSS_CHANGED_BEACON_ENABLED)) && (!inband_disc);
 
-	mvif = vif ? (struct mt76_vif_link *)vif->drv_priv : NULL;
-	if (mvif) {
-		omac_idx = mvif->omac_idx;
-		wmm_idx = mvif->wmm_idx;
-		band_idx = mvif->band_idx;
+	if (vif) {
+		mvif = (struct mt7996_vif *)vif->drv_priv;
+		if (wcid->offchannel)
+			mlink = rcu_dereference(mvif->mt76.offchannel_link);
+		if (!mlink)
+			mlink = &mvif->deflink.mt76;
+	}
+
+	if (mlink) {
+		omac_idx = mlink->omac_idx;
+		wmm_idx = mlink->wmm_idx;
+		band_idx = mlink->band_idx;
 	}
 
 	if (inband_disc) {
@@ -909,13 +917,13 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			     is_multicast_ether_addr(hdr->addr1);
 		u8 idx = MT7996_BASIC_RATES_TBL;
 
-		if (mvif) {
-			if (mcast && mvif->mcast_rates_idx)
-				idx = mvif->mcast_rates_idx;
-			else if (beacon && mvif->beacon_rates_idx)
-				idx = mvif->beacon_rates_idx;
+		if (mlink) {
+			if (mcast && mlink->mcast_rates_idx)
+				idx = mlink->mcast_rates_idx;
+			else if (beacon && mlink->beacon_rates_idx)
+				idx = mlink->beacon_rates_idx;
 			else
-				idx = mvif->basic_rates_idx;
+				idx = mlink->basic_rates_idx;
 		}
 
 		val = FIELD_PREP(MT_TXD6_TX_RATE, idx) | MT_TXD6_FIXED_BW;
@@ -983,8 +991,14 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	if (vif) {
 		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+		struct mt76_vif_link *mlink = NULL;
 
-		txp->fw.bss_idx = mvif->deflink.mt76.idx;
+		if (wcid->offchannel)
+			mlink = rcu_dereference(mvif->mt76.offchannel_link);
+		if (!mlink)
+			mlink = &mvif->deflink.mt76;
+
+		txp->fw.bss_idx = mlink->idx;
 	}
 
 	txp->fw.token = cpu_to_le16(id);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 69dd565d8319..886b6ef3462b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -249,6 +249,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	mlink->band_idx = band_idx;
 	mlink->wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
 	mlink->wcid = &link->sta.wcid;
+	mlink->wcid->offchannel = mlink->offchannel;
 
 	ret = mt7996_mcu_add_dev_info(phy, vif, link_conf, mlink, true);
 	if (ret)
-- 
2.47.1


