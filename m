Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202DC7A481A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbjIRLMX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbjIRLLr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40718FD
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035502; x=1726571502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zw4Wd1dchW8fstZola4H1xK/Lb1GY8rTsX0m/nAJ3/Y=;
  b=jompXlKqs/XMCnIDKrzDdwLNkEnp0/gnN6v2gFMqsicX4A13JahGRZfr
   vjwLggauHftPRmlZeMvBWV0yzjD7PCUopyi6Cjjbhg9F8cTIMNQCGSWso
   5eAN8fINJDAOG6Gxszf5bdzFcnX2lO+hmK+qOea7S+j5/98N5kvj/5+np
   L4GRCFbplFxoSv3xRxCYT2N8sFSHLqoTK4q6S1Z2+1yCN4psGCTkQn0Ly
   LGySx6yDhboJNXhhuMxXrf9+jpI1bk5jdAl6dS2L/8J7Os7lOa8c+hKeo
   v2fyhLwXEJiUla53qYkPePaU1o4OUNCWlnD1AFq5n607LZmU4aCN1jWRy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535772"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535772"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025321"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025321"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/18] wifi: mac80211: describe return values in kernel-doc
Date:   Mon, 18 Sep 2023 14:10:52 +0300
Message-Id: <20230918140607.46323481d647.Ibae386f0354f2e215d4955752ac378acc2466b51@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
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

