Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32B78AF9B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjH1MGS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjH1MFr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880F11A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6ZYxl6NvMI7EV75IbHQPQ+r016Dayt85bhDosCRIyhk=;
        t=1693224344; x=1694433944; b=nprL+wNnlmWWi1bRAaeovvPLjecO6mWmY1oCKBBWghpqlNk
        wJfsvsXTmGI4ohhCST35wR8s9h4NzPhUTmNU+4lukztVAQWuiyYZ9+9sLMCIXKX0SjrGkNCeL0Vol
        r2rLn0M8DNjRggjVBkj+IRNNyrIYCuNOaQNC6BI876bhGuzZTi7tpUIQxRi3dVQy7Xa1KB7FdYE2u
        3J7pf+AGmpW5dRpmd45VnuVEAX3X0qPirWrZpQrPLjyk8eBn9clp7yYJ42NrsePe5C1zx6mD9Al9u
        vL4WT1KlYbbBgN6DuTm3t+C4MjDdJ1OiM20ha5C48J9ZXo/68hq7gpyCNbGd08hA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab02-00Gjgt-23;
        Mon, 28 Aug 2023 14:05:42 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 29/40] wifi: mac80211: ethtool: hold wiphy mutex
Date:   Mon, 28 Aug 2023 13:59:57 +0200
Message-ID: <20230828135928.ab953bd13e75.I442c12f6f47701269777ab07de3561c4ccc38ee4@changeid>
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

We should hold the wiphy mutex here since we're going
to call the driver and want to remove the sta_mtx.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ethtool.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index a3830d925cc2..c53208321c8f 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -5,7 +5,7 @@
  * Copied from cfg.c - originally
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2014	Intel Corporation (Author: Johannes Berg)
- * Copyright (C) 2018, 2022 Intel Corporation
+ * Copyright (C) 2018, 2022-2023 Intel Corporation
  */
 #include <linux/types.h>
 #include <net/cfg80211.h>
@@ -102,6 +102,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 	 * network device.
 	 */
 
+	wiphy_lock(local->hw.wiphy);
 	mutex_lock(&local->sta_mtx);
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
@@ -200,10 +201,13 @@ static void ieee80211_get_stats(struct net_device *dev,
 
 	mutex_unlock(&local->sta_mtx);
 
-	if (WARN_ON(i != STA_STATS_LEN))
+	if (WARN_ON(i != STA_STATS_LEN)) {
+		wiphy_unlock(local->hw.wiphy);
 		return;
+	}
 
 	drv_get_et_stats(sdata, stats, &(data[STA_STATS_LEN]));
+	wiphy_unlock(local->hw.wiphy);
 }
 
 static void ieee80211_get_strings(struct net_device *dev, u32 sset, u8 *data)
-- 
2.41.0

