Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0844BAE68
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 09:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404522AbfIWHUh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 03:20:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46422 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbfIWHUh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 03:20:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CD43B61214; Mon, 23 Sep 2019 07:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569223235;
        bh=/XTiKHGAUsaIPb0cfDEJ4fYnBg7ih+OwcDi6EtcIfSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WkXohcj5zTewBJDP+HUn9IuXxKKCMLRHs8XhpUe4f6AaVnLQ7YTb8xUot9nXVjxVz
         MbKrJDfbkLhShYarRR9zloupgCr9aTR+GNMLv9Fp96n6YU0NcztUkvSH2k0QmZYUk/
         VnAk9e5jaNIo6oWbeZRnoyxzUymrk+Tw4s3EvCwE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB73161214;
        Mon, 23 Sep 2019 07:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569223234;
        bh=/XTiKHGAUsaIPb0cfDEJ4fYnBg7ih+OwcDi6EtcIfSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGRgiEkib6N3dbhcLK3OMwHkDX16zkiCMWk4RspYmcGmdTyEAexv5TEUaAXWJk7ro
         NzX5+QkpGUSYrKgztFl/xHtS1FxQHsk9+6UVJ+Bj2ET6HORhE7NDVBBXlI6QvtiOzH
         0K4urVsj8x4clH1Al6BQ7f0JtZJ8IQBmezDEJ8uk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB73161214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: [PATCH V3 3/4] mac80211: fix low throughput in multi-clients situation
Date:   Mon, 23 Sep 2019 15:20:00 +0800
Message-Id: <1569223201-1490-4-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Not long after the start of multi-clients test, not a single station is
an eligible candidate for transmission since global virtual time(g_vt) is
smaller than the virtual airtime(s_vt) of all the stations. As a result,
the Tx has been blocked and throughput is quite low.

This may mainly due to sync mechanism and accumulative deviation from the
devision calculation of g_vt.

For example:
Suppose we have 50 clients in first round.
Round 1:
STA	weight	Tx_time_round  wt_sum	s_vt	g_vt  valid_for_next_Tx
1	256	2048		12800	2048	2000	N
2	256	2048			2048		N
.	.	.			.		.
.	.	.			.		.
.	.	.			.		.
50	256	2048			2048		N

After this round, all the stations are not valid for next transmission due to
accumulative deviation.

And if we add a new #51,
STA	weight	Tx_time_round  wt_sum	s_vt	g_vt  valid_for_next_Tx
1	256	2048		13056	2048	2020	N
2	256	2048			2048		N
.	.	.			.
.	.	.			.
.	.	.			.
50	256	2048			2048		N
51	256	1024			2524		N

Sync is done by:
max(g_vt of last round - grace period, s_vt)
and s_vt of #51 = max(2000 - 500, 0) + 1024 = 2524, and it is more than the final
g_vt of this round.

After this round, no more station is valid for transmission.

The real situation can be more complicate, above is one of the extremely case.

To avoid this situation to occur, the new proposal is:

- Increase the airtime grace period a little more to reduce the
  unexpected sync

- If global virtual time is less than the virtual airtime of any station,
  sync it to the airtime of first station in the red-black tree

- Round the division result

Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
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

