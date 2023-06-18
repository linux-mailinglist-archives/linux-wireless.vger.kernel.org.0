Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064147347CA
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjFRSu6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFRSu6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D261A4
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114253; x=1718650253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zGn7Y5fq2t/kN0R/So8gzao+cFubxpUr9JVV4h77WQs=;
  b=BVTwblnR8xMRVLI0kN6ahRPil9/NhopUjKHNS62MeJFKQ5XP7DQYVmrx
   pF3K5HD4zcP/RoSYaJDVx7jd7C06qgD8WeqYq94Sbb83bI78JF/vtTmCr
   S7ONUhgckAoBr8t5Dc5n2u5wR9sCTwUdGn58cVsHLdo/ISJPUOI+QC1E8
   abzxwjWqHyJgJsNrnnuqIKnkT6qfcGPwIxYV08nTnocTIpDWEBOTykPJQ
   ifdpmtxStHtOQIxO2w7MfNk9dauQrWl+vXEKutV0RASiuRzxsEh35/Ezy
   eVkNGwu5pdZRgxZdbygONG92bOThSYc4p420joBUgJ7oukl/UwCUB+xIY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116664"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116664"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:52 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747234066"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747234066"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/20] wifi: mac80211: agg-tx: add a few locking assertions
Date:   Sun, 18 Jun 2023 21:49:57 +0300
Message-Id: <20230618214436.7f03dec6a90b.I762c11e95da005b80fa0184cb1173b99ec362acf@changeid>
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

This is all true today, but difficult to understand since
the callers are in other files etc. Add two new lockdep
assertions to make things easier to read.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/agg-tx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 3b651e7f5a73..118ad2e24dbb 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -457,6 +457,8 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 	u8 tid = tid_tx->tid;
 	u16 buf_size;
 
+	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+
 	/* activate the timer for the recipient's addBA response */
 	mod_timer(&tid_tx->addba_resp_timer, jiffies + ADDBA_RESP_INTERVAL);
 	ht_dbg(sdata, "activated addBA response timer on %pM tid %d\n",
@@ -795,6 +797,8 @@ void ieee80211_start_tx_ba_cb(struct sta_info *sta, int tid,
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
 
+	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+
 	if (WARN_ON(test_and_set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state)))
 		return;
 
-- 
2.38.1

