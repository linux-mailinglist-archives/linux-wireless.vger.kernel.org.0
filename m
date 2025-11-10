Return-Path: <linux-wireless+bounces-28781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C479AC46C14
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8483A07F2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D1530FC17;
	Mon, 10 Nov 2025 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWd/BnI3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D8310627
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779774; cv=none; b=GNdajubynmxRXhQM5TnsDdaNp+81k8eHzKCS9lw4hN+2HXv08Nuj6Gemo6i4ZG2ewoo5mdm3EuLaUMX2invaNphsYyOPscTzsxfqz5oTutsvjOO7lNXsWt3/BuKqig69h7nLHL1CCBofKGsb+GxR+JOJGY93bSjnr26tTk1JZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779774; c=relaxed/simple;
	bh=Cyw57PgUToIGHYEjeEvM6Etw8Vhv0zBKKyMVXcozc04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PeBGMio0KbP2EJ14hnuNyAzw6Gmwd0rZ3eYRXtTbq+3uRnvGY2mrvi8NQ/0BbmVUi5P5C4PT0Ol3Df1jud9PcuhBYQplSH/n9LUOS0zHWEITUw1TojQKe4EvzPKHFjJ81XaeAOJVaIsMbln9qeMNSg0yg1Su7TJh3kNRln1MuSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWd/BnI3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779773; x=1794315773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cyw57PgUToIGHYEjeEvM6Etw8Vhv0zBKKyMVXcozc04=;
  b=QWd/BnI3IXHO5tS0Q0nbUKsx6ySoRtJfo9GKqTK1ah0NC9zcX3AbCfTQ
   qFojLYv+4DpkjqvFP5M6XXJEqR1UOs0xQJszxCKghWMtgPvM0s5N/P2wQ
   f5eLtg8wJaATIe41GtjbP2CsM9UUCGQTlyiX6giuwSMHK87BCz5O/zgl5
   U1/VglgFrJc0DS20iva876nka5oDsU+F/xqBr+2wG/EPHaruU9R8BkYeD
   UyK3lhEyQ1bZARXkhMOt0pauSE5G+9JrnOi3QXXXajahgtdomjePwsAS6
   62+wk8/RT4aAec+7a5ON8etHraVAc7vfZM/wQEoM872KYt9/Jmkr7Xngw
   g==;
X-CSE-ConnectionGUID: SMIwn/RhQ8+fc98XWbwBQw==
X-CSE-MsgGUID: G7KyjP2yRiqA2ir0TPSUdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454898"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454898"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:52 -0800
X-CSE-ConnectionGUID: rWf29ok6RDedwQ4WgX3fOg==
X-CSE-MsgGUID: 6njxV0spR66vqtKAbCyAeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928573"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:51 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: cfg: move the MODULE_FIRMWARE to the per-rf file
Date: Mon, 10 Nov 2025 15:02:25 +0200
Message-Id: <20251110150012.9749e9514e8c.Ib6f15663c875cf231e97cb4b37adaf21fa616a77@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The MODULE_FIRMWARE are now located in the rf-*.h file and not in the
mac (bz.h in our case) files. Move them around for consistency.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 12 ------------
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index d25445bd1e5c..77db8c75e6e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -19,12 +19,6 @@
 #define IWL_BZ_SMEM_OFFSET		0x400000
 #define IWL_BZ_SMEM_LEN			0xD0000
 
-#define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
-#define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
-#define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
-#define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
-#define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
-
 static const struct iwl_family_base_params iwl_bz_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -100,9 +94,3 @@ const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 	.xtal_latency = 12000,
 	.low_latency_xtal = true,
 };
-
-IWL_CORE_FW(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-IWL_CORE_FW(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-IWL_CORE_FW(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-IWL_CORE_FW(IWL_GL_B_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-IWL_CORE_FW(IWL_GL_C_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
index fd82050e33a3..ad2536f53084 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
@@ -5,6 +5,12 @@
  */
 #include "iwl-config.h"
 
+#define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
+#define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
+#define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
+#define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
+#define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
+
 /* NVM versions */
 #define IWL_FM_NVM_VERSION		0x0a1d
 
@@ -50,3 +56,9 @@ const char iwl_be201_name[] = "Intel(R) Wi-Fi 7 BE201 320MHz";
 const char iwl_be200_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
 const char iwl_be202_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
 const char iwl_be401_name[] = "Intel(R) Wi-Fi 7 BE401 320MHz";
+
+IWL_CORE_FW(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_GL_B_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_GL_C_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-- 
2.34.1


