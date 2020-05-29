Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513D11E760E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 08:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgE2Gjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 02:39:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:35012 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbgE2Gjq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 02:39:46 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jeYgB-000jvb-Rc; Fri, 29 May 2020 09:39:44 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 29 May 2020 09:39:26 +0300
Message-Id: <iwlwifi.20200529092401.f83f994572ca.Ibcfd66c3f9b69e68a53b3b2df8331ffb225db655@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063931.80551-1-luca@coelho.fi>
References: <20200529063931.80551-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/11] iwlwifi: pcie: gen3: indicate 8k/12k RB size to device
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Newer firmware versions will parse a few extra bits in the
context info to be able to determine whether we are using
bigger than 4k RBs, indicate 8k/12k to them if we actually
use those (e.g. for sniffer based on the module parameter).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h   | 12 ++++++++++--
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |  8 ++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index ebea99189ca9..9d7a04833cd0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018, 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -18,7 +18,7 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018, 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -93,6 +93,11 @@ enum iwl_prph_scratch_mtr_format {
  * @IWL_PRPH_SCRATCH_MTR_FORMAT: a mask for the size of the tfd.
  *	There are 4 optional values: 0: 16 bit, 1: 32 bit, 2: 64 bit,
  *	3: 256 bit.
+ * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_MASK: RB size full information, ignored
+ *	by older firmware versions, so set IWL_PRPH_SCRATCH_RB_SIZE_4K
+ *	appropriately; use the below values for this.
+ * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_8K: 8kB RB size
+ * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_12K: 12kB RB size
  */
 enum iwl_prph_scratch_flags {
 	IWL_PRPH_SCRATCH_EARLY_DEBUG_EN		= BIT(4),
@@ -103,6 +108,9 @@ enum iwl_prph_scratch_flags {
 	IWL_PRPH_SCRATCH_RB_SIZE_4K		= BIT(16),
 	IWL_PRPH_SCRATCH_MTR_MODE		= BIT(17),
 	IWL_PRPH_SCRATCH_MTR_FORMAT		= BIT(18) | BIT(19),
+	IWL_PRPH_SCRATCH_RB_SIZE_EXT_MASK	= 0xf << 20,
+	IWL_PRPH_SCRATCH_RB_SIZE_EXT_8K		= 8 << 20,
+	IWL_PRPH_SCRATCH_RB_SIZE_EXT_12K	= 9 << 20,
 };
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index b6a5921a63c3..dcd81ee1f773 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -138,9 +138,17 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	case IWL_AMSDU_2K:
 		break;
 	case IWL_AMSDU_4K:
+		control_flags |= IWL_PRPH_SCRATCH_RB_SIZE_4K;
+		break;
 	case IWL_AMSDU_8K:
+		control_flags |= IWL_PRPH_SCRATCH_RB_SIZE_4K;
+		/* if firmware supports the ext size, tell it */
+		control_flags |= IWL_PRPH_SCRATCH_RB_SIZE_EXT_8K;
+		break;
 	case IWL_AMSDU_12K:
 		control_flags |= IWL_PRPH_SCRATCH_RB_SIZE_4K;
+		/* if firmware supports the ext size, tell it */
+		control_flags |= IWL_PRPH_SCRATCH_RB_SIZE_EXT_12K;
 		break;
 	}
 
-- 
2.26.2

