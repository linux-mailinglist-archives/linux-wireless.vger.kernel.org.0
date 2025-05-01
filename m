Return-Path: <linux-wireless+bounces-22303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED4AA5CE0
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B28D1BC2015
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E622D4F1;
	Thu,  1 May 2025 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReBHM44c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9942AEE1
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093610; cv=none; b=PTndyCQOdOqTUH4otFQrZDHvtobia7EmjPciob8xttjKCCgdr0ppqiF5IH0gWoW793jvwBKPxmysGrY2Fz9ndYZmqMRIe7VSC/6YVIbaUT7T7rouM+SLqxDpkgYLc5xyB95hF87lrTskItUPbZ5OYT3Qia7DNqzOl/dJIKtXML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093610; c=relaxed/simple;
	bh=LFPXWYsRgUT6g1Dmbnfr05VJBMaBrEuD3ddgEGDe7b0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t3UA4eypCqWe5V19yAi6rO8EmQ3jqCVD/bFfcinVt2x+Cgyx/86xEYS+JQtiLyT0f+b6ZDWiPGIDyNU7B8IvhBSJqapXqklnv9QnspCBOO1vQP0/E9qbJqzyudkZSYr+xXJVEHLtH1X3Fv8DYL1DR1akzwtL+Z5SyqXKL4Je1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ReBHM44c; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093609; x=1777629609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LFPXWYsRgUT6g1Dmbnfr05VJBMaBrEuD3ddgEGDe7b0=;
  b=ReBHM44c8EPtrQBD6b6DckMPmF3VfMFQ5l4BCvq5+8xnObnD8hkKIq0v
   d9CLqzBkmylErrC/N2ty4nfQQ70FTIxlyOlUt/mWi1pIEuBSZSsFYJxnN
   x0WJzu5m1eZlmtHih6wweGOK2/o74VnR95sp0arcjeaobpCdL6+Eflhsc
   Zwa1iOsC0DXBc+kIJvY919K+QbE3WW2frv4/mzPngrNATg8uip8vUr1wr
   +L5Ki0ZTwAZICh46/BXFPkoEpqdPnqlFkU490QnyAFzTVsnQV9hbmuzJ0
   DN6qt5D7hQMMH7+qRZNEFJE9c2sPobkkrBdNf2CvWZpkPbrOoZ/D7V42R
   Q==;
X-CSE-ConnectionGUID: d34qTNOnRP2E0Jn+cLIk/Q==
X-CSE-MsgGUID: eoBg4gbgRh6qFx8A0yq3yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962843"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962843"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:09 -0700
X-CSE-ConnectionGUID: mfD+g8uJQnSksrceM2FDhQ==
X-CSE-MsgGUID: jGfPC9uzRWKRAuTHIXkU3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135318006"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: cfg: remove unused config externs
Date: Thu,  1 May 2025 12:59:33 +0300
Message-Id: <20250501125731.3458d31df3ad.I9997a72027d37249620a78091759fa44f9d32c87@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
References: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are two killer configs that no longer exist,
remove the externs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index a551967d1724..b9f6f122e752 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -626,8 +626,6 @@ extern const struct iwl_cfg iwl_qu_hr1;
 extern const struct iwl_cfg iwl_qu_hr;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
-extern const struct iwl_cfg killer1650x_2ax_cfg;
-extern const struct iwl_cfg killer1650w_2ax_cfg;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long;
-- 
2.34.1


