Return-Path: <linux-wireless+bounces-27320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B37B5730E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F99189E621
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844422D46BD;
	Mon, 15 Sep 2025 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gX5iShYt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F52EFDBD
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925314; cv=none; b=f+t4k+6/X2RHRylIrpC3yb9nW4dy83jsmVi0YAQki7/CdnHWXx1B5n5d8/4tP5j5tlaRhX5yag3loWKVRBwUvjTTqnss5PBxS5a2eu8/b9FYwDvrKNGC5b9yvHC2muMQiyCX872y8j94kkI+SLQKB9GkmWeRhMABOmuIBJoE3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925314; c=relaxed/simple;
	bh=VfcJEdY7cztnjI7AT8PalKo3SADIYhqKHWIaSerxci8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XaTnTBehfL+pJKrp7fldsS4FVTBkmDAyD0Z0hV47DPzthQVzCXqZ1raIiilfihTa/RQUTXDHhKcgGfvvkHqEKV8sgb5QA9d4m88weM1gTOJQ2zAR6o/gjyKYDbJdQUqAZRclXbOZKB7TbWM4O7bIYQHXDx9RLwovSJLDHX/2pfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gX5iShYt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925313; x=1789461313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VfcJEdY7cztnjI7AT8PalKo3SADIYhqKHWIaSerxci8=;
  b=gX5iShYt/acJg1lRfUIKLMc4iBkp09NSBu2PlQrwgsY0tgDXVioB1byn
   t68LoPZ46DGtTQMAHikh0ZVthXLeOmygdRNZ7ifvJTRTUDKqiTM9jf3D7
   DnQYcSSHEpv0vNnsadZlxEOHx06SaNuh4oAf1CiDApFulLqNjFM04d5BK
   rCB6eCS26vBqLqhIt1aD7e8rOj6HHgzeikK961Eu3jHkt4nHtf4yf1KgE
   nmJQ9L+wkQ4DQ3EzXjKU297uybIrxBmb4iwGzaF0fz8f9e+rLhUKuT+om
   EsWwI0VW0zkU8Ggib8TwUz7i8wbqdfsKFxipe8tnjgYDKk5VRgdQNv8ST
   g==;
X-CSE-ConnectionGUID: tlW4b9BwQ92cspp9Eb2FPw==
X-CSE-MsgGUID: hT4vcik7QP6pOcuG0Jw4yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213085"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213085"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:13 -0700
X-CSE-ConnectionGUID: Va7fiDAxQdOXZboUEsLVWg==
X-CSE-MsgGUID: MAHZUqqSTdCIiMIcowlXEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569906"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/11] wifi: iwlwifi: mvm: cleanup unsupported phy command versions
Date: Mon, 15 Sep 2025 11:34:30 +0300
Message-Id: <20250915113137.e7e26fe71132.I8ec95ff86521661118782ecee1be20ef6e8e48e1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The iwlmvm op mode is used for pre EHT HWs. Those HWs doesn't have wider
OFDMA, so phy command versions 5+ (that added support for wider OFDMA)
are not supported. Remove support for them.

This means that we also don't need to set the
IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW, as we don't care about the ap
chandef anyway.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  3 ---
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 24 +++++--------------
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index b1dca76b7141..380b6f8a53fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -102,9 +102,6 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		mvm->csme_vif = vif;
 	}
 
-	if (vif->p2p || iwl_fw_lookup_cmd_ver(mvm->fw, PHY_CONTEXT_CMD, 1) < 5)
-		vif->driver_flags |= IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW;
-
 	return 0;
 
  out_free_bf:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 5e7e2926be0c..4f4111055ddd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
@@ -202,17 +202,13 @@ int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 				  struct iwl_mvm_phy_ctxt *ctxt,
 				  const struct cfg80211_chan_def *chandef,
-				  const struct cfg80211_chan_def *ap,
 				  u8 chains_static, u8 chains_dynamic,
 				  u32 action)
 {
 	int ret;
 	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_CONTEXT_CMD, 1);
 
-	if (ver < 5 || !ap || !ap->chan)
-		ap = NULL;
-
-	if (ver >= 3 && ver <= 6) {
+	if (ver >= 3 && ver <= 4) {
 		struct iwl_phy_context_cmd cmd = {};
 
 		/* Set the command header fields */
@@ -223,14 +219,6 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 					  chains_static,
 					  chains_dynamic);
 
-		if (ap) {
-			cmd.sbb_bandwidth = iwl_mvm_get_channel_width(ap);
-			cmd.sbb_ctrl_channel_loc = iwl_mvm_get_ctrl_pos(ap);
-		}
-
-		if (ver == 6)
-			cmd.puncture_mask = cpu_to_le16(chandef->punctured);
-
 		ret = iwl_mvm_send_cmd_pdu(mvm, PHY_CONTEXT_CMD,
 					   0, sizeof(cmd), &cmd);
 	} else if (ver < 3) {
@@ -284,7 +272,7 @@ int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 	ctxt->width = chandef->width;
 	ctxt->center_freq1 = chandef->center_freq1;
 
-	ret = iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef, ap,
+	ret = iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
 				     chains_static, chains_dynamic,
 				     FW_CTXT_ACTION_ADD);
 
@@ -342,7 +330,7 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 		int ret;
 
 		/* ... remove it here ...*/
-		ret = iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef, NULL,
+		ret = iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
 					     chains_static, chains_dynamic,
 					     FW_CTXT_ACTION_REMOVE);
 		if (ret)
@@ -356,7 +344,7 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 	ctxt->width = chandef->width;
 	ctxt->center_freq1 = chandef->center_freq1;
 
-	return iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef, ap,
+	return iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
 				      chains_static, chains_dynamic,
 				      action);
 }
@@ -376,7 +364,7 @@ void iwl_mvm_phy_ctxt_unref(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt)
 
 	cfg80211_chandef_create(&chandef, ctxt->channel, NL80211_CHAN_NO_HT);
 
-	iwl_mvm_phy_ctxt_apply(mvm, ctxt, &chandef, NULL, 1, 1,
+	iwl_mvm_phy_ctxt_apply(mvm, ctxt, &chandef, 1, 1,
 			       FW_CTXT_ACTION_REMOVE);
 }
 
-- 
2.34.1


