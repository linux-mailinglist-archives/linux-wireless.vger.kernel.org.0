Return-Path: <linux-wireless+bounces-21894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147DA97F0C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312753A041F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEDF266F0A;
	Wed, 23 Apr 2025 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8J+6j8p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B95266EE0
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389035; cv=none; b=NBTR5qynEAvsr84Bq7iuOBl2ZWbIliCffqifzLZ1zzfLvCmRB+WVjd5SV0XgLPGfFdOC/BlRXR9y1FfGBXcWz2FQTSLSs/ecuMskKOp5fr4zoE/x1WvAocjGi758Lfgl0X6+2Ug+QFNs9Rg7OWjJg3VtFjWBCjW77iX229G2Fak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389035; c=relaxed/simple;
	bh=Gj2IPnVdT+xs7I66m+zJJJtlcsN6BUGv1DzFs0yhaYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DF+3T6tyccNItzz4Pf5UW7mT3VKTz1pMoQt1znB2fAdM6oHRLKU9MCJN6/6zg9zjB65j2M0VNDIlbj9qiV7fHT+Fm5Syt09zrgxCSxXc1qjQ0A0WzSOApVlsYH2bHOKVJwLERVwbDcbrg8+2+yFVbqEeomycaiBgkay/cevpmag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8J+6j8p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389032; x=1776925032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gj2IPnVdT+xs7I66m+zJJJtlcsN6BUGv1DzFs0yhaYo=;
  b=U8J+6j8p6SV25rgfY2JlsSwtGTh95vRQGhKED/Owo+nWAlZHjQMfxpRV
   cTo0MhVvbJStegstRTF4IafdkKZOeZKQ479tgXuNl38K+VaeBqmrhh0qL
   ARuLaOVo2/3ZI+s81B39OOENS7fSYrnhaJXTLJfk+XhpVUBGqLmzq52s4
   MhUU+tqGoj+qrRmcGitMCocutpxXJelKsZ+STpCyYjs/NJiW+xu6wf3TH
   TIULT633KKoqWvh48Vmn7S5+dO9NagwZU5yazaY7i2XLWkqtzVpdjU9x3
   4gi8CgE5nQhOunTjUQwYiCxIgZg1sGRBkGqthL1PfM36njKZqUFKBHJ6T
   g==;
X-CSE-ConnectionGUID: pTqPQVezQcedjrK3PR/Efw==
X-CSE-MsgGUID: /n7716sXS9aSbFOGDFjAIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843657"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843657"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:12 -0700
X-CSE-ConnectionGUID: nlvNSh3FQzibCKeNFwJSJQ==
X-CSE-MsgGUID: BmF9tRYCTfK9XMgViyeKog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269092"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 13/15] wifi: iwlwifi: update the PHY_CONTEXT_CMD API
Date: Wed, 23 Apr 2025 09:16:39 +0300
Message-Id: <20250423091408.0e1324ae07b7.I6d8ffda2b00c817d3f784241dd61cfe533e12d93@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

A new field is added, no impact on the current flows.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index 4d8a12799c4d..4594a7c94bd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -146,6 +146,7 @@ struct iwl_phy_context_cmd_v1 {
  * @sbb_ctrl_channel_loc: location of the control channel
  * @puncture_mask: bitmap of punctured subchannels
  * @dsp_cfg_flags: set to 0
+ * @secondary_ctrl_chnl_loc: location of secondary control channel
  * @reserved: reserved to align to 64 bit
  */
 struct iwl_phy_context_cmd {
@@ -164,11 +165,13 @@ struct iwl_phy_context_cmd {
 		};
 	};
 	__le32 dsp_cfg_flags;
-	__le32 reserved;
+	u8 secondary_ctrl_chnl_loc;
+	u8 reserved[3];
 } __packed; /* PHY_CONTEXT_CMD_API_VER_3,
 	     * PHY_CONTEXT_CMD_API_VER_4,
 	     * PHY_CONTEXT_CMD_API_VER_5,
-	     * PHY_CONTEXT_CMD_API_VER_6
+	     * PHY_CONTEXT_CMD_API_VER_6,
+	     * PHY_CONTEXT_CMD_API_S_VER_7
 	     */
 
 #endif /* __iwl_fw_api_phy_ctxt_h__ */
-- 
2.34.1


