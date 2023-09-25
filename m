Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D8C7ADB6D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjIYPam (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 11:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjIYPaj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 11:30:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3770B121
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=PUBrsypQtdQXK6lXCvo8XLIm2KTYP9eRrx39nV1+qqU=; t=1695655833; x=1696865433; 
        b=rvjhlUDv8pr1ab+dIoVDfj8mNa0H+1waS0EV+8flGZXX5VrT+lJI6UMGSV50IUjH55qUAbwIHmI
        wflqCMRnZeG4jyvsfQbo6OW01X+8gMB57v16f9Cq8ToGmuDGjdhzh47HfzMnnW3RNoEgWkLpPe6Ay
        +t9G92O5omNmMyCs3SIAHDuzQjCXfDFvvd9Bif/v58Bzk/u5XOYoehcMJZ2zXuJch2lV3JvnHk8M5
        nZ5tW2jF2PVgt4RdVvxvdTY5k2etHZv2jvme2Z3RxWKVdnqV+gSXP9Dwf+UPx8IlbKFl6d7ToJIbJ
        ZksJJHiRXXB9O4QNrz6bmhcSZ77S1MtGfoqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qknXa-003lAj-1w;
        Mon, 25 Sep 2023 17:30:31 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] wifi: mac80211: Create resources for disabled links
Date:   Mon, 25 Sep 2023 17:30:29 +0200
Message-ID: <20230925173028.f9afdb26f6c7.I4e6e199aaefc1bf017362d64f3869645fa6830b5@changeid>
X-Mailer: git-send-email 2.41.0
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

From: Benjamin Berg <benjamin.berg@intel.com>

When associating to an MLD AP, links may be disabled. Create all
resources associated with a disabled link so that we can later enable it
without having to create these resources on the fly.

Fixes: 6d543b34dbcf ("wifi: mac80211: Support disabled links during association")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0e61eb5a29d1..0c9198997482 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5130,9 +5130,10 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				continue;
 
 			valid_links |= BIT(link_id);
-			if (assoc_data->link[link_id].disabled) {
+			if (assoc_data->link[link_id].disabled)
 				dormant_links |= BIT(link_id);
-			} else if (link_id != assoc_data->assoc_link_id) {
+
+			if (link_id != assoc_data->assoc_link_id) {
 				err = ieee80211_sta_allocate_link(sta, link_id);
 				if (err)
 					goto out_err;
@@ -5147,7 +5148,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_link_data *link;
 		struct link_sta_info *link_sta;
 
-		if (!cbss || assoc_data->link[link_id].disabled)
+		if (!cbss)
 			continue;
 
 		link = sdata_dereference(sdata->link[link_id], sdata);
-- 
2.41.0

