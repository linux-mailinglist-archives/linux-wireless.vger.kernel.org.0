Return-Path: <linux-wireless+bounces-22677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEB8AACE31
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41973B78C6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F73520AF67;
	Tue,  6 May 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e92tuqL7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F71FBCB1
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560481; cv=none; b=YtxV8xNuCCWt8YQuChxBFS+x7UU5a3lg6hpyEiiJ2xsvF9uNab0y7xUFjyg6OG195CVSoH5bBVRL3H+iGZgydInP9UfC94aVQt85bj5B6/0kw75z9HoB7AHwtoxiSNwBiJM0xNlGAiWhqPQ+bH24Ywpx0OuAnti/EXyYfSDzdeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560481; c=relaxed/simple;
	bh=RK1xIKypMuYtItGcL6YCZO3C13V1ye7CxvqC3bwGlh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zv070wgHDXewSvoi/YEDTZ2rNtPNJbWN1K6JAA08GBhsEwU7u6GrM4boVEj//5wAmnLhh4/T70KeTUasdpRENBQYCRHNnfH6pnXQVAAdY0fE3Jy8vQUkA28EaYSzyo0xxVQtazz9EDI4G5DvtsdCKs1Sqxq9xZ4WXUViMliLCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e92tuqL7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560480; x=1778096480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RK1xIKypMuYtItGcL6YCZO3C13V1ye7CxvqC3bwGlh8=;
  b=e92tuqL7m5sw1F6SLGukGK0d9lf8f6je9N0vI4CiD4YqKPb0Hy4o0ltU
   p5rU85/5yTbtmBFszAP0P541w8cVzHn5BXOWjBKWKgoTcFqdHdh0MbFD1
   CSRX5P4Pku3UoJWKaoP2968hCeBAb/SiVjqzlVSiKAtMVbBFLE+a6RCQp
   cXToaBQMmTCorQm9b35YOur5WQAMTHoVWbS0K93xukioBL7PTPrEMSr2F
   gVgfbQazpqLCvvrX3InYbVgZqNC9SQckJ9LrEv21etdKLSMRJ0Js+vUM1
   VbUFU5JkGzr5QfNmbqCb602z+iCXUEEGpHss/vc7/NbHff5nShAD2Myui
   Q==;
X-CSE-ConnectionGUID: QPUOlR83RASSC0W73P1FVg==
X-CSE-MsgGUID: QBLVm3FoTbyULkrOyPdoXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961610"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961610"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:19 -0700
X-CSE-ConnectionGUID: JRGHHw+ZTr62Uhkqu+ZWLQ==
X-CSE-MsgGUID: 4hKNob0aTyOyZdKsW57ZZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465398"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: remove one more error in unallocated BAID
Date: Tue,  6 May 2025 22:40:48 +0300
Message-Id: <20250506194102.3407967-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Since the FW is the one to assign an ID to a BA, it can happen that
the FW sends a bar_frame_release_notif before the driver had the chance to
allocate the BAID.

Convert the IWL_FW_CHECK into a regular debug print.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250506223834.101423dfcc07.Id5aa779b6a0a0d51cc127ba561c01ffc6594a178@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index 393cc0e27052..bda488ae9eec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -124,10 +124,12 @@ void iwl_mld_handle_bar_frame_release_notif(struct iwl_mld *mld,
 
 	rcu_read_lock();
 	baid_data = rcu_dereference(mld->fw_id_to_ba[baid]);
-	if (!IWL_FW_CHECK(mld, !baid_data,
-			  "Got valid BAID %d but not allocated, invalid BAR release!\n",
-			  baid))
+	if (!baid_data) {
+		IWL_DEBUG_HT(mld,
+			     "Got valid BAID %d but not allocated\n",
+			     baid);
 		goto out_unlock;
+	}
 
 	if (IWL_FW_CHECK(mld, tid != baid_data->tid ||
 			 sta_id > mld->fw->ucode_capa.num_stations ||
-- 
2.34.1


