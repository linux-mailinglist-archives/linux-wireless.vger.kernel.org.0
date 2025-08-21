Return-Path: <linux-wireless+bounces-26504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504ACB2F8E5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BC13B1E64
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61879322DD3;
	Thu, 21 Aug 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DaXMH76i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C6322C73
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780313; cv=none; b=qxa8FETbhtTdu41Jw+QBkU8k+z5u1IdOm3wRYxomHh6l4O37d8XnX/5VeCh/wTBltm3X5Xm8BU1n0jZfL8onaDYDauyz3IPI0zMrp0Kj9zEvUKq3zH9AdpTy+946NnW/SVNWWgAUK1mc4+CyZqUybR+H3Zkn4kwU59OZNUNQD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780313; c=relaxed/simple;
	bh=0owfmp0V7qOMmeR8ZqOqWtJAbo8RK0h+IGfwwwXbIhw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aflesfkMx5qeTZIyA80bFylnCm9oJ2VfaH+GIprebUYxJ585POxUm3HGaOZQhZWNoyD5v8JG/ml6hsr9RjlFVjJ7DC9QIfQt7hYuFXsO58FU7ZREPKrM+MxaR1qNCafeDfSEQjhWXVqsenRrCIu2QGgOXJuH1kRZ8Crk6Bwv4zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DaXMH76i; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780312; x=1787316312;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0owfmp0V7qOMmeR8ZqOqWtJAbo8RK0h+IGfwwwXbIhw=;
  b=DaXMH76iRODQ0NrVLYdgRGXpgYLlOOZ2cQB1gD5CsaNfWfZovuD37MaB
   NbGNrRMwtqZCtn2f+4TnRdJkP+j9zyVnkJFCbGITdt+0aCa11naPoeF7P
   r/P6VhZJ1dO4tRLl9/sMOq5S3Ma8gTOMdweJoDDZWuuOqkwFiXOKGmToT
   WG78ypXByN/GqV6JbygYL8UlLQNRSxBvsJeGGQ7+b21CyUR8VVgsm8ZpO
   uwYBf21CI2gVxczSFLHXKSw13b63GlCKoLLBR4x+PDMl/TUVCuU0byGrl
   yVIZvMA9a9dTwH2otmCFlSYMYkBK74hkOcRD4+D+UF7M6gpe0nra5QKR9
   Q==;
X-CSE-ConnectionGUID: 5wBFlp90Quuh9prsREymSg==
X-CSE-MsgGUID: B3CKT3ivRAymdq8S9ZypAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895753"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895753"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:12 -0700
X-CSE-ConnectionGUID: U3gQZs7GRfu4ShHMhrzfUw==
X-CSE-MsgGUID: QytE67/8RJqX9cV44Dbxmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622196"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: bump MIN API in HR/GF/BZ/SC/DR
Date: Thu, 21 Aug 2025 15:44:27 +0300
Message-Id: <20250821124433.2234183-3-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
References: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
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


