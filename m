Return-Path: <linux-wireless+bounces-16916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4789FEA66
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AFE1882B03
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEDF19CC20;
	Mon, 30 Dec 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="CW77xFYf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14500EAD0
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587734; cv=none; b=AJJj5++C0hz3Ivb8mkyN/yp9TWFK/GfZitGF+gXfIEVvHUKxU964EtXdiXYNd0WdGklthlF8/K97g7axgf2aiY9FT5qQGjoxnH4DjqZ/wwd6FD1QjakK09ggMssx6yJ6PSn6rqVrTZWEype9CiZMjWS+RK8kXTeNG+hGd1A87Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587734; c=relaxed/simple;
	bh=cfF00UFwyD87wBF6ebvJtSDP17fno48kUalaR2qkYGw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=vGY0z7L3qy1MzkrjzJ8MrYwF+N5fO9JufVAouIW8/DzKCn9WWLfzjRQJVOMmuMz0Shmn7KSmEjpeEM4q57JS737Z+Gn9YwrEQWbd3yCHkRS3e8mgDU3y4CP1sL/GmFMKk3gW7X69nTIrrLF1bTUPjJFkvuN205lcRFiSUl/e23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=CW77xFYf; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cwvSys7HlITzva1LpN8DG4b5Si8Q/BfcxICPb5nPogI=; b=CW77xFYfWjDg/5w3vfCwLJCBHs
	f5DZ6COd8VZO7mm7AuC3p1M4+m/6gASQsedWQhjQNB9SeyFFO2Q6XvmqYW3e4WszZChUW2iZO/azo
	7RsH2fAc2gk3nWt4PYq09WK3VQHp7fb4VRcLSjzqMw1tm/NLOgd4boUR3bgkvT8k96tA=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeT-00GKzc-0m
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:09 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 01/14] wifi: mt76: remove mt76_calculate_default_rate()
Date: Mon, 30 Dec 2024 20:41:49 +0100
Message-ID: <20241230194202.95065-1-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is only used in mt76_connac2_mac_tx_rate_val, inline it there.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 24 -------------------
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 --
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 14 ++++++++++-
 3 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 7fbce5e757df..57c7b681645a 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1808,30 +1808,6 @@ mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 }
 EXPORT_SYMBOL_GPL(mt76_init_queue);
 
-u16 mt76_calculate_default_rate(struct mt76_phy *phy,
-				struct ieee80211_vif *vif, int rateidx)
-{
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = mvif->ctx ?
-					    &mvif->ctx->def :
-					    &phy->chandef;
-	int offset = 0;
-
-	if (chandef->chan->band != NL80211_BAND_2GHZ)
-		offset = 4;
-
-	/* pick the lowest rate for hidden nodes */
-	if (rateidx < 0)
-		rateidx = 0;
-
-	rateidx += offset;
-	if (rateidx >= ARRAY_SIZE(mt76_rates))
-		rateidx = offset;
-
-	return mt76_rates[rateidx].hw_value;
-}
-EXPORT_SYMBOL_GPL(mt76_calculate_default_rate);
-
 void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 			 struct mt76_sta_stats *stats, bool eht)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 599123967af6..3bc591c14b65 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1192,8 +1192,6 @@ int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 		int ring_base, void *wed, u32 flags);
-u16 mt76_calculate_default_rate(struct mt76_phy *phy,
-				struct ieee80211_vif *vif, int rateidx);
 static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
 				     int n_desc, int ring_base, void *wed,
 				     u32 flags)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index a3db65254e37..a72551ba27e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -299,6 +299,7 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 					    &mvif->ctx->def : &mphy->chandef;
 	u8 nss = 0, mode = 0, band = chandef->chan->band;
 	int rateidx = 0, mcast_rate;
+	int offset = 0;
 
 	if (!vif)
 		goto legacy;
@@ -330,7 +331,18 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 		rateidx = ffs(vif->bss_conf.basic_rates) - 1;
 
 legacy:
-	rateidx = mt76_calculate_default_rate(mphy, vif, rateidx);
+	if (band != NL80211_BAND_2GHZ)
+		offset = 4;
+
+	/* pick the lowest rate for hidden nodes */
+	if (rateidx < 0)
+		rateidx = 0;
+
+	rateidx += offset;
+	if (rateidx >= ARRAY_SIZE(mt76_rates))
+		rateidx = offset;
+
+	rateidx = mt76_rates[rateidx].hw_value;
 	mode = rateidx >> 8;
 	rateidx &= GENMASK(7, 0);
 out:
-- 
2.47.1


