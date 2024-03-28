Return-Path: <linux-wireless+bounces-5421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390EB88F4F8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 02:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E276E1F2D8BC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 01:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5065124A06;
	Thu, 28 Mar 2024 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YkDne85H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A124B34;
	Thu, 28 Mar 2024 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590927; cv=none; b=Li5s/GB18OvLC8ZMb76ymGp8CSWYbPOPosDFqd5cd6+xlreFgiwKi4XUqsyNgLP4rQTfBT/iHz0NOZxjXSYOiwbaXDcRJmDKNKCOUzlLv5BF95wUhEPdutVjXdad/GrTse6XIg0oXZc+oTYPWU1SorViI7dI9a2Dvw30SHL5Ln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590927; c=relaxed/simple;
	bh=IETo2efBbzGICHkTqHFtKCELfkAub+cYw2cmythX2Po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W5mAF8Y5W9UfZpKhtjx6noRwhIC/ahf5NlvQotvg9RcqFUsuLxDymNahp2NISpo57eEWtGq5eF168op+QLmqy5gDpyEaSY5HWScfBknatI8kTa4qPi1ZSZgZ9lgIBNvNPRZ+CMSIO6unVByGhezvlg0seEmjiK+K/KDq1HLAxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YkDne85H; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [222.129.33.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C528D4459A;
	Thu, 28 Mar 2024 01:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711590923;
	bh=qpSGpDBVaMWfsCfDS3yMWR+WBH1fbjGdQxPfbs0PY9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=YkDne85HBVbCg5u3fif4owMpojFWIMsih6daP9g2LtviVHHSdrLZnNnPKHR1k0mEl
	 sH8PiwWNixaQse3t3TTsiemAJ6dlqoyj3pRfBRhMKYs1Iz4VhHu0I+L6uYceWzexJy
	 WK330P37q7OszjLbJQ2IVQyCg9X7JNOJuXjMROfMGs4IZzs5GsM0FbWrScPO6/Mtw3
	 VhfBxgZ4c8dhQuTlNMZJ7PQHoNwcn3cQk9KRWzvGkyVjFr5jS4zWlp84tmw8/qWuRq
	 ziso0W7QdiSUXptpEN86lyQCQtZc76zgFGyA91js7ml669iCuFYE4FJCsv6jJNGufe
	 NBzxGdvKHUcqQ==
From: Aaron Ma <aaron.ma@canonical.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregory.greenman@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH 6.6 1/1] wifi: iwlwifi: pcie: fix RB status reading
Date: Thu, 28 Mar 2024 09:54:02 +0800
Message-Id: <20240328015402.114435-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240328015402.114435-1-aaron.ma@canonical.com>
References: <20240328015402.114435-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 9f9797c7de18d2ec6be4ef6e0abbaea585040b39 ]

On newer hardware, a queue's RB status / write pointer
can be bigger than 4095 (0xFFF), so we cannot mask the
value by 0xFFF unconditionally. Since anyway that's
only necessary on older hardware, move the masking to
the helper function and apply it only for older HW.
This also moves the endian conversion in to handle it
more easily.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230830112059.7be2a3fff6f4.I94f11dee314a4f7c1941d2d223936b1fa8aa9ee4@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Cc: stable@vger.kernel.org # 6.6.y
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 12 ++++--------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 5602441df2b7e..8408e4ddddedd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -190,17 +190,17 @@ struct iwl_rb_allocator {
  * iwl_get_closed_rb_stts - get closed rb stts from different structs
  * @rxq - the rxq to get the rb stts from
  */
-static inline __le16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
-					    struct iwl_rxq *rxq)
+static inline u16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
+					 struct iwl_rxq *rxq)
 {
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		__le16 *rb_stts = rxq->rb_stts;
 
-		return READ_ONCE(*rb_stts);
+		return le16_to_cpu(READ_ONCE(*rb_stts));
 	} else {
 		struct iwl_rb_status *rb_stts = rxq->rb_stts;
 
-		return READ_ONCE(rb_stts->closed_rb_num);
+		return le16_to_cpu(READ_ONCE(rb_stts->closed_rb_num)) & 0xFFF;
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 63091c45a576d..be9b5a19e2a7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1510,7 +1510,7 @@ static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget)
 	spin_lock(&rxq->lock);
 	/* uCode's read index (stored in shared DRAM) indicates the last Rx
 	 * buffer that the driver may process (last buffer filled by ucode). */
-	r = le16_to_cpu(iwl_get_closed_rb_stts(trans, rxq)) & 0x0FFF;
+	r = iwl_get_closed_rb_stts(trans, rxq);
 	i = rxq->read;
 
 	/* W/A 9000 device step A0 wrap-around bug */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 1bc4a0089c6ff..e9807fcca6ad1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2714,11 +2714,9 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 		pos += scnprintf(buf + pos, bufsz - pos, "\tfree_count: %u\n",
 				 rxq->free_count);
 		if (rxq->rb_stts) {
-			u32 r =	__le16_to_cpu(iwl_get_closed_rb_stts(trans,
-								     rxq));
+			u32 r =	iwl_get_closed_rb_stts(trans, rxq);
 			pos += scnprintf(buf + pos, bufsz - pos,
-					 "\tclosed_rb_num: %u\n",
-					 r & 0x0FFF);
+					 "\tclosed_rb_num: %u\n", r);
 		} else {
 			pos += scnprintf(buf + pos, bufsz - pos,
 					 "\tclosed_rb_num: Not Allocated\n");
@@ -3091,7 +3089,7 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 
 	spin_lock_bh(&rxq->lock);
 
-	r = le16_to_cpu(iwl_get_closed_rb_stts(trans, rxq)) & 0x0FFF;
+	r = iwl_get_closed_rb_stts(trans, rxq);
 
 	for (i = rxq->read, j = 0;
 	     i != r && j < allocated_rb_nums;
@@ -3387,9 +3385,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans,
 		/* Dump RBs is supported only for pre-9000 devices (1 queue) */
 		struct iwl_rxq *rxq = &trans_pcie->rxq[0];
 		/* RBs */
-		num_rbs =
-			le16_to_cpu(iwl_get_closed_rb_stts(trans, rxq))
-			& 0x0FFF;
+		num_rbs = iwl_get_closed_rb_stts(trans, rxq);
 		num_rbs = (num_rbs - rxq->read) & RX_QUEUE_MASK;
 		len += num_rbs * (sizeof(*data) +
 				  sizeof(struct iwl_fw_error_dump_rb) +
-- 
2.34.1


