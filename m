Return-Path: <linux-wireless+bounces-22687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD0AACE3C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B021BC4964
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B49218E96;
	Tue,  6 May 2025 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emX5qzPM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B320B803
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560495; cv=none; b=KeSD3F48qttHWddBn9wRwKB+971igEN/oWwqaDLk3BCZ3JxIlX/wamCGn3/kdqe3zy6OJoqLP3soV0Ofwda0y7ziOkUQXUpzvVc4M+lVNM9EodCcQMtlGzJweeR1/h6NqK+PUgmgm0lhVl96NusXBafee7gKMJoY2Wc62QUVJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560495; c=relaxed/simple;
	bh=jaSjnYMO7jrklwlUzrufJhJb24CKh3TzAFcM+TwBrks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7m3eeKgGoptz3TYCwH5GfJDEBiK2GwIkDxprbo70+zqrhks964U7H8xvu6bTKxF1++P1JhvorSY2BVrpzbIldV38banDxWWnxQXY+OhO3DuKFuyqWID6L5lyX3IbpssXoh0cGgyEV7Ld0h5RRWXE+xwiM98ED0o3Hfnvu6ZSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emX5qzPM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560494; x=1778096494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jaSjnYMO7jrklwlUzrufJhJb24CKh3TzAFcM+TwBrks=;
  b=emX5qzPM1pIwLrjJiUNCW/yK25yuYj09B5RBlI104hyZYwIvRMHpswhw
   BV06nCKMgC83mJUa81SJ+1rDUlaFRN61x6KueQK+uQo0LZKxkAE+3/vJO
   Ze3mo8AY2gcPUeh5K7XQtF7NkKVCVm7XI/UiZurlrhAOzFOwIxeQiUCSG
   wyJEI1Z1+xt4OcK71NRM6WdczI/yBDueRBxIJ+bRsqS0DW+j0EiTdMXud
   jbWdhqYNi4FVqCx9/oA6X0mNhMCWw0rAF/MJRVoT7Xl12o3ZxxdgRnUXd
   j6wYJqKQUC1Y5R9OdbkfWVl+/rCPH7osao00GUHx3LTgZ23AqoREMGkgF
   Q==;
X-CSE-ConnectionGUID: u42rU5TCQ2iof5pENWod+w==
X-CSE-MsgGUID: SuME9wJ8QPOyazTv9YA3JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961662"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961662"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:34 -0700
X-CSE-ConnectionGUID: rO2G/peKQTqeLsnX4FC5Mg==
X-CSE-MsgGUID: yR/2wX9wThWycey57+rSLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465497"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: cfg: remove 6 GHz from ht40_bands
Date: Tue,  6 May 2025 22:40:59 +0300
Message-Id: <20250506194102.3407967-13-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since there's no HT on 6 GHz, only HE, the HT capabilities
are never initialized, and so the ht40_bands value is never
checked for the 6 GHz band. Remove the misleading value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250506223834.e5d8d276ae13.I0c46dcf796364c4192b17b1bbf248df039d3b644@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 3 +--
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 21d5a02933a6..b62c3d1e9b3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -64,8 +64,7 @@ static const struct iwl_base_params iwl_22000_base_params = {
 const struct iwl_ht_params iwl_22000_ht_params = {
 	.stbc = true,
 	.ldpc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ) |
-		      BIT(NL80211_BAND_6GHZ),
+	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
 };
 
 #define IWL_DEVICE_22000_COMMON						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index f3144ad251f3..4840bb25448b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -58,8 +58,7 @@ static const struct iwl_base_params iwl_bz_base_params = {
 const struct iwl_ht_params iwl_bz_ht_params = {
 	.stbc = true,
 	.ldpc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ) |
-		      BIT(NL80211_BAND_6GHZ),
+	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
 };
 
 #define IWL_DEVICE_BZ_COMMON						\
-- 
2.34.1


