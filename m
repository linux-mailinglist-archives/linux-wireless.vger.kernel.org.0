Return-Path: <linux-wireless+bounces-21873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14BDA97E56
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E20F7AD51E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890282673AA;
	Wed, 23 Apr 2025 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vxx7UGZl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435926462C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387470; cv=none; b=H82Yf4UetaQLBvgYm+H8WDyeXzCMhCZ56mla/6WS+yJuXcVVNOMME4IehJcu4MVk0dRmySDEEahUK4s0Kj5v/0q6P4azEuxgusGYiN+vAzor0KvvrT2kEFdTz1pLv8yf7jUr+SKN42mZiJKb9SXDiUozXcoYsWUaIT8a2iwLfow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387470; c=relaxed/simple;
	bh=Gj2IPnVdT+xs7I66m+zJJJtlcsN6BUGv1DzFs0yhaYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOaPnSfPL1trBw4xs59WMOel/YGlOFxaxqZ5ZVYBwJh2e/9UWEvYDb1n06Uq5oEU2BE04/rdcwcl5LZoX2IPd+SQR798qFx4zCx0iQzCbIuWYoGrtPDX3VWM0D/BRMClNrEjqF5N+Rqe4qZFB0ExKGow+sUL8UOcMgrbyO5aLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vxx7UGZl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387469; x=1776923469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gj2IPnVdT+xs7I66m+zJJJtlcsN6BUGv1DzFs0yhaYo=;
  b=Vxx7UGZlzQUKEwdX+pNFF62E6HwKRm73rYu92ZpMY2jPbfVay7bX0U8y
   YgNCTfJ07eeDR7lCwm4Y5EOUTIiN1crcoOJ3DrHOJgQ3jxNLiBJj5v08U
   88o/fsDsH0/5Dwdpv2IwgmR078l+9SAWyhVSJvVcHb53cjlaeT2FWS6w0
   3BiL1go0elgvsuD+cR0oKyEzpzs0HLA36vzacrwatxdingUWvuvNkWVbI
   5VARufH7MsYk3l3bB94GV7jjtz+mcdGBuSGAEHpaM81AzFj+ZMDhGTm/u
   oSkIFCVdxUHUqdb4a1xmqqd8UgzTSBWNGQw0IMSxk7tUqqZ9UfzZGNt7f
   w==;
X-CSE-ConnectionGUID: JCVvoq04Sp+HXTojFcQY3Q==
X-CSE-MsgGUID: ztwNvjDsS5GpbSrFAW9mlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844645"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844645"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:08 -0700
X-CSE-ConnectionGUID: NG2bkx2zQVOU37enMi96zg==
X-CSE-MsgGUID: WoCSqu96QUKrOEN5Xdl8YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164357"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless 13/17] wifi: iwlwifi: update the PHY_CONTEXT_CMD API
Date: Wed, 23 Apr 2025 08:50:32 +0300
Message-Id: <20250423084826.0e1324ae07b7.I6d8ffda2b00c817d3f784241dd61cfe533e12d93@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
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


