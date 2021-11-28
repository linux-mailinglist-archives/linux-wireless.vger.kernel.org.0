Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18593460613
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Nov 2021 13:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357410AbhK1MUg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Nov 2021 07:20:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:49552 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236551AbhK1MSf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Nov 2021 07:18:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="259737788"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="259737788"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 04:15:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="498990677"
Received: from iberendo-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.255.202.253])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 04:15:18 -0800
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] iwlwifi: mei: don't rely on the size from the shared area
Date:   Sun, 28 Nov 2021 14:15:09 +0200
Message-Id: <20211128121509.3952-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If CSME is compromised, it could report a bigger queue size
in the share area and make the host perform an out of bound
access.
Instead of reading the size of the queue from the shared area,
store it in the regular context which is not accessible by CSME.

While at it, fix a small typo in an error print.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 112cc362e8e7..4eca333f91b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -119,6 +119,7 @@ struct iwl_sap_shared_mem_ctrl_blk {
 struct iwl_mei_shared_mem_ptrs {
 	struct iwl_sap_shared_mem_ctrl_blk *ctrl;
 	void *q_head[SAP_DIRECTION_MAX][SAP_QUEUE_IDX_MAX];
+	size_t q_size[SAP_DIRECTION_MAX][SAP_QUEUE_IDX_MAX];
 };
 
 struct iwl_mei_filters {
@@ -209,7 +210,7 @@ static void iwl_mei_free_shared_mem(struct mei_cl_device *cldev)
 	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
 
 	if (mei_cldev_dma_unmap(cldev))
-		dev_err(&cldev->dev, "Coudln't unmap the shared mem properly\n");
+		dev_err(&cldev->dev, "Couldn't unmap the shared mem properly\n");
 	memset(&mei->shared_mem, 0, sizeof(mei->shared_mem));
 }
 
@@ -271,6 +272,8 @@ static void iwl_mei_init_shared_mem(struct iwl_mei *mei)
 			mem->q_head[dir][queue] = q_head;
 			q_head +=
 				le32_to_cpu(mem->ctrl->dir[dir].q_ctrl_blk[queue].size);
+			mem->q_size[dir][queue] =
+				le32_to_cpu(mem->ctrl->dir[dir].q_ctrl_blk[queue].size);
 		}
 	}
 
@@ -280,11 +283,11 @@ static void iwl_mei_init_shared_mem(struct iwl_mei *mei)
 static ssize_t iwl_mei_write_cyclic_buf(struct mei_cl_device *cldev,
 					struct iwl_sap_q_ctrl_blk *notif_q,
 					u8 *q_head,
-					const struct iwl_sap_hdr *hdr)
+					const struct iwl_sap_hdr *hdr,
+					u32 q_sz)
 {
 	u32 rd = le32_to_cpu(READ_ONCE(notif_q->rd_ptr));
 	u32 wr = le32_to_cpu(READ_ONCE(notif_q->wr_ptr));
-	u32 q_sz = le32_to_cpu(notif_q->size);
 	size_t room_in_buf;
 	size_t tx_sz = sizeof(*hdr) + le16_to_cpu(hdr->len);
 
@@ -382,6 +385,7 @@ static int iwl_mei_send_sap_msg_payload(struct mei_cl_device *cldev,
 	struct iwl_sap_q_ctrl_blk *notif_q;
 	struct iwl_sap_dir *dir;
 	void *q_head;
+	u32 q_sz;
 	int ret;
 
 	lockdep_assert_held(&iwl_mei_mutex);
@@ -404,7 +408,8 @@ static int iwl_mei_send_sap_msg_payload(struct mei_cl_device *cldev,
 	dir = &mei->shared_mem.ctrl->dir[SAP_DIRECTION_HOST_TO_ME];
 	notif_q = &dir->q_ctrl_blk[SAP_QUEUE_IDX_NOTIF];
 	q_head = mei->shared_mem.q_head[SAP_DIRECTION_HOST_TO_ME][SAP_QUEUE_IDX_NOTIF];
-	ret = iwl_mei_write_cyclic_buf(q_head, notif_q, q_head, hdr);
+	q_sz = mei->shared_mem.q_size[SAP_DIRECTION_HOST_TO_ME][SAP_QUEUE_IDX_NOTIF];
+	ret = iwl_mei_write_cyclic_buf(q_head, notif_q, q_head, hdr, q_sz);
 
 	if (ret < 0)
 		return ret;
@@ -454,10 +459,10 @@ void iwl_mei_add_data_to_ring(struct sk_buff *skb, bool cb_tx)
 	dir = &mei->shared_mem.ctrl->dir[SAP_DIRECTION_HOST_TO_ME];
 	notif_q = &dir->q_ctrl_blk[SAP_QUEUE_IDX_DATA];
 	q_head = mei->shared_mem.q_head[SAP_DIRECTION_HOST_TO_ME][SAP_QUEUE_IDX_DATA];
+	q_sz = mei->shared_mem.q_size[SAP_DIRECTION_HOST_TO_ME][SAP_QUEUE_IDX_DATA];
 
 	rd = le32_to_cpu(READ_ONCE(notif_q->rd_ptr));
 	wr = le32_to_cpu(READ_ONCE(notif_q->wr_ptr));
-	q_sz = le32_to_cpu(notif_q->size);
 	hdr_sz = cb_tx ? sizeof(struct iwl_sap_cb_data) :
 			 sizeof(struct iwl_sap_hdr);
 	tx_sz = skb->len + hdr_sz;
@@ -1074,11 +1079,11 @@ static void iwl_mei_handle_sap_rx_cmd(struct mei_cl_device *cldev,
 static void iwl_mei_handle_sap_rx(struct mei_cl_device *cldev,
 				  struct iwl_sap_q_ctrl_blk *notif_q,
 				  const u8 *q_head,
-				  struct sk_buff_head *skbs)
+				  struct sk_buff_head *skbs,
+				  u32 q_sz)
 {
 	u32 rd = le32_to_cpu(READ_ONCE(notif_q->rd_ptr));
 	u32 wr = le32_to_cpu(READ_ONCE(notif_q->wr_ptr));
-	u32 q_sz = le32_to_cpu(notif_q->size);
 	ssize_t valid_rx_sz;
 
 	if (rd > q_sz || wr > q_sz) {
@@ -1110,6 +1115,7 @@ static void iwl_mei_handle_check_shared_area(struct mei_cl_device *cldev)
 	struct sk_buff_head tx_skbs;
 	struct iwl_sap_dir *dir;
 	void *q_head;
+	u32 q_sz;
 
 	if (!mei->shared_mem.ctrl)
 		return;
@@ -1117,22 +1123,24 @@ static void iwl_mei_handle_check_shared_area(struct mei_cl_device *cldev)
 	dir = &mei->shared_mem.ctrl->dir[SAP_DIRECTION_ME_TO_HOST];
 	notif_q = &dir->q_ctrl_blk[SAP_QUEUE_IDX_NOTIF];
 	q_head = mei->shared_mem.q_head[SAP_DIRECTION_ME_TO_HOST][SAP_QUEUE_IDX_NOTIF];
+	q_sz = mei->shared_mem.q_size[SAP_DIRECTION_ME_TO_HOST][SAP_QUEUE_IDX_NOTIF];
 
 	/*
 	 * Do not hold the mutex here, but rather each and every message
 	 * handler takes it.
 	 * This allows message handlers to take it at a certain time.
 	 */
-	iwl_mei_handle_sap_rx(cldev, notif_q, q_head, NULL);
+	iwl_mei_handle_sap_rx(cldev, notif_q, q_head, NULL, q_sz);
 
 	mutex_lock(&iwl_mei_mutex);
 	dir = &mei->shared_mem.ctrl->dir[SAP_DIRECTION_ME_TO_HOST];
 	notif_q = &dir->q_ctrl_blk[SAP_QUEUE_IDX_DATA];
 	q_head = mei->shared_mem.q_head[SAP_DIRECTION_ME_TO_HOST][SAP_QUEUE_IDX_DATA];
+	q_sz = mei->shared_mem.q_size[SAP_DIRECTION_ME_TO_HOST][SAP_QUEUE_IDX_DATA];
 
 	__skb_queue_head_init(&tx_skbs);
 
-	iwl_mei_handle_sap_rx(cldev, notif_q, q_head, &tx_skbs);
+	iwl_mei_handle_sap_rx(cldev, notif_q, q_head, &tx_skbs, q_sz);
 
 	if (skb_queue_empty(&tx_skbs)) {
 		mutex_unlock(&iwl_mei_mutex);
-- 
2.25.1

