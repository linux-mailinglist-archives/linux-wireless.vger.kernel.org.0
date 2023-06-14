Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED772F99C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244174AbjFNJpc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244268AbjFNJon (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CBB1FF5
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735813; x=1718271813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=69mwLCnksy5tNztA863iiRxvL63vI714m4MtHAH93B8=;
  b=fmOmSIoKqRDVK0Veuf19x7mquWng/DFfqW/6Jwh0tqZM/Iw6B5GzfX1/
   TnvrUBKTQKWaI4aSEVKM7z1IBtjdmiYkt0wXyy+d+CYCtIFnYBL+JXhOD
   w1LONcEJDKrjn+DC+Yh51mqPqEAApUWBbwEd23f2an54t+ZJiQNF3PtF7
   nqy4pMyOLHrDsPxT78VieO+5af+Wyj5cElwwDGxKGZXF5kW2mMClcG9cA
   A6W3EyHAq1jYVsS0EKovCyZ1YcG5PR0Vok0hlX0nfVynbiGT1OGXi8Anj
   Ccinr0KGjysNI21Fhw9JQHLFLkVj9U/f+z5dsyTbB0071ge+E0lnnyf/G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049839"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049839"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989825"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989825"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/20] wifi: iwlwifi: pcie: double-check ACK interrupt after timeout
Date:   Wed, 14 Jun 2023 12:41:23 +0300
Message-Id: <20230614123446.00cc2d9b88c3.I429bfe800f17c624e50c0b0c10dd2cd7d885f199@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are evidently cases where the firmware completes the
reset but the interrupt isn't received correctly, so check
for the interrupt again after the timeout, and don't dump
the firmware error log if the right bit is set.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 73b395841ca8..fa46dad5fd68 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-prph.h"
@@ -117,9 +117,14 @@ static void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 				 trans_pcie->fw_reset_state != FW_RESET_REQUESTED,
 				 FW_RESET_TIMEOUT);
 	if (!ret || trans_pcie->fw_reset_state == FW_RESET_ERROR) {
-		IWL_INFO(trans,
-			 "firmware didn't ACK the reset - continue anyway\n");
-		iwl_trans_fw_error(trans, true);
+		u32 inta_hw = iwl_read32(trans, CSR_MSIX_HW_INT_CAUSES_AD);
+
+		IWL_ERR(trans,
+			"timeout waiting for FW reset ACK (inta_hw=0x%x)\n",
+			inta_hw);
+
+		if (!(inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE))
+			iwl_trans_fw_error(trans, true);
 	}
 
 	trans_pcie->fw_reset_state = FW_RESET_IDLE;
-- 
2.38.1

