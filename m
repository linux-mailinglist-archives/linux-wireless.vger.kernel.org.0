Return-Path: <linux-wireless+bounces-22748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78AEAAF97E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441214C5494
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8729322425B;
	Thu,  8 May 2025 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8UYb909"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC9228CBC
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706420; cv=none; b=ars849XLPSSbxwmd9OR73UCtfu8W7YAuMeqvvpLyilFmFBdBh/lWmGnaZmXq7NwQZ73kuBDMWTMZdSd5xSOVW46g9pfb4R5FJytueAtCdcgq0BI/2i+uawa7TyOYQVjbmATP3pW+ACY3BUSwmk/W95mCmWNrgS+GmJjLI4yD14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706420; c=relaxed/simple;
	bh=+XxxCIU//6JhU/Xd6Df24dBP57JNUESbzFl1gSibs4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvON2TD/Q8HX/exTFhBNYr2kOQ1ILMxtbDy4PC4XpgCDtvbVvAL77xU6MkBLVMQ4+7oaQhfNB5JScopOKBZkhDl8MMDfM0VwjS5vsoLsnM2s8hW1dV675z+uXplj2pWYSoGbrKjF5OdW+uIEOtjtk/7MtmyqiDGXne52NWULk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8UYb909; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706419; x=1778242419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+XxxCIU//6JhU/Xd6Df24dBP57JNUESbzFl1gSibs4s=;
  b=I8UYb909pjE5TPWMLaehS18XS1e1woOuUwWXYy42dENvoZHE3RllCLRP
   IaONP1cFaArWxrgtRu0oyIZvJFYZUmTXX3GEUqFTBF0l5MuXayIrOjZ9A
   KuWyZtUz0eWTNe1gCcapFUOOm2UCPC2cnCp2c80mGyqfGbjziLuvI5uyO
   8eUO/J0yZAQmyBKm9kt6SHwVp4HcpTX0W0eJC70ocJ+P/Lpf7liYZ/vV9
   8p1/Z0/+PBZx6wTUJYY9uwD/FKhVJ97/ffTqFuwGLmyonHP/yQNXSzLhh
   jRWEaq07EP4jG87Cm6cbdNmdiKbNADCEfIF9pHQ50Klj6GLb0tMltPUa9
   w==;
X-CSE-ConnectionGUID: fxnX6RDUTdWcOXCy2QuKLg==
X-CSE-MsgGUID: GYNNZF4gQNupOvVyxreT3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688051"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688051"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:39 -0700
X-CSE-ConnectionGUID: xTWVxm/pSS2vpV2zU9f31A==
X-CSE-MsgGUID: cB26HjrlRLKrUHQ6cQRtzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347878"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: cfg: remove eeprom_size from new devices
Date: Thu,  8 May 2025 15:13:03 +0300
Message-Id: <20250508121306.1277801-13-miriam.rachel.korenblit@intel.com>
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

Since 22000 series, the data is read by the firmware and the
driver doesn't need to know, remove the useless setting.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.420ce8b4d79e.I1deccbaebe2cb3d89fdd7e8e27d1777bf480bb6a@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c    | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 09286509fe3e..3ac9a8ec8915 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -50,7 +50,6 @@
 	IWL_CC_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_family_base_params iwl_22000_base = {
-	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 256,
 	.shadow_ram_support = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 8c26cc90d0f0..e52dea6b468a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -48,7 +48,6 @@
 	IWL_MA_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_family_base_params iwl_ax210_base = {
-	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.shadow_ram_support = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index dd4952b11a33..8567c5ed92d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -44,7 +44,6 @@ const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
 #endif
 
 static const struct iwl_family_base_params iwl_bz_base = {
-	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.shadow_ram_support = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 011b299045c4..0a0a9b49d8ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -37,7 +37,6 @@
 	IWL_BR_A_PE_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_family_base_params iwl_dr_base = {
-	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.shadow_ram_support = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index e5f780f4e73d..928b1514d33f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -44,7 +44,6 @@
 	IWL_SC_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_family_base_params iwl_sc_base = {
-	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.shadow_ram_support = true,
-- 
2.34.1


