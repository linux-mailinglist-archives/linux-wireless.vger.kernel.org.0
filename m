Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433ED665761
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 10:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbjAKJ1P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 04:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbjAKJ01 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 04:26:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C4202D
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 01:25:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21272B81AD7
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 09:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0009FC433D2;
        Wed, 11 Jan 2023 09:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673429154;
        bh=yPbKVKAGApGaOsxSfqbfmPNFgWvzf0UqkFIDaNWkG9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=syTnEIHqiDQNrCQZrO9DTCIz/3TldRj6VsQecJVbcNQUXOykI9q+5VyB6bRQ09aZd
         C9oU2FSdzbuF73DXixInWzW2pPhyCKSFC92AfQuE9yF/L5KSlr0fogfKBvoWhPBE3j
         GqgrjBHgcifLIkKwJ5s0dwagS5DQozxLKq315KZ+7IMff5xfNwkcfRqGdT1Ks/3Bhe
         MjxhTlWjXD1RXBjZg7dv2lltfUiBZxl0kmIJPb4798v8bu6EG9t1wR9IE3U3apOWtu
         SuNGPa+SglWA+2pInPDaKZD/sACykXZ2JSJ8VkFQTdjD69Vdf/LCoC/Yon2VHvm/sM
         obWIoVSGdyRAA==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] ath11k: qmi: refactor ath11k_qmi_m3_load()
Date:   Wed, 11 Jan 2023 11:25:46 +0200
Message-Id: <20230111092547.21425-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111092547.21425-1-kvalo@kernel.org>
References: <20230111092547.21425-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Simple refactoring to make it easier to add firmware-2.bin support in the
following patch.

Earlier ath11k_qmi_m3_load() supported changing m3.bin contents while ath11k is
running. But that's not going to actually work, m3.bin is supposed to the be
same during the lifetime of ath11k, for example we don't support changing the
firmware capabilities on the fly. Due to this ath11k requests m3.bin firmware
file first and only then checks m3_mem->vaddr, so we are basically requesting
the firmware file even if it's not needed. Reverse the code so that m3_mem
buffer is checked first, and only if it doesn't exist, then m3.bin is requested
from user space.

Checking for m3_mem->size is redundant when m3_mem->vaddr is NULL, we would
not be able to use the buffer in that case. So remove the check for size.

Simplify the exit handling and use 'goto out'.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index ab923e24b0a9..5bc98180aed4 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2493,6 +2493,10 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
 	char path[100];
 	int ret;
 
+	if (m3_mem->vaddr)
+		/* m3 firmware buffer is already available in the DMA buffer */
+		return 0;
+
 	fw = ath11k_core_firmware_request(ab, ATH11K_M3_FILE);
 	if (IS_ERR(fw)) {
 		ret = PTR_ERR(fw);
@@ -2502,25 +2506,25 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
 		return ret;
 	}
 
-	if (m3_mem->vaddr || m3_mem->size)
-		goto skip_m3_alloc;
-
 	m3_mem->vaddr = dma_alloc_coherent(ab->dev,
 					   fw->size, &m3_mem->paddr,
 					   GFP_KERNEL);
 	if (!m3_mem->vaddr) {
 		ath11k_err(ab, "failed to allocate memory for M3 with size %zu\n",
 			   fw->size);
-		release_firmware(fw);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
-skip_m3_alloc:
 	memcpy(m3_mem->vaddr, fw->data, fw->size);
 	m3_mem->size = fw->size;
+
+	ret = 0;
+
+out:
 	release_firmware(fw);
 
-	return 0;
+	return ret;
 }
 
 static void ath11k_qmi_m3_free(struct ath11k_base *ab)
-- 
2.30.2

