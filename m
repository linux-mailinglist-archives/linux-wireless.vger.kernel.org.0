Return-Path: <linux-wireless+bounces-22750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7520BAAF986
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5A3B2020B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E12225760;
	Thu,  8 May 2025 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CE8gm7Ty"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB09225415
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706422; cv=none; b=uUdDLQkvRkpebfV/i/6/4JofoRQggdc0upHakA2Gm94ENIUx10U9m3Q6r5orUEQ5vlmJxhKYjOS3bC1HBmRT7syvsDi3BkLPmBTPnxN1B1juivGc/+h7m12rnoFJYgCrxyXGagQd/LAtWRGGKnGZroQxH/UOInzvzLDYz6Djgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706422; c=relaxed/simple;
	bh=DmqcJUeaSNdCIGW1Gb8XmWiE6/saEFpItKZnvHWAVfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtFTyWpDM4H+m8FKlRZ8ysIC0yJaFjjaoxQ8lL19JcxC80eEHASE6ZU4R8h9O8kbv90eITbL5sFiJfFIy5uNX2K0bJIlAOmboW/arpGA4F5SUK1Cucx2gGTg2xZLFxfh+wPURJG5hNvpAfS6Wkyx2zjKEn1g35p5u+kfDwuNE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CE8gm7Ty; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706421; x=1778242421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DmqcJUeaSNdCIGW1Gb8XmWiE6/saEFpItKZnvHWAVfQ=;
  b=CE8gm7TyMIVDX09kh+tP6OuGOD8n0Ml0kS01TEDB0JTiu8v0FU6Ayejx
   3aP6uULISVRyrIwmfrN25NMalInF7jsHb07j3Ocsem3lR8TeoYryuxUK8
   P7PZ2sVK9mk8QWFh3kLVr1SQD0BCBIi+/MA/jRodhc0BrMa3EA38aE7Pi
   2DzTT7SShySE4s0y8+KhJvacxMORZXbgqX4JvGl5ZG8LfawgVovmvm5lS
   qxoEnaXUDWdBffr+pbj7AjzhFHbutz7BIAwEad3hBRmYecIkB+ZzQWgt7
   XMDtkSjBcwJq44pPsb7PkXcfHzPHvOq+FAjYSPfYYi/9wTpsOk4uUcU3T
   Q==;
X-CSE-ConnectionGUID: jJHdDr9DRLqejedBITMvDg==
X-CSE-MsgGUID: XHFgEwkzS2ehvnNwFOGWHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688054"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688054"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:40 -0700
X-CSE-ConnectionGUID: c34k4PhqR0ic0vGi2SDdpw==
X-CSE-MsgGUID: 7Wy3+e0JRn6hQtW51Jk3+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347884"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: cfg: remove DCCM offsets from new devices
Date: Thu,  8 May 2025 15:13:04 +0300
Message-Id: <20250508121306.1277801-14-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
References: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is only used with old-style debug dump, which isn't
supported on newer devices, so remove the data.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.19b9c916a153.I7d53ac70cc61876e51c9f5c70fb42c5381992cd3@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 8 --------
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 8 --------
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 8 --------
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c    | 8 --------
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 8 --------
 5 files changed, 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 3ac9a8ec8915..273625e84676 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -19,10 +19,6 @@
 #define IWL_22000_NVM_VERSION		0x0a1d
 
 /* Memory offsets and lengths */
-#define IWL_22000_DCCM_OFFSET		0x800000 /* LMAC1 */
-#define IWL_22000_DCCM_LEN		0x10000 /* LMAC1 */
-#define IWL_22000_DCCM2_OFFSET		0x880000
-#define IWL_22000_DCCM2_LEN		0x8000
 #define IWL_22000_SMEM_OFFSET		0x400000
 #define IWL_22000_SMEM_LEN		0xD0000
 
@@ -64,10 +60,6 @@ static const struct iwl_family_base_params iwl_22000_base = {
 	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
-	.dccm_offset = IWL_22000_DCCM_OFFSET,				\
-	.dccm_len = IWL_22000_DCCM_LEN,					\
-	.dccm2_offset = IWL_22000_DCCM2_OFFSET,				\
-	.dccm2_len = IWL_22000_DCCM2_LEN,				\
 	.smem_offset = IWL_22000_SMEM_OFFSET,				\
 	.smem_len = IWL_22000_SMEM_LEN,					\
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index e52dea6b468a..82b127ffb537 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -19,10 +19,6 @@
 #define IWL_AX210_NVM_VERSION		0x0a1d
 
 /* Memory offsets and lengths */
-#define IWL_AX210_DCCM_OFFSET		0x800000 /* LMAC1 */
-#define IWL_AX210_DCCM_LEN		0x10000 /* LMAC1 */
-#define IWL_AX210_DCCM2_OFFSET		0x880000
-#define IWL_AX210_DCCM2_LEN		0x8000
 #define IWL_AX210_SMEM_OFFSET		0x400000
 #define IWL_AX210_SMEM_LEN		0xD0000
 
@@ -62,10 +58,6 @@ static const struct iwl_family_base_params iwl_ax210_base = {
 	.ucode_api_min = IWL_AX210_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
-	.dccm_offset = IWL_AX210_DCCM_OFFSET,				\
-	.dccm_len = IWL_AX210_DCCM_LEN,					\
-	.dccm2_offset = IWL_AX210_DCCM2_OFFSET,				\
-	.dccm2_len = IWL_AX210_DCCM2_LEN,				\
 	.smem_offset = IWL_AX210_SMEM_OFFSET,				\
 	.smem_len = IWL_AX210_SMEM_LEN,					\
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 8567c5ed92d7..8d6a042c9c64 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -19,10 +19,6 @@
 #define IWL_BZ_NVM_VERSION		0x0a1d
 
 /* Memory offsets and lengths */
-#define IWL_BZ_DCCM_OFFSET		0x800000 /* LMAC1 */
-#define IWL_BZ_DCCM_LEN			0x10000 /* LMAC1 */
-#define IWL_BZ_DCCM2_OFFSET		0x880000
-#define IWL_BZ_DCCM2_LEN		0x8000
 #define IWL_BZ_SMEM_OFFSET		0x400000
 #define IWL_BZ_SMEM_LEN			0xD0000
 
@@ -59,10 +55,6 @@ static const struct iwl_family_base_params iwl_bz_base = {
 	.ucode_api_min = IWL_BZ_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
-	.dccm_offset = IWL_BZ_DCCM_OFFSET,				\
-	.dccm_len = IWL_BZ_DCCM_LEN,					\
-	.dccm2_offset = IWL_BZ_DCCM2_OFFSET,				\
-	.dccm2_len = IWL_BZ_DCCM2_LEN,				\
 	.smem_offset = IWL_BZ_SMEM_OFFSET,				\
 	.smem_len = IWL_BZ_SMEM_LEN,					\
 	.apmg_not_supported = true,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 0a0a9b49d8ff..2d571ffe9588 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -18,10 +18,6 @@
 #define IWL_DR_NVM_VERSION		0x0a1d
 
 /* Memory offsets and lengths */
-#define IWL_DR_DCCM_OFFSET		0x800000 /* LMAC1 */
-#define IWL_DR_DCCM_LEN			0x10000 /* LMAC1 */
-#define IWL_DR_DCCM2_OFFSET		0x880000
-#define IWL_DR_DCCM2_LEN		0x8000
 #define IWL_DR_SMEM_OFFSET		0x400000
 #define IWL_DR_SMEM_LEN			0xD0000
 
@@ -52,10 +48,6 @@ static const struct iwl_family_base_params iwl_dr_base = {
 	.ucode_api_min = IWL_DR_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
-	.dccm_offset = IWL_DR_DCCM_OFFSET,				\
-	.dccm_len = IWL_DR_DCCM_LEN,					\
-	.dccm2_offset = IWL_DR_DCCM2_OFFSET,				\
-	.dccm2_len = IWL_DR_DCCM2_LEN,				\
 	.smem_offset = IWL_DR_SMEM_OFFSET,				\
 	.smem_len = IWL_DR_SMEM_LEN,					\
 	.apmg_not_supported = true,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 928b1514d33f..cdd859b93356 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -19,10 +19,6 @@
 #define IWL_SC_NVM_VERSION		0x0a1d
 
 /* Memory offsets and lengths */
-#define IWL_SC_DCCM_OFFSET		0x800000 /* LMAC1 */
-#define IWL_SC_DCCM_LEN			0x10000 /* LMAC1 */
-#define IWL_SC_DCCM2_OFFSET		0x880000
-#define IWL_SC_DCCM2_LEN		0x8000
 #define IWL_SC_SMEM_OFFSET		0x400000
 #define IWL_SC_SMEM_LEN			0xD0000
 
@@ -59,10 +55,6 @@ static const struct iwl_family_base_params iwl_sc_base = {
 	.ucode_api_min = IWL_SC_UCODE_API_MIN,				\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
-	.dccm_offset = IWL_SC_DCCM_OFFSET,				\
-	.dccm_len = IWL_SC_DCCM_LEN,					\
-	.dccm2_offset = IWL_SC_DCCM2_OFFSET,				\
-	.dccm2_len = IWL_SC_DCCM2_LEN,					\
 	.smem_offset = IWL_SC_SMEM_OFFSET,				\
 	.smem_len = IWL_SC_SMEM_LEN,					\
 	.apmg_not_supported = true,					\
-- 
2.34.1


