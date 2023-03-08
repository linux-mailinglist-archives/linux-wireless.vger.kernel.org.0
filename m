Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022DF6B167D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 00:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCHX0O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 18:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCHX0M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 18:26:12 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3955518
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 15:26:11 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8871BB80067
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 23:26:09 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 09A5E13C2B0;
        Wed,  8 Mar 2023 15:26:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 09A5E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1678317969;
        bh=W92O/HCLG/YQJ2xNJsJQgMOAQsfHeY4ozR920rE2008=;
        h=From:To:Cc:Subject:Date:From;
        b=TjEXMBoaXuycEJS+Wyxy/FDLCfa2Tb1Mwgw1t4VvO0n0ta0v82QeBjZ3E/bgPyz++
         ILEneauxweGYYGGLM1JBI1OV0VyT+lmAowqiEr1NPljO1rzMq8DdsPJReISVFg+jjT
         mKgC54a6fns4kA1h3+uks4TCBxQTBj/e5K/TTcw4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211: Allow some cleanup even if sdata-not-in-driver
Date:   Wed,  8 Mar 2023 15:26:06 -0800
Message-Id: <20230308232606.2672652-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1678317970-n-dLGOg_9hPD
X-MDID-O: us5;ut7;1678317970;n-dLGOg_9hPD;<greearb@candelatech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

When ax210 firmware crashes and radio cannot recover, sometimes
use-after-free errors are seen due to txqs not being properly cleanedup
(I think).

Logging shows that the sdata-not-in-driver checks are stopping cleanup
actions from happening.

So, instead warn but allow calls to the driver to clean up objects
even if sdata-not-in-driver is true.

This appears to help this problem, but system is still crashing (perhaps
due to not directly related problems), so this patch needs review before
going upstream.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/driver-ops.c |  5 +++--
 net/mac80211/driver-ops.h | 14 +++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index a94e281bbb8e..6685c89e87f6 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -105,8 +105,9 @@ void drv_remove_interface(struct ieee80211_local *local,
 {
 	might_sleep();
 
-	if (!check_sdata_in_driver(sdata))
-		return;
+	if (!check_sdata_in_driver(sdata)) {
+		pr_err("drv-remove-interface, sdata-not-in-driver, but will continue in hopes it cleans something up.\n");
+	}
 
 	trace_drv_remove_interface(local, sdata);
 	local->ops->remove_interface(&local->hw, &sdata->vif);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index a8924a6de1ee..81b8886db972 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -513,8 +513,9 @@ static inline void drv_sta_pre_rcu_remove(struct ieee80211_local *local,
 	might_sleep();
 
 	sdata = get_bss_sdata(sdata);
-	if (!check_sdata_in_driver(sdata))
-		return;
+	if (!check_sdata_in_driver(sdata)) {
+		pr_err("drv-sta-pre-rcu-remove, sdata-not-in-driver, but will continue in hopes it cleans something up.\n");
+	}
 
 	trace_drv_sta_pre_rcu_remove(local, sdata, &sta->sta);
 	if (local->ops->sta_pre_rcu_remove)
@@ -632,8 +633,9 @@ static inline void drv_flush(struct ieee80211_local *local,
 
 	might_sleep();
 
-	if (sdata && !check_sdata_in_driver(sdata))
-		return;
+	if (sdata && !check_sdata_in_driver(sdata)) {
+		pr_err("drv_flush, sdata-not-in-driver, but will continue in hopes it cleans something up.\n");
+	}
 
 	trace_drv_flush(local, queues[0], drop);
 	/* NOTE:  Only ath10k might want more queues than fits in 32-bits,
@@ -870,8 +872,10 @@ drv_mgd_protect_tdls_discover(struct ieee80211_local *local,
 {
 	might_sleep();
 
-	if (!check_sdata_in_driver(sdata))
+	if (!check_sdata_in_driver(sdata)) {
+		pr_err("drv-unassing-vif-chantx, sdata-not-in-driver, but will continue in hopes it cleans something up.\n");
 		return;
+	}
 	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION);
 
 	trace_drv_mgd_protect_tdls_discover(local, sdata);
-- 
2.39.1

