Return-Path: <linux-wireless+bounces-16857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D5F9FDC39
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8AD7A123F
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D960192B95;
	Sat, 28 Dec 2024 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyqqW+sy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25397199396
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418100; cv=none; b=Zc+QGVObYGidxJkCRglj4Yr9vv7kxlk3tf4lmv1cYF6aDd4x6w1MgcB+9NoFJOmIdUdZ6QuGRJns0gEVNvOlV/avbez+AxtQC6gLjl5qzRH5aqMM4EIAB/Sb49ey5sCqRk1SbW2Jg3m670bAc0CvpDlF20vDN0CJC4ZC9YGhxpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418100; c=relaxed/simple;
	bh=N+l+zjwb6uQa+0sj3qLQm9oqSgTyeThwEKDaztzxBOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ek8Z3ul8pSVVe3LGYEqLrmQew/K72tI3kRtWCEufJHeiGlWZwSd/LZ+VsBEezp4bgHKU1Hx5D2R23VeDwJitbWKpyzvkW598NRhFk/CFfKkgFrgpPpNUjK/t4PWT0/qwr+Vob3SYdWkRtet7z9BBsUI2aT1qRO0FzrlYfV2OPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyqqW+sy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418096; x=1766954096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N+l+zjwb6uQa+0sj3qLQm9oqSgTyeThwEKDaztzxBOM=;
  b=PyqqW+syL1v0gtfeu19oy3V+e0mxaZQTO4qWV2z3y37io2fLfEsViVQN
   xgZ0WpKfkKawzAQgl4NvTE/JNkOEt/lkk/5NN3M+vBE1CrUiOCrkPgIQl
   fjkvMbGZY/EN/6s69YUe4zoXJYsfmrCXCmJ9xgQt9/Go1bmOwSr2l1MQw
   kaI4Ny7T7tOVEm7xygMsJW8iICAwo+Xp+RgK7mtUsvMdVky4aV8XZQ4aj
   7YCMcwGSiCvmg2vK27LxGR6PfnWWn/G8s9f1y59Qx2P8PrOK+krtQGUWY
   w9936hlsl9Vck+hGmL7v1sTTdp45+ltxv90LBbxwDe9apqvBzgDNb5Ghh
   A==;
X-CSE-ConnectionGUID: wl7IyIbMRL2Svxm4D1bkHQ==
X-CSE-MsgGUID: 09kuHUxCQI6Dyi5yehsEAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479783"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479783"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:56 -0800
X-CSE-ConnectionGUID: OrBz2UwFSFKuHoKyMYCEeA==
X-CSE-MsgGUID: g157llQ4RfeZUSKqIazqTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488428"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 15/15] wifi: iwlwifi: bump FW API to 96 for BZ/SC devices
Date: Sat, 28 Dec 2024 22:34:19 +0200
Message-Id: <20241228223206.4028b66f4563.I5d5caf4bffeabcab72a69c2b31445e7bee4a94b6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 96 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index af6d3c85eb6e..33f5e110acb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	95
+#define IWL_BZ_UCODE_API_MAX	96
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	92
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 4b92cd274765..0422d7771b28 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	95
+#define IWL_SC_UCODE_API_MAX	96
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	92
-- 
2.34.1


