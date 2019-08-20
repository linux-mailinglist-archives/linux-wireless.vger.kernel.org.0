Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71FA095DEF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 13:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfHTLz2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 07:55:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49230 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbfHTLz2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 07:55:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B814F60A4E; Tue, 20 Aug 2019 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566302127;
        bh=tUpg8TmQmSrgjnvR9tb1NUbLLZ9mDMZgQ7+e6Vditgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwYH/daXH1hw9DGAxp3N1KJvbB8jmUwNmh7Y42AG9kvNFyziVd++XP3lRD1tfL5BS
         kHHDhQMaCkgsNMHs1HevczKQ8o1hXrdrJmBbhJinb1YjPnHvi6cPpkIDPKODQlo/pE
         7sKTUUfnesmH0Hzc6dCiPppikb6IgGP0bfnOhzzI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54AE0608CC;
        Tue, 20 Aug 2019 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566302127;
        bh=tUpg8TmQmSrgjnvR9tb1NUbLLZ9mDMZgQ7+e6Vditgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwYH/daXH1hw9DGAxp3N1KJvbB8jmUwNmh7Y42AG9kvNFyziVd++XP3lRD1tfL5BS
         kHHDhQMaCkgsNMHs1HevczKQ8o1hXrdrJmBbhJinb1YjPnHvi6cPpkIDPKODQlo/pE
         7sKTUUfnesmH0Hzc6dCiPppikb6IgGP0bfnOhzzI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54AE0608CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Date:   Tue, 20 Aug 2019 19:55:03 +0800
Message-Id: <1566302108-18219-3-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
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
 drivers/net/wireless/ath/ath10k/htc.h  | 2 +-
 drivers/net/wireless/ath/ath10k/sdio.c | 5 +++--
 drivers/net/wireless/ath/ath10k/sdio.h | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index f55d3ca..8c79b9e 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -39,7 +39,7 @@
  * 4-byte aligned.
  */
 
-#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        8
+#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        32
 
 enum ath10k_htc_tx_flags {
 	ATH10K_HTC_FLAG_NEED_CREDIT_UPDATE = 0x01,
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index d9395f0..baa6051 100644
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
 
@@ -501,6 +501,7 @@ static int ath10k_sdio_mbox_alloc_bundle(struct ath10k *ar,
 	int ret, i;
 
 	*bndl_cnt = FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, htc_hdr->flags);
+	*bndl_cnt += (FIELD_GET(GENMASK(3, 2), htc_hdr->flags) << 4);
 
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

