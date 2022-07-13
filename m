Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABC257335E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiGMJql (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbiGMJph (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EE7F788A
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gXqTGi2IeP86rpocotb869fVQKLe3fgrQDvRIYonHxs=;
        t=1657705527; x=1658915127; b=uLEAZGUtmX/H2MB1cGstKFQQ0NXb80G9qXj4IvV+cdpkXwc
        hRhRmnwKYUdhqnJlfzlkZ4Lg6nQ6AjfwC3ndZ9Wp3GfiWy3PlGrlh3pSYQI39P66IgucGn+julytC
        qgk6W3axIY5KnGN5S/FRXBHe5DxK1tGFv4VuHqtkDEmGTYPy6wfZpCmdk/E/Lvl7fG6j2wCxPwESa
        18FbFeapt5jICFp2EWVc81fqDSCk0APudGtBQKBtHXA3psVQZy+Wea1stZ3F8IebK6W8lImz6rL+p
        xnXb52ptlRSG4QImTlndM6G1MbBxrJcUb6xge51lf/VapiTbeS3F2mvWq8dAFh8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvt-00EgvB-Cz;
        Wed, 13 Jul 2022 11:45:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 59/76] wifi: mac80211: fix link manipulation
Date:   Wed, 13 Jul 2022 11:44:45 +0200
Message-Id: <20220713114426.d26055298480.Id13d50b4dd1ea6298282e4414611822996bba284@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we add non-deflink pointers, we need to remove the
link[0] pointer to deflink in case link[0] is not valid
afterwards. Also, we need to add that back when there
are no more valid links. Reorg the code to fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index fc5869f40279..271fc81a5ea4 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -463,6 +463,10 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 	if (old_links == new_links)
 		return 0;
 
+	/* if there were no old links, need to clear the pointers to deflink */
+	if (!old_links)
+		rem |= BIT(0);
+
 	/* allocate new link structures first */
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		link = kzalloc(sizeof(*link), GFP_KERNEL);
@@ -480,6 +484,22 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 	BUILD_BUG_ON(sizeof(old_data) != sizeof(sdata->link));
 	memcpy(old_data, sdata->link, sizeof(old_data));
 
+	/* grab old links to free later */
+	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		RCU_INIT_POINTER(sdata->link[link_id], NULL);
+		RCU_INIT_POINTER(sdata->vif.link_conf[link_id], NULL);
+
+		if (rcu_access_pointer(sdata->link[link_id]) == &sdata->deflink)
+			continue;
+		/*
+		 * we must have allocated the data through this path so
+		 * we know we can free both at the same time
+		 */
+		to_free[link_id] = container_of(rcu_access_pointer(sdata->link[link_id]),
+						typeof(*links[link_id]),
+						data);
+	}
+
 	/* link them into data structures */
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		WARN_ON(!use_deflink &&
@@ -490,10 +510,9 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		ieee80211_link_setup(&link->data);
 	}
 
-	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		RCU_INIT_POINTER(sdata->link[link_id], NULL);
-		RCU_INIT_POINTER(sdata->vif.link_conf[link_id], NULL);
-	}
+	if (new_links == 0)
+		ieee80211_link_init(sdata, -1, &sdata->deflink,
+				    &sdata->vif.bss_conf);
 
 	sdata->vif.valid_links = new_links;
 
@@ -506,25 +525,14 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		memcpy(sdata->link, old_data, sizeof(old_data));
 		memcpy(sdata->vif.link_conf, old, sizeof(old));
 		sdata->vif.valid_links = old_links;
-		/* and free the newly allocated links */
-		goto deinit;
+		/* and free (only) the newly allocated links */
+		memset(to_free, 0, sizeof(links));
+		goto free;
 	}
 
 	/* use deflink/bss_conf again if and only if there are no more links */
 	use_deflink = new_links == 0;
 
-	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		if (rcu_access_pointer(sdata->link[link_id]) == &sdata->deflink)
-			continue;
-		/*
-		 * we must have allocated the data through this path so
-		 * we know we can free both at the same time
-		 */
-		to_free[link_id] = container_of(rcu_access_pointer(sdata->link[link_id]),
-						typeof(*links[link_id]),
-						data);
-	}
-
 	goto deinit;
 free:
 	/* if we failed during allocation, only free all */
-- 
2.36.1

