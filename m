Return-Path: <linux-wireless+bounces-25058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F4DAFDF1E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25505856CC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A526A1C7;
	Wed,  9 Jul 2025 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VN2nwPFw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183926A0FD
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038222; cv=none; b=j5m7TixLKvceKgcTm9P3gcNZq5bc+m8WuUtM6hKvtYNa3cY1h/aN4NpQm9Ohk88C/boaJdcbKtdVnqKbSVw0iR+Qd3I73RWMo8Jj5kaKcC6S7op7eLHEx4QIbLmZs6NrOLeIpd/EHysEa8XB/QZ63CYNs9NpzuGPBsUrRGejMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038222; c=relaxed/simple;
	bh=uiAx5S1yZp3DMFYYANp4nm2RTR9B8vHiaAJmvKZ7+rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FL16FHE0pk3nlBAOEYUHVAzpVdjrkOF8erDWACELFmqwF9Y4CxwD9moHIv1fKmOtVM93r+dES5+6ViHVHhEXXzQW2OHjBNgw+Se/tyMTCBZ+YJavL+P0I//s6OQnihXEfX1wbPZJZMRVkWnDrRw/CyuXAl0/ZDutwiUVMhe28ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VN2nwPFw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038222; x=1783574222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uiAx5S1yZp3DMFYYANp4nm2RTR9B8vHiaAJmvKZ7+rE=;
  b=VN2nwPFwl2rmQx3V2tkuoNO/b+ydIhtSjEMHuyc7k8aIiWCfZ/gd1KTf
   m2yyutLEB5AsuimM1EJ/n1tbbRO4WmACu09LsnuW14Ez1wZZHqVd2qBKk
   j0zH1iL5WcAunXBeyZSUZD4Umh7P8R2Mk8BqWIL7z0KXyPad8l+GTfwYf
   mhs0jbhYj4bi0WtzWkOmVFu67eDzdgpmBp/RKgQ/BDbZuxw6asfoSRG5o
   3Xut8azG/XaUh15ZttnBW4W1kBA6SPxoCqxBFBwEclCq0VgbdRdrEsqfD
   e26six1d1jlirDNgYvxbPRO8avNE1kNtfwOnmZBc2ICcwZhM5ZHshUC2b
   w==;
X-CSE-ConnectionGUID: EHA14gtqRTyR4k14lkEYfg==
X-CSE-MsgGUID: B+eFdJLCSxG9msVLMOeuVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091170"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091170"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:01 -0700
X-CSE-ConnectionGUID: fS/hF1jqTZ2JEMNSz2lv/g==
X-CSE-MsgGUID: oAC9KV6NSneDdlH4kTKBnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327866"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH iwlwifi-next v3 04/15] wifi: iwlwifi: pcie: Move txcmd size/align calculation to callers
Date: Wed,  9 Jul 2025 08:16:23 +0300
Message-Id: <20250709081300.237285d81461.I3552860dd062a523606c8a5c85c9a6f0d4f04262@changeid>
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

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

Refactor iwl_trans_init to accept txcmd_size and txcmd_align as parameters
instead of calculating them internally.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c   | 16 ++--------------
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h   |  3 ++-
 .../wireless/intel/iwlwifi/pcie/gen1_2/trans.c   | 16 +++++++++++++++-
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 78808c956444..6288779ff8ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -293,25 +293,13 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 	return trans;
 }
 
-int iwl_trans_init(struct iwl_trans *trans)
+int iwl_trans_init(struct iwl_trans *trans, unsigned int txcmd_size,
+		   unsigned int txcmd_align)
 {
-	int txcmd_size, txcmd_align;
-
 	/* check if name/num_rx_queues were set as a proxy for info being set */
 	if (WARN_ON(!trans->info.name || !trans->info.num_rxqs))
 		return -EINVAL;
 
-	if (!trans->mac_cfg->gen2) {
-		txcmd_size = sizeof(struct iwl_tx_cmd_v6);
-		txcmd_align = sizeof(void *);
-	} else if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
-		txcmd_size = sizeof(struct iwl_tx_cmd_v9);
-		txcmd_align = 64;
-	} else {
-		txcmd_size = sizeof(struct iwl_tx_cmd);
-		txcmd_align = 128;
-	}
-
 	txcmd_size += sizeof(struct iwl_cmd_header);
 	txcmd_size += 36; /* biggest possible 802.11 header */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 012b1e44bce3..49a695e30109 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1206,7 +1206,8 @@ static inline void iwl_trans_finish_sw_reset(struct iwl_trans *trans)
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 			  struct device *dev,
 			  const struct iwl_mac_cfg *cfg_trans);
-int iwl_trans_init(struct iwl_trans *trans);
+int iwl_trans_init(struct iwl_trans *trans, unsigned int txcmd_size,
+		   unsigned int txcmd_align);
 void iwl_trans_free(struct iwl_trans *trans);
 
 static inline bool iwl_trans_is_hw_error_value(u32 val)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 0ebb1e7e4bf5..9355d5a9d933 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -25,6 +25,7 @@
 #include "fw/dbg.h"
 #include "fw/api/tx.h"
 #include "fw/acpi.h"
+#include "fw/api/tx.h"
 #include "mei/iwl-mei.h"
 #include "internal.h"
 #include "iwl-fh.h"
@@ -4139,6 +4140,7 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 	};
 	struct iwl_trans *iwl_trans;
 	struct iwl_trans_pcie *trans_pcie;
+	unsigned int txcmd_size, txcmd_align;
 	int ret;
 
 	iwl_trans = iwl_trans_pcie_alloc(pdev, trans, &info);
@@ -4247,7 +4249,19 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 
 	iwl_trans_set_info(iwl_trans, &info);
 
-	ret = iwl_trans_init(iwl_trans);
+	if (!iwl_trans->mac_cfg->gen2) {
+		txcmd_size = sizeof(struct iwl_tx_cmd_v6);
+		txcmd_align = sizeof(void *);
+	} else if (iwl_trans->mac_cfg->device_family <
+		   IWL_DEVICE_FAMILY_AX210) {
+		txcmd_size = sizeof(struct iwl_tx_cmd_v9);
+		txcmd_align = 64;
+	} else {
+		txcmd_size = sizeof(struct iwl_tx_cmd);
+		txcmd_align = 128;
+	}
+	ret = iwl_trans_init(iwl_trans, txcmd_size, txcmd_align);
+
 	if (ret)
 		goto out_free_trans;
 
-- 
2.34.1


