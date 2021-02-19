Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2814131F6EE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 11:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhBSJ6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 04:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBSJ6s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 04:58:48 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BFAC061574
        for <linux-wireless@vger.kernel.org>; Fri, 19 Feb 2021 01:58:07 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lD2Xl-005Hiu-LW; Fri, 19 Feb 2021 10:57:49 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mac80211: minstrel_ht: remove unused variable 'mg'
Date:   Fri, 19 Feb 2021 10:57:45 +0100
Message-Id: <20210219105744.f2538a80f6cf.I3d53554c158d5b896ac07ea546bceac67372ec28@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This probably came in through some refactoring and what is
now a call to minstrel_ht_group_min_rate_offset(), remove
the unused variable.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rc80211_minstrel_ht.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 2f44f4919789..ecad9b10984f 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -805,7 +805,6 @@ minstrel_ht_group_min_rate_offset(struct minstrel_ht_sta *mi, int group,
 static u16
 minstrel_ht_next_inc_rate(struct minstrel_ht_sta *mi, u32 fast_rate_dur)
 {
-	struct minstrel_mcs_group_data *mg;
 	u8 type = MINSTREL_SAMPLE_TYPE_INC;
 	int i, index = 0;
 	u8 group;
@@ -813,7 +812,6 @@ minstrel_ht_next_inc_rate(struct minstrel_ht_sta *mi, u32 fast_rate_dur)
 	group = mi->sample[type].sample_group;
 	for (i = 0; i < ARRAY_SIZE(minstrel_mcs_groups); i++) {
 		group = (group + 1) % ARRAY_SIZE(minstrel_mcs_groups);
-		mg = &mi->groups[group];
 
 		index = minstrel_ht_group_min_rate_offset(mi, group,
 							  fast_rate_dur);
-- 
2.26.2

