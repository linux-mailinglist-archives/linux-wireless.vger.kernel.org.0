Return-Path: <linux-wireless+bounces-21017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC4A7730F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 05:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF01188D65E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 03:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55B3A8F7;
	Tue,  1 Apr 2025 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQMCg0lq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D49461
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743479178; cv=none; b=ZQ+1LcevfAKGo773ipTrfiYY9fC2C5ztMOs8njAZ0tZfO22ETDPvUcKev203dyLanXuED+2vojBWnA1SwuZnALhDAcLhiIm19gVasqlHIkRsDE1k+1nUTAwDWyr/DOITXI8Ht54t5U3Hr+1p2X2bvTa5AdICfkAfCm4i/m12Eo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743479178; c=relaxed/simple;
	bh=yKQQTJgnlsAt5EUCf0XqaNI7pQyKyO/qu8kMRUmo0KY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jcM2WNNbphLEg3JXK4iF+Nrf3+oT4sm0I3j7xlK45xIXwzNtcCGxUMaGFYrMBDfJxj9jqophFvN98OmZIhxM/tb4PHqKMTCFf27taV4qtRy9cPOHoLeXrqPgydmgKcL7DsARC0saBkkbEvhPWb1ZlYAyXdFCULkSg/zeKELHxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQMCg0lq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743479177; x=1775015177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yKQQTJgnlsAt5EUCf0XqaNI7pQyKyO/qu8kMRUmo0KY=;
  b=VQMCg0lqILn5SfZ+IN1R8rW95OxOzJfrQvpP0RdH9aNR+e7ccIR8iC6u
   OwsOv8wOv8/7E3bFn16vN1rE9qSD1eQZ3sjYq+m7pTg2ju1Yn4NnCX4Mo
   lswB42XsCXT66pwaVO7rm/ejd57+GJjTYSE8mE77/Mov0300nL6yaMQiS
   AHpH5U9+XrHpZS0YiCm6N9QbSOmDsaSUaauUh1lmJRUOo+UKf0rbQa51A
   voJPt8+oqBDqC6gGFYYGnkRyqmul9+jAYsXegqdUBfwEH8Fia8Qb/KIo6
   B3OMjKZ8Qqbs89wVa1F6PCMchHStDAvW+L/H79x7i743Vos2GPRYFZuLZ
   Q==;
X-CSE-ConnectionGUID: 668k3zboSWCQdnNHnCO+ig==
X-CSE-MsgGUID: jhK328hNSVmQdQLiONEvbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="48573172"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="48573172"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 20:46:16 -0700
X-CSE-ConnectionGUID: ESo07wuBTe+7kNXa8cxJvQ==
X-CSE-MsgGUID: ZlF+62pgTU+s3o46zxg0TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="126156059"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 20:46:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH wireless 1/2] wifi: iwlwifi: mld: reduce scope for uninitialized variable
Date: Tue,  1 Apr 2025 06:45:54 +0300
Message-Id: <20250401064530.769f76a9ad6e.I69e8f194997eb3a20e40d27fdc31002d5753d905@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

After resuming from D3, keeping the connection or disconnecting
isn't relevant for the case of netdetect.
Reduce the scope of the keep_connection indicator to wowlan only.

Fixes: d1e879ec600f9 ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 5a7207accd86..2c6e8ecd93b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1895,7 +1895,6 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld)
 	int link_id;
 	int ret;
 	bool fw_err = false;
-	bool keep_connection;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
@@ -1965,7 +1964,7 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld)
 		iwl_mld_process_netdetect_res(mld, bss_vif, &resume_data);
 		mld->netdetect = false;
 	} else {
-		keep_connection =
+		bool keep_connection =
 			iwl_mld_process_wowlan_status(mld, bss_vif,
 						      resume_data.wowlan_status);
 
@@ -1973,11 +1972,10 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld)
 		if (keep_connection)
 			iwl_mld_unblock_emlsr(mld, bss_vif,
 					      IWL_MLD_EMLSR_BLOCKED_WOWLAN);
+		else
+			ieee80211_resume_disconnect(bss_vif);
 	}
 
-	if (!mld->netdetect && !keep_connection)
-		ieee80211_resume_disconnect(bss_vif);
-
 	goto out;
 
  err:
-- 
2.34.1


