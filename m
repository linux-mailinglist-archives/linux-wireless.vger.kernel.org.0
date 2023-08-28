Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA4378AF85
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjH1MFs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjH1MFX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12198120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=B9yFwEoCBehB4dLooscTUlovsmWKsW6kU8fX1j6bUlM=;
        t=1693224321; x=1694433921; b=boM9qEQyUgd231+2Z4LlKGy3RfLttkJu+fx6rn/RZlrCoYs
        amQTRNJrcoKa2BwA+bUttTx+s4tBd9RSVq+SduUr0WxMWT1xC4ceLefiv6V0ZXnct8amP7UMv/9ds
        BBJmf5Jf75LOsZrrSFs+aoQm/1FSJR1FiwV0GE7lQzv1dIvog/3mHNK49n6URSGBuD3mB8irHqubJ
        9bL7VsV03o6utQcCVf6666PRgmcp7He9WQo+i0WVsW1ow7UqoO9yNgjFvLFepky7t/QMwvXq6pHTP
        HPmqBY26rdw2IJK4uhHR5+SCOSk+JDid2yRRavxRPlJPl53Ism/jm9ZqPGMWXttA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaaze-00Gjgt-0l;
        Mon, 28 Aug 2023 14:05:18 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/40] wifi: mac80211: debugfs: lock wiphy instead of RTNL
Date:   Mon, 28 Aug 2023 13:59:29 +0200
Message-ID: <20230828135927.e1069157fc33.I734dc816376001f38cdc7e17078d397207c96674@changeid>
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

Since we no longer really use the RTNL, there's no point
in locking it here. Most drivers don't really need to
have any locks here anyway, and the rest are probably
completely broken, but it's a debugfs-only callback so
it really doesn't matter much.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 207f772bd8ce..2efc6ccbfcf6 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -4,7 +4,7 @@
  *
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018 - 2019, 2021-2022 Intel Corporation
+ * Copyright (C) 2018 - 2019, 2021-2023 Intel Corporation
  */
 
 #include <linux/debugfs.h>
@@ -594,9 +594,9 @@ static ssize_t format_devstat_counter(struct ieee80211_local *local,
 	char buf[20];
 	int res;
 
-	rtnl_lock();
+	wiphy_lock(local->hw.wiphy);
 	res = drv_get_stats(local, &stats);
-	rtnl_unlock();
+	wiphy_unlock(local->hw.wiphy);
 	if (res)
 		return res;
 	res = printvalue(&stats, buf, sizeof(buf));
-- 
2.41.0

