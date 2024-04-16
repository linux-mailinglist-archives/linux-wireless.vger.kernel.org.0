Return-Path: <linux-wireless+bounces-6391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430F58A692C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661771C20D74
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42DA12838A;
	Tue, 16 Apr 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTvzL6Xk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC6129E88
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264888; cv=none; b=FoGCYYzqIKa52aQ+BpaO7yK6d/Wv2dk7qDoMFUbaKrh7rLKjJoGomRVrQE0dn1jHtkjPC83tTgHSTdFaP9QFO/6RyxYU39xmE1pItS8pm2bAxJKKPldOBOSqKu0Quy4IKy+6hXuirF6NQo3jlHCv1yM5duGaXb2BUAFqNjlum8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264888; c=relaxed/simple;
	bh=nODaPKOSxm3sGFkjmAwoENCn9Io9N677AI0DoPn/t3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKHoX2KMp9jwwzWUCgUbc8oniO3zcpRWEDvrP9mh+F+akr7WEDAGccwwTGdaevjxdHAYmxFz1RRNJdtgN8w/FFtb/aVBuB4hRaoFDHTh3gXgCOgMgRGYrgjKwXUedvK7vuYIYXsu9/vbOwCz+RTxoHDr2ylrl8oj7L2E7La71OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTvzL6Xk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264887; x=1744800887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nODaPKOSxm3sGFkjmAwoENCn9Io9N677AI0DoPn/t3E=;
  b=PTvzL6XkeOGAFswYwbDoCY0TLPqItoi/XPxQbmmPFmy4HMAulislQ/J5
   zRZOULoi3ommNugw3SFz15BCSZJCJGMNYaNheKG+7CNnKR7qkWre49lsf
   Yomd/XorpOtTnM6vknyaMrlqNCio/5GIGeKHMgKIJLNFi/ODJCWuOtWXS
   1pnWO4GXy+n08MFLuNSPJNXzZ2I2o1jvt+FY2kqZviV7loBcsAdBwDxfK
   sjpoWUI1xZsPZj2vSCHDa5IqxeBPFsQ9gXkqoCgdGIfip8J+y8scEtVmh
   m6+E/k4JiRTxMMl+InLOe4dTMvL+3VtSyu3VQFbTS5VwHVgPOU6oLupSu
   w==;
X-CSE-ConnectionGUID: a8NYTC6wQ76yWILtPqxgPQ==
X-CSE-MsgGUID: zmxeyAgVRpCGSM7msT52kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556070"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556070"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:47 -0700
X-CSE-ConnectionGUID: pAM+SOg6ScmVQDJH2SNOtw==
X-CSE-MsgGUID: 5BL9wHOTT/y1YyxFGa3mFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872580"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 14/16] wifi: iwlwifi: mvm: get periodic statistics in EMLSR
Date: Tue, 16 Apr 2024 13:54:09 +0300
Message-Id: <20240416134215.6e19d596d77f.Ica2a75a031b1bced0dc2e18c5d365b5eb0d3ec07@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In EMLSR we need to track the RSSI of both links, and exit if the RSSI of
one of the links got too low.
For that request the FW to send statistics every 5 seconds when in EMLSR.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  6 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 22 ++++++++++++++++++-
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ddf27e6d2df2..c631de70253d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3987,6 +3987,10 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 
 		wiphy_delayed_work_cancel(mvm->hw->wiphy,
 					  &mvmvif->prevent_esr_done_wk);
+
+		/* No need for the periodic statistics anymore */
+		if (ieee80211_vif_is_mld(vif) && mvmvif->esr_active)
+			iwl_mvm_request_periodic_system_statistics(mvm, false);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 4016aaf91e6e..986176d94210 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -240,6 +240,9 @@ static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
 	else
 		mvmvif->primary_link = __ffs(vif->active_links);
 
+	/* Needed for tracking RSSI */
+	iwl_mvm_request_periodic_system_statistics(mvm, true);
+
 	return ret;
 }
 
@@ -283,6 +286,7 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 		ret = iwl_mvm_esr_mode_active(mvm, vif);
 		if (ret) {
 			IWL_ERR(mvm, "failed to activate ESR mode (%d)\n", ret);
+			iwl_mvm_request_periodic_system_statistics(mvm, false);
 			goto out;
 		}
 	}
@@ -406,6 +410,8 @@ static int iwl_mvm_esr_mode_inactive(struct iwl_mvm *mvm,
 			break;
 	}
 
+	iwl_mvm_request_periodic_system_statistics(mvm, false);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 0e0b8dae5284..050a04c185e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1776,6 +1776,8 @@ void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 void iwl_mvm_rx_statistics(struct iwl_mvm *mvm,
 			   struct iwl_rx_cmd_buffer *rxb);
 int iwl_mvm_request_statistics(struct iwl_mvm *mvm, bool clear);
+int iwl_mvm_request_periodic_system_statistics(struct iwl_mvm *mvm,
+					       bool enable);
 void iwl_mvm_accu_radio_stats(struct iwl_mvm *mvm);
 
 /* NVM */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index ab56ff87c6f9..74452b2112b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -344,6 +344,26 @@ static bool iwl_wait_stats_complete(struct iwl_notif_wait_data *notif_wait,
 	return true;
 }
 
+#define PERIODIC_STAT_RATE 5
+
+int iwl_mvm_request_periodic_system_statistics(struct iwl_mvm *mvm, bool enable)
+{
+	u32 flags = enable ? 0 : IWL_STATS_CFG_FLG_DISABLE_NTFY_MSK;
+	u32 type = enable ? (IWL_STATS_NTFY_TYPE_ID_OPER |
+			     IWL_STATS_NTFY_TYPE_ID_OPER_PART1) : 0;
+	struct iwl_system_statistics_cmd system_cmd = {
+		.cfg_mask = cpu_to_le32(flags),
+		.config_time_sec = cpu_to_le32(enable ?
+					       PERIODIC_STAT_RATE : 0),
+		.type_id_mask = cpu_to_le32(type),
+	};
+
+	return iwl_mvm_send_cmd_pdu(mvm,
+				    WIDE_ID(SYSTEM_GROUP,
+					    SYSTEM_STATISTICS_CMD),
+				    0, sizeof(system_cmd), &system_cmd);
+}
+
 static int iwl_mvm_request_system_statistics(struct iwl_mvm *mvm, bool clear,
 					     u8 cmd_ver)
 {
-- 
2.34.1


