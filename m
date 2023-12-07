Return-Path: <linux-wireless+bounces-474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3121E806A13
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BF51F21788
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB25C19BBB;
	Wed,  6 Dec 2023 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HoxLClI4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B6FA
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852572; x=1733388572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SzncjNaFBA6N0j81sRheaz4lCzdhYqEAJeSUyW5ZpiE=;
  b=HoxLClI4dZ4zQJ1xUszTUAazS0mf0ywJgdMkCCkJ2sz9xS06SQMj8Yd8
   70oP9xaQXxiOXZ755zFAC2GdOAGwNaHfPyZhdL1iTdo9yGjHe8yYCESfU
   zkEeaZCjmsVLHjPhIkXiEBBT9bkoz43UQM7asEb4asAIgyPeQWHIQt4oU
   ESlQDELSeVYx2Gzls3EKeQgXr2sxNb90Uo+Pvcv3HPHJG0tF5GH2XdLDr
   rTOR/HU19M01UY7qKUJvtvDaDcXaPBEjIs5blPs7iwtWoOv5yYovHxDKe
   Idb/AB8K853B9L8rBhw4sM3RP9S0sFgubumlZw47b3ham+UFcx5d9/Ght
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916504"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916504"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575348"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575348"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:30 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 01/13] wifi: iwlwifi: mvm: Use the link ID provided in scan request
Date: Thu,  7 Dec 2023 04:50:06 +0200
Message-Id: <20231207044813.84e21c01b79d.Ib5f546d35542c6c561f5b944c08c9b1850f44146@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Ilan Peer <ilan.peer@intel.com>

If a valid link ID was provided in the scan request use it instead
of picking one of the active links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 75c5c58e14a5..79829ced8349 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -101,6 +101,7 @@ struct iwl_mvm_scan_params {
 	bool scan_6ghz;
 	bool enable_6ghz_passive;
 	bool respect_p2p_go, respect_p2p_go_hb;
+	s8 tsf_report_link_id;
 	u8 bssid[ETH_ALEN] __aligned(2);
 };
 
@@ -2345,17 +2346,9 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_mvm *mvm,
 	if (version < 16) {
 		gp->scan_start_mac_or_link_id = scan_vif->id;
 	} else {
-		struct iwl_mvm_vif_link_info *link_info;
-		u8 link_id = 0;
+		struct iwl_mvm_vif_link_info *link_info =
+			scan_vif->link[params->tsf_report_link_id];
 
-		/* Use one of the active link (if any). In the future it would
-		 * be possible that the link ID would be part of the scan
-		 * request coming from upper layers so we would need to use it.
-		 */
-		if (vif->active_links)
-			link_id = ffs(vif->active_links) - 1;
-
-		link_info = scan_vif->link[link_id];
 		if (!WARN_ON(!link_info))
 			gp->scan_start_mac_or_link_id = link_info->fw_link_id;
 	}
@@ -2977,6 +2970,14 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (req->duration)
 		params.iter_notif = true;
 
+	params.tsf_report_link_id = req->tsf_report_link_id;
+	if (params.tsf_report_link_id < 0) {
+		if (vif->active_links)
+			params.tsf_report_link_id = __ffs(vif->active_links);
+		else
+			params.tsf_report_link_id = 0;
+	}
+
 	iwl_mvm_build_scan_probe(mvm, vif, ies, &params);
 
 	iwl_mvm_scan_6ghz_passive_scan(mvm, &params, vif);
-- 
2.34.1


