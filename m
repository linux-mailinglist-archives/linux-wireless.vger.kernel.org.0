Return-Path: <linux-wireless+bounces-3746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC363859853
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D48AB212CA
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612A56F06C;
	Sun, 18 Feb 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Svfg2r1w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE829CF8
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278734; cv=none; b=Z88ZLlCjnfvPoMNGywZhfHf66fEcGy9Kyo/3De2HOpM7bly4C1mvbP+hj18ZGxFtxyjVjUbC4uGrE2lz2Q7KQK5gqGe7VkRwYUWwC5lpL6E9dH69xf+OIeUKNBhnTyf+94wToYGn9IHR5gFI1cl5jaZX3vxbXFG4LfZJNRPSv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278734; c=relaxed/simple;
	bh=qdg4yA3Ky3NutMLm1rG0BEaKDzI7hqzo2I/eE2lhZTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szk6yVCkk5GMzzPzjJoVmOS/6rbWljw6xoCNsXxX1c5OJxt7QBuYjYEogdijlFos5eNElwD37XmSpVGMPU7VFs+T3bfAfWpuvINyR68s/2r2w2I6Hgs+6Meb9SNdMQInzqPAYvX+HwzXO175ktMfYRh6BBjgZNUdrD0EG33cufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Svfg2r1w; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278732; x=1739814732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qdg4yA3Ky3NutMLm1rG0BEaKDzI7hqzo2I/eE2lhZTI=;
  b=Svfg2r1wGqQLVYK5dRmRlkm87pdy8NdGEdIUc1I+W8I/JKtIc8QShXDv
   uzWPPQFhZr375kmeqtbzxnHGyVEpdbQVuORI+0HESNfYZ63rI83XgWsL+
   I7cJ8h0zPxgfnRodt3qddiPUmpJsL/6uHXv7egbD86nNFDiUnUVhjpvDV
   KoOCE0asGqKQ8gt9oJ7irk3KorNb/r2CllbucSSnlE6M/rZf+hBwOcRZg
   YBjgAGtMKGwh8s0KTxZ8ka02li+t90IBlYIE1PIsoHHUeDzSguQfNBJpW
   gdiLjCMDP49ijJSr4HPtL2O7yjUnxcJSTx1XOaVwlbXYmIxqokzyRL6nU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464977"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464977"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459428"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 04/11] wifi: iwlwifi: bump FW API to 90 for BZ/SC devices
Date: Sun, 18 Feb 2024 19:51:45 +0200
Message-Id: <20240218194912.21cf0b641f12.I2f9196191f1ea78e96e92f9db8ecb3cc9bbfd9b3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 90 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 14c5cc265fe3..18b1f2cf08cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	89
+#define IWL_BZ_UCODE_API_MAX	90
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	80
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index dbbcb2d0968c..9b79279fd76c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	89
+#define IWL_SC_UCODE_API_MAX	90
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	82
-- 
2.34.1


