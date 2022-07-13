Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9A2573A44
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiGMPet (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbiGMPem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077CC41D38
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=byRy5DE04FosmI7ShOE9jYDvUvldHf+9y/jdXN2TQzs=;
        t=1657726481; x=1658936081; b=C7C+kfc+7MNwW9o1tcnyhRbXVfUH15DYysDhgjk3YupC2Vz
        jLIhU87isWlEzy9uifROrcXLSaPOgQiLrYesB6dKj/5ZHrhf+XkYL3s6WOdau8IxqUs5T5xanb0ny
        OtljnRFnndioKFFYYF3I6CpsVpkN8vAKC5/GfGzGRAV0HUu26CmmAnAJ39WTDiBalzhcsmhaacrzv
        cik810BaxknQg2bjAy3jjBj21TORc/xPk7Klpw+ScMh3wvoqjXWSNjhP2+pZfk+BVD31PqoSANHKv
        u4MBolxTyW4amB6tANYmzAROWZi3+/S+EgrBep6aG2DKquy6Gg6VcVtTpY6O+npg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNr-00EnaA-6x;
        Wed, 13 Jul 2022 17:34:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/21] wifi: mac80211: make ieee80211_check_rate_mask() link-aware
Date:   Wed, 13 Jul 2022 17:34:20 +0200
Message-Id: <20220713173301.e6ac357a8943.I68489f528743ecf1b4f31f7e7bc786f5adca4b21@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

Change ieee80211_check_rate_mask() to use a link rather than
the sdata and deflink/bss_conf.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c  | 2 +-
 net/mac80211/mlme.c | 2 +-
 net/mac80211/rate.c | 9 +++++----
 net/mac80211/rate.h | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 498dce37adad..bc2aaecd2a8c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2524,7 +2524,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 					 params->basic_rates_len,
 					 &sdata->vif.bss_conf.basic_rates);
 		changed |= BSS_CHANGED_BASIC_RATES;
-		ieee80211_check_rate_mask(sdata);
+		ieee80211_check_rate_mask(&sdata->deflink);
 	}
 
 	if (params->ap_isolate >= 0) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 042cd5439bb8..3986bf70fc5c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2360,7 +2360,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	memcpy(link->u.mgd.bssid, cbss->bssid, ETH_ALEN);
 	memcpy(sdata->vif.cfg.ap_addr, cbss->bssid, ETH_ALEN);
 
-	ieee80211_check_rate_mask(sdata);
+	ieee80211_check_rate_mask(link);
 
 	if (sdata->vif.p2p ||
 	    sdata->vif.driver_flags & IEEE80211_VIF_GET_NOA_UPDATE) {
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 7947e9a162a9..d5ea5f5bcf3a 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -270,17 +270,18 @@ static void rate_control_free(struct ieee80211_local *local,
 	kfree(ctrl_ref);
 }
 
-void ieee80211_check_rate_mask(struct ieee80211_sub_if_data *sdata)
+void ieee80211_check_rate_mask(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
-	u32 user_mask, basic_rates = sdata->vif.bss_conf.basic_rates;
+	u32 user_mask, basic_rates = link->conf->basic_rates;
 	enum nl80211_band band;
 
-	if (WARN_ON(!sdata->vif.bss_conf.chandef.chan))
+	if (WARN_ON(!link->conf->chandef.chan))
 		return;
 
-	band = sdata->vif.bss_conf.chandef.chan->band;
+	band = link->conf->chandef.chan->band;
 	if (band == NL80211_BAND_S1GHZ) {
 		/* TODO */
 		return;
diff --git a/net/mac80211/rate.h b/net/mac80211/rate.h
index d89c13584dc8..d6190f10fe7c 100644
--- a/net/mac80211/rate.h
+++ b/net/mac80211/rate.h
@@ -85,7 +85,7 @@ static inline void rate_control_add_debugfs(struct ieee80211_local *local)
 #endif
 }
 
-void ieee80211_check_rate_mask(struct ieee80211_sub_if_data *sdata);
+void ieee80211_check_rate_mask(struct ieee80211_link_data *link);
 
 /* Get a reference to the rate control algorithm. If `name' is NULL, get the
  * first available algorithm. */
-- 
2.36.1

