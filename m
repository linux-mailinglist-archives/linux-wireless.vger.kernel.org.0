Return-Path: <linux-wireless+bounces-17812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01999A189D7
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 03:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D6D188B0E7
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 02:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FBA2E628;
	Wed, 22 Jan 2025 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="m+FRXTs5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE91145A05;
	Wed, 22 Jan 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737512567; cv=none; b=SbPwG0J8sDEMy13azxTv5m11oVqW1eKYiRot+BdIvJ8HBqHz090ZneHpEpjrPseQsZdJsXck2/9MQSEamDImabGCqd4pSO36Kh1J77Ah3f01VaIfFUrJeHvMYMNpeiHrdCrrWTs7KrmQv0Hsc5+CuQSikUVvMmfY1qPDG/G6OOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737512567; c=relaxed/simple;
	bh=6VIUdM5Tg+/W8PXINQvbJb2UuMReiLTQyJhk4mx55oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UA0ae0vgo+BkNr0mZbkVm9c+N9OLKap9+76uO62z6z6DOJM2W7l8PDR1lLiyj8NqIzwYxnzeHly7CTB9FMPhk2CGxsSrW8M9fHXOhlIPIooUg/qK45mziAID7jtwWlr7Ag+Wc13Ih19rw/7QKAii7ikwLF0R9GyZcC9j3R7gM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=m+FRXTs5; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=cJDs44l7FOIhekBJMpGxopfrdTVZNC5rMy41b9aO/AM=; b=m+FRXTs5VEr/7IyZ
	mUXRZmUgsI/0+NoB+s/VKZ9tKXLmRbUPF05foJWI2gxbA8u++DPv7TkjfiMxmSXk10BY3CQNI58O/
	Z7KpiZaspvLrRE6TH5NrPTUN2KwehbLf3ghOdsQCgMW4fovQCFd+IonV8HI+faEo1+Dzff2TyF8B+
	mQiHxJbVwv313dlCfmj2U/+atJr/gjM6H973AjJqnPSqMVMC5gvEtItjX/D0Crb3fuyB4CKZdeebY
	SOExISgI4B00HxvVr1iJqA6sw14m/OA0gh8d9BBHebhZal6J+ij3FpVsTOAxXltSz5ntpOnSZwNG5
	xyNa8tasCZGg0/JY7Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1taQO9-00BPQB-02;
	Wed, 22 Jan 2025 02:22:41 +0000
From: linux@treblig.org
To: stas.yakovlev@gmail.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] wifi: ipw2x00: Remove unused libipw_rx_any
Date: Wed, 22 Jan 2025 02:22:40 +0000
Message-ID: <20250122022240.456198-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

libipw_rx_any() was added in 2006 by
commit 1a995b45a528 ("[PATCH] ieee80211_rx_any: filter out packets, call
ieee80211_rx or ieee80211_rx_mgt")
as ieee80211_rx_any but is currently unused and I can't find any
sign it was used under either name,

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/intel/ipw2x00/libipw.h   |  2 -
 .../net/wireless/intel/ipw2x00/libipw_rx.c    | 91 -------------------
 2 files changed, 93 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw.h b/drivers/net/wireless/intel/ipw2x00/libipw.h
index 3c20353e5a41..e031e8692ca6 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw.h
+++ b/drivers/net/wireless/intel/ipw2x00/libipw.h
@@ -1011,8 +1011,6 @@ netdev_tx_t libipw_xmit(struct sk_buff *skb, struct net_device *dev);
 void libipw_txb_free(struct libipw_txb *);
 
 /* libipw_rx.c */
-void libipw_rx_any(struct libipw_device *ieee, struct sk_buff *skb,
-		   struct libipw_rx_stats *stats);
 int libipw_rx(struct libipw_device *ieee, struct sk_buff *skb,
 	      struct libipw_rx_stats *rx_stats);
 /* make sure to set stats->len */
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index dc4e91f58bb4..b7bc94f7abd8 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -823,96 +823,6 @@ int libipw_rx(struct libipw_device *ieee, struct sk_buff *skb,
 	return 0;
 }
 
-/* Filter out unrelated packets, call libipw_rx[_mgt]
- * This function takes over the skb, it should not be used again after calling
- * this function. */
-void libipw_rx_any(struct libipw_device *ieee,
-		     struct sk_buff *skb, struct libipw_rx_stats *stats)
-{
-	struct libipw_hdr_4addr *hdr;
-	int is_packet_for_us;
-	u16 fc;
-
-	if (ieee->iw_mode == IW_MODE_MONITOR) {
-		if (!libipw_rx(ieee, skb, stats))
-			dev_kfree_skb_irq(skb);
-		return;
-	}
-
-	if (skb->len < sizeof(struct ieee80211_hdr))
-		goto drop_free;
-
-	hdr = (struct libipw_hdr_4addr *)skb->data;
-	fc = le16_to_cpu(hdr->frame_ctl);
-
-	if ((fc & IEEE80211_FCTL_VERS) != 0)
-		goto drop_free;
-
-	switch (fc & IEEE80211_FCTL_FTYPE) {
-	case IEEE80211_FTYPE_MGMT:
-		if (skb->len < sizeof(struct libipw_hdr_3addr))
-			goto drop_free;
-		libipw_rx_mgt(ieee, hdr, stats);
-		dev_kfree_skb_irq(skb);
-		return;
-	case IEEE80211_FTYPE_DATA:
-		break;
-	case IEEE80211_FTYPE_CTL:
-		return;
-	default:
-		return;
-	}
-
-	is_packet_for_us = 0;
-	switch (ieee->iw_mode) {
-	case IW_MODE_ADHOC:
-		/* our BSS and not from/to DS */
-		if (ether_addr_equal(hdr->addr3, ieee->bssid) &&
-		    ((fc & (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == 0)) {
-			/* promisc: get all */
-			if (ieee->dev->flags & IFF_PROMISC)
-				is_packet_for_us = 1;
-			/* to us */
-			else if (ether_addr_equal(hdr->addr1, ieee->dev->dev_addr))
-				is_packet_for_us = 1;
-			/* mcast */
-			else if (is_multicast_ether_addr(hdr->addr1))
-				is_packet_for_us = 1;
-		}
-		break;
-	case IW_MODE_INFRA:
-		/* our BSS (== from our AP) and from DS */
-		if (ether_addr_equal(hdr->addr2, ieee->bssid) &&
-		    ((fc & (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == IEEE80211_FCTL_FROMDS)) {
-			/* promisc: get all */
-			if (ieee->dev->flags & IFF_PROMISC)
-				is_packet_for_us = 1;
-			/* to us */
-			else if (ether_addr_equal(hdr->addr1, ieee->dev->dev_addr))
-				is_packet_for_us = 1;
-			/* mcast */
-			else if (is_multicast_ether_addr(hdr->addr1)) {
-				/* not our own packet bcasted from AP */
-				if (!ether_addr_equal(hdr->addr3, ieee->dev->dev_addr))
-					is_packet_for_us = 1;
-			}
-		}
-		break;
-	default:
-		/* ? */
-		break;
-	}
-
-	if (is_packet_for_us)
-		if (!libipw_rx(ieee, skb, stats))
-			dev_kfree_skb_irq(skb);
-	return;
-
-drop_free:
-	dev_kfree_skb_irq(skb);
-	ieee->dev->stats.rx_dropped++;
-}
-
 #define MGMT_FRAME_FIXED_PART_LENGTH		0x24
 
 static u8 qos_oui[QOS_OUI_LEN] = { 0x00, 0x50, 0xF2 };
@@ -1729,6 +1639,5 @@ void libipw_rx_mgt(struct libipw_device *ieee,
 	}
 }
 
-EXPORT_SYMBOL_GPL(libipw_rx_any);
 EXPORT_SYMBOL(libipw_rx_mgt);
 EXPORT_SYMBOL(libipw_rx);
-- 
2.48.1


