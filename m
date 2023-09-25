Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED027ADB51
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjIYPYt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 11:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjIYPYt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 11:24:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11B101
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=UNyYP4xcN5GtlaBA+Bwa1unD9qiUdEiwh9jnVloq9sE=; t=1695655483; x=1696865083; 
        b=fv+TEdgbO76rFT3zbjfex6gFGXxW5HzIlKCnwuDJrpYYMhlf+BomXsQZsL0D31rfr5Z2P+N8KTa
        jBurUXN405daJVud5LmgGRWezL4Jsi2laY5M3qMyWFq8qtCcV0yllizEeO2k289bq+FtKmtg8B4+C
        /yBb2vlOsuYblRzBlz/jsOi2Aj1Zxxm/RiTyMHuMiTlsxUgpfYx2XshsXE4szNh5a0mcVBCJa/S1F
        PVwVDbYrYANXi7rmQtvvaWlzgktyPtG8Yt3sVVIk5xsp47lePstkPogm3J0p8CT81t0JMP6MTSqLx
        TTbjGfG1e1ZYDsnfii+Uw9CdMuJuz5GduULw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qknRw-003kmD-2c;
        Mon, 25 Sep 2023 17:24:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: fix check for unusable RX result
Date:   Mon, 25 Sep 2023 17:24:39 +0200
Message-ID: <20230925172438.8ae4e914904c.I6670c7313fc9d1ba611183d373334b0f085b543e@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

If we just check "result & RX_DROP_UNUSABLE", this really only works
by accident, because SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE got to
have the value 1, and SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR is 2.

Fix this to really check the entire subsys mask for the value, so it
doesn't matter what the subsystem value is.

Fixes: 7f4e09700bdc ("wifi: mac80211: report all unusable beacon frames")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/drop.h | 3 +++
 net/mac80211/rx.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/drop.h b/net/mac80211/drop.h
index 49dc809cab29..1570fac8411f 100644
--- a/net/mac80211/drop.h
+++ b/net/mac80211/drop.h
@@ -53,4 +53,7 @@ enum mac80211_drop_reason {
 #undef DEF
 };
 
+#define RX_RES_IS_UNUSABLE(result)	\
+	(((__force u32)(result) & SKB_DROP_REASON_SUBSYS_MASK) == ___RX_DROP_UNUSABLE)
+
 #endif /* MAC80211_DROP_H */
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6fcd2a717922..944adc9a51f1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2112,7 +2112,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 	/* either the frame has been decrypted or will be dropped */
 	status->flag |= RX_FLAG_DECRYPTED;
 
-	if (unlikely(ieee80211_is_beacon(fc) && (result & RX_DROP_UNUSABLE) &&
+	if (unlikely(ieee80211_is_beacon(fc) && RX_RES_IS_UNUSABLE(result) &&
 		     rx->sdata->dev))
 		cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 					     skb->data, skb->len);
-- 
2.41.0

