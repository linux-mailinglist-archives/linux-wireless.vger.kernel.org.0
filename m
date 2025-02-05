Return-Path: <linux-wireless+bounces-18535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0973A28B07
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34C01880831
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D6FC1D;
	Wed,  5 Feb 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpTVaRrH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39FC134D4
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760196; cv=none; b=mxIxTrNlrrZQyaF/axpGrGxNofHUWTIRyXuEHxY3nUE3iWY6+wssXjaX2Xs4FUU1QESV2xrq96bwRWIKvMZXSwGfRgR20PERnu2yxo5apE/NNgDabRebELz/Q3BnpzinsJiCMgjMfbevddIh/5bVbvNDiBoaBkUOcF5h1USfHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760196; c=relaxed/simple;
	bh=xjohJRyp+/gfUtXbONDolcVTysM1jAQtaIPxY6g65Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CC0pTnWerxr+YYc+8qsCqrmcwAWE3+svbNSmm1R09HJ0dawq7+z9NsYczuoXyylaXLaLDZJJRZ8hBUkMDqnX7Urw/NifIJw4HzYveoJvpbr1K/AxYHL3H02iQQtjU3kTztrtlLWCLXqQmAwb1C+1+X9BZbGeCIMtytgD/Xx+wvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpTVaRrH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760195; x=1770296195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xjohJRyp+/gfUtXbONDolcVTysM1jAQtaIPxY6g65Bw=;
  b=MpTVaRrHH3pkzwF8Vgod9hGBG6HCjRTYOlf84//jHo+T0c4xX3/PAFDw
   CpRrskOPHv6XRHOf6SF21GoD1xEQZg+BiCssxdKHBet1bXO/zJT1SNWkJ
   U8r+raxS5XItSpKXMaiyeJ8Sjdk3IJdqhlJ7T4WbEbPH8xptiJDPf5fRC
   k3kMP0Slp5doXf2CcT0ZUmDPQ/JWLsxoZmeFk45ug3JBwI1gcNRVdm/GO
   rA364XL9MMicPhp54wrCrKlxIzz5mrJv6zRld4+PEmTWFBw387+dtVZ6X
   Xil7q83KvW5XgT1dVTpH+ylybL+Pr2jeksMfb+xW5/jSuGc6f/vgm6hh8
   g==;
X-CSE-ConnectionGUID: lrJT96ylQsebK4cxaQE+3w==
X-CSE-MsgGUID: L5l9+mQ3QD+KK+r3OqTCdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159223"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159223"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:34 -0800
X-CSE-ConnectionGUID: bX7Azt8wTxSPacH7WMkOQQ==
X-CSE-MsgGUID: rWz6+wKoSfK3BL2P0GC7kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745501"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/19] wifi: iwlwifi: use correct IMR dump variable
Date: Wed,  5 Feb 2025 14:55:46 +0200
Message-Id: <20250205145347.3313b18667d1.Iaa9ab66b1d397912a573525e060d39ea01b29d19@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We shouldn't dump the reg_data here which dumps the last
entry again, it should use the imr_reg_data.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 10bde19e9dca..6819c615fef6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -2661,7 +2661,7 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 	}
 	/* collect DRAM_IMR region in the last */
 	if (imr_reg_data.reg_tlv)
-		size += iwl_dump_ini_mem(fwrt, list, &reg_data,
+		size += iwl_dump_ini_mem(fwrt, list, &imr_reg_data,
 					 &iwl_dump_ini_region_ops[IWL_FW_INI_REGION_DRAM_IMR]);
 
 	if (size) {
-- 
2.34.1


