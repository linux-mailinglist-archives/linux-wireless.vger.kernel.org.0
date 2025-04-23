Return-Path: <linux-wireless+bounces-21868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF2A97E51
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977B3189E2CE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371FF266B5A;
	Wed, 23 Apr 2025 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gA0tc9Ww"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183A266F13
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387463; cv=none; b=MbmdfIEtDLsDjNEIzogVbbONlPA/sXfd/CnIzqLrzcY05tXWyoiAhes0vYYeixlzDd8LIKpV0w52IUmNn7/OrVUCnOcs/dgqfcoO7MOhAFdYpA0aX/FMBcZsS0cgmEZvLq6HP0/A0GONirxn57LkZAsyeMBssNDQ+96yGohokDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387463; c=relaxed/simple;
	bh=l+2ye8Wn6MGC6tKklV/KB2fZ4l+ccQwr9i/7i+L5scg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YFYzDI+kET2csBnJ2vX+n1QiBnOJ4JZ2IL+DPeuFnET6ayO9pV84PXTWs1TDise0phU7KvUSaZ3XHbwvDpt6WNkOzi5vvwYfxs5w2twff8LtBoBQxbfUgQJlOKBul9Th8Otzokl4kdMq9DcUBGG4grE2HY4kg7LT9ehO5Zl/u8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gA0tc9Ww; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387461; x=1776923461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+2ye8Wn6MGC6tKklV/KB2fZ4l+ccQwr9i/7i+L5scg=;
  b=gA0tc9Wwo68a7s0g/y8MHgVd1rb5h8S1G5ByqxHNfpHtIEcB5lGPF1Xc
   Y0dx4OiyEtm9UodJlMSiWeOJrZj0B6Z9UdMzxDwJQdEMxmhE0L2VvbkkI
   FkRDVq7sCy+sJ8vwkobdvce+7M4/hzQng8jrngv3sl/2TxPZRlwb8rxNV
   LjvsQi7cOAy6aAw63g542gGOPamq9CPZ2DTxLxDgVsPCow0dAeQsBiTbs
   fFCSqNfZ7qOeGCF3q6e8MOAX1bYktsMl9XxTAHyYuihRqDuqtxqx3IvB4
   VxjRvrev+VKor7h13IRF2gAg59I8PnquK/soKaDsgRYW7oxDQsc3HCzap
   Q==;
X-CSE-ConnectionGUID: ZAlE3PXVTu60dyTQJihmEg==
X-CSE-MsgGUID: osGbJExXTr+9AZrYR8wVvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844631"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844631"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:01 -0700
X-CSE-ConnectionGUID: S7QJq7O8QPm8O+b9PveNOw==
X-CSE-MsgGUID: zDNlIuJ8SIqKO6HqV0ydDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164335"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 08/17] wifi: iwlwifi: mld: stop hw if mcc_init fails
Date: Wed, 23 Apr 2025 08:50:27 +0300
Message-Id: <20250423084826.ba06d972a57b.I317fb7b10ed8a688a0d92c5d99de8765d8044b10@changeid>
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

iwl_mld_run_fw_init_sequence used to be the last thing done in
iwl_mld_load_fw, and if it failed, it called iwl_trans_stop_hw.
Now we also have there iwl_mld_init_mcc, and it can fail.
In that case, we need to undo what we did so far, which is basically only
iwl_trans_stop_device. Do that.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c | 26 ++++++++-------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 77cc8e4bb498..511df49672b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -238,22 +238,17 @@ static int iwl_mld_load_fw_wait_alive(struct iwl_mld *mld)
 			iwl_fw_dbg_error_collect(&mld->fwrt,
 						 FW_DBG_TRIGGER_ALIVE_TIMEOUT);
 		iwl_mld_print_alive_notif_timeout(mld);
-		goto alive_failure;
+		return ret;
 	}
 
 	if (!alive_valid) {
 		IWL_ERR(mld, "Loaded firmware is not valid!\n");
-		ret = -EIO;
-		goto alive_failure;
+		return -EIO;
 	}
 
 	iwl_trans_fw_alive(mld->trans, 0);
 
 	return 0;
-
-alive_failure:
-	iwl_trans_stop_device(mld->trans);
-	return ret;
 }
 
 static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
@@ -279,7 +274,7 @@ static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
 			    &mld->fw->ucode_capa);
 	if (ret) {
 		IWL_ERR(mld, "Timeout waiting for PNVM load %d\n", ret);
-		goto init_failure;
+		return ret;
 	}
 
 	iwl_dbg_tlv_time_point(&mld->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
@@ -297,21 +292,17 @@ static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
 	if (ret) {
 		IWL_ERR(mld, "Failed to send init config command: %d\n", ret);
 		iwl_remove_notification(&mld->notif_wait, &init_wait);
-		goto init_failure;
+		return ret;
 	}
 
 	ret = iwl_wait_notification(&mld->notif_wait, &init_wait,
 				    MLD_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		IWL_ERR(mld, "Failed to get INIT_COMPLETE %d\n", ret);
-		goto init_failure;
+		return ret;
 	}
 
 	return 0;
-
-init_failure:
-	iwl_trans_stop_device(mld->trans);
-	return ret;
 }
 
 int iwl_mld_load_fw(struct iwl_mld *mld)
@@ -326,15 +317,18 @@ int iwl_mld_load_fw(struct iwl_mld *mld)
 
 	ret = iwl_mld_run_fw_init_sequence(mld);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = iwl_mld_init_mcc(mld);
 	if (ret)
-		return ret;
+		goto err;
 
 	mld->fw_status.running = true;
 
 	return 0;
+err:
+	iwl_trans_stop_device(mld->trans);
+	return ret;
 }
 
 void iwl_mld_stop_fw(struct iwl_mld *mld)
-- 
2.34.1


