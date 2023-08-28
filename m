Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5702B78AFA0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjH1MGV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjH1MFs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B39123
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=z5i6fB9ver++WsAhzBdzLlLi4vnBA76X8vVFlKDB4S4=;
        t=1693224346; x=1694433946; b=RT+0G+gIfD0aMjqonR2XcNNTlBg/2xl+a/l6A6gSDSeslnI
        XUOdWx/1Wyhoqsuj4ztaZZd6LuuSuS+DHxLlMhEjbXGBJx9py+pjX2xbWITk+8zjdIi9kjIdyiv5w
        sy4sQfzlaQYPfE0HfmkXmnC+3NQTG0yT0slaKChUXcVu7axAGw9noQqxOzd9rw2dexkNxZubQCdmq
        /EAnS1KYWz2fdMPcjHTpC07ti8fpWL51v53LLTIV4hk1acW08tI7t0DUa+7i5wdPoNgzd49nEUEHV
        bs+rJW4hv5VBMJcxUyGCZaTzhY5UaBgfNTj1EKi2Xa3T/F2UAMiS5TFLRi+3VFLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab04-00Gjgt-0G;
        Mon, 28 Aug 2023 14:05:44 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 31/40] wifi: mac80211: extend wiphy lock in interface removal
Date:   Mon, 28 Aug 2023 13:59:59 +0200
Message-ID: <20230828135928.03669afb49e6.I65dfd43d490a20b079b03db2112bdfccaf731a17@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We want to extend the wiphy locking to the interface list,
so move that into the section locked with the wiphy lock.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index c528a4bb7f4f..a465a18bf3bd 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2274,6 +2274,8 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 	 */
 	cfg80211_shutdown_all_interfaces(local->hw.wiphy);
 
+	wiphy_lock(local->hw.wiphy);
+
 	WARN(local->open_count, "%s: open count remains %d\n",
 	     wiphy_name(local->hw.wiphy), local->open_count);
 
@@ -2283,7 +2285,6 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 	list_splice_init(&local->interfaces, &unreg_list);
 	mutex_unlock(&local->iflist_mtx);
 
-	wiphy_lock(local->hw.wiphy);
 	list_for_each_entry_safe(sdata, tmp, &unreg_list, list) {
 		bool netdev = sdata->dev;
 
-- 
2.41.0

