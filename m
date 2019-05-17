Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8E216AE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfEQKFZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 06:05:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfEQKFZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 06:05:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EEE7060128; Fri, 17 May 2019 10:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558087525;
        bh=e7P62AYBNfK5NvPXqx1wEnqqoUsS0GTNzKIU0NvNP3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXggcu8H7JH0u4Hgy4lrctMRf0z0LmAPs+CFqiKRwHCp6ijHRDjTj89UJWIoQIZ5O
         VMy1xGn8cWZAy7hymIdvHv4HYRtdo6tG5TExrMfdjJfDlhEWi5D/A5Xf0PMDzKhp9u
         OSNjKssNjeGj3uYUanxKmm+jReTfx8FHbiIrBI28=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from aambure-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aambure@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E92360128;
        Fri, 17 May 2019 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558087524;
        bh=e7P62AYBNfK5NvPXqx1wEnqqoUsS0GTNzKIU0NvNP3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSpqTu+fc/YuPIg27Q36TOwAmzS/gHb9KV1jPOgCeFE7hxy8jhuajP3fiRWEXorRz
         s213ymVsDTJNTsfEe67JdiIo6JrAJD/bhveRyre5/z+D0H+NUTk4VKEUFo+F0ObtsG
         0p7u9aEoLm4I7+geyS0UCyIjiTIpLtZ+kOVkxISs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E92360128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aambure@codeaurora.org
From:   Abhishek Ambure <aambure@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Abhishek Ambure <aambure@codeaurora.org>
Subject: [PATCH 1/2] ath10k: move pktlog connect service before htc start
Date:   Fri, 17 May 2019 15:35:15 +0530
Message-Id: <1558087516-666-2-git-send-email-aambure@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558087516-666-1-git-send-email-aambure@codeaurora.org>
References: <1558087516-666-1-git-send-email-aambure@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WCN3990 supports HTC service for pktlog. PKTLOG service should be
connected before HTC start. Hence move connect pktlog service before
HTC start

Fixes: 713358c321f4 ("ath10k: enable pktlog for WCN3990 target")
Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-00963-QCAHLSWMTPL-1

Signed-off-by: Abhishek Ambure <aambure@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index 805a7f8..e2980fe9 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -893,6 +893,14 @@ int ath10k_htc_start(struct ath10k_htc *htc)
 	int status = 0;
 	struct ath10k_htc_msg *msg;
 
+	if (ath10k_htc_pktlog_svc_supported(ar)) {
+		status = ath10k_htc_pktlog_connect(ar);
+		if (status) {
+			ath10k_err(ar, "failed to connect to pktlog: %d\n", status);
+			return status;
+		}
+	}
+
 	skb = ath10k_htc_build_tx_ctrl_skb(htc->ar);
 	if (!skb)
 		return -ENOMEM;
@@ -919,14 +927,6 @@ int ath10k_htc_start(struct ath10k_htc *htc)
 		return status;
 	}
 
-	if (ath10k_htc_pktlog_svc_supported(ar)) {
-		status = ath10k_htc_pktlog_connect(ar);
-		if (status) {
-			ath10k_err(ar, "failed to connect to pktlog: %d\n", status);
-			return status;
-		}
-	}
-
 	return 0;
 }
 
-- 
1.9.1

