Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D154F1F333C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 07:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgFIFDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 01:03:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31427 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgFIFDh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 01:03:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591679017; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=E2B2AVpPz/YzRJqkK80E1/17qfCEhD/PP76V2xYd/b4=; b=Z6as/dMZcu24WKFRteOQz8CrFtsw1dVicaEINlTQAlH0ZDaDd/EDCzPz8fKaswf6136KXOj4
 CA9oobLcZe85vS8tiPke7wIgZAQja78bcOoXdNsMy879IsbueUFWXOMG5h9KZ+2z3mfDEe0r
 UiCmpgZNn8LWRUxSKt/XHevSiiI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5edf18285c89e47d73adf569 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 05:03:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 760F5C433C6; Tue,  9 Jun 2020 05:03:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8F6FC43387;
        Tue,  9 Jun 2020 05:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8F6FC43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 1/8] ath11k: update firmware files read path
Date:   Tue,  9 Jun 2020 10:33:06 +0530
Message-Id: <1591678993-11016-2-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591678993-11016-1-git-send-email-akolli@codeaurora.org>
References: <1591678993-11016-1-git-send-email-akolli@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We need this so that all hardware versions can coexist and
it's easier to manage everything then all hardware
directories are under ath11k directory.

Copy ath11k firmware files to
/lib/firmware/ath11k/IPQ8074/hw2.0/

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index dc4434aefbbe..6e065c4e5935 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -69,7 +69,7 @@
 #define ATH11K_FW_DIR			"ath11k"
 
 /* IPQ8074 definitions */
-#define IPQ8074_FW_DIR			"IPQ8074"
+#define IPQ8074_FW_DIR			ATH11K_FW_DIR "/IPQ8074/hw2.0"
 #define IPQ8074_MAX_BOARD_DATA_SZ	(256 * 1024)
 #define IPQ8074_MAX_CAL_DATA_SZ		IPQ8074_MAX_BOARD_DATA_SZ
 
-- 
2.7.4

