Return-Path: <linux-wireless+bounces-28936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A6AC5A513
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 23:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AE2C4E2D70
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 22:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092528405C;
	Thu, 13 Nov 2025 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvAmgKOt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80B322C81
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763072938; cv=none; b=NJPXRmPbFNNmADOUcwM2TkT1R9b0B8oy6O1TKV5K7YFVBpM9yLTdX4a5wzrCWIAmL9Fviqweb/h34PII7dm0h9eU/EPwx2MB2B43u2ioBt7ajSWRAhimd922TEMMFHWu7z+WVECr5UMwCU25nBiX8byGSF+SbHkMnt/mpY43TYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763072938; c=relaxed/simple;
	bh=j16Yxy/4awh8xWsnxI3AbyaMeUqddxtu1JXSKvoMqrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uuwG49IgJwSfvi267VXpDMuS1tHajKRfIZOhtPXQZbuIHjxk4TJOw0r2sYkGDrLHUseddL7/O9lr7F1qTkebw2BLPcW/Vw8vH2iG238wujrUIzivweLE7cpoQNJvTjViww5V2DkJa626ghtY3t2z47NiyP8neBUmm9K/lEygR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvAmgKOt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763072937; x=1794608937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j16Yxy/4awh8xWsnxI3AbyaMeUqddxtu1JXSKvoMqrg=;
  b=WvAmgKOtQaqPp+l9hptXhzKavjH1lbBxSMU1aUJeblF9fKY2xb+LESvM
   VNKgkB3khebQ2sesBya0nDEGgwrKlUBwrwCQ4ptgNQ0u1o13fs7atykc/
   JwW6sZ3C1YDd8sejVtnUB1ZlPQ4F81SL6ft/xmRqGXp7PQzszM9rynhSg
   JTGRFaBA85RpbWksOCKEJh2SKhoi9w87hwkME5XJOuOfUy8xeRs18+nYR
   S9PSdDPbfDVjR1sjYCBuXEBh+8scmfM5BNv697LnmDax2dX6JE9/yCOP9
   IzNAWrkP4WRIkMbnwRql1i1gKFAjkS52a6WkPe0nsjrubMLVAtXl4kRN9
   Q==;
X-CSE-ConnectionGUID: ZapQ7QLzREGt4/JN9etotg==
X-CSE-MsgGUID: oDQ0XhNhS36wXaenYa2bRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="82798785"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="82798785"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:28:56 -0800
X-CSE-ConnectionGUID: /8mYZgMYSBW5jvyGgrzgqQ==
X-CSE-MsgGUID: DRrYb2QkTDSFRzgBKuie9w==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:28:55 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH] wifi: iwlwifi: Fix firmware version handling
Date: Fri, 14 Nov 2025 00:28:52 +0200
Message-ID: <20251113222852.15896-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

On my system the arithmetic done on the firmware numbers
results in a negative number, but since the types are
unsigned it gets interpreted as a large positive number.

The end result is that the firmware gets rejected and wifi
is defunct.

Switch to signed types to handle this case correctly.

iwlwifi 0000:0c:00.0: Driver unable to support your firmware API. Driver supports FW core 4294967294..2, firmware is 2.
iwlwifi 0000:0c:00.0: Direct firmware load for iwlwifi-5000-4.ucode failed with error -2
iwlwifi 0000:0c:00.0: Direct firmware load for iwlwifi-5000-3.ucode failed with error -2
iwlwifi 0000:0c:00.0: Direct firmware load for iwlwifi-5000-2.ucode failed with error -2
iwlwifi 0000:0c:00.0: Direct firmware load for iwlwifi-5000-1.ucode failed with error -2
iwlwifi 0000:0c:00.0: no suitable firmware found!
iwlwifi 0000:0c:00.0: minimum version required: iwlwifi-5000-1
iwlwifi 0000:0c:00.0: maximum version supported: iwlwifi-5000-5
iwlwifi 0000:0c:00.0: check git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

Cc: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Fixes: 5f708cccde9d ("wifi: iwlwifi: add a new FW file numbering scheme")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 607fcea6f4ef..0f002ef261fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1599,7 +1599,7 @@ static void _iwl_op_mode_stop(struct iwl_drv *drv)
  */
 static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 {
-	unsigned int min_core, max_core, loaded_core;
+	int min_core, max_core, loaded_core;
 	struct iwl_drv *drv = context;
 	struct iwl_fw *fw = &drv->fw;
 	const struct iwl_ucode_header *ucode;
@@ -1678,7 +1678,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	if (loaded_core < min_core || loaded_core > max_core) {
 		IWL_ERR(drv,
 			"Driver unable to support your firmware API. "
-			"Driver supports FW core %u..%u, firmware is %u.\n",
+			"Driver supports FW core %d..%d, firmware is %d.\n",
 			min_core, max_core, loaded_core);
 		goto try_again;
 	}
-- 
2.49.1


