Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A69473A4
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfFPHdv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:33:51 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:59666 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfFPHdv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:33:51 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 16 Jun 2019 09:26:14 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9289"; a="8499833"
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg02-ams.qualcomm.com with ESMTP; 16 Jun 2019 09:26:11 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 03/11] wil6210: increase the frequency of status ring hw tail update
Date:   Sun, 16 Jun 2019 10:25:59 +0300
Message-Id: <1560669967-23706-4-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
References: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ahmad Masri <amasri@codeaurora.org>

The driver updates Tx status ring HW tail only after it finishes
processing the whole status ring, while the HW is still transmitting
from other transmit rings. This can cause back-pressure on HW if
no status entries are available.

Update HW tail of Tx status ring without waiting for the end of the
processing to help feeding back the HW with status entries and to allow
additional packet transmission.

Signed-off-by: Ahmad Masri <amasri@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/txrx_edma.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 6140db5..dc040cd 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -26,6 +26,10 @@
 #include "txrx.h"
 #include "trace.h"
 
+/* Max number of entries (packets to complete) to update the hwtail of tx
+ * status ring. Should be power of 2
+ */
+#define WIL_EDMA_TX_SRING_UPDATE_HW_TAIL 128
 #define WIL_EDMA_MAX_DATA_OFFSET (2)
 /* RX buffer size must be aligned to 4 bytes */
 #define WIL_EDMA_RX_BUF_LEN_DEFAULT (2048)
@@ -1155,7 +1159,7 @@ int wil_tx_sring_handler(struct wil6210_priv *wil,
 	struct wil_net_stats *stats;
 	struct wil_tx_enhanced_desc *_d;
 	unsigned int ring_id;
-	unsigned int num_descs;
+	unsigned int num_descs, num_statuses = 0;
 	int i;
 	u8 dr_bit; /* Descriptor Ready bit */
 	struct wil_ring_tx_status msg;
@@ -1276,6 +1280,11 @@ int wil_tx_sring_handler(struct wil6210_priv *wil,
 		}
 
 again:
+		num_statuses++;
+		if (num_statuses % WIL_EDMA_TX_SRING_UPDATE_HW_TAIL == 0)
+			/* update HW tail to allow HW to push new statuses */
+			wil_w(wil, sring->hwtail, sring->swhead);
+
 		wil_sring_advance_swhead(sring);
 
 		wil_get_next_tx_status_msg(sring, &msg);
@@ -1286,8 +1295,9 @@ int wil_tx_sring_handler(struct wil6210_priv *wil,
 	if (desc_cnt)
 		wil_update_net_queues(wil, vif, NULL, false);
 
-	/* Update the HW tail ptr (RD ptr) */
-	wil_w(wil, sring->hwtail, (sring->swhead - 1) % sring->size);
+	if (num_statuses % WIL_EDMA_TX_SRING_UPDATE_HW_TAIL != 0)
+		/* Update the HW tail ptr (RD ptr) */
+		wil_w(wil, sring->hwtail, (sring->swhead - 1) % sring->size);
 
 	return desc_cnt;
 }
-- 
1.9.1

