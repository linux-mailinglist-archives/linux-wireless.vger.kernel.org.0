Return-Path: <linux-wireless+bounces-36369-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH5WOjgQBGoMDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36369-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:46:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A47A52DB62
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C152D30CD86E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919DF2030A;
	Wed, 13 May 2026 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoE2Pdm7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C93A6F0D
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651074; cv=none; b=baNQJZxR9RZ84eewYWqETkW/GAe2A6XWgggGhjoxednB0R9qJn6cnGTxZY9pIqftw8PSHjAvVtM897lWHFDmScdi3Ac7kgngEDDZBQuVIGGgntA8U9zCL+ksZ0tzSaf2OUDOtrDhVfoAFY5Rrh5qy9dw8sGrtXJ8iqtOvryzk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651074; c=relaxed/simple;
	bh=NEiB2SYIA16pSPQgsrjBDWOOPhGTPAQJNOvjuv2LK3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2cjtVg46SpqydePJArycO606jgU8vQ/ux8ZHAuDE7rKouv9xiDLl9DS4D6zYsTbyJlgWmArubJXZGuDSMMJCdCWnqsCokmgy0eapxZr2R9QygZsrnbKdA5RzpsT9pJ/wATVgyO54/zj93QUPl42gU60w6nSHmmLk7LHXpkZPaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoE2Pdm7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651072; x=1810187072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NEiB2SYIA16pSPQgsrjBDWOOPhGTPAQJNOvjuv2LK3U=;
  b=XoE2Pdm7DmuMh9vpdgded/5nymTROmlbXsYxhJBiVQW8V7yyfJr6XbW5
   a6K5MlBlfHpbPD472bf6mF+amRXHeuhXiwjV7RdW+qszuo43HpTE3DNVh
   D577Is2lrKfFWm+W9MAZzOuBDVviyVjFjmN/6TwUo9+yUgiTvWRS43faU
   SqCUOF+qx77D+strYoC3yy+jg7Tvz4R5Gb+Ez6/NB6svxMvhn5T1IbzO7
   fBowNHdXrlwzyIk0V5t/OwtiBap1gGcVNLebMGGhHJPEbq4yvCDKQawBk
   C4zsRPSTAfHA9QRbhqVQTvUMhst7+PjkGo0HWbrLzmbnQpzFIPGLBDaTx
   A==;
X-CSE-ConnectionGUID: XiDd6MEgQEeNVyKhNb98dA==
X-CSE-MsgGUID: V4ZQ0FxHR/2JghnWwgjVUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552842"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552842"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:32 -0700
X-CSE-ConnectionGUID: QSJgGPlpTTe+tp18fUcD8Q==
X-CSE-MsgGUID: cA57Y+ORRrKXPOVBbt9XUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077944"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: define MODULE_FIRMWARE with the correct API
Date: Wed, 13 May 2026 08:43:59 +0300
Message-Id: <20260513084215.c8dcacbeb616.I3d51a9daeda6fb7f52b3014101db79fdc98295d5@changeid>
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
X-Rspamd-Queue-Id: 6A47A52DB62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36369-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

A firmware API of a mix and match (MAC + RF) is the lower one of the
two. But the MODULE_FIRMWARE of QU/QUZ/SO/MA/TY with GF/HR, was defined
using the max API of GF/HR, which is 100, instead of the max API of
QU/QUZ/SO/MA/TY, which are API 77/89.
Therefore, the wrong firmware files were published in the modinfo,
leading to missing firmware files.

Fix this by using the right API when declaring MODULE_FIRMWARE.

While at it, add a IWL_FW_AND_PNVM entry for SO and GF4, that was
missing.

Fixes: db35444d557f ("wifi: iwlwifi: assign a FW API range for HR")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 12 ++++++++
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 29 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    | 13 ---------
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    | 24 ---------------
 4 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index e929a08e7585..01ca65eb5acd 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -16,9 +16,18 @@
 #define IWL_22000_UCODE_API_MIN	77
 
 #define IWL_CC_A_FW_PRE			"iwlwifi-cc-a0"
+#define IWL_QU_B_HR_B_FW_PRE		"iwlwifi-Qu-b0-hr-b0"
+#define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0"
+#define IWL_QUZ_A_HR_B_FW_PRE		"iwlwifi-QuZ-a0-hr-b0"
 
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
 	IWL_CC_A_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_QU_B_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_QU_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_QUZ_A_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_QUZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_QU_C_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_QU_C_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_family_base_params iwl_22000_base = {
 	.num_of_queues = 512,
@@ -104,4 +113,7 @@ const char iwl_ax201_killer_1650s_name[] =
 const char iwl_ax201_killer_1650i_name[] =
 	"Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)";
 
+MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index ec1951a94e23..2519f577669e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -15,6 +15,24 @@
 /* Lowest firmware API version supported */
 #define IWL_AX210_UCODE_API_MIN	89
 
+#define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0"
+#define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0"
+#define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0"
+#define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0"
+#define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0"
+#define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0"
+#define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0"
+#define IWL_SO_A_HR_B_FW_PRE		"iwlwifi-so-a0-hr-b0"
+#define IWL_MA_A_HR_B_FW_PRE		"iwlwifi-ma-a0-hr-b0"
+#define IWL_MA_B_HR_B_FW_PRE		"iwlwifi-ma-b0-hr-b0"
+
+#define IWL_SO_A_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_SO_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_MA_A_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_MA_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_MA_B_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_MA_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+
 static const struct iwl_family_base_params iwl_ax210_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -112,3 +130,14 @@ const struct iwl_mac_cfg iwl_ma_mac_cfg = {
 	.integrated = true,
 	.umac_prph_offset = 0x300000
 };
+
+IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_TY_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_B_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_SO_A_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_A_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_B_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
index e6f7066f5c7c..8b63cdb3d66c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
@@ -11,13 +11,6 @@
 /* Lowest firmware API version supported */
 #define IWL_GF_UCODE_API_MIN	100
 
-#define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0"
-#define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0"
-#define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0"
-#define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0"
-#define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0"
-#define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0"
-#define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0"
 #define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0"
 #define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0"
 #define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0"
@@ -70,12 +63,6 @@ const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
 const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6 AX231";
 const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
 
-IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_TY_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_MA_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_MA_B_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_MA_A_GF4_A_FW_PRE, IWL_GF_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_MA_B_GF4_A_FW_PRE, IWL_GF_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_GF_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_GF_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SC_A_GF_A_MODULE_FIRMWARE(IWL_GF_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
index 3c3a8d5702d8..16b9075acdd8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
@@ -11,28 +11,10 @@
 /* Lowest firmware API version supported */
 #define IWL_HR_UCODE_API_MIN	100
 
-#define IWL_QU_B_HR_B_FW_PRE		"iwlwifi-Qu-b0-hr-b0"
-#define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0"
-#define IWL_QUZ_A_HR_B_FW_PRE		"iwlwifi-QuZ-a0-hr-b0"
-#define IWL_SO_A_HR_B_FW_PRE		"iwlwifi-so-a0-hr-b0"
-#define IWL_MA_A_HR_B_FW_PRE		"iwlwifi-ma-a0-hr-b0"
-#define IWL_MA_B_HR_B_FW_PRE		"iwlwifi-ma-b0-hr-b0"
 #define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0"
 #define IWL_SC_A_HR_A_FW_PRE		"iwlwifi-sc-a0-hr-b0"
 #define IWL_SC_A_HR_B_FW_PRE		"iwlwifi-sc-a0-hr-b0"
 
-#define IWL_QU_B_HR_B_MODULE_FIRMWARE(api)	\
-	IWL_QU_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_QUZ_A_HR_B_MODULE_FIRMWARE(api)	\
-	IWL_QUZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_QU_C_HR_B_MODULE_FIRMWARE(api)	\
-	IWL_QU_C_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SO_A_HR_B_MODULE_FIRMWARE(api)	\
-	IWL_SO_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(api)	\
-	IWL_MA_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(api)	\
-	IWL_MA_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api)	\
 	IWL_BZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(api)	\
@@ -74,12 +56,6 @@ const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
 const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
 const char iwl_ax203_name[] = "Intel(R) Wi-Fi 6 AX203";
 
-MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
-- 
2.34.1


