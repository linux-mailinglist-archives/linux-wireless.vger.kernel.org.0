Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6D69F92A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 17:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjBVQk0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 11:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjBVQkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 11:40:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB18B367F0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 08:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8306149A
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 16:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30514C433EF;
        Wed, 22 Feb 2023 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677084016;
        bh=Cq5LJA51WZMVZRD+6jr03EpdMGj/1bo1DYkBpIiNA9o=;
        h=From:To:Cc:Subject:Date:From;
        b=c5y0rKj7bsPD2J77uL3PPZe9c2tCU58PBGI25U3vjN2hovtM31xSAqNc3fVFCsQk4
         NgBdS/XLI+DkaJC24TC5/zNut4DK39LCX+sh3x4tH5UoYYdHSbdy0NXvLE6yV/IBgo
         Yc//bO12ewrlzCfF+dN2AKLAl8JpOG1u4i8Jy6D+dOy/lqM7/pbAiFTghAH64/Li9i
         qMsuCam5fOGQVcYmTjGOKi65JCm9tj3Ck35HR5Q3ViYZ5/C+bCNIUKsvq+yHbhDWaL
         e9xtHKf/aKUhc8C2mCJbMnKQJczQoKEbRP7AyJlOQbyTyI827nquJPvpke09twI9Fi
         s7hWyDiaVrzqQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: remove memset with byte count of 278528
Date:   Wed, 22 Feb 2023 18:40:14 +0200
Message-Id: <20230222164014.860-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
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

Sparse warns:

drivers/net/wireless/ath/ath12k/dp.c:1471:15: warning: memset with byte count of 278528

There's no need to use memset() here, instead call dma_alloc_coherent() with __GFP_ZERO.

While at it, remove an extra line before the error handler.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 9926d81c5fe4..ae1645d0f42a 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1461,15 +1461,12 @@ static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 	dp->reoq_lut.vaddr = dma_alloc_coherent(ab->dev,
 						DP_REOQ_LUT_SIZE,
 						&dp->reoq_lut.paddr,
-						GFP_KERNEL);
-
+						GFP_KERNEL | __GFP_ZERO);
 	if (!dp->reoq_lut.vaddr) {
 		ath12k_warn(ab, "failed to allocate memory for reoq table");
 		return -ENOMEM;
 	}
 
-	memset(dp->reoq_lut.vaddr, 0, DP_REOQ_LUT_SIZE);
-
 	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE0(ab),
 			   dp->reoq_lut.paddr);
 	return 0;

base-commit: 5aa9ff08c0b71be15a607341fa5344546e19ceb2
-- 
2.30.2

