Return-Path: <linux-wireless+bounces-36361-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFOuAr4PBGoMDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36361-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:44:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B319052DACD
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 811373067BAB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A5A3A48E0;
	Wed, 13 May 2026 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXEp4feG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A53A6EEE
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651063; cv=none; b=hUYh1BJY5qAnxZ9rm45iEQ92khVMx1JCcLGYfhBCLwvUI/+U5pSaay7WUCATPzFZbqI7Nn3eoJG60V67bXpMG+1uFKEJx7fJ+2d9PK8W3EJEkc/CaTqVoBbwCFXB8EN1B1y9mqTukSHDIaKSKBby/wGzumlWPKZ+sY3BPxhgz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651063; c=relaxed/simple;
	bh=Xs0mbxsBcSCj28p0HHNcKnQicpr5ElDIg4zIVRRBukQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kceMlpDV5KzIKfNUhWz1zPEy5zQdOSBDGGoRp2YhrIB/3Cb5Zw5UHDlzovKH0/VmVOemMGPb+ab6rH/CpdwLCPUsEnTmzblAjbJLUXlhVBd4fAUrpqEuE13aqaQw63isS8O4Zbouqig2Y2Yr38I+oyuK+F7Jcwxwc38eTaw1Wto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXEp4feG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651062; x=1810187062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xs0mbxsBcSCj28p0HHNcKnQicpr5ElDIg4zIVRRBukQ=;
  b=OXEp4feGAL++EbPiU9xaowiKAs9Rb8o57wnw+sXs08x4ldSN2QcX1x9H
   POc+orA2+Jhv8pDTd5oENKmkrhn89D5WCC/Qy0mcy9QUv/US52n5CeZLW
   HaaIM0m8qcgaQLunLBcWhNC3XYHEzTmfRRLiMh6RSvLach38LkGDJ+KGf
   By5iiw5xvCwBQEdl1+tm57LnJODWJuHfjFCy5nOpJVaVU9rtZDAPOZMO+
   mIfzQm3XsC4xzjlv7jvDR3UEm+Hs0j8IbVofCgJJjKzAn2IFdDTi4pema
   uGfhJYIfJ86zWhcneMxAnY3XSPHaiJesiwTib59DJXheW0+WCN5VeAqCP
   g==;
X-CSE-ConnectionGUID: At+TCv56Sry36GszJI4+MQ==
X-CSE-MsgGUID: fIPgGD//TCm/pT6R/Zyljg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552810"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552810"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:22 -0700
X-CSE-ConnectionGUID: L5j0rUdtSvuigIDUDQLOiQ==
X-CSE-MsgGUID: xH2LdbpnT0GGZBbSo4pLWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077904"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: smem_offset smem_len are not needed from 22000 and up
Date: Wed, 13 May 2026 08:43:51 +0300
Message-Id: <20260513084215.18095aac398a.I0bdc5120b9b4226692dcffb1c5971f617d99e632@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B319052DACD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36361-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This was used for the old (pre-ini) debug mechanism which is now
obsolete.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 6 ------
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 6 ------
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 6 ------
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c    | 6 ------
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 6 ------
 5 files changed, 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 563c596240b2..e929a08e7585 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -15,10 +15,6 @@
 /* Lowest firmware API version supported */
 #define IWL_22000_UCODE_API_MIN	77
 
-/* Memory offsets and lengths */
-#define IWL_22000_SMEM_OFFSET		0x400000
-#define IWL_22000_SMEM_LEN		0xD0000
-
 #define IWL_CC_A_FW_PRE			"iwlwifi-cc-a0"
 
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
@@ -30,8 +26,6 @@ static const struct iwl_family_base_params iwl_22000_base = {
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
-	.smem_offset = IWL_22000_SMEM_OFFSET,
-	.smem_len = IWL_22000_SMEM_LEN,
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x380,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index ee24ded67069..ec1951a94e23 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -15,18 +15,12 @@
 /* Lowest firmware API version supported */
 #define IWL_AX210_UCODE_API_MIN	89
 
-/* Memory offsets and lengths */
-#define IWL_AX210_SMEM_OFFSET		0x400000
-#define IWL_AX210_SMEM_LEN		0xD0000
-
 static const struct iwl_family_base_params iwl_ax210_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
-	.smem_offset = IWL_AX210_SMEM_OFFSET,
-	.smem_len = IWL_AX210_SMEM_LEN,
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x380,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 1b14ba5a09f9..a70b356d9576 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -15,18 +15,12 @@
 /* Lowest firmware core release supported */
 #define IWL_BZ_UCODE_CORE_MIN	101
 
-/* Memory offsets and lengths */
-#define IWL_BZ_SMEM_OFFSET		0x400000
-#define IWL_BZ_SMEM_LEN			0xD0000
-
 static const struct iwl_family_base_params iwl_bz_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
-	.smem_offset = IWL_BZ_SMEM_OFFSET,
-	.smem_len = IWL_BZ_SMEM_LEN,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x30,
 	.d3_debug_data_base_addr = 0x401000,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index afde84ad0493..e95112fdc664 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -14,10 +14,6 @@
 /* Lowest firmware core release supported */
 #define IWL_DR_UCODE_CORE_MIN	101
 
-/* Memory offsets and lengths */
-#define IWL_DR_SMEM_OFFSET		0x400000
-#define IWL_DR_SMEM_LEN			0xD0000
-
 #define IWL_DR_A_PE_A_FW_PRE		"iwlwifi-dr-a0-pe-a0"
 
 static const struct iwl_family_base_params iwl_dr_base = {
@@ -26,8 +22,6 @@ static const struct iwl_family_base_params iwl_dr_base = {
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
-	.smem_offset = IWL_DR_SMEM_OFFSET,
-	.smem_len = IWL_DR_SMEM_LEN,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x30,
 	.d3_debug_data_base_addr = 0x401000,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 52a08105d0c4..d1e5cef42fff 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -15,10 +15,6 @@
 /* Lowest firmware core release supported */
 #define IWL_SC_UCODE_CORE_MIN	101
 
-/* Memory offsets and lengths */
-#define IWL_SC_SMEM_OFFSET		0x400000
-#define IWL_SC_SMEM_LEN			0xD0000
-
 #define IWL_SC_A_FM_B_FW_PRE		"iwlwifi-sc-a0-fm-b0"
 #define IWL_SC_A_FM_C_FW_PRE		"iwlwifi-sc-a0-fm-c0"
 #define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0"
@@ -31,8 +27,6 @@ static const struct iwl_family_base_params iwl_sc_base = {
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
-	.smem_offset = IWL_SC_SMEM_OFFSET,
-	.smem_len = IWL_SC_SMEM_LEN,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x30,
 	.d3_debug_data_base_addr = 0x401000,
-- 
2.34.1


