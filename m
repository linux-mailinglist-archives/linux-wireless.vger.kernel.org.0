Return-Path: <linux-wireless+bounces-977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7699818396
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C9F28131D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0F125C2;
	Tue, 19 Dec 2023 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/efFh/H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFF4125B0
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975117; x=1734511117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kHpD3v2RLXhDg+fg+xWvL/tntpE9aSEKwY1Ui5Y0y4=;
  b=A/efFh/H1O3Q0Kj8iGgboYUumLLhwMwxYwYbcRSp8Skb5+JI9gOBExs6
   gMDtTm2z4HqqcAcNDQh0dTbrzT/1+OwA0N0PDUvSk+S0r7pbe4Wq+eiTi
   BzjU/K6bsXhlz1h5SjqC1+/DhQoTZrsw96X/cv3z4k3jPiFctUDFvZY8p
   SaNBB8bYnyNC++r/aZLDa9FME8+I/tl3fDP8raYRCGQ9En8hp7FvkN8ca
   gqWbCAJz3dHl3y7/Fyl9BkIsdToDOax1SzVnlaKjaK9aoQzTwASfmM60T
   AhB92RH/dt6NKqndvJwfsoyKPG/EMk+3Iw+YTyzBtU+bSLqZrn2MLK5EU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969306"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969306"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266545"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266545"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>, Berg@web.codeaurora.org,
	Johannes <johannes.berg@intel.com>
Subject: [PATCH 13/15] wifi: mac80211: add/remove driver debugfs entries as appropriate
Date: Wed, 20 Dec 2023 04:38:01 +0200
Message-Id: <20231220043149.a9f64c359424.I7076526b5297ae8f832228079c999f7b8e147a4c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When an interface is removed, we should also be deleting the driver
debugfs entries (as it might still exist in DOWN state in mac80211). At
the same time, when adding an interface, we can check the
IEEE80211_SDATA_IN_DRIVER flag to know whether the interface was
previously known to the driver and is simply being reconfigured.

Fixes: a1f5dcb1c0c1 ("wifi: mac80211: add a driver callback to add vif debugfs")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/debugfs_netdev.c |  9 ++++++---
 net/mac80211/driver-ops.c     | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index ec91e131b29e..f879a0f2728e 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -983,9 +983,12 @@ void ieee80211_debugfs_recreate_netdev(struct ieee80211_sub_if_data *sdata,
 {
 	ieee80211_debugfs_remove_netdev(sdata);
 	ieee80211_debugfs_add_netdev(sdata, mld_vif);
-	drv_vif_add_debugfs(sdata->local, sdata);
-	if (!mld_vif)
-		ieee80211_link_debugfs_drv_add(&sdata->deflink);
+
+	if (sdata->flags & IEEE80211_SDATA_IN_DRIVER) {
+		drv_vif_add_debugfs(sdata->local, sdata);
+		if (!mld_vif)
+			ieee80211_link_debugfs_drv_add(&sdata->deflink);
+	}
 }
 
 void ieee80211_link_debugfs_add(struct ieee80211_link_data *link)
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 5e0435db2f9c..3b7f70073fc3 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -75,9 +75,9 @@ int drv_add_interface(struct ieee80211_local *local,
 	if (ret)
 		return ret;
 
-	sdata->flags |= IEEE80211_SDATA_IN_DRIVER;
+	if (!(sdata->flags & IEEE80211_SDATA_IN_DRIVER)) {
+		sdata->flags |= IEEE80211_SDATA_IN_DRIVER;
 
-	if (!local->in_reconfig && !local->resuming) {
 		drv_vif_add_debugfs(local, sdata);
 		/* initially vif is not MLD */
 		ieee80211_link_debugfs_drv_add(&sdata->deflink);
@@ -113,9 +113,13 @@ void drv_remove_interface(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
+	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
+
+	/* Remove driver debugfs entries */
+	ieee80211_debugfs_recreate_netdev(sdata, sdata->vif.valid_links);
+
 	trace_drv_remove_interface(local, sdata);
 	local->ops->remove_interface(&local->hw, &sdata->vif);
-	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
 	trace_drv_return_void(local);
 }
 
-- 
2.34.1


