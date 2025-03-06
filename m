Return-Path: <linux-wireless+bounces-19955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535DCA55959
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C373B29B4
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4594227605B;
	Thu,  6 Mar 2025 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqNgP29m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83327CB0C
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298727; cv=none; b=iqQEw4NV+2RKiRRsU9MMq219soaOTNMwJKFn6vzbfY6CJD3rzj08SJHTdgr4CW1qLhfvhnpLJJ+qNHhJeyroT9J/0c8DIGrDdswvJHBByT3mFiNinfEYOpqiipY1wxiocE7brW+JTMijAqk3MPjlalkQDK6bCg1/eC7qWSLGWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298727; c=relaxed/simple;
	bh=aECVySNzn2V3AsKAmU1Lsz6ZK6tSpZELmMu9+FYa1SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X4eT64IcPLsEiCDaqMuVWFrLYdAHrSrXFV3UeOflw8MkoH+oJ6ab4A2wjmjRnO2d422Bl3bdl0xoGfNuCugPLBXuqHzZjvUS7kqbpO2Di4RelH8392sITpXFbf8PxODVejceuOBUTSsZ+U9qnzMe8Na62YiZeBDeax1iuv71qMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqNgP29m; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298726; x=1772834726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aECVySNzn2V3AsKAmU1Lsz6ZK6tSpZELmMu9+FYa1SA=;
  b=XqNgP29mBSJjJ3oUVfB0Q+kzj3lHkgQS+udR3rni2nnOF9ua8hS4dyZa
   2NPV3ytPNx8PHA2MUbQStTThT0WXc2oJY7KuPF6CxXUG+7cKgSuCfX1Qu
   EtwQgTZYqSRAD32Mc5m5YdhcHXDUJ7ZTrnGBooLvyVUvJbMHYF7zpRiV1
   Srn3Fc52tBBZJKth322VoHOO6dbWHPYX6QY01WMSqo08bOGH7ROvS1w79
   C5X0uaNGX6p98u5a6HYgxjReE5Pi4CFYx94jiP2KkC9J9tDF2Ea4rbp2K
   BdklJc1/ZAYI/VPHeBoWqISF9kSduyudZSAJ9b7gy6bZKjcYovN5XPtLE
   g==;
X-CSE-ConnectionGUID: cIGEbyRzTBi/7k452g8PuA==
X-CSE-MsgGUID: qrYSEljfQPSoRRSQU+5KNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474283"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474283"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:24 -0800
X-CSE-ConnectionGUID: o1nIIamaS0OSWjOhiXrOSA==
X-CSE-MsgGUID: 7XCmfsC/QSGCHYmAl9Zb9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061912"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 12/15] wifi: iwlwifi: bump minimum API version in BZ/SC to 93
Date: Fri,  7 Mar 2025 00:04:51 +0200
Message-Id: <20250307000213.c8cc5a0eb19a.I942fa8cafc1791b9330ad18e2599fae11d7b3336@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Stop supporting older FWs.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index d7636f817b01..50be8ee8a637 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -13,7 +13,7 @@
 #define IWL_BZ_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
-#define IWL_BZ_UCODE_API_MIN	92
+#define IWL_BZ_UCODE_API_MIN	93
 
 /* NVM versions */
 #define IWL_BZ_NVM_VERSION		0x0a1d
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index a9fc9e8ec431..670031fd60dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -13,7 +13,7 @@
 #define IWL_SC_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
-#define IWL_SC_UCODE_API_MIN	92
+#define IWL_SC_UCODE_API_MIN	93
 
 /* NVM versions */
 #define IWL_SC_NVM_VERSION		0x0a1d
-- 
2.34.1


