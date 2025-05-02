Return-Path: <linux-wireless+bounces-22337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F31AA71A1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732179855B3
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F6B2522A5;
	Fri,  2 May 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VY8ztkTJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806A253B65
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188462; cv=none; b=S+yHRyUN5xpY7CA0eRgcvdT/6YoGAiMHds+nRKwq30gJ21ynC1Dn++a5N0KZarg6H/2Ft1XxCBy1A7C5Jo3FLHZKww2xROnd4X7p313HArreau19LOQuMmSrxyjBUp/Kq5rNanbq0EXi61I6nJVi3blcSXCeH1v2xC4zvXRyJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188462; c=relaxed/simple;
	bh=LFPXWYsRgUT6g1Dmbnfr05VJBMaBrEuD3ddgEGDe7b0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1VjsqpIqwNse8icMQEFeeQA9+ZTAtNxOotKFysvd5NutZmyDH9cUqQv+mSMoiWxNIRoXoW3+uSISYnqbwIFkyo2KYytnmK6ZzCCWrVIJXWJg6qMLuxz3AQntuChItVYe0t6V1f33IfK9tHJmHCGjBS38zjY+hJNfyqnLNm9m90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VY8ztkTJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188461; x=1777724461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LFPXWYsRgUT6g1Dmbnfr05VJBMaBrEuD3ddgEGDe7b0=;
  b=VY8ztkTJCT5p/KZ/M6jf96GvXRR3lXJmuPB154/L21ZbVmmPzL9FAm4s
   TRlmixJL9IX8g5Ac9z3z+6zPTLnIMOpc0GEe3J6y3G//2C078Y+JV3dG7
   taJDo+Mxt3nAQQUpCtRjuq3AOBJwmoTENtjiY0b6sUNFTI/1t87jjSOBT
   ZoU9i4JYwQJlCVcdIs/qd1T2K63dPZhXCrHNxRvWVHapDxaBKRbfagR09
   HVdsK4n20/FipLt4zR7dUx1UIBBn4jC7X9VQUtzENxpHUVgntj9voRLSx
   H4VszDs4pavx7O42tt4YSVQXxkQDTieQO4Cz9+zyk2yem+n6y2fQY2UTw
   w==;
X-CSE-ConnectionGUID: lD6ojiMZR6Kso8/q215anw==
X-CSE-MsgGUID: vde+K5aeRV2/B2vtCFucxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010367"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010367"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:21:00 -0700
X-CSE-ConnectionGUID: GH9eRohsT/eYjv2hoApkjg==
X-CSE-MsgGUID: RyIw6C9kR3SnKFribxZ5+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586137"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 11/15] wifi: iwlwifi: cfg: remove unused config externs
Date: Fri,  2 May 2025 15:20:26 +0300
Message-Id: <20250502151751.64977630101f.I9997a72027d37249620a78091759fa44f9d32c87@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
References: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
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


