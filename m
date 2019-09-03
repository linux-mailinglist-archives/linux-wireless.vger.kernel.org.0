Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054A8A62B4
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 09:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfICHhv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 03:37:51 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40316 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725888AbfICHhv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 03:37:51 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i53Nf-0004Cd-A4; Tue, 03 Sep 2019 10:37:35 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  3 Sep 2019 10:37:06 +0300
Message-Id: <20190903073714.32278-14-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903073714.32278-1-luca@coelho.fi>
References: <20190903073714.32278-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 13/21] iwlwifi: mvm: handle BAR_FRAME_RELEASE (0xc2) notification
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In prior hardware generations (e.g. 9000 series), we received the BAR
frame with fake NSSN information to handle releasing frames from the
reorder buffer for the default queue, the other queues were getting
the FRAME_RELEASE notification in this case.

With multi-TID block-ack, the firmware no longer sends us the BAR
frame because the fake RX is quite big (just the metadata is around
48 bytes or so). Instead, it now sends us one (or multiple) special
release notifications (0xc2). The hardware consumes these as well,
but only generates the FRAME_RELEASE (0xc3) for queues other than
the default queue. We thus need to handle them in the same way we
handle the normal FRAME_RELEASE.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  7 ++++
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 32 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 39 +++++++++++++++++++
 5 files changed, 83 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 4d2274bcc0b5..22dff2c92d4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -474,6 +474,13 @@ enum iwl_legacy_cmds {
 	 */
 	REPLY_RX_MPDU_CMD = 0xc1,
 
+	/**
+	 * @BAR_FRAME_RELEASE: Frame release from BAR notification, used for
+	 *	multi-TID BAR (previously, the BAR frame itself was reported
+	 *	instead). Uses &struct iwl_bar_frame_release.
+	 */
+	BAR_FRAME_RELEASE = 0xc2,
+
 	/**
 	 * @FRAME_RELEASE:
 	 * Frame release (reorder helper) notification, uses
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 9b0bb89599fc..a93449db7bb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -746,6 +746,38 @@ struct iwl_frame_release {
 	__le16 nssn;
 };
 
+/**
+ * enum iwl_bar_frame_release_sta_tid - STA/TID information for BAR release
+ * @IWL_BAR_FRAME_RELEASE_TID_MASK: TID mask
+ * @IWL_BAR_FRAME_RELEASE_STA_MASK: STA mask
+ */
+enum iwl_bar_frame_release_sta_tid {
+	IWL_BAR_FRAME_RELEASE_TID_MASK = 0x0000000f,
+	IWL_BAR_FRAME_RELEASE_STA_MASK = 0x000001f0,
+};
+
+/**
+ * enum iwl_bar_frame_release_ba_info - BA information for BAR release
+ * @IWL_BAR_FRAME_RELEASE_NSSN_MASK: NSSN mask
+ * @IWL_BAR_FRAME_RELEASE_SN_MASK: SN mask (ignored by driver)
+ * @IWL_BAR_FRAME_RELEASE_BAID_MASK: BAID mask
+ */
+enum iwl_bar_frame_release_ba_info {
+	IWL_BAR_FRAME_RELEASE_NSSN_MASK	= 0x00000fff,
+	IWL_BAR_FRAME_RELEASE_SN_MASK	= 0x00fff000,
+	IWL_BAR_FRAME_RELEASE_BAID_MASK	= 0x3f000000,
+};
+
+/**
+ * struct iwl_bar_frame_release - frame release from BAR info
+ * @sta_tid: STA & TID information, see &enum iwl_bar_frame_release_sta_tid.
+ * @ba_info: BA information, see &enum iwl_bar_frame_release_ba_info.
+ */
+struct iwl_bar_frame_release {
+	__le32 sta_tid;
+	__le32 ba_info;
+} __packed; /* RX_BAR_TO_FRAME_RELEASE_API_S_VER_1 */
+
 enum iwl_rss_hash_func_en {
 	IWL_RSS_HASH_TYPE_IPV4_TCP,
 	IWL_RSS_HASH_TYPE_IPV4_UDP,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b8a8369457b9..843d00bf2bd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1606,6 +1606,8 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 				struct iwl_rx_cmd_buffer *rxb, int queue);
 void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 			      struct iwl_rx_cmd_buffer *rxb, int queue);
+void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
+				  struct iwl_rx_cmd_buffer *rxb, int queue);
 int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
 			    const u8 *data, u32 count, bool async);
 void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 35b393f8cd85..961c7ab7950b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -389,6 +389,7 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
 	HCMD_NAME(SCAN_ITERATION_COMPLETE_UMAC),
 	HCMD_NAME(REPLY_RX_PHY_CMD),
 	HCMD_NAME(REPLY_RX_MPDU_CMD),
+	HCMD_NAME(BAR_FRAME_RELEASE),
 	HCMD_NAME(FRAME_RELEASE),
 	HCMD_NAME(BA_NOTIF),
 	HCMD_NAME(MCC_UPDATE_CMD),
@@ -1060,6 +1061,8 @@ static void iwl_mvm_rx_mq(struct iwl_op_mode *op_mode,
 		iwl_mvm_rx_queue_notif(mvm, napi, rxb, 0);
 	else if (cmd == WIDE_ID(LEGACY_GROUP, FRAME_RELEASE))
 		iwl_mvm_rx_frame_release(mvm, napi, rxb, 0);
+	else if (cmd == WIDE_ID(LEGACY_GROUP, BAR_FRAME_RELEASE))
+		iwl_mvm_rx_bar_frame_release(mvm, napi, rxb, 0);
 	else if (cmd == WIDE_ID(DATA_PATH_GROUP, RX_NO_DATA_NOTIF))
 		iwl_mvm_rx_monitor_no_data(mvm, napi, rxb, 0);
 	else
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index f3f9e641ae70..c48d6fb16408 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2014,3 +2014,42 @@ void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 					  le16_to_cpu(release->nssn),
 					  queue, 0);
 }
+
+void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
+				  struct iwl_rx_cmd_buffer *rxb, int queue)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_bar_frame_release *release = (void *)pkt->data;
+	unsigned int baid = le32_get_bits(release->ba_info,
+					  IWL_BAR_FRAME_RELEASE_BAID_MASK);
+	unsigned int nssn = le32_get_bits(release->ba_info,
+					  IWL_BAR_FRAME_RELEASE_NSSN_MASK);
+	unsigned int sta_id = le32_get_bits(release->sta_tid,
+					    IWL_BAR_FRAME_RELEASE_STA_MASK);
+	unsigned int tid = le32_get_bits(release->sta_tid,
+					 IWL_BAR_FRAME_RELEASE_TID_MASK);
+	struct iwl_mvm_baid_data *baid_data;
+
+	if (WARN_ON_ONCE(baid == IWL_RX_REORDER_DATA_INVALID_BAID ||
+			 baid >= ARRAY_SIZE(mvm->baid_map)))
+		return;
+
+	rcu_read_lock();
+	baid_data = rcu_dereference(mvm->baid_map[baid]);
+	if (!baid_data) {
+		IWL_DEBUG_RX(mvm,
+			     "Got valid BAID %d but not allocated, invalid BAR release!\n",
+			      baid);
+		goto out;
+	}
+
+	if (WARN(tid != baid_data->tid || sta_id != baid_data->sta_id,
+		 "baid 0x%x is mapped to sta:%d tid:%d, but BAR release received for sta:%d tid:%d\n",
+		 baid, baid_data->sta_id, baid_data->tid, sta_id,
+		 tid))
+		goto out;
+
+	iwl_mvm_release_frames_from_notif(mvm, napi, baid, nssn, queue, 0);
+out:
+	rcu_read_unlock();
+}
-- 
2.23.0.rc1

