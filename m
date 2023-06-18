Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC317347CB
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjFRSvF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFRSvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:51:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E458E65
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114257; x=1718650257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=855656UKU2YiFkYq5FSjC97RSZTgpiFcDeLEbCYVVFw=;
  b=JYDQSmvfAPo+8mfVW8+ujILpAUQpFEMRjssKmQoW7U5eWNfukZOugapK
   iariGL/XjCGMCCBcG3zRJO9RcsLRg4yQSKebdBBcvd7CUBpKoIaOIg5BE
   6I963QiehIugx4yhWgpk/VUDkJkJcMiE53c5N792O5xtQjgNvRXIdZIpK
   CrmPQVZk14YEq6z+gdG9vX0oY2Pli+CEF4nDskUAbhDONuMlVBjWCxgOM
   lwsHDcP/k1np+s1ry6qzGtptdrh/dSTb25gKC7IIQZgwne5sT5QafRWmn
   JrhOQg6ZSYWkSDS9XfkTtbabVooI2SsN5zFDQjmd3a4+oocXEX7IgvHMn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116669"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116669"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:57 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747234082"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747234082"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/20] wifi: mac80211: agg-tx: prevent start/stop race
Date:   Sun, 18 Jun 2023 21:49:58 +0300
Message-Id: <20230618214436.e5b52777462a.I0b2ed6658e81804279f5d7c9c1918cb1f6626bf2@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There were crashes reported in this code, and the timer_shutdown()
warning in one of the previous patches indicates that the timeout
timer for the AP response (addba_resp_timer) is still armed while
we're stopping the aggregation session.

After a very long deliberation of the code, so far the only way I
could find that might cause this would be the following sequence:
 - session start requested
 - session start indicated to driver, but driver returns
   IEEE80211_AMPDU_TX_START_DELAY_ADDBA
 - session stop requested, sets HT_AGG_STATE_WANT_STOP
 - session stop worker runs ___ieee80211_stop_tx_ba_session(),
   sets HT_AGG_STATE_STOPPING

From here on, the order doesn't matter exactly, but:

 1. driver calls ieee80211_start_tx_ba_cb_irqsafe(),
    setting HT_AGG_STATE_START_CB
 2. driver calls ieee80211_stop_tx_ba_cb_irqsafe(),
    setting HT_AGG_STATE_STOP_CB
 3. the worker will run ieee80211_start_tx_ba_cb() for
    HT_AGG_STATE_START_CB
 4. the worker will run ieee80211_stop_tx_ba_cb() for
    HT_AGG_STATE_STOP_CB

(the order could also be 1./3./2./4.)

This will cause ieee80211_start_tx_ba_cb() to send out the AddBA
request frame to the AP and arm the timer, but we're already in
the middle of stopping and so the ieee80211_stop_tx_ba_cb() will
no longer assume it needs to stop anything.

Prevent this by checking for WANT_STOP/STOPPING in the start CB,
and warn if we're sending a frame on a stopping session.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/agg-tx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 118ad2e24dbb..b6b772685881 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -457,6 +457,10 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 	u8 tid = tid_tx->tid;
 	u16 buf_size;
 
+	if (WARN_ON_ONCE(test_bit(HT_AGG_STATE_STOPPING, &tid_tx->state) ||
+			 test_bit(HT_AGG_STATE_WANT_STOP, &tid_tx->state)))
+		return;
+
 	lockdep_assert_held(&sta->ampdu_mlme.mtx);
 
 	/* activate the timer for the recipient's addBA response */
@@ -802,6 +806,10 @@ void ieee80211_start_tx_ba_cb(struct sta_info *sta, int tid,
 	if (WARN_ON(test_and_set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state)))
 		return;
 
+	if (test_bit(HT_AGG_STATE_STOPPING, &tid_tx->state) ||
+	    test_bit(HT_AGG_STATE_WANT_STOP, &tid_tx->state))
+		return;
+
 	if (!test_bit(HT_AGG_STATE_SENT_ADDBA, &tid_tx->state)) {
 		ieee80211_send_addba_with_timeout(sta, tid_tx);
 		/* RESPONSE_RECEIVED state whould trigger the flow again */
-- 
2.38.1

