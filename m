Return-Path: <linux-wireless+bounces-20157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9936A5BDFD
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0A616A589
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86D5238170;
	Tue, 11 Mar 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="YMFQgrQo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D422D4FE
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689410; cv=none; b=CgIKBSwCqCZrG38XOPRyrxw1VqL97maP75wJLs95V3oHj3Qk1LyGzEtj83UHGnf/pGLvEeGL0sGpXWUBX2CXd866LuGGWMcp9dzfborJJWzXrUU67zN9L9nNtQ3Vc5PxAzXFHw3jsYCP/L52+2hLOTC5QfaAvJrbdl6QgAhejgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689410; c=relaxed/simple;
	bh=FMod+Y06YQYawP5IdhxQO2Qb4UYR3XOvPcD5junq88g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ9zKelgA/Q/kuMzSdkpTVNroGNJqTyXbIVzfReXqs5xOylIqNc8Z1PHgjdhfobOajSF58eM8S6gkyXvEOqZvYU8/21pj1aWzLXoaK+OdCImpGC9rn29fyNSh+yCFzOzEkDnbEb9vdM/HQiE/ZC4PhfbVJ/jE7awFPyesqnBLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=YMFQgrQo; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ihyTzD7MFGuanbVO4dzWaUyTMuq9uBXI264Cmv8vAjU=; b=YMFQgrQoY8O8ODr30EBUt/8LcS
	JBgl9rtsubGeZNRsyDWEIojwfkMCfpHJUzxcVHYZqR/lcix4qqhhYLGL7+vPgFTPQF6FU6RavclDc
	jyKmHPUybeIocqvIK6lGDlGrzytv9KhGBs7eRNU7NEHcbWJ9Tgvqqc6nSTXLu1L1BA+M=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1trwyd-00Ftvh-1o
	for linux-wireless@vger.kernel.org;
	Tue, 11 Mar 2025 11:36:47 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 7/8] wifi: mt76: mt7996: implement driver specific get_txpower function
Date: Tue, 11 Mar 2025 11:36:44 +0100
Message-ID: <20250311103646.43346-7-nbd@nbd.name>
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

Fixes reporting tx power for vifs that don't have a channel context
assigned. Report the tx power of a phy that is covered by the vif's
radio mask.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 886b6ef3462b..89fc3f102555 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -602,6 +602,31 @@ static void mt7996_configure_filter(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static int
+mt7996_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif, int *dbm)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct wireless_dev *wdev;
+	int n_chains, delta, i;
+
+	if (!phy) {
+		wdev = ieee80211_vif_to_wdev(vif);
+		for (i = 0; i < hw->wiphy->n_radio; i++)
+			if (wdev->radio_mask & BIT(i))
+				phy = dev->radio_phy[i];
+
+		if (!phy)
+			return -EINVAL;
+	}
+
+	n_chains = hweight16(phy->mt76->chainmask);
+	delta = mt76_tx_power_nss_delta(n_chains);
+	*dbm = DIV_ROUND_UP(phy->mt76->txpower_cur + delta, 2);
+
+	return 0;
+}
 static u8
 mt7996_get_rates_table(struct mt7996_phy *phy, struct ieee80211_bss_conf *conf,
 		       bool beacon, bool mcast)
@@ -1651,7 +1676,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.remain_on_channel = mt76_remain_on_channel,
 	.cancel_remain_on_channel = mt76_cancel_remain_on_channel,
 	.release_buffered_frames = mt76_release_buffered_frames,
-	.get_txpower = mt76_get_txpower,
+	.get_txpower = mt7996_get_txpower,
 	.channel_switch_beacon = mt7996_channel_switch_beacon,
 	.get_stats = mt7996_get_stats,
 	.get_et_sset_count = mt7996_get_et_sset_count,
-- 
2.47.1


