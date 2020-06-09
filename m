Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E101F3CB5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 15:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgFINdu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 09:33:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38257 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbgFINdq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 09:33:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591709626; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=w2224Y0nbWvWlC7xoYkdAlPsLiP73clnhNvdoGUaSho=; b=npN7ZHmKmUx/pTHeoni9Y3fhBxNXFApePbNcKsvPzE8WNOFsjha5tGZKD/6EB6A/fT9pOFmL
 W6I7ecUU46MUo9Pc8e0izLbev64hqCEpA3iNVDkIAJ1vjxZwv+XOLcKM0C3VtnN2saSKWYBs
 BEmopZbDVseLjv+vpB4XK6vomJc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5edf8fa63a8a8b20b8b1d5ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 13:33:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8AB48C433CB; Tue,  9 Jun 2020 13:33:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92898C433C6;
        Tue,  9 Jun 2020 13:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92898C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2 3/8] ath11k: rename default board file
Date:   Tue,  9 Jun 2020 19:02:56 +0530
Message-Id: <1591709581-18039-4-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
References: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rename default BDF to make it consistent with board-2.bin naming.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 6e065c4e5935..f7f070af233c 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -75,7 +75,7 @@
 
 #define ATH11K_BOARD_MAGIC		"QCA-ATH11K-BOARD"
 #define ATH11K_BOARD_API2_FILE		"board-2.bin"
-#define ATH11K_DEFAULT_BOARD_FILE	"bdwlan.bin"
+#define ATH11K_DEFAULT_BOARD_FILE	"board.bin"
 #define ATH11K_DEFAULT_CAL_FILE		"caldata.bin"
 
 enum ath11k_hw_rate_cck {
-- 
2.7.4

