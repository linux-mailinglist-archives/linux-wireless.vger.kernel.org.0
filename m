Return-Path: <linux-wireless+bounces-21889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC033A97F07
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0825D3A5C33
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D112266EF0;
	Wed, 23 Apr 2025 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZ7LrKL9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82679267705
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389027; cv=none; b=qMyd6hElkzSh1KpxJzk2yFJsR31odVx7XsxAXTRHlmkdhMdEUpNfrYIGrGZHzhP8w9xVrP2G1AB6i0Aw8/ZDF0iEvXJDp3SX9d5ObykzI2IAr/UunYIIEpjASZsFqILRxVw3tdrxLmvBI3N6U11zZnJkmOIT/J/lsrGH6E+SqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389027; c=relaxed/simple;
	bh=l+2ye8Wn6MGC6tKklV/KB2fZ4l+ccQwr9i/7i+L5scg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OWXt6VPfY/+g4nrhz7nmtneQ3JXrIhy4MPP51BPqWXUGWiheUanyyukCpjo7rryuHLebTq9pjKXtAAD4xLfl4WUBX/gQQ8q1y2zoUnC/baWRkmz/vgkh7UAow0S6o9iOW1zbfy666mUVWJIacOqfqtRzJsfzTtk1SU9xeBZ3IOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZ7LrKL9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389025; x=1776925025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+2ye8Wn6MGC6tKklV/KB2fZ4l+ccQwr9i/7i+L5scg=;
  b=DZ7LrKL9jSGN7lR7ixt05X/PKjr7XlnulSGC3i5iY9Say9Az5oRuimRX
   lEtA6q3nFkyB+9xavXfjXwR2M7eqHci5myfNlR21bDLMDyrJEtjD1/i2B
   Um2czrGpTvunuAOM56DYxdqDSkirm451ToUaKjYktMEmyoxlCccJTQDjE
   HfCHlJvJUy6lz41c1ENyg4VK5bPvHyJ8m4J/b8m3/3PUy4vOZjVMsdbXo
   Ttrm89iymx+KTZbVnlFLsexhnSQ5Z9QmDxOSXpGiQ2EhJHdPKTy5+Jtwu
   Sf/MzTyHE/Cd8dH1QlwNNles0FjlYZvvXJOcZFq+dzIX5BgqgRjeSzkIm
   Q==;
X-CSE-ConnectionGUID: 6mXPFh79TfmkrL7SqHeBOg==
X-CSE-MsgGUID: sqF9jqUiQkyBa/w8ItzeQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843636"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843636"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:05 -0700
X-CSE-ConnectionGUID: cH8yEiF7QG2ofJunHSxdXw==
X-CSE-MsgGUID: GrPZtfB6Q06cNyWCU27oGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269049"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 08/15] wifi: iwlwifi: mld: stop hw if mcc_init fails
Date: Wed, 23 Apr 2025 09:16:34 +0300
Message-Id: <20250423091408.ba06d972a57b.I317fb7b10ed8a688a0d92c5d99de8765d8044b10@changeid>
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


