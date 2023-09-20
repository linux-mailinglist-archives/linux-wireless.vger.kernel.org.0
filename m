Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCEF7A8BB2
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjITS04 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjITS0z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD15138
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234398; x=1726770398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VJrEtcDlDrFyWZ20cO2/Ef3pMAKc7EAIGJs/qzqKo0g=;
  b=eeoUJlxUr6Ngk9zYRY6ZhmvhXqeobByGb4xneJEoPhXODBEEqqhFZ/u1
   irHQUO07FHRkMs+arxXb+XeaFGajPG9Nluy6ad5gzAzhmrvePgFGeVHve
   S5tE1bAR54GwWWOYJQ5wbRRyA0jucTUrujNXHLSSGXQUAhsxe9b/4JPAX
   PYhOAyw7pKmOp/8frAyPifQSg9mURhQyn2qCJdLzRjoTHGjU9dOWzIRTG
   rUNksj+ODTxgWrKPr9uNlY290+C1gayn7DzRykXbPFZJuPYSvZvjitdm7
   f2jyEdKKAZHLvjtdZTMGdnbUE518XCgwV2eL3PMMXvkkcTw5oFpCIa4Pv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556420"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556420"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424252"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424252"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 11/18] wifi: mac80211: Notify the low level driver on change in MLO valid links
Date:   Wed, 20 Sep 2023 21:25:22 +0300
Message-Id: <20230920211508.4fc85b0a51b0.I64238e0e892709a2bd4764b3bca93cdcf021e2fd@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

Notify the low level driver when there is change in the valid links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/main.c    | 3 ++-
 net/mac80211/mlme.c    | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index be3d74942a4a..b3df8cb2919b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -341,6 +341,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_UNSOL_BCAST_PROBE_RESP: Unsolicited broadcast probe response
  *	status changed.
  * @BSS_CHANGED_EHT_PUNCTURING: The channel puncturing bitmap changed.
+ * @BSS_CHANGED_MLD_VALID_LINKS: MLD valid links status changed.
  */
 enum ieee80211_bss_change {
 	BSS_CHANGED_ASSOC		= 1<<0,
@@ -376,6 +377,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
 	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
 	BSS_CHANGED_EHT_PUNCTURING	= BIT_ULL(32),
+	BSS_CHANGED_MLD_VALID_LINKS	= BIT_ULL(33),
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index bf8f72c412ee..b46f4d733c5d 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -207,7 +207,8 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
 				   BSS_CHANGED_PS |\
 				   BSS_CHANGED_IBSS |\
 				   BSS_CHANGED_ARP_FILTER |\
-				   BSS_CHANGED_SSID)
+				   BSS_CHANGED_SSID |\
+				   BSS_CHANGED_MLD_VALID_LINKS)
 
 void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 				      u64 changed)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b480dd181a63..091ec0753df7 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5736,6 +5736,8 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 	if (ret)
 		sdata_info(sdata, "Failed setting valid links\n");
 
+	ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_MLD_VALID_LINKS);
+
 out:
 	if (!ret)
 		cfg80211_links_removed(sdata->dev, sdata->u.mgd.removed_links);
-- 
2.38.1

