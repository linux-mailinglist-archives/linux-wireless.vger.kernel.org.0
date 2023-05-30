Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B747163CC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 16:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjE3OVQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 10:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjE3OU2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 10:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F205E1989
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 07:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B7F362BD8
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 14:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9D6C4339B;
        Tue, 30 May 2023 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685456300;
        bh=yPbKVKAGApGaOsxSfqbfmPNFgWvzf0UqkFIDaNWkG9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LB4Dawat89qhNiNWs85PHr+Ar48bcQ3M4g8e3sYRRWE9EI8rZSj4vF7VniZfO18qS
         YZdJPPsecR5tRAqAlFsYdfEFIMxcHy2prBa6OpkIWZ8B6KftMHBvHuegVXcU5H443D
         7BGfAf3c7nA9zwaF6YctEIiu6o39V+Brthx/FeYnhhIllcqYmS6kah16DJ6ZyiAlgo
         XbPp6aJL5KvQI/E2t/Jka5egaFLxzVpb/GP4rjz0MotDPRd3ouKiTy9MoMh406Awzs
         1BY1VqOPWmd1lMg9+jDGQvaAgjivDA8iG/zT33UzbvQWxFh8kX8IiKpyJAJRr+VTT2
         d00+3lU+6PUpA==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH v3 2/3] wifi: ath11k: qmi: refactor ath11k_qmi_m3_load()
Date:   Tue, 30 May 2023 17:18:12 +0300
Message-Id: <20230530141813.29333-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230530141813.29333-1-kvalo@kernel.org>
References: <20230530141813.29333-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

