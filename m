Return-Path: <linux-wireless+bounces-7212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D08BC811
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF37281A37
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDA31420BB;
	Mon,  6 May 2024 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgnZgFqa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5D1411D2
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979113; cv=none; b=iPdKQ+b/ytfMuIK5Kc2c3uQ0e8/NsHbMa/PIxf4CWsSk1ffHKIcbCRCRO3Zw89ZNs9wR1fDhJ8LY476v31QJaXgluHCdq5CR81oY1iK2y5QtGQNUljXgBu9rZg3hhg5aHMzH1Hj6zls8dBeQGiSVtz5O2yjFW7hASlwr2rLbNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979113; c=relaxed/simple;
	bh=lDyyMbX2KSSAd9eXyMw8vJtuphu3BM/G1JlzRaTQe6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHmeD5mHbM0+pk/BxTt0xwHMUFXaC+/EdZJy5E70vgDXIXWHcIJmUNuB+IXtrvhF5kNdJvxo5VcK/EodZ1HO28RF8rDlwOo9dHeL9CjhlAdluG1oyPUeLJ+CTEgmtBnCaAjWqFvHF3d3SE0Y+X4Ca85k3pzWH3tHwjmynt+B/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgnZgFqa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979112; x=1746515112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lDyyMbX2KSSAd9eXyMw8vJtuphu3BM/G1JlzRaTQe6w=;
  b=WgnZgFqaxY7nj6G0x9nhKeM6O1V8ZqpdCXng9c3mfaVFCfI2KgvZ3V7Y
   AXDi+UuHfCiIq8/BFmMV9fGa6ac2PJ2Kf/RVMTh+R/yQdJqmo3P5JemJb
   Cpa5/R/Fo4R5T9IJcGUQkkzqKzKpRjZrSZiAG3A95VCls2HVFDNNuh0R/
   6tDykVafNb4h+0eweOt31afBqp6OpiRX197WkIZSq6/CQdWL+BE6MoqaH
   5pelgPJM9CDiure9eHidRFpPFJyj/vB5Ieh4WSN8v7jqc+VlTXZqc5iqm
   izGXwrRIt+nOXa/GXuQhu3j8+gyzD3p1sV1DDTFrm3WZdfM7oy8vAR+VR
   w==;
X-CSE-ConnectionGUID: HdzEpT83RRaaUbA8+Xi2sQ==
X-CSE-MsgGUID: jDkp5ZEJTxqZT88ehK1aXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638272"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638272"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:54 -0700
X-CSE-ConnectionGUID: E+tfNewQR2G+dxfDaLtjzQ==
X-CSE-MsgGUID: Sfz5taGNT7iYfRuzao9pDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59265016"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Eilon Rinat <eilon.rinat@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: Ensure prph_mac dump includes all addresses
Date: Mon,  6 May 2024 10:04:19 +0300
Message-Id: <20240506095953.31fa9ce91a1c.Ia0c86f70c7a6874c15ffc6f8235aa88530208546@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

In prph_mac_iter, ensure that all required addresses are dumped
even if a read fails. Currently, if a read fails, the region dump
is stopped, preventing the creation of prph_mac.lst.

By dumping all addresses even if a read fails, we can accurately
determine which addresses were successfully read and which were not.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Eilon Rinat <eilon.rinat@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index fe4e1bea30bb..945ffc083d25 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1026,17 +1026,12 @@ static int iwl_dump_ini_prph_mac_iter_common(struct iwl_fw_runtime *fwrt,
 {
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	__le32 *val = range->data;
-	u32 prph_val;
 	int i;
 
 	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = size;
-	for (i = 0; i < le32_to_cpu(size); i += 4) {
-		prph_val = iwl_read_prph(fwrt->trans, addr + i);
-		if (iwl_trans_is_hw_error_value(prph_val))
-			return -EBUSY;
-		*val++ = cpu_to_le32(prph_val);
-	}
+	for (i = 0; i < le32_to_cpu(size); i += 4)
+		*val++ = cpu_to_le32(iwl_read_prph(fwrt->trans, addr + i));
 
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
-- 
2.34.1


