Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE77B1FC6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjI1Ogc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjI1Ogb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A17CC1
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911789; x=1727447789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jSk3eOIjdWrZ/vH5KLjnPp2uVqLfFKxMw6oRBzvY328=;
  b=PXCmdrozJ26JOba2Wj9uBMQ4oLMcQryf4vv4I/50zewJX+MaBZ5xfZni
   6nwMT/+tzN4r5ECvoduWwM+LPQcAZwWg/kcOJXPFWlTfb/UzQM6hgHOcb
   ul6X2WjtP8OmGtTCDDdIjOH00f67uEYI2qk9mh9nnJp/8EeJUoxEk7Nhh
   NlcHqg4zm32OSFyrYdfa4BOF1hwM5EiAewqjS8WktyLrYXr4GHib+R2CY
   sFK5fn5LLLslJNuJHUu+hYinVQoO/AqVQr8zRZgnYzra7iML6ny7h5LA7
   BQzHzye5FlYCx0bnc5mKE0lYbQP1+sBu2RtBIxTXLWERzRnwYbmH9+m0L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688507"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688507"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590541"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590541"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:27 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/18] wifi: mac80211: fix a expired vs. cancel race in roc
Date:   Thu, 28 Sep 2023 17:35:36 +0300
Message-Id: <20230928172905.4e4469be20ac.Iab0525f5cc4698acf23eab98b8b1eec02099cde0@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When the remain on channel is removed at the time it should
have expired, we have a race: the driver could be handling
the flow of the expiration while mac80211 is cancelling
that very same remain on channel request.

This wouldn't be problem in itself, but since mac80211
can send the next request to the driver in the cancellation
flow, we can get to the following situation:

           CPU0                             CPU1
expiration of roc in driver
ieee80211_remain_on_channel_expired()
                                         Cancellation of the roc
schedules a worker (hw_roc_done)
                                         Add next roc
hw_roc_done_wk runs and ends
the second roc prematurely.

Since, by design, there is only one single request sent to the
driver at a time, we can safely assume that after the cancel()
request returns from the driver, we should not handle any worker
that handles the expiration of the request.

Cancel the hw_roc_done worker after the cancellation to make
sure we start the next one with a clean slate.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/offchannel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 071582dbe6a5..6c4080202573 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -717,6 +717,23 @@ static int ieee80211_cancel_roc(struct ieee80211_local *local,
 			return ret;
 		}
 
+		/*
+		 * We could be racing against the notification from the driver:
+		 *  + driver is handling the notification on CPU0
+		 *  + user space is cancelling the remain on channel and
+		 *    schedules the hw_roc_done worker.
+		 *
+		 *  Now hw_roc_done might start to run after the next roc will
+		 *  start and mac80211 will think that this second roc has
+		 *  ended prematurely.
+		 *  Cancel the work to make sure that all the pending workers
+		 *  have completed execution.
+		 *  Note that this assumes that by the time the driver returns
+		 *  from drv_cancel_remain_on_channel, it has completed all
+		 *  the processing of related notifications.
+		 */
+		wiphy_work_cancel(local->hw.wiphy, &local->hw_roc_done);
+
 		/* TODO:
 		 * if multiple items were combined here then we really shouldn't
 		 * cancel them all - we should wait for as much time as needed
-- 
2.38.1

