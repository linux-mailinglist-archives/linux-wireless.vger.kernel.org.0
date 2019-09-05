Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25731A9FDC
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbfIEKiw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 06:38:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37826 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732466AbfIEKiv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 06:38:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA40561194; Thu,  5 Sep 2019 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567679930;
        bh=ld1eX5mvbjvbUjx/d4phNpbv0HhspUohlfIABRC03GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQ8V2YIdUfiXlE6VWIpUQsBymxqn+spiHpl5cQHZ2e4Oy+xTbUy/3qYQ9wLnmkAVV
         PSo9FEKitvGc6xqbOQVRjJZa1FgZz3iZEuh6F4b0IvidOHKaIJ7MifH0cfkO+U+zC9
         qt+JSNhdELeAT0Vjcn1c9m8Ve+/xF9dhcngArYck=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C9826115D;
        Thu,  5 Sep 2019 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567679930;
        bh=ld1eX5mvbjvbUjx/d4phNpbv0HhspUohlfIABRC03GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQ8V2YIdUfiXlE6VWIpUQsBymxqn+spiHpl5cQHZ2e4Oy+xTbUy/3qYQ9wLnmkAVV
         PSo9FEKitvGc6xqbOQVRjJZa1FgZz3iZEuh6F4b0IvidOHKaIJ7MifH0cfkO+U+zC9
         qt+JSNhdELeAT0Vjcn1c9m8Ve+/xF9dhcngArYck=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C9826115D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v5 3/8] ath10k: change max RX bundle size from 8 to 32 for sdio
Date:   Thu,  5 Sep 2019 18:38:08 +0800
Message-Id: <1567679893-14029-4-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The max bundle size support by firmware is 32, change it from 8 to 32
will help performance. This results in significant performance
improvement on RX path.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: change macro HTC_GET_BUNDLE_COUNT
v3: change some code style
v4: add macro ATH10K_HTC_FLAG_BUNDLE_MASK
v5: no change
 drivers/net/wireless/ath/ath10k/htc.h  | 12 +++++++++---
 drivers/net/wireless/ath/ath10k/sdio.c |  6 +++---
 drivers/net/wireless/ath/ath10k/sdio.h |  4 ++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index f55d3ca..7055156 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -39,7 +39,7 @@
  * 4-byte aligned.
  */
 
-#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        8
+#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        32
 
 enum ath10k_htc_tx_flags {
 	ATH10K_HTC_FLAG_NEED_CREDIT_UPDATE = 0x01,
@@ -48,10 +48,16 @@ enum ath10k_htc_tx_flags {
 
 enum ath10k_htc_rx_flags {
 	ATH10K_HTC_FLAGS_RECV_1MORE_BLOCK = 0x01,
-	ATH10K_HTC_FLAG_TRAILER_PRESENT = 0x02,
-	ATH10K_HTC_FLAG_BUNDLE_MASK     = 0xF0
+	ATH10K_HTC_FLAG_TRAILER_PRESENT = 0x02
 };
 
+#define ATH10K_HTC_FLAG_BUNDLE_MASK 0xF0
+#define ATH10K_HTC_BUNDLE_EXTRA_MASK GENMASK(3, 2)
+
+#define ATH10K_HTC_GET_BUNDLE_COUNT(flags) \
+	    (FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, (flags)) +  \
+	    (FIELD_GET(ATH10K_HTC_BUNDLE_EXTRA_MASK, (flags)) << 4))
+
 struct ath10k_htc_hdr {
 	u8 eid; /* @enum ath10k_htc_ep_id */
 	u8 flags; /* @enum ath10k_htc_tx_flags, ath10k_htc_rx_flags */
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index d7ffcd5..714b0b1 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -24,8 +24,8 @@
 #include "trace.h"
 #include "sdio.h"
 
-#define ATH10K_SDIO_DMA_BUF_SIZE	(32 * 1024)
-#define ATH10K_SDIO_VSG_BUF_SIZE	(32 * 1024)
+#define ATH10K_SDIO_DMA_BUF_SIZE	(64 * 1024)
+#define ATH10K_SDIO_VSG_BUF_SIZE	(64 * 1024)
 
 /* inlined helper functions */
 
@@ -495,7 +495,7 @@ static int ath10k_sdio_mbox_alloc_bundle(struct ath10k *ar,
 {
 	int ret, i;
 
-	*bndl_cnt = FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, htc_hdr->flags);
+	*bndl_cnt = ATH10K_HTC_GET_BUNDLE_COUNT(htc_hdr->flags);
 
 	if (*bndl_cnt > HTC_HOST_MAX_MSG_PER_RX_BUNDLE) {
 		ath10k_warn(ar,
diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
index 4896eca..3ca76c7 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.h
+++ b/drivers/net/wireless/ath/ath10k/sdio.h
@@ -89,10 +89,10 @@
  * to the maximum value (HTC_HOST_MAX_MSG_PER_RX_BUNDLE).
  *
  * in this case the driver must allocate
- * (HTC_HOST_MAX_MSG_PER_RX_BUNDLE * HTC_HOST_MAX_MSG_PER_RX_BUNDLE) skb's.
+ * (HTC_HOST_MAX_MSG_PER_RX_BUNDLE * 2) skb's.
  */
 #define ATH10K_SDIO_MAX_RX_MSGS \
-	(HTC_HOST_MAX_MSG_PER_RX_BUNDLE * HTC_HOST_MAX_MSG_PER_RX_BUNDLE)
+	(HTC_HOST_MAX_MSG_PER_RX_BUNDLE * 2)
 
 #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL   0x00000868u
 #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL_DISABLE_SLEEP_OFF 0xFFFEFFFF
-- 
1.9.1

