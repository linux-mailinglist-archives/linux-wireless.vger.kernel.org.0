Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64A078AF80
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjH1MFn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjH1MFY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E93123
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kJRJ4qgY36/Xy4zk8vp7+HnwUX5Bf2Cmq/jJvSuh5RI=;
        t=1693224321; x=1694433921; b=l4OsQGVnYJOeSLrQnolaHGuCAVaHrQIYW1A9SoUA8QPex5d
        IKphlQ1BRT0xsQbfw3DlVFoSGYNiI5pgkaeR6gL/4q+e3ir5bVnnD4NOspPkWN+eylK9ChldQMaZA
        BAnn6DJHvFrfHh+jmya4UNpAxjkN8mU5MnuZsCTBzTI0G2xmlsrUbF7oJEWcywBA1cl9S6k+MwjxY
        /nX6lpLQVLSpqczBm5rI+3ZXjG0yC83oSAFavKca8fw4ETk1gEptDP4KuaUDOO3ujDkxfq2x1Nc9n
        0WfY9qxFrW2MROSB+OxPqWXdsAA1bELIqosIUH90vdiWnWNKiq9gZ6Y7x7c6//0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazf-00Gjgt-26;
        Mon, 28 Aug 2023 14:05:19 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/40] wifi: mac80211: lock wiphy for aggregation debugfs
Date:   Mon, 28 Aug 2023 13:59:31 +0200
Message-ID: <20230828135927.c0cbf23d5bcf.I0452fa80819d04860ea21444d23f6cf71fbda3af@changeid>
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

To change aggregation status may call into the driver,
lock the wiphy for this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs_sta.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 5a97fb248c85..06e3613bf46b 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -5,7 +5,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  */
 
 #include <linux/debugfs.h>
@@ -420,6 +420,7 @@ static ssize_t sta_agg_status_write(struct file *file, const char __user *userbu
 	if (ret || tid >= IEEE80211_NUM_TIDS)
 		return -EINVAL;
 
+	wiphy_lock(sta->local->hw.wiphy);
 	if (tx) {
 		if (start)
 			ret = ieee80211_start_tx_ba_session(&sta->sta, tid,
@@ -431,6 +432,7 @@ static ssize_t sta_agg_status_write(struct file *file, const char __user *userbu
 					       3, true);
 		ret = 0;
 	}
+	wiphy_unlock(sta->local->hw.wiphy);
 
 	return ret ?: count;
 }
-- 
2.41.0

