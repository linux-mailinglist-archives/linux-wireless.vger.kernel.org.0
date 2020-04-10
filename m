Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619781A48C7
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJRFb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 13:05:31 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47827 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgDJRFb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 13:05:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586538331; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=pYGe/doWjXV4ByehKZnLioV7ADmaQfRqkdcHgaeNd0M=; b=tu1QfMcdcGjy5klFB/CFm3BY5NG4/j9n7g5AccO11myb21ZfixKlLOBXi2hqHqW1Kny/85X1
 0MkhbF8NixM73pfAasmlY6S82kaEfArDZE/hFq3zjimd19SrmKRVNEzaSUAdDObwdr/ApFgD
 I6/P9bUCVxP/zmE1tht7qljA+2M=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e90a754.7f2b7232a500-smtp-out-n03;
 Fri, 10 Apr 2020 17:05:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51C9FC433CB; Fri, 10 Apr 2020 17:05:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from che-swdbs-01.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A16BC43636;
        Fri, 10 Apr 2020 17:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A16BC43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ritesh Singh <ritesi@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH] ath11k: Fix fw assert by setting proper vht cap
Date:   Fri, 10 Apr 2020 22:36:44 +0530
Message-Id: <1586538405-16226-2-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1586538405-16226-1-git-send-email-mkenna@codeaurora.org>
References: <1586538405-16226-1-git-send-email-mkenna@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ritesh Singh <ritesi@codeaurora.org>

After setting fixed vht-rate if new station is trying to
assoc with mu_bfee cap, or if a sta is already connected
with mu_bfee cap then set the fixed vht-rate and
reconnecting the sta, FW assert is happening.

So to avoid this, reset the MU_BEAMFORMEE bit in vht->caps,
if mcs_index is invalid for nss 1.

Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9f8bc19..29e1267 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1142,6 +1142,10 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 	arg->tx_mcs_set &= ~IEEE80211_VHT_MCS_SUPPORT_0_11_MASK;
 	arg->tx_mcs_set |= IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11;
 
+	if ((arg->tx_mcs_set & IEEE80211_VHT_MCS_NOT_SUPPORTED) ==
+			IEEE80211_VHT_MCS_NOT_SUPPORTED)
+		arg->peer_vht_caps &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+
 	/* TODO:  Check */
 	arg->tx_max_mcs_nss = 0xFF;
 
-- 
1.9.1
