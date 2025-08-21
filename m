Return-Path: <linux-wireless+bounces-26536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A05BB3015E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F047B2B22
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5D34166D;
	Thu, 21 Aug 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7m9PAFh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC34343219
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798484; cv=none; b=ldHIq+ACVKhyV/yaXU9X6rnVtRrJub79Baff0mD+eGcQn0kFawmqAbCIqWpImV0b+y/0WoWpR037kIGO6wB0aeZlN6o+tzhnnCMganErL6DiAueewP+EFPgbLnsxmYPJR22RHNC0ZNZWASWSmIAIW4bCxMJqzeoVPyQ1lsR/mdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798484; c=relaxed/simple;
	bh=0owfmp0V7qOMmeR8ZqOqWtJAbo8RK0h+IGfwwwXbIhw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Im3Jm3d1ve4vqUfuQ9NVxWzIGE70kis/ROY/Ba5zlj/9Mt8lIevD/TWkcEIxGaqRk2lkZnaTH7na14a25Pd1x6TO2/0ZucAMfslzMhctnYVkh92wWo/ASmDQ7XhIjtwgUFrEP455KCyRtf19SvJ0xyXQk2ks6zX43B3qqhiLdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7m9PAFh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798483; x=1787334483;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0owfmp0V7qOMmeR8ZqOqWtJAbo8RK0h+IGfwwwXbIhw=;
  b=V7m9PAFh0AtyKQ7xeBrmVsBDR5st8XlSva6SkQnRjYXs8dufzXlAy9qI
   J6GuNSJ0mI9s5IHX4J9uKwEnuwQ4SyKQvjbZAVQA9HTPBcWki3eE9YbaF
   An9gAL+ziFAZHAaXH/hsB1W/XRvk+IiUzMNA9vCv9KbTWuUmzGPcqmYK2
   mqkNwyERO1lcey1aqWMFxSRuV2zJKV8wSrXuhOvxgVl9C36A6yiBfQGWa
   iI37vurVciHxyQ9Lbsgn+L7aaH5MOXCqFUr9R4pQitTzPqmY8gmMZrtMk
   u39fAYmfZJ1NfkSF5iQZXdfHbOvSadQHj9XBHh2TsOAF6/QaeTUWppX0p
   Q==;
X-CSE-ConnectionGUID: wI+sbHmxRdSKns7qggg6iA==
X-CSE-MsgGUID: EPKwlDqjT0u1P/DXgF1HQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806076"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806076"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:03 -0700
X-CSE-ConnectionGUID: 9A6v+ML2SzKbkPlKXzpPiQ==
X-CSE-MsgGUID: CoO6aHJaSK2pvB/lnBmqdA==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 09/15] wifi: iwlwifi: bump MIN API in HR/GF/BZ/SC/DR
Date: Thu, 21 Aug 2025 20:47:20 +0300
Message-Id: <20250821174726.2425334-3-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
References: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Stop supporting API 98. Since API 99 will not be released, bump to 100.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 9f543946b285..0acf52064132 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -13,7 +13,7 @@
 #define IWL_BZ_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
-#define IWL_BZ_UCODE_API_MIN	98
+#define IWL_BZ_UCODE_API_MIN	100
 
 /* Memory offsets and lengths */
 #define IWL_BZ_SMEM_OFFSET		0x400000
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 807f4e29d55a..3c8fa8aa78ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -12,7 +12,7 @@
 #define IWL_DR_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
-#define IWL_DR_UCODE_API_MIN	98
+#define IWL_DR_UCODE_API_MIN	100
 
 /* Memory offsets and lengths */
 #define IWL_DR_SMEM_OFFSET		0x400000
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
index 7ff5170faaa9..ff2cc90f1896 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
@@ -9,7 +9,7 @@
 #define IWL_GF_UCODE_API_MAX	100
 
 /* Lowest firmware API version supported */
-#define IWL_GF_UCODE_API_MIN	98
+#define IWL_GF_UCODE_API_MIN	100
 
 #define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0"
 #define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0"
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
index 9f408d276ce9..6cf187d92dbf 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
@@ -9,7 +9,7 @@
 #define IWL_HR_UCODE_API_MAX	100
 
 /* Lowest firmware API version supported */
-#define IWL_HR_UCODE_API_MIN	98
+#define IWL_HR_UCODE_API_MIN	100
 
 #define IWL_QU_B_HR_B_FW_PRE		"iwlwifi-Qu-b0-hr-b0"
 #define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0"
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 6d4a3bce49b9..ee1dc27362c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -13,7 +13,7 @@
 #define IWL_SC_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
-#define IWL_SC_UCODE_API_MIN	98
+#define IWL_SC_UCODE_API_MIN	100
 
 /* NVM versions */
 #define IWL_SC_NVM_VERSION		0x0a1d
-- 
2.34.1


