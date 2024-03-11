Return-Path: <linux-wireless+bounces-4538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F2877AED
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25498B20C5A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82E125B2;
	Mon, 11 Mar 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwMRnrlD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55211CA0
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138521; cv=none; b=HsSD2xDRo/nXc6Wjn2mchg9/rh2CTQll78AlEJxJDR4fhqa/K3rQl+5Cx7LXKwofPPTyoeUb8rXurN7tZ+sNWRJtD9uM4WL8OKR/NtjBWRZu6Xt5A7z6yBbvjokzfd8i7Go6fClsVlq91dlYr+sp0qHCbmxtSdO7zKvcYTn+Z5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138521; c=relaxed/simple;
	bh=0E7v9x2pnLo9rfSG3QvgmO/AW/iq+DTNzLPNs5rAEVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZ0Ef/VbaoP8XqZc9IMxw3yF1u/9nuZg6iTXsQ/tCr0EK6meMM1X0vETmMC62b9CQqEF9LYkctimsXtnE2njMYwoGGKJXZVSrmi80Z3kXq7ifK0M8M42/tJCZpJx2UGSBbzqc5HvObb7qpFGBQi3Svvj2quA1DZa2V5EHhlWiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwMRnrlD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138519; x=1741674519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0E7v9x2pnLo9rfSG3QvgmO/AW/iq+DTNzLPNs5rAEVc=;
  b=kwMRnrlDDoxw9Va9eADrLbjqPyPDXDhyVH6N96No0L5J9kuJR5CvicAA
   sRGuBHDxxSKsdcTzk1kdJoX/eFWJdOvRZ5PGzYBP3tIn6E9EWOkFK5tSf
   33ZPdgxRxCAAf3ivCjvdOD2LCLdBVsyIkqh+lknoAiqtAMBwAk8x7et35
   x4wuJoV7gUFiv2OD+T13e6FzEq0BozNQzxQd4G+PdCqouzC++vcphjAsg
   odEdFkk3fJqA1ZyiKYsnGhdLG/KR8f5U//caHfmsg0+J0aAi5obuXgink
   WYCEpbFVwiq8RStq6nUNXX8/U7AOVZ7HTmPk/maIQWBYv8+ylpagXzEdT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226756"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226756"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657656"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: fix the sta id in offload
Date: Mon, 11 Mar 2024 08:28:06 +0200
Message-Id: <20240311081938.ace4f793872d.Id984110576a72acc84493217ca95564c3cd362bd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

With MLO, the station id in wowlan can be other than 0.
Set the correct station in the protocol offload command.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c         | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/offloading.c | 8 ++++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 1a235b0c5593..d3dda2678cc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1152,7 +1152,8 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 	if (ret)
 		return ret;
 
-	return iwl_mvm_send_proto_offload(mvm, vif, false, true, 0);
+	return iwl_mvm_send_proto_offload(mvm, vif, false, true, 0,
+					  mvm_link->ap_sta_id);
 }
 
 static int
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f932a4382912..e9da4d2bc13a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2112,7 +2112,8 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif,
 			       bool disable_offloading,
 			       bool offload_ns,
-			       u32 cmd_flags);
+			       u32 cmd_flags,
+			       u8 sta_id);
 
 /* BT Coex */
 int iwl_mvm_send_bt_init_conf(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
index dfb16ca5b438..1eb21fe861e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2021-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2021-2022, 2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
@@ -30,7 +30,8 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif,
 			       bool disable_offloading,
 			       bool offload_ns,
-			       u32 cmd_flags)
+			       u32 cmd_flags,
+			       u8 sta_id)
 {
 	union {
 		struct iwl_proto_offload_cmd_v1 v1;
@@ -205,6 +206,9 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 	if (!disable_offloading)
 		common->enabled = cpu_to_le32(enabled);
 
+	if (ver >= 4)
+		cmd.v4.sta_id = cpu_to_le32(sta_id);
+
 	hcmd.len[0] = size;
 	return iwl_mvm_send_cmd(mvm, &hcmd);
 }
-- 
2.34.1


