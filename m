Return-Path: <linux-wireless+bounces-19426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B91A443A3
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 15:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18621724A8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931D269AE4;
	Tue, 25 Feb 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AidLEU3V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DA21ABC3;
	Tue, 25 Feb 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495245; cv=none; b=DjO75wRaaecOxvx0eXAd3u3zdpvwuJrwlDCJl7cHTGRv86JqkXAfi7+YTH46VfRPtbQ5Z+jibNXTx2M3jJ2zsWczZiTNzHEM4hrtxfVou8hFS+DATcnZxnjC9uS9uY5tYOl1DuhjtUDMLlZu+UM985uBXZz9uRy3/uCPBr7q9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495245; c=relaxed/simple;
	bh=GZpMngtmFhdsP/lCjQiVOV105u1rCCmmCdZDYcwGgRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TDKD/X/5AIOtK8syE2OVRona5sJUgzEDE6Sku8dpxDdlf3s/IF0RuPTA14QxSBddsHGiubiYCnlUC09ubUWHOK+Ds/SJGy3gQLZhVmFB7rC0gBJPqMJEBMEDBSMHJGMwzGgacNYoyXQftFz6hBYshbezeFn/Ooc7ehCzAb6EIQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AidLEU3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA87C4CEE6;
	Tue, 25 Feb 2025 14:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740495244;
	bh=GZpMngtmFhdsP/lCjQiVOV105u1rCCmmCdZDYcwGgRk=;
	h=From:To:Cc:Subject:Date:From;
	b=AidLEU3VRr8MU2JzqXd6vgBqZWojdJiH1QEJ54HQ4XViRiatsnhMd8++/l08YWuZB
	 9j3QGwxiDZgCwazjZeBpgZVAlNNICwJ9aeCs2c/cglShIU9vzjJOoFWNVrVWBPyDPy
	 mP1n59p5rRR1KiAuIck9tZP/ylJN9tb1NSMm0/AH1T+XFb1n0wnp3mKjwv2t+LYZQq
	 PBUOb670gmD3DCjOyHI9qPmEHi57pdRJUgop/KwWoRJRk8Lom4KD80EZMmS4yOi3T4
	 pUIl2XRPXBRsDM/Kue59axX86c2bdFNf6Rr62861ROpRxhysYrWN2qTSLZ/5nGunbV
	 W/LKU3bICUsKw==
From: Arnd Bergmann <arnd@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] iwlegacy: don't warn for unused variables with DEBUG_FS=n
Date: Tue, 25 Feb 2025 15:53:53 +0100
Message-Id: <20250225145359.1126786-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The reference to il_rate_mcs is inside of an #ifdef, causing a W=1 warning:

drivers/net/wireless/intel/iwlegacy/4965-rs.c:189:38: error: unused variable 'il_rate_mcs' [-Werror,-Wunused-const-variable]
static const struct il_rate_mcs_info il_rate_mcs[RATE_COUNT] = {

Replace the #ifdef with a PTR_IF() for better compile time analysis.
The dead code will still get eliminated, but the warning goes away.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use correct config symbol consistently
---
 drivers/net/wireless/intel/iwlegacy/4965-rs.c | 15 ++-------------
 drivers/net/wireless/intel/iwlegacy/common.h  |  2 --
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index 718efb1aa1b0..f754fb979546 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -132,15 +132,8 @@ static void il4965_rs_fill_link_cmd(struct il_priv *il,
 static void il4965_rs_stay_in_table(struct il_lq_sta *lq_sta,
 				    bool force_search);
 
-#ifdef CONFIG_MAC80211_DEBUGFS
 static void il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta,
 				    u32 *rate_n_flags, int idx);
-#else
-static void
-il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
-{
-}
-#endif
 
 /*
  * The following tables contain the expected throughput metrics for all rates
@@ -2495,8 +2488,6 @@ il4965_rs_free_sta(void *il_r, struct ieee80211_sta *sta, void *il_sta)
 	D_RATE("leave\n");
 }
 
-#ifdef CONFIG_MAC80211_DEBUGFS
-
 static void
 il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
 {
@@ -2758,7 +2749,6 @@ il4965_rs_add_debugfs(void *il, void *il_sta, struct dentry *dir)
 	debugfs_create_u8("tx_agg_tid_enable", 0600, dir,
 			  &lq_sta->tx_agg_tid_en);
 }
-#endif
 
 /*
  * Initialization of rate scaling information is done by driver after
@@ -2781,9 +2771,8 @@ static const struct rate_control_ops rs_4965_ops = {
 	.free = il4965_rs_free,
 	.alloc_sta = il4965_rs_alloc_sta,
 	.free_sta = il4965_rs_free_sta,
-#ifdef CONFIG_MAC80211_DEBUGFS
-	.add_sta_debugfs = il4965_rs_add_debugfs,
-#endif
+	.add_sta_debugfs = PTR_IF(IS_ENABLED(CONFIG_MAC80211_DEBUGFS),
+				  il4965_rs_add_debugfs),
 };
 
 int
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 92285412ab10..52610f5e57a3 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -2815,9 +2815,7 @@ struct il_lq_sta {
 	struct il_scale_tbl_info lq_info[LQ_SIZE];	/* "active", "search" */
 	struct il_traffic_load load[TID_MAX_LOAD_COUNT];
 	u8 tx_agg_tid_en;
-#ifdef CONFIG_MAC80211_DEBUGFS
 	u32 dbg_fixed_rate;
-#endif
 	struct il_priv *drv;
 
 	/* used to be in sta_info */
-- 
2.39.5


