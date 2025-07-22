Return-Path: <linux-wireless+bounces-25788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC915B0D075
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E461188C8D7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521D28C5CA;
	Tue, 22 Jul 2025 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahgmxbt3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0DEEDE
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155721; cv=none; b=VzJEggOmL9BDMHY9yxutInvDl7CbvLnB7phE4egu64LC1ZuL0E+XK0FQxyTUIzGts3u3fMKMKHl2mK/sdwl6PEG98HhgIxLwdcc2Rkf9/PRtl+j3jLZzc6Os6Wnx/QZ5pdBp6N2ciXb0zH3VsM11oaxXF1gXljBRxqMfFI5fa0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155721; c=relaxed/simple;
	bh=IBpZPTlQNBgGCAa+Q4pAO2l+/gHIqegcWz9NlHWiFL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVo2VKr6BphLqH9J9pPj3uAf6NGMeFnUKnYalh0hw7ig147BiJ2M4UQnjdb4b1EM8wM4RgTLmksaoIUGQ7j0m5q8VYe82gy0djmf34fG0XGxkWztBqC4c1oFQhcOWNv2tCUapW55eHr9Z2ROAOe+SCRjiNQkOOkRgcbVMly8dIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahgmxbt3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155720; x=1784691720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IBpZPTlQNBgGCAa+Q4pAO2l+/gHIqegcWz9NlHWiFL8=;
  b=ahgmxbt32yOXpreyCjqGfxUj3nhKOe9Ww0ylQwoG7DRb9SjTTePDi1ak
   LrA4geyq8MA5Wkl3YDaZGgagUcgG9qO9HmytCrRoEvJw/KirHO10VexOR
   yRX5gD9um0ef+lz0u7xOQy+abUUhWM8bOTspR0EnrlW3ZZk6apThfGsT9
   Vp6ighYqWiFTeLoFu31imr6RZ0Z8bbFGvPlq1D3NFjfKVJ8Xa5SOpmtpW
   AnZ2Gxfweyspxv4m0On2jtk54PN/55nAPE/VvoNN6UmbKK7fSKBpxObBi
   EVmn56JOvO0IiwR7bDRPwnqeWFUYGFPOnNAuijvd31r7eAIsXTUjD0Ass
   g==;
X-CSE-ConnectionGUID: Jw6hXsnvSxSDLE7YzUAnqg==
X-CSE-MsgGUID: qkMwbohdQKayJPIMz1BYOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006161"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006161"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:42:00 -0700
X-CSE-ConnectionGUID: iTLay59FRb630Zvsozn5TQ==
X-CSE-MsgGUID: 1otdXm0uR8WEyO/zmNKVsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338119"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: remove SC2F firmware support
Date: Tue, 22 Jul 2025 06:41:19 +0300
Message-Id: <20250722063923.62bdc0dfb7e2.Iffa0a982f90a179566d85c60ccd3dbfc50e293ef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
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


