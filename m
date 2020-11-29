Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496F92C79BD
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgK2Pbt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33528 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727879AbgK2Pbr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:47 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfE-0035ld-Ld; Sun, 29 Nov 2020 17:31:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:46 +0200
Message-Id: <iwlwifi.20201129172929.4012647275f3.I1a93ae71c57ef0b6f58f99d47fce919d19d65ff0@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/13] cfg80211: Parse SAE H2E only membership selector
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

This extends the support for drivers that rebuild IEs in the
FW (same as with HT/VHT/HE).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/linux/ieee80211.h | 2 ++
 include/net/cfg80211.h    | 3 ++-
 net/wireless/nl80211.c    | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 5e8cc9c3d45a..9b99a5afe097 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1261,6 +1261,8 @@ struct ieee80211_mgmt {
 #define BSS_MEMBERSHIP_SELECTOR_HT_PHY	127
 #define BSS_MEMBERSHIP_SELECTOR_VHT_PHY	126
 #define BSS_MEMBERSHIP_SELECTOR_HE_PHY	122
+#define BSS_MEMBERSHIP_SELECTOR_SAE_H2E 123
+
 
 /* mgmt header + 1 byte category code */
 #define IEEE80211_MIN_ACTION_SIZE offsetof(struct ieee80211_mgmt, u.action.u)
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ab249ca5d5d1..4a5ae7fb7d59 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1186,6 +1186,7 @@ enum cfg80211_ap_settings_flags {
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
  * @he_required: stations must support HE
+ * @sae_h2e_required: stations must support direct H2E technique in SAE
  * @flags: flags, as defined in enum cfg80211_ap_settings_flags
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
@@ -1217,7 +1218,7 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_vht_cap *vht_cap;
 	const struct ieee80211_he_cap_elem *he_cap;
 	const struct ieee80211_he_operation *he_oper;
-	bool ht_required, vht_required, he_required;
+	bool ht_required, vht_required, he_required, sae_h2e_required;
 	bool twt_responder;
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cf37cea1ff42..643000200a1b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5017,6 +5017,8 @@ static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 			params->vht_required = true;
 		if (rates[2 + i] == BSS_MEMBERSHIP_SELECTOR_HE_PHY)
 			params->he_required = true;
+		if (rates[2 + i] == BSS_MEMBERSHIP_SELECTOR_SAE_H2E)
+			params->sae_h2e_required = true;
 	}
 }
 
-- 
2.29.2

