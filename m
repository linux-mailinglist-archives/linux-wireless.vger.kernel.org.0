Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41737428925
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhJKIwS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 04:52:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24163 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235276AbhJKIwS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 04:52:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633942218; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=uT1YdAIDeG5sQ7gfDapubMtpx9RXyxhsLMgzuJ41PJo=; b=iQ+vcG5CTcmTk3NUrN9CoBWw/YY0MRB81AuijBc81jEHvh4K4FDw07faIsr6H7tscSN9G6+4
 WbPq2nXtLFgDWVKnB2o80vrSiWwaaY3u7+uXXviBFsjbwWI89Gmu5CEYfAjHOjTaaB6lW4AT
 K2/Nt/F3sODYOnH/gb/NXjOw9KU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6163fabfa45ca75307ad3694 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 08:50:07
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F14AC4360D; Mon, 11 Oct 2021 08:50:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E74E4C4338F;
        Mon, 11 Oct 2021 08:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E74E4C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath11k: remove return for empty tx bitrate in mac_op_sta_statistics
Date:   Mon, 11 Oct 2021 04:49:57 -0400
Message-Id: <20211011084957.31024-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently in ath11k_mac_op_sta_statistics() there is the following
logic:
    if (!arsta->txrate.legacy && !arsta->txrate.nss)
        return;

Unfortunately if this condition is true then the function returns
without setting parameters that follow the txrate.

To address this issue remove the return and instead invert the logic
to set the txrate logic if (arsta->txrate.legacy || arsta->txrate.nss).

Same change which is upstream also exists in ath10k:
1cd6ba8ae33e ("ath10k: remove return for NL80211_STA_INFO_TX_BITRATE")

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 29 +++++++++++++--------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 0f54332bc24c..8714f971ad67 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6965,21 +6965,20 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->tx_duration = arsta->tx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
 
-	if (!arsta->txrate.legacy && !arsta->txrate.nss)
-		return;
-
-	if (arsta->txrate.legacy) {
-		sinfo->txrate.legacy = arsta->txrate.legacy;
-	} else {
-		sinfo->txrate.mcs = arsta->txrate.mcs;
-		sinfo->txrate.nss = arsta->txrate.nss;
-		sinfo->txrate.bw = arsta->txrate.bw;
-		sinfo->txrate.he_gi = arsta->txrate.he_gi;
-		sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
-		sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
-	}
-	sinfo->txrate.flags = arsta->txrate.flags;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	if (arsta->txrate.legacy || arsta->txrate.nss) {
+		if (arsta->txrate.legacy) {
+			sinfo->txrate.legacy = arsta->txrate.legacy;
+		} else {
+			sinfo->txrate.mcs = arsta->txrate.mcs;
+			sinfo->txrate.nss = arsta->txrate.nss;
+			sinfo->txrate.bw = arsta->txrate.bw;
+			sinfo->txrate.he_gi = arsta->txrate.he_gi;
+			sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
+			sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
+		}
+		sinfo->txrate.flags = arsta->txrate.flags;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	}
 
 	/* TODO: Use real NF instead of default one. */
 	sinfo->signal = arsta->rssi_comb + ATH11K_DEFAULT_NOISE_FLOOR;
-- 
2.31.1

