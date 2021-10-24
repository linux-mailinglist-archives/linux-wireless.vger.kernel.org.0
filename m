Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2C43895C
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhJXN5q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 09:57:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58566 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231706AbhJXN5o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:44 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1medy5-000cvJ-W0; Sun, 24 Oct 2021 16:55:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:55:06 +0300
Message-Id: <iwlwifi.20211024165252.21c90ba4fa5f.I2a30f62aa4685dc7623d3c69838909833c3f435c@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024135506.285102-1-luca@coelho.fi>
References: <20211024135506.285102-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/11] iwlwifi: dump host monitor data when NIC doesn't init
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the NIC cannot be initialized, dump host monitor data
so we can analyze properly why it didn't initialize.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c | 46 ++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 6e96ee5bc261..46917b4216b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -398,6 +398,47 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 	return 0;
 }
 
+#define IWL_HOST_MON_BLOCK_PEMON	0x00
+#define IWL_HOST_MON_BLOCK_HIPM		0x22
+
+#define IWL_HOST_MON_BLOCK_PEMON_VEC0	0x00
+#define IWL_HOST_MON_BLOCK_PEMON_VEC1	0x01
+#define IWL_HOST_MON_BLOCK_PEMON_WFPM	0x06
+
+static void iwl_dump_host_monitor_block(struct iwl_trans *trans,
+					u32 block, u32 vec, u32 iter)
+{
+	int i;
+
+	IWL_ERR(trans, "Host monitor block 0x%x vector 0x%x\n", block, vec);
+	iwl_write32(trans, CSR_MONITOR_CFG_REG, (block << 8) | vec);
+	for (i = 0; i < iter; i++)
+		IWL_ERR(trans, "    value [iter %d]: 0x%08x\n",
+			i, iwl_read32(trans, CSR_MONITOR_STATUS_REG));
+}
+
+static void iwl_dump_host_monitor(struct iwl_trans *trans)
+{
+	switch (trans->trans_cfg->device_family) {
+	case IWL_DEVICE_FAMILY_22000:
+	case IWL_DEVICE_FAMILY_AX210:
+		IWL_ERR(trans, "CSR_RESET = 0x%x\n",
+			iwl_read32(trans, CSR_RESET));
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
+					    IWL_HOST_MON_BLOCK_PEMON_VEC0, 15);
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
+					    IWL_HOST_MON_BLOCK_PEMON_VEC1, 15);
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
+					    IWL_HOST_MON_BLOCK_PEMON_WFPM, 15);
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_HIPM,
+					    IWL_HOST_MON_BLOCK_PEMON_VEC0, 1);
+		break;
+	default:
+		/* not supported yet */
+		return;
+	}
+}
+
 int iwl_finish_nic_init(struct iwl_trans *trans)
 {
 	const struct iwl_cfg_trans_params *cfg_trans = trans->trans_cfg;
@@ -433,9 +474,12 @@ int iwl_finish_nic_init(struct iwl_trans *trans)
 	 * and accesses to uCode SRAM.
 	 */
 	err = iwl_poll_bit(trans, CSR_GP_CNTRL, poll_ready, poll_ready, 25000);
-	if (err < 0)
+	if (err < 0) {
 		IWL_DEBUG_INFO(trans, "Failed to wake NIC\n");
 
+		iwl_dump_host_monitor(trans);
+	}
+
 	if (cfg_trans->bisr_workaround) {
 		/* ensure BISR shift has finished */
 		udelay(200);
-- 
2.33.0

