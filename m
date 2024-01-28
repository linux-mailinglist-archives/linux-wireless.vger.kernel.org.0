Return-Path: <linux-wireless+bounces-2615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB183F472
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E9B1F22EAA
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D7125C1;
	Sun, 28 Jan 2024 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuLKfEZH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F019E56C
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424897; cv=none; b=SZVL5qwi/3wIsYIw188ZqZzqQ0U95pWmRC5ZPlqCnkll8WKMSaOpKci5GbOZYMub8yzfYubc8MYiKIdcYz5o6y4aVLe/CXnKwMUuK/5/6FS5ZJ+1ybbZkRF+34CdYWkAhcn1eLLPPJsjMUc2pThpltpszRL90zoi9soKh4e1qNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424897; c=relaxed/simple;
	bh=UZPDRUXyYYpC/4h5N8/AVkyTKOj/nsvXk3M4ybhdrgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHpMFCj+kG8itaWYxeVi9/14y5WDHmkg0H00wIQsTwLtH7kHFG5B65oXa1BePgKUwj0GV7Z5Nq5f7yZlLu7xHox8UxJUC3UzJMzsF+dO+phYQ83KqPsYBn4nPsZXU7rCCtR6wZLchiKE2qf7IrxGzkZ1VdCPEBe4FcVX9O0+qUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuLKfEZH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424895; x=1737960895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UZPDRUXyYYpC/4h5N8/AVkyTKOj/nsvXk3M4ybhdrgM=;
  b=LuLKfEZHEAJzkRQkdHQP+hDh1FQR28/O00N/YGcOoEmFb/bBkKgRTrWr
   O/JqCRxUlgZCLo8sf1sD29QQaYPppWNLcd9mtkHCcgJCzQGx3WDL1X3Av
   QFYF9/jVUwH0GeDsLercB7heQtw7s2FavGeHpqAmNdecNUk2pMeZtbcSQ
   cGUZ8jdPJENdetycrjYWN6cbQWpmy+gU7DOwhKDJguOg83fO3FH2ws5RG
   dqB9tWYJsMVD3Jg+1og5pyhDvUrJGA3yG9x9pL5CbS2Nbq8osb713PWty
   tquNdG4jnv7C1CkpAcgYNgWbqSdjcs4xbvmcc4GPGhYr7P8fRKAOFx6LK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217671"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217671"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833363"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman Gregory <gregory.greenman@intel.com>
Subject: [PATCH 09/14] wifi: iwlwifi: acpi: fix WPFC reading
Date: Sun, 28 Jan 2024 08:53:55 +0200
Message-Id: <20240128084842.2afeb476b62d.I200568dc42a277e21c12be99d5aaa39b009d45da@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The code reading the WPFC table needs to take into account
the domain type (first element in the package), shouldn't
leak the memory if it fails, and has a bad comment. Fix all
these issues.

Fixes: c4c954547755 ("wifi: iwlwifi: implement WPFC ACPI table loading")
Reported-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman Gregory <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index b96f30d11644..72a0a9565371 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1293,7 +1293,6 @@ void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 	if (IS_ERR(data))
 		return;
 
-	/* try to read wtas table revision 1 or revision 0*/
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_WPFC_WIFI_DATA_SIZE,
 					 &tbl_rev);
@@ -1303,13 +1302,14 @@ void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 	if (tbl_rev != 0)
 		goto out_free;
 
-	BUILD_BUG_ON(ARRAY_SIZE(filters->filter_cfg_chains) != ACPI_WPFC_WIFI_DATA_SIZE);
+	BUILD_BUG_ON(ARRAY_SIZE(filters->filter_cfg_chains) !=
+		     ACPI_WPFC_WIFI_DATA_SIZE - 1);
 
 	for (i = 0; i < ARRAY_SIZE(filters->filter_cfg_chains); i++) {
-		if (wifi_pkg->package.elements[i].type != ACPI_TYPE_INTEGER)
-			return;
+		if (wifi_pkg->package.elements[i + 1].type != ACPI_TYPE_INTEGER)
+			goto out_free;
 		tmp.filter_cfg_chains[i] =
-			cpu_to_le32(wifi_pkg->package.elements[i].integer.value);
+			cpu_to_le32(wifi_pkg->package.elements[i + 1].integer.value);
 	}
 
 	IWL_DEBUG_RADIO(fwrt, "Loaded WPFC filter config from ACPI\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index e9277f6f3582..39106ccb4b9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -56,7 +56,7 @@
 #define ACPI_EWRD_WIFI_DATA_SIZE_REV2	((ACPI_SAR_PROFILE_NUM - 1) * \
 					 ACPI_SAR_NUM_CHAINS_REV2 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV2 + 3)
-#define ACPI_WPFC_WIFI_DATA_SIZE	4 /* 4 filter config words */
+#define ACPI_WPFC_WIFI_DATA_SIZE	5 /* domain and 4 filter config words */
 
 /* revision 0 and 1 are identical, except for the semantics in the FW */
 #define ACPI_GEO_NUM_BANDS_REV0		2
-- 
2.34.1


