Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03E25B8706
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiINLJo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Sep 2022 07:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiINLJm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Sep 2022 07:09:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0C13E1A
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 04:09:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so9151752pjk.4
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tcUxPuwcwfufFHuF+JKAubqLO88KJPHzuJbwH0zC7XQ=;
        b=KWthKO1JcQDn79Ws56Ork6MuRKJZSctpZuTCC+yRJjaYmEyPJm542nbVtXvoK1Nd5Y
         FJcP5FflRxs2feXXjgikAmRTYinHHi6KcwxLXFO8HkT6R7TQ2zIVTg1pkJ1ZhP5AumcX
         mYHMeLXTHS36qTCc+rVBWa5057qaZdxqOiZYx5pbDE/dwa0tD3//UGajLt+pnNOWPDiR
         zUPQ9x7z/V8kxYZGfW9/eJvp79UdXb7vip9QnmY1xsNMbmEJ2XXQEXKwNSgk5qgmlLop
         x5GxDen7JuWcTAKqo7KiXNcwOUGw0Pk2mf9biCqS38kv3T8sRtGla1djoC3eo4iFHBr1
         DBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tcUxPuwcwfufFHuF+JKAubqLO88KJPHzuJbwH0zC7XQ=;
        b=fiHiQB8NG1JgZcfqc5qvU7tx4PwEbHQtrKk/72R6OmxzV8S5Iv7p8+8oGr4RhVeJxs
         X+V2dR7GCAuYw5kVlaerQxjrtVFMCGWZuESbec3E7ActhBBtQOirh4R6KqkiZZakVlW9
         iq9aJ+VcjiRAE3Sr8Ss7ZucpK9mSadLBuXoBxbLL8hTG/xsUnDXIARTuIkqQ8kICYIpq
         q1vFx2NjnxlyJ3ANE78jvBBeshoGjr49CtTYRboLPFZVfB1mpFiQwoze/I7o+P2FvAmG
         AurJiharjc3PNr1hRZFUfFmKQu9r9JH1KNiYlKHbxPN4ARLNNsE4KqtfhrKdJg7LQ7LI
         dKyw==
X-Gm-Message-State: ACrzQf0ksCrRjhOYjqkfYr6hgmYZRy8iYPtfmmV567glqlbhn0O89u/t
        K5aTlqBfjRR50ec7eKW2Z6Q=
X-Google-Smtp-Source: AA6agR57IY6ynCMDiu+fpOZ0dks2Vzk6YFlcr/kNC40C1S3h2hyYN0vjPxbzYG82LHVlPG00G8ukmg==
X-Received: by 2002:a17:90b:4a06:b0:202:c03b:eb5c with SMTP id kk6-20020a17090b4a0600b00202c03beb5cmr4358392pjb.6.1663153779693;
        Wed, 14 Sep 2022 04:09:39 -0700 (PDT)
Received: from VenkatShasta.lan ([49.206.58.42])
        by smtp.gmail.com with ESMTPSA id c17-20020a63ea11000000b0042988a04bfdsm9448342pgi.9.2022.09.14.04.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:09:39 -0700 (PDT)
From:   venkatch@gmail.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, victorg@ti.com,
        Venkat Chimata <venkata@shasta.cloud>
Subject: [PATCH] wifi: mac80211: Fix performance issue with mutex_lock
Date:   Wed, 14 Sep 2022 16:39:34 +0530
Message-Id: <20220914110934.617430-1-venkatch@gmail.com>
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

Signed-off-by: Venkat Chimata <venkata@shasta.cloud>
---
 net/mac80211/cfg.c      | 6 ++----
 net/mac80211/sta_info.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6a8350d..0b526b5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -794,16 +794,14 @@ static int ieee80211_dump_station(struct wiphy *wiphy, struct net_device *dev,
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

