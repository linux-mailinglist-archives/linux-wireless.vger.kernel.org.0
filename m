Return-Path: <linux-wireless+bounces-36298-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKhUIFa7AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36298-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:32:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8698451A1AD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D0CD302403C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CAE37FF48;
	Tue, 12 May 2026 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krnUxJMy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCA377560
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563412; cv=none; b=XsXFLQQ1cAp3Mtsv96pXHkW6NgszlKHbLnC5d1xWOMi1p6AevXoRW8Awz4ysgj8dqjooBnGwKw1KjWGPGrREVP6Nsj2vB+mjyD5frBlKsftXOrPyJ7Z4fIJ+LS2Hct7odWzvY07wkaZmplK6dk9rDfCbudnmFXheqBx4SqG5auA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563412; c=relaxed/simple;
	bh=Y0je0ArwJ3he3DZ+9lW1xPlfJHeIWqIVwbTRRp9PpN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uECJgxuQpzCS3fWP78KqWEEVXLEqshfF/P9ygJKtgnFPE/oCbucfW9pSdGsb5KUkDOn86XV7P0ewXDgCWee6cF2i9MyVg9ebSoDgNfyydK/b4E/qrogTKqAdjWse3+Y+02QEmbKJiFurOumcY1EX4AYI+1y6xLTIPmNdf1MQtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krnUxJMy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563409; x=1810099409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y0je0ArwJ3he3DZ+9lW1xPlfJHeIWqIVwbTRRp9PpN0=;
  b=krnUxJMyk1s4ps55VopvO1cnkc743sz5zM8jPUeG8hyAbIbrDgRClhRt
   fLYc0bhLegljzau2F3N3a+Uq3wiZbf7ti0tBq1+WeEi65gvGZoDOrfcda
   kMg/e/31WSNC1QbetbJAVUbn2Azk1wHWZ36euK7+fSKKXDLWuFDvZg7FE
   rO0yNOa9yNWhbghFjJ65rR0a8+eJw1hqmn7SjvWDM+zbtQ+mQTmqh8CVb
   ot7OtAAZtEFOqYUC4T1HJCB2moFGSemGiOYBuJVZg73yii443EGf7JRu1
   baFlC3qr8rMepmebryc0OWSYSzThcUsJgrBvm6LXEGzodmbKi2sGzqnLg
   g==;
X-CSE-ConnectionGUID: sBmqpWrSQaW8YdvOCdjfBw==
X-CSE-MsgGUID: weNQyYCbRgWzAbqVmenr5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495095"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495095"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:29 -0700
X-CSE-ConnectionGUID: 9AdSeuNOQA+IcSRCa34VOA==
X-CSE-MsgGUID: 1nF021ZzTOS2+rqD4lB1/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187560"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: remove nvm_ver for devices that don't need it
Date: Tue, 12 May 2026 08:22:59 +0300
Message-Id: <20260512082114.261b04a1b8f2.I5834a3efd0ae7e601a02cc0582287ced405a0aef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
References: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8698451A1AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36298-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This was needed only to check the NVM for devices that had a specific
firmware image to run the initial calibrations.
Remove this field from newer devices that no longer have a specific
image for those.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c | 6 +-----
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c | 4 ----
 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c | 6 +-----
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c | 5 +----
 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c | 6 +-----
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 3 ---
 6 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
index ad2536f53084..f482536e6b5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include "iwl-config.h"
 
@@ -11,9 +11,6 @@
 #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
 #define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
 
-/* NVM versions */
-#define IWL_FM_NVM_VERSION		0x0a1d
-
 #define IWL_DEVICE_FM							\
 	.ht_params = {							\
 		.stbc = true,						\
@@ -27,7 +24,6 @@
 	.uhb_supported = true,						\
 	.eht_supported = true,						\
 	.num_rbds = IWL_NUM_RBDS_EHT,					\
-	.nvm_ver = IWL_FM_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT
 
 const struct iwl_rf_cfg iwl_rf_fm = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
index 307b557dce99..e6f7066f5c7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
@@ -35,9 +35,6 @@
 #define IWL_SC_A_GF4_A_MODULE_FIRMWARE(api) \
 	IWL_SC_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
 
-/* NVM versions */
-#define IWL_GF_NVM_VERSION		0x0a1d
-
 const struct iwl_rf_cfg iwl_rf_gf = {
 	.uhb_supported = true,
 	.led_mode = IWL_LED_RF_STATE,
@@ -49,7 +46,6 @@ const struct iwl_rf_cfg iwl_rf_gf = {
 		.ht40_bands = BIT(NL80211_BAND_2GHZ) |
 			      BIT(NL80211_BAND_5GHZ),
 	},
-	.nvm_ver = IWL_GF_NVM_VERSION,
 	.nvm_type = IWL_NVM_EXT,
 	.num_rbds = IWL_NUM_RBDS_HE,
 	.ucode_api_min = IWL_GF_UCODE_API_MIN,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
index 6cf187d92dbf..3c3a8d5702d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include "iwl-config.h"
 
@@ -40,9 +40,6 @@
 #define IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(api)	\
 	IWL_SC_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 
-/* NVM versions */
-#define IWL_HR_NVM_VERSION		0x0a1d
-
 #define IWL_DEVICE_HR							\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
@@ -54,7 +51,6 @@
 			      BIT(NL80211_BAND_5GHZ),			\
 	},								\
 	.num_rbds = IWL_NUM_RBDS_HE,					\
-	.nvm_ver = IWL_HR_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT,					\
 	.ucode_api_min = IWL_HR_UCODE_API_MIN,				\
 	.ucode_api_max = IWL_HR_UCODE_API_MAX
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
index c02478b73057..7a04cb120b1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2025 Intel Corporation
+ * Copyright (C) 2025-2026 Intel Corporation
  */
 #include "iwl-config.h"
 
-#define IWL_PE_NVM_VERSION		0x0a1d
-
 #define IWL_DEVICE_PE							\
 	.ht_params = {							\
 		.stbc = true,						\
@@ -20,7 +18,6 @@
 	.eht_supported = true,						\
 	.uhr_supported = true,						\
 	.num_rbds = IWL_NUM_RBDS_EHT,					\
-	.nvm_ver = IWL_PE_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT
 
 const struct iwl_rf_cfg iwl_rf_pe = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
index b5803ea1eb78..fa63a9a01264 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
@@ -1,12 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2025 Intel Corporation
+ * Copyright (C) 2025-2026 Intel Corporation
  */
 #include "iwl-config.h"
 
-/* NVM versions */
-#define IWL_WH_NVM_VERSION		0x0a1d
-
 #define IWL_DEVICE_WH							\
 	.ht_params = {							\
 		.stbc = true,						\
@@ -19,7 +16,6 @@
 	.vht_mu_mimo_supported = true,					\
 	.uhb_supported = true,						\
 	.num_rbds = IWL_NUM_RBDS_EHT,					\
-	.nvm_ver = IWL_WH_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT
 
 /* currently iwl_rf_wh/iwl_rf_wh_160mhz are just defines for the FM ones */
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 8e6efde3c64b..4532d31d5f8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -15,9 +15,6 @@
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	100
 
-/* NVM versions */
-#define IWL_SC_NVM_VERSION		0x0a1d
-
 /* Memory offsets and lengths */
 #define IWL_SC_SMEM_OFFSET		0x400000
 #define IWL_SC_SMEM_LEN			0xD0000
-- 
2.34.1


