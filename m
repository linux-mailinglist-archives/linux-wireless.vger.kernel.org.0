Return-Path: <linux-wireless+bounces-16742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F79FB84C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 02:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF57A1F05
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 01:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6102C4086A;
	Tue, 24 Dec 2024 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="mGDgUTHn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C763139D;
	Tue, 24 Dec 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735003984; cv=none; b=JiLKTHnT/DXKTNmKq6vwZ5NQ4zt3c1ukuNU+7wybu9YYFxeSEBcxxEndkON/nX9i2RtuB7WSCFe/cjzAEzBjZMUeepjZRQ/D0YTv60Qc7FkiwmqJ/1qwFJp63PxklitV2Iepy2X2D3tKLZybrjz6T9ZwQ8DwjPMU+2+UInrDQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735003984; c=relaxed/simple;
	bh=/3RA0jnSH3S8QwTSON0xgsl/KDiYU1P4Ws16sfE4qnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtAJef8IBvJehFH+J05qixHmVaMda+J6uSUjFRW8GvtjrUiHlrCVL0ReGzQpHX07KBqCuEeCgVAcGPu3uyrEAFBhqPMd4tI6kS4/yqn1u3vpo4u9row/Bj/2Cdjz2/+oQ1Bxx6h8tChTW0+HHg+TcvBdGtQ2mn3gQq930uAm2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=mGDgUTHn; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=wDgeQdZmmkR227GhLvh6GOgLONdDJz0d2NeCCr0pQqk=; b=mGDgUTHnSkqRNech
	OKyrqhxJiItkNVl+rU70bXfcPNZoxHxFOfC3X5OmMv58YD3GM46AZoOP5mtqyXBYJwIUANl9rmDP8
	+wieQ0NCDtx0hMIPY1fDUx57FeZ+KPkD4s8ekm9isYLtSLDJGvawyztCgCfzsqFGuOg3c0DcMRqr1
	swpoTNf83ENXtdr+98/kwQRsBjX2tusdwVD5mwbIy2uABAZpw1NjnhPFWiRI8FQ0syj4dUT28cey2
	qVTPQAkKIUUPPMzNLVJLpY4wwdXBqqiJjkBMZPYzbJio+ycIE5gEDHwP8gjUMVhZXUNXVtZzvTf+m
	Tu9IjslrPP/PY5YUZg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPtn9-006wDg-1p;
	Tue, 24 Dec 2024 01:32:59 +0000
From: linux@treblig.org
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/2] wifi: mac80211: Clean up debugfs_key deadcode
Date: Tue, 24 Dec 2024 01:32:56 +0000
Message-ID: <20241224013257.185742-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224013257.185742-1-linux@treblig.org>
References: <20241224013257.185742-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of ieee80211_debugfs_key_sta_del() was removed in 2007 by
commit 11a843b7e160 ("[MAC80211]: rework key handling")

The last use of ieee80211_debugfs_key_add_mgmt_default() was removed
in 2010 by
commit f7e0104c1a4e ("mac80211: support separate default keys")

The last use of ieee80211_debugfs_key_add_beacon_default() was
removed in 2020 by
commit e5473e80d467 ("mac80211: Support BIGTK configuration for Beacon
protection")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/mac80211/debugfs_key.c | 47 --------------------------------------
 net/mac80211/debugfs_key.h | 15 ------------
 2 files changed, 62 deletions(-)

diff --git a/net/mac80211/debugfs_key.c b/net/mac80211/debugfs_key.c
index b3a64edea0f2..117f58af5ff9 100644
--- a/net/mac80211/debugfs_key.c
+++ b/net/mac80211/debugfs_key.c
@@ -402,25 +402,6 @@ void ieee80211_debugfs_key_update_default(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
-void ieee80211_debugfs_key_add_mgmt_default(struct ieee80211_sub_if_data *sdata)
-{
-	char buf[50];
-	struct ieee80211_key *key;
-
-	if (!sdata->vif.debugfs_dir)
-		return;
-
-	key = wiphy_dereference(sdata->local->hw.wiphy,
-				sdata->deflink.default_mgmt_key);
-	if (key) {
-		sprintf(buf, "../keys/%d", key->debugfs.cnt);
-		sdata->debugfs.default_mgmt_key =
-			debugfs_create_symlink("default_mgmt_key",
-					       sdata->vif.debugfs_dir, buf);
-	} else
-		ieee80211_debugfs_key_remove_mgmt_default(sdata);
-}
-
 void ieee80211_debugfs_key_remove_mgmt_default(struct ieee80211_sub_if_data *sdata)
 {
 	if (!sdata)
@@ -430,27 +411,6 @@ void ieee80211_debugfs_key_remove_mgmt_default(struct ieee80211_sub_if_data *sda
 	sdata->debugfs.default_mgmt_key = NULL;
 }
 
-void
-ieee80211_debugfs_key_add_beacon_default(struct ieee80211_sub_if_data *sdata)
-{
-	char buf[50];
-	struct ieee80211_key *key;
-
-	if (!sdata->vif.debugfs_dir)
-		return;
-
-	key = wiphy_dereference(sdata->local->hw.wiphy,
-				sdata->deflink.default_beacon_key);
-	if (key) {
-		sprintf(buf, "../keys/%d", key->debugfs.cnt);
-		sdata->debugfs.default_beacon_key =
-			debugfs_create_symlink("default_beacon_key",
-					       sdata->vif.debugfs_dir, buf);
-	} else {
-		ieee80211_debugfs_key_remove_beacon_default(sdata);
-	}
-}
-
 void
 ieee80211_debugfs_key_remove_beacon_default(struct ieee80211_sub_if_data *sdata)
 {
@@ -460,10 +420,3 @@ ieee80211_debugfs_key_remove_beacon_default(struct ieee80211_sub_if_data *sdata)
 	debugfs_remove(sdata->debugfs.default_beacon_key);
 	sdata->debugfs.default_beacon_key = NULL;
 }
-
-void ieee80211_debugfs_key_sta_del(struct ieee80211_key *key,
-				   struct sta_info *sta)
-{
-	debugfs_remove(key->debugfs.stalink);
-	key->debugfs.stalink = NULL;
-}
diff --git a/net/mac80211/debugfs_key.h b/net/mac80211/debugfs_key.h
index af7cf495f8d1..e17a48d5c6cc 100644
--- a/net/mac80211/debugfs_key.h
+++ b/net/mac80211/debugfs_key.h
@@ -6,16 +6,10 @@
 void ieee80211_debugfs_key_add(struct ieee80211_key *key);
 void ieee80211_debugfs_key_remove(struct ieee80211_key *key);
 void ieee80211_debugfs_key_update_default(struct ieee80211_sub_if_data *sdata);
-void ieee80211_debugfs_key_add_mgmt_default(
-	struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_key_remove_mgmt_default(
 	struct ieee80211_sub_if_data *sdata);
-void ieee80211_debugfs_key_add_beacon_default(
-	struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_key_remove_beacon_default(
 	struct ieee80211_sub_if_data *sdata);
-void ieee80211_debugfs_key_sta_del(struct ieee80211_key *key,
-				   struct sta_info *sta);
 #else
 static inline void ieee80211_debugfs_key_add(struct ieee80211_key *key)
 {}
@@ -24,21 +18,12 @@ static inline void ieee80211_debugfs_key_remove(struct ieee80211_key *key)
 static inline void ieee80211_debugfs_key_update_default(
 	struct ieee80211_sub_if_data *sdata)
 {}
-static inline void ieee80211_debugfs_key_add_mgmt_default(
-	struct ieee80211_sub_if_data *sdata)
-{}
 static inline void ieee80211_debugfs_key_remove_mgmt_default(
 	struct ieee80211_sub_if_data *sdata)
 {}
-static inline void ieee80211_debugfs_key_add_beacon_default(
-	struct ieee80211_sub_if_data *sdata)
-{}
 static inline void ieee80211_debugfs_key_remove_beacon_default(
 	struct ieee80211_sub_if_data *sdata)
 {}
-static inline void ieee80211_debugfs_key_sta_del(struct ieee80211_key *key,
-						 struct sta_info *sta)
-{}
 #endif
 
 #endif /* __MAC80211_DEBUGFS_KEY_H */
-- 
2.47.1


