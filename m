Return-Path: <linux-wireless+bounces-26508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA13B2F8EA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBDB188F0D1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115EA322A01;
	Thu, 21 Aug 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3ogRWzE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2D326D4E
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780318; cv=none; b=ZRRXd4c3R11gdLlufQ4gGm6sSeL1BrNep5rhA3ODs0ixRakTVAbhXCYo0hYpAYNbZi97Bl8VRBjzHU/xNyYZTsmi6DXcZ9KYNqqQmXN9ttcAQt1P2ui+OYZBuw95Oyfi/CtdbPIf5oHAfTceIv9GoED6UCSWaEroIqETzbPRGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780318; c=relaxed/simple;
	bh=VMWwaggfSjxj8tIl43s/7ne5H6zn/zZJv7pVzqMNPg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrO+YXr4VZweCA1hA3uaVdDj8Dj3g5/C1GdPzRb3EnxgGnfpRDiyj22FCND2CsGpj5xmkccHY05/6lbe5t3cvygf17iVjPjQjbbwbJ2g6V5tz++bBSaKEy8RTUMprP+qzatIgEcYVVpYkoxAIJdg8yrE2o5SJaeUFhv91jikXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3ogRWzE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780316; x=1787316316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VMWwaggfSjxj8tIl43s/7ne5H6zn/zZJv7pVzqMNPg0=;
  b=U3ogRWzEscWsJ0pnZavWMoPcBhJa6t18usmTfJukXDiqsvfSfHU4DmCH
   U8LjYaZLDzLNniLHTUouIX9WpWPiGYUCW0ztdqLVv1uajV3INwZTX8dZs
   tqZN5epyI9gE+XDlxuYdiP1jtCfuFCb+xeDLtkIZWgS6BwIk7FCTKZb0W
   yYIKoQDU2u8FWA/OgfkcmbFuCc8P5xynB50GnPXjSuU+pVzgwICunDQkz
   pT4I4vFSrIjeWYrP8M7mvbX5DRTnKQkLVRCloHMAd8G+P1/Rl0JKSPNZT
   w4A9qmYqb3aNPJUm75ZdR1/tSmlJdop8lRHWF+RlWKy95QutpdLTlplCm
   g==;
X-CSE-ConnectionGUID: VgRtZSoFRP2AKI1H3XIoyA==
X-CSE-MsgGUID: 7Z0jQT4STzWECmhCzWgbgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895763"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895763"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:16 -0700
X-CSE-ConnectionGUID: ZgWosSK/THSCkldr+SJgOA==
X-CSE-MsgGUID: CL1gTJ4nTAqvpzMOgX1GRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622216"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: refactor iwl_mld_add_all_rekeys
Date: Thu, 21 Aug 2025 15:44:31 +0300
Message-Id: <20250821154216.1d12ab0b5699.I201044d175b979520970090153de4d622652f86d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
References: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
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


