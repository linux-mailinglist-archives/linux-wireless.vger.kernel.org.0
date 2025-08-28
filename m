Return-Path: <linux-wireless+bounces-26734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFB7B396DC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB629810F1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6A2E2295;
	Thu, 28 Aug 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRnOeKzU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18A2E040F
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369606; cv=none; b=fVorE612LlEE9IUayMm16y7eNbVkltBqe1GE8nYGsjDrVnUFuqqq0es2Jv17xI6dYI34ahOL0eWfeAfGaLqOCec4FWIdOF9Ug5eQkWKGQlXVTWvzrl4pqPTBflgwD85jgi1ql4QHEJnF9/X9mSWtmb/CrAImmNZxy8j5iRVrliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369606; c=relaxed/simple;
	bh=mdOeC9yZqbiqEI5s7m9OtwQ8qkEWO1A+kFFbW1Yr7tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YiEHOkONSbV5mY/ixLFR4KEsSn6IzRk0l5a71V+MV99GpcJx15XNY7M8DUv3Z6JpXMGZ47ihyIjER2b38VsBq1vfQnR69b1MOguG1EO3p/iaxfI8BWbZJUsY2bqTC8dLxlM7iFkmE3LumO5/XyyXyAjaEk1d9q6nhiIvjikhKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRnOeKzU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369605; x=1787905605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdOeC9yZqbiqEI5s7m9OtwQ8qkEWO1A+kFFbW1Yr7tA=;
  b=eRnOeKzUbLVDg0j5chaPoRyJdvabjNdCv0fhL2GFD1kxlOcf6kb/mVW3
   VgYRPk3RtZ7vl1o7T98dBBx+JZRtQ555EUKQtcijZSfSrbjhqntAQ44Sp
   rxVNlRxW1pZvy5C0Aj/kcx/1b4W5eYjvBMH1QoFtQdVzAatj3NZkD7Hkz
   7DesGggNtbOzxibPJHiC7ctYFLG2t48b0wk6o1DZlpTFeLbgkMbjlIzJW
   atyU+ugsXmerCdXLWswO9RSccCPDANzELy7tHfUr4G5e2MwhHUdEiFJ/2
   xFRbfhq2tfKnYd3KZ5haRAf/BJVd7KXIprY0nHs7NN2770j5l/Wt2iwpq
   Q==;
X-CSE-ConnectionGUID: 3pfV2W8pSxSTEfvqR/TPRA==
X-CSE-MsgGUID: AO3Zx+iqRACP9T00vivaBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003328"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003328"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:35 -0700
X-CSE-ConnectionGUID: U5Bv69jIRyCiIkGblF90rw==
X-CSE-MsgGUID: M4xCXXlVSvWU4aTCvX63wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224487"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: remove .pnvm files from module info
Date: Thu, 28 Aug 2025 11:25:49 +0300
Message-Id: <20250828111032.74f7fdba4ff6.Ia5e2123471df1fdc3688d8687a8e437388412206@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

For BZ/GF and SC/GF, we no longer have a .pnvm file, don't declare
those

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
index ff2cc90f1896..c16cda087a7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
@@ -23,6 +23,18 @@
 #define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0"
 #define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0"
 
+#define IWL_BZ_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
+
+#define IWL_BZ_A_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
+
+#define IWL_SC_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_SC_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
+
+#define IWL_SC_A_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_SC_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
+
 /* NVM versions */
 #define IWL_GF_NVM_VERSION		0x0a1d
 
@@ -67,7 +79,7 @@ IWL_FW_AND_PNVM(IWL_MA_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_MA_B_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_MA_A_GF4_A_FW_PRE, IWL_GF_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_MA_B_GF4_A_FW_PRE, IWL_GF_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_BZ_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_BZ_A_GF4_A_FW_PRE, IWL_GF_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_SC_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_SC_A_GF4_A_FW_PRE, IWL_GF_UCODE_API_MAX);
+MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_GF_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_GF_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_GF_A_MODULE_FIRMWARE(IWL_GF_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_GF4_A_MODULE_FIRMWARE(IWL_GF_UCODE_API_MAX));
-- 
2.34.1


