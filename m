Return-Path: <linux-wireless+bounces-4846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9124A87EE0C
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15C91C21626
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8432554F96;
	Mon, 18 Mar 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpUSFK2F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D6554F89
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780831; cv=none; b=cjw8ux3RKSNpXevNj3PePmvvIGwNdEwftZ7JOaUAiduGkIi94e815AyRxXPphsjmGJE9sXFrfKadFCa/3o7Ri54JSZCUOBSHnI0+Ht3HPtgpnOC3HuVrgG5aIJ/7s8ZOD5PWzaNd7XMttDmAT4GWJ0a1vzpYwa56VTl7eEt4GLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780831; c=relaxed/simple;
	bh=DSFVFhEr2+mbVFAVWO4MV0D9SQo/onwUSVw3aRWeXC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCweEe0ZtqD3lwi1K7kU+R8Hm1EOwcmo1gvRL0wOORZhrN7CReAbXTJXSYXmCjHO/08weKjEJf1HvvqM+oLaY+oNcyfkPY1PPx8GdHZAtYBiP/yHcpz5xkSNaDfOpUEpeqIVQc50c8ayAN4kubnQ87AZGfgfX8ul/UnvEfeLPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpUSFK2F; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780830; x=1742316830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DSFVFhEr2+mbVFAVWO4MV0D9SQo/onwUSVw3aRWeXC0=;
  b=YpUSFK2FZtRGxTFvX7+gMvET9eF4XCfBz7QU9Cshw/zMorssCeopO8rJ
   NwhiQMgGkpBKhJaDOpDtVduFJ0+0ydsFb2A1LBDQS0MW+r2SqPWf9c74U
   xk6BRG0iwwcEjyOnU+LHBp/UfU3VToD3s0+Sqdbeq2pkNEx2ynisFinH6
   WJDZHpwITbj4u3/6F1y08DvOPzjd7gMFEzRizyqXk9FXvLI9WSIDj4n1h
   5BNDlOYUdJvATdBBqJ3TBAGBg4ggTy/AXCSn/9q0tOs/jzUE00LDLw1i6
   LCjDIOuGag22iJ7NOHbcStEB8ohxYee99d50FQhyEJrudouCs8l/344Fu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819385"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819385"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909772"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/15] wifi: mac80211_hwsim: move skip_beacons to be per link
Date: Mon, 18 Mar 2024 18:53:19 +0200
Message-Id: <20240318184907.8b6691bd70eb.If8a28b893d277254906601065e4aaefa704b6fcb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
References: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Initially, we were only using this for non-MLO, but it could
also be useful for MLO, and if we move it to per-link and the
vif isn't an MLD, it'll be put in the same place (by mac80211)
anyway. Move it to be per link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index b55fe320633c..450913cf6583 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -216,7 +216,7 @@ static const struct ieee80211_regdomain *hwsim_world_regdom_custom[] = {
 
 struct hwsim_vif_priv {
 	u32 magic;
-	u32 skip_beacons;
+	u32 skip_beacons[IEEE80211_MLD_MAX_NUM_LINKS];
 	u8 bssid[ETH_ALEN];
 	bool assoc;
 	bool bcn_en;
@@ -2133,13 +2133,16 @@ static int mac80211_hwsim_add_interface(struct ieee80211_hw *hw,
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-static void mac80211_hwsim_vif_add_debugfs(struct ieee80211_hw *hw,
-					   struct ieee80211_vif *vif)
+static void
+mac80211_hwsim_link_add_debugfs(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link_conf,
+				struct dentry *dir)
 {
 	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
 
-	debugfs_create_u32("skip_beacons", 0600, vif->debugfs_dir,
-			   &vp->skip_beacons);
+	debugfs_create_u32("skip_beacons", 0600, dir,
+			   &vp->skip_beacons[link_conf->link_id]);
 }
 #endif
 
@@ -2214,8 +2217,8 @@ static void __mac80211_hwsim_beacon_tx(struct ieee80211_bss_conf *link_conf,
 	/* TODO: get MCS */
 	int bitrate = 100;
 
-	if (vp->skip_beacons) {
-		vp->skip_beacons--;
+	if (vp->skip_beacons[link_conf->link_id]) {
+		vp->skip_beacons[link_conf->link_id]--;
 		dev_kfree_skb(skb);
 		return;
 	}
@@ -3922,7 +3925,7 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 #define HWSIM_DEBUGFS_OPS					\
-	.vif_add_debugfs = mac80211_hwsim_vif_add_debugfs,
+	.link_add_debugfs = mac80211_hwsim_link_add_debugfs,
 #else
 #define HWSIM_DEBUGFS_OPS
 #endif
-- 
2.34.1


