Return-Path: <linux-wireless+bounces-26540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104ACB30175
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A282620A22
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BB7343D8C;
	Thu, 21 Aug 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzQW/7PH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CD341AAE
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798489; cv=none; b=TJi1aZsy24x3IQpDSzYci8oChg1N9MF7nyXN6hZ2O0hh/W+Fy/ZDvBY1YN7IL8XV7vrZzDgExViP+O+Iln5Uj49A2ap5TqjVcB/259TUoDSLZJsdgur3zU00RgZFaqxSNw3VIxRfb872iQlWLz5GG5laerAUraS9X1oFXD1myYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798489; c=relaxed/simple;
	bh=VMWwaggfSjxj8tIl43s/7ne5H6zn/zZJv7pVzqMNPg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PN3vNIZHDr7FOJVvtcVtLB1nBZ+Av/MnnmuLvIQBB67C0z0E2J6IqjKg5qfCs4p7Klz6RDohQDBC73iZNLr/1/3KlfyZeb4jmY3VnKzhLWpok5bWHkA7iS958Upg1VII6iiANMkk0RmcL5QnI5PI2zJSyLijJDAaaiU49tkqsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzQW/7PH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798488; x=1787334488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VMWwaggfSjxj8tIl43s/7ne5H6zn/zZJv7pVzqMNPg0=;
  b=XzQW/7PHvEdoxzgIhvcGW7FRAKHYHSN/iGCsdX/kRFIf3d19Q0ptuRet
   QHV0AzQnmgooqu9CaD1Vm7KjTJEJdxWtZPgIzG4ZBpWW0FnPaBLfUrGSl
   lp+v6rHY5u8WzbzmwvzCnZff51j3tkHfA2uSV4/pXAYopE+omtmAmTrl2
   RYy9W8xNGEtj/GH93k7TiV1l7RZndgmJDheM0wADtrzDY0RfYqRbqX80z
   HpFfnbZ+3aLkcLI71dBbyT1koko4oJTf2mJ/XLLKhv2M0SYxAun/Trg6a
   Cg48puJdqt5phNnHc95FwH785vN3jNIlo5AJJqLr8uu4uAeAjHVc5ablY
   g==;
X-CSE-ConnectionGUID: VZy+occFTUiOrREd5/m4yg==
X-CSE-MsgGUID: 927ECOn2Rl+3A6Vz02KVBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806091"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806091"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:08 -0700
X-CSE-ConnectionGUID: EJis86wMQAKZ/XU84UIg4A==
X-CSE-MsgGUID: ckOAL8gpT9iQxXjbJRgDjA==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 13/15] wifi: iwlwifi: mld: refactor iwl_mld_add_all_rekeys
Date: Thu, 21 Aug 2025 20:47:24 +0300
Message-Id: <20250821204455.1d12ab0b5699.I201044d175b979520970090153de4d622652f86d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
References: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This receives iwl_mld_resume_key_iter_data, but it really only needs the
mld object. Pass that instead.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 86bb3a7a9f7f..db0c83a425fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -831,24 +831,21 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 }
 
 static void
-iwl_mld_add_all_rekeys(struct ieee80211_vif *vif,
+iwl_mld_add_all_rekeys(struct iwl_mld *mld,
+		       struct ieee80211_vif *vif,
 		       struct iwl_mld_wowlan_status *wowlan_status,
-		       struct iwl_mld_resume_key_iter_data *key_iter_data,
 		       struct ieee80211_bss_conf *link_conf)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(wowlan_status->gtk); i++)
-		iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
-					&wowlan_status->gtk[i],
+		iwl_mld_add_mcast_rekey(vif, mld, &wowlan_status->gtk[i],
 					link_conf);
 
-	iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
-				&wowlan_status->igtk, link_conf);
+	iwl_mld_add_mcast_rekey(vif, mld, &wowlan_status->igtk, link_conf);
 
 	for (i = 0; i < ARRAY_SIZE(wowlan_status->bigtk); i++)
-		iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
-					&wowlan_status->bigtk[i],
+		iwl_mld_add_mcast_rekey(vif, mld, &wowlan_status->bigtk[i],
 					link_conf);
 }
 
@@ -934,7 +931,7 @@ iwl_mld_update_sec_keys(struct iwl_mld *mld,
 	if (!key_iter_data.num_keys || !wowlan_status->num_of_gtk_rekeys)
 		return true;
 
-	iwl_mld_add_all_rekeys(vif, wowlan_status, &key_iter_data,
+	iwl_mld_add_all_rekeys(mld, vif, wowlan_status,
 			       link_conf);
 
 	iwl_mld_mlo_rekey(mld, wowlan_status, vif);
-- 
2.34.1


