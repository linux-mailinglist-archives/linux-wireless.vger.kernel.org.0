Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6897455E90D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbiF1PPm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Jun 2022 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348083AbiF1PPQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Jun 2022 11:15:16 -0400
X-Greylist: delayed 582 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 08:15:04 PDT
Received: from simonwunderlich.de (simonwunderlich.de [23.88.38.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDC031343
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jun 2022 08:15:04 -0700 (PDT)
Received: from localhost (p200300c5974564900000000000000607.dip0.t-ipconnect.de [IPv6:2003:c5:9745:6490::607])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by simonwunderlich.de (Postfix) with ESMTPSA id 4A8E1FA22B;
        Tue, 28 Jun 2022 17:05:20 +0200 (CEST)
From:   Issam Hamdi <ih@simonwunderlich.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, sw@simonwunderlich.de,
        Issam Hamdi <ih@simonwunderlich.de>
Subject: [PATCH] wifi: mac80211: fix get inactive time for station mode
Date:   Tue, 28 Jun 2022 17:05:11 +0200
Message-Id: <20220628150511.1185132-1-ih@simonwunderlich.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In station mode, the value last_rx is not updated often.
Therefore the calculation of the inactive time will be wrong (will give
values between 1000 ms to 30000 ms).
To fix this add the update of "sta->deflink.rx_stats.last_rx" for
station mode in the response of the packets process
(ieee80211_rx_h_sta_process).

Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
---
 net/mac80211/rx.c       | 3 +++
 net/mac80211/sta_info.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index d017ad14d7db..6ce899b18614 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1756,6 +1756,9 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 			sta->deflink.rx_stats.last_rate = sta_stats_encode_rate(status);
 	}
 
+	if (rx->sdata->vif.type == NL80211_IFTYPE_STATION)
+		sta->deflink.rx_stats.last_rx = jiffies;
+
 	sta->deflink.rx_stats.fragments++;
 
 	u64_stats_update_begin(&rx->sta->deflink.rx_stats.syncp);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 014032369994..88a9f81e7083 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2430,7 +2430,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
 	sinfo->assoc_at = sta->assoc_at;
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta));
+		jiffies_to_msecs(abs(jiffies - ieee80211_sta_last_active(sta)));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
-- 
2.30.2

