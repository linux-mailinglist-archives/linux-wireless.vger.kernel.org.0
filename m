Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38BD197A88
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2020 13:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgC3LRP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Mar 2020 07:17:15 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:50372 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729267AbgC3LRM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Mar 2020 07:17:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585567032; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ohNyk2iJCkJ68ndhVx4gG40YfMXlUYfIKl79zrMGSBo=; b=Z9qjOUuUKFGiE/qxLArDdHoo2E9EFE8jDj6/I8JrCv/50PAoCvpD5IHEZClQdTURaF5RhsAU
 K1F/+nXJGY1+V1oDbsWUM0VledEbakvw0uVpxy1zhlvKDI+luIbgVJX0wK79LIMKVRyXhgri
 egJCmz1QWwj8bSq8Ph2ZFi8KEMc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e81d52e.7f86213c2618-smtp-out-n04;
 Mon, 30 Mar 2020 11:17:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0B37C43636; Mon, 30 Mar 2020 11:17:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6E90C433D2;
        Mon, 30 Mar 2020 11:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6E90C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>
Subject: [PATCH] ath11k: Increase the tx completion ring size
Date:   Mon, 30 Mar 2020 16:46:46 +0530
Message-Id: <1585567006-9173-1-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase the tx completion ring size to 0x8000.Also set the
idr size to be same as the completion ring size.

This avoids backpressure on the TX Completion and
corresponding TCL Data ring during high data traffic.

Signed-off-by: Sriram R <srirrama@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 551f9c9..d4e19dc 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -169,8 +169,8 @@ struct ath11k_pdev_dp {
 
 #define DP_WBM_RELEASE_RING_SIZE	64
 #define DP_TCL_DATA_RING_SIZE		512
-#define DP_TX_COMP_RING_SIZE		8192
-#define DP_TX_IDR_SIZE			(DP_TX_COMP_RING_SIZE << 1)
+#define DP_TX_COMP_RING_SIZE		32768
+#define DP_TX_IDR_SIZE			DP_TX_COMP_RING_SIZE
 #define DP_TCL_CMD_RING_SIZE		32
 #define DP_TCL_STATUS_RING_SIZE		32
 #define DP_REO_DST_RING_MAX		4
-- 
2.7.4
