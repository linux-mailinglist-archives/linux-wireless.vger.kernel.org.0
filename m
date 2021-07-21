Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68CE3D18FE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 23:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhGUUl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:41:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57368 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhGUUl2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:41:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626902525; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=l7xcrTU8m14XMQJypurQwvT9aOgURPSR0kG022TbR3U=; b=kfnBhGsYT545Mjd+AI0ibQWdceRdqj+uk8FZIda4Yc5stdedElGyVuJ3UM90S39eVGf18eYo
 rhvoDPpj4nk4zauj25SK9POdAUb9EsgwkplLo3tBDtVeL5ZDBzawwPzk9trpaH/5XB9fZgDh
 DdrvHNXF4FdT6J9s+3xThq7uq/I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60f88fc3290ea35ee641aa2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 21:21:07
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40D43C43460; Wed, 21 Jul 2021 21:21:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98F11C4314A;
        Wed, 21 Jul 2021 21:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98F11C4314A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <ramess@codeaurora.org>,
        Sathishkumar Muruganandam <murugana@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 10/12] ath11k: Send PPDU_STATS_CFG with proper pdev mask to firmware
Date:   Thu, 22 Jul 2021 00:20:27 +0300
Message-Id: <20210721212029.142388-10-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721212029.142388-1-jouni@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rameshkumar Sundaram <ramess@codeaurora.org>

HTT_PPDU_STATS_CFG_PDEV_ID bit mask for target FW PPDU stats request
message was set as bit 8 to 15. Bit 8 is reserved for soc stats and
pdev id starts from bit 9. Hence change the bitmask as bit 9 to 15
and fill the proper pdev id in the request message.

Tested on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01092-QCAHKSWPL_SILICONZ-1
Tested on: IPQ6018 hw1.0 WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1

Fixes: 701e48a43e15 ("ath11k: add packet log support for QCA6390")

Co-developed-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
Signed-off-by: Rameshkumar Sundaram <ramess@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.h    | 3 ++-
 drivers/net/wireless/ath/ath11k/dp_tx.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index b2e7621969c5..522d3a6ce253 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -541,7 +541,8 @@ struct htt_ppdu_stats_cfg_cmd {
 } __packed;
 
 #define HTT_PPDU_STATS_CFG_MSG_TYPE		GENMASK(7, 0)
-#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 8)
+#define HTT_PPDU_STATS_CFG_SOC_STATS		BIT(8)
+#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 9)
 #define HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK	GENMASK(31, 16)
 
 enum htt_ppdu_stats_tag_type {
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index b00e78de36bc..125a9a8a5b0a 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -906,7 +906,7 @@ int ath11k_dp_tx_htt_h2t_ppdu_stats_req(struct ath11k *ar, u32 mask)
 		cmd->msg = FIELD_PREP(HTT_PPDU_STATS_CFG_MSG_TYPE,
 				      HTT_H2T_MSG_TYPE_PPDU_STATS_CFG);
 
-		pdev_mask = 1 << (i + 1);
+		pdev_mask = 1 << (ar->pdev_idx + i);
 		cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_PDEV_ID, pdev_mask);
 		cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK, mask);
 
-- 
2.25.1

