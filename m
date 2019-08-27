Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5EF9E663
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 13:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfH0LCn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 07:02:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49954 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfH0LCm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 07:02:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2CACD61CAE; Tue, 27 Aug 2019 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566903761;
        bh=vd0RTaYYfBKa1FaQDgVuXPzggY28jmRtCE8XaakNWtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSsn0HBcfg0oDoDyqq3A74HBgFZqaRTfq/IucDtC2GB+fn63AcWcUsgZr3Q1nUDF2
         Z4TqU6Teg7hthU3rZfVuLSh5wSHNLVktXTqKAZQWESQSRbGwPYGPq44VLan3Dj47H6
         Si3h+olzAal0e/pxblDXsw2wyvbirxp8Z4lTtRCQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AEAFE61C35;
        Tue, 27 Aug 2019 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566903738;
        bh=vd0RTaYYfBKa1FaQDgVuXPzggY28jmRtCE8XaakNWtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxMt0tOb5w4ZwIk8vsVsLoQGfbZ48vENb+CHX82obu4ZkmMK2v9dVMMVlmWzv6PpE
         /zEkCVVSUVbjVOs98U78gdaJEvRut13fSOkaKSUttpt9cl/RCyBrQR+p5zh0+KDK8R
         H9uKpr0q6o0c0L6tmI/57UaBUDvZxf7AAcW0xp/4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEAFE61C35
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Date:   Tue, 27 Aug 2019 19:01:42 +0800
Message-Id: <1566903707-27536-3-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
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
 drivers/net/wireless/ath/ath10k/htc.h  | 6 +++++-
 drivers/net/wireless/ath/ath10k/sdio.c | 6 +++---
 drivers/net/wireless/ath/ath10k/sdio.h | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index f55d3ca..8a07da0 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -39,7 +39,7 @@
  * 4-byte aligned.
  */
 
-#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        8
+#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        32
 
 enum ath10k_htc_tx_flags {
 	ATH10K_HTC_FLAG_NEED_CREDIT_UPDATE = 0x01,
@@ -52,6 +52,10 @@ enum ath10k_htc_rx_flags {
 	ATH10K_HTC_FLAG_BUNDLE_MASK     = 0xF0
 };
 
+#define HTC_GET_BUNDLE_COUNT(flags) \
+	    (FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, (flags)) +  \
+	    (FIELD_GET(GENMASK(3, 2), (flags)) << 4))
+
 struct ath10k_htc_hdr {
 	u8 eid; /* @enum ath10k_htc_ep_id */
 	u8 flags; /* @enum ath10k_htc_tx_flags, ath10k_htc_rx_flags */
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index eacb4d5..e5c365e 100644
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
+	*bndl_cnt = HTC_GET_BUNDLE_COUNT(htc_hdr->flags);
 
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

