Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE16357335A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiGMJq0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiGMJpc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC395F682B
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YdoP4xpeu8yzq81x6SM2u02pWcs+6B77bGoqZ15CHnA=;
        t=1657705525; x=1658915125; b=XaRdlbhj5S47nbTYb1vpp66tOanQ7gmEZw+9Cq9A5vgEAxo
        j2G+9pFbido8hNN308qetWwEAUhqkd+4tJnMTkJ8MWTjbMMy8P9mUJELj8ApwTJZDOPKF9w8LlZKF
        W9PSJNuU3BtpzHMTv9i7VSXlYcoBRgj6SQ0VYIqp5qv5t+Hoqw6FiiSmGvrI3asQSjEKWkWvBl5Xl
        ZGmOFuT3tMnFXOpH6c+N7Ym500SwyqQMgnkxTRgPG7jZW5O/M0dw7QrSgwudvc6V0S4LG1kjgLs/W
        EQgGA3d08xUlvm+Lmx+lEP7cYStbjXJBZCz3cEYa/W5gLcGQa3K32n5CzTybd6lA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvr-00EgvB-69;
        Wed, 13 Jul 2022 11:45:23 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 52/76] wifi: mac80211: use only channel width in ieee80211_parse_bitrates()
Date:   Wed, 13 Jul 2022 11:44:38 +0200
Message-Id: <20220713114425.b125faaaa9a6.I44ad959d94ec256e175763777ac646ada7148dd4@changeid>
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

For MLO, we may not have a full chandef here later, so change
the API to pass only the width.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         |  4 ++--
 net/mac80211/ieee80211_i.h | 12 +++++++++---
 net/mac80211/mlme.c        |  3 ++-
 net/mac80211/util.c        |  6 +++---
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 555c135e9fcd..498dce37adad 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1633,7 +1633,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 
 	if (params->supported_rates &&
 	    params->supported_rates_len) {
-		ieee80211_parse_bitrates(&link->conf->chandef,
+		ieee80211_parse_bitrates(link->conf->chandef.width,
 					 sband, params->supported_rates,
 					 params->supported_rates_len,
 					 &link_sta->pub->supp_rates[sband->band]);
@@ -2518,7 +2518,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	}
 
 	if (params->basic_rates) {
-		ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
+		ieee80211_parse_bitrates(sdata->vif.bss_conf.chandef.width,
 					 wiphy->bands[sband->band],
 					 params->basic_rates,
 					 params->basic_rates_len,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index dc38f57fcdc9..74d5fc5889bb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1102,9 +1102,9 @@ sdata_assert_lock(struct ieee80211_sub_if_data *sdata)
 }
 
 static inline int
-ieee80211_chandef_get_shift(struct cfg80211_chan_def *chandef)
+ieee80211_chanwidth_get_shift(enum nl80211_chan_width width)
 {
-	switch (chandef->width) {
+	switch (width) {
 	case NL80211_CHAN_WIDTH_5:
 		return 2;
 	case NL80211_CHAN_WIDTH_10:
@@ -1114,6 +1114,12 @@ ieee80211_chandef_get_shift(struct cfg80211_chan_def *chandef)
 	}
 }
 
+static inline int
+ieee80211_chandef_get_shift(struct cfg80211_chan_def *chandef)
+{
+	return ieee80211_chanwidth_get_shift(chandef->width);
+}
+
 static inline int
 ieee80211_vif_get_shift(struct ieee80211_vif *vif)
 {
@@ -2346,7 +2352,7 @@ u8 *ieee80211_ie_build_he_cap(ieee80211_conn_flags_t disable_flags, u8 *pos,
 void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
 				    struct sk_buff *skb);
 u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef);
-int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
+int ieee80211_parse_bitrates(enum nl80211_chan_width width,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates);
 int ieee80211_add_srates_ie(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fd8d7545a896..c65fe9f6f000 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -819,7 +819,8 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		 * in the association request (e.g. D-Link DAP 1353 in
 		 * b-only mode)...
 		 */
-		rates_len = ieee80211_parse_bitrates(&chanctx_conf->def, sband,
+		rates_len = ieee80211_parse_bitrates(chanctx_conf->def.width,
+						     sband,
 						     assoc_data->supp_rates,
 						     assoc_data->supp_rates_len,
 						     &rates);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1de6b6256acc..86b6ee7e8156 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3686,12 +3686,12 @@ bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
 	return true;
 }
 
-int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
+int ieee80211_parse_bitrates(enum nl80211_chan_width width,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates)
 {
-	u32 rate_flags = ieee80211_chandef_rate_flags(chandef);
-	int shift = ieee80211_chandef_get_shift(chandef);
+	u32 rate_flags = ieee80211_chanwidth_rate_flags(width);
+	int shift = ieee80211_chanwidth_get_shift(width);
 	struct ieee80211_rate *br;
 	int brate, rate, i, j, count = 0;
 
-- 
2.36.1

