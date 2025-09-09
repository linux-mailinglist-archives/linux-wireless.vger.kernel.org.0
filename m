Return-Path: <linux-wireless+bounces-27133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4882EB49FFE
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C5E4E07E2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4812D24BC;
	Tue,  9 Sep 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpXjDW+s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180362D4B7F
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388135; cv=none; b=Vxlc6z504vNe36dRWsuNtaTFUjcOWKekqambEHQghe5juugfmSJyyZQ8dEBxU3sGzU/1/DxCb59T84f6Y6JjUg0XFltIFpyz2Zly45bTAY0kS7byxr92kbcJSangrMeYroJR/dxQIvbNjlA9jVB0XkvmiL/2zAsNNgmFYxPPa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388135; c=relaxed/simple;
	bh=S0MpRMJVB6L05yxZURjA8gdJqAldSKlrFZx3LlMkkk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fyi/JNA2+IxH0DryRUGBf4oKk+/Dyc6X27Wkx5Ga41+iiL0t41kEXTimfTU3iiX5aWxkfEDdvBayJPbGUkJc4etbnPS9ZXo2dZe7gDV7H2JwUWhI/Jazs+n+jRTuIkEd18DwkS1/IQHdUIEZPYJowTv9KRicuLaf4ltj5kzJLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpXjDW+s; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388134; x=1788924134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0MpRMJVB6L05yxZURjA8gdJqAldSKlrFZx3LlMkkk4=;
  b=NpXjDW+sycu/UrV9u/82PSzNisy23HupsSNxyk1nXsCIN9XGTHGAFqQP
   jOcY13VuCWKr3nBOKL1hSexH3tiI+gwg+Qhhw7qBOx6zDFxc3KXSes/3J
   js3D8YyJ8je2Vq/3DmISYecNTnZpTVhMeZHHGS/zzfRpbPkhncXYxZhd/
   TN7BJsXnf4txsu3h2wnEktN3q6taPBd4p23mFLwYD3ASQIaJMq1H0lKx9
   k3PKAbzH8jvH1OyKqqcZRZPJZKAv9rhWfwnazKHwggx2bQ1N2TXdF9KJY
   R56dVAjAerC9o6rSlpDEjiNDxvfKPKekEZCBaevUZZK/U5FZ4lcG+MjLH
   A==;
X-CSE-ConnectionGUID: G0wrsJxoQrirOTu0wS77oQ==
X-CSE-MsgGUID: JmCQGWBATxu5yfR+JT1yhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281082"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281082"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:14 -0700
X-CSE-ConnectionGUID: 0AcyPjzgQgeOeHED7lvHSQ==
X-CSE-MsgGUID: zWFoJsQuQu2uCTtnnGhbPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950406"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 14/15] wifi: iwlwifi: mld: remove support of iwl_esr_mode_notif version 1
Date: Tue,  9 Sep 2025 06:21:27 +0300
Message-Id: <20250909061931.e15a7fa15c70.Ibb8636e826136c8c31931e77f5ffa853372b4301@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
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


