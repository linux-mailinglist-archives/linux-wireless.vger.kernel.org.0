Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B491BA547
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 15:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgD0Np3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 09:45:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19232 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgD0Np2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 09:45:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587995127; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=qshxf137plj2PKtnn3fpcimUTrUW7HbR7QWOLyDX0RI=; b=lTh2QrkVZ+4uZJZz7CfKnZwxsYG2RLsTOlCy3U78uj47OYyY8QHwttc1WzGXXfFOb2hXB3bG
 v6uf0s+x0wP3udpMjnb6CZL+f5Ym/mNdnUXcj3j0gdwBexf4mY1l0sid6sCHwRpoFXIzcb/U
 eA3g+iiGbWYLrguYncjNthmkRso=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea6e1ef.7f33dd797998-smtp-out-n02;
 Mon, 27 Apr 2020 13:45:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40FADC433BA; Mon, 27 Apr 2020 13:45:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from murugana-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76585C433CB;
        Mon, 27 Apr 2020 13:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76585C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: [PATCH v3 2/2] ath11k: add DBG_MAC prints to track vdev events
Date:   Mon, 27 Apr 2020 19:14:55 +0530
Message-Id: <1587995095-7808-3-git-send-email-murugana@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587995095-7808-1-git-send-email-murugana@codeaurora.org>
References: <1587995095-7808-1-git-send-email-murugana@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Added DBG_MAC prints to track vdev create, delete, start and
stop events.

Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2b3a63ac216c..bfe2d20de351 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4229,6 +4229,8 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ar->num_created_vdevs++;
+	ath11k_dbg(ab, ATH11K_DBG_MAC, "vdev %pM created, vdev_id %d\n",
+		   vif->addr, arvif->vdev_id);
 	ar->allocated_vdev_map |= 1LL << arvif->vdev_id;
 	ab->free_vdev_map &= ~(1LL << arvif->vdev_id);
 
@@ -4399,6 +4401,8 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 
 	ar->num_created_vdevs--;
+	ath11k_dbg(ab, ATH11K_DBG_MAC, "vdev %pM deleted, vdev_id %d\n",
+		   vif->addr, arvif->vdev_id);
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ab->free_vdev_map |= 1LL << (arvif->vdev_id);
 
@@ -4664,6 +4668,8 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 	}
 
 	ar->num_started_vdevs++;
+	ath11k_dbg(ab, ATH11K_DBG_MAC,  "vdev %pM started, vdev_id %d\n",
+		   arvif->vif->addr, arvif->vdev_id);
 
 	/* Enable CAC Flag in the driver by checking the channel DFS cac time,
 	 * i.e dfs_cac_ms value which will be valid only for radar channels
@@ -4722,6 +4728,8 @@ static int ath11k_mac_vdev_stop(struct ath11k_vif *arvif)
 	WARN_ON(ar->num_started_vdevs == 0);
 
 	ar->num_started_vdevs--;
+	ath11k_dbg(ab, ATH11K_DBG_MAC, "vdev %pM stopped, vdev_id %d\n",
+		   arvif->vif->addr, arvif->vdev_id);
 
 	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
 		clear_bit(ATH11K_CAC_RUNNING, &ar->dev_flags);
-- 
2.7.4
