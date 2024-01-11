Return-Path: <linux-wireless+bounces-1715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B784982AF12
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 14:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF611C236B2
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1515E9D;
	Thu, 11 Jan 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbA3qGqX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12F15EBA;
	Thu, 11 Jan 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704978052; x=1736514052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jcUhweAoBDlKZayEk0EIABknwJLV84Zn7qyo6fu9fbo=;
  b=KbA3qGqX7JBvOdf5lU2fT/UaAXF9HfhnHEubhERsKSsrk257upK01CUL
   ocmQuEa4V08ljhCC1G/OsVfRVsAcht8e6nEJDaauUsEM4j/qUJP8Jpqlp
   kqp0XOHJgTKstoNJCNN8mXbo3HpihIFKwa+dQYtgsA66PLdOT/RVUnLmH
   Frv6QkuYbDP16mqegLlY5ScYOZDIT9JbONfO1xFtYCsNIY+TRt2KxtcgW
   b5N0qr0M40fS3JKdg2rjwHqoXYHwCAZ78lL0slRSKKSGpa9beAQ2rBJPj
   5h0RrVOV4f46tFqQ1SXC4+7CPBJS/CFv6mDGzTXM6OT7NIDWnm4CHMCnn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="6195678"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="6195678"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 05:00:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="24324395"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 05:00:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: fix a memory corruption
Date: Thu, 11 Jan 2024 15:00:30 +0200
Message-Id: <20240111145954.2d2b8b870194.I14ed76505a5cf87304e0c9cc05cc0ae85ed3bf91@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

iwl_fw_ini_trigger_tlv::data is a pointer to a __le32, which means that
if we copy to iwl_fw_ini_trigger_tlv::data + offset while offset is in
bytes, we'll write past the buffer.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218233
Fixes: cf29c5b66b9f ("iwlwifi: dbg_ini: implement time point handling")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index b658cf228fbe..9160d81a871e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/firmware.h>
 #include "iwl-drv.h"
@@ -1096,7 +1096,7 @@ static int iwl_dbg_tlv_override_trig_node(struct iwl_fw_runtime *fwrt,
 		node_trig = (void *)node_tlv->data;
 	}
 
-	memcpy(node_trig->data + offset, trig->data, trig_data_len);
+	memcpy((u8 *)node_trig->data + offset, trig->data, trig_data_len);
 	node_tlv->length = cpu_to_le32(size);
 
 	if (policy & IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG) {
-- 
2.34.1


