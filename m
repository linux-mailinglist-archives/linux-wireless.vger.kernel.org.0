Return-Path: <linux-wireless+bounces-22396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7347AA85F9
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F0178ABF
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCE81AAE28;
	Sun,  4 May 2025 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWLFieHW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253E18FC84
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354429; cv=none; b=mKB4e81u9mPwtcOVE8PECwo9iQbtie69V/evFDAkdwLxUEquLmi0xcMH6EhBU5ZrqVYtVKJ4p74hX/h0yObMaVFoTyApqv0lxnrtQZNYBhDRrIWK9uYCpEfk15YcS7SI+FXMF1T+pnATMJ6rI9TGh12s+NYcfz4nLUXKT/dVngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354429; c=relaxed/simple;
	bh=asS9d46KahPTY8eQ9UxVN2+bGHEX3hnKeHyOAaqRZa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTzaWydn089oymh3OoadPHcwLGz1quMfVfCt8HnnUQ0lBG0WDzHMF+RT4dwdKLGJIPG8+nwa5x+jWacpSu6NOselaWNGb34jB+FYT3u/bT/Cy3jX/I2G5SOag+eVEjLrLZJGH9VpEVQQqPobdJg+aXd+A1fzaUjdP/g42Jw7h4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWLFieHW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354427; x=1777890427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=asS9d46KahPTY8eQ9UxVN2+bGHEX3hnKeHyOAaqRZa8=;
  b=DWLFieHW47eIbuRdWf6g/jbE9PRCm83I9Tf0cVi2dI+MtfG0EigYQkdT
   jOa/OGC3zFSazuCIVF0lsyLu9EpwBn2jcZOSMt3vkka91YA+hsbqzIGM2
   Gs7Hf0jgzFpDDRADQJonirZm50ZXd/ZhMzBBs6a1xPwRgZxE2tl/jE215
   H5lfyFhq2eOh2LyamDR36i7uX21iJEOSBAFdfc8TYB3NcVryx67oorLZV
   zewj8eFyQdOU0NcXT56YlPSMGHOv1jgm2iCA6xdIGA7cdg/v82zo1VVD0
   RrAsiWJZt9pw/eyjfx5UMI6lDJPSg5nH0WKg0C5HrPVg2fy3ghm8VW6y2
   A==;
X-CSE-ConnectionGUID: /wLf5qbQQYGbkPGWQMjOZA==
X-CSE-MsgGUID: tb0tJW9xSpqekanDgIgrIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511504"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511504"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:07 -0700
X-CSE-ConnectionGUID: gfoK31OxQfaew6Kf1kfq0g==
X-CSE-MsgGUID: 0dWfgZoBQKyzZPkf2+jFZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778905"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: bump FW API to 99 for BZ/SC/DR devices
Date: Sun,  4 May 2025 13:26:26 +0300
Message-Id: <20250504132447.677db25ce2c7.Ie4a7a00ff3562bfed1e8ac1fb42c1382cd24a486@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 99 for those devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index cc405a4b21a9..f3144ad251f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	98
+#define IWL_BZ_UCODE_API_MAX	99
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	93
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 7211c6376b99..c4f637627901 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_DR_UCODE_API_MAX	98
+#define IWL_DR_UCODE_API_MAX	99
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	96
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 033cbf4d1a0d..a0b5c4b8fc57 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	98
+#define IWL_SC_UCODE_API_MAX	99
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	98
-- 
2.34.1


