Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B04B957C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Feb 2022 02:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiBQB0m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 20:26:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiBQB0l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 20:26:41 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 2C8DDE7F
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 17:26:28 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645061188; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=HpRE/Smcxl8NGQvUYyDEXcz+rmnjQcxULXnXoKQ73H4=; b=NDPMioq1kzIrVut02mx47/yEUX0x9Q2BOyPdMzDSmKEiqn/pks3DPInMX8nAosOsIH97jwW6
 iTfXaDmlb2oTp3QEbmzQ2XBF6rN7tyWMO+9KCSVCYEbgtZNirzjnr1UeW9VtCeE4CyS11Hoz
 Utpd4nRtBrGWQS0h1HSfQCun2RI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 620da3123047cf1c0a5f1435 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Feb 2022 01:21:22
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A2E7C4360D; Thu, 17 Feb 2022 01:21:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D864C4360C;
        Thu, 17 Feb 2022 01:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5D864C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH v10 1/3] ath11k: switch to using ieee80211_tx_status_ext()
Date:   Wed, 16 Feb 2022 17:21:10 -0800
Message-Id: <20220217012112.31211-2-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217012112.31211-1-pradeepc@codeaurora.org>
References: <20220217012112.31211-1-pradeepc@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows us to pass HE rates down into the stack.

Co-developed-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 32 +++++++++++++++++++++----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index c7d7631efa5a..6f553a870e70 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -519,9 +519,13 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
 {
+	struct ieee80211_tx_status status = { 0 };
 	struct ath11k_base *ab = ar->ab;
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
+	struct ath11k_peer *peer;
+	struct ath11k_sta *arsta;
+	struct rate_info rate;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -584,12 +588,30 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 		ath11k_dp_tx_cache_peer_stats(ar, msdu, ts);
 	}
 
-	/* NOTE: Tx rate status reporting. Tx completion status does not have
-	 * necessary information (for example nss) to build the tx rate.
-	 * Might end up reporting it out-of-band from HTT stats.
-	 */
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
+	if (!peer || !peer->sta) {
+		ath11k_dbg(ab, ATH11K_DBG_DATA,
+			   "dp_tx: failed to find the peer with peer_id %d\n",
+			    ts->peer_id);
+		spin_unlock_bh(&ab->base_lock);
+		dev_kfree_skb_any(msdu);
+		goto exit;
+	}
+	arsta = (struct ath11k_sta *)peer->sta->drv_priv;
+	status.sta = peer->sta;
+	status.skb = msdu;
+	status.info = info;
+	rate = arsta->last_txrate;
+	status.rate = &rate;
 
-	ieee80211_tx_status(ar->hw, msdu);
+	spin_unlock_bh(&ab->base_lock);
+	rcu_read_unlock();
+
+	ieee80211_tx_status_ext(ar->hw, &status);
+	return;
+exit:
+	rcu_read_unlock();
 }
 
 static inline void ath11k_dp_tx_status_parse(struct ath11k_base *ab,
-- 
2.17.1

