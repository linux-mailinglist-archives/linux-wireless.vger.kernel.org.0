Return-Path: <linux-wireless+bounces-22484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1172EAAA04F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1A37A2E73
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F627B513;
	Mon,  5 May 2025 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AW3cqLiO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9B27A478;
	Mon,  5 May 2025 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483425; cv=none; b=NZdCOVJMu1ZYblfmUsOX9iN93baE3LcQQmYv0qApNPgQBo1sywfkYDAbNlpz5zwUowkcWX699iArke3lt+q/kT+D267wuSoIS00plmL9W3c8irxpTLKLqBNgjFaNz1ew7P/Qjr8bnqnYKt0Zb0bzQUpS5tvjN0op3OSnff043AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483425; c=relaxed/simple;
	bh=6qaGOBfLQqjBlG7mlV7178I8mSUvnwgJ+5rXSWFfTWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YrV9T/X4ApZplt6bzWeEnOsk0LBuKYz/j22G8SNG7rem86j8TWAPJpL7bLFghaEjNmPuw1nJoK4SUTCfgR6zDgWifYXX38raTe1dhsfOnu3J4/2b/RWgjZmGKxOrT053Va/O7nI6ep1X633kHfzR5TFS8ozpKfDmmc8LFHwneDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AW3cqLiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CF7C4CEED;
	Mon,  5 May 2025 22:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483425;
	bh=6qaGOBfLQqjBlG7mlV7178I8mSUvnwgJ+5rXSWFfTWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AW3cqLiOdmsJUn1UWa9LJFWHXTOxROTJqBMNdfmnoGqApv0hJK1tHEa7nmB0ApXw0
	 tEJIbETLWTRCepZLtvRrsIHnyAb7U1f1V/UxSMmiDjTwwoVzXFCFd5AqPb7Eq0owRR
	 dpYSQ+28Op3lQh8tEE9z0cq0nhBbr9rzQ+RrmrFqEejMSekDagc3HbcpeSXjJ9M8tu
	 vm9GUIIHZ7RdM9vvhIWxU4kOg66tcH9p8yvyaEgdzsKUhgPJdAke6DV7lVbNbStatp
	 Ksz+T1Ke6gqNB7u4NeyaZStasZVX1tPCXK9E/wLuehUAZulHlXVaAkP1e2oww3NwQG
	 PidfmXbKgeE2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shayne.chen@mediatek.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 076/642] wifi: mt76: mt7996: use the correct vif link for scanning/roc
Date: Mon,  5 May 2025 18:04:52 -0400
Message-Id: <20250505221419.2672473-76-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 13b4c81083cc4b59fb639a511c0a9a7c38efde7e ]

Use the newly added offchannel_link pointer in vif data

Link: https://patch.msgid.link/20250311103646.43346-5-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 40 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  1 +
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 019c925ae600e..88f9d9059d5f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -832,7 +832,8 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
-	struct mt76_vif_link *mvif;
+	struct mt76_vif_link *mlink = NULL;
+	struct mt7996_vif *mvif;
 	u16 tx_count = 15;
 	u32 val;
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
@@ -840,11 +841,18 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
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
@@ -910,13 +918,13 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
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
@@ -984,8 +992,14 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	if (vif) {
 		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+		struct mt76_vif_link *mlink = NULL;
+
+		if (wcid->offchannel)
+			mlink = rcu_dereference(mvif->mt76.offchannel_link);
+		if (!mlink)
+			mlink = &mvif->deflink.mt76;
 
-		txp->fw.bss_idx = mvif->deflink.mt76.idx;
+		txp->fw.bss_idx = mlink->idx;
 	}
 
 	txp->fw.token = cpu_to_le16(id);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 980a059b3b38f..b01cc7ef47999 100644
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
2.39.5


