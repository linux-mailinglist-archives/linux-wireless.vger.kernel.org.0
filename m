Return-Path: <linux-wireless+bounces-16913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D29FEA63
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB473A2A16
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C5191F74;
	Mon, 30 Dec 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="bx5oLf0J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB351991BF
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587734; cv=none; b=DZ8lMD6Frb/ZHpj4oZCL8eZwcf4pPmtI/PdBu0D1yTidyWQ2TeG1MgZyc1+rU1tvQBn5b669cv9PhB9o9Vhr2Y6TExHnzwO0ipdI9mZ1piVT7dEbyulNcQXCCzVfMCgw+IPmn+ElL87e84PCLkWwYB1XO+J4SwajKq0j+bX/aOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587734; c=relaxed/simple;
	bh=WsscW/3nELUKmY/+l2I/hqoIXHVmF/gN4+npd96N8Ms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMTN28WaxZqz9eZlxgAjS3LcYj0nBfeKRygKKnEoI/gXkbGL+xPc0CfeR1YImUVRVON2FP38x1kXJls1XI0B94F0uc6UgD1R2l2JAjqXzkyykIY1o5taHTHNRi3J4mkzrYooTW5SOTqmK4u83W1C1ZktEOmbEKTrrXQbBAtpXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=bx5oLf0J; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cFAhxM8hwqKJsT6UDCNCvVdBG2oWL0m0pc2iTup7+IQ=; b=bx5oLf0Jl7dYl1A+UMXBxQJMsW
	FJF9wChAuThFh/4xDJ6OpWyMC3rkSEYu11zeq5q+P9YL224thjzrx57EPP+vo9XpzlYT1M5eK+rXd
	RI6laNripa0atMdgfW17n8j0qdtZd57pva3EnlINTZqRJqdRaLV+6L1q/9w5QQuYmz0w=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeU-00GKzc-2d
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:10 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 09/14] wifi: mt76: mt7915: ensure that only one sta entry is active per mac address
Date: Mon, 30 Dec 2024 20:41:57 +0100
Message-ID: <20241230194202.95065-9-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230194202.95065-1-nbd@nbd.name>
References: <20241230194202.95065-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a client is roaming to a different AP interface, a duplicate wtbl entry
can be created. This can lead to lost packets or aggregation issues until
the old entry expires.
In order to fix this issue, delete any conflicting entries from WTBL
whenever a station is authorized.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 58 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2d4457fbb5ab..fd337aede99e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -368,8 +368,12 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	int idx = key->keyidx;
 	int err = 0;
 
-	if (sta && !wcid->sta)
+	if (sta && !wcid->sta) {
+		if (cmd != SET_KEY)
+			return 0;
+
 		return -EOPNOTSUPP;
+	}
 
 	/* The hardware does not support per-STA RX GTK, fallback
 	 * to software mode for these.
@@ -765,6 +769,57 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	return 0;
 }
 
+struct drop_sta_iter {
+	struct mt7915_dev *dev;
+	struct ieee80211_hw *hw;
+	struct ieee80211_vif *vif;
+	u8 sta_addr[ETH_ALEN];
+};
+
+static void
+__mt7915_drop_sta(void *ptr, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct drop_sta_iter *data = ptr;
+	struct ieee80211_sta *sta;
+	struct mt7915_sta *msta;
+
+	if (vif == data->vif || vif->type != NL80211_IFTYPE_AP)
+		return;
+
+	sta = ieee80211_find_sta_by_ifaddr(data->hw, data->sta_addr, mac);
+	if (!sta)
+		return;
+
+	msta = (struct mt7915_sta *)sta->drv_priv;
+	mt7915_mcu_add_sta(data->dev, vif, sta, CONN_STATE_DISCONNECT, false);
+	msta->wcid.sta_disabled = 1;
+	msta->wcid.sta = 0;
+}
+
+static void
+mt7915_drop_other_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+		      struct ieee80211_sta *sta)
+{
+	struct mt76_phy *ext_phy = dev->mt76.phys[MT_BAND1];
+	struct drop_sta_iter data = {
+		.dev = dev,
+		.hw = dev->mphy.hw,
+		.vif = vif,
+	};
+
+	if (vif->type != NL80211_IFTYPE_AP)
+		return;
+
+	memcpy(data.sta_addr, sta->addr, ETH_ALEN);
+	ieee80211_iterate_active_interfaces(data.hw, 0, __mt7915_drop_sta, &data);
+
+	if (!ext_phy)
+		return;
+
+	data.hw = ext_phy->hw;
+	ieee80211_iterate_active_interfaces(data.hw, 0, __mt7915_drop_sta, &data);
+}
+
 int mt7915_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta, enum mt76_sta_event ev)
 {
@@ -793,6 +848,7 @@ int mt7915_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		return 0;
 
 	case MT76_STA_EVENT_AUTHORIZE:
+		mt7915_drop_other_sta(dev, vif, sta);
 		return mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_PORT_SECURE, false);
 
 	case MT76_STA_EVENT_DISASSOC:
-- 
2.47.1


