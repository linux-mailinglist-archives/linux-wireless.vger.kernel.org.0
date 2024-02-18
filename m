Return-Path: <linux-wireless+bounces-3745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC91859852
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C50B2122F
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513756EB42;
	Sun, 18 Feb 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qd2KT5R7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B26F084
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278733; cv=none; b=D46tSPUnU4A3HtTRacKSOAsjfiZSQY873RoEsMzDZtd+/oVxbXRH7y8O5YqDwzv+UZF4yyJMMbONK30df/gsmgyv/0EMzwxoN7yq/bp3CLPCWKV8yVqtzWOx/rtu4RPINuihqyHxrYZFB1qMXMmIDOwXaXELzsXwxaDphjWLXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278733; c=relaxed/simple;
	bh=2FzC/WzIwb0BSLiISODiQ6iAf3NV+DFXwGGnpP+Wc54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mest7XhMcSQl7n71UdMpL/E/ugS1nIek9d/I2pI2lvQEVqoA58IqTfKkFYQ5dryZT3RWO0ocBWvxDANZpXbtXkn6NkjpgRJ/KB+d1PLtlb8xq1K0ysDx1daQNLBNweQy8QV8u1qqID2JTKuhaEQSRyZNCoGPMWv9Q36q0IHM0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qd2KT5R7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278730; x=1739814730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2FzC/WzIwb0BSLiISODiQ6iAf3NV+DFXwGGnpP+Wc54=;
  b=Qd2KT5R7LEh90/5MEy7nPDBMMORKU9VzB8Cemx+TqF/4EY4tk07mOgLr
   zSIY3mbQKRFgAWmi+T/UajF7eLtCb2qX4mKDx3rYy8RLP2AIBgMW/YZkY
   bXfR9HKz1i8BSBbU5z23o0jhfsmbqjW7huFYOx0OuEIDbyyVsbu6oU0WV
   tgV3H+vJXn+rMIYgU3P2MQjeg+BL+sUFt9PUNwQMdzmHb1DWsiSIIblAR
   RWR4/KkzXbWTMyYDHlZKia1vG/pCorR7lJ2dTtKnMc859/jIjt5VAtUpO
   mnkoj+iGezEJOfiC0/uYk4OjUIkWxR+/yF3M+505XLkZ5s7L4F1g7KEku
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464975"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464975"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459424"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/11] wifi: iwlwifi: mvm: support PHY context version 6
Date: Sun, 18 Feb 2024 19:51:44 +0200
Message-Id: <20240218194912.16d9f5fc41df.I9eeb55787d8483f820f5790e8874761f598da314@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Fill the new puncture mask in the PHY context command if
supported. In this case, also don't send it in the link
context command.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c     | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 129eefcc45d6..f13f13e6b71a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -204,7 +204,8 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			def = iwl_mvm_chanctx_def(mvm, ctx);
 
 		if (iwlwifi_mod_params.disable_11be ||
-		    !link_conf->eht_support || !def)
+		    !link_conf->eht_support || !def ||
+		    iwl_fw_lookup_cmd_ver(mvm->fw, PHY_CONTEXT_CMD, 1) >= 6)
 			changes &= ~LINK_CONTEXT_MODIFY_EHT_PARAMS;
 		else
 			cmd.puncture_mask = cpu_to_le16(def->punctured);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 5db44514d025..ce264b386029 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
@@ -224,6 +224,9 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 			cmd.sbb_ctrl_channel_loc = iwl_mvm_get_ctrl_pos(ap);
 		}
 
+		if (ver == 6)
+			cmd.puncture_mask = cpu_to_le16(chandef->punctured);
+
 		ret = iwl_mvm_send_cmd_pdu(mvm, PHY_CONTEXT_CMD,
 					   0, sizeof(cmd), &cmd);
 	} else if (ver < 3) {
-- 
2.34.1


