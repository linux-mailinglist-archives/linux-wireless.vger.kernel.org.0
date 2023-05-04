Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190BE6F6D2B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjEDNp6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjEDNp5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:45:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC027EFF
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683207950; x=1714743950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SQEi17CQU0rYHdBcmNkcGmN59JlItb1qMiPC34eL6jE=;
  b=SLDt81fMe02r4hlEmjwzBzp6Qc01udV+OAuuWiQJtQTyxaekcYxLEk70
   s915f+m/Y08W7uKvWuUg/9s0cH8C2VEafjVwvak/7ZnXLXg/FzQoOY8T5
   3SlTtb4m3EdSwYdJEf80qqVTnfLY5shQVK3DLjkMaV7T8mYMSV4UqYhSH
   Ifl2glZ02/ruClc2YKKH7ufWrzl1d0e+Pj03uCQ7tt+woJxEKIdJdjp6E
   kVFA4IVa9jRByFkGRdiSNkkuofRkYm/M7Rc/nLwqXD7aq0VLpmp/spUsO
   h4Kefnm77fLFtaoT/FZbcx6tQ9lO3yUjWtu93YovgBCFSGWT3barULLkw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435242705"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435242705"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766591892"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766591892"
Received: from haddadra-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.238.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/11] wifi: mac80211: implement proper AP MLD HW restart
Date:   Thu,  4 May 2023 16:45:11 +0300
Message-Id: <20230504134511.828474-12-gregory.greenman@intel.com>
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

Previously, I didn't implement restarting here at all if the
interface is an MLD, so it only worked for non-MLO. Add the
needed code to restart an AP MLD correctly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/util.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b0c035cf13da..cd323fbea8df 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2475,6 +2475,35 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 	return 0;
 }
 
+static void ieee80211_reconfig_ap_links(struct ieee80211_local *local,
+					struct ieee80211_sub_if_data *sdata,
+					u32 changed)
+{
+	int link_id;
+
+	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
+		struct ieee80211_link_data *link;
+
+		if (!(sdata->vif.active_links & BIT(link_id)))
+			continue;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link)
+			continue;
+
+		if (rcu_access_pointer(link->u.ap.beacon))
+			drv_start_ap(local, sdata, link->conf);
+
+		if (!link->conf->enable_beacon)
+			continue;
+
+		changed |= BSS_CHANGED_BEACON |
+			   BSS_CHANGED_BEACON_ENABLED;
+
+		ieee80211_link_info_change_notify(sdata, link, changed);
+	}
+}
+
 int ieee80211_reconfig(struct ieee80211_local *local)
 {
 	struct ieee80211_hw *hw = &local->hw;
@@ -2737,7 +2766,13 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			changed |= BSS_CHANGED_IBSS;
 			fallthrough;
 		case NL80211_IFTYPE_AP:
-			changed |= BSS_CHANGED_SSID | BSS_CHANGED_P2P_PS;
+			changed |= BSS_CHANGED_P2P_PS;
+
+			if (sdata->vif.valid_links)
+				ieee80211_vif_cfg_change_notify(sdata,
+								BSS_CHANGED_SSID);
+			else
+				changed |= BSS_CHANGED_SSID;
 
 			if (sdata->vif.bss_conf.ftm_responder == 1 &&
 			    wiphy_ext_feature_isset(sdata->local->hw.wiphy,
@@ -2747,6 +2782,13 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			if (sdata->vif.type == NL80211_IFTYPE_AP) {
 				changed |= BSS_CHANGED_AP_PROBE_RESP;
 
+				if (sdata->vif.valid_links) {
+					ieee80211_reconfig_ap_links(local,
+								    sdata,
+								    changed);
+					break;
+				}
+
 				if (rcu_access_pointer(sdata->deflink.u.ap.beacon))
 					drv_start_ap(local, sdata,
 						     sdata->deflink.conf);
-- 
2.38.1

