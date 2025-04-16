Return-Path: <linux-wireless+bounces-21575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D6A8ACB5
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D71E440E6E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 00:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC09F1A2622;
	Wed, 16 Apr 2025 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="jf3lWFMT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DED1A8418
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763311; cv=none; b=hjE8hdHOaMAB/Ibo7F/Czjjm+WXrCAAmeXD/ZUxm9TBjgIc0EuYxdDyE9sYe5jTJvJVSTheZW0RtzKf8T5u2yJ2Mk/q9C4GGgrQ0tWjH4vDO0gfsa15PE3wyNx4MBG9pOx5BP6hAyKUT9UaeKac3o0TbaPjQj3zuq5kQKQLUH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763311; c=relaxed/simple;
	bh=LsYhTK9+zEG9TkN2q9f9lkedORqo5Do8dQEGJThRKII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMiFS7Jg8UDzYCSTvXtCYJA/XUxWy9/I8n0/Ch+Fo+KGNuLfsf+P+/RNBbXrkVcom9Rz/rD9gs8eoDLIUCuHefn1bn4ZGR104HE2NiKKpzNKR54l9Kvxx4tQFaqhBX5+6sln5KA5ZZ8+Q7d9UAEIePTpaIUvhtz2hxtMV6dt8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=jf3lWFMT; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.110.50.134])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1A93A600C2;
	Wed, 16 Apr 2025 00:28:23 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5976E80006B;
	Wed, 16 Apr 2025 00:28:20 +0000 (UTC)
Received: from carkeek.lan (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id AB45713C2B1;
	Tue, 15 Apr 2025 17:28:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AB45713C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1744763298;
	bh=LsYhTK9+zEG9TkN2q9f9lkedORqo5Do8dQEGJThRKII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jf3lWFMTaltz0uvkXgNhI3RE9Be58UzJk9K/2OWY++uQ8suubZkduPkSUF0WziQtY
	 if6Mph66Di5D1RcSK1sF5ywgShIh2F3MAuABRhvAQ9YCyJhyZKE+VVm1xj1xrGYvd5
	 A3oZhdigMNuzlA07agqVk9ZX4Yr6YNBkaLb0HH8A=
From: Rory Little <rory@candelatech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH 3/4] wifi: mt76: mt7996: Refactor of rx filter logic.
Date: Tue, 15 Apr 2025 17:26:16 -0700
Message-ID: <20250416002617.1328286-4-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250416002617.1328286-1-rory@candelatech.com>
References: <20250416002617.1328286-1-rory@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1744763302-GLnlPruyvcK4
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1744763302;GLnlPruyvcK4;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;

The existing logic for configuring the rx filter is hard to follow and
contained at least one sneaky bug: since mt7996_set_monitor(_, false) is
only called when a monitor is removed, MT_WF_RFCR_DROP_OTHER_UC would
not be configured on a fresh boot. This meant that the rxfilter was too
verbose until a monitor had been added and removed. This refactor hopes
to avoid sequence-of-action bugs like this by:

1. Placing all logic that directly alters the rx filter in one function,
   so that state does not need to be tracked across methods.
2. Explicitly tracking all values sent to the control registers within
   the radio phy, for easier debugging.
3. Realizing the rx filter control registers freshly every time that
   mt7996_phy_set_rxfilter() is called.

In order to perform goals (1) and (3), new state needed to be added
to the radio phy to remember the mac80211 rxfilter flags that had been
requested, and to track if the radio is acting as a monitor.

Since the existing MT76_FILTER macro could not handle all cases where
the rxfilter needs to be configured, it was not used here.

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Rory Little <rory@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  15 ++-
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 114 +++++++++---------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   7 +-
 3 files changed, 77 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index c16606792539..bb02878fd8a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -849,12 +849,14 @@ mt7996_rxfilter_show(struct seq_file *file, void *data)
 
 	mutex_lock(&phy->dev->mt76.mutex);
 
-	seq_printf(file, "CR: 0x%08x\n", phy->rxfilter);
+	seq_printf(file, "CR: 0x%08x\n", phy->rxfilter.cr);
 
-#define MT7996_RFCR_PRINT(flag) do {			\
-		if (phy->rxfilter & MT_WF_RFCR_##flag)	\
+#define __MT7996_RXFILTER_PRINT(reg, flag) do {		\
+		if (phy->rxfilter.reg & (flag))		\
 			seq_printf(file, #flag "\n");	\
 	} while (0)
+#define MT7996_RFCR_PRINT(flag) __MT7996_RXFILTER_PRINT(cr, MT_WF_RFCR_##flag)
+#define MT7996_RFCR1_PRINT(flag) __MT7996_RXFILTER_PRINT(cr1, MT_WF_RFCR1_##flag)
 
 	MT7996_RFCR_PRINT(DROP_STBC_MULTI);
 	MT7996_RFCR_PRINT(DROP_FCSFAIL);
@@ -877,6 +879,13 @@ mt7996_rxfilter_show(struct seq_file *file, void *data)
 	MT7996_RFCR_PRINT(DROP_NDPA);
 	MT7996_RFCR_PRINT(DROP_UNWANTED_CTL);
 
+	seq_printf(file, "\nCR1: 0x%08x\n", phy->rxfilter.cr1);
+	MT7996_RFCR1_PRINT(DROP_ACK);
+	MT7996_RFCR1_PRINT(DROP_BF_POLL);
+	MT7996_RFCR1_PRINT(DROP_BA);
+	MT7996_RFCR1_PRINT(DROP_CFEND);
+	MT7996_RFCR1_PRINT(DROP_CFACK);
+
 	mutex_unlock(&phy->dev->mt76.mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..cbc9826320a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -391,25 +391,60 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 static void mt7996_phy_set_rxfilter(struct mt7996_phy *phy)
 {
 	struct mt7996_dev *dev = phy->dev;
-	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
-			MT_WF_RFCR1_DROP_BF_POLL |
-			MT_WF_RFCR1_DROP_BA |
-			MT_WF_RFCR1_DROP_CFEND |
-			MT_WF_RFCR1_DROP_CFACK;
-	u32 filter = phy->rxfilter;
-
-	if (filter & MT_WF_RFCR_DROP_OTHER_UC) {
-		filter |= MT_WF_RFCR_DROP_CTS |
-			  MT_WF_RFCR_DROP_RTS |
-			  MT_WF_RFCR_DROP_CTL_RSV |
-			  MT_WF_RFCR_DROP_FCSFAIL;
-	}
+	u32 supported_flags = 0;
+
+	/* Initially reset the filter */
+	phy->rxfilter.cr = 0;
+	phy->rxfilter.cr1 = 0;
+
+	/* The following HW flags should never be set here:
+	 * MT_WF_RFCR_DROP_OTHER_BSS
+	 * MT_WF_RFCR_DROP_OTHER_BEACON
+	 * MT_WF_RFCR_DROP_FRAME_REPORT
+	 * MT_WF_RFCR_DROP_PROBEREQ
+	 * MT_WF_RFCR_DROP_MCAST_FILTERED
+	 * MT_WF_RFCR_DROP_MCAST
+	 * MT_WF_RFCR_DROP_BCAST
+	 * MT_WF_RFCR_DROP_DUPLICATE
+	 * MT_WF_RFCR_DROP_A2_BSSID
+	 * MT_WF_RFCR_DROP_UNWANTED_CTL
+	 * MT_WF_RFCR_DROP_STBC_MULTI
+	 */
 
-	mt76_wr(dev, MT_WF_RFCR(phy->mt76->band_idx), filter);
-	if (filter & MT_WF_RFCR_DROP_CTL_RSV)
-		mt76_set(dev, MT_WF_RFCR1(phy->mt76->band_idx), ctl_flags);
-	else
-		mt76_clear(dev, MT_WF_RFCR1(phy->mt76->band_idx), ctl_flags);
+	supported_flags |= FIF_OTHER_BSS;
+	if (!(phy->mac80211_rxfilter_flags & FIF_OTHER_BSS))
+		phy->rxfilter.cr |= MT_WF_RFCR_DROP_OTHER_TIM |
+				    MT_WF_RFCR_DROP_A3_MAC |
+				    MT_WF_RFCR_DROP_A3_BSSID;
+
+	supported_flags |= FIF_FCSFAIL;
+	if (!(phy->mac80211_rxfilter_flags & FIF_FCSFAIL))
+		phy->rxfilter.cr |= MT_WF_RFCR_DROP_FCSFAIL;
+
+	supported_flags |= FIF_CONTROL;
+	if (!(phy->mac80211_rxfilter_flags & FIF_CONTROL))
+		phy->rxfilter.cr |= MT_WF_RFCR_DROP_CTS |
+				    MT_WF_RFCR_DROP_RTS |
+				    MT_WF_RFCR_DROP_CTL_RSV;
+
+	if (!phy->monitor_enabled)
+		phy->rxfilter.cr |= MT_WF_RFCR_DROP_CTS |
+				    MT_WF_RFCR_DROP_RTS |
+				    MT_WF_RFCR_DROP_CTL_RSV |
+				    MT_WF_RFCR_DROP_FCSFAIL |
+				    MT_WF_RFCR_DROP_OTHER_UC;
+
+	if (!((phy->mac80211_rxfilter_flags & FIF_CONTROL) || phy->monitor_enabled))
+		phy->rxfilter.cr1 |= MT_WF_RFCR1_DROP_ACK |
+				     MT_WF_RFCR1_DROP_BF_POLL |
+				     MT_WF_RFCR1_DROP_BA |
+				     MT_WF_RFCR1_DROP_CFEND |
+				     MT_WF_RFCR1_DROP_CFACK;
+
+	phy->mac80211_rxfilter_flags &= supported_flags;
+
+	mt76_wr(dev, MT_WF_RFCR(phy->mt76->band_idx), phy->rxfilter.cr);
+	mt76_wr(dev, MT_WF_RFCR1(phy->mt76->band_idx), phy->rxfilter.cr1);
 }
 
 static void mt7996_set_monitor(struct mt7996_phy *phy, bool enabled)
@@ -419,13 +454,10 @@ static void mt7996_set_monitor(struct mt7996_phy *phy, bool enabled)
 	if (!phy)
 		return;
 
-	if (enabled == !(phy->rxfilter & MT_WF_RFCR_DROP_OTHER_UC))
+	if (enabled == phy->monitor_enabled)
 		return;
 
-	if (!enabled)
-		phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
-	else
-		phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+	phy->monitor_enabled = enabled;
 
 	mt76_rmw_field(dev, MT_DMA_DCR0(phy->mt76->band_idx),
 		       MT_DMA_DCR0_RXD_G5_EN, enabled);
@@ -620,46 +652,18 @@ static void mt7996_configure_filter(struct ieee80211_hw *hw,
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_phy *phy;
-	u32 filter_mask = 0, filter_set = 0;
 	u32 flags = 0;
 
-#define MT76_FILTER(_flag, _hw) do {				\
-		flags |= *total_flags & FIF_##_flag;		\
-		filter_mask |= (_hw);				\
-		filter_set |= !(flags & FIF_##_flag) * (_hw);	\
-	} while (0)
-
 	mutex_lock(&dev->mt76.mutex);
 
-	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
-			       MT_WF_RFCR_DROP_A3_MAC |
-			       MT_WF_RFCR_DROP_A3_BSSID);
-
-	MT76_FILTER(FCSFAIL, MT_WF_RFCR_DROP_FCSFAIL);
-
-	MT76_FILTER(CONTROL, MT_WF_RFCR_DROP_CTS |
-			     MT_WF_RFCR_DROP_RTS |
-			     MT_WF_RFCR_DROP_CTL_RSV);
-
-	*total_flags = flags;
-
 	mt7996_for_each_phy(dev, phy) {
-		phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
-				   MT_WF_RFCR_DROP_OTHER_BEACON |
-				   MT_WF_RFCR_DROP_FRAME_REPORT |
-				   MT_WF_RFCR_DROP_PROBEREQ |
-				   MT_WF_RFCR_DROP_MCAST_FILTERED |
-				   MT_WF_RFCR_DROP_MCAST |
-				   MT_WF_RFCR_DROP_BCAST |
-				   MT_WF_RFCR_DROP_DUPLICATE |
-				   MT_WF_RFCR_DROP_A2_BSSID |
-				   MT_WF_RFCR_DROP_UNWANTED_CTL |
-				   MT_WF_RFCR_DROP_STBC_MULTI |
-				   filter_mask);
-		phy->rxfilter |= filter_set;
+		phy->mac80211_rxfilter_flags = *total_flags;
 		mt7996_phy_set_rxfilter(phy);
+		flags |= phy->mac80211_rxfilter_flags;
 	}
 
+	*total_flags = flags;
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 3300b7c8e4d2..2b2108f96255 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -273,7 +273,12 @@ struct mt7996_phy {
 	u8 throttle_state;
 	u32 throttle_temp[2]; /* 0: critical high, 1: maximum */
 
-	u32 rxfilter;
+	bool monitor_enabled;
+	u32 mac80211_rxfilter_flags;
+	struct {
+		u32 cr;
+		u32 cr1;
+	} rxfilter; /* Rx filter control registers */
 	u64 omac_mask;
 
 	u16 noise;
-- 
2.48.1


