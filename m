Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312C3B3B04
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfIPNKg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 09:10:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44308 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfIPNKg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 09:10:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C1DDD61528; Mon, 16 Sep 2019 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568639434;
        bh=5ZC6jmwiMy7decVcU1F89bZb8lrRdZ+ifQlFcir8cq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRSc9AkUFFNKdZbxqnI6DWI0DdnM7iYGtLcjPkPnnG65I9DwjAk8mZAdRH5a195Wg
         VnXHMxVy4+Ihr+UerynjaQ8xIkkzZ7QYhlrrUun4JoaQeuAl/hM47rLpO1a97zCttc
         BA/5hvknP86RXOnfakR5Aspm9l34PxOjSDltPttA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from ybzhao-HP-Z230-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yiboz@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDDF5611FA;
        Mon, 16 Sep 2019 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568639433;
        bh=5ZC6jmwiMy7decVcU1F89bZb8lrRdZ+ifQlFcir8cq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pN7h8XF8UrO7qWE3gKv16d9m80IWGVDqxwMmg/BEL+YyLEpD99X/bLmU/a6O+uCcT
         pJ3m0EY1bxAThNrxcuiBC6rwNrl77mG4bF7+JUsg1Yned5KyrrARMhbFKNfHyTJVwD
         s0YflXUnBaPt7W23A+cDz7RdEqqnmdTTg8f/oWjc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDDF5611FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Yibo Zhao <yiboz@codeaurora.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH 3/4] mac80211: fix low throughput in push pull mode
Date:   Mon, 16 Sep 2019 21:09:47 +0800
Message-Id: <1568639388-27291-3-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If station is ineligible for transmission in ieee80211_txq_may_transmit(),
no packet will be delivered to FW. During the tests in push-pull mode with
many clients, after several seconds, not a single station is an eligible
candidate for transmission since global time is smaller than all the
station's virtual airtime. As a consequence, the Tx has been blocked and
throughput is quite low.

To avoid this situation to occur in push-pull mode, the new proposal is:

- Increase the airtime grace period a little more to reduce the
  unexpected sync

- If global virtual time is less than the virtual airtime of any station,
  sync it to the airtime of first station in the red-black tree

- Round the division result since the process of global virtual time
  involves the division calculation

Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 net/mac80211/sta_info.c |  3 ++-
 net/mac80211/sta_info.h |  2 +-
 net/mac80211/tx.c       | 16 +++++++++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 9d01fdd..feac975 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1852,7 +1852,8 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 
 	weight_sum = local->airtime_weight_sum[ac] ?: sta->airtime_weight;
 
-	local->airtime_v_t[ac] += airtime / weight_sum;
+	/* Round the calculation of global vt */
+	local->airtime_v_t[ac] += (airtime + (weight_sum >> 1)) / weight_sum;
 	sta->airtime[ac].v_t += airtime / sta->airtime_weight;
 	ieee80211_resort_txq(&local->hw, txq);
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 5c1cac9..5055f94 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -130,7 +130,7 @@ enum ieee80211_agg_stop_reason {
 /* Debugfs flags to enable/disable use of RX/TX airtime in scheduler */
 #define AIRTIME_USE_TX		BIT(0)
 #define AIRTIME_USE_RX		BIT(1)
-#define AIRTIME_GRACE 500 /* usec of grace period before reset */
+#define AIRTIME_GRACE 2000 /* usec of grace period before reset */
 
 struct airtime_info {
 	u64 rx_airtime;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 42ca010..60cf569 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3867,15 +3867,29 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
-	struct txq_info *txqi = to_txq_info(txq);
+	struct txq_info *first_txqi, *txqi = to_txq_info(txq);
+	struct rb_node *node = NULL;
 	struct sta_info *sta;
 	u8 ac = txq->ac;
+	first_txqi = NULL;
 
 	lockdep_assert_held(&local->active_txq_lock[ac]);
 
 	if (!txqi->txq.sta)
 		return true;
 
+	node = rb_first_cached(&local->active_txqs[ac]);
+	if (node) {
+		first_txqi = container_of(node, struct txq_info,
+					  schedule_order);
+		if (first_txqi->txq.sta) {
+			sta = container_of(first_txqi->txq.sta,
+					   struct sta_info, sta);
+			if (local->airtime_v_t[ac] < sta->airtime[ac].v_t)
+				local->airtime_v_t[ac] = sta->airtime[ac].v_t;
+		}
+	}
+
 	sta = container_of(txqi->txq.sta, struct sta_info, sta);
 	return (sta->airtime[ac].v_t <= local->airtime_v_t[ac]);
 }
-- 
1.9.1

