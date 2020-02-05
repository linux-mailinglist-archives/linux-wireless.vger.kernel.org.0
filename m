Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE32C152797
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 09:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgBEIc0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 03:32:26 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:63850 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728079AbgBEIc0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 03:32:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580891545; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jYeXu8Bq1N/yKhVNgvvndQG64TjmW7ULdklQC4cBpwk=; b=pRDaZ/3DgApP3mACjKm/HC24tpoS9YPMp8OA6aeROuXZqg36zzvBtGXUfk+sV9dBbWdvOy3D
 5x+81U+aWo40Uch8asQLy1q7q3JFLoI4+bnH8uaP/P8FpMJfGpqu0q6aKW4gSqY25ZWeY73Y
 G0gctC2cFod5zuOm6C665Pe353M=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3a7d8e.7f52ee421110-smtp-out-n01;
 Wed, 05 Feb 2020 08:32:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56441C433A2; Wed,  5 Feb 2020 08:32:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AD42C43383;
        Wed,  5 Feb 2020 08:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AD42C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Rao Naralasetty <vnaralas@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Vikas Patel <vikpatel@codeaurora.org>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
Subject: [PATCH] ath11k: Fixing dangling pointer issue upon peer delete failure
Date:   Wed,  5 Feb 2020 14:01:55 +0530
Message-Id: <1580891515-15054-1-git-send-email-vnaralas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vikas Patel <vikpatel@codeaurora.org>

When there is WMI command failure, 'peer->sta' was not getting
cleaned up, and mac80211 frees the 'sta' memory, which is causing
the below page fault.

Cleaning up the sta pointer in ath11k whenever peer delete command
is sent.

Unable to handle kernel paging request at virtual address 200080000006a
pgd = ffffffc02a774000
[200080000006a] *pgd=0000000000000000, *pud=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
.
.
.
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.4.60 #1
Hardware name: Qualcomm Technologies, Inc. IPQ807x/AP-HK01-C1 (DT)
task: ffffffc00083c6d0 ti: ffffffc00083c6d0 task.ti: ffffffc00083c6d0
PC is at ath11k_dp_rx_process_mon_status+0x114/0x4e0 [ath11k]
LR is at ath11k_dp_rx_process_mon_status+0xe8/0x4e0 [ath11k]
pc : [<ffffffbffcf8e544>] lr : [<ffffffbffcf8e518>] pstate: 60000145
sp : ffffffc000833a30

Signed-off-by: Vikas Patel <vikpatel@codeaurora.org>
Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6640662..4868c83 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2786,6 +2786,7 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k_peer *peer;
 	int ret = 0;
 
 	/* cancel must be done outside the mutex to avoid deadlock */
@@ -2818,6 +2819,17 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   sta->addr, arvif->vdev_id);
 
 		ath11k_mac_dec_num_stations(arvif, sta);
+		spin_lock_bh(&ar->ab->base_lock);
+		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+		if (peer && peer->sta == sta) {
+			ath11k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
+				    vif->addr, arvif->vdev_id);
+			peer->sta = NULL;
+			list_del(&peer->list);
+			kfree(peer);
+			ar->num_peers--;
+		}
+		spin_unlock_bh(&ar->ab->base_lock);
 
 		kfree(arsta->tx_stats);
 		arsta->tx_stats = NULL;
-- 
2.7.4
