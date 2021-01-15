Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9B2F772F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 12:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbhAOLGz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 06:06:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40314 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726534AbhAOLGz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 06:06:55 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l0Mvf-003hBK-LJ; Fri, 15 Jan 2021 13:06:08 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:05:52 +0200
Message-Id: <iwlwifi.20210115130252.70e67cc75d88.I6615cad4361862e7f3c9f2d3cafb6a8c61e16781@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115110558.1248847-1-luca@coelho.fi>
References: <20210115110558.1248847-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 06/12] iwlwifi: fix the NMI flow for old devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

I noticed that the flow that triggers an NMI on the firmware
for old devices (tested on 7265) doesn't work.
Apparently, the firmware / device is still in low power when
we write the register that triggers the NMI. We call the
"grab_nic_access" function to make sure the device is awake
but that wasn't enough. I played with this and noticed that
if we wait 1 ms after the device reports it is awake before
we write to the NMI register, the device always sees our
write and the firmware gets properly asserted.

Triggering an NMI to the firmware can be done with the
debugfs hook:
echo 1 > /sys/kernel/debug/iwlwifi/0000\:00\:03.0/iwlmvm/fw_nmi

What happened before is that the firmware would just stall
without running its NMI routine. Because of that the driver
wouldn't get the "firmware crashed" interrupt. After a while
the driver would notice that the firmware is not responding
to some command and it would read the error data from the
firmware, but this data is populated in the NMI service
routine in the firmware which was not called. So in the logs
it looked like:

iwlwifi 0000:00:03.0: Error sending REPLY_ERROR: time out after 2000ms.
iwlwifi 0000:00:03.0: Current CMD queue read_ptr 33 write_ptr 34
iwlwifi 0000:00:03.0: Loaded firmware version: 29.09bd31e1.0 7265D-29.ucode
iwlwifi 0000:00:03.0: 0x00000000 | ADVANCED_SYSASSERT
iwlwifi 0000:00:03.0: 0x00000000 | trm_hw_status0
iwlwifi 0000:00:03.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:00:03.0: 0x00000000 | branchlink2
iwlwifi 0000:00:03.0: 0x00000000 | interruptlink1
iwlwifi 0000:00:03.0: 0x00000000 | interruptlink2
iwlwifi 0000:00:03.0: 0x00000000 | data1
iwlwifi 0000:00:03.0: 0x00000000 | data2
iwlwifi 0000:00:03.0: 0x00000000 | data3
iwlwifi 0000:00:03.0: 0x00000000 | beacon time
iwlwifi 0000:00:03.0: 0x00000000 | tsf low
...

With this fix, immediately after we trigger the NMI to the
firmware, we get the expected:
iwlwifi 0000:00:03.0: Microcode SW error detected.  Restarting 0x2000000.
iwlwifi 0000:00:03.0: Start IWL Error Log Dump:
iwlwifi 0000:00:03.0: Status: 0x00000040, count: 6
iwlwifi 0000:00:03.0: Loaded firmware version: 29.09bd31e1.0 7265D-29.ucode
iwlwifi 0000:00:03.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
iwlwifi 0000:00:03.0: 0x000002F1 | trm_hw_status0
iwlwifi 0000:00:03.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:00:03.0: 0x00043D6C | branchlink2
iwlwifi 0000:00:03.0: 0x0004AFD6 | interruptlink1
iwlwifi 0000:00:03.0: 0x000008C4 | interruptlink2
iwlwifi 0000:00:03.0: 0x00000000 | data1
iwlwifi 0000:00:03.0: 0x00000080 | data2
iwlwifi 0000:00:03.0: 0x07030000 | data3
iwlwifi 0000:00:03.0: 0x003FD4C3 | beacon time
iwlwifi 0000:00:03.0: 0x00C22AC3 | tsf low
iwlwifi 0000:00:03.0: 0x00000000 | tsf hi
iwlwifi 0000:00:03.0: 0x00000000 | time gp1
iwlwifi 0000:00:03.0: 0x00C22AC3 | time gp2
iwlwifi 0000:00:03.0: 0x00000001 | uCode revision type
iwlwifi 0000:00:03.0: 0x0000001D | uCode version major

Notice the first line: "Microcode SW error detected:" which
is printed in the driver's ISR, which means that the driver
actually got an interrupt from the firmware saying that it
crashed. And then we have the properly populated error data.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c |  9 +++++----
 drivers/net/wireless/intel/iwlwifi/iwl-io.h | 10 ++++++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 2ac20d0a30eb..2b7ef1583e7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -150,16 +150,17 @@ u32 iwl_read_prph(struct iwl_trans *trans, u32 ofs)
 }
 IWL_EXPORT_SYMBOL(iwl_read_prph);
 
-void iwl_write_prph(struct iwl_trans *trans, u32 ofs, u32 val)
+void iwl_write_prph_delay(struct iwl_trans *trans, u32 ofs, u32 val, u32 delay_ms)
 {
 	unsigned long flags;
 
 	if (iwl_trans_grab_nic_access(trans, &flags)) {
+		mdelay(delay_ms);
 		iwl_write_prph_no_grab(trans, ofs, val);
 		iwl_trans_release_nic_access(trans, &flags);
 	}
 }
-IWL_EXPORT_SYMBOL(iwl_write_prph);
+IWL_EXPORT_SYMBOL(iwl_write_prph_delay);
 
 int iwl_poll_prph_bit(struct iwl_trans *trans, u32 addr,
 		      u32 bits, u32 mask, int timeout)
@@ -219,8 +220,8 @@ IWL_EXPORT_SYMBOL(iwl_clear_bits_prph);
 void iwl_force_nmi(struct iwl_trans *trans)
 {
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
-		iwl_write_prph(trans, DEVICE_SET_NMI_REG,
-			       DEVICE_SET_NMI_VAL_DRV);
+		iwl_write_prph_delay(trans, DEVICE_SET_NMI_REG,
+				     DEVICE_SET_NMI_VAL_DRV, 1);
 	else if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_NIC_SET_NMI_DRIVER,
 				UREG_NIC_SET_NMI_DRIVER_NMI_FROM_DRIVER);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.h b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
index 39bceee4e9e7..3c21c0e081f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 #ifndef __iwl_io_h__
 #define __iwl_io_h__
@@ -37,7 +37,13 @@ u32 iwl_read_prph_no_grab(struct iwl_trans *trans, u32 ofs);
 u32 iwl_read_prph(struct iwl_trans *trans, u32 ofs);
 void iwl_write_prph_no_grab(struct iwl_trans *trans, u32 ofs, u32 val);
 void iwl_write_prph64_no_grab(struct iwl_trans *trans, u64 ofs, u64 val);
-void iwl_write_prph(struct iwl_trans *trans, u32 ofs, u32 val);
+void iwl_write_prph_delay(struct iwl_trans *trans, u32 ofs,
+			  u32 val, u32 delay_ms);
+static inline void iwl_write_prph(struct iwl_trans *trans, u32 ofs, u32 val)
+{
+	iwl_write_prph_delay(trans, ofs, val, 0);
+}
+
 int iwl_poll_prph_bit(struct iwl_trans *trans, u32 addr,
 		      u32 bits, u32 mask, int timeout);
 void iwl_set_bits_prph(struct iwl_trans *trans, u32 ofs, u32 mask);
-- 
2.29.2

