Return-Path: <linux-wireless+bounces-37037-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LdROtZOF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37037-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2D5E9E8A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35CD0307933C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71E3B6374;
	Wed, 27 May 2026 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPBnZ/Bv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55A3B635A
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912345; cv=none; b=OtwDf4GSf9Rdwma1esf6Pc80ZRTrAGMtYT63izDG1jCgt3say9Ubbu7TSyH0K4m37sjXJR+AzfDmLk6BMSDwDGXetZ7deVi6YMIZ781xwuueSDQCs8Pid56eLkPT7+vu1c11aL4VCWHcWdyoM9LRLZmHfnJwL84A01vM7aGBozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912345; c=relaxed/simple;
	bh=Zqq4QxlwSJ2Y6Jidu/qpAPUfwCmRHPM45PxzaLBeOUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NB3gnkbBUwXGs0SkpHVpxB2nUFj0BnDp5T6BpLmMh16E5Zx3F9lxOrRr/b9DyXqMJKdy5D8/8AnPyp7UgX2rsX98wMxFpREVHxZlHMqwfzAxrmF8Cli3rmgPCxHFVPrTZhLQ463ScRAqajgxozYY0j/VMaubhOiCrI8qVah2RWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPBnZ/Bv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912343; x=1811448343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zqq4QxlwSJ2Y6Jidu/qpAPUfwCmRHPM45PxzaLBeOUY=;
  b=QPBnZ/Bvtq0aZ6yGdaed3zjaQ7i4lMR5eysdYb34Xa8bHIsq7Qe+QDNS
   jMPTujU1IAo+QxSAqPwXL/HabgVcQLJZLCaoBRTYBso52tGl7SEsqj+Xm
   esf4RZCm3hBPxFA1cnnaWO/7ThBcIjiZvL9LBVQo0jWRRVi6Q2btmq9qp
   rhgdqSxMHD1QzzZ+dPYdRE5HgnNiK1ov2cNaoWXU60ns64/0X6X3LVgvy
   tgHVtOiVQbJvbhhFlM3F5aGVHGT4ES49ABydNgTR+UFhj14aSULh5cyTt
   B5Hlz07ExVU8HbtKyqURfrTeh0HqkZLvrjAtcnSScR+9v6kgPZhbQdWZM
   Q==;
X-CSE-ConnectionGUID: y9U2zpzbSBagwHusqgAs3w==
X-CSE-MsgGUID: yC2PtCs2Qmy726wuSGInTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940875"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940875"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:42 -0700
X-CSE-ConnectionGUID: aKpNq55/QfSo6iLN2W80Gw==
X-CSE-MsgGUID: BJYndFm2QzaHuhvBQu6AyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286979"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Shahar Tzarfati <shahar.tzarfati@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: cfg: Revert "wifi: iwlwifi: cfg: move the MODULE_FIRMWARE to the per-rf file"
Date: Wed, 27 May 2026 23:05:08 +0300
Message-Id: <20260527230313.a10bc3359dca.I446a1340c635f07aff3efaba5317635e010c156f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-37037-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6CF2D5E9E8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shahar Tzarfati <shahar.tzarfati@intel.com>

IWL_BZ_UCODE_CORE_MAX is undefined in cfg/rf-fm.c, this
causes __stringify(core) to turn it into the literal
token text, so MODULE_FIRMWARE entries are generated as
"iwlwifi...-cIWL_BZ_UCODE_CORE_MAX.ucode",
instead of the actual number.

This reverts the commit below.

Fixes: e4d47493c6be ("wifi: iwlwifi: cfg: move the MODULE_FIRMWARE to the per-rf file")
Signed-off-by: Shahar Tzarfati <shahar.tzarfati@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 12 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index ecb4f81a99f5..9cdc4f142c7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -15,6 +15,12 @@
 /* Lowest firmware core release supported */
 #define IWL_BZ_UCODE_CORE_MIN	101
 
+#define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
+#define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
+#define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
+#define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
+#define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
+
 static const struct iwl_family_base_params iwl_bz_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -85,3 +91,9 @@ const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 	.xtal_latency = 12000,
 	.low_latency_xtal = true,
 };
+
+IWL_CORE_FW(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_GL_B_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_GL_C_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
index 294cf25ae2a6..35b1618f3474 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
@@ -5,12 +5,6 @@
  */
 #include "iwl-config.h"
 
-#define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
-#define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
-#define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
-#define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
-#define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
-
 #define IWL_DEVICE_FM							\
 	.ht_params = {							\
 		.stbc = true,						\
@@ -54,9 +48,3 @@ const char iwl_be201_name[] = "Intel(R) Wi-Fi 7 BE201 320MHz";
 const char iwl_be200_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
 const char iwl_be202_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
 const char iwl_be401_name[] = "Intel(R) Wi-Fi 7 BE401 320MHz";
-
-IWL_CORE_FW(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-IWL_CORE_FW(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-IWL_CORE_FW(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-IWL_CORE_FW(IWL_GL_B_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-IWL_CORE_FW(IWL_GL_C_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-- 
2.34.1


