Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1297B1FCD
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjI1Ogh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjI1Ogf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDC3136
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911793; x=1727447793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JqpogA/1oBry8Te1FOBRhqJenWCszhZsBQE3v+8qxbE=;
  b=emHnA9dVE6WZBReWxS5jpA+vFOEvyzGxVN6ui5nsNuoOH6x7SupvyYhN
   vrt0kdoXxzjwJs46ury46lWqqjiZq3WhotGs4n2izeE5f+gpdKcx/+dMo
   KBBdTzkAt0RVj9Fmo/OJUwQo3cmfjR4lksF/AFkNYn/Dau5/9L8SwfcE9
   T7qODmRSBCt3fJmeADJArpdeG8iqtxsj52cuo1MX0CvVPjt1JhdeHmte2
   xATjvDbus3VQerruPFkYGE8qrJsNw4uOq5FEkl3AhHIzKmg/tzJPDmP/M
   HjCpwkC7WMg/kadhvLKVdsf0OI6lRjnLhBrBwKXLntxSnRguhOzAEwOIp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688536"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688536"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590567"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590567"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/18] wifi: mac80211: purge TX queues in flush_queues flow
Date:   Thu, 28 Sep 2023 17:35:38 +0300
Message-Id: <20230928172905.8fc2ee23e56f.I8b3f6def9c28ea96261e2d31df8786986fb5385b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

When this flow is invoked with the "drop" parameter as true,
we only drop the frames from the hw queues, but not from the
sw queues.
So when we call wake_queues() after hw queue purging, all the
frames from the sw queues will be TX'ed,
when what we actually want to do is to purge all queues
in order to not TX anything...
This can cause, for example, TXing data frames to the peer
after the deauth frame was sent.
Fix this by purging the sw queues in addition to the hw queues
if the drop parameter is true.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/sta_info.c    | 28 ++++++++++++++++++----------
 net/mac80211/util.c        | 13 +++++++++++++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eb459a6a76f5..4f9afa2fe0e9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2390,6 +2390,7 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 			struct txq_info *txq, int tid);
 void ieee80211_txq_purge(struct ieee80211_local *local,
 			 struct txq_info *txqi);
+void ieee80211_purge_sta_txqs(struct sta_info *sta);
 void ieee80211_txq_remove_vlan(struct ieee80211_local *local,
 			       struct ieee80211_sub_if_data *sdata);
 void ieee80211_fill_txq_stats(struct cfg80211_txq_stats *txqstats,
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index ba36fc29e532..450700173422 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -113,6 +113,23 @@ static int link_sta_info_hash_del(struct ieee80211_local *local,
 			       &link_sta->link_hash_node, link_sta_rht_params);
 }
 
+void ieee80211_purge_sta_txqs(struct sta_info *sta)
+{
+	struct ieee80211_local *local = sta->sdata->local;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
+		struct txq_info *txqi;
+
+		if (!sta->sta.txq[i])
+			continue;
+
+		txqi = to_txq_info(sta->sta.txq[i]);
+
+		ieee80211_txq_purge(local, txqi);
+	}
+}
+
 static void __cleanup_single_sta(struct sta_info *sta)
 {
 	int ac, i;
@@ -139,16 +156,7 @@ static void __cleanup_single_sta(struct sta_info *sta)
 		atomic_dec(&ps->num_sta_ps);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
-		struct txq_info *txqi;
-
-		if (!sta->sta.txq[i])
-			continue;
-
-		txqi = to_txq_info(sta->sta.txq[i]);
-
-		ieee80211_txq_purge(local, txqi);
-	}
+	ieee80211_purge_sta_txqs(sta);
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		local->total_ps_buffered -= skb_queue_len(&sta->ps_tx_buf[ac]);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 98a3bffc6991..b6be18710441 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -693,6 +693,19 @@ void __ieee80211_flush_queues(struct ieee80211_local *local,
 					IEEE80211_QUEUE_STOP_REASON_FLUSH,
 					false);
 
+	if (drop) {
+		struct sta_info *sta;
+
+		/* Purge the queues, so the frames on them won't be
+		 * sent during __ieee80211_wake_queue()
+		 */
+		list_for_each_entry(sta, &local->sta_list, list) {
+			if (sdata != sta->sdata)
+				continue;
+			ieee80211_purge_sta_txqs(sta);
+		}
+	}
+
 	drv_flush(local, sdata, queues, drop);
 
 	ieee80211_wake_queues_by_reason(&local->hw, queues,
-- 
2.38.1

