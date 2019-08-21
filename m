Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5C97B1D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 15:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfHUNkE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 09:40:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37836 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726484AbfHUNkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 09:40:04 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0Qod-0000lZ-MR; Wed, 21 Aug 2019 16:38:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 16:38:00 +0300
Message-Id: <20190821133800.23636-19-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821133800.23636-1-luca@coelho.fi>
References: <20190821133800.23636-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 18/18] iwlwifi: dbg_ini: remove periphery phy and aux regions handling
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

periphery phy and aux regions should not be collected like periphery mac
region. Remove their handling. The handling will be added in the future
once the FW will support it.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Fixes: 7a14c23dcdee ("iwlwifi: dbg: dump data according to the new ini TLVs")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 78e13cd182cb..1aa880936121 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1908,8 +1908,6 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 			iwl_dump_ini_mem(fwrt, data, reg, &ops);
 			break;
 		case IWL_FW_INI_REGION_PERIPHERY_MAC:
-		case IWL_FW_INI_REGION_PERIPHERY_PHY:
-		case IWL_FW_INI_REGION_PERIPHERY_AUX:
 			ops.get_num_of_ranges =	iwl_dump_ini_mem_ranges;
 			ops.get_size = iwl_dump_ini_mem_get_size;
 			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
@@ -1974,6 +1972,8 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 			ops.fill_range = iwl_dump_ini_csr_iter;
 			iwl_dump_ini_mem(fwrt, data, reg, &ops);
 			break;
+		case IWL_FW_INI_REGION_PERIPHERY_PHY:
+		case IWL_FW_INI_REGION_PERIPHERY_AUX:
 		case IWL_FW_INI_REGION_DRAM_IMR:
 			/* This is undefined yet */
 		default:
-- 
2.23.0.rc1

