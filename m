Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95306F6D25
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjEDNpl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjEDNpk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:45:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F87AB7
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683207938; x=1714743938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mEejSuktN6EKsehrNC2bCysWPxi8n75r4ERiDRnjGnQ=;
  b=aAcQaYGo6P/+Qeo37aE0E0D4SKLcBs67j9wrsC37Zqsfhqd43+JgaLFX
   Vm8SWQZFjgbfraYQwrci5reTtNeaIWeF1j6PVhZk7egepgRoklcwR+CDc
   Yv54LZ7M+C9DfNr4WA83AAgkLKF1biqNyiqw/YTRhL4gUMApvaFEwBM8G
   W9yLG6YpNa+s44VMIAxN6VbeB8JSRzlTDEDJbRnSQJsr/6i9TvA7U2Mue
   OUbsgriVcnRliwgBocMdjS/2+lC2qfdR8EQSRK2VdYSfBD1P/6TeyV8pF
   +hmV8xYSv4V472o43HyzaTQFBgjC5zXPtLbcTzcZDo1/vG4YOS4nBiNs0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435242623"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435242623"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766591737"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766591737"
Received: from haddadra-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.238.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/11] wifi: mac80211: HW restart for MLO
Date:   Thu,  4 May 2023 16:45:05 +0300
Message-Id: <20230504134511.828474-6-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230504134511.828474-1-gregory.greenman@intel.com>
References: <20230504134511.828474-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Implement proper reconfiguration for interfaces that are
doing MLO, in order to be able to recover from HW restart
correctly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/util.c | 107 ++++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 34 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 4bf76150925d..ead4b095cc4d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2624,21 +2624,55 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
 	/* Finally also reconfigure all the BSS information */
 	list_for_each_entry(sdata, &local->interfaces, list) {
+		/* common change flags for all interface types - link only */
+		u32 changed = BSS_CHANGED_ERP_CTS_PROT |
+			      BSS_CHANGED_ERP_PREAMBLE |
+			      BSS_CHANGED_ERP_SLOT |
+			      BSS_CHANGED_HT |
+			      BSS_CHANGED_BASIC_RATES |
+			      BSS_CHANGED_BEACON_INT |
+			      BSS_CHANGED_BSSID |
+			      BSS_CHANGED_CQM |
+			      BSS_CHANGED_QOS |
+			      BSS_CHANGED_TXPOWER |
+			      BSS_CHANGED_MCAST_RATE;
+		struct ieee80211_link_data *link = NULL;
 		unsigned int link_id;
-		u32 changed;
+		u32 active_links = 0;
 
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
 		sdata_lock(sdata);
+		if (sdata->vif.valid_links) {
+			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS] = {
+				[0] = &sdata->vif.bss_conf,
+			};
+
+			if (sdata->vif.type == NL80211_IFTYPE_STATION) {
+				/* start with a single active link */
+				active_links = sdata->vif.active_links;
+				link_id = ffs(active_links) - 1;
+				sdata->vif.active_links = BIT(link_id);
+			}
+
+			drv_change_vif_links(local, sdata, 0,
+					     sdata->vif.active_links,
+					     old);
+		}
+
 		for (link_id = 0;
 		     link_id < ARRAY_SIZE(sdata->vif.link_conf);
 		     link_id++) {
-			struct ieee80211_link_data *link;
+			if (sdata->vif.valid_links &&
+			    !(sdata->vif.active_links & BIT(link_id)))
+				continue;
 
 			link = sdata_dereference(sdata->link[link_id], sdata);
-			if (link)
-				ieee80211_assign_chanctx(local, sdata, link);
+			if (!link)
+				continue;
+
+			ieee80211_assign_chanctx(local, sdata, link);
 		}
 
 		switch (sdata->vif.type) {
@@ -2658,42 +2692,42 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 					    &sdata->deflink.tx_conf[i]);
 			break;
 		}
-		sdata_unlock(sdata);
-
-		/* common change flags for all interface types */
-		changed = BSS_CHANGED_ERP_CTS_PROT |
-			  BSS_CHANGED_ERP_PREAMBLE |
-			  BSS_CHANGED_ERP_SLOT |
-			  BSS_CHANGED_HT |
-			  BSS_CHANGED_BASIC_RATES |
-			  BSS_CHANGED_BEACON_INT |
-			  BSS_CHANGED_BSSID |
-			  BSS_CHANGED_CQM |
-			  BSS_CHANGED_QOS |
-			  BSS_CHANGED_IDLE |
-			  BSS_CHANGED_TXPOWER |
-			  BSS_CHANGED_MCAST_RATE;
 
 		if (sdata->vif.bss_conf.mu_mimo_owner)
 			changed |= BSS_CHANGED_MU_GROUPS;
 
+		if (!sdata->vif.valid_links)
+			changed |= BSS_CHANGED_IDLE;
+
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_STATION:
-			changed |= BSS_CHANGED_ASSOC |
-				   BSS_CHANGED_ARP_FILTER |
-				   BSS_CHANGED_PS;
-
-			/* Re-send beacon info report to the driver */
-			if (sdata->deflink.u.mgd.have_beacon)
-				changed |= BSS_CHANGED_BEACON_INFO;
-
-			if (sdata->vif.bss_conf.max_idle_period ||
-			    sdata->vif.bss_conf.protected_keep_alive)
-				changed |= BSS_CHANGED_KEEP_ALIVE;
-
-			sdata_lock(sdata);
-			ieee80211_bss_info_change_notify(sdata, changed);
-			sdata_unlock(sdata);
+			if (!sdata->vif.valid_links) {
+				changed |= BSS_CHANGED_ASSOC |
+					   BSS_CHANGED_ARP_FILTER |
+					   BSS_CHANGED_PS;
+
+				/* Re-send beacon info report to the driver */
+				if (sdata->deflink.u.mgd.have_beacon)
+					changed |= BSS_CHANGED_BEACON_INFO;
+
+				if (sdata->vif.bss_conf.max_idle_period ||
+				    sdata->vif.bss_conf.protected_keep_alive)
+					changed |= BSS_CHANGED_KEEP_ALIVE;
+
+				if (sdata->vif.bss_conf.eht_puncturing)
+					changed |= BSS_CHANGED_EHT_PUNCTURING;
+
+				ieee80211_bss_info_change_notify(sdata,
+								 changed);
+			} else if (!WARN_ON(!link)) {
+				ieee80211_link_info_change_notify(sdata, link,
+								  changed);
+				changed = BSS_CHANGED_ASSOC |
+					  BSS_CHANGED_IDLE |
+					  BSS_CHANGED_PS |
+					  BSS_CHANGED_ARP_FILTER;
+				ieee80211_vif_cfg_change_notify(sdata, changed);
+			}
 			break;
 		case NL80211_IFTYPE_OCB:
 			changed |= BSS_CHANGED_OCB;
@@ -2728,6 +2762,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_NAN:
 			res = ieee80211_reconfig_nan(sdata);
 			if (res < 0) {
+				sdata_unlock(sdata);
 				ieee80211_handle_reconfig_failure(local);
 				return res;
 			}
@@ -2745,6 +2780,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			WARN_ON(1);
 			break;
 		}
+		sdata_unlock(sdata);
+
+		if (active_links)
+			ieee80211_set_active_links(&sdata->vif, active_links);
 	}
 
 	ieee80211_recalc_ps(local);
-- 
2.38.1

