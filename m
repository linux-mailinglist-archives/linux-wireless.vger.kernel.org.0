Return-Path: <linux-wireless+bounces-26689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4219B37EC9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 11:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3C47AC851
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9646345747;
	Wed, 27 Aug 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="k32W/tb4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5C343D7E
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286767; cv=none; b=RORyOOgPoyncj9PGTAIZ4ZIU93nwWqFebE1zBvmHL5zV46rFYMDlln1dXCVv7JUlabnVSVg9a26IO1iTte3T8+NRufX1eG7ykAq+cxbb2LEvOgWAVcQ3lKbXTKRghUBlpRF82R14jk8ILKbVgW5wCtwsHhbNTJtFHVFep5GLW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286767; c=relaxed/simple;
	bh=8gnDW77ryAIJLGL7rtFqnzIhfO01V9Eh1Pav/Q1v0j4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlUSFcwz6cJuuRUI1q7prTlpReROFUcfxtpwDYtCo+E28J7KKTavsdzUFQHLBpeQ12sUAuiWUjekpteLgrfBFxdGInm9+EhcP+1qUzkz5ZnMm2RD2hQIj2MoJBovQweW60+XZ0uugdtpg0CubPeWgq5TioXauW4X9UC6WFbxNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=k32W/tb4; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RbCJDO5qhfijMdOH4Xwb2AsALsAtJaU8RB9a6jtuHf0=; b=k32W/tb4gTPQHQ6HUWefQFW0lA
	anbDH5515Nfke6pvUKByTBdvRVyiFua5OdzhFHgHfaRa2KbYotvzYq9M5H7MK5uDUhr2wg5G+TiiY
	VuXvBlXHkfKyEKYi0J9eTK05oOyWsS/Rom1RYv7ctS8gc2ReRXJ7rE/1GTosoTsFPjeA=;
Received: from tmo-087-176.customers.d1-online.com ([80.187.87.176] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1urBum-00Fn6z-0M
	for linux-wireless@vger.kernel.org;
	Wed, 27 Aug 2025 10:53:56 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 4/6] wifi: mt76: mt7915: fix list corruption after hardware restart
Date: Wed, 27 Aug 2025 10:53:50 +0200
Message-ID: <20250827085352.51636-4-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827085352.51636-1-nbd@nbd.name>
References: <20250827085352.51636-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since stations are recreated from scratch, all lists that wcids are added
to must be cleared before calling ieee80211_restart_hw.
Set wcid->sta = 0 for each wcid entry in order to ensure that they are
not added again before they are ready.

Fixes: 8a55712d124f ("wifi: mt76: mt7915: enable full system reset support")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 37 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 12 +++---
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 6b2641a9ae9a..0e0d7b3bfe42 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -818,6 +818,43 @@ void mt76_free_device(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_free_device);
 
+static void mt76_reset_phy(struct mt76_phy *phy)
+{
+	if (!phy)
+		return;
+
+	INIT_LIST_HEAD(&phy->tx_list);
+}
+
+void mt76_reset_device(struct mt76_dev *dev)
+{
+	int i;
+
+	rcu_read_lock();
+	for (i = 0; i < ARRAY_SIZE(dev->wcid); i++) {
+		struct mt76_wcid *wcid;
+
+		wcid = rcu_dereference(dev->wcid[i]);
+		if (!wcid)
+			continue;
+
+		wcid->sta = 0;
+		mt76_wcid_cleanup(dev, wcid);
+		rcu_assign_pointer(dev->wcid[i], NULL);
+	}
+	rcu_read_unlock();
+
+	INIT_LIST_HEAD(&dev->wcid_list);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	dev->vif_mask = 0;
+	memset(dev->wcid_mask, 0, sizeof(dev->wcid_mask));
+
+	mt76_reset_phy(&dev->phy);
+	for (i = 0; i < ARRAY_SIZE(dev->phys); i++)
+		mt76_reset_phy(dev->phys[i]);
+}
+EXPORT_SYMBOL_GPL(mt76_reset_device);
+
 struct mt76_phy *mt76_vif_phy(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index febe1dcb8d19..5c71226c8607 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1247,6 +1247,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 			 struct ieee80211_rate *rates, int n_rates);
 void mt76_unregister_device(struct mt76_dev *dev);
 void mt76_free_device(struct mt76_dev *dev);
+void mt76_reset_device(struct mt76_dev *dev);
 void mt76_unregister_phy(struct mt76_phy *phy);
 
 struct mt76_phy *mt76_alloc_radio_phy(struct mt76_dev *dev, unsigned int size,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 09c92e4ae129..5da7bb90e209 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1460,17 +1460,15 @@ mt7915_mac_full_reset(struct mt7915_dev *dev)
 	if (i == 10)
 		dev_err(dev->mt76.dev, "chip full reset failed\n");
 
-	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	while (!list_empty(&dev->mt76.sta_poll_list))
-		list_del_init(dev->mt76.sta_poll_list.next);
-	spin_unlock_bh(&dev->mt76.sta_poll_lock);
-
-	memset(dev->mt76.wcid_mask, 0, sizeof(dev->mt76.wcid_mask));
-	dev->mt76.vif_mask = 0;
 	dev->phy.omac_mask = 0;
 	if (phy2)
 		phy2->omac_mask = 0;
 
+	mt76_reset_device(&dev->mt76);
+
+	INIT_LIST_HEAD(&dev->sta_rc_list);
+	INIT_LIST_HEAD(&dev->twt_list);
+
 	i = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
 	dev->mt76.global_wcid.idx = i;
 	dev->recovery.hw_full_reset = false;
-- 
2.51.0


