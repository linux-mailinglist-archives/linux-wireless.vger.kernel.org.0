Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359191BA546
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 15:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgD0NpR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 09:45:17 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:61441 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgD0NpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 09:45:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587995116; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=7ICCT2+tbWtu868EIqFl223/Mq5QcoeFd0GbK4KNJUA=; b=L4kZ+OK22NqutTTARCN1ytIAJDkh2beZMj53i95dgtEMiEBWv1nVijcyBe9MZurjze5q5PaI
 ASj3m6zkaVNlS+G6q1lHV3SrHLD9cwOOpekPhJfXa7ht7DnaZmB1WJJcTGwKOQzY9l7Mn7EY
 0uL/TJ3fvFem2OTcMVyHcx1jgzY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea6e1eb.7f7765c107d8-smtp-out-n02;
 Mon, 27 Apr 2020 13:45:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0BF23C433D2; Mon, 27 Apr 2020 13:45:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from murugana-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E5F2C433CB;
        Mon, 27 Apr 2020 13:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E5F2C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: [PATCH v3 1/2] ath11k: fix mgmt_tx_wmi cmd sent to FW for deleted vdev
Date:   Mon, 27 Apr 2020 19:14:54 +0530
Message-Id: <1587995095-7808-2-git-send-email-murugana@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587995095-7808-1-git-send-email-murugana@codeaurora.org>
References: <1587995095-7808-1-git-send-email-murugana@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In Multi-AP VAP scenario with frequent interface up-down, there is a
chance that ath11k_mgmt_over_wmi_tx_work() will dequeue a skb
corresponding to currently deleted/stopped vdev.

FW will assert on receiving mgmt_tx_wmi cmd for already deleted vdev.
Hence adding validation checks for arvif present on the corresponding
ar before sending mgmt_tx_wmi cmd.

Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 065b7d6d4ab2..2b3a63ac216c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3793,15 +3793,30 @@ static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 
 	while ((skb = skb_dequeue(&ar->wmi_mgmt_tx_queue)) != NULL) {
 		info = IEEE80211_SKB_CB(skb);
-		arvif = ath11k_vif_to_arvif(info->control.vif);
-
-		ret = ath11k_mac_mgmt_tx_wmi(ar, arvif, skb);
-		if (ret) {
-			ath11k_warn(ar->ab, "failed to transmit management frame %d\n",
-				    ret);
+		if (!info->control.vif) {
+			ath11k_warn(ar->ab, "no vif found for mgmt frame, flags 0x%x\n",
+				    info->control.flags);
 			ieee80211_free_txskb(ar->hw, skb);
+			continue;
+		}
+
+		arvif = ath11k_vif_to_arvif(info->control.vif);
+		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id) &&
+		    arvif->is_started) {
+			ret = ath11k_mac_mgmt_tx_wmi(ar, arvif, skb);
+			if (ret) {
+				ath11k_warn(ar->ab, "failed to tx mgmt frame, vdev_id %d :%d\n",
+					    arvif->vdev_id, ret);
+				ieee80211_free_txskb(ar->hw, skb);
+			} else {
+				atomic_inc(&ar->num_pending_mgmt_tx);
+			}
 		} else {
-			atomic_inc(&ar->num_pending_mgmt_tx);
+			ath11k_warn(ar->ab,
+				    "dropping mgmt frame for vdev %d, flags 0x%x is_started %d\n",
+				    arvif->vdev_id, info->control.flags,
+				    arvif->is_started);
+			ieee80211_free_txskb(ar->hw, skb);
 		}
 	}
 }
-- 
2.7.4
