Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756882D04FF
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 13:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgLFMz4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 07:55:56 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34886 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727939AbgLFMzj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 07:55:39 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kltYy-003AHZ-BM; Sun, 06 Dec 2020 14:54:52 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 14:54:40 +0200
Message-Id: <iwlwifi.20201206145305.f6698d97ae4e.Iba2dffcb79c4ab80bde7407609806010b55edfdf@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206125450.564941-1-luca@coelho.fi>
References: <20201206125450.564941-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/11] cfg80211: remove struct ieee80211_he_bss_color
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We don't really use this struct, we're now using
struct cfg80211_he_bss_color instead.

Change the one place in mac80211 that's using the old
name to use struct assignment instead of memcpy() and
thus remove the wrong sizeof while at it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h | 13 -------------
 net/mac80211/cfg.c     |  3 +--
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ab249ca5d5d1..f6fc4408ba95 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -301,19 +301,6 @@ struct cfg80211_he_bss_color {
 	bool partial;
 };
 
-/**
- * struct ieee80211_he_bss_color - AP settings for BSS coloring
- *
- * @color: the current color.
- * @disabled: is the feature disabled.
- * @partial: define the AID equation.
- */
-struct ieee80211_he_bss_color {
-	u8 color;
-	bool disabled;
-	bool partial;
-};
-
 /**
  * struct ieee80211_sta_ht_cap - STA's HT capabilities
  *
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 454432ced0c9..1b3169c6a9a6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1123,8 +1123,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.twt_responder = params->twt_responder;
 	memcpy(&sdata->vif.bss_conf.he_obss_pd, &params->he_obss_pd,
 	       sizeof(struct ieee80211_he_obss_pd));
-	memcpy(&sdata->vif.bss_conf.he_bss_color, &params->he_bss_color,
-	       sizeof(struct ieee80211_he_bss_color));
+	sdata->vif.bss_conf.he_bss_color = params->he_bss_color;
 	sdata->vif.bss_conf.s1g = params->chandef.chan->band ==
 				  NL80211_BAND_S1GHZ;
 
-- 
2.29.2

