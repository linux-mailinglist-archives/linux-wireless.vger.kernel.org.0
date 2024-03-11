Return-Path: <linux-wireless+bounces-4546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018DB877AF5
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAB4281E0D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F575179AD;
	Mon, 11 Mar 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giKqmhns"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5617578
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138539; cv=none; b=qsqa5NoquSYg/yzMwZsTckf6dqIcpmCm6SHnVR44fF2PtZEurlX+vT775u0u0oLhoj4N9u1D9nazqHSLPSfZoZaCWWGbLzifzdpNDdmhc5pU2n0uY4tOf/1BGrlWTyvLTR+sfdiJlp4mSyZGcvaZLoJryvxkeV1lp8+DZFBthms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138539; c=relaxed/simple;
	bh=OCq8dxe/4zvZnf5Xjc4sPMghFsEJ22Vw7dnUgYv28DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+m2LJXhbgt86aTovvyCQqL2EUI9ZuBuwX9YX1pcE6QtAMf8O+C9uNPacQmWcd/cFRekRioJ9fYPhargI4+54NnC6gTpskx3J14V34MCkK0+9D6gf/R4266o9lLxzXMH97Nyjezdq352+9PMsbYyJyFhi7V/w8oIpfs8N61DYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giKqmhns; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138538; x=1741674538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OCq8dxe/4zvZnf5Xjc4sPMghFsEJ22Vw7dnUgYv28DQ=;
  b=giKqmhnssaKp7qYFDnyMAW74nwnBCUcWP0AEk6XVBPeJP82pApkT1YEx
   p5dzCY2OuHqMHU58mncLUTeR52D01sMkgwI0J/KzQNq9lTJNGkM+6qu+q
   ULEhoeci9Ldk+XexeeKaP9zvIlmSXVeMd4jbyOj+KS2JT+VJHdQgwkGbq
   LeWTkGSkPlt3SfUZVRkhUwydcc4zVi+JHdrnwoN+VZqlTkFYNgfbpvVTQ
   mKCBU/vPZvMwhSqgWZUFfVWhVuqh4fgjKjV8eS/sKYXSf2QXIYQYHhTI3
   uRaFf2vhJdiejRwgnP1rp8rKLCBxxBKRbM4iBi45mlXwrDbmmrYLWI8rI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226805"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226805"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657733"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: add debugfs for forcing unprotected ranging request
Date: Mon, 11 Mar 2024 08:28:14 +0200
Message-Id: <20240311081938.bf7303f075a1.I7ab6c547513717e69ec385f72a8f43ea00bd9e0a@changeid>
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

From: Avraham Stern <avraham.stern@intel.com>

Add an option to force sending unprotected ranging request even if the
station is associated to the responder or a PASN keys are configured.
This is used for testing.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c    |  3 ++-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c  | 13 ++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index ea5488721977..2f1dfb1727c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -738,7 +738,8 @@ void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	MVM_DEBUGFS_ADD_FILE_VIF(rx_phyinfo, mvmvif->dbgfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE_VIF(quota_min, mvmvif->dbgfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE_VIF(os_device_timediff, mvmvif->dbgfs_dir, 0400);
-
+	debugfs_create_bool("ftm_unprotected", 0200, mvmvif->dbgfs_dir,
+			    &mvmvif->ftm_unprotected);
 	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
 	    mvmvif == mvm->bf_allowed_vif)
 		MVM_DEBUGFS_ADD_FILE_VIF(bf_params, mvmvif->dbgfs_dir, 0600);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 4863a3c74640..4fc18372cd4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/etherdevice.h>
 #include <linux/math64.h>
@@ -551,6 +551,11 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			break;
 		}
 		rcu_read_unlock();
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+		if (mvmvif->ftm_unprotected)
+			target->sta_id = IWL_MVM_INVALID_STA;
+#endif
 	} else {
 		target->sta_id = IWL_MVM_INVALID_STA;
 	}
@@ -713,6 +718,12 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_mvm_ftm_pasn_entry *entry;
 	u32 flags = le32_to_cpu(target->initiator_ap_flags);
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (mvmvif->ftm_unprotected)
+		return;
+#endif
 
 	if (!(flags & (IWL_INITIATOR_AP_FLAGS_NON_TB |
 		       IWL_INITIATOR_AP_FLAGS_TB)))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2421f1f5222c..1705791f30af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -437,6 +437,7 @@ struct iwl_mvm_vif {
 	struct iwl_dbgfs_bf dbgfs_bf;
 	struct iwl_mac_power_cmd mac_pwr_cmd;
 	int dbgfs_quota_min;
+	bool ftm_unprotected;
 #endif
 
 	/* FW identified misbehaving AP */
-- 
2.34.1


