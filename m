Return-Path: <linux-wireless+bounces-25059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58665AFDF1F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7D04822F3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB426A0FD;
	Wed,  9 Jul 2025 05:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gu8u+MPD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B4269CE6
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038224; cv=none; b=rsd+xoOun69HSBkodrm5PVhBSamxmTJ7Xz9uEqbV4QqlpXREbMKePzz7DW03MaTPTZb3wCw5q9pql4sHlxhJi2WjWMoAWQ+4qYXIxreZH+TmxahqrOyY5he04KrE0k0fDAaJnXoz+7UttrnHHAnXwQ4Z+b2D6iXgonSUtwlZefE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038224; c=relaxed/simple;
	bh=L+k4Se5bijqIXNA3qnnceqMeYHHL6EWEcThhrJIfopQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afxp4WEwV9KYZDtEyjWQ1FPkyLDf2qb50XrejELHxJ2OhEcNPNSN6sjsPL/zxOM/j4pS9t3nQWDAnaFXptnolZWUSOoiCzxahPd9CmhJ67oic8pPfWlTmqnSptOCnSu7E8oEw4yxEnHB6EXQ+M+ywcEzDk3pee8ctpXSsn/UOlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gu8u+MPD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038223; x=1783574223;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=L+k4Se5bijqIXNA3qnnceqMeYHHL6EWEcThhrJIfopQ=;
  b=gu8u+MPDA/D5vHmb82BIpYLR7o6FpDt3Vnwbs7mJBtATgt9bgvZDb4xq
   m6kJW9BRPWjHxPOsiswLyAC1B7LNVzl6nXuKScrSnR0sexcoNogsjn793
   RuiyK+h66KMI/qlO80B2JB4S55GLBRje1XDgNlGkIlLICVNYukLbsbimv
   ySCTbOBv2YrFUUI//puxn9vlfLUQFQu8Ol2mdBEhUnZ5joQTBtblqmNTC
   +sV5WPOABBuZQGk0RJqgfUwCa/j3023KPDfsLXlosWiYyu/6hV/bxP/jK
   UYqpwsivJVyLNGrnCCzU3a2A2yZ1J8c6NYdOzh9saZkppg5h5w0SwPW3H
   A==;
X-CSE-ConnectionGUID: 1kP3zf9gSPyefaYFElY6VA==
X-CSE-MsgGUID: /a8oYcRYS1OSZ3AbpxmDTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091171"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091171"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:02 -0700
X-CSE-ConnectionGUID: 9bPU01exSwGLdFbkFrMxnA==
X-CSE-MsgGUID: xStnZt6mQT6jyAYr4cAKDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327867"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next v3 05/15] wifi: iwlwifi: bump FW API to 102 for BZ/SC/DR
Date: Wed,  9 Jul 2025 08:16:24 +0300
Message-Id: <20250709081300.da98a7b6be42.I77150bbf55eb160dbe0ef75c3e28afc053f27ec3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
References: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting FW API version 102 on those devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index b5ad6d635fcb..c6cd892bff69 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	99
+#define IWL_BZ_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	94
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 95aa27c35357..807f4e29d55a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_DR_UCODE_API_MAX	99
+#define IWL_DR_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	98
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 12c2adb4b5c4..97e503a25eae 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	99
+#define IWL_SC_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	98
-- 
2.34.1


