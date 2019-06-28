Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE559750
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfF1JUh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:37 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54758 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726667AbfF1JUh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3Q-0001ny-SZ; Fri, 28 Jun 2019 12:20:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 11/20] iwlwifi: dbg: fix debug monitor stop and restart delays
Date:   Fri, 28 Jun 2019 12:19:59 +0300
Message-Id: <20190628092008.11049-12-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

The driver should delay only in recording stop flow between writing to
DBGC_IN_SAMPLE register and DBGC_OUT_CTRL register. Any other delay is
not needed.

Change the following:
1. Remove any unnecessary delays in the flow
2. Increase the delay in the stop recording flow since 100 micro is
   not enough
3. Use usleep_range instead of delay since the driver is allowed to
   sleep in this flow.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Fixes: 5cfe79c8d92a ("iwlwifi: fw: stop and start debugging using host command")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 2 --
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 0c366009389e..21df3e3a28e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2386,8 +2386,6 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	/* start recording again if the firmware is not crashed */
 	if (!test_bit(STATUS_FW_ERROR, &fwrt->trans->status) &&
 	    fwrt->fw->dbg.dest_tlv) {
-		/* wait before we collect the data till the DBGC stop */
-		udelay(500);
 		iwl_fw_dbg_restart_recording(fwrt, &params);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index d009c0aa95d7..cff96d2a7e4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -295,7 +295,10 @@ _iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
 	}
 
 	iwl_write_umac_prph(trans, DBGC_IN_SAMPLE, 0);
-	udelay(100);
+	/* wait for the DBGC to finish writing the internal buffer to DRAM to
+	 * avoid halting the HW while writing
+	 */
+	usleep_range(700, 1000);
 	iwl_write_umac_prph(trans, DBGC_OUT_CTRL, 0);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	trans->dbg_rec_on = false;
@@ -325,7 +328,6 @@ _iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
 	} else {
 		iwl_write_umac_prph(trans, DBGC_IN_SAMPLE, params->in_sample);
-		udelay(100);
 		iwl_write_umac_prph(trans, DBGC_OUT_CTRL, params->out_ctrl);
 	}
 }
-- 
2.20.1

