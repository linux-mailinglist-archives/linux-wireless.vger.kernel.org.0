Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAEE78CBE6
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjH2SQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjH2SQT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 14:16:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86026BE
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=/14W8/eZeYzNeWOcUSufGs779e64uaLkoPWHiIsC4z8=; t=1693332976; x=1694542576; 
        b=ZWloKthCaszqcxh3C1oWRgpKe2MF0ZrzXnxtb+fAnpsfZkpYFXFxDEu7LZy39hwfGnY2X8OcscG
        SNdxVEFE6u/rZzhnneTxF3YJGyG2I6KZsWqc4AUdC4k5LMJZwy8xYvb/paVS/Qvbs+nSd2xRJtG+S
        lEg7h3zDKFo0injekBIdVXXWYWJ7WIPQxInyOvqG2RlBOFKkhf927LO64A2eqMMll6vtd7DGGRcKq
        3kjn0ty5DlkE8M7alHNzDtVeDohmJy65D/sgh0fLup1LFcPARBDhJ+Sp7aCHwV3+v/ThRcAyiCDk9
        4+S8vV34FEhRXh+FEaQ3hyA+vqnHx6PIN8/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qb3G9-001SAJ-1U;
        Tue, 29 Aug 2023 20:16:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Alexander Wetzel <alexander@wetzel-home.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: fix BA session teardown race
Date:   Tue, 29 Aug 2023 20:16:11 +0200
Message-ID: <20230829201610.cc648236f434.I205a557b06a27f58afe3880f4db43d554210c88d@changeid>
X-Mailer: git-send-email 2.41.0
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

As previously reported by Alexander, whose commit 69403bad97aa
("wifi: mac80211: sdata can be NULL during AMPDU start") I'm
reverting as part of this commit, there's a race between station
destruction and aggregation setup, where the aggregation setup
can happen while the station is being removed and queue the work
after ieee80211_sta_tear_down_BA_sessions() has already run in
__sta_info_destroy_part1(), and thus the worker will run with a
now freed station. In his case, this manifested in a NULL sdata
pointer, but really there's no guarantee whatsoever.

The real issue seems to be that it's possible at all to have a
situation where this occurs - we want to stop the BA sessions
when doing _part1, but we cannot be sure, and WLAN_STA_BLOCK_BA
isn't necessarily effective since we don't know that the setup
isn't concurrently running and already got past the check.

Simply call ieee80211_sta_tear_down_BA_sessions() again in the
second part of station destruction, since at that point really
nothing else can hold a reference to the station any more.

Also revert the sdata checks since those are just misleading at
this point.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-tx.c     |  6 +-----
 net/mac80211/driver-ops.c |  3 ---
 net/mac80211/sta_info.c   | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 0627abb09f0e..b8a278355e18 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -497,7 +497,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 {
 	struct tid_ampdu_tx *tid_tx;
 	struct ieee80211_local *local = sta->local;
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_ampdu_params params = {
 		.sta = &sta->sta,
 		.action = IEEE80211_AMPDU_TX_START,
@@ -525,7 +525,6 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 	 */
 	synchronize_net();
 
-	sdata = sta->sdata;
 	params.ssn = sta->tid_seq[tid] >> 4;
 	ret = drv_ampdu_action(local, sdata, &params);
 	tid_tx->ssn = params.ssn;
@@ -539,9 +538,6 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 		 */
 		set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state);
 	} else if (ret) {
-		if (!sdata)
-			return;
-
 		ht_dbg(sdata,
 		       "BA request denied - HW unavailable for %pM tid %d\n",
 		       sta->sta.addr, tid);
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 919300750527..169dbbca54b6 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -409,9 +409,6 @@ int drv_ampdu_action(struct ieee80211_local *local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!sdata)
-		return -EIO;
-
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index abcc280acd38..2a61269a4b54 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1385,6 +1385,20 @@ static void __sta_info_destroy_part2(struct sta_info *sta, bool recalc)
 	 *	 after _part1 and before _part2!
 	 */
 
+	/*
+	 * There's a potential race in _part1 where we set WLAN_STA_BLOCK_BA
+	 * but someone might have just gotten past a check, and not yet into
+	 * queuing the work/creating the data/etc.
+	 *
+	 * Do another round of destruction so that the worker is certainly
+	 * canceled before we later free the station.
+	 *
+	 * Since this is after synchronize_rcu()/synchronize_net() we're now
+	 * certain that nobody can actually hold a reference to the STA and
+	 * be calling e.g. ieee80211_start_tx_ba_session().
+	 */
+	ieee80211_sta_tear_down_BA_sessions(sta, AGG_STOP_DESTROY_STA);
+
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-- 
2.41.0

