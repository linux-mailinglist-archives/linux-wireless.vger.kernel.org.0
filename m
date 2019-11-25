Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463951091F3
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 17:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfKYQgW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 11:36:22 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:58432
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728927AbfKYQgW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 11:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574699781;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=6IkkHK+cSobqSjh+k5v32K8eIaqyvt8BS+MYhdVO8pA=;
        b=o3i5PzRdIi2LhfFFoTOd+EdOG0IChbugLRxAnCTyDwFB5cLLJ3IwPNL96XlR2sJU
        ANBZtVGwAE1Eo/kszM9BxE0UFhtLfBPJWGedFWrS3ISjfzkBffcIkDLXJL2PUAFDSun
        wJUle0Uqac1gM600NClpEpHmJbf/dhGqjkktiEMI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574699781;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=6IkkHK+cSobqSjh+k5v32K8eIaqyvt8BS+MYhdVO8pA=;
        b=NEcP7MGjQmsyKQP2Ez5KQtz292bS94EVB4xZWGKatrhsfGlsRv5VjqjGrbJPrzuw
        c4+SL8EXf0WSczDoIktNC8pRP1G3L475Py2evfhMVuzNHjm2IjLZr82ML87+vh4/YCs
        s7DGJV7Db2J+nyUKJaWE3/wTS7RWehaCEY5aD3rw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9ECB0C447A6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 3/8] ath11k: convert message from info to dbg
Date:   Mon, 25 Nov 2019 16:36:21 +0000
Message-ID: <0101016ea36bcbc4-b136c4ff-3869-48b1-a43b-278d3ae918b0-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
References: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.25-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

We can regularly see the following message.
- "ath11k c000000.wifi1: failed to find the peer with peer_id 4"
This happens when the FW starts sending stats for the peer whilst the
peer is not fully associated. Convert this info message to a debug one.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index c498c4920e11..d5963509419b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2621,8 +2621,9 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		peer = ath11k_peer_find_by_id(ab, ppdu_info.peer_id);
 
 		if (!peer || !peer->sta) {
-			ath11k_warn(ab, "failed to find the peer with peer_id %d\n",
-				    ppdu_info.peer_id);
+			ath11k_dbg(ab, ATH11K_DBG_DATA,
+				   "failed to find the peer with peer_id %d\n",
+				   ppdu_info.peer_id);
 			spin_unlock_bh(&ab->base_lock);
 			rcu_read_unlock();
 			dev_kfree_skb_any(skb);
-- 
2.7.4

