Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D572D4CB5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbgLIVST (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:18:19 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35608 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728003AbgLIVRs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:17:48 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pU-003Drx-7q; Wed, 09 Dec 2020 23:16:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:07 +0200
Message-Id: <iwlwifi.20201209231351.c9a9cbef4a09.Ic7df63c617f79b7e6a95a510c51b3516bba5599f@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 03/47] iwlwifi: yoyo: align the write pointer to DWs
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rotem Saado <rotem.saado@intel.com>

from AX210 generation the write pointer is in Bytes.
to be align with all previous HWs convert it DWs.

Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c     | 5 +++++
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 579c1929729e..185c1d893b52 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1662,6 +1662,11 @@ iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt,
 
 	data->write_ptr = iwl_get_mon_reg(fwrt, alloc_id,
 					  &addrs->write_ptr);
+	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		u32 wrt_ptr = le32_to_cpu(data->write_ptr);
+
+		data->write_ptr = cpu_to_le32(wrt_ptr >> 2);
+	}
 	data->cycle_cnt = iwl_get_mon_reg(fwrt, alloc_id,
 					  &addrs->cycle_cnt);
 	data->cur_frag = iwl_get_mon_reg(fwrt, alloc_id,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index d2e69ad53b27..8fd85ebf1b35 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3115,6 +3115,8 @@ iwl_trans_pcie_dump_pointers(struct iwl_trans *trans,
 		fw_mon_data->fw_mon_base_high_ptr =
 			cpu_to_le32(iwl_read_prph(trans, base_high));
 		write_ptr_val &= DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK;
+		/* convert wrtPtr to DWs, to align with all HWs */
+		write_ptr_val >>= 2;
 	}
 	fw_mon_data->fw_mon_wr_ptr = cpu_to_le32(write_ptr_val);
 }
-- 
2.29.2

