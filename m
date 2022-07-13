Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA5573360
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiGMJqq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiGMJpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A3BEE1F8
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=N3f/xzkac5yb4WWsLlk762QRjKPv+pZ+gGblFzyAViM=;
        t=1657705528; x=1658915128; b=Y7oDFLO21QbTpiQKAEHa6XXzMw0maFxB4HvI09rqZ+EDmOf
        fQHI4bOJO7X+2v3N+nh1Hg50NQjMQhnhqOeHxMPFQibOYshIAN7NDhroxSRwCEeCarm0zgahhwvqi
        +KEizp4grx18nl9lsGwW2wG1J2hWUvvvsFOVNVFZCthn/TY3X5F4PI9+a+z5rzsUHAiz8TjWBA2qd
        DGjcUeA5UeGurr8T8L8ne24WvRUkX8Xd492PiI8M9j3EM1ma6N65dD21J7p2GVg9o/Z9SChQ/0seu
        UXV1LmAKHltajGIWnC2QFjog6RIuBQxgOGnWm/KClKAsh26zAIIa4AcRDLxH+71Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvu-00EgvB-OG;
        Wed, 13 Jul 2022 11:45:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 63/76] wifi: mac80211: skip rate statistics for MLD STAs
Date:   Wed, 13 Jul 2022 11:44:49 +0200
Message-Id: <20220713114426.da1b12d1e803.Ie34f8fe634e62aab03e1aadd42549f097bac8eb7@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For now, skip rate statistics here to avoid warnings in
the called code, we'll need to adjust this to have all
the statistics for link stations.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 20aad688c9c9..88ff61aadd96 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2507,13 +2507,15 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		}
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
+	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
+	    !sta->sta.valid_links) {
 		sta_set_rate_info_tx(sta, &sta->deflink.tx_stats.last_rate,
 				     &sinfo->txrate);
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE))) {
+	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
+	    !sta->sta.valid_links) {
 		if (sta_set_rate_info_rx(sta, &sinfo->rxrate) == 0)
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
 	}
-- 
2.36.1

