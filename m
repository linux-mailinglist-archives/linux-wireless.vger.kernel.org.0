Return-Path: <linux-wireless+bounces-16989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8169FFA64
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF571629C4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5E31B4F23;
	Thu,  2 Jan 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIB90LPz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E01B4F14
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827642; cv=none; b=m5dkOs1TG9Eh5FdCYWzui8E4aUvsI3TZRRaqLTMO8EjsMPjq8BLyMQOGhASoEVgByuQi8rUZYcUz/Mz6ZagRBn055qzCoLr5jmF8Y1DuSK9j7fMbuIuXyTwuvJwUOe+HYzRyIYYSEmbi8F47hyoexcXQy1jaLPcOz/N0ZPbLQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827642; c=relaxed/simple;
	bh=L12LwHolbApbTKvjzvTuQ/p2qojRdHgGiIioGYvka44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tiu9UrfwKj6IQKjXg5QUV6HODgLoj1BNwq2iKsBTKOYXqoVWac4XTube7SCGtOdH3XXkfLv1IvhxwG7rkvkEHJqAPuo1YrxJVpa7tvIpsP0MK0R4FbnIhyrSXvFdMHnymJq2lqg1eJTgAmvV4RUwsV+VmNibi6PG09OJYBEAvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIB90LPz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827640; x=1767363640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L12LwHolbApbTKvjzvTuQ/p2qojRdHgGiIioGYvka44=;
  b=gIB90LPzwvN5sMeLzTH48zrGcQzlGl42PBkWCBG9fHGfIPVTFPb31ZOJ
   ImKfQN4tN9Gf7/chBSqY3XIsTboWSR6z801/WW9wpsqms21I74TJHc6BP
   nr17xVch5RIrhfUYvVFyv+Qh6FsTj7AXqk7kBlqYpqfiAFSvnBJI3fCyc
   l93PGJczrgRHENVstULASvtYLoqIiMm2mC1kuXlovuxwVWNssLQ9cuHt5
   XCSqm4Aqupy4Rn5cERcXbhoWH74C4h520zhrsBvi3aCxaWoyGdB+94+fS
   j6+Y4w7EjRZlaPbHEmOPnVZqUIawTrTjnujUWjp5fCOno+OO9waZpVEmk
   A==;
X-CSE-ConnectionGUID: JdPapHPlQXCTJ7vPLnrFiw==
X-CSE-MsgGUID: n18ixUolSSqYzbgExhfkdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735121"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735121"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:40 -0800
X-CSE-ConnectionGUID: nMpqs3Q0QYaypSUoxiFmCg==
X-CSE-MsgGUID: 1OKhVjlqQpmn9NCUB23YiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357420"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/17] wifi: iwlwifi: simplify nested if checks
Date: Thu,  2 Jan 2025 16:20:03 +0200
Message-Id: <20250102161730.7ddc9cb1ea50.If18bd94706d6c821e34c38a4704bf85dca6207b2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the absence of (an) else clause(s), "if (a) if (b)" is
equivalent to "if (a && b)", so simplify the code a bit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c     | 7 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/link.c        | 5 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 6 +++---
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/binding.c b/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
index 458b97930059..58e9a940024d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2012-2014, 2020 Intel Corporation
  * Copyright (C) 2016 Intel Deutschland GmbH
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022, 2024 Intel Corporation
  */
 #include <net/mac80211.h>
 #include "fw-api.h"
@@ -158,9 +158,8 @@ int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	ret = iwl_mvm_binding_update(mvm, vif, mvmvif->deflink.phy_ctxt,
 				     false);
 
-	if (!ret)
-		if (iwl_mvm_sf_update(mvm, vif, true))
-			IWL_ERR(mvm, "Failed to update SF state\n");
+	if (!ret && iwl_mvm_sf_update(mvm, vif, true))
+		IWL_ERR(mvm, "Failed to update SF state\n");
 
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 272da41567ef..80c175cc9873 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -412,9 +412,8 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_REMOVE);
 
-	if (!ret)
-		if (iwl_mvm_sf_update(mvm, vif, true))
-			IWL_ERR(mvm, "Failed to update SF state\n");
+	if (!ret && iwl_mvm_sf_update(mvm, vif, true))
+		IWL_ERR(mvm, "Failed to update SF state\n");
 
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 8903a5692dfb..a822448ad5ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -139,9 +139,9 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	if (trans_pcie->is_down)
 		return;
 
-	if (trans->state >= IWL_TRANS_FW_STARTED)
-		if (trans_pcie->fw_reset_handshake)
-			iwl_trans_pcie_fw_reset_handshake(trans);
+	if (trans->state >= IWL_TRANS_FW_STARTED &&
+	    trans_pcie->fw_reset_handshake)
+		iwl_trans_pcie_fw_reset_handshake(trans);
 
 	trans_pcie->is_down = true;
 
-- 
2.34.1


