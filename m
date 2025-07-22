Return-Path: <linux-wireless+bounces-25824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8AB0D4A4
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BC53A46A8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9E52DA760;
	Tue, 22 Jul 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMIzlYlC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472012D660B
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172984; cv=none; b=ANbJSzn36Xtc9GIiLudIxWsWUNLo5K4vp8z0Ekw/T73KsvMcOYIANIbiarS2FsBEJFrr9A5d1w4aTcuFP2SgMBImGNJbJ7ZxZYDJ2jYcF1jRZAR2EfayCLIsXg4Ra8qUL4mNDYHNByiKzHEfJePiyfuIM4mHOkvbcpfTq0Ylzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172984; c=relaxed/simple;
	bh=IBpZPTlQNBgGCAa+Q4pAO2l+/gHIqegcWz9NlHWiFL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GeSOrR9o1I9mxrcWgc9VppcmOG1QqXpQDmelMlx/s3DSNyYzPCrWrmV/e8D1Cop4jJa7o2XdY4dhpiFjxewJrrKRawJM5DnbJLWVTCdW7JlkTQBd8vTUnZvHGjMndesQ3y/fOeVmZUK+x9iL6VLu7733ZzHIUVB8Hr4T05aa64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMIzlYlC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172984; x=1784708984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IBpZPTlQNBgGCAa+Q4pAO2l+/gHIqegcWz9NlHWiFL8=;
  b=bMIzlYlC1r4eOzqkVOZUlmtxd9o3PtP5c3cu4oX+dy+llsqDoTzo2QVX
   jjKJko2A+RobBy2XXgTe3QzjUW/hF1MroKahfwH/hufAaztpOFN/1XyZQ
   aqGsPQfi5y8Fx5z1dbcn/ILX0rzD0Jv8xaNxDVWARUbWZ0XtplAzhu/Ol
   QS78HvIO9ZiIGqg4wVkEwBaAzAzcSHl7YEYOklLCv+sP45keWWMNqA/Ok
   0McfuukKtXHSmz+FgnKXDSG39mLmjI52k3a6Pfq8qEEPL7LebPYuTQ9TC
   j9VWcfBmOB6Ommz98hnn3j4oNCeh/J+6/PUFevj/Tpxa2cM8OWCALg8DA
   A==;
X-CSE-ConnectionGUID: OtP+9bQURE28ilbmYqE0Vg==
X-CSE-MsgGUID: e8u5V4QnSwGCdN8/A2AxjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569896"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569896"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:44 -0700
X-CSE-ConnectionGUID: oMN7NpFASTG7/f5EugpAdg==
X-CSE-MsgGUID: hPCYsSJESzO6OncrkmQBjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124283"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: remove SC2F firmware support
Date: Tue, 22 Jul 2025 11:29:04 +0300
Message-Id: <20250722112718.62bdc0dfb7e2.Iffa0a982f90a179566d85c60ccd3dbfc50e293ef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
References: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The only difference between SC2 and SC2F is that they use a different
FSEQ image.
The firmware of SC2 implements the logic of selecting the right FSEQ
image to load, so there is no need for SC2F firmware image.
Stop loading it, and load SC2 image instead.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c  | 4 ----
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 5 ++---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 7b70640abf53..6d4a3bce49b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -27,8 +27,6 @@
 #define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0"
 #define IWL_SC2_A_FM_C_FW_PRE		"iwlwifi-sc2-a0-fm-c0"
 #define IWL_SC2_A_WH_A_FW_PRE		"iwlwifi-sc2-a0-wh-a0"
-#define IWL_SC2F_A_FM_C_FW_PRE		"iwlwifi-sc2f-a0-fm-c0"
-#define IWL_SC2F_A_WH_A_FW_PRE		"iwlwifi-sc2f-a0-wh-a0"
 
 static const struct iwl_family_base_params iwl_sc_base = {
 	.num_of_queues = 512,
@@ -101,5 +99,3 @@ IWL_FW_AND_PNVM(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC2_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC2_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_SC2F_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_SC2F_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 6d983fe2ee44..28aad975434b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -236,10 +236,9 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 		mac = "sc";
 		break;
 	case IWL_CFG_MAC_TYPE_SC2:
-		mac = "sc2";
-		break;
+	/* Uses the same firmware as SC2 */
 	case IWL_CFG_MAC_TYPE_SC2F:
-		mac = "sc2f";
+		mac = "sc2";
 		break;
 	case IWL_CFG_MAC_TYPE_BR:
 		mac = "br";
-- 
2.34.1


