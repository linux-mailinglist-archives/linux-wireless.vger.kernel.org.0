Return-Path: <linux-wireless+bounces-19958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0317AA5595C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC97188E210
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE45B279342;
	Thu,  6 Mar 2025 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5YTewcE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B427CB3B
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298729; cv=none; b=JAj1gqKV/TuYe/AK34M8HcQbHqwVkcV3AiAXnBDmZluUG7KUYSDdlBZecJIqQCnvSEd2X01QITNyzHPx60EQK0IpxbkGkFYnK1Hj9jyBZqhNZ+y+ikzoCw1t0w3s2wwlMTiGtaDfRYMEHcMBcLG2i9EA7XirIeYG1ppGTsORNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298729; c=relaxed/simple;
	bh=fWKR+NTasQWmb41vYMEWcM/PWchbNMqsHUJfbuePSXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ns5cD+DRo+ChbiJkX65c8E0e+pncpWspRDzAq9156nbdvYXwhZgm7MfzUn5J1d4EWY4vLIq7nIFWm+hHTpoJR3UZS4xDBhZ6MEvvYeT8WtfBNiiEOrzKPT0/zFkBNZekBJeLCopZF7ynLQo5pLTGcQn8QEHgL/xRWL8vz1O6Tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5YTewcE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298728; x=1772834728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWKR+NTasQWmb41vYMEWcM/PWchbNMqsHUJfbuePSXA=;
  b=X5YTewcEOgg1rLBwrZQpGVmZ6QFbuz1VSmKsd8NVn6dZGkP2KZDZkN5a
   QKfDJs89LoZXXm8R45goru7TRh/tyNR/mfy3u7UJjDO602W7dEy8TazIw
   WPP+rY2yLn19KTSG7jRH7QF6vAeL9kr0jy+BUnqQ+u3WsGdBbHvh4MDb/
   g1uLBYS8YfObkRd0ApJSlW2nhSnWRfZagtWmL52JrrFMI4A82fpTe8HhZ
   LEi6hWewONeH7YcS5UInZHG0hl0lmnvK8X5gCnHhWvRrzvojLVq+aH6Qq
   1SlCqWni1qTSTgLpBJX1a7e1kUibyz/SZy1ROiboYHZyvTXn3Aj+3s4ZZ
   A==;
X-CSE-ConnectionGUID: ZjG2lsYJRyqaqFCt6papVA==
X-CSE-MsgGUID: wwV19Ot8Sq+2ewQLFrjrtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474291"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474291"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:27 -0800
X-CSE-ConnectionGUID: dulJe0CFQmiu7pBPQVR9QQ==
X-CSE-MsgGUID: mN7mgRipSxiIr0Pu8+zHcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061921"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	nerrera <nathan.errera@intel.com>
Subject: [PATCH wireless-next 14/15] wifi: iwlwifi: add restricted TWT capability
Date: Fri,  7 Mar 2025 00:04:53 +0200
Message-Id: <20250307000213.8af3edabf23b.I08ecc8ead59e0869445b5802c13002dae99f68fd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
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
index cd1b0048bb6d..81b83ce56c45 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/firmware.h>
 
+#include "fw/file.h"
 #include "iwl-drv.h"
 #include "iwl-modparams.h"
 #include "iwl-nvm-parse.h"
@@ -1112,6 +1113,10 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
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


