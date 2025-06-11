Return-Path: <linux-wireless+bounces-24005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4036DAD5F09
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6741BC18D1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017A12BD5BB;
	Wed, 11 Jun 2025 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYeuuYA+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648822BDC17
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670018; cv=none; b=dDpZoUVnlVvY/VlFCVXObVvFXRpJ6EPJWBk+vzQZuoTgAu51xRATeVUtSzIOCoCGqT+nFbCLS/mia5TzTRWnYzYZ2a76QT7zH58F7mf2Gv4GoFHdNIHOdA1xNepzh4nbLTW8R41ObjXuz5N9335Yaf/gvvRHKombaaTz3M0tp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670018; c=relaxed/simple;
	bh=uU9SdRLZ6Dc5AKK+yj1wJVIU6RdQKS4gSLBFIRAvthM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWU/emEjnE91m3NTDs9s1l07gg6l8RafKGIpi5sUmGaunkR8jettbYvQFJ1uuZ2TjulagqRNUkCQs00oxpf0j/PEZ3gcWA+c8oM+TuWpQ94xwLIOO193Vk7gi4sYfc0j2G7xV5BzJqJkGNX5r7+QpBJx5dB2R9Jro6TbIBg/e+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYeuuYA+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670018; x=1781206018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uU9SdRLZ6Dc5AKK+yj1wJVIU6RdQKS4gSLBFIRAvthM=;
  b=NYeuuYA+aUPUTjvEgZFqZdWj+WOEYBNBlHOSH2Nto+KyGuORcmsLzWQV
   3/tamzK6dwH72qZ0xsBX3UixSWxTZbM+TrB3yFNgVubfI9+tsy9mBMJZ1
   gtXawEtXNOwn2utX9Ep+fpJZYDymp0OHXr08cGw1+GltXQ4J05u+Cqxpn
   b7P6CppiFw3R+DhIs/KTHP3W+ywibLsC43hSVAnDlzCl8xiaXFoJojssV
   HjqFFZ8ZrPd7GmpN4pw3vTMHnwrI0hhsDLeANMk9WscGwf3tGazNxjOMQ
   a91dQi2UHLPfa4s2M+jknxdyI+U+BIowqmmrsE15qt5MwgWxqZLIkytP6
   A==;
X-CSE-ConnectionGUID: XOXknXLMRQ+YCvY+IK26JA==
X-CSE-MsgGUID: PzX5NMU0RS+8IFlypIcB4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360878"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360878"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:58 -0700
X-CSE-ConnectionGUID: MxrEfeQRT7iaRm1M7fQ1hg==
X-CSE-MsgGUID: /7cfjeUZTPCWrtDKi4Xw0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165843"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Or Ron <or.ron@intel.com>,
	Eilon Rinat <eilon.rinat@intel.com>
Subject: [PATCH iwlwifi-next v2 05/15] wifi: iwlwifi: phy periph read - flow modification
Date: Wed, 11 Jun 2025 22:26:24 +0300
Message-Id: <20250611222325.124ce6613edd.Ic1aad57cc6163f0551a3dafae048434f4a2fe7f5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Or Ron <or.ron@intel.com>

If for some reason the reading of phy prph fails, there is no reason to
keep reading them. Check the status abd break early in such case.

Signed-off-by: Or Ron <or.ron@intel.com>
Reviewed-by: Eilon Rinat <eilon.rinat@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 16 ++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 10 +++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 95a732efce45..98ad020014d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1106,6 +1106,7 @@ static int iwl_dump_ini_prph_phy_iter_common(struct iwl_fw_runtime *fwrt,
 	u32 prph_val;
 	u32 dphy_state;
 	u32 dphy_addr;
+	u32 prph_stts;
 	int i;
 
 	range->internal_base_addr = cpu_to_le32(addr);
@@ -1133,6 +1134,21 @@ static int iwl_dump_ini_prph_phy_iter_common(struct iwl_fw_runtime *fwrt,
 
 		iwl_write_prph_no_grab(fwrt->trans, indirect_wr_addr,
 				       WMAL_INDRCT_CMD(addr + i));
+
+		if (fwrt->trans->info.hw_rf_id != IWL_CFG_RF_TYPE_JF1 &&
+		    fwrt->trans->info.hw_rf_id != IWL_CFG_RF_TYPE_JF2 &&
+		    fwrt->trans->info.hw_rf_id != IWL_CFG_RF_TYPE_HR1 &&
+		    fwrt->trans->info.hw_rf_id != IWL_CFG_RF_TYPE_HR2) {
+			udelay(2);
+			prph_stts = iwl_read_prph_no_grab(fwrt->trans,
+							  WMAL_MRSPF_STTS);
+
+			/* Abort dump if status is 0xA5A5A5A2 or FIFO1 empty */
+			if (prph_stts == WMAL_TIMEOUT_VAL ||
+			    !WMAL_MRSPF_STTS_IS_FIFO1_NOT_EMPTY(prph_stts))
+				break;
+		}
+
 		prph_val = iwl_read_prph_no_grab(fwrt->trans,
 						 indirect_rd_addr);
 		*val++ = cpu_to_le32(prph_val);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 23b2009fbb28..a7214ddcfaf5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -514,6 +514,14 @@ enum {
 #define WMAL_INDRCT_CMD(addr) \
 	((WMAL_CMD_READ_BURST_ACCESS << WMAL_INDRCT_RD_CMD1_OPMOD_POS) | \
 	 ((addr) & WMAL_INDRCT_RD_CMD1_BYTE_ADDRESS_MSK))
+#define WMAL_MRSPF_STTS 0xADFC24
+#define WMAL_MRSPF_STTS_FIFO1_NOT_EMPTY_POS 15
+#define WMAL_MRSPF_STTS_FIFO1_NOT_EMPTY_MSK 0x8000
+#define WMAL_TIMEOUT_VAL 0xA5A5A5A2
+#define WMAL_MRSPF_STTS_IS_FIFO1_NOT_EMPTY(val) \
+	(((val) >> (WMAL_MRSPF_STTS_FIFO1_NOT_EMPTY_POS)) & \
+	 ((WMAL_MRSPF_STTS_FIFO1_NOT_EMPTY_MSK) >> \
+	  (WMAL_MRSPF_STTS_FIFO1_NOT_EMPTY_POS)))
 
 #define WFPM_LMAC1_PS_CTL_RW 0xA03380
 #define WFPM_LMAC2_PS_CTL_RW 0xA033C0
-- 
2.34.1


