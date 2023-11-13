Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F47E990D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 10:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjKMJf6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 04:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjKMJf5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 04:35:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B763010D3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 01:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699868153; x=1731404153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=62/PjcuircY3Bjw/q96rEBHhbbPvoz8DyZGFHiN940E=;
  b=CG5fucJ62u97LA3CsU+YplUuf6Gywn4EJIJK3aV7jHnUfPmVqwfzPMly
   9OlJi+1EZ6a8Nsw8l3rkh86ij7SdjkAxT5q5HNhY8sZG4hFlJhPigny+V
   UTkugpLC7FE6jbC+6cl/+tbdmlqtL5xmKz0FBaAbxPyiXDcDOWBCOKVj7
   Up1Va/RZmKc91XMlec4vsP3NDz436DQOcs5NzfKHzYw3PJvdATF+uavH3
   mkS1dAZTwQq6XXC3TmHXl7kZffOh8kk31oFBcUfdd853UC0TTBHqSiIo0
   97ERTJbESbIX6/Z+tfzh/nwzG+sj+hhAv+XJmI/0eQY/hfbXndpxNP4e2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369735711"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="369735711"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937695242"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937695242"
Received: from tdistelf-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.220.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:35:51 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/6] wifi: mac80211: Extend support for scanning while MLO connected
Date:   Mon, 13 Nov 2023 11:35:01 +0200
Message-Id: <20231113112844.68564692c404.Iae9605cbb7f9d52e00ce98260b3559a34cf18341@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231113093505.456824-1-gregory.greenman@intel.com>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

- If the scan request includes a link ID, validate that it is
  one of the active links. Otherwise, if the scan request doesn't
  include a valid link ID, select one of the active links.

- When reporting the TSF for a BSS entry, use the link ID information
  from the Rx status or the scan request to set the parent BSSID.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/scan.c | 48 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 24fa06105378..1d98877647d8 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -194,11 +194,32 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 	if (scan_sdata && scan_sdata->vif.type == NL80211_IFTYPE_STATION &&
 	    scan_sdata->vif.cfg.assoc &&
 	    ieee80211_have_rx_timestamp(rx_status)) {
-		bss_meta.parent_tsf =
-			ieee80211_calculate_rx_timestamp(local, rx_status,
-							 len + FCS_LEN, 24);
-		ether_addr_copy(bss_meta.parent_bssid,
-				scan_sdata->vif.bss_conf.bssid);
+		struct ieee80211_bss_conf *link_conf = NULL;
+
+		/* for an MLO connection, set the TSF data only in case we have
+		 * an indication on which of the links the frame was received
+		 */
+		if (ieee80211_vif_is_mld(&scan_sdata->vif)) {
+			if (rx_status->link_valid) {
+				s8 link_id = rx_status->link_id;
+
+				link_conf =
+					rcu_dereference(scan_sdata->vif.link_conf[link_id]);
+			}
+		} else {
+			link_conf = &scan_sdata->vif.bss_conf;
+		}
+
+		if (link_conf) {
+			bss_meta.parent_tsf =
+				ieee80211_calculate_rx_timestamp(local,
+								 rx_status,
+								 len + FCS_LEN,
+								 24);
+
+			ether_addr_copy(bss_meta.parent_bssid,
+					link_conf->bssid);
+		}
 	}
 	rcu_read_unlock();
 
@@ -666,6 +687,21 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 	if (local->scan_req)
 		return -EBUSY;
 
+	/* For an MLO connection, if a link ID was specified, validate that it
+	 * is indeed active. If no link ID was specified, select one of the
+	 * active links.
+	 */
+	if (ieee80211_vif_is_mld(&sdata->vif)) {
+		if (req->tsf_report_link_id >= 0) {
+			if (!(sdata->vif.active_links &
+			      BIT(req->tsf_report_link_id)))
+				return -EINVAL;
+		} else {
+			req->tsf_report_link_id =
+				__ffs(sdata->vif.active_links);
+		}
+	}
+
 	if (!__ieee80211_can_leave_ch(sdata))
 		return -EBUSY;
 
@@ -714,6 +750,8 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 		local->hw_scan_req->req.duration = req->duration;
 		local->hw_scan_req->req.duration_mandatory =
 			req->duration_mandatory;
+		local->hw_scan_req->req.tsf_report_link_id =
+			req->tsf_report_link_id;
 
 		local->hw_scan_band = 0;
 		local->hw_scan_req->req.n_6ghz_params = req->n_6ghz_params;
-- 
2.38.1

