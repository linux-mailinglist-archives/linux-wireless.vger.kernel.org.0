Return-Path: <linux-wireless+bounces-2701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB788412E7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBB41F22126
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA7914290;
	Mon, 29 Jan 2024 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PJUyd6r9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8714A82
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554807; cv=none; b=s61iMl9M7DAh3XcdHLnmQJoR6QOsAstjhJwE3wL6lIlJMv9pxbjbiv4hHC5rsfBdTmsfSfs5tw4VVy1t4zb6wQ5ZRniKb7szbSVZiUyPvZ9/Wy8IMWC8Ja8ELwvK+a72M8UDshcQsRW/iX8QTJxJC0tSmoQDyMY4sIZFcTFhex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554807; c=relaxed/simple;
	bh=v1jeP6wlqAY0U8uxno479RdkhIFT961QELGnKeQkWg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nw03kGoHkOBU0U+SgkkhzOIsac9hbuGGzbSUbTBG/dX6KLX2/kFG5eYs/dFkwazkA6Ybi7p8CiK0yKg8W9e2XY97X3GB8cI52JO5BoWBgTNO7JRNNfxps3ZpxWbDltlCT6DospdBfzVDzMK3xznkhNZB3rHualrRFpuPUSSLAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PJUyd6r9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2wv5ljzdRUSplEsDKXpfy07z5y5FNpPHK8aKaXdxZPU=; t=1706554806; x=1707764406; 
	b=PJUyd6r9sw1my8XDz7eUep6IuIcW0c6m+4bCHLDO/Y0El1TAvVYjtqxupQIOqZ5c9RLBAYEW/ds
	ZHMBQfoDPw0nlLiqVhNqx9v/cEb3KygQLfO+iwRFq6KaZda/hWzF0xKVRZBxF3eFwxMfQ4D5ZRLsF
	3ajYhkNIOrLUYr1FZJx/m5NqvCUmnk+bHdhf20DdtMWHKRr7epsX/BmsVD6eNbe1xJN5VqmcKGXi1
	JBgU6pBIfY6OsmllZ99PshW5LDgEQXHCoKBhIW5/DHhjlxyc/pzXHcsvj3DXlV1+JJxFXlrHfeRDN
	av8qijPUjp6z7OhSREWxTd6g9otVdG6/Edyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWrT-00000004zwF-2k0U;
	Mon, 29 Jan 2024 20:00:03 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211_hwsim: add control to skip beacons
Date: Mon, 29 Jan 2024 20:00:02 +0100
Message-ID: <20240129200001.a267383709e6.I36f427d17c3478a7df46e205716f5ebc9b35a918@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

To test certain beacon loss scenarios it can be useful to
simply not send a couple of beacons. Add a simple debugfs
file (per vif) to skip sending the beacons. They're still
fully prepared etc. so their DTIM count etc. will appear
as if they were simply corrupt over the air or otherwise
not received.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 62a5839f5385..59ec6aa5ac26 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -213,6 +213,7 @@ static const struct ieee80211_regdomain *hwsim_world_regdom_custom[] = {
 
 struct hwsim_vif_priv {
 	u32 magic;
+	u32 skip_beacons;
 	u8 bssid[ETH_ALEN];
 	bool assoc;
 	bool bcn_en;
@@ -2128,6 +2129,16 @@ static int mac80211_hwsim_add_interface(struct ieee80211_hw *hw,
 	return 0;
 }
 
+#ifdef CONFIG_MAC80211_DEBUGFS
+static void mac80211_hwsim_vif_add_debugfs(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
+
+	debugfs_create_u32("skip_beacons", 0600, vif->debugfs_dir,
+			   &vp->skip_beacons);
+}
+#endif
 
 static int mac80211_hwsim_change_interface(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
@@ -2193,12 +2204,19 @@ static void __mac80211_hwsim_beacon_tx(struct ieee80211_bss_conf *link_conf,
 				       struct ieee80211_vif *vif,
 				       struct sk_buff *skb)
 {
+	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_rate *txrate;
 	struct ieee80211_mgmt *mgmt;
 	/* TODO: get MCS */
 	int bitrate = 100;
 
+	if (vp->skip_beacons) {
+		vp->skip_beacons--;
+		dev_kfree_skb(skb);
+		return;
+	}
+
 	info = IEEE80211_SKB_CB(skb);
 	if (ieee80211_hw_check(hw, SUPPORTS_RC_TABLE))
 		ieee80211_get_tx_rates(vif, NULL, skb,
@@ -3857,6 +3875,13 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 	return err;
 }
 
+#ifdef CONFIG_MAC80211_DEBUGFS
+#define HWSIM_DEBUGFS_OPS					\
+	.vif_add_debugfs = mac80211_hwsim_vif_add_debugfs,
+#else
+#define HWSIM_DEBUGFS_OPS
+#endif
+
 #define HWSIM_COMMON_OPS					\
 	.tx = mac80211_hwsim_tx,				\
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,	\
@@ -3881,7 +3906,8 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 	.get_et_stats = mac80211_hwsim_get_et_stats,		\
 	.get_et_strings = mac80211_hwsim_get_et_strings,	\
 	.start_pmsr = mac80211_hwsim_start_pmsr,		\
-	.abort_pmsr = mac80211_hwsim_abort_pmsr,
+	.abort_pmsr = mac80211_hwsim_abort_pmsr,		\
+	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
 	.sta_add = mac80211_hwsim_sta_add,			\
-- 
2.43.0


