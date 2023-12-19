Return-Path: <linux-wireless+bounces-1037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE90819126
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 21:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F4928774D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472A3A1B9;
	Tue, 19 Dec 2023 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eASTlAXB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAD3A1AD
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015991; x=1734551991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Gttt4xlqrNvn9YTQoK4XCp+NCYkAioPGrx+NrT752I=;
  b=eASTlAXBttkPYRWEF3s9oRlOkMxWDqtfCpcopn+nM9EFw3RFDNi73FNn
   LK9sKSDJPjOVhK79OTNa9tmY5nzE+LcE9PaX5pzgfabxpZgI9wmPK8qZi
   COO14WxtcDlsIcO+0WPQAQMr4qpY9EMdvxQQ9yp8KHlayY2ZwxPscj/2i
   JO426HRXgdoRe3dFX6FqU+2tfh5d6/7opXYs6/eJ4HkJ1aaHFJsbdzB58
   5JBGsav1y0TZHtHf9vStLerQxsY1Ig5CPIXErL/Bjh2sHWTXqrjqvPcEL
   bfHMSzcFdF3OcuPrrroRN5m5gAUsK8AtcARLaKXubJXyFOW/DadtUS3hS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694971"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694971"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589134"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589134"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:49 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/14] wifi: iwlwifi: mvm: add US/Canada MCC to API
Date: Tue, 19 Dec 2023 21:58:59 +0200
Message-Id: <20231219215605.6595e905997b.I12354d31676911b29ab30c81a4e9b87f59284d3b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
References: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We don't want to duplicate the definitions later,
so add them to the API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c         | 7 ++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index dfe0bebabc81..7ec959244ffc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -269,6 +269,9 @@ struct iwl_nvm_access_complete_cmd {
 	__le32 reserved;
 } __packed; /* NVM_ACCESS_COMPLETE_CMD_API_S_VER_1 */
 
+#define IWL_MCC_US	0x5553
+#define IWL_MCC_CANADA	0x4341
+
 /**
  * struct iwl_mcc_update_cmd - Request the device to update geographic
  * regulatory profile according to the given MCC (Mobile Country Code).
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 403bd17b8b7a..1252084662c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -27,9 +27,6 @@
 #define MVM_UCODE_ALIVE_TIMEOUT	(2 * HZ)
 #define MVM_UCODE_CALIB_TIMEOUT	(2 * HZ)
 
-#define IWL_TAS_US_MCC 0x5553
-#define IWL_TAS_CANADA_MCC 0x4341
-
 #define IWL_UATS_VLP_AP_SUPPORTED BIT(29)
 #define IWL_UATS_AFC_AP_SUPPORTED BIT(30)
 
@@ -1234,10 +1231,10 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 				dmi_get_system_info(DMI_SYS_VENDOR));
 		if ((!iwl_mvm_add_to_tas_block_list(cmd.v4.block_list_array,
 						    &cmd.v4.block_list_size,
-							IWL_TAS_US_MCC)) ||
+							IWL_MCC_US)) ||
 		    (!iwl_mvm_add_to_tas_block_list(cmd.v4.block_list_array,
 						    &cmd.v4.block_list_size,
-							IWL_TAS_CANADA_MCC))) {
+							IWL_MCC_CANADA))) {
 			IWL_DEBUG_RADIO(mvm,
 					"Unable to add US/Canada to TAS block list, disabling TAS\n");
 			return;
-- 
2.34.1


