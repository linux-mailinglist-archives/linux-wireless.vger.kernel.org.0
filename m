Return-Path: <linux-wireless+bounces-25899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4AEB0EADE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DF81C81ABE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62104270ED4;
	Wed, 23 Jul 2025 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mh0eT43C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940126A1BB
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253152; cv=none; b=NlFiWAstnLISvhHK/QP0GZNN2k8HwLWfhfqpBl4do8O4Oe2Iyt2ln4B8trKp9cSKfetkpbTF77Vn+kwDutmbApq5Z6y0UWjxind4jUpLns42TQJo3M05hbNJWoN5sIbHqp65n6sdqL2DD78rhxUBPDT2HFqEiogz5HdIAOd6rA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253152; c=relaxed/simple;
	bh=IBpZPTlQNBgGCAa+Q4pAO2l+/gHIqegcWz9NlHWiFL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SVsBA8zqvjv6epTSo1IjxRbjcpGUGbiFphlhzz8WaOT6wk90kG/kLf5DbmRjdJu4y46fW72luB+U2n0rh7gEUJYbBuFqVwrv43FFp9YC+XBQgevlBHJb4+Iym+yxg09NyDV+f3somO9PD/qPTN6jHzm/xDfrJAD9RWa3J0DJSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mh0eT43C; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253151; x=1784789151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IBpZPTlQNBgGCAa+Q4pAO2l+/gHIqegcWz9NlHWiFL8=;
  b=Mh0eT43Cb9q3eC+J5v1AGu2ArOqcdhP5Q8/DlfsEFJ+ycky9OQ/XdOcL
   yBq1k83ZUAudAilPyAKAVWWzhDZLd3quY5Aw2OAwXDfSji3T9gbqgGO11
   A2SyygUF8ICJ7ytD7Z8yZgzJS4MLoK0lVTG0Wk1YxR7XVKOa9j0Rce6AT
   LGrlzVfXaBDR8YcQDgj1PUxMOGETPJcokhbXg9Cup35I2EBi3CKO2oABw
   k7ZR19CcPLfxKWAeNOx7JEJLqbKEVk/kUXyycUAA0RHGCkiJP1lO8cihB
   +39V2wc65CwKjVF6xLGk+nOu9OE3/QMPf6tDXiDrUkhlofH7gmryA92Cu
   w==;
X-CSE-ConnectionGUID: Kx0Z7bqSRou1SE5XDpf+uA==
X-CSE-MsgGUID: sPeshQpAQhu0shJguCvhQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340764"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340764"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:46 -0700
X-CSE-ConnectionGUID: zyhDsNEDRxCeuxAFtDa4fQ==
X-CSE-MsgGUID: KQr0deoqQEmVdS+h4n1pxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918092"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/14] wifi: iwlwifi: remove SC2F firmware support
Date: Wed, 23 Jul 2025 09:45:08 +0300
Message-Id: <20250723094230.bf0ec63e49a9.Iffa0a982f90a179566d85c60ccd3dbfc50e293ef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
References: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
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


