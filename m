Return-Path: <linux-wireless+bounces-3234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2834B84BA84
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB081C23A9B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC813341F;
	Tue,  6 Feb 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhfdu0if"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04381134CC0
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235353; cv=none; b=e3tSqXwVAOZPu+ChH4PImNOLYjbULI2VZpNvoQxh0MH1KlBOJumRS2FjdIFRsuadGCGHLzZHhFp+Efftx10AolMp9af5vcbVWlJn9Y8NI1jz8IMYFAnoabnGch3dGvOde7T5zt+vGFCKTaVckDbLpPZa+/XBfFpauEBWTTKkb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235353; c=relaxed/simple;
	bh=u6GrYaO/pM92as946RbYERkBctBpt6hdhoubiHy8hb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TfMzT4dpvVB5MTIkhVaTJyoyU/pTBjsltkzKE6lt8uEFgGmRXjnsSzPwKxhLdW3IV8nxn+8Splf49BcjMNr5PFUpBVZSK9PFtCTcB0y7H5YGofR0lUqc+0+42JQXNva0hyQj1CBbmf9ITTOrb96oZ+wF9F3xJvsWlJjlhf/9lm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhfdu0if; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235352; x=1738771352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6GrYaO/pM92as946RbYERkBctBpt6hdhoubiHy8hb4=;
  b=jhfdu0if2b6iIbDH8qm6gno46+9xLXYQsoGBOlmFnD6uDLm/xEvOZmSK
   xk3xClEixsVVg/wRNBwoEVl87oQYqp+a36aLl9ZmYYH44UaHvkiWO3ZPd
   OO6G5fpZQXzN0nbS9h65OfNicPzuzS+95f1MbEE94atNmOEsRImBTAcND
   R/u9R0BXfWLZ7XBs7a/iiM4Il3M3qIR2YVcWFGwHz3FfeRll9nj7wI7Yi
   zIgysoO6aULNe8+G2WZ/iSefPycfzu2sXTyVBUF1/dKGJWUVnNOV9Sg05
   R7RsYIv+B2p4EeDKDrEEhIZGCKyvEKHv6YDyOqU9IdVrkhuBjWy/eV8MH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252316"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252316"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349823"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:30 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 03/11] wifi: iwlwifi: mvm: don't set the MFP flag for the GTK
Date: Tue,  6 Feb 2024 18:02:06 +0200
Message-Id: <20240206175739.2f2c602ab3c6.If13b2e2fa532381d985c07df130bee1478046c89@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
References: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware doesn't need the MFP flag for the GTK, it can even make the
firmware crash. in case the AP is configured with: group cipher TKIP and
MFPC. We would send the GTK with cipher = TKIP and MFP which is of course
not possible.

Fixes: 5c75a208c244 ("wifi: iwlwifi: mvm: support new key API")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c   | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index bbd37a95d4c8..8a38fc4b0b0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 - 2023 Intel Corporation
+ * Copyright (C) 2022 - 2024 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <net/mac80211.h>
@@ -62,11 +62,13 @@ u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 			  struct ieee80211_key_conf *keyconf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	bool pairwise = keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE;
+	bool igtk = keyconf->keyidx == 4 || keyconf->keyidx == 5;
 	u32 flags = 0;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (!(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+	if (!pairwise)
 		flags |= IWL_SEC_KEY_FLAG_MCAST_KEY;
 
 	switch (keyconf->cipher) {
@@ -96,12 +98,14 @@ u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 	if (!sta && vif->type == NL80211_IFTYPE_STATION)
 		sta = mvmvif->ap_sta;
 
-	/* Set the MFP flag also for an AP interface where the key is an IGTK
-	 * key as in such a case the station would always be NULL
+	/*
+	 * If we are installing an iGTK (in AP or STA mode), we need to tell
+	 * the firmware this key will en/decrypt MGMT frames.
+	 * Same goes if we are installing a pairwise key for an MFP station.
+	 * In case we're installing a groupwise key (which is not an iGTK),
+	 * then, we will not use this key for MGMT frames.
 	 */
-	if ((!IS_ERR_OR_NULL(sta) && sta->mfp) ||
-	    (vif->type == NL80211_IFTYPE_AP &&
-	     (keyconf->keyidx == 4 || keyconf->keyidx == 5)))
+	if ((!IS_ERR_OR_NULL(sta) && sta->mfp && pairwise) || igtk)
 		flags |= IWL_SEC_KEY_FLAG_MFP;
 
 	if (keyconf->flags & IEEE80211_KEY_FLAG_SPP_AMSDU)
-- 
2.34.1


