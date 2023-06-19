Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D26C73587B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 15:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjFSN1M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 09:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFSN1L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 09:27:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C9127
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181230; x=1718717230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kic8iWUAFicVvTvuOa0S3TWiqWH4AEXopDiJM+DfX2o=;
  b=oHE/QeIuIfB83a8VkbrwikVYf6QVUUO66fqfyq3m6u7nnKq7uxoW+hQ8
   6ODObaTUjlmroqK/WOlQgtmtsuJnGcCzPHWKzKagYxNF3elfjE8ECCTIM
   8wXz0ETVUxz1JO5sXF7tr+S80CxkixzzQ/Z+wqlqYhsAK3R6SB6WKYiIT
   levIkcjUp4rSmEAyz/8lVuhLM979N6lgJeXWg8Rg7LQWBdrNO4E+hvtWf
   qNRCEDTWLXRXXg8gJhY3iP4rdL/0RYdnEIcr1wh6ch8bpcOB/0lPeSlQI
   8yRvQ+zgJUSl6sOXoZ93QHUYjT4O35xOL1DImV71+smMAYxMuCi4ONs+z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339240653"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339240653"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="716871706"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716871706"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:08 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/9] wifi: mac80211: move action length check up
Date:   Mon, 19 Jun 2023 16:26:46 +0300
Message-Id: <20230619161906.e799254e923f.I0a1de5f6bbdc1b2ef5efaa0ac80c7c3f39415538@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619132653.902084-1-gregory.greenman@intel.com>
References: <20230619132653.902084-1-gregory.greenman@intel.com>
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

We'd like to add more checks to the function here for
action frames, so move up the length check from the
action processing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/rx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a2109d61487f..5c1d6c2674ef 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3355,6 +3355,11 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	if (!ieee80211_is_mgmt(mgmt->frame_control))
 		return RX_DROP_MONITOR;
 
+	/* drop too small action frames */
+	if (ieee80211_is_action(mgmt->frame_control) &&
+	    rx->skb->len < IEEE80211_MIN_ACTION_SIZE)
+		return RX_DROP_UNUSABLE;
+
 	if (rx->sdata->vif.type == NL80211_IFTYPE_AP &&
 	    ieee80211_is_beacon(mgmt->frame_control) &&
 	    !(rx->flags & IEEE80211_RX_BEACON_REPORTED)) {
@@ -3444,10 +3449,6 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	if (!ieee80211_is_action(mgmt->frame_control))
 		return RX_CONTINUE;
 
-	/* drop too small frames */
-	if (len < IEEE80211_MIN_ACTION_SIZE)
-		return RX_DROP_UNUSABLE;
-
 	if (!rx->sta && mgmt->u.action.category != WLAN_CATEGORY_PUBLIC &&
 	    mgmt->u.action.category != WLAN_CATEGORY_SELF_PROTECTED &&
 	    mgmt->u.action.category != WLAN_CATEGORY_SPECTRUM_MGMT)
-- 
2.38.1

