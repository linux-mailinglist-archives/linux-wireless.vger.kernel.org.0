Return-Path: <linux-wireless+bounces-481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AB6806A1E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FF71F21846
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F23928DA9;
	Wed,  6 Dec 2023 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZT6AtdH6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CABC2127
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852600; x=1733388600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s/6BA6r2IysRiM+EXs6o2zeUp+Hfn65Z9cgixQhGHu8=;
  b=ZT6AtdH68XPhPQAylXLTQfCx3MObb/Fd7zFCPSscw850VBOI5k0zDZrG
   +ZrMU9i1ErFRYY64o6iFb/aeb0jq3YUoL7qia/dgbyW2di3xz308jL+hn
   pyHS0/hxYHCR3CeqmkIScc1vAIG34t5akKb3A00Zn3OGbEEhTMgUDi2CS
   bCmNTVGBGVMxGLHcZzPDqRP901JRFXMqDgFLiZa9BGP9DzpyorBnaLwWy
   I8SJKEpqKkI7615Rmn3C62E3per+aQtF0nLm0RTyy8iXVDvBVdu5VjthY
   UQjcRZFq2meUprlTOs0R09QmpvSG1zNO05aTHDn9IvSABerLUVkeJxhAj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916570"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916570"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575408"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575408"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:58 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 08/13] wifi: iwlwifi: pcie: get_crf_id() can be void
Date: Thu,  7 Dec 2023 04:50:13 +0200
Message-Id: <20231207044813.898b7e99206f.I61378115093fe70e6f5baca7f334651e4190eb3b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Johannes Berg <johannes.berg@intel.com>

This never returns an error and the return value is never
checked anyway, so it can just be void.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 26a0953603ab..2c9b98c8184b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1121,9 +1121,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 /*
  * Read rf id and cdb info from prph register and store it
  */
-static int get_crf_id(struct iwl_trans *iwl_trans)
+static void get_crf_id(struct iwl_trans *iwl_trans)
 {
-	int ret = 0;
 	u32 sd_reg_ver_addr;
 	u32 val = 0;
 
@@ -1150,8 +1149,6 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 	IWL_INFO(iwl_trans, "Detected crf-id 0x%x, cnv-id 0x%x wfpm id 0x%x\n",
 		 iwl_trans->hw_crf_id, iwl_trans->hw_cnv_id,
 		 iwl_trans->hw_wfpm_id);
-
-	return ret;
 }
 
 /*
-- 
2.34.1


