Return-Path: <linux-wireless+bounces-4468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E31F875728
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 20:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2FE6B2105C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D24136664;
	Thu,  7 Mar 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="RH6/ZbNu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5E135A6E
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839803; cv=none; b=OQEgzJLLPbVyXq5+9AValFuBRDaGpC6lMFSyMiAUq711Alm235mkkzZfWNR/Yh/6LhmO4KcWqDdyLcgOzA9OIWgQyE9XMhfI/hFx3ttyrNp+FFHw8bd0Gwap6HWaoLkO/e093niT3+Ee1w4i25MXbLwRwykWKlgHjnyaviiDAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839803; c=relaxed/simple;
	bh=WnWuViE8lVO5WJHNpH2NzOz3slYNxvA/iborrhEmiww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imdj1AFdE8WX7LefZ3BGW6Uhj6Lod6FpR39yvOmfNy6h1oYCLKWXr9vNpgzMOMu9YeECoMKIxNJjq/2wk68lhqtStUYxihsdEu75O6TFAjJHJwykLwX0fXWK3F+FlIV2eXdtNAm55s+yC1N8QnutaZC2BeNqggd7j1G7UDt1GoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=RH6/ZbNu; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D744F600091
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:29:59 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 4972A13C2B5;
	Thu,  7 Mar 2024 11:29:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4972A13C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709839799;
	bh=WnWuViE8lVO5WJHNpH2NzOz3slYNxvA/iborrhEmiww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RH6/ZbNuZ1rpKOj8PetOzMS7Vfez9Cmur7Rbqmrh7kz3kM5HadgQwDM1FPDZIqiGY
	 Gh1NTCqAQOX+2Wh9edyCEJwmBedFEm+rDOogw9S+H3Ra9vJiKzQD4xgCjIxteBXKcw
	 Jy66ZeeMyl1pEHBBFzE4KbnYIyJsvWjZ2GNMv9Lg=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 6/6] wifi: mt76: mt7996: Allow ignoring radar events.
Date: Thu,  7 Mar 2024 11:29:51 -0800
Message-ID: <20240307192951.3271156-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240307192951.3271156-1-greearb@candelatech.com>
References: <20240307192951.3271156-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1709839800-Tlxa4G4JDBfk
X-MDID-O:
 us5;ut7;1709839800;Tlxa4G4JDBfk;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Useful for testing.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 14 ++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  1 +
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 9bd953586b04..39008274b493 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -806,6 +806,8 @@ int mt7996_init_debugfs(struct mt7996_phy *phy)
 	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
 				    mt7996_twt_stats);
 	debugfs_create_file("rf_regval", 0600, dir, dev, &fops_rf_regval);
+	debugfs_create_u32("ignore_radar", 0600, dir,
+			   &dev->ignore_radar);
 
 	if (phy->mt76->cap.has_5ghz) {
 		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 77c89d2d2423..c31fd2ea18ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -391,12 +391,14 @@ mt7996_mcu_rx_radar_detected(struct mt7996_dev *dev, struct sk_buff *skb)
 	if (!mphy)
 		return;
 
-	if (r->band_idx == MT_RX_SEL2)
-		cfg80211_background_radar_event(mphy->hw->wiphy,
-						&dev->rdd2_chandef,
-						GFP_ATOMIC);
-	else
-		ieee80211_radar_detected(mphy->hw);
+	if (!dev->ignore_radar) {
+		if (r->band_idx == MT_RX_SEL2)
+			cfg80211_background_radar_event(mphy->hw->wiphy,
+							&dev->rdd2_chandef,
+							GFP_ATOMIC);
+		else
+			ieee80211_radar_detected(mphy->hw);
+	}
 	dev->hw_pattern++;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index bc73bcb47bf0..8b5eb6e3807f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -286,6 +286,7 @@ struct mt7996_dev {
 	struct list_head twt_list;
 
 	u32 hw_pattern;
+	u32 ignore_radar; /* skip propagating up the stack, for debugging */
 
 	bool flash_mode:1;
 	bool has_eht:1;
-- 
2.42.0


