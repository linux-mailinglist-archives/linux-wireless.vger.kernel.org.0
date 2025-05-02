Return-Path: <linux-wireless+bounces-22343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9F5AA72AA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41F61BC304A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17025253B7B;
	Fri,  2 May 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvZHSKEz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2E24677A
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190609; cv=none; b=L5Wrist+P4+QKXTAX/aUwq7q4HLfLl6/W/XDFPFuTYZy/N9c4LhWBjrcndPYZ/i4AUu1M8EGX7VHUfYvruxDCcI8pruHNbvfi/ssWAUT7hlCxkZZSI++wpgLXMt5t2VwfOeho99LVe1qOA3QKWMRrx1bSBcnlZKJPS2nVuW77pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190609; c=relaxed/simple;
	bh=6ExVofQO/mGozoeImBBS0bn9JNgb1/lpowWmeQUb+q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4+tgDhb8grcv+FZ2yOsYXXgM9YpR40SLZymJgPf2TxTAo1VxsLb4MgJhq407lOgjyZmokDKWfKkXM1znhkHJP01Epola24VUPadCc/P4wNle6SbBi7mgX0hFpluKZ/EtT0rvi3hPs0iiDmapRq5nDGDJ8un11P4vRqKH+czR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvZHSKEz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190608; x=1777726608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ExVofQO/mGozoeImBBS0bn9JNgb1/lpowWmeQUb+q8=;
  b=DvZHSKEzz/vewhwuRE0IUjkTf3VqE82O4m1adEqW8Xw7tuCxJcf+Yblu
   aTuXpw2kqi9F5NsLGPqQYTS2xX40H9nKSyC7y80PhBke+Fa6Zb5t17Qso
   IPo6BAPIZjN2Yhn2jQOHKgwaeBvhVBXkeQf6kj9HSeylH4U22OIPHWyP/
   ElIi7ovTIIBwtzc0i82Lm39QpEK2wIL1fdTG5fepc1uXpMcQrqlwAOHLp
   8JSwxWk1cukVc2E4FqPqfMIH9l7zn4SbOT2ywU3CbDSInThmmDAaTCd+4
   bQfaLOv1DRAUOuq9gZQui8I4iMRB+suGmMv5KD0w19JktcJlAjZPRoyrz
   A==;
X-CSE-ConnectionGUID: AybB0iW6S7yAzEgNIO7AqQ==
X-CSE-MsgGUID: cRyJnejDQqm9ZB1ii4ctYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255533"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255533"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:47 -0700
X-CSE-ConnectionGUID: y8DocBf+TYWi1nCCdJFFCA==
X-CSE-MsgGUID: NZescXw4QACKZHi/l4+KUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554697"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: cfg: remove iwl_cfg_br
Date: Fri,  2 May 2025 15:56:17 +0300
Message-Id: <20250502155404.83b86e8a182b.Iec7f3027e7058005a98ff6d05cc224ab61b7c44a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is the same as iwl_cfg_dr, just different by the MAC,
so no need to keep a separate config; remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c     | 4 ----
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 2 +-
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 4bca1b13858f..8bbeb2a1f691 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -154,10 +154,6 @@ const struct iwl_cfg_trans_params iwl_br_trans_cfg = {
 
 const char iwl_br_name[] = "Intel(R) TBD Br device";
 
-const struct iwl_cfg iwl_cfg_br = {
-	IWL_DEVICE_DR,
-};
-
 MODULE_FIRMWARE(IWL_DR_A_PE_A_FW_MODULE_FIRMWARE(IWL_DR_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BR_A_PET_A_FW_MODULE_FIRMWARE(IWL_DR_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BR_A_PE_A_FW_MODULE_FIRMWARE(IWL_DR_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 8862148a49bb..1ecd873911bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -642,7 +642,6 @@ extern const struct iwl_cfg iwl_cfg_bz;
 
 extern const struct iwl_cfg iwl_cfg_sc;
 extern const struct iwl_cfg iwl_cfg_dr;
-extern const struct iwl_cfg iwl_cfg_br;
 #endif /* CONFIG_IWLMLD */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 6c4854f44b26..b96b85e7d5d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1152,7 +1152,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_cfg_dr, iwl_dr_name, MAC_TYPE(DR)),
 
 /* Br */
-	IWL_DEV_INFO(iwl_cfg_br, iwl_br_name, MAC_TYPE(BR)),
+	IWL_DEV_INFO(iwl_cfg_dr, iwl_br_name, MAC_TYPE(BR)),
 #endif /* CONFIG_IWLMLD */
 };
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table);
-- 
2.34.1


