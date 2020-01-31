Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3102C14EB97
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgAaLQr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:16:47 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55876 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgAaLQr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:16:47 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEc-0002GC-Hl; Fri, 31 Jan 2020 13:13:14 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:47 +0200
Message-Id: <20200131111300.891737-11-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 10/23] mac80211: make ieee80211_wep_init() return void
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This function always returns 0, so there's no point in returning int.
Make it void and remove the impossible error-path when calling it.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/main.c | 5 +----
 net/mac80211/wep.c  | 4 +---
 net/mac80211/wep.h  | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 287dd0588476..d91bcef738dc 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1185,10 +1185,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	if (!local->hw.weight_multiplier)
 		local->hw.weight_multiplier = 1;
 
-	result = ieee80211_wep_init(local);
-	if (result < 0)
-		wiphy_debug(local->hw.wiphy, "Failed to initialize wep: %d\n",
-			    result);
+	ieee80211_wep_init(local);
 
 	local->hw.conf.flags = IEEE80211_CONF_IDLE;
 
diff --git a/net/mac80211/wep.c b/net/mac80211/wep.c
index b75c2c54e665..9a6e11d7b4db 100644
--- a/net/mac80211/wep.c
+++ b/net/mac80211/wep.c
@@ -22,12 +22,10 @@
 #include "wep.h"
 
 
-int ieee80211_wep_init(struct ieee80211_local *local)
+void ieee80211_wep_init(struct ieee80211_local *local)
 {
 	/* start WEP IV from a random value */
 	get_random_bytes(&local->wep_iv, IEEE80211_WEP_IV_LEN);
-
-	return 0;
 }
 
 static inline bool ieee80211_wep_weak_iv(u32 iv, int keylen)
diff --git a/net/mac80211/wep.h b/net/mac80211/wep.h
index 997a034233c2..4ffe83554c67 100644
--- a/net/mac80211/wep.h
+++ b/net/mac80211/wep.h
@@ -13,7 +13,7 @@
 #include "ieee80211_i.h"
 #include "key.h"
 
-int ieee80211_wep_init(struct ieee80211_local *local);
+void ieee80211_wep_init(struct ieee80211_local *local);
 int ieee80211_wep_encrypt_data(struct arc4_ctx *ctx, u8 *rc4key,
 				size_t klen, u8 *data, size_t data_len);
 int ieee80211_wep_encrypt(struct ieee80211_local *local,
-- 
2.24.1

