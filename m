Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01E8789D28
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjH0LGi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjH0LGV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:06:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0561D109
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134378; x=1724670378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b/91OmF4nJmJ5sCwuCQMnbmm1LGL0ki/pXnWdJFED9o=;
  b=hGcx0ut0/6Sf9boFE2Dxf6wMOF6KZMW51/qxy3BmOps1Bs31pVLEoY5n
   3InchKR8mliWwrVLmKXH8gGqADjqA8vu1gGlUys/8VfhSq3F6xhg3ajru
   Jcm6G7tRPPq/7eaJpisiZ1Bdke0HpZOc+mQQ1+VGC1yhl++rdVQXlW8XF
   Y7P1QV+M90hKzd29+DN0+dJ1/0Scq+R0zr5p6v7Yj1FeuMBbIZGREbvvX
   JEJzKammsmeHLow1AbAcPzflQVwyryAaRJ32LQlJWk2WqmMszdf/HsZrr
   rMkF7eE+QOPTj5f2asTCcZhElM1MohVZN3xCB1/4gEF104rRUJVhHL7/6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301597"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301597"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881633029"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: mac80211: fix channel switch link data
Date:   Sun, 27 Aug 2023 14:05:32 +0300
Message-Id: <20230827135854.0b6a211c8e75.I5724d32bb2dae440888efbc47334d8c115db9d50@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230827110532.348304-1-gregory.greenman@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
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

Use the correct link ID and per-link puncturing data instead
of hardcoding link ID 0 and using deflink puncturing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/cfg.c  | 9 +++++----
 net/mac80211/mlme.c | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ae5017edd09f..3d5d9468ee68 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3668,7 +3668,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 		return ieee80211_link_use_reserved_context(&sdata->deflink);
 	}
 
-	if (!cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef,
+	if (!cfg80211_chandef_identical(&link_data->conf->chandef,
 					&link_data->csa_chandef))
 		return -EINVAL;
 
@@ -3684,7 +3684,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 		changed |= BSS_CHANGED_EHT_PUNCTURING;
 	}
 
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
+	ieee80211_link_info_change_notify(sdata, link_data, changed);
 
 	if (link_data->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
@@ -3696,8 +3696,9 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 	if (err)
 		return err;
 
-	cfg80211_ch_switch_notify(sdata->dev, &link_data->csa_chandef, 0,
-				  sdata->vif.bss_conf.eht_puncturing);
+	cfg80211_ch_switch_notify(sdata->dev, &link_data->csa_chandef,
+				  link_data->link_id,
+				  link_data->conf->eht_puncturing);
 
 	return 0;
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8abd4301f278..e4d229814911 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1782,7 +1782,8 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 		return;
 	}
 
-	cfg80211_ch_switch_notify(sdata->dev, &link->reserved_chandef, 0, 0);
+	cfg80211_ch_switch_notify(sdata->dev, &link->reserved_chandef,
+				  link->link_id, 0);
 }
 
 void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
-- 
2.38.1

