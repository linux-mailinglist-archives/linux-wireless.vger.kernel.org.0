Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2034D12490A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLROGC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:06:02 -0500
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:4869 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfLROGC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:06:02 -0500
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 18 Dec 2019 14:59:55 +0100
Received: from lx-merez2.mea.qualcomm.com ([10.18.173.102])
  by ironmsg03-ams.qualcomm.com with ESMTP; 18 Dec 2019 14:59:53 +0100
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Dedy Lansky <dlansky@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 6/8] wil6210: fix MID valid bits in Rx status message
Date:   Wed, 18 Dec 2019 15:59:45 +0200
Message-Id: <20191218135947.5903-7-merez@codeaurora.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218135947.5903-1-merez@codeaurora.org>
References: <20191218135947.5903-1-merez@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dedy Lansky <dlansky@codeaurora.org>

Fix incorrect definitions of MAC ID bits inside Rx status message.

Signed-off-by: Dedy Lansky <dlansky@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/txrx_edma.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.h b/drivers/net/wireless/ath/wil6210/txrx_edma.h
index c744c65225da..c736f7413a35 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.h
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.h
@@ -46,7 +46,7 @@
 
 #define WIL_RX_EDMA_DLPF_LU_MISS_TID_POS	5
 
-#define WIL_RX_EDMA_MID_VALID_BIT		BIT(22)
+#define WIL_RX_EDMA_MID_VALID_BIT		BIT(20)
 
 #define WIL_EDMA_DESC_TX_MAC_CFG_0_QID_POS 16
 #define WIL_EDMA_DESC_TX_MAC_CFG_0_QID_LEN 6
@@ -244,8 +244,8 @@ struct wil_ring_tx_status {
  *		     calculated, Bit1- L4Err - TCP/UDP Checksum Error
  *	bit      7 : Reserved:1
  *	bit  8..19 : Flow ID:12 - MSDU flow ID
- *	bit 20..21 : MID:2 - The MAC ID
- *	bit     22 : MID_V:1 - The MAC ID field is valid
+ *	bit     20 : MID_V:1 - The MAC ID field is valid
+ *	bit 21..22 : MID:2 - The MAC ID
  *	bit     23 : L3T:1 - IP types: 0-IPv6, 1-IPv4
  *	bit     24 : L4T:1 - Layer 4 Type: 0-UDP, 1-TCP
  *	bit     25 : BC:1 - The received MPDU is broadcast
@@ -479,7 +479,7 @@ static inline int wil_rx_status_get_mid(void *msg)
 		return 0; /* use the default MID */
 
 	return WIL_GET_BITS(((struct wil_rx_status_compressed *)msg)->d0,
-			    20, 21);
+			    21, 22);
 }
 
 static inline int wil_rx_status_get_error(void *msg)
-- 
2.23.0

