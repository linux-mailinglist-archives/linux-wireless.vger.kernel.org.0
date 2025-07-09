Return-Path: <linux-wireless+bounces-25024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23928AFDE7F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768C1172784
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF5221FAE;
	Wed,  9 Jul 2025 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JTeejIEH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC2221F13
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032646; cv=none; b=nB+QXl7Mn8Q1DtZrSRMT/d+a3tUYPgygWgS7pFofg/RtUuxd+2TtTVfFPHP0DQiJ3U9snOIBE3OW1ggzLNQkK6+VS/ENFnaLhy1PQCXk33r3cqU3DIFu+bT7ERFs4jo+TrHTA0mHlh47EPAZKHiF9sczu/HGZ4ZK3PiGmVUlD6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032646; c=relaxed/simple;
	bh=sAJlFxiHeZQXZ90jEA/K2X4s01mUcHYQbl5bPSoG7qA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dacq/RRLIwGFpZK5GBHxhDNcgBsfY+CG0FqR74Stz6/ap42qEwFO2bw540Xz1xvWqn15wGCImZvl4fA7zSIUOtPdBurZJbmxV8WCSRacIEdAz8YCCU0a2kTWsw+qvHQjY7aTw82bz3L/nC2KcF8AY4XdMZgtmshLNOOatnriq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JTeejIEH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032644; x=1783568644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sAJlFxiHeZQXZ90jEA/K2X4s01mUcHYQbl5bPSoG7qA=;
  b=JTeejIEHC3qWWALgRkHF959WFNUV/MxtiQl+cZ2zVCxb8fM8kHi3B4JJ
   VdHJEgYQwkw24M3t1HD/5M6pqqzz1225K/BJjZDjq8sq05FsfjoHRYUXF
   G1LyodducT1pIlkioiEFY6c8lK87oCQCmzwkNZM3F6yimeBGMIeHhgzYy
   5RA8p4rfbd6zj4XSyz9ZoTj2jeWIir/NogSXB5Hgd5BZhfdhXyo/ORVdd
   2C4TjD+tprkucgFYnwNmYpzINOxsYliJTHjE3DKZLSDxsNajUcVT6ag8H
   sHiUwty/9AAYpBIGZzMwS2SmB6FuVwHRCNn7zujcUupTr2MizwBz8fqqg
   w==;
X-CSE-ConnectionGUID: gCd5cow5R3KKzUUcoNUrlQ==
X-CSE-MsgGUID: aiWbsPUIRWeKx2axDPW4Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720629"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720629"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:04 -0700
X-CSE-ConnectionGUID: FK/tad8mQh2yESNSgko7DA==
X-CSE-MsgGUID: 1xNCt/wXSxCoYVYTAm2Owg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390548"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH iwlwifi-next v2 04/15] wifi: iwlwifi: pcie: Move txcmd size/align calculation to callers
Date: Wed,  9 Jul 2025 06:43:28 +0300
Message-Id: <20250709063858.0b7819f2e5bb.I3552860dd062a523606c8a5c85c9a6f0d4f04262@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
References: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
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
index 49baa4b57b42..162c61e97629 100644
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
@@ -4142,6 +4143,7 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 	};
 	struct iwl_trans *iwl_trans;
 	struct iwl_trans_pcie *trans_pcie;
+	unsigned int txcmd_size, txcmd_align;
 	int ret;
 
 	iwl_trans = iwl_trans_pcie_alloc(pdev, trans, &info);
@@ -4250,7 +4252,19 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 
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


