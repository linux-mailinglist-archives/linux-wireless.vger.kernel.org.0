Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADFA729CCE
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbjFIOZY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbjFIOZB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:25:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3373235A9
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1272E615D1
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A1AC433EF;
        Fri,  9 Jun 2023 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320699;
        bh=07gyuyD88dqTsWLowHKsvMGA1/8R7H8umcB9wqiN818=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lY16zqZUV+Lcuv8MX9TzNy8PU2SVwg1gNw/FcXdY/yoBNKbzoUIMhl7PT0QOvg5X5
         gA+3z4Z2O0jDCWO4ohCM8aq5+JebxnlwBO0RGcpRIZfE1ezlfH9gzGMXCfjYiZTo7a
         PaDinEUipCMC+ny341/4nDonNHb+OrjTqsNKA4td9mZbxUdOeBi+/iV2gyDp8Ptfgm
         mgjRBCwQdLG/A2ZFnI75GcyrOLpP7A9bkc//AZZdMr4hzOW79I+MIo45b4OgqmdbPN
         GtCuxazve8B1M5lKzA/rfrlxZa2UfKWnHdVRNcssZxeC3m5GkSWgx5fYlnE9X0H09U
         Qyzhimg2tKzCQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 15/15] wifi: ath11k: debug: add ATH11K_DBG_CE
Date:   Fri,  9 Jun 2023 17:24:40 +0300
Message-Id: <20230609142440.24643-16-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609142440.24643-1-kvalo@kernel.org>
References: <20230609142440.24643-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Add a new debug level for CE so that we don't need to use AHB level in ce.c.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ce.c    | 4 ++--
 drivers/net/wireless/ath/ath11k/debug.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index f2da95fd4253..289d47ae92af 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -442,7 +442,7 @@ static void ath11k_ce_recv_process_cb(struct ath11k_ce_pipe *pipe)
 	}
 
 	while ((skb = __skb_dequeue(&list))) {
-		ath11k_dbg(ab, ATH11K_DBG_AHB, "rx ce pipe %d len %d\n",
+		ath11k_dbg(ab, ATH11K_DBG_CE, "rx ce pipe %d len %d\n",
 			   pipe->pipe_num, skb->len);
 		pipe->recv_cb(ab, skb);
 	}
@@ -520,7 +520,7 @@ static void ath11k_ce_tx_process_cb(struct ath11k_ce_pipe *pipe)
 	}
 
 	while ((skb = __skb_dequeue(&list))) {
-		ath11k_dbg(ab, ATH11K_DBG_AHB, "tx ce pipe %d len %d\n",
+		ath11k_dbg(ab, ATH11K_DBG_CE, "tx ce pipe %d len %d\n",
 			   pipe->pipe_num, skb->len);
 		pipe->send_cb(ab, skb);
 	}
diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index f0dddd188ef0..9c52804ef8ac 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -26,6 +26,7 @@ enum ath11k_debug_mask {
 	ATH11K_DBG_PCI		= 0x00001000,
 	ATH11K_DBG_DP_TX	= 0x00002000,
 	ATH11K_DBG_DP_RX	= 0x00004000,
+	ATH11K_DBG_CE		= 0x00008000,
 };
 
 static inline const char *ath11k_dbg_str(enum ath11k_debug_mask mask)
@@ -61,6 +62,8 @@ static inline const char *ath11k_dbg_str(enum ath11k_debug_mask mask)
 		return "dp_tx";
 	case ATH11K_DBG_DP_RX:
 		return "dp_rx";
+	case ATH11K_DBG_CE:
+		return "ce";
 
 	/* no default handler to allow compiler to check that the
 	 * enum is fully handled
-- 
2.30.2

