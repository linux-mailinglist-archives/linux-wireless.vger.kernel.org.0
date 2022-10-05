Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DC35F54EB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJENBf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJENA7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD57B2CDFA
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xRkrtuwYnKvPIX2Ba1ckI+oIYR9JRBS0+AoC1T8tI9o=;
        t=1664974858; x=1666184458; b=FYLh0OgkOW7RdNLO+F4UwHxvvo9LIXJBpT8APQOPjj2Ke6D
        +9NB+IXdWN6/AtiJiOoF9BhGM9pF2Z94mjMvOfWtln1NXBFN8aGwLc11rno/qtDq8GKW95WAwXlRS
        MvkbI15WlFJ7UKZpFwVxnZBmmXyku9vqUE8GRHdpjbVnLfcunn5auXk1+zTPVAWqnwgYVZN8/A8tI
        1zaG3yqHGlmB23e++DTPpyOsALs4PoBCOuxeAfuZgrBNAuCufR2ZITdgcXk7fcTCXUDMpaV3tCGvc
        bXmGVOBwQUTQqQvX2pMHlKdCjWSW4ASX33fLwic6BO2v5T/iKAAEZYNWkqUIDZHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og41A-00G2RL-1v;
        Wed, 05 Oct 2022 15:00:56 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 24/28] wifi: mac80211: don't clear DTIM period after setting it
Date:   Wed,  5 Oct 2022 15:00:44 +0200
Message-Id: <20221005145226.5f2ee3b22e83.If419dfd118a03544cefd9a395bfe07235d427468@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Fix the code that sets the DTIM period to always propagate it
into link->conf->dtim_period and not overwrite it, while still
preferring to set it from the beacon data if available.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 50a376f86ec2..a651d3ffd8e6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2717,18 +2717,10 @@ static u32 ieee80211_link_set_associated(struct ieee80211_link_data *link,
 	}
 
 	if (link->u.mgd.have_beacon) {
-		/*
-		 * If the AP is buggy we may get here with no DTIM period
-		 * known, so assume it's 1 which is the only safe assumption
-		 * in that case, although if the TIM IE is broken powersave
-		 * probably just won't work at all.
-		 */
-		bss_conf->dtim_period = link->u.mgd.dtim_period ?: 1;
 		bss_conf->beacon_rate = bss->beacon_rate;
 		changed |= BSS_CHANGED_BEACON_INFO;
 	} else {
 		bss_conf->beacon_rate = NULL;
-		bss_conf->dtim_period = 0;
 	}
 
 	/* Tell the driver to monitor connection quality (if supported) */
@@ -4934,10 +4926,11 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		struct cfg80211_bss *cbss = assoc_data->link[link_id].bss;
 		struct ieee80211_link_data *link;
 		struct link_sta_info *link_sta;
 
-		if (!assoc_data->link[link_id].bss)
+		if (!cbss)
 			continue;
 
 		link = sdata_dereference(sdata->link[link_id], sdata);
@@ -4957,19 +4950,25 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		if (WARN_ON(!link_sta))
 			goto out_err;
 
-		if (link_id != assoc_data->assoc_link_id) {
-			struct cfg80211_bss *cbss = assoc_data->link[link_id].bss;
+		if (!link->u.mgd.have_beacon) {
 			const struct cfg80211_bss_ies *ies;
 
 			rcu_read_lock();
-			ies = rcu_dereference(cbss->ies);
+			ies = rcu_dereference(cbss->beacon_ies);
+			if (ies)
+				link->u.mgd.have_beacon = true;
+			else
+				ies = rcu_dereference(cbss->ies);
 			ieee80211_get_dtim(ies,
 					   &link->conf->sync_dtim_count,
 					   &link->u.mgd.dtim_period);
-			link->conf->dtim_period = link->u.mgd.dtim_period ?: 1;
 			link->conf->beacon_int = cbss->beacon_interval;
 			rcu_read_unlock();
+		}
 
+		link->conf->dtim_period = link->u.mgd.dtim_period ?: 1;
+
+		if (link_id != assoc_data->assoc_link_id) {
 			err = ieee80211_prep_channel(sdata, link, cbss,
 						     &link->u.mgd.conn_flags);
 			if (err) {
-- 
2.37.3

