Return-Path: <linux-wireless+bounces-21888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 664B1A97F06
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81753B419F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA226770B;
	Wed, 23 Apr 2025 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H90IxuEN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E0266B70
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389025; cv=none; b=QQcbGWam/LsU13xjzYqGIrYPWhczGD+IsLqSD8LsWUAcRjkU67URmkFJcSZxGqt/aGmtfwYfRuRz9u5uZ+eHYWhwNdAKX7VbGPdpPBwPxSUBUaAYvFDyPrTMf2xuKUUgJ20RPAf6RcPfDp8nSUkLmhDqGY6FIhIxsh7YUyL9cY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389025; c=relaxed/simple;
	bh=csjViaGQSf5FNOj5F04VW80J5j/q0jWBsIx0qDESDYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aF3khsey+94mMaxFRqSg8dLSIbisHHVF0Sn4itQ3ui0WpcrCZqePLw3/GawPwC26IJB42IFUyKJEj//Utq7HqsKU3sJludyJGR4QXXT/VX8k8stfZWsXM2geC09v95szVTXcKJuurJ38xGZng+F4AjJ6EWS2zkAAqhUfE1GSTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H90IxuEN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389024; x=1776925024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=csjViaGQSf5FNOj5F04VW80J5j/q0jWBsIx0qDESDYw=;
  b=H90IxuEN+VR5RXsjUoBdfwK5hlpn+QVpZQd8L0eDny4hkTnjOeTA933H
   UYrqtib9ujn8N9JQh8/6CVMp3baMr/FDgK7GkcnzKEGEA7om0Ri6OuemG
   CEVaYvZrlrWULNJ5QOFhRRwcdxWRVXD/OPE9hEk+oXi2EkjqmoA48Zooy
   gbIRsbz4Dlz3D3lyb/UiSSxK9l0DaRpQKvua5GHGahi85rrj4NlDxMd7k
   IgNEJi6gWKQ4XVbMuYZNK4sMiorLCviQihXag+rRdzVfRHEDZaPW4PyMi
   kj80EYQSGOeo+PfMAGlcDwcKKQS/N8v8ITrzeL40Vr/hQpsYQI2l1Y1/f
   g==;
X-CSE-ConnectionGUID: mfQcpon7Q/GiSpORn6ORQw==
X-CSE-MsgGUID: 2UoJT5hYSpK62lEw1kemCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843634"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:04 -0700
X-CSE-ConnectionGUID: CibARQt5SmmczOsCRHC1Tw==
X-CSE-MsgGUID: aPGv4B2uShKkwnTS84RG1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269043"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 07/15] wifi: iwlwifi: mld: avoid memory leak if mcc_init fails
Date: Wed, 23 Apr 2025 09:16:33 +0300
Message-Id: <20250423091408.d07469f866ac.I84ad2e624ce7cd4a661c73b4942186e50cdf82b2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
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


