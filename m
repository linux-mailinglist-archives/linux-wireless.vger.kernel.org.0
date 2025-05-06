Return-Path: <linux-wireless+bounces-22689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E20EAACE42
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F016982CA6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C092121CC46;
	Tue,  6 May 2025 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isGRuVoC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9820C46A
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560498; cv=none; b=WL3lAaouB2dF5+hl6EEDBsbYmToOrro8o4L7XaOALqCuh2RoNwF0cCXcH1wzU/4JhjsXdc5+I7n9103KgG6+5OvwRxde38b3AzcaoQP2MF4PBkBEDVbpGyPJCAOHFGWThqlA1BqESCj9FL0IazMZukrZnKYqehVUhb1SM9qdnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560498; c=relaxed/simple;
	bh=TVcYYgf/PlU/M+yvb92WeQgNNv5Ceh1KK1NF1ahdDPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dvt87DNBOOt/QZ2a5z5Bt9AXTH14Cb6UYt8OkGZ+AzNza9Bc6mSzd8Bq8GJT8Lel3WU7HcgOHnHzvcxnmNWwaXdqRz6WyFWWiHsKEcf1l1YsmlzvmlGkhBRNVvohQV1VyEmBHIEeDyLWFiWkOOPQw3W345iuLdFPR0Muaw8FvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isGRuVoC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560498; x=1778096498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TVcYYgf/PlU/M+yvb92WeQgNNv5Ceh1KK1NF1ahdDPU=;
  b=isGRuVoCw63vvD+LQO9x3uw8FofEcfw1Uow3/MLJiiDn218QObV3V74j
   s8MlY76jqNQX+ecw/OWlIo69QFX+t0RqRqvCF73+PMZ3wWTQgJbAW/eNQ
   vF5yOCiIZrabwP4d4Ae9EJ1L4EDFHKFRWqAU3c2HymRQjz7w/zoWLp676
   8YYhZAyKf/oqqpL9J1IJhFGkOrKuFaD/psMT5aBd1xGIiC3IvhwEhdu/m
   yuzAkupdlPsqVpHZ0fPwIqdWG8G3Cx15218dyH0PVN+btNH4O5g6no3Jf
   r0nHpgycHSGSxMgTOVcGWT6Q0F+Ul5I5nUtbwLEFYAkUJIFFTn8bG2xsm
   A==;
X-CSE-ConnectionGUID: 3RWFugaXSRu/BEDNHvs1+w==
X-CSE-MsgGUID: WyeL6+VFSW+mi0zSsxrE1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961682"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961682"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:37 -0700
X-CSE-ConnectionGUID: VpICNrRGQZ2//kXx3nzXxA==
X-CSE-MsgGUID: qgro1MSSSdW4f2jPvmfQ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465526"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: pcie: remove 0x2726 devices
Date: Tue,  6 May 2025 22:41:01 +0300
Message-Id: <20250506194102.3407967-15-miriam.rachel.korenblit@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

These are test chips, not available to users, and not even listed
in the PCI IDs table (so the driver won't bind them). There's no
reason to list specific devices with them in the driver.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250506223834.b55208fc7de1.I21ec21d4d90131a17325b426688a3769e931e7b6@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 22049bc7e72e..3e535fed8ff5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1203,10 +1203,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x7AF0), SUBDEV(0x1552)),
 
 	/* SO with GF2 */
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x2726), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x2726), SUBDEV(0x1672)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x51F0), SUBDEV(0x1671)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
-- 
2.34.1


