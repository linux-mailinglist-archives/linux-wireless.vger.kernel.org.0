Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8111A5C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfEBNgn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 09:36:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBNgm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 09:36:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 605206083E; Thu,  2 May 2019 13:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556804201;
        bh=0JFvp52OyBwf49RIzG+yuBXweHAZDmaCdelkT+rDO7w=;
        h=From:To:Cc:Subject:Date:From;
        b=mG6jLsRpPE0uTgF+G+M3ZcSQEtx50HLt5+S3yQ4Rp2rsFYBzF5v9p8kgFbNwkxl7O
         8p6gGOXr4olSPPpLxiRLOqdzCdqjcACV8/ewC5QZ5oJhU7isdnp+Rc+GXno7Oozf46
         +K4Na8Nft+de+n/lyAW+CDfoKnB6G0zyLqOkCxVM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from yintang-HP-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yintang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D439E60863;
        Thu,  2 May 2019 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556804200;
        bh=0JFvp52OyBwf49RIzG+yuBXweHAZDmaCdelkT+rDO7w=;
        h=From:To:Cc:Subject:Date:From;
        b=XaFYK4aNxvXw5gEZZbhtK1PYJ1561zL7Vs6SE2Eq65LeYLrGNwCq0300OMH/0vUsB
         DBRSeTMd+1OkA8OKCD+wTEeMXbFOmt2C/q5K2XG6jOQVuj6iKS6E77c/P6VaoCKUAr
         ckbOILAfYzEpNPprMsEgdK76Yfcb0vXAk/46u3Ak=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D439E60863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yintang@codeaurora.org
From:   Yingying Tang <yintang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: Check tx_stats before use it
Date:   Thu,  2 May 2019 21:36:50 +0800
Message-Id: <1556804210-28599-1-git-send-email-yintang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tx_stats will be freed and set to NULL before debugfs_sta node is
removed in station disconnetion process. So if read the debugfs_sta
node there may be NULL pointer error. Add check for tx_stats before
use it to resove this issue.

Signed-off-by: Yingying Tang <yintang@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/debugfs_sta.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 0f3fd65..4a8d94d 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -674,6 +674,13 @@ static ssize_t ath10k_dbg_sta_dump_tx_stats(struct file *file,
 
 	mutex_lock(&ar->conf_mutex);
 
+	if (!arsta->tx_stats) {
+		ath10k_warn(ar, "failed to get tx stats");
+		mutex_unlock(&ar->conf_mutex);
+		kfree(buf);
+		return 0;
+	}
+
 	spin_lock_bh(&ar->data_lock);
 	for (k = 0; k < ATH10K_STATS_TYPE_MAX; k++) {
 		for (j = 0; j < ATH10K_COUNTER_TYPE_MAX; j++) {
-- 
1.9.1

