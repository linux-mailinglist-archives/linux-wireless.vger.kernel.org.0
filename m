Return-Path: <linux-wireless+bounces-22295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B59AA5CD8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450053B8034
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 09:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2550222D79D;
	Thu,  1 May 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXfha4k1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2B126C05
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093599; cv=none; b=KNezazbw4GO9IH8gJjVwjA8Wy3rUXQK+J6NOF/75QfivgtJehKVZq28HK/wZ01YCiJzWjOHc2DDBDozQJ7B52RlIpOHeJBYG0xVtZ9F05oUYdyTX9aaD/4JmDYQuajIn8r8byrNFoMu9utBrb6/y6WbkWHC8SWTCCteViUPsfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093599; c=relaxed/simple;
	bh=cJ+dwlJ/AL/bIznN+qw/0qM9wgvj9Dgi0GvA1dOtKek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pm7pFu7vfDYmiPOOFaS6lHO/nPtoT8RSsooEbHNg6rta0BYxkZxk07PZkc1B4SKj2CUP7GFDDELF9V2VyHfIY/iruSXjwzjKSyWNJYJW/QGA+70Ir9i3lJN09yV6KXKDTIcsk8K7fHQd5mS2RiOfSAQWNSk959/QpvmNsDZ1j5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXfha4k1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093597; x=1777629597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cJ+dwlJ/AL/bIznN+qw/0qM9wgvj9Dgi0GvA1dOtKek=;
  b=kXfha4k1RQ9GMiVuCSNahfrC6z333pUGXI6ZRr8Iu0ME53UcJ8UIO/t5
   TT14cjvwCOGd/XH0ZupjJm3h5s4qMgQ+U57CQmtKS69PA4c6Vvf7tM9tA
   QOwha/deEFKoKSbebh7J1NjzPwXBmL2WnZyvW6qRKlKoOuESkWIrC7Wag
   6ZLcR84DSqp580Edk0DYCicFuZTw56Ufqvlwghl3mXLob+Ptz42VP2yfR
   rcUsjj40gzB1zfjUllVcwUYVjQ7ebzc41YcWuN+slP4FK9AtCNF9/PYn1
   nxZhluDCBmv6gKInwwLW9G7RW+HYiTToEQ4lJrd9AnxAAjUPLjqV0nWWM
   g==;
X-CSE-ConnectionGUID: sPuccHyiTPico/tP6NHeiw==
X-CSE-MsgGUID: XzucKTIORF2pIokSFqDBdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962821"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962821"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:59:57 -0700
X-CSE-ConnectionGUID: Yi+fgqwiRDiluMk3n/k2Wg==
X-CSE-MsgGUID: JkL5ddG1Rp2lmZCiwH+ERg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135317939"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:59:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: pcie: Add support for new device ids
Date: Thu,  1 May 2025 12:59:25 +0300
Message-Id: <20250501125731.63bde540c374.Icbbc7c28855f8de232cb3916901a4da3ac286117@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
References: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

Add device support for PeP on ScP

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 670031fd60dc..5c740f302c93 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -143,6 +143,7 @@ const struct iwl_cfg_trans_params iwl_sc_trans_cfg = {
 };
 
 const char iwl_sp_name[] = "Intel(R) Wi-Fi 7 BE213 160MHz";
+const char iwl_pe_name[] = "Intel(R) Wi-Fi 8 BN201";
 
 const struct iwl_cfg iwl_cfg_sc = {
 	.fw_name_mac = "sc",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index f9fdb7c97636..a14488f03f92 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -549,6 +549,7 @@ extern const char iwl_ax411_name[];
 extern const char iwl_fm_name[];
 extern const char iwl_wh_name[];
 extern const char iwl_sp_name[];
+extern const char iwl_pe_name[];
 extern const char iwl_gl_name[];
 extern const char iwl_mtp_name[];
 extern const char iwl_dr_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 2480fba9b140..5b0905ac9870 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1131,18 +1131,21 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
 		     BW_LIMIT(160)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
 	IWL_DEV_INFO(iwl_cfg_sc2, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_cfg_sc2, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_cfg_sc2, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_cfg_sc2, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_LIMIT(160)),
+	IWL_DEV_INFO(iwl_cfg_sc2, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
 	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_LIMIT(160)),
+	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
 
 /* Dr */
 	IWL_DEV_INFO(iwl_cfg_dr, iwl_dr_name, MAC_TYPE(DR)),
-- 
2.34.1


