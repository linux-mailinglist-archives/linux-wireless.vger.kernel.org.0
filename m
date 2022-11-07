Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C879161F8A5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 17:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiKGQOT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 11:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiKGQOQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 11:14:16 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62C92D89
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 08:14:14 -0800 (PST)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1667837651;
        bh=pWElwA5VPwEVVQ7wNFdTNxRrf4ZnLxIUfA5R7Zf5ReE=;
        h=From:To:Cc:Subject:Date;
        b=L9ScbOwyhS0TD5aF68avhsK1HBFOXjp7lThWR7Ns07Mkj4BLgQ3zCYCjymVWyNb5I
         mz7EC/SCsM/Wm5O4ug3NtcNrLLh+9n+xqquqyxBVxsR4bSsjcYXr4FoeMkfJC3yfLW
         pn7mmoSH/LsWqgne304qEKFfuzBQkS0Y7OIQBK0E=
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] wifi: mac80211: Drop not needed check for NULL
Date:   Mon,  7 Nov 2022 17:13:28 +0100
Message-Id: <20221107161328.2883-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_get_txq() can only be called with vif != NULL.
Remove not needed NULL test in function.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 165ac0711d71..3ed5ca4a2bae 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1343,7 +1343,7 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 			return NULL;
 
 		txq = sta->sta.txq[tid];
-	} else if (vif) {
+	} else {
 		txq = vif->txq;
 	}
 
-- 
2.38.1

