Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED5A32F64B
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Mar 2021 00:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCEXEM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Mar 2021 18:04:12 -0500
Received: from z11.mailgun.us ([104.130.96.11]:39593 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhCEXEF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Mar 2021 18:04:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614985445; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=JMSkQDbDLCxhtRQlVe8R4q0GM/5dq6kNMpa2Xg/8lPA=; b=wOq0FFRxrD8xkFc5XF0ibIg8XBQY0YTS7dqZpDyN4UH8EHVFIGMQpDORT208j31HuUzcfaJW
 M03q6kssyXZDcZyd0bBXr9+ffN5arlIUuSs9Vw5hTWCueXTsdELtpCbH3wgtM7QZOKTSznqw
 a7+Nn1otJSQ2PagBGCjXTGsKN0w=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6042b8d3f7ec0ea57c5de573 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Mar 2021 23:03:47
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2B6AC43464; Fri,  5 Mar 2021 23:03:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6099AC433ED;
        Fri,  5 Mar 2021 23:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6099AC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH v7 1/3] ath11k: switch to using ieee80211_tx_status_ext()
Date:   Fri,  5 Mar 2021 15:03:35 -0800
Message-Id: <20210305230337.23047-2-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305230337.23047-1-pradeepc@codeaurora.org>
References: <20210305230337.23047-1-pradeepc@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows us to pass HE rates down into the stack.

Co-developed-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 26 ++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8bba5234f81f..9b636b4e8521 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -417,9 +417,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
 {
+	struct ieee80211_tx_status status = { 0 };
 	struct ath11k_base *ab = ar->ab;
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
+	struct ath11k_peer *peer;
+	struct ath11k_sta *arsta;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -483,13 +486,22 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 		ath11k_dp_tx_cache_peer_stats(ar, msdu, ts);
 	}
 
-	/* NOTE: Tx rate status reporting. Tx completion status does not have
-	 * necessary information (for example nss) to build the tx rate.
-	 * Might end up reporting it out-of-band from HTT stats.
-	 */
-
-	ieee80211_tx_status(ar->hw, msdu);
-
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
+	if (peer) {
+		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
+		status.sta = peer->sta;
+		status.skb = msdu;
+		status.info = info;
+		status.rate = &arsta->last_txrate;
+	}
+	rcu_read_unlock();
+	if (peer)
+		ieee80211_tx_status_ext(ar->hw, &status);
+	else
+		dev_kfree_skb_any(msdu);
+	spin_unlock_bh(&ab->base_lock);
+	return;
 exit:
 	rcu_read_unlock();
 }
-- 
2.17.1

