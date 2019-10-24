Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 939FBE2DF3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 11:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393100AbfJXJyO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 05:54:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJXJyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 05:54:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DAD6261065; Thu, 24 Oct 2019 09:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571910853;
        bh=9Wf6RMnyINCUk3PS0SF0QPwLRWMMNoeboD9LOGpLDdM=;
        h=From:To:Cc:Subject:Date:From;
        b=YbcmWlSOb3aa9nilL0ojgIj17QZr4zXBLtKz0HzjlQlCBwkE1dxUeURnv2JhojK3w
         cK1y/qK3WdpWzLOTUAQB4AKLrUVsH1CI2wYRT1vg1xDW1GPenb0m2ng9A7wnox1/qu
         B9mhbznlqg1NE5DNDXfHLMf4BH96H3AP+SHpWDFU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 907EB60FBB;
        Thu, 24 Oct 2019 09:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571910853;
        bh=9Wf6RMnyINCUk3PS0SF0QPwLRWMMNoeboD9LOGpLDdM=;
        h=From:To:Cc:Subject:Date:From;
        b=YbcmWlSOb3aa9nilL0ojgIj17QZr4zXBLtKz0HzjlQlCBwkE1dxUeURnv2JhojK3w
         cK1y/qK3WdpWzLOTUAQB4AKLrUVsH1CI2wYRT1vg1xDW1GPenb0m2ng9A7wnox1/qu
         B9mhbznlqg1NE5DNDXfHLMf4BH96H3AP+SHpWDFU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 907EB60FBB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] ath10k: cosmetic cleanup to sdio files
Date:   Thu, 24 Oct 2019 12:54:08 +0300
Message-Id: <1571910849-11489-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do some cosmetic cleanup while reviewing the files. No functional changes.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index c34637881219..ef16b45c18da 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -541,10 +541,8 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 	int pkt_cnt = 0;
 
 	if (n_lookaheads > ATH10K_SDIO_MAX_RX_MSGS) {
-		ath10k_warn(ar,
-			    "the total number of pkgs to be fetched (%u) exceeds maximum %u\n",
-			    n_lookaheads,
-			    ATH10K_SDIO_MAX_RX_MSGS);
+		ath10k_warn(ar, "the total number of pkgs to be fetched (%u) exceeds maximum %u\n",
+			    n_lookaheads, ATH10K_SDIO_MAX_RX_MSGS);
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -553,10 +551,8 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 		htc_hdr = (struct ath10k_htc_hdr *)&lookaheads[i];
 		last_in_bundle = false;
 
-		if (le16_to_cpu(htc_hdr->len) >
-		    ATH10K_HTC_MBOX_MAX_PAYLOAD_LENGTH) {
-			ath10k_warn(ar,
-				    "payload length %d exceeds max htc length: %zu\n",
+		if (le16_to_cpu(htc_hdr->len) > ATH10K_HTC_MBOX_MAX_PAYLOAD_LENGTH) {
+			ath10k_warn(ar, "payload length %d exceeds max htc length: %zu\n",
 				    le16_to_cpu(htc_hdr->len),
 				    ATH10K_HTC_MBOX_MAX_PAYLOAD_LENGTH);
 			ret = -ENOMEM;
@@ -567,8 +563,7 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 		full_len = ath10k_sdio_calc_txrx_padded_len(ar_sdio, act_len);
 
 		if (full_len > ATH10K_SDIO_MAX_BUFFER_SIZE) {
-			ath10k_warn(ar,
-				    "rx buffer requested with invalid htc_hdr length (%d, 0x%x): %d\n",
+			ath10k_warn(ar, "rx buffer requested with invalid htc_hdr length (%d, 0x%x): %d\n",
 				    htc_hdr->eid, htc_hdr->flags,
 				    le16_to_cpu(htc_hdr->len));
 			ret = -EINVAL;
@@ -590,12 +585,14 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 							    &bndl_cnt);
 
 			if (ret) {
-				ath10k_warn(ar, "alloc_bundle error %d\n", ret);
+				ath10k_warn(ar, "failed to allocate a bundle: %d\n",
+					    ret);
 				goto err;
 			}
 
 			pkt_cnt += bndl_cnt;
-			/*Next buffer will be the last in the bundle */
+
+			/* next buffer will be the last in the bundle */
 			last_in_bundle = true;
 		}
 
-- 
2.7.4

