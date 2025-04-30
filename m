Return-Path: <linux-wireless+bounces-22268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0DBAA4C69
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D25175B9D
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134325DB1F;
	Wed, 30 Apr 2025 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAmMkKqY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF132609D8
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017874; cv=none; b=LAcP05Z7V/EzjMFDoZrsgHrAGSyWSdsVkpEACHZr8cJ0Y4z271q4vlPJfW1BA1pQ2KSqaC7YXFKJyg4JgEOotHtxDCWraee6aoLBB+7a2ZOUXcs+slVR+5QFO9JX37QWtiEuT18T9/DwP86x1s+zrym8SvpN3wlyHYEBr6PhnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017874; c=relaxed/simple;
	bh=Zr0ixprYzERzsRY7xAaVqJAlaV1ewQznDHINijW6eJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhOvb8E0bBRh33O/edpN80EVL1gEaxwz/zxYAebPpNmBr6ZGu6C0S5lkkAmIn7LTKJYepkhwUohdG0MHPI8Ze41VKbNSE/aBVdX51Zv5A4s9prxYlkkgn9gkkrxlmFkgYjq1LfU0howIcLc7IkRH+CWt3XqnmRk9ApJQEaqxZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAmMkKqY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017873; x=1777553873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zr0ixprYzERzsRY7xAaVqJAlaV1ewQznDHINijW6eJ4=;
  b=CAmMkKqYJGlVmFC1dJlss+6V4QTwj8WXwMvBMCwsXJm30VtuMzx9G0m4
   PllyRwtJEhMWOzKIXSxr2blH28X3DLqu3okA7+U2j27Eq+uZE0o5KJ8bw
   +QtKApGs8lhbAI6TsLp9nZJxYr/MuCcSYqyhwnN0l43iB5f8K1c5/dpgv
   VOUMq5N7whbFuvNbnkiZBzGFjfMFLmcIXdCxiqmXCMPhAJVA2W4XiVJF6
   n1agCBgIK+9uYM0Qce2yqpdEf4Xokp9KDcnq8yUNdtIpkgHEp8aJjxq5c
   h2GHAhX0nb1FNkLPAmaBDWDX1ZsCu5JKxd8D0n3h52zhGfkvH5cyV40HU
   g==;
X-CSE-ConnectionGUID: e2cHxZDaTDSCK3TAfX9SQQ==
X-CSE-MsgGUID: N6miLv1NTS+mo/zLzbQldg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332341"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332341"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:53 -0700
X-CSE-ConnectionGUID: BfxAiWyDRLmEMZhMi24Rnw==
X-CSE-MsgGUID: jyZw8zn9SOundB30aOB5Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632106"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mvm: support iwl_mac_power_cmd version 2
Date: Wed, 30 Apr 2025 15:57:21 +0300
Message-Id: <20250430155443.5c9a0181a84b.I9a03bc07a7b3f6e37cc1c0c1af5719e765a05897@changeid>
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

This version fixes the issue that was worked around by
iwl_mvm_smps_workaround. So for FWs with the new version don't do the
workaround, and set new bit added in this version when appropriate.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c    | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5d8f50a455d7..70b2cdace86d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4105,7 +4105,8 @@ void iwl_mvm_smps_workaround(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (!iwl_mvm_has_rlc_offload(mvm))
+	if (!iwl_mvm_has_rlc_offload(mvm) ||
+	    iwl_fw_lookup_cmd_ver(mvm->fw, MAC_PM_POWER_TABLE, 0) >= 2)
 		return;
 
 	mvmvif->ps_disabled = !vif->cfg.ps;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index a386b315e52f..0057fddf88f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -376,6 +376,9 @@ static void iwl_mvm_power_build_cmd(struct iwl_mvm *mvm,
 	if (!vif->cfg.ps || !mvmvif->pm_enabled)
 		return;
 
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, MAC_PM_POWER_TABLE, 0) >= 2)
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_ENABLE_SMPS_MSK);
+
 	if (iwl_mvm_vif_low_latency(mvmvif) && vif->p2p &&
 	    (!fw_has_capa(&mvm->fw->ucode_capa,
 			 IWL_UCODE_TLV_CAPA_SHORT_PM_TIMEOUTS) ||
-- 
2.34.1


