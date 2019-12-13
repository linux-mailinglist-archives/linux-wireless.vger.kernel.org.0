Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA88811DE95
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 08:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfLMHYY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 02:24:24 -0500
Received: from m228-5.mailgun.net ([159.135.228.5]:27134 "EHLO
        m228-5.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfLMHYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 02:24:24 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 02:24:18 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576221864; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=YXtkS+WCDRchtLlhZcdIFPjO82KlbppU6JgdHQbzzmE=; b=lMsg0KyIUzhgwX6ySTy0fEQOVnfRpcFlydUrq7+f4MvgDhic6soNm5qC03oISvk4+8ps/OK2
 waT0KBK9ScctIinaTbD/gjMs1OvTWon5RKz7l7dtHekdPSQinBkZA55wcLrqwitmc7UO0PiD
 oJ9JBluH2W111OMM5KufmRTwfiY=
X-Mailgun-Sending-Ip: 159.135.228.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df33b77.7f62fae9c618-smtp-out-n03;
 Fri, 13 Dec 2019 07:19:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 387CAC433CB; Fri, 13 Dec 2019 07:19:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from ybzhao-HP-Z230-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yiboz)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0E0AC43383;
        Fri, 13 Dec 2019 07:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0E0AC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: [PATCH 2/4] mac80211: fix issue in loop scenario
Date:   Fri, 13 Dec 2019 15:19:51 +0800
Message-Id: <1576221593-1086-3-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org>
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In a loop txqs dequeue scenario, if the first txq in the rbtree gets
removed from rbtree immediately in the ieee80211_return_txq(), the
loop will break soon in the ieee80211_next_txq() due to schedule_pos
not leading to the second txq in the rbtree. Thus update schedule_pos
to previous node once the node of schedule_pos is either removed from
rbtree or move to other location in rbtree due to airtime update.

Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/tx.c          | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a4556f9..ed85400 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -847,6 +847,7 @@ struct txq_info {
 	struct codel_stats cstats;
 	struct sk_buff_head frags;
 	struct rb_node schedule_order;
+	u16 schedule_round;
 	unsigned long flags;
 
 	/* keep last! */
@@ -1144,6 +1145,7 @@ struct ieee80211_local {
 	struct rb_node *schedule_pos[IEEE80211_NUM_ACS];
 	u64 airtime_v_t[IEEE80211_NUM_ACS];
 	u64 airtime_weight_sum[IEEE80211_NUM_ACS];
+	u16 schedule_round[IEEE80211_NUM_ACS];
 
 	u16 airtime_flags;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d00baaa..c1444e7 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3644,6 +3644,7 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 
 	lockdep_assert_held(&local->active_txq_lock[ac]);
 
+begin:
 	if (!node) {
 		node = rb_first_cached(&local->active_txqs[ac]);
 		first = true;
@@ -3668,7 +3669,10 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 		}
 	}
 
+	if (txqi->schedule_round == local->schedule_round[ac])
+		goto begin;
 
+	txqi->schedule_round = local->schedule_round[ac];
 	local->schedule_pos[ac] = node;
 	return &txqi->txq;
 }
@@ -3752,6 +3756,9 @@ void ieee80211_resort_txq(struct ieee80211_hw *hw,
 	u8 ac = txq->ac;
 
 	if (!RB_EMPTY_NODE(&txqi->schedule_order)) {
+		if (local->schedule_pos[ac] == &txqi->schedule_order)
+			local->schedule_pos[ac] = rb_prev(&txqi->schedule_order);
+
 		rb_erase_cached(&txqi->schedule_order,
 				&local->active_txqs[ac]);
 		RB_CLEAR_NODE(&txqi->schedule_order);
@@ -3771,6 +3778,9 @@ static void __ieee80211_unschedule_txq(struct ieee80211_hw *hw,
 	if (RB_EMPTY_NODE(&txqi->schedule_order))
 		return;
 
+	if (local->schedule_pos[ac] == &txqi->schedule_order)
+		local->schedule_pos[ac] = rb_prev(&txqi->schedule_order);
+
 	if (txq->sta) {
 		struct sta_info *sta = container_of(txq->sta,
 						    struct sta_info, sta);
@@ -3803,7 +3813,7 @@ void ieee80211_return_txq(struct ieee80211_hw *hw,
 	lockdep_assert_held(&local->active_txq_lock[txq->ac]);
 
 	if (!RB_EMPTY_NODE(&txqi->schedule_order) &&
-	    (skb_queue_empty(&txqi->frags) && !txqi->tin.backlog_packets))
+	    !txq_has_queue(&txqi->txq))
 		__ieee80211_unschedule_txq(hw, txq);
 }
 EXPORT_SYMBOL(ieee80211_return_txq);
@@ -3832,6 +3842,8 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 	struct ieee80211_local *local = hw_to_local(hw);
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
+	local->schedule_round[ac]++;
+
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 
-- 
1.9.1
