Return-Path: <linux-wireless+bounces-21867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67606A97E50
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A631516896E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD24266B55;
	Wed, 23 Apr 2025 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+hkjUvA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD524266B4C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387461; cv=none; b=P33ZDCjqa2/9yWK4nDcRAMTJQX2JsbOmHjR1QGEcTRbg7eZ88Fu1zOANcoJttc7d7n7jRHTDeVJwtz1NXO+FLdWin0TjFXWNy9zMwhlOhDLEAjJuOu0w+KHYFkKIviWLwUi0L+yLY1e8zXz7mgukIje8FO+bgqXfMYm1N7+nXtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387461; c=relaxed/simple;
	bh=csjViaGQSf5FNOj5F04VW80J5j/q0jWBsIx0qDESDYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4YtETgwOIFmlbsJXYBLMh/2cHqzIJdhyDy+SxAG2tT+s3v16KI07zonWzXKBLdMMY7UwdRSM3wr1zJQ50cERico5DG95zvjj+HIaw8+9w3vYPx+yXF17h32F/2loPq6OmiFIGXnAUKVqJ5DDKp5OvNBzUfmmaYqD/wFu3hiJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+hkjUvA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387460; x=1776923460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=csjViaGQSf5FNOj5F04VW80J5j/q0jWBsIx0qDESDYw=;
  b=O+hkjUvAGKaFarflrSkbQxY4ji/bYY8Vz1rifARXUWueKyS38almrCoW
   mXDn8z3hol0LDLr5dC2GiQiZiG7/UPoP+2GTWoB2hvOZju4/8S9PwN7kW
   z4oVxeVFwQeK0OXA0fOViQsQNGkBUHCjPbOeZOGlqtTM4CxikvM9oeNLU
   Y2EBESOM0rL9AHozOk/0Xfn1tW2WV3+Fic7misnPgJ1RfC/ElaanqFFk6
   8JXso8nbM/rt99OrYx2SX1I4mGg0plPYQWtzD/JaRkUA929P5b/cObYjm
   pfb22oSa+9YvU5kOhlKRz3SqTJ7886ksxW5Vt1yMwatOS+nrsqaKMHaqp
   A==;
X-CSE-ConnectionGUID: dfywnPW0Trq/mKOXCOW4Ew==
X-CSE-MsgGUID: zxdvA9N+Rii5emTWqNtbnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844629"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844629"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:59 -0700
X-CSE-ConnectionGUID: BUVNAteXR2uQKAxRny0GCQ==
X-CSE-MsgGUID: XmtMR80ETq+PKSzfLtkXrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164331"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 07/17] wifi: iwlwifi: mld: avoid memory leak if mcc_init fails
Date: Wed, 23 Apr 2025 08:50:26 +0300
Message-Id: <20250423084826.d07469f866ac.I84ad2e624ce7cd4a661c73b4942186e50cdf82b2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

allocating mld->nvm_data used to be the last thing done in
iwl_mld_load_fw, so there was no need to free on any error path of
iwl_mld_load_fw.
But now iwl_mld_load_fw also calls iwl_mld_init_mcc, that can fail,
after allocating nvm->data. In that case, it is not freed.

As allocating the NVM data should only be done at op mode start anyway,
simply move it to there, where it is already freed in the right error
paths.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c  | 11 -----------
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 62da137e1024..77cc8e4bb498 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -11,7 +11,6 @@
 #include "fw/dbg.h"
 #include "fw/pnvm.h"
 #include "hcmd.h"
-#include "iwl-nvm-parse.h"
 #include "power.h"
 #include "mcc.h"
 #include "led.h"
@@ -308,16 +307,6 @@ static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
 		goto init_failure;
 	}
 
-	if (!mld->nvm_data) {
-		mld->nvm_data = iwl_get_nvm(mld->trans, mld->fw, 0, 0);
-		if (IS_ERR(mld->nvm_data)) {
-			ret = PTR_ERR(mld->nvm_data);
-			mld->nvm_data = NULL;
-			IWL_ERR(mld, "Failed to read NVM: %d\n", ret);
-			goto init_failure;
-		}
-	}
-
 	return 0;
 
 init_failure:
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 367f9738c011..8d788af8dcc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -26,6 +26,8 @@
 #include "hcmd.h"
 #include "fw/api/location.h"
 
+#include "iwl-nvm-parse.h"
+
 #define DRV_DESCRIPTION "Intel(R) MLD wireless driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_LICENSE("GPL");
@@ -412,6 +414,14 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 			break;
 	}
 
+	if (!ret) {
+		mld->nvm_data = iwl_get_nvm(mld->trans, mld->fw, 0, 0);
+		if (IS_ERR(mld->nvm_data)) {
+			IWL_ERR(mld, "Failed to read NVM: %d\n", ret);
+			ret = PTR_ERR(mld->nvm_data);
+		}
+	}
+
 	if (ret) {
 		wiphy_unlock(mld->wiphy);
 		rtnl_unlock();
-- 
2.34.1


