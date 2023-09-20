Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2F67A8BAD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjITS0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjITS0e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8ECD8
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234388; x=1726770388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zw4Wd1dchW8fstZola4H1xK/Lb1GY8rTsX0m/nAJ3/Y=;
  b=XOBEycbckF0GEPnuD3ZFdGfjlWZJoOpdfb2fjmIJdZJkLoAsvNzZ+Ak9
   MeDSjp3534y+IPOzuH0ZSxZOHyapTHGZFwUMn3P+ajzpdKBwhX2iN7+4l
   4uI/ahqG29cTBqb6QtbZKGHBoOdCF2qZQSXaF2EdXyj+2uYr6ABgH/JDJ
   fsndHZ2cP7IsEul+GPk4uItUZAfuAjFWKFfy6qP9XkqkGfAdOA4mBTfeJ
   DD3107QU5dQo9U+I8mKpdqXzcfL3q9WPaMWHRYc7v8859PZVEGZp3l8Ii
   0y32WwFJ+adwRj3T3t5nxMf2EPUkpoBfZoJg8dTVWzK7Pr/skdHf878L3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556353"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556353"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424231"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424231"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:27 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 07/18] wifi: mac80211: describe return values in kernel-doc
Date:   Wed, 20 Sep 2023 21:25:18 +0300
Message-Id: <20230920211508.79307c341723.Ibae386f0354f2e215d4955752ac378acc2466b51@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add descriptions for two return values for two functions
that are missing them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/tx.c   | 2 ++
 net/mac80211/util.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 9b845fbf923c..932516f8cc13 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4474,6 +4474,8 @@ static void ieee80211_mlo_multicast_tx(struct net_device *dev,
  * @dev: incoming interface
  *
  * On failure skb will be freed.
+ *
+ * Returns: the netdev TX status (but really only %NETDEV_TX_OK)
  */
 netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 				       struct net_device *dev)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a1e18938ce52..97c5823da0eb 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4146,6 +4146,8 @@ u8 ieee80211_mcs_to_chains(const struct ieee80211_mcs_info *mcs)
  * This function calculates the RX timestamp at the given MPDU offset, taking
  * into account what the RX timestamp was. An offset of 0 will just normalize
  * the timestamp to TSF at beginning of MPDU reception.
+ *
+ * Returns: the calculated timestamp
  */
 u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 				     struct ieee80211_rx_status *status,
-- 
2.38.1

