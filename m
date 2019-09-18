Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2FB60A9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfIRJrc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 05:47:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfIRJrb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 05:47:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C95E661515; Wed, 18 Sep 2019 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568800050;
        bh=nOPG271MYmE9za6LywVupNiS5dg7aCWvsd/EPLsiDhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feWGhdyPcYxR4D5wq6WgoFy7V+l69hL8jxXs7kCJuHFTCEj+3V+7y+7Ge2emWSQ37
         P8Bnt8poVGzLYQq+fvPapUSlIRC4IfFviEt7QYxjIiSpoheURHyv5q+4R4xpbh9deG
         15E3jWskO8DNaBoTSkQsTXFvJQmPACUrkXS+z+6M=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C525E60767;
        Wed, 18 Sep 2019 09:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568800050;
        bh=nOPG271MYmE9za6LywVupNiS5dg7aCWvsd/EPLsiDhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feWGhdyPcYxR4D5wq6WgoFy7V+l69hL8jxXs7kCJuHFTCEj+3V+7y+7Ge2emWSQ37
         P8Bnt8poVGzLYQq+fvPapUSlIRC4IfFviEt7QYxjIiSpoheURHyv5q+4R4xpbh9deG
         15E3jWskO8DNaBoTSkQsTXFvJQmPACUrkXS+z+6M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C525E60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Yibo Zhao <yiboz@codeaurora.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH V2 3/4] mac80211: fix low throughput in multi-clients situation
Date:   Wed, 18 Sep 2019 17:47:12 +0800
Message-Id: <1568800033-17297-3-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568800033-17297-1-git-send-email-yiboz@codeaurora.org>
References: <1568800033-17297-1-git-send-email-yiboz@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
.	.	.			.		.
.	.	.			.		.
.	.	.			.		.

After this round, all the stations are not valid for next transmission due
to accumulative deviation.

And if we add a new #51,
Round 2:
STA	weight	Tx_time_round	wt_sum  s_vt	g_vt  valid_for_next_Tx
.	.	.			.		.
.	.	.			.		.
.	.	.			.		.

Sync is done by:
max(g_vt of last round - grace period, s_vt)
and s_vt of #51 = max(2000 - 500, 0) + 1024 = 2524, and it is more than the
final g_vt of this round.

After this round, no more station is valid for transmission.

The real situation can be more complicate, above is one of the extremely
case.

To avoid this situation to occur, the new proposal is:

- Increase the airtime grace period a little more to reduce the
  unexpected sync

- If global virtual time is less than the virtual airtime of any station,
  sync it to the airtime of first station in the red-black tree

- Round the division result

Co-developed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
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

