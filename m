Return-Path: <linux-wireless+bounces-22746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19CAAF97B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403151C0087C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6532253F7;
	Thu,  8 May 2025 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YY/CGPqe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3902253F2
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706417; cv=none; b=mkILgiC7cYKUCyil8V6Y+z2DTqRklYtozNyIuVqNwKo+I77mUxJ3bBWkd7WK5pCb+M0q0J8H29zKDDvkWFf9bKayLpp8lAezw2ZlMMFG8QQKi7FapF0U1g3FJ/4HiHZVT5RvWfRdsbwkAHuktfJFGQ6pbynBsJpd8Kturl3N29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706417; c=relaxed/simple;
	bh=E1Cjx+26wC5r9O7/nLZ29LAZtXTRxPdVjEWrOuPCIOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Av80uYLcBqo7o1JKE84aDZZ9NG7WhwqVaAolzzhi++oNUDTk+EdkEUhUumLS9Itoywpfjx7qkMzwHk4aOPH4yoeZ5TtTXzdBsSqpydVw2P1zQpOcHJNLQGh4QTXIjzeghtdm27aNww7CD13dtDbEcoPxbd1Hb/tpdOBYVRIlzrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YY/CGPqe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706415; x=1778242415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E1Cjx+26wC5r9O7/nLZ29LAZtXTRxPdVjEWrOuPCIOI=;
  b=YY/CGPqeGTdGmVbhKHgVnjFQ6K3jpIzufWRslhqNiL8XJ0qLRvQph0Q5
   6q9mXf1MVwzmsxTv3DJU/ExglAQYkr00+kOE0wWaSlrjpaQs1QupVS+EU
   KzwBU5KJJ7HJ+A9qoPD4G05+o5o12v+HQAvAJ4g9Vwxcpa1Km+uDxlR5X
   dm+tM6nIw9mT05xKIrOBfI653SeYnra/CLnpujs2dFNpPpE29XAm2O0Ff
   7e4+254fZQovL6wIXANSFT2liX8j/TchRsymFW3XIl2xWERJ6f6sL3/ck
   iwbd1P+EJYw/ujnjtXHy8veZ3+rDr2A3uOHkTav0g8S/5Bt0ypnwH8JAz
   g==;
X-CSE-ConnectionGUID: Sz61OTvxQECyPNO9NCKfGA==
X-CSE-MsgGUID: hFXtbBMkQzaeevqzNKMGhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688047"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688047"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:35 -0700
X-CSE-ConnectionGUID: yL5RTVrfToamhaUpVYZWTA==
X-CSE-MsgGUID: ZJApyLMBQpqpVd7Qd6M+4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347858"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: cfg: remove dbgc_supported field
Date: Thu,  8 May 2025 15:13:00 +0300
Message-Id: <20250508121306.1277801-10-miriam.rachel.korenblit@intel.com>
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

This field is unused, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.d2301d9ae76d.I3b8fbf6f64fc0d648cfe634f131352041538ad98@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c   | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c   | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c  | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c     | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 1 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index e99c727f81f4..db11252ca73c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -83,7 +83,6 @@ static const struct iwl_base_params iwl_22000_base_params = {
 	},								\
 	.nvm_ver = IWL_22000_NVM_VERSION,				\
 	.nvm_type = IWL_NVM_EXT,					\
-	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x400000,				\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 60 * 1024,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index d31f38c76a86..337c35a36627 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -87,7 +87,6 @@ const struct iwl_mac_cfg iwl8000_mac_cfg = {
 	.thermal_params = &iwl8000_tt_params,				\
 	.apmg_not_supported = true,					\
 	.nvm_type = IWL_NVM_EXT,					\
-	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x800000
 
 #define IWL_DEVICE_8260							\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index abfdecad7967..0c3429dfca2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -85,7 +85,6 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = 0x380,					\
 	.nvm_type = IWL_NVM_EXT,					\
-	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x800000,				\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 92 * 1024,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index acceb6dda0af..d78f8ecaf133 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -81,7 +81,6 @@ static const struct iwl_base_params iwl_ax210_base_params = {
 	},								\
 	.nvm_ver = IWL_AX210_NVM_VERSION,				\
 	.nvm_type = IWL_NVM_EXT,					\
-	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x400000,				\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 60 * 1024,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 8aad515c1464..61ba92cac37c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -71,7 +71,6 @@ static const struct iwl_base_params iwl_bz_base_params = {
 	.mac_addr_from_csr = 0x30,					\
 	.nvm_ver = IWL_BZ_NVM_VERSION,				\
 	.nvm_type = IWL_NVM_EXT,					\
-	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0xD0000,				\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 60 * 1024,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 9b4d008cd8ad..9b1ae8de7529 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -64,7 +64,6 @@ static const struct iwl_base_params iwl_dr_base_params = {
 	.mac_addr_from_csr = 0x30,					\
 	.nvm_ver = IWL_DR_NVM_VERSION,				\
 	.nvm_type = IWL_NVM_EXT,					\
-	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0xD0000,				\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 60 * 1024,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index b0ddda3718e7..d06e15a5a9d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -71,7 +71,6 @@ static const struct iwl_base_params iwl_sc_base_params = {
 	.mac_addr_from_csr = 0x30,					\
 	.nvm_ver = IWL_SC_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT,					\
-	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0xD0000,				\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 60 * 1024,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index accbc684e59d..85afdff0cc98 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -385,7 +385,6 @@ struct iwl_cfg {
 	    lp_xtal_workaround:1,
 	    apmg_not_supported:1,
 	    vht_mu_mimo_supported:1,
-	    dbgc_supported:1,
 	    uhb_supported:1;
 	u8 valid_tx_ant;
 	u8 valid_rx_ant;
-- 
2.34.1


