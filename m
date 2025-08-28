Return-Path: <linux-wireless+bounces-26741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE01EB396E3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF3F1C23CB4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216BF2EA17D;
	Thu, 28 Aug 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gv2HKPXf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1632E091C
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369623; cv=none; b=oCvWwwC6Jv8lGEDTPA+Tm6mCEzE3CzThfjC+5da0/KIw7X3aIZrPQjrSHCQOeT332ooXLJuMinL1jbPDIhDMuswKUev9pMs1ptXOT76QQGWV8TIGYJAAi+F7Imw3RJz7NKoPQsnWlOQdCrNIKbKSaJ7N5O21BntjDfcD0+sWtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369623; c=relaxed/simple;
	bh=5ZoQ6aD3NPvhuDEyeC3J85szgxiJlbcHOO8z/9Bywbg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GsUSpmFsSJ/0KZ1KRNKFHpFHg1jq+3hwwO/Ur1axumtRSa73p5FZXYBjhhRacPmm2EmrAKUYoVzqUhG7ZZZxlxGiCBfDxOgR6vu8Io4T+zF1TMFaC+kj0PdeTE6nDaKu1aFtJaq7hUun2F4CsQsefD5NVblggwVCQskafEcr9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gv2HKPXf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369621; x=1787905621;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=5ZoQ6aD3NPvhuDEyeC3J85szgxiJlbcHOO8z/9Bywbg=;
  b=Gv2HKPXfQgEEsPKwEzK8+M/kGUVjmNZ0DJTsaKK6xLKefWaxIvCHCU6d
   EkjzUVXOYICjNvtKKdK/NQJfm9WUiVYq7MM9RnzliURY0VlZiaMkvhVNy
   cuQbRDB0BM37Rg7c9CXNY2hv9F+eULNcxWrchrmnCksRwQF1s6fQRMX4Q
   peLyZOeDq5wSQUkgl1lTsXMfwpMqCSOUNzttyKFa1/B43x5FDb6tHZzyr
   KsV0FD7Dl54J3ac2T8z+YRM2mrzs+6iiXs3mjMbBht72q/MnGpo6OYZKM
   +WPDZo9SBbb9rdSKRGZ/EH2LszWhyufaS7ZKR7v2oCIha9HEkX/QyIh45
   w==;
X-CSE-ConnectionGUID: U9MDkaU/RpqEhnXhoxOkOg==
X-CSE-MsgGUID: CV4xWQ3DSEq3RQbm9ePE3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003369"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003369"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:47 -0700
X-CSE-ConnectionGUID: hsGHj4PLQeercDFuViJ9xw==
X-CSE-MsgGUID: OCinxRSBSZOvxuqbPbHe1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224520"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: make iwl_mld_rm_vif void
Date: Thu, 28 Aug 2025 11:25:58 +0300
Message-Id: <20250828111032.418e898e908d.I18cc8d6b55a4e468dd155a40089ebea7de70594c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Unlike adding/allocating an object, destroying it should always
succeed. In addition, the return value of iwl_mld_rm_vif is not even
used.
Make it a void function.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 9 +++------
 drivers/net/wireless/intel/iwlwifi/mld/iface.h | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 38993d65c052..c4738400ee11 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -451,24 +451,21 @@ int iwl_mld_add_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 	return ret;
 }
 
-int iwl_mld_rm_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
+void iwl_mld_rm_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	ret = iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_REMOVE);
+	iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_REMOVE);
 
 	if (WARN_ON(mld_vif->fw_id >= ARRAY_SIZE(mld->fw_id_to_vif)))
-		return -EINVAL;
+		return;
 
 	RCU_INIT_POINTER(mld->fw_id_to_vif[mld_vif->fw_id], NULL);
 
 	iwl_mld_cancel_notifications_of_object(mld, IWL_MLD_OBJECT_TYPE_VIF,
 					       mld_vif->fw_id);
-
-	return ret;
 }
 
 void iwl_mld_set_vif_associated(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 38e10e279153..a3573d20f214 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -224,7 +224,7 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif);
 int iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			  u32 action);
 int iwl_mld_add_vif(struct iwl_mld *mld, struct ieee80211_vif *vif);
-int iwl_mld_rm_vif(struct iwl_mld *mld, struct ieee80211_vif *vif);
+void iwl_mld_rm_vif(struct iwl_mld *mld, struct ieee80211_vif *vif);
 void iwl_mld_set_vif_associated(struct iwl_mld *mld,
 				struct ieee80211_vif *vif);
 u8 iwl_mld_get_fw_bss_vifs_ids(struct iwl_mld *mld);
-- 
2.34.1


