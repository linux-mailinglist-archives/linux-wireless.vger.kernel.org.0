Return-Path: <linux-wireless+bounces-20158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C732A5BDFE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D15616F844
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE413238D3B;
	Tue, 11 Mar 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="jP2pKUti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6422FF42
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689410; cv=none; b=O/ppiFQOo9FFqGcQWaZKJY5CZC69xrvPe0bn67xRrxmUtYkT9egH346yT8swBPlV/fVBFkd7wfsTKJv+yTzJatQQ9GdD0AQDDWXJWZ9ZkTE6+EOpL4g2M75oHHD5s8RlkOBfDgyRuVofDBleAyg5x9cxqiJObLPTgSzVw2VQAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689410; c=relaxed/simple;
	bh=Ql3jeD299hUpA6PDCI9+FXsbclI7ZNRKOBRaJ22HgUw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tomJxn95SUXBx9iZjTYb5TFMpozRzg3l4dCh2//rLrqcKwJytCBUEpWd010d9t7dJMKPn0jKnMjG44jLzr4u03o3uxS/+MQba3y9+yoJSwtFaKhd2L29jKqW3TMg/9KGFgkEqE91PLLYAnUi0EFJjbYz4ps+l4UxhgLGiOvWMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=jP2pKUti; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1R31MJGxdLJcun7W2dd3/KH41YsNm43S7N1AglG/HFY=; b=jP2pKUtixnSEeDb5aJtkz1oUyU
	j1ys4zMsO8gKx6z1MU5xzl8BIvyX7YmupfFb012eVb0RmYoSo8cNtRhComnom6AI1rLlNlFTrtthn
	ttk5TwA2iQhmZ7n9asBAD1FHezOW6ktAEmu8uU6aJjEq8wPoL3lfOyPYvTrgugaPjaek=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1trwyd-00Ftvh-2P
	for linux-wireless@vger.kernel.org;
	Tue, 11 Mar 2025 11:36:47 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 8/8] wifi: mt76: scan: fix setting tx_info fields
Date: Tue, 11 Mar 2025 11:36:45 +0100
Message-ID: <20250311103646.43346-8-nbd@nbd.name>
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

ieee80211_tx_prepare_skb initializes the skb cb, so fields need to be set
afterwards.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/scan.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 1c4f9deaaada..9b20ccbeb8cf 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -52,11 +52,6 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
 		ether_addr_copy(hdr->addr3, req->bssid);
 	}
 
-	info = IEEE80211_SKB_CB(skb);
-	if (req->no_cck)
-		info->flags |= IEEE80211_TX_CTL_NO_CCK_RATE;
-	info->control.flags |= IEEE80211_TX_CTRL_DONT_USE_RATE_MASK;
-
 	if (req->ie_len)
 		skb_put_data(skb, req->ie, req->ie_len);
 
@@ -64,10 +59,20 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 
 	rcu_read_lock();
-	if (ieee80211_tx_prepare_skb(phy->hw, vif, skb, band, NULL))
-		mt76_tx(phy, NULL, mvif->wcid, skb);
-	else
+
+	if (!ieee80211_tx_prepare_skb(phy->hw, vif, skb, band, NULL)) {
 		ieee80211_free_txskb(phy->hw, skb);
+		goto out;
+	}
+
+	info = IEEE80211_SKB_CB(skb);
+	if (req->no_cck)
+		info->flags |= IEEE80211_TX_CTL_NO_CCK_RATE;
+	info->control.flags |= IEEE80211_TX_CTRL_DONT_USE_RATE_MASK;
+
+	mt76_tx(phy, NULL, mvif->wcid, skb);
+
+out:
 	rcu_read_unlock();
 }
 
-- 
2.47.1


