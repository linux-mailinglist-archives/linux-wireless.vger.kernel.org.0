Return-Path: <linux-wireless+bounces-22744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0C0AAF978
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390399E25F8
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC53722655E;
	Thu,  8 May 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cC8u07Sv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26622425B
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706411; cv=none; b=l/hwOvmodiK49Ln5MGjZ7iINIILpXkmY9hglTyfZoFEGljharM4hY/EzHU9DWYQm6Aju7o+hct97p40QR3bRcBVEe/qirq2dFaVQhAmdhahn4msrhbZJTlvKEyWiwFyqXV+GluG3boA2zjWshor5G+cz6uLeOdkp14LVU8NYM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706411; c=relaxed/simple;
	bh=H31lPHjIG3kaVyUNAR/dfHYcQSODZue6uU95sXHBnrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okej42q9OF/5UsLljIEmOQTwTKGa/E5NIKLGKoesgjoSfrrPMmkfTrqUSOc7LbStyyWwIn4YHaMAcUNl8C2+8JZCqi+V+wBV5bQfPSxo/PCMxtBmKGjnB5CTQqdSJ/o0Sdq4/znciX3PHRtjaYHTuv+JiG5xjxXSBK6tQ2Z1rvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cC8u07Sv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706410; x=1778242410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H31lPHjIG3kaVyUNAR/dfHYcQSODZue6uU95sXHBnrw=;
  b=cC8u07SvdKTTGPw/OY8OKw3RDu7Y/Gzu+Zo+kuEWJDsvfJDUw0tD00ST
   I9gVy4ukNp00jyDa6lXPzf3zYv1G1K17E3Hv8gucNojTPkLWoaOnQ/nBk
   LkiU7n47E2YQl0vvjFDPYwpqcF6HsjKSuUvcyQdRlR69aJj6tguBciJHA
   jModNUTjqePTWOJmfwadJ9I3fzR0ISvv2Ta8EtlRwmLbrgO7Mkm3h2zKs
   oeiarjdgaaDnbfAquDJqumIYStfTF2YWKAz/tpOLfBL+a5j64H/JAe20K
   Iy+eoJwy8vexk+ibhxGd4Pb8I8x+gdu4ZXc1ovniS0hOlxHYgKIw3TRPR
   Q==;
X-CSE-ConnectionGUID: A2MKBKHSR3OH7WnBgVxjPA==
X-CSE-MsgGUID: MHBo1phQQLKkIBnvEk3dOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688040"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688040"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:30 -0700
X-CSE-ConnectionGUID: LspzRDwpR1a2D6wZSOP6Ug==
X-CSE-MsgGUID: Ls39zds8QKyzMyL61fWX/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347822"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: cfg: remove nvm_hw_section_num from new devices
Date: Thu,  8 May 2025 15:12:57 +0300
Message-Id: <20250508121306.1277801-7-miriam.rachel.korenblit@intel.com>
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

This value hasn't been used since unified firmware in 22000
series, so there's no need to set the value for that or
newer devices. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.51885d609bd2.I4610a0c65646f0fefc7d4c9f463de86b4f5c8a0f@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c    | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 073e95a61c0d..33e70890f8a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -64,7 +64,6 @@ static const struct iwl_base_params iwl_22000_base_params = {
 #define IWL_DEVICE_22000_COMMON						\
 	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
-	.nvm_hw_section_num = 10,					\
 	.non_shared_ant = ANT_B,					\
 	.dccm_offset = IWL_22000_DCCM_OFFSET,				\
 	.dccm_len = IWL_22000_DCCM_LEN,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 21b1e257f751..0fcdca2d4a69 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -62,7 +62,6 @@ static const struct iwl_base_params iwl_ax210_base_params = {
 #define IWL_DEVICE_AX210_COMMON						\
 	.ucode_api_min = IWL_AX210_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
-	.nvm_hw_section_num = 10,					\
 	.non_shared_ant = ANT_B,					\
 	.dccm_offset = IWL_AX210_DCCM_OFFSET,				\
 	.dccm_len = IWL_AX210_DCCM_LEN,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index ea2d35cbc6f3..f347b9d29a12 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -59,7 +59,6 @@ static const struct iwl_base_params iwl_bz_base_params = {
 	.ucode_api_max = IWL_BZ_UCODE_API_MAX,			\
 	.ucode_api_min = IWL_BZ_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
-	.nvm_hw_section_num = 10,					\
 	.non_shared_ant = ANT_B,					\
 	.dccm_offset = IWL_BZ_DCCM_OFFSET,				\
 	.dccm_len = IWL_BZ_DCCM_LEN,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index cbac8f12e2d8..1218aec8b49a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -52,7 +52,6 @@ static const struct iwl_base_params iwl_dr_base_params = {
 	.ucode_api_max = IWL_DR_UCODE_API_MAX,			\
 	.ucode_api_min = IWL_DR_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
-	.nvm_hw_section_num = 10,					\
 	.non_shared_ant = ANT_B,					\
 	.dccm_offset = IWL_DR_DCCM_OFFSET,				\
 	.dccm_len = IWL_DR_DCCM_LEN,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 673e29f02b00..5ae1bc4831e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -59,7 +59,6 @@ static const struct iwl_base_params iwl_sc_base_params = {
 	.ucode_api_max = IWL_SC_UCODE_API_MAX,				\
 	.ucode_api_min = IWL_SC_UCODE_API_MIN,				\
 	.led_mode = IWL_LED_RF_STATE,					\
-	.nvm_hw_section_num = 10,					\
 	.non_shared_ant = ANT_B,					\
 	.dccm_offset = IWL_SC_DCCM_OFFSET,				\
 	.dccm_len = IWL_SC_DCCM_LEN,					\
-- 
2.34.1


