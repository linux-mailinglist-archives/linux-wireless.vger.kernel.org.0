Return-Path: <linux-wireless+bounces-22271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB51BAA4C6E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B491B17D907
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD992609F5;
	Wed, 30 Apr 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0C68uBh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767AE2609DE
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017879; cv=none; b=hmjzKdGC3EQr7leBVpmUP5aU2+x+LHVzMt+0mHJNAdCbDAHavINmqcQdBqWc/RUTapCwSP78bUq4QtGpQEVpZEkk9r19Vn3CUIkt/QPLLTxK12xDXaKyylPBkzFOSQo4/MLFP829NOh+AEDqyuq1IT5Zct13+MZkBSW44EE9d1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017879; c=relaxed/simple;
	bh=iXMEHaYOFcWMsmrq2wsuI+hM35v+874+zxjcDGaKryQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDTUfDFxom0F9SUl30l81exA8ltSICLuo776pt5pwbCLK1nvjfHYLW+7pyu9RsJzqWKwapYZYkwoA/fPqBMsGZSnWCnjz9Fct7E9vNtAQ45P6UMdN4NpPGC3SZ9pB6RqxQPWb4XoK6i0G840G1NMhjNq6D3f6xYLGsxvO4FEx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0C68uBh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017877; x=1777553877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iXMEHaYOFcWMsmrq2wsuI+hM35v+874+zxjcDGaKryQ=;
  b=f0C68uBh3SMD0o7/qG1jH9qWzEyM40GXprFuMPPKbIw0Nxvy4AU2Ntrr
   JFOp/aPgswIM5Si9HQ0qeZ8q5UJBwSb3yD9RA32H3MKujXbfIWKW8UKX2
   Sd6YXU4wutTbxRjmmGgvTWtb8H9A/YUpP7I7y0dMLfU+QeAtpzJ1Idi5T
   9AQl6qAnTdUV+uZQWco1ieBWLarC+k32XaN6Ilk4/jBwNKzQ7g0jgLeA3
   /C/tClhxZL8dibs3Sceptiqc8gyvgOpuwZvEnC9t6ocqBzAQMW5NqQyYw
   wbBdgAKy9OX6VeQx/2UL4v5Bzhtu6H63KDqnqrOJGmhQ8wy+3PE8XN0Jn
   w==;
X-CSE-ConnectionGUID: 5w3mK6CuTqKmaXzJve5tmw==
X-CSE-MsgGUID: oaJpflj9Qm2R0S6MLUJZaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332346"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332346"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:57 -0700
X-CSE-ConnectionGUID: ph8j5MdOQ7O0YFXcdxDR+w==
X-CSE-MsgGUID: 77/epHYWRsq7XaEPP+jDJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632118"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: start AP with the correct bandwidth
Date: Wed, 30 Apr 2025 15:57:24 +0300
Message-Id: <20250430155443.30b043b10fb1.I62c2aa58687e4796b759fa68132122119a337b49@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

When a channel context is added, it is still not assigned to the link
and the link is not yet active. As a result, the channel context
min_def is used when the AP is started, even when the full bandwidth
should be used.
Fix it by updating the PHY channel context when the link is already
active so the full bandwidth is used when needed.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ap.c       |  9 +++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c |  3 +--
 drivers/net/wireless/intel/iwlwifi/mld/phy.c      | 11 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/phy.h      |  3 +++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ap.c b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
index 571eabd0b511..26511b49d89a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ap.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
@@ -11,6 +11,7 @@
 #include "tx.h"
 #include "power.h"
 #include "key.h"
+#include "phy.h"
 #include "iwl-utils.h"
 
 #include "fw/api/sta.h"
@@ -269,6 +270,7 @@ int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct ieee80211_chanctx_conf *ctx;
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_AP)
@@ -314,6 +316,13 @@ int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 		return iwl_mld_mac_fw_action(mld, mld->p2p_device_vif,
 					     FW_CTXT_ACTION_MODIFY);
 
+	/* When the channel context was added, the link is not yet active, so
+	 * min_def is always used. Update the PHY again here in case def should
+	 * actually be used.
+	 */
+	ctx = wiphy_dereference(mld->wiphy, link->chanctx_conf);
+	iwl_mld_update_phy_chandef(mld, ctx);
+
 	return 0;
 rm_bcast:
 	iwl_mld_remove_bcast_sta(mld, vif, link);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index b64e3f290e71..e06cf72b2de5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -887,9 +887,8 @@ void iwl_mld_change_chanctx(struct ieee80211_hw *hw,
 			return;
 	}
 update:
-	phy->chandef = *chandef;
 
-	iwl_mld_phy_fw_action(mld, ctx, FW_CTXT_ACTION_MODIFY);
+	iwl_mld_update_phy_chandef(mld, ctx);
 }
 
 static u8
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.c b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
index 2345fe5c3291..3a80ee5e1cb3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
@@ -182,3 +182,14 @@ int iwl_mld_send_phy_cfg_cmd(struct iwl_mld *mld)
 
 	return iwl_mld_send_cmd_pdu(mld, PHY_CONFIGURATION_CMD, &cmd);
 }
+
+void iwl_mld_update_phy_chandef(struct iwl_mld *mld,
+				struct ieee80211_chanctx_conf *ctx)
+{
+	struct iwl_mld_phy *phy = iwl_mld_phy_from_mac80211(ctx);
+	struct cfg80211_chan_def *chandef =
+		iwl_mld_get_chandef_from_chanctx(mld, ctx);
+
+	phy->chandef = *chandef;
+	iwl_mld_phy_fw_action(mld, ctx, FW_CTXT_ACTION_MODIFY);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.h b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
index 563e309deb0a..0deaf179f07c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
@@ -54,4 +54,7 @@ u8 iwl_mld_get_fw_ctrl_pos(const struct cfg80211_chan_def *chandef);
 
 int iwl_mld_send_phy_cfg_cmd(struct iwl_mld *mld);
 
+void iwl_mld_update_phy_chandef(struct iwl_mld *mld,
+				struct ieee80211_chanctx_conf *ctx);
+
 #endif /* __iwl_mld_phy_h__ */
-- 
2.34.1


