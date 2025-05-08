Return-Path: <linux-wireless+bounces-22745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E52AAF982
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A89F7BF999
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C462253E8;
	Thu,  8 May 2025 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc4V4SaT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87B225776
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706413; cv=none; b=WqDmUfz0vQRs/IfMp8Dunv3bEACbd+B6Qrx4lmtK76Tcxwe08aJs29Qe5P0q/MSAdDOhx+gwizyqm7xgQDbepgN4LG5lawxoVzJO/GQqJ71lAwCBfeVAk1felwJYIBaGPtT7w4r6iGst2RhZvT0KMGwgzzf4QlTFNmWYQOekwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706413; c=relaxed/simple;
	bh=5nrDWQkGGOSAOV3mrg9Mxc+GQ+pqXEcCdd0P2Axaxl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iaQyKWz6FWzVrgXd9/7lF5OWytpv/+MafUkQKVfj9nzT3MDUjiasO6IU0F4bC8snk/xtCYmJB9iqRKlka8Cym+eoCx5DtGJuieSNXNUu00Pnc5ENnfhKFYNWg7EcagzOPnqwkAUaJK5iNQ1OfAu0AYuerPgqNqvtJwJDR0Vqzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc4V4SaT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706412; x=1778242412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5nrDWQkGGOSAOV3mrg9Mxc+GQ+pqXEcCdd0P2Axaxl4=;
  b=Sc4V4SaTld4DzJCWLnnSkULooDsTGSaG7J8w1fWu7oyHRoUaluI77FQB
   CLa+owJsQP4TrUIZKMDoi0Hg96TZ9W5iRRH+W2Yd/0iHAjAlJX2pwZIxR
   tVJLIA/euRlgN2yjhb72F5IT04cxRwif8BCCUB2Ec0DTnKpJ1HXgTJIs5
   uBCsx+xipJs/0CNx3+78T9NLUoi6p1Q3McShcRmica9Y60hYv/M9u035W
   tV99Mmrq2u6w+o9UMoJjdSB5qH5CX+2vStLzosD2RWVswZkM1VSeXFPNA
   OflXPeV192zjbN6GxK69QjHfBiSVK+2ZXlBUFP+UQLW7XFxYGqhNWMFMc
   Q==;
X-CSE-ConnectionGUID: Va46i3xETCO7qk7zCHSLhA==
X-CSE-MsgGUID: LWVyikkuQjagPchgFSYmMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688042"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688042"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:32 -0700
X-CSE-ConnectionGUID: 001QMs/RSfm3L253oInsqA==
X-CSE-MsgGUID: KzXCg+o/RYeDSHiaGkLXuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347829"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: pass trans to iwl_parse_nvm_mcc_info()
Date: Thu,  8 May 2025 15:12:58 +0300
Message-Id: <20250508121306.1277801-8-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
References: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to pass various different pointers when
the transport is already established, so just pass that
instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.42da295af3ec.Iea24ca1d33eb70b66a3145a005aabb9b5c63dc09@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  4 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h | 12 ++++++++++--
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  2 +-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 87f927ed2c6e..96dc27b93db1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1744,10 +1744,12 @@ static struct iwl_reg_capa iwl_get_reg_capa(u32 flags, u8 resp_ver)
 }
 
 struct ieee80211_regdomain *
-iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
+iwl_parse_nvm_mcc_info(struct iwl_trans *trans,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
 		       u16 geo_info, u32 cap, u8 resp_ver)
 {
+	const struct iwl_cfg *cfg = trans->cfg;
+	struct device *dev = trans->dev;
 	int ch_idx;
 	u16 ch_flags;
 	u32 reg_rule_flags, prev_reg_rule_flags = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index 0c6c3fb8c6dd..17d22a68f074 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2015, 2018-2024 Intel Corporation
+ * Copyright (C) 2005-2015, 2018-2025 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_nvm_parse_h__
@@ -46,9 +46,17 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
  * accordingly. An ERR_PTR is returned on error.
  * If not given to the regulatory core, the user is responsible for freeing
  * the regdomain returned here with kfree.
+ *
+ * @trans: the transport
+ * @num_of_ch: the number of channels
+ * @channels: channel map
+ * @fw_mcc: firmware country code
+ * @geo_info: geo info value
+ * @cap: capability
+ * @resp_ver: FW response version
  */
 struct ieee80211_regdomain *
-iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
+iwl_parse_nvm_mcc_info(struct iwl_trans *trans,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
 		       u16 geo_info, u32 cap, u8 resp_ver);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
index daca14e208bd..19cb562e7a73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 
 #include <net/cfg80211.h>
@@ -158,7 +158,7 @@ iwl_mld_get_regdomain(struct iwl_mld *mld,
 	}
 	IWL_DEBUG_LAR(mld, "MCC update response version: %d\n", resp_ver);
 
-	regd = iwl_parse_nvm_mcc_info(mld->trans->dev, mld->cfg,
+	regd = iwl_parse_nvm_mcc_info(mld->trans,
 				      __le32_to_cpu(resp->n_channels),
 				      resp->channels,
 				      __le16_to_cpu(resp->mcc),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d15031f9f38c..a968f5401da1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -146,7 +146,7 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 					   MCC_UPDATE_CMD, 0);
 	IWL_DEBUG_LAR(mvm, "MCC update response version: %d\n", resp_ver);
 
-	regd = iwl_parse_nvm_mcc_info(mvm->trans->dev, mvm->cfg,
+	regd = iwl_parse_nvm_mcc_info(mvm->trans,
 				      __le32_to_cpu(resp->n_channels),
 				      resp->channels,
 				      __le16_to_cpu(resp->mcc),
-- 
2.34.1


