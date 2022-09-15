Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA7D5B93B0
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 06:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIOEff (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 00:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOEfd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 00:35:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E339A5B079
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 21:35:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso16362539pjd.4
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 21:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qhBPM3R7FLR5q0HRTK6YpySwj/OPttofDxjVIeG32oM=;
        b=GHaI9CFX35FSfAvuiL9ALbNvzjUL5V/f/eMc2a3R6vMpZiT4z62KJ9gjnwW9+rowct
         O+kD1qaA8wruE+6qHJS7FK+RVzfWIT3BUWgKJW7emyETDzHfuoJO5ntR6raeSdr82eOv
         VIyZ99DsCeMgWVOiGAwXRBl7Nyozi5veqa8GwWlLKf7TOBjEIv9BFDEqcvo7koVi+WSA
         7n3cet2AXpJiK7fnxfMIQX2OAVRXAHomoNMElNjMj0BbjvX6yhFDG9lxBLNchBLLacNH
         hlZ8FQltJdxh/pbgNqviHFpzaNjW3+e1YDwSLZBSC71MyuZyki85ychj9EuPoOUIh9PB
         MRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qhBPM3R7FLR5q0HRTK6YpySwj/OPttofDxjVIeG32oM=;
        b=nl6BnY99zs+0OGm8SwQODNUGGXbqiCOgyqIyKfRKnwqanmPaIbzvhBj3lXv/OF7wp4
         gFohSweZMoECQRUfmFfdmNG07xF4UPj9LWl+EuCJiIwerlHnQXoyxRO7zYHOuQM0JieX
         0GZUmDd6AXHOPNWfGUo9UoqApoiAzfjZMEH9eEF/snpvaizBFfsEERN6iF44a1KyBoUW
         YHvn7jhyY81igtw1tMfw1c766P8UOCTMk8a26vuozHod8R6nrtIaQV7/VGJVTAsE5U0b
         zAembXz4RDE3QLXtvhKrBUqkcFCii/J4GwdvGq8RPW+XMSVg2nLimfWzPdJoywuwnuIR
         OQaA==
X-Gm-Message-State: ACrzQf2FSSpHB0kT9ElYMRvUm+fMk6G7SGOz7IXPEJSFOXmQ7SiaOHaf
        K02MGwHk3k1tinTXXV4B3ak=
X-Google-Smtp-Source: AMsMyM6+/FIyUeyv8krarPnIVJiUu4KZ+zwN6NVXUuy66jdySFpf+x+kiUd+JZv61Vh/aytWpDrk1A==
X-Received: by 2002:a17:903:2443:b0:178:221d:c599 with SMTP id l3-20020a170903244300b00178221dc599mr2558378pls.100.1663216532298;
        Wed, 14 Sep 2022 21:35:32 -0700 (PDT)
Received: from VenkatShasta.lan ([49.206.58.42])
        by smtp.gmail.com with ESMTPSA id x1-20020aa79a41000000b00536b2483aedsm9396991pfj.199.2022.09.14.21.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 21:35:31 -0700 (PDT)
From:   venkatch@gmail.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Venkat Chimata <venkata@shasta.cloud>
Subject: [PATCH v2] wifi: mac80211: Fix performance issue with mutex_lock
Date:   Thu, 15 Sep 2022 10:05:27 +0530
Message-Id: <20220915043527.737133-1-venkatch@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkat Chimata <venkata@shasta.cloud>

OpenWiFi's ucentral agent periodically (typically 120 seconds)
issues nl80211 call to get associated client list from the
WLAN driver. Somehow this operation was causing tx/rx delays
sometimes and the video calls on connected clients are experiencing
jitter. The associated client list was protected by
a mutex lock. I saw that ieee80211_check_fast_xmit_all uses
rcu_read_lock and rcu_read_unlock to iterate through sta_list.
I took it as a refernce and changed the lock to rcu_read lock
from mutex.
Also saw this this comment just above sta_mutex declaration.
        /* Station data */
        /*
         * The mutex only protects the list, hash table and
         * counter, reads are done with RCU.
         */
        struct mutex sta_mtx;

Hence tried changing mutex_lock(/unlock) in ieee80211_dump_station
to rcu_read_lock(/unlock) and it resolved the jitter issue in the
video calls.

Tests:
We had this issue show up consistently and the patch fixed the issue.
We spent a good part of 2 weeks following up on this and with this
fix, the video calls are smooth.

Also tested if this could cause any crashes with below mentioned
process.

1. Connect 3 clients
2. A script running dumping clients in an infinite loop
3. Continuously disconnect / connect one client to see if
   there is any crash. No crash was observed.

---
v2:
* Resolve warning
 net/mac80211/cfg.c:858:33: warning:
 unused variable 'local' [-Wunused-variable]
 ---

Signed-off-by: Venkat Chimata <venkata@shasta.cloud>
---
 net/mac80211/cfg.c      | 7 ++-----
 net/mac80211/sta_info.c | 3 +--
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6a8350d..a005364 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -790,20 +790,17 @@ static int ieee80211_dump_station(struct wiphy *wiphy, struct net_device *dev,
 				  int idx, u8 *mac, struct station_info *sinfo)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 	int ret = -ENOENT;
 
-	mutex_lock(&local->sta_mtx);
-
+	rcu_read_lock();
 	sta = sta_info_get_by_idx(sdata, idx);
 	if (sta) {
 		ret = 0;
 		memcpy(mac, sta->sta.addr, ETH_ALEN);
 		sta_set_sinfo(sta, sinfo, true);
 	}
-
-	mutex_unlock(&local->sta_mtx);
+	rcu_read_unlock();
 
 	return ret;
 }
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 550a610..af6fa75 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -231,8 +231,7 @@ struct sta_info *sta_info_get_by_idx(struct ieee80211_sub_if_data *sdata,
 	struct sta_info *sta;
 	int i = 0;
 
-	list_for_each_entry_rcu(sta, &local->sta_list, list,
-				lockdep_is_held(&local->sta_mtx)) {
+	list_for_each_entry_rcu(sta, &local->sta_list, list) {
 		if (sdata != sta->sdata)
 			continue;
 		if (i < idx) {
-- 
2.34.1

