Return-Path: <linux-wireless+bounces-7238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA3E8BD53D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C99281E7D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB5158D95;
	Mon,  6 May 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UBoO94JG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F3115572C
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022727; cv=none; b=psldQ7VuwEs1yQPjvjviIu4omTKYEtzN1MyWRp1rBET+RgS9mKFWSgd9FrvvpvVZEFgHbR+8lDFmsxMBmE25kJ5m6prFLMCJZmlpQwhBbDoz4GwdyVgqrgNt+hVA3eAik/CiOVYrYgwcB7NPwUBHHNdeOp7UOG1cAp1DREeOG/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022727; c=relaxed/simple;
	bh=L/PkHj+pMsi0K1q6dTJUAkB1uVJ2m2r7wB++8YyEDfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZrxPzUDUHcWTAVnvgxIsUEWB1EvmDmW7CL/eJOBXmn5o7oCng3TkiNg7weH0MVx/UXMpjDqrMcJAOpPyocCbZ979Zt3e3CjZmAxnBRNaBaE6AxcSqsvEOEzEsAD664VWSCCWK/iu4IplwFA1fl/XqeM74z8Wh3u7/Gdfao9IvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UBoO94JG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QtfIGuDdDrojIF9YOp5yzZ31nhq53McENukWYemk+30=; t=1715022725; x=1716232325; 
	b=UBoO94JGFMBBP5iPjBOKldCVguQ+5yTXHJtmETUNUSvZ6cwumiypQH0f9qne9jxh7PnAGrMg4pb
	5I2z46y47SqUCr1vVaH27M2Cbhdqk3tMStjUI1IKwZkqaLGRCUnNQlVfpYGBV7LR7xxqz24MbtUWF
	/EDdihYyxVpUb6s8ovG7zeqOBBBhn4jW46C//DHlbnnJkcATlfmJzVi/4lURysj1Lflq+x0LpsTG+
	sc+z/vaGFkhMTFopdO6m7j5/wvbC6FuwRE0kpuoDHAQUvA7wTnvVfur4zEF0fm2vlwC1ocz3wPVFc
	SSL/3Xd07ZOlNXC4/+p9N/4EFK3KPBbNAi5g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43ko-000000089rf-0A6p;
	Mon, 06 May 2024 21:12:02 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: cfg80211: restrict operation during radar detection
Date: Mon,  6 May 2024 21:11:59 +0200
Message-ID: <20240506211158.ae8dca3d0d6c.I7c70a66a5fbdbc63a78fee8a34f31d1995491bc3@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Just like it's not currently possible to start radar
detection while already operating, it shouldn't be
possible to start operating while radar detection is
running. Fix that.

Also, improve the check whether operating (carrier
might not be up if e.g. attempting to join IBSS).

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/ibss.c    |  5 ++++-
 net/wireless/mesh.c    |  5 ++++-
 net/wireless/nl80211.c | 21 +++++++++++++++------
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index 9f02ee5f08be..34e5acff3935 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -3,7 +3,7 @@
  * Some IBSS support code for cfg80211.
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2020-2023 Intel Corporation
+ * Copyright (C) 2020-2024 Intel Corporation
  */
 
 #include <linux/etherdevice.h>
@@ -94,6 +94,9 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 
 	lockdep_assert_held(&rdev->wiphy.mtx);
 
+	if (wdev->cac_started)
+		return -EBUSY;
+
 	if (wdev->u.ibss.ssid_len)
 		return -EALREADY;
 
diff --git a/net/wireless/mesh.c b/net/wireless/mesh.c
index 83306979fbe2..aaca65b66af4 100644
--- a/net/wireless/mesh.c
+++ b/net/wireless/mesh.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Portions
- * Copyright (C) 2022-2023 Intel Corporation
+ * Copyright (C) 2022-2024 Intel Corporation
  */
 #include <linux/ieee80211.h>
 #include <linux/export.h>
@@ -127,6 +127,9 @@ int __cfg80211_join_mesh(struct cfg80211_registered_device *rdev,
 	if (!rdev->ops->join_mesh)
 		return -EOPNOTSUPP;
 
+	if (wdev->cac_started)
+		return -EBUSY;
+
 	if (!setup->chandef.chan) {
 		/* if no channel explicitly given, use preset channel */
 		setup->chandef = wdev->u.mesh.preset_chandef;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3c0bca4238d3..71cbe5d15994 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5937,6 +5937,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->start_ap)
 		return -EOPNOTSUPP;
 
+	if (wdev->cac_started)
+		return -EBUSY;
+
 	if (wdev->links[link_id].ap.beacon_interval)
 		return -EALREADY;
 
@@ -9929,6 +9932,17 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 
 	flush_delayed_work(&rdev->dfs_update_channels_wk);
 
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
+		break;
+	default:
+		/* caution - see cfg80211_beaconing_iface_active() below */
+		return -EINVAL;
+	}
+
 	wiphy_lock(wiphy);
 
 	dfs_region = reg_get_dfs_region(wiphy);
@@ -9959,12 +9973,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		goto unlock;
 	}
 
-	if (netif_carrier_ok(dev)) {
-		err = -EBUSY;
-		goto unlock;
-	}
-
-	if (wdev->cac_started) {
+	if (cfg80211_beaconing_iface_active(wdev) || wdev->cac_started) {
 		err = -EBUSY;
 		goto unlock;
 	}
-- 
2.44.0


