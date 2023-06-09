Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F200729CCC
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbjFIOZV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbjFIOY4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0588530E5
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D966E6173E
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC149C433EF;
        Fri,  9 Jun 2023 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320694;
        bh=gxf6ePnmTtpWbNVitpX5s+VlzfoKLTljRK7KzeC97Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHtcx2PQJe1lWlUqeq7AqPD5YvOgs77dF12JSQaw5xXjsFWv/qfB/xCTzksEv7Fga
         jCkk8BgMNZTBJ52Im5AGAOCrYqSyRfNCM4P3HnJb8zWW1i5jkLVJyNJfk2LIPA/WTf
         lDwrVOCbRocOpdCm80gpPi9BOWV4x+z4f5ZvrmqG3l3uxseAo0aDMx+ZQECgqenehG
         cz8WAEDfI5/st7CTgKjYzu9NNvVo0jQqKyFmNIECq/DPz7bUT9oN+Guve4+c0WOpkz
         YexH33G9Ikm9wLAwF/bwXBlkzQqI9J+PZfmoDC0ASwPrHGYWIdYIKqGVXLvjfPSjQN
         NWBbF1niCgmRA==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 10/15] wifi: ath11k: dp: cleanup debug message
Date:   Fri,  9 Jun 2023 17:24:35 +0300
Message-Id: <20230609142440.24643-11-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609142440.24643-1-kvalo@kernel.org>
References: <20230609142440.24643-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Merge the two debug messages into and fix them to follow the preferred style.

Also change the log level to ATH11K_DBG_DP_TX to match the filename.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 08a28464eb7a..a34833de7c67 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -964,14 +964,10 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 				params.low_threshold);
 	}
 
-	ath11k_dbg(ab, ATH11k_DBG_HAL,
-		   "%s msi_addr_lo:0x%x, msi_addr_hi:0x%x, msi_data:0x%x\n",
-		   __func__, cmd->ring_msi_addr_lo, cmd->ring_msi_addr_hi,
-		   cmd->msi_data);
-
-	ath11k_dbg(ab, ATH11k_DBG_HAL,
-		   "ring_id:%d, ring_type:%d, intr_info:0x%x, flags:0x%x\n",
-		   ring_id, ring_type, cmd->intr_info, cmd->info2);
+	ath11k_dbg(ab, ATH11K_DBG_DP_TX,
+		   "htt srng setup msi_addr_lo 0x%x msi_addr_hi 0x%x msi_data 0x%x ring_id %d ring_type %d intr_info 0x%x flags 0x%x\n",
+		   cmd->ring_msi_addr_lo, cmd->ring_msi_addr_hi,
+		   cmd->msi_data, ring_id, ring_type, cmd->intr_info, cmd->info2);
 
 	ret = ath11k_htc_send(&ab->htc, ab->dp.eid, skb);
 	if (ret)
-- 
2.30.2

