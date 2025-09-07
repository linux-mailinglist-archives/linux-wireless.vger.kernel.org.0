Return-Path: <linux-wireless+bounces-27061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7462EB479A9
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6982C1B2193E
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16E821CA0E;
	Sun,  7 Sep 2025 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7atQfaU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F34221DB3
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233871; cv=none; b=tSwtTVdFAKcVy4G3y6MDsec0SmiS/pBmzOLGEinUGG5gJVErtoiOHS6IJKSGGq/YT+PW/abzSYNUZFzD5D7LeHEDCeZuhEbnik+OV/3NldNRcBDdl91GlceQ1LhfHGkg/xe4/KdApJGVNm7o3INSdWCpaTs10BcFRoJDfB5zBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233871; c=relaxed/simple;
	bh=S0MpRMJVB6L05yxZURjA8gdJqAldSKlrFZx3LlMkkk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpwp0RTegpHkAwHxHaawSJuQtmZwrmU0EfJNj9SFZcVnKEXcd+xRXXKlv+nckCXNGQXqlQWi0Q6KepoFKs1vX2rd216GxLaCzTFuFOQr9BOMOfhj4dsnDkH5aJeI7vdnbrV1Ljo/Tm/3IDaEUp8gPVzT0+/ax2/3IljoG7ycnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7atQfaU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233870; x=1788769870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0MpRMJVB6L05yxZURjA8gdJqAldSKlrFZx3LlMkkk4=;
  b=e7atQfaUDTUAmJv+CtamV97ZqNxYDHq52jfRGngRELVn1vBjpdlgJF+8
   3BNBMpoZcEgYsE93gz2R8rOq+LghW6HogFJtteonndCA3lo5sIU3+kfTG
   eAJoi8jUhEiPEkC3o2kTMG7TZtIaanD5FsQ0/872PlGSCHHKlJtrin4/u
   MUu7DH3JcW23xxRnoFEsirIe/MxTbVhzHAwocB3G+GPpQG+XJO7fl847v
   N34jw/ahSKsdRy6Ieds+BODIpecN6U7KFCDZbPCbm8pZGbsSg0e3DCxas
   ZnaY590AMkxlAY7XZIp1G8K/pSgwKv7qaYA6BsRWOUR3XZPVk7LWCeE4q
   w==;
X-CSE-ConnectionGUID: cYhPmWj4Si21ekqAJXmL7Q==
X-CSE-MsgGUID: vCI/pqQJT3SKn9xm9BpsXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973627"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973627"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:10 -0700
X-CSE-ConnectionGUID: 9tp/fi3xSWiGn9v1H2baUg==
X-CSE-MsgGUID: /WJJx8dmT5iDpBrb5XJrRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790086"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: remove support of iwl_esr_mode_notif version 1
Date: Sun,  7 Sep 2025 11:30:13 +0300
Message-Id: <20250907112757.d118e8b65513.Ibb8636e826136c8c31931e77f5ffa853372b4301@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The last FW API that supports version 5 is 99. Since this API is no
longer supported on any device that loads iwlmld, we can remove support
of it.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 28 ++++++-------------
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  1 -
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 99a9219438a6..241a6271d13d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -357,38 +357,26 @@ iwl_mld_vif_iter_emlsr_mode_notif(void *data, u8 *mac,
 				  struct ieee80211_vif *vif)
 {
 	const struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	enum iwl_mvm_fw_esr_recommendation action;
-	const struct iwl_esr_mode_notif *notif = NULL;
-
-	if (iwl_fw_lookup_notif_ver(mld_vif->mld->fw, DATA_PATH_GROUP,
-				    ESR_MODE_NOTIF, 0) > 1) {
-		notif = (void *)data;
-		action = le32_to_cpu(notif->action);
-	} else {
-		const struct iwl_esr_mode_notif_v1 *notif_v1 = (void *)data;
-
-		action = le32_to_cpu(notif_v1->action);
-	}
+	const struct iwl_esr_mode_notif *notif = (void *)data;
+	enum iwl_mvm_fw_esr_recommendation action = le32_to_cpu(notif->action);
 
 	if (!iwl_mld_vif_has_emlsr_cap(vif))
 		return;
 
 	switch (action) {
 	case ESR_RECOMMEND_LEAVE:
-		if (notif)
-			IWL_DEBUG_INFO(mld_vif->mld,
-				       "FW recommend leave reason = 0x%x\n",
-				       le32_to_cpu(notif->leave_reason_mask));
+		IWL_DEBUG_INFO(mld_vif->mld,
+			       "FW recommend leave reason = 0x%x\n",
+			       le32_to_cpu(notif->leave_reason_mask));
 
 		iwl_mld_exit_emlsr(mld_vif->mld, vif,
 				   IWL_MLD_EMLSR_EXIT_FW_REQUEST,
 				   iwl_mld_get_primary_link(vif));
 		break;
 	case ESR_FORCE_LEAVE:
-		if (notif)
-			IWL_DEBUG_INFO(mld_vif->mld,
-				       "FW force leave reason = 0x%x\n",
-				       le32_to_cpu(notif->leave_reason_mask));
+		IWL_DEBUG_INFO(mld_vif->mld,
+			       "FW force leave reason = 0x%x\n",
+			       le32_to_cpu(notif->leave_reason_mask));
 		fallthrough;
 	case ESR_RECOMMEND_ENTER:
 	default:
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index f17aeca4fae6..884973d0b344 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -333,7 +333,6 @@ CMD_VERSIONS(bt_coex_notif,
 CMD_VERSIONS(beacon_notification,
 	     CMD_VER_ENTRY(6, iwl_extended_beacon_notif))
 CMD_VERSIONS(emlsr_mode_notif,
-	     CMD_VER_ENTRY(1, iwl_esr_mode_notif_v1)
 	     CMD_VER_ENTRY(2, iwl_esr_mode_notif))
 CMD_VERSIONS(emlsr_trans_fail_notif,
 	     CMD_VER_ENTRY(1, iwl_esr_trans_fail_notif))
-- 
2.34.1


