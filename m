Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B434109CB4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 12:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfKZLEq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 06:04:46 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:43416
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbfKZLEq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 06:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574766285;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=Uyeo4iqBPl1KuvYSnL8ekx9nDe/k3v/zyOzdlv+Rtzw=;
        b=VVXKYsBa1fkU0UQGRbiIq8o3htbobswz5OspRBdC1EGM1ZSAkUy4u+4CHlrm+b/+
        PpFS1JNwb8m+lgRRjAJ6HmAiWlqPi44RbtIhG/IrPH2r35NxrV2loM6TYzwH+L5cyNd
        bnyvuh10K6nzfszGTgsyQP9wgkoJwx73Q4pI6K7c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574766285;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=Uyeo4iqBPl1KuvYSnL8ekx9nDe/k3v/zyOzdlv+Rtzw=;
        b=bA9o5zhp1z0aFgsErHBi4WxkbXjymX4fLUGXBCbN7r8gTK+tGxr2XeTdd3YU7w85
        ODp3sGbwcphAwy1bfdsGN6ogsBTaFOG7QS+PVhwoE1YDMfVq5ep/o1vEAWM9SeFJ54+
        wkx1mIjeQIrWj5q66AQdbetHS5qRl9ketdsGUIWc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E45E3C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 01/10] ath11k: Fix htt stats sounding info and pdev cca stats
Date:   Tue, 26 Nov 2019 11:04:45 +0000
Message-ID: <0101016ea76291c1-5098ab8c-5e07-4a40-a582-6bd9ae513b74-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
References: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.26-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ganesh Sesetti <gseset@codeaurora.org>

The Previous configuartion of htt stats sounding info and pdev cca stats
are invalid due to that getting time out error.

Changing htt stats sounding info value from 0xFF to 0x00 and htt pdev cca
stats from 0x10 to 0x00

Signed-off-by: Ganesh Sesetti <gseset@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 4db71173db62..eb0f3df131c5 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1365,8 +1365,8 @@ struct htt_ext_stats_cfg_cmd {
 #define HTT_STAT_DEFAULT_CFG0_ALL_CMDQS 0xffff
 #define HTT_STAT_DEFAULT_CFG0_ALL_RINGS 0xffff
 #define HTT_STAT_DEFAULT_CFG0_ACTIVE_PEERS 0xff
-#define HTT_STAT_DEFAULT_CFG0_CCA_CUMULATIVE 0x10
-#define HTT_STAT_DEFAULT_CFG0_ACTIVE_VDEVS 0xff
+#define HTT_STAT_DEFAULT_CFG0_CCA_CUMULATIVE 0x00
+#define HTT_STAT_DEFAULT_CFG0_ACTIVE_VDEVS 0x00
 
 /* HTT_DBG_EXT_STATS_PEER_INFO
  * PARAMS:
-- 
2.7.4

