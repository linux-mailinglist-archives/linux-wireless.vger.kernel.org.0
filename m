Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB64193F77
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgCZNJ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:09:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44328 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726260AbgCZNJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:09:58 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHSGi-00044K-B1; Thu, 26 Mar 2020 15:09:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 15:09:35 +0200
Message-Id: <iwlwifi.20200326150855.20feaabfb484.I886252639604c8e3e84b8ef97962f1b0e4beec81@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326130943.623208-1-luca@coelho.fi>
References: <20200326130943.623208-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 04/12] cfg80211: Parse HE membership selector
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

This extends the support for drivers that rebuilds IEs in the
FW (same as with HT/VHT).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/linux/ieee80211.h | 1 +
 include/net/cfg80211.h    | 3 ++-
 net/wireless/nl80211.c    | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index bdcc3165c440..7c7b974c41b1 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1067,6 +1067,7 @@ struct ieee80211_mgmt {
 /* Supported rates membership selectors */
 #define BSS_MEMBERSHIP_SELECTOR_HT_PHY	127
 #define BSS_MEMBERSHIP_SELECTOR_VHT_PHY	126
+#define BSS_MEMBERSHIP_SELECTOR_HE_PHY	122
 
 /* mgmt header + 1 byte category code */
 #define IEEE80211_MIN_ACTION_SIZE offsetof(struct ieee80211_mgmt, u.action.u)
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c78bd4ff9e33..18e17496a904 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1052,6 +1052,7 @@ enum cfg80211_ap_settings_flags {
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
+ * @he_required: stations must support HE
  * @flags: flags, as defined in enum cfg80211_ap_settings_flags
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
@@ -1081,7 +1082,7 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_vht_cap *vht_cap;
 	const struct ieee80211_he_cap_elem *he_cap;
 	const struct ieee80211_he_operation *he_oper;
-	bool ht_required, vht_required;
+	bool ht_required, vht_required, he_required;
 	bool twt_responder;
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ad87e9db9a91..0586093420e8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4728,6 +4728,8 @@ static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 			params->ht_required = true;
 		if (rates[2 + i] == BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
 			params->vht_required = true;
+		if (rates[2 + i] == BSS_MEMBERSHIP_SELECTOR_HE_PHY)
+			params->he_required = true;
 	}
 }
 
-- 
2.25.1

