Return-Path: <linux-wireless+bounces-20058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76D4A57E85
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F350D16E146
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B8020E00D;
	Sat,  8 Mar 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VS/6H8Gh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31420C031
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468798; cv=none; b=sp4VSZT9kJN9QSN7I1R0wa1Cmx4ubo2dyUkB+fas4Wrt0s/HHfLaFXCVf/3DjaG5mNHYlImoAQIXS1FzxgFoON68AbcoHqbVP035UR7sA3LnDCvQHLiQeLBntYM3r6rm3fkp41m6paCwwg2fmCUel1qUwk6dD6ICmJPT9cphx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468798; c=relaxed/simple;
	bh=fWKR+NTasQWmb41vYMEWcM/PWchbNMqsHUJfbuePSXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6fH5zsGI5YBxEo3E3XkNDhCkwB+mdbpsIiPK8PQ3asnnc/whzRn/8NapE1tJxRXU1axl875zIQAuvJH2WSfDVLtRcJ1q3n6WBsJV7SRBdcgq5D4ImMpEaVEHXIVySPJQIUNANqfhJvrbQrc9QYnPbQGNn5nP50LWD79fYRm28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VS/6H8Gh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468797; x=1773004797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWKR+NTasQWmb41vYMEWcM/PWchbNMqsHUJfbuePSXA=;
  b=VS/6H8Ghgtu9NsbhIpLBwzaOoIf2wdj58L8wmfZgo4JZK9MC6/sRDtP2
   rhg2CUsFWFA1jZPhAtBXmupA+CzUJYAB6L90JE/rNxKu9hwmUgNOh+WUr
   o6xatVduLmkL76ciTZDP4sXls76vGEgejfbpoTiEegI4eL+ZXGkFh/TqZ
   6/hUDQG3wQfmqzp71B7F51280QacL6QYlRE7VhUtDaqe2ZV5d8rMMpnit
   50j5Ab3CAXDoRyP8DJVVBPi7BV0eGq2YKgO4jmZXW8lp4vzvm2NsyjmM7
   jP5jFyQpQg+8ykEJiYcSpPdwhF9g+e7LKGnzVCEBfzGBlQWggSs6Qk17e
   w==;
X-CSE-ConnectionGUID: eK5toU9vSV2rWgk/JlReIg==
X-CSE-MsgGUID: rIHVDAi7RhOfWHeWDESn6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052389"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052389"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:57 -0800
X-CSE-ConnectionGUID: TjjmiTYJRMqOMLrkdHIHjA==
X-CSE-MsgGUID: 9r9V0ClFSM69U8Jo4FxSTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859975"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	nerrera <nathan.errera@intel.com>
Subject: [PATCH v3 wireless-next 13/14] wifi: iwlwifi: add restricted TWT capability
Date: Sat,  8 Mar 2025 23:19:24 +0200
Message-Id: <20250308231427.d58360cf4218.I08ecc8ead59e0869445b5802c13002dae99f68fd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
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


