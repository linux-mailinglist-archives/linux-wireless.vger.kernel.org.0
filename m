Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216722F91DD
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbhAQLLs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:11:48 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40620 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728146AbhAQLLd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:11:33 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15xC-003sZv-Iz; Sun, 17 Jan 2021 13:10:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:30 +0200
Message-Id: <iwlwifi.20210117130510.9aff3c6b4607.I03b0ae7df094734451445ffcb7f9f0274969f1c0@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117111038.1402870-1-luca@coelho.fi>
References: <20210117111038.1402870-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/11] iwlwifi: mvm: remove debugfs injection limitations
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For testing features where the firmware may send some
notifications it can often be a lot easier to do that
from a test script. Remove most injection limitations
from debugfs to be able to do this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 26 +++++--------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  6 ++---
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 80f848a9ee13..8fb7911cfd6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1117,24 +1117,22 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 					     char *buf, size_t count,
 					     loff_t *ppos)
 {
+	struct iwl_op_mode *opmode = container_of((void *)mvm,
+						  struct iwl_op_mode,
+						  op_mode_specific);
 	struct iwl_rx_cmd_buffer rxb = {
 		._rx_page_order = 0,
 		.truesize = 0, /* not used */
 		._offset = 0,
 	};
 	struct iwl_rx_packet *pkt;
-	struct iwl_rx_mpdu_desc *desc;
 	int bin_len = count / 2;
 	int ret = -EINVAL;
-	size_t mpdu_cmd_hdr_size = (mvm->trans->trans_cfg->device_family >=
-				    IWL_DEVICE_FAMILY_AX210) ?
-		sizeof(struct iwl_rx_mpdu_desc) :
-		IWL_RX_DESC_SIZE_V1;
 
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
 
-	/* supporting only 9000 descriptor */
+	/* supporting only MQ RX */
 	if (!mvm->trans->trans_cfg->mq_rx_supported)
 		return -ENOTSUPP;
 
@@ -1148,22 +1146,12 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 		goto out;
 
 	/* avoid invalid memory access */
-	if (bin_len < sizeof(*pkt) + mpdu_cmd_hdr_size)
-		goto out;
-
-	/* check this is RX packet */
-	if (WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd) !=
-	    WIDE_ID(LEGACY_GROUP, REPLY_RX_MPDU_CMD))
-		goto out;
-
-	/* check the length in metadata matches actual received length */
-	desc = (void *)pkt->data;
-	if (le16_to_cpu(desc->mpdu_len) !=
-	    (bin_len - mpdu_cmd_hdr_size - sizeof(*pkt)))
+	if (bin_len < sizeof(*pkt) ||
+	    bin_len < sizeof(*pkt) + iwl_rx_packet_payload_len(pkt))
 		goto out;
 
 	local_bh_disable();
-	iwl_mvm_rx_mpdu_mq(mvm, NULL, &rxb, 0);
+	iwl_mvm_rx_mq(opmode, NULL, &rxb);
 	local_bh_enable();
 	ret = 0;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ed0e8b751737..28b118f3d73d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1547,6 +1547,9 @@ bool iwl_mvm_bcast_filter_build_cmd(struct iwl_mvm *mvm,
  * FW notifications / CMD responses handlers
  * Convention: iwl_mvm_rx_<NAME OF THE CMD>
  */
+void iwl_mvm_rx_mq(struct iwl_op_mode *op_mode,
+		   struct napi_struct *napi,
+		   struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_rx_rx_phy_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 			struct iwl_rx_cmd_buffer *rxb);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 286ae1757fc3..27527a3440af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1049,9 +1049,9 @@ static void iwl_mvm_rx(struct iwl_op_mode *op_mode,
 		iwl_mvm_rx_common(mvm, rxb, pkt);
 }
 
-static void iwl_mvm_rx_mq(struct iwl_op_mode *op_mode,
-			  struct napi_struct *napi,
-			  struct iwl_rx_cmd_buffer *rxb)
+void iwl_mvm_rx_mq(struct iwl_op_mode *op_mode,
+		   struct napi_struct *napi,
+		   struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
-- 
2.29.2

