Return-Path: <linux-wireless+bounces-13591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F5992AF0
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF771F232CE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5531D1D1F7B;
	Mon,  7 Oct 2024 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUL/ll/t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED221D1E87
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302483; cv=none; b=s4fhXfn5EnxoEWuC3miE54OU1jYY+84VdLcfMzfFX1BN9syuZswNUmdAc/DD4XekfcAp/YMmoaJp/5ukEEoucUdwNN3sQCBnaheibYEZFFjxZxGKZL8DVQFP7wLUbuKcbrhHlU70AUIq+L8EY7j5CuOxh475FBB7azxcGGo/T18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302483; c=relaxed/simple;
	bh=vnWUID+tV2PMwc47TjV1ZAYOv5SjdAV84Hnoh41fubU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mf7fKx1dvXgSZu6x30yZ2bhm6WL+lSBaUMpnXyGE+6VZJk0+eqQjijq50RY5Uv+wxsUID7bNo+uIC1LelXunlPN6R1566a7ej8s+4ppgb1i19fAYN0sDzntQdvfjpIqTqShrJYlnGy+XQJJlkE0UyQ6U83y3dMpPY0XUf12Ax2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUL/ll/t; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302481; x=1759838481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnWUID+tV2PMwc47TjV1ZAYOv5SjdAV84Hnoh41fubU=;
  b=OUL/ll/tmQ2kaszEJChLsvj9XeaGdx3OaZ4D3s7gyaoUou08QyrB5ke0
   2nD3EvjIxbyF3qGi2ZSpu4r50mxm89W/D4W0i9oDmbZDwulYtbW8IGC0J
   uTjbfg0/K6+yPfZgI9oe2yww2GQQFCOJpjBs2N/VIdBf+B3jLFhSzKOU8
   Nm9V6OpNqmjZjQjc6BdPmYIQHEnZB0kHFy8Wz02hvTcg+Hr2ofYJz48rH
   T4bwTlL6fySWnL63fqrNU6nVTkJcCkeo/ZOkXf1ziLoD0IAO9+6jr/MIW
   8TnmvvoDdzdk6IH4YW5MQO9duEj/PpfCtRn7zEoXCf+4awYOGxOnKAR4h
   w==;
X-CSE-ConnectionGUID: YpSIXxuHRUqLl8HmHnpJRA==
X-CSE-MsgGUID: CRIU1VugQ7mf0Ki2VcQ7FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099394"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099394"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:21 -0700
X-CSE-ConnectionGUID: XI2y06r/R5qSx3FiQIrPsg==
X-CSE-MsgGUID: XOA7GwbuRiybw1AfLoK/3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019259"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/14] wifi: mac80211: ieee80211_recalc_txpower receives a link
Date: Mon,  7 Oct 2024 15:00:50 +0300
Message-Id: <20241007144851.705bbf953d0a.I8a429dede07bab5801f4c730a6abff7ce23b22d3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Handle the tx power per-link. Don't change the behavior for now. Just
change the signature of the function.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c         | 7 ++++---
 net/mac80211/chan.c        | 4 ++--
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/iface.c       | 8 ++++----
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 548b9bbdac04..27468a463d8b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3096,7 +3096,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 			sdata->vif.bss_conf.txpower_type = txp_type;
 		}
 
-		ieee80211_recalc_txpower(sdata, update_txp_type);
+		ieee80211_recalc_txpower(&sdata->deflink, update_txp_type);
 
 		return 0;
 	}
@@ -3127,7 +3127,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
 			continue;
-		ieee80211_recalc_txpower(sdata, update_txp_type);
+		ieee80211_recalc_txpower(&sdata->deflink, update_txp_type);
 	}
 
 	if (has_monitor) {
@@ -3139,7 +3139,8 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 				update_txp_type = true;
 			sdata->vif.bss_conf.txpower_type = txp_type;
 
-			ieee80211_recalc_txpower(sdata, update_txp_type);
+			ieee80211_recalc_txpower(&sdata->deflink,
+						 update_txp_type);
 		}
 	}
 
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 4b07bdfdf658..a4cc91beee74 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -905,7 +905,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	}
 
 	if (new_ctx && ieee80211_chanctx_num_assigned(local, new_ctx) > 0) {
-		ieee80211_recalc_txpower(sdata, false);
+		ieee80211_recalc_txpower(&sdata->deflink, false);
 		ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL, false);
 	}
 
@@ -1712,7 +1712,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 								  link,
 								  changed);
 
-			ieee80211_recalc_txpower(sdata, false);
+			ieee80211_recalc_txpower(&sdata->deflink, false);
 		}
 
 		ieee80211_recalc_chanctx_chantype(local, ctx);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ea74b625aa6c..67de4675c33a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2034,7 +2034,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local);
 void ieee80211_del_virtual_monitor(struct ieee80211_local *local);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata);
-void ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata,
+void ieee80211_recalc_txpower(struct ieee80211_link_data *link,
 			      bool update_bss);
 void ieee80211_recalc_offload(struct ieee80211_local *local);
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6ef0990d3d29..e4a8ed102736 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -74,12 +74,12 @@ bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 	return false;
 }
 
-void ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata,
+void ieee80211_recalc_txpower(struct ieee80211_link_data *link,
 			      bool update_bss)
 {
-	if (__ieee80211_recalc_txpower(sdata) ||
-	    (update_bss && ieee80211_sdata_running(sdata)))
-		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+	if (__ieee80211_recalc_txpower(link->sdata) ||
+	    (update_bss && ieee80211_sdata_running(link->sdata)))
+		ieee80211_link_info_change_notify(link->sdata, link,
 						  BSS_CHANGED_TXPOWER);
 }
 
-- 
2.34.1


