Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552DD4F1BE4
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379030AbiDDVSf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 17:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380692AbiDDVDR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 17:03:17 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E9238A3
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 14:01:20 -0700 (PDT)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1649106079; bh=F0pmMQO96ia8+/SEA9XaTI2abIY52/1JRNbsDWWFqVE=;
        h=From:To:Cc:Subject:Date:From;
        b=T5yioeBf8JNcZc5KcPfMzEm4qocZya63qBwzPuDm9w1/7n+tMLLgyJgaSgE7cgA9m
         R8ZUymBVho88iiERcoIi1IvDngbnw20AcXUrBkpAHQlT0ocnmO4fjmP8+rfo3fn2Cg
         zDqtI15gTo0F56H3e7X9UWHsksFQ4xw5QNVKMgESGvL56E0MNyKV65rhF1p2uZvCSZ
         3xlI/dnhCS4eXuOKtfg8dGbYSUCOLPcLliQjIRKCDMCicRMgW+ERawf90DsImmguSp
         CstJmYRvM7MO1iSuA4FEhVAoiq9K6xHp3Mu9+XB5u+hV9cd05cMxr865OQeHkooNZa
         TleRlTQGKBm9w==
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH] mac80211: Improve confusing comment around tx_info clearing
Date:   Mon,  4 Apr 2022 23:01:08 +0200
Message-Id: <20220404210108.2684907-1-toke@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The comment above the ieee80211_tx_info_clear_status() helper was somewhat
confusing as to which fields it was or wasn't clearing. So replace it by
something that is hopefully more, well, clear.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 include/net/mac80211.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 382ebb862ea8..db992f71604d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1201,9 +1201,9 @@ static inline struct ieee80211_rx_status *IEEE80211_SKB_RXCB(struct sk_buff *skb
  * in the TX status but the rate control information (it does clear
  * the count since you need to fill that in anyway).
  *
- * NOTE: You can only use this function if you do NOT use
- *	 info->driver_data! Use info->rate_driver_data
- *	 instead if you need only the less space that allows.
+ * NOTE: While the rates array is kept intact, this will wipe all of the
+ *	 driver_data fields in info, so it's up to the driver to restore
+ *	 any fields it needs after calling this helper.
  */
 static inline void
 ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
-- 
2.35.1

