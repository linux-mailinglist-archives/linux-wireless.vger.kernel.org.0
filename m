Return-Path: <linux-wireless+bounces-3751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B6859858
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E8FB2127E
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89976FBB8;
	Sun, 18 Feb 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvpImxuK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9A6F08C
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278752; cv=none; b=aeFTTra3am9IoizEcYOLcBL6ke5Sh1M+0brXcwCeL8YaVXBYnVDgFyttBbRD+640CJLcni3qZH8RV00VvUoLhBzO5eoPYxJPz/dVkMz6WIe7Y5EQ86wpTdV4sr1IVNAchfs82re0YlwcYV+vhBnbIcxTxgMJnPXxvzIkC6ChX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278752; c=relaxed/simple;
	bh=OcffHn90xyu33ofSRyoFxQF1Z0ONB4MFgwkuQOUoLHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FTuRvXiAXBaAJ71p6D6xRBzDqQEwXHUK9oOJFqnPlpdWWtFWy27UuGJPBJ4o4M/Y7rpHVOxZ3d6h+v7qd0zYfXGuE41Sg5Aa73j37NCN7/Tt/gHQdIs97jcr6JaUZvbHCXkz4GhQ5xuu7QP6feXJVKTm0IEWjXGlyb521L9JLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvpImxuK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278746; x=1739814746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OcffHn90xyu33ofSRyoFxQF1Z0ONB4MFgwkuQOUoLHM=;
  b=QvpImxuK7QejZBppA0n1q0vQaHIZaNQJYLxage+GCs+j+MNZ/drhXcdw
   Yvm08GvqQv4d+QhXp9hbFRpg9xBGbGozaffwJnYPtciTmrt9h6t0YQswB
   BCa6fnppwR/XPlJDLBNijAC8sJIkF36UbzrIPpY5P1XS/zmyeLrJK+PaZ
   UgX5LN/sZP876XmgGT+fh3tvOoNqPoXTc1AhK/DzhCcjY7Ld/7r8XA2kG
   wOXMl8gTnK8lWuPAkRwqqGIZFBmXZqYT3S9SG+CegtkkrXZOO1AtgCzf1
   mPa/CowSD4LtaGCwETgBAKNesXVpGo9jvKEynhVjgeIiEzV7mO0DlEfUl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464988"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464988"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459453"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 09/11] wifi: iwlwifi: mvm: fix the TXF mapping for BZ devices
Date: Sun, 18 Feb 2024 19:51:50 +0200
Message-Id: <20240218194912.da336ca2fa0a.I73e44d5fc474ebb6f275b9008950e59c012f33b2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Those devices' fifos are numbered differently.
Because of that, we were looking at the size of the VO fifo size to
determine the size of the A-MSDU which led to a lower throughput.

Note that for those devices the only user of the AC -> fifo mapping is
the size limitation of A-MSDU.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h   | 12 +++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 11 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  8 ++++++--
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
index 9c69d3674384..e6c0f928a6bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2019-2021, 2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2019-2021, 2023-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -66,6 +66,16 @@ enum iwl_gen2_tx_fifo {
 	IWL_GEN2_TRIG_TX_FIFO_VO,
 };
 
+enum iwl_bz_tx_fifo {
+	IWL_BZ_EDCA_TX_FIFO_BK,
+	IWL_BZ_EDCA_TX_FIFO_BE,
+	IWL_BZ_EDCA_TX_FIFO_VI,
+	IWL_BZ_EDCA_TX_FIFO_VO,
+	IWL_BZ_TRIG_TX_FIFO_BK,
+	IWL_BZ_TRIG_TX_FIFO_BE,
+	IWL_BZ_TRIG_TX_FIFO_VI,
+	IWL_BZ_TRIG_TX_FIFO_VO,
+};
 /**
  * enum iwl_tx_queue_cfg_actions - TXQ config options
  * @TX_QUEUE_CFG_ENABLE_QUEUE: enable a queue
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index cc592e288188..3002f0f8d3bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -31,6 +31,17 @@ const u8 iwl_mvm_ac_to_gen2_tx_fifo[] = {
 	IWL_GEN2_TRIG_TX_FIFO_BK,
 };
 
+const u8 iwl_mvm_ac_to_bz_tx_fifo[] = {
+	IWL_BZ_EDCA_TX_FIFO_VO,
+	IWL_BZ_EDCA_TX_FIFO_VI,
+	IWL_BZ_EDCA_TX_FIFO_BE,
+	IWL_BZ_EDCA_TX_FIFO_BK,
+	IWL_BZ_TRIG_TX_FIFO_VO,
+	IWL_BZ_TRIG_TX_FIFO_VI,
+	IWL_BZ_TRIG_TX_FIFO_BE,
+	IWL_BZ_TRIG_TX_FIFO_BK,
+};
+
 struct iwl_mvm_mac_iface_iterator_data {
 	struct iwl_mvm *mvm;
 	struct ieee80211_vif *vif;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index fcae5199ac90..8a45d69d0f81 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1589,12 +1589,16 @@ static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
 
 extern const u8 iwl_mvm_ac_to_tx_fifo[];
 extern const u8 iwl_mvm_ac_to_gen2_tx_fifo[];
+extern const u8 iwl_mvm_ac_to_bz_tx_fifo[];
 
 static inline u8 iwl_mvm_mac_ac_to_tx_fifo(struct iwl_mvm *mvm,
 					   enum ieee80211_ac_numbers ac)
 {
-	return iwl_mvm_has_new_tx_api(mvm) ?
-		iwl_mvm_ac_to_gen2_tx_fifo[ac] : iwl_mvm_ac_to_tx_fifo[ac];
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		return  iwl_mvm_ac_to_bz_tx_fifo[ac];
+	if (iwl_mvm_has_new_tx_api(mvm))
+		return iwl_mvm_ac_to_gen2_tx_fifo[ac];
+	return iwl_mvm_ac_to_tx_fifo[ac];
 }
 
 struct iwl_rate_info {
-- 
2.34.1


