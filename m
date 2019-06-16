Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02404473A0
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfFPHcy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:32:54 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:36278 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbfFPHcy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:32:54 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 16 Jun 2019 09:26:15 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9289"; a="8499832"
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg02-ams.qualcomm.com with ESMTP; 16 Jun 2019 09:26:11 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 02/11] wil6210: enlarge Tx status ring size
Date:   Sun, 16 Jun 2019 10:25:58 +0300
Message-Id: <1560669967-23706-3-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
References: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ahmad Masri <amasri@codeaurora.org>

With multiple clients and in high throughput scenarios, Tx status ring
can get full and become a bottleneck in Tx transmission.
Set the default Tx status ring size order to 13, previous value was 12.
This will double the status ring size from 4K entries to 8K entries.

Signed-off-by: Ahmad Masri <amasri@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/txrx_edma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.h b/drivers/net/wireless/ath/wil6210/txrx_edma.h
index bb4ff28..e9e6ea9 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.h
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.h
@@ -24,7 +24,7 @@
 #define WIL_SRING_SIZE_ORDER_MAX	(WIL_RING_SIZE_ORDER_MAX)
 /* RX sring order should be bigger than RX ring order */
 #define WIL_RX_SRING_SIZE_ORDER_DEFAULT	(12)
-#define WIL_TX_SRING_SIZE_ORDER_DEFAULT	(12)
+#define WIL_TX_SRING_SIZE_ORDER_DEFAULT	(14)
 #define WIL_RX_BUFF_ARR_SIZE_DEFAULT (2600)
 
 #define WIL_DEFAULT_RX_STATUS_RING_ID 0
-- 
1.9.1

