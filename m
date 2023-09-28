Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055097B1FCE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjI1Ogj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjI1Ogh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E0A136
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911796; x=1727447796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ua4ZGso1xaLXHXSvTBiuX2m7cSG81XStHJwmvnLVE9A=;
  b=A3+R0Z/9mUl1flaXFHQuOgMGtrL+aKkyuBJ0lFNkm1PqAG0JliogReEY
   325cYx1bUn5NcHHxMR+svzeMvCNX26IzkwQzs9nam4hrwg08pKK9q7BvC
   hnklCSYMY1ksDoH2nfuc3Xa8eTUGVK8aSa4go/VpDpfRxvF80R7cwxyXi
   KTc33WHZ1+ldRD57fppyqbCoP7LYtpP+AbqFQxV6OVUF0/M54cHkqHFwp
   UFdjya6vkeYO+/yBBit2vIKsheTCnAIJ6Z30FN+i1XvwDqmZf3EvmsTZU
   Lb15qGU1eu0rd1EEhOqtzSLJtEyY6oCZeskG8cQkcPUQKwaAUqvJlOSoi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688554"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688554"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590579"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590579"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/18] wifi: mac80211: flush STA queues on unauthorization
Date:   Thu, 28 Sep 2023 17:35:39 +0300
Message-Id: <20230928172905.d47f528829e7.I96903652c7ee0c5c66891f8b2364383da8e45a1f@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

When the station is marked as no longer authorized, we shouldn't
transmit to it any longer, but in particular we shouldn't be able
to transmit to it after removing keys, which might lead to frames
being sent out unencrypted depending on the exact hardware offload
mechanism. Thus, instead of flushing only on station destruction,
which covers only some cases, always flush on unauthorization.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/sta_info.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 450700173422..0ba613dd1cc4 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1275,6 +1275,8 @@ static int _sta_info_move_state(struct sta_info *sta,
 				enum ieee80211_sta_state new_state,
 				bool recalc)
 {
+	struct ieee80211_local *local = sta->local;
+
 	might_sleep();
 
 	if (sta->sta_state == new_state)
@@ -1350,6 +1352,24 @@ static int _sta_info_move_state(struct sta_info *sta,
 		} else if (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
 			ieee80211_vif_dec_num_mcast(sta->sdata);
 			clear_bit(WLAN_STA_AUTHORIZED, &sta->_flags);
+
+			/*
+			 * If we have encryption offload, flush (station) queues
+			 * (after ensuring concurrent TX completed) so we won't
+			 * transmit anything later unencrypted if/when keys are
+			 * also removed, which might otherwise happen depending
+			 * on how the hardware offload works.
+			 */
+			if (local->ops->set_key) {
+				synchronize_net();
+				if (local->ops->flush_sta)
+					drv_flush_sta(local, sta->sdata, sta);
+				else
+					ieee80211_flush_queues(local,
+							       sta->sdata,
+							       false);
+			}
+
 			ieee80211_clear_fast_xmit(sta);
 			ieee80211_clear_fast_rx(sta);
 		}
@@ -1415,18 +1435,6 @@ static void __sta_info_destroy_part2(struct sta_info *sta, bool recalc)
 		WARN_ON_ONCE(ret);
 	}
 
-	/* Flush queues before removing keys, as that might remove them
-	 * from hardware, and then depending on the offload method, any
-	 * frames sitting on hardware queues might be sent out without
-	 * any encryption at all.
-	 */
-	if (local->ops->set_key) {
-		if (local->ops->flush_sta)
-			drv_flush_sta(local, sta->sdata, sta);
-		else
-			ieee80211_flush_queues(local, sta->sdata, false);
-	}
-
 	/* now keys can no longer be reached */
 	ieee80211_free_sta_keys(local, sta);
 
-- 
2.38.1

