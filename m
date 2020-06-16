Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0E1FB344
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgFPOBu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44251 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729262AbgFPOBr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316107; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=xONop08UVVjt4dAWJeiQVjfWA8PD9etL29HqmjnmFEc=; b=ZRHt5sweLCFj4VLoQJydO+sAh+kioVqb61zm9kEuFzkQDlsv4pd0ODNxFMwW9vxGwtTav0FJ
 luu20lpxeSodZUxprSz5kLkz8VWY4R6RNmO3aZKMDEi35ZphNPQvvIqC/pgMSe38G8YGi7Vb
 g5XVfhKUk1Y95HJnLMHzF1ALRiU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5ee8d0b1f3deea03f3022824 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8FAA5C433CB; Tue, 16 Jun 2020 14:01:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D8E1C4339C;
        Tue, 16 Jun 2020 14:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D8E1C4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 11/12] ath11k: don't use defines in hw_params
Date:   Tue, 16 Jun 2020 17:00:54 +0300
Message-Id: <1592316055-24958-12-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These defines are not used anywhere else so to avoid extra indirection add the
values directly to hw_params.

No functional changes. Compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 4 ++--
 drivers/net/wireless/ath/ath11k/hw.h   | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 84a566dffad9..38e830a2395b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -23,8 +23,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.name = "ipq8074 hw2.0",
 		.fw = {
 			.dir = "IPQ8074/hw2.0",
-			.board_size = IPQ8074_MAX_BOARD_DATA_SZ,
-			.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
+			.board_size = 256 * 1024,
+			.cal_size = 256 * 1024,
 		},
 		.max_radios = 3,
 		.bdf_addr = 0x4B0C0000,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 828c8c076218..f31d53f6adb8 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -68,10 +68,6 @@
 
 #define ATH11K_FW_DIR			"ath11k"
 
-/* IPQ8074 definitions */
-#define IPQ8074_MAX_BOARD_DATA_SZ	(256 * 1024)
-#define IPQ8074_MAX_CAL_DATA_SZ		IPQ8074_MAX_BOARD_DATA_SZ
-
 #define ATH11K_BOARD_MAGIC		"QCA-ATH11K-BOARD"
 #define ATH11K_BOARD_API2_FILE		"board-2.bin"
 #define ATH11K_DEFAULT_BOARD_FILE	"board.bin"
-- 
2.7.4

