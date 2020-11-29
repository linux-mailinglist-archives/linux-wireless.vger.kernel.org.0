Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6642C79BB
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgK2Pbs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:48 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33522 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727739AbgK2Pbr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:47 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfD-0035ld-UD; Sun, 29 Nov 2020 17:31:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:45 +0200
Message-Id: <iwlwifi.20201129172929.fb59be9c6de8.Ife2260887366f585afadd78c983ebea93d2bb54b@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/13] mac80211: support MIC error/replay detected counters driver update
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Support the driver incrementing MIC error and replay detected
counters when having detected a bad frame, if it drops it directly
instead of relying on mac80211 to do the checks.

These are then exposed to userspace, though currently only in some
cases and in debugfs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/mac80211.h | 20 +++++++++++++++++
 net/mac80211/key.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 1328b7166460..2d01280c0564 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5321,6 +5321,26 @@ ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
 void ieee80211_gtk_rekey_notify(struct ieee80211_vif *vif, const u8 *bssid,
 				const u8 *replay_ctr, gfp_t gfp);
 
+/**
+ * ieee80211_key_mic_failure - increment MIC failure counter for the key
+ *
+ * Note: this is really only safe if no other RX function is called
+ * at the same time.
+ *
+ * @keyconf: the key in question
+ */
+void ieee80211_key_mic_failure(struct ieee80211_key_conf *keyconf);
+
+/**
+ * ieee80211_key_replay - increment replay counter for the key
+ *
+ * Note: this is really only safe if no other RX function is called
+ * at the same time.
+ *
+ * @keyconf: the key in question
+ */
+void ieee80211_key_replay(struct ieee80211_key_conf *keyconf);
+
 /**
  * ieee80211_wake_queue - wake specific queue
  * @hw: pointer as obtained from ieee80211_alloc_hw().
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 8c5f829ff6d7..a4817aa4b171 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -1300,3 +1300,52 @@ ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
 	return &key->conf;
 }
 EXPORT_SYMBOL_GPL(ieee80211_gtk_rekey_add);
+
+void ieee80211_key_mic_failure(struct ieee80211_key_conf *keyconf)
+{
+	struct ieee80211_key *key;
+
+	key = container_of(keyconf, struct ieee80211_key, conf);
+
+	switch (key->conf.cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		key->u.aes_cmac.icverrors++;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		key->u.aes_gmac.icverrors++;
+		break;
+	default:
+		/* ignore the others for now, we don't keep counters now */
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(ieee80211_key_mic_failure);
+
+void ieee80211_key_replay(struct ieee80211_key_conf *keyconf)
+{
+	struct ieee80211_key *key;
+
+	key = container_of(keyconf, struct ieee80211_key, conf);
+
+	switch (key->conf.cipher) {
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		key->u.ccmp.replays++;
+		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		key->u.aes_cmac.replays++;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		key->u.aes_gmac.replays++;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		key->u.gcmp.replays++;
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(ieee80211_key_replay);
-- 
2.29.2

