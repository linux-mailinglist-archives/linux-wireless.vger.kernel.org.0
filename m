Return-Path: <linux-wireless+bounces-475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1234F806A14
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4755281BE8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D531A706;
	Wed,  6 Dec 2023 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrbjWNBS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA2ED51
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852575; x=1733388575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HeasniUBsWSYmqetfuaKw1rut5ma0qdwry5lBBmOYwk=;
  b=TrbjWNBS3AndffYbM/oX2k5H8CBcavHCVeR6ANhhlPQwOjWcjfyfZysK
   ma/EKXghOi8tK7IFzX55cmOBzva7VHm2AEX8tJGlbmrPsYovxZa0Hop2R
   h11ef+z3BP+fLgFehboAZjdqeB5D7hgYP2l4vtvV2ZUUUDuFuFL8EkvDu
   dcV84NIlVcEY4CJ3CIYpM3K3CSBacrref+IU71hiGFcZ0cExTUbEwhrl9
   VMYwp210f+IIIVc8v6oSSKbZL3D9WJtX+gzKEbwyOh64WpDTQK/4Mspda
   1uV8kxcWMWIej6DWIdcX/mJoEr/ghHZXJVbWXyt5ZAR0tHZKc+syDRXpP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916509"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916509"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575362"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575362"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:33 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 02/13] wifi: iwlwifi: mvm: Correctly report TSF data in scan complete
Date: Thu,  7 Dec 2023 04:50:07 +0200
Message-Id: <20231207044813.1e67dba640c1.I6c4941bfab3a04498370e58b402c64d990c39fbf@changeid>
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

For an MLO connection, the BSSID of the link used during the scanning
should be used (and not the one from the default link).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f2af3e571409..b04485b7e1f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -947,6 +947,7 @@ struct iwl_mvm {
 
 	/* the vif that requested the current scan */
 	struct iwl_mvm_vif *scan_vif;
+	u8 scan_link_id;
 
 	/* rx chain antennas set through debugfs for the scan command */
 	u8 scan_rx_ant;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 79829ced8349..7b6f1cdca067 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2343,12 +2343,15 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_mvm *mvm,
 	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2)
 		gp->num_of_fragments[SCAN_HB_LMAC_IDX] = IWL_SCAN_NUM_OF_FRAGS;
 
+	mvm->scan_link_id = 0;
+
 	if (version < 16) {
 		gp->scan_start_mac_or_link_id = scan_vif->id;
 	} else {
 		struct iwl_mvm_vif_link_info *link_info =
 			scan_vif->link[params->tsf_report_link_id];
 
+		mvm->scan_link_id = params->tsf_report_link_id;
 		if (!WARN_ON(!link_info))
 			gp->scan_start_mac_or_link_id = link_info->fw_link_id;
 	}
@@ -3165,8 +3168,13 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 			.aborted = aborted,
 			.scan_start_tsf = mvm->scan_start,
 		};
+		struct iwl_mvm_vif *scan_vif = mvm->scan_vif;
+		struct iwl_mvm_vif_link_info *link_info =
+			scan_vif->link[mvm->scan_link_id];
+
+		if (!WARN_ON(!link_info))
+			memcpy(info.tsf_bssid, link_info->bssid, ETH_ALEN);
 
-		memcpy(info.tsf_bssid, mvm->scan_vif->deflink.bssid, ETH_ALEN);
 		ieee80211_scan_completed(mvm->hw, &info);
 		mvm->scan_vif = NULL;
 		cancel_delayed_work(&mvm->scan_timeout_dwork);
-- 
2.34.1


