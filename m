Return-Path: <linux-wireless+bounces-19908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E37A54A05
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D676B188CCDC
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B120A5C1;
	Thu,  6 Mar 2025 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNTCGGhx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08220C02D
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261774; cv=none; b=ck9YIwMm9kBGDCAeBGFJk3c/EM8tGmXEjXdL2Q+XbfcZox2iFX+KagmeFvPuxOPjkAQ5XdTOWjRykpNV4DCI0iP8O/FdLvXii0azG/wA1KsWYPqU1v/u/boZ6rIm+KtVNy26kk6SHA675U2eOAZHfT+tBW9hpp61czA2R5AEwMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261774; c=relaxed/simple;
	bh=Ftz9yaIImFok3saQwRb8ogCHQwoS/w1X7gQUJqAsBmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dESuOGxVl43Ct4Oox7Eh3Ifm/hQ6SqX6d4VW7g2Z+06KHooudXeoRt9mbXpGLP2KnoXnG7NBawz/E2apF5q6EVsuZIvWHR07IWELe2g0C4kmrLJDoDsf37IyyNcCT5fuW8gJyMcs3TJpPoOIVepIao80+euqmMVr1ZSCFqfVEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNTCGGhx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261773; x=1772797773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ftz9yaIImFok3saQwRb8ogCHQwoS/w1X7gQUJqAsBmI=;
  b=LNTCGGhxQ0gU5uUYBcoBxekQCeAkuJl6KPg6UGJbYXThaY6rzEbpdklJ
   EvrhPmpTEhlJwsegCKXF5+RHR0t9YYnIEIfXN0ayNKIBdtjUIXflpHOyP
   6LqNb9/WjbMyiYCoGaglKjBGPYSK+gEXHT65ePpxHrN2dZIQSX+JqmJtF
   rCK4E88DWOcemuoJtnHJZV5G/kU74EKMZ0bvou7m6ZRNuhsTPq1e73791
   ejCHQvqGiE2y2/b53EmgsFno2YyKYN0YKlgcXqQO2NPx6wdzypnCLff/k
   z11TFETOF0p69JkXxCBVJYB1KR1yt5qhd2KjrTEX5J97upoNQmuifhMz6
   A==;
X-CSE-ConnectionGUID: pMjCjHrkT7+0otWHgOuRDg==
X-CSE-MsgGUID: fdF7Gf2PSSqKvcpceKetaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474559"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474559"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:33 -0800
X-CSE-ConnectionGUID: PzI7Uf+QRT+W3pThc2wGHw==
X-CSE-MsgGUID: i+BzfEtjQIOdmenuIg57jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915584"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:30 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	nerrera <nathan.errera@intel.com>
Subject: [PATCH wireless-next 15/19] wifi: iwlwifi: add restricted TWT capability
Date: Thu,  6 Mar 2025 13:48:51 +0200
Message-Id: <20250306134559.1435681da109.I08ecc8ead59e0869445b5802c13002dae99f68fd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: nerrera <nathan.errera@intel.com>

Set the restricted TWT capability bit if FW supports it.

Signed-off-by: nerrera <nathan.errera@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h       | 4 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 9860903ecd3f..770991d0c60b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2008-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2008-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -404,6 +404,7 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  * @IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT: supports %TAS_UHB_ALLOWED_CANADA
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
+ * @IWL_UCODE_TLV_CAPA_RESTRICTED_TWT_SUPPORT: Supports restricted TWT operation
  */
 enum iwl_ucode_tlv_capa {
 	/* set 0 */
@@ -504,6 +505,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_MONITOR_PASSIVE_CHANS	= (__force iwl_ucode_tlv_capa_t)122,
 	IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA	= (__force iwl_ucode_tlv_capa_t)123,
 	IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT	= (__force iwl_ucode_tlv_capa_t)124,
+	IWL_UCODE_TLV_CAPA_RESTRICTED_TWT_SUPPORT	= (__force iwl_ucode_tlv_capa_t)126,
 	NUM_IWL_UCODE_TLV_CAPA
 /*
  * This construction make both sparse (which cannot increment the previous
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 018752b8c4d8..d3d95153a671 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/firmware.h>
 
+#include "fw/file.h"
 #include "iwl-drv.h"
 #include "iwl-modparams.h"
 #include "iwl-nvm-parse.h"
@@ -1116,6 +1117,10 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[8] &=
 			~IEEE80211_EHT_PHY_CAP8_RX_4096QAM_WIDER_BW_DL_OFDMA;
 	}
+
+	if (fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_RESTRICTED_TWT_SUPPORT))
+		iftype_data->eht_cap.eht_cap_elem.mac_cap_info[0] |=
+			IEEE80211_EHT_MAC_CAP0_RESTRICTED_TWT;
 }
 
 static void iwl_init_he_hw_capab(struct iwl_trans *trans,
-- 
2.34.1


