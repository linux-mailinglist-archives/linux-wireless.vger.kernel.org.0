Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3945E6D10CD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjC3VXB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjC3VW5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 17:22:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D099E1043F;
        Thu, 30 Mar 2023 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Bo8wBgP5LFr7iH0j8q/YBCQ8VI5vd27cc9RPj+Ka0LY=;
        t=1680211356; x=1681420956; b=kYAbkkLdJ/+Tb/Pu8oIhPPBsFr/vjxZT3DK+N/Yijt4VUbf
        eLOvB+ZmEyHZ20l3jQwRMrm5IBSoq+S03ZRVUpjX4+i6+PVtiqOF6hbZd2AIar0PaK+Ih9PLvtbao
        2IIp6RzdlMl+CND1lhqKQRfLXCabaveXC7fDicRMmrHvrWwYbYfhVwvtBttoiiI2chmN5H7j3AntL
        EpS5shNuZrhKroR2B1Wa+xIkMPG/xwejWaPREacAwy/OK7pzB1q8KGnLpHqGx2D45GxMPUy1R81Et
        eFToSkUeKuQrHey1hwyLhuNIhMCn9BJF9juZov1u7g74X2xcIbo+/sZxZNHgKUhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1phzj3-001Shm-2h;
        Thu, 30 Mar 2023 23:22:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 2/2] mac80211: use the new drop reasons infrastructure
Date:   Thu, 30 Mar 2023 23:22:27 +0200
Message-Id: <20230330232146.015cb10f5cd8.Iea29d70af97ce2ed590a00dbebee2ab4d013dfd5@changeid>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330212227.928595-1-johannes@sipsolutions.net>
References: <20230330212227.928595-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It can be really hard to analyse or debug why packets are
going missing in mac80211, so add the needed infrastructure
to use use the new per-subsystem drop reasons.

We actually use two drop reason subsystems here because of
the different handling of frames that are dropped but still
go to monitor for old versions of hostapd, and those that
are just completely unusable (e.g. crypto failed.)

Annotate a few reasons here just to illustrate this, we'll
need to go through and annotate more of them later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/dropreason.h   | 10 +++++++
 net/mac80211/drop.h        | 55 ++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  8 +----
 net/mac80211/main.c        | 30 +++++++++++++++++++
 net/mac80211/rx.c          | 61 ++++++++++++++++++--------------------
 net/mac80211/wpa.c         | 24 +++++++--------
 6 files changed, 137 insertions(+), 51 deletions(-)
 create mode 100644 net/mac80211/drop.h

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index d7a134c108ad..c2c1ee99984b 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -359,6 +359,16 @@ enum skb_drop_reason_subsys {
 	/** @SKB_DROP_REASON_SUBSYS_CORE: core drop reasons defined above */
 	SKB_DROP_REASON_SUBSYS_CORE,
 
+	/** @SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE: mac80211 drop reasons
+	 * for unusable frames, see net/mac80211/drop.h
+	 */
+	SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE,
+
+	/** @SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR: mac80211 drop reasons
+	 * for frames still going to monitor, see net/mac80211/drop.h
+	 */
+	SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR,
+
 	/** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
 	SKB_DROP_REASON_SUBSYS_NUM
 };
diff --git a/net/mac80211/drop.h b/net/mac80211/drop.h
new file mode 100644
index 000000000000..6c243f64d1b8
--- /dev/null
+++ b/net/mac80211/drop.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * mac80211 drop reason list
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#ifndef MAC80211_DROPS_H
+#define MAC80211_DROPS_H
+
+typedef unsigned int __bitwise ieee80211_rx_result;
+
+#define MAC80211_DROP_REASONS_MONITOR(R)	\
+	R(RX_DROP_M_UNEXPECTED_4ADDR_FRAME)	\
+	R(RX_DROP_M_BAD_BCN_KEYIDX)		\
+	R(RX_DROP_M_BAD_MGMT_KEYIDX)		\
+/* this line for the trailing \ - add before this */
+
+#define MAC80211_DROP_REASONS_UNUSABLE(R)	\
+	R(RX_DROP_U_MIC_FAIL)			\
+	R(RX_DROP_U_REPLAY)			\
+	R(RX_DROP_U_BAD_MMIE)			\
+/* this line for the trailing \ - add before this */
+
+/* having two enums allows for checking ieee80211_rx_result use with sparse */
+enum ___mac80211_drop_reason {
+/* if we get to the end of handlers with RX_CONTINUE this will be the reason */
+	___RX_CONTINUE	= SKB_CONSUMED,
+
+/* this never gets used as an argument to kfree_skb_reason() */
+	___RX_QUEUED	= SKB_NOT_DROPPED_YET,
+
+#define ENUM(x) ___ ## x,
+	___RX_DROP_MONITOR = SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR <<
+		SKB_DROP_REASON_SUBSYS_SHIFT,
+	MAC80211_DROP_REASONS_MONITOR(ENUM)
+
+	___RX_DROP_UNUSABLE = SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE <<
+		SKB_DROP_REASON_SUBSYS_SHIFT,
+	MAC80211_DROP_REASONS_UNUSABLE(ENUM)
+#undef ENUM
+};
+
+enum mac80211_drop_reason {
+	RX_CONTINUE	 = (__force ieee80211_rx_result)___RX_CONTINUE,
+	RX_QUEUED	 = (__force ieee80211_rx_result)___RX_QUEUED,
+	RX_DROP_MONITOR	 = (__force ieee80211_rx_result)___RX_DROP_MONITOR,
+	RX_DROP_UNUSABLE = (__force ieee80211_rx_result)___RX_DROP_UNUSABLE,
+#define DEF(x) x = (__force ieee80211_rx_result)___ ## x,
+	MAC80211_DROP_REASONS_MONITOR(DEF)
+	MAC80211_DROP_REASONS_UNUSABLE(DEF)
+#undef DEF
+};
+
+#endif /* MAC80211_DROPS_H */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cdc80285efd4..b682fdfa29c9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -33,6 +33,7 @@
 #include "key.h"
 #include "sta_info.h"
 #include "debug.h"
+#include "drop.h"
 
 extern const struct cfg80211_ops mac80211_config_ops;
 
@@ -170,13 +171,6 @@ struct ieee80211_tx_data {
 	unsigned int flags;
 };
 
-
-typedef unsigned __bitwise ieee80211_rx_result;
-#define RX_CONTINUE		((__force ieee80211_rx_result) 0u)
-#define RX_DROP_UNUSABLE	((__force ieee80211_rx_result) 1u)
-#define RX_DROP_MONITOR		((__force ieee80211_rx_result) 2u)
-#define RX_QUEUED		((__force ieee80211_rx_result) 3u)
-
 /**
  * enum ieee80211_packet_rx_flags - packet RX flags
  * @IEEE80211_RX_AMSDU: a-MSDU packet
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 846528850612..4b3c07bc9d02 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1540,6 +1540,28 @@ void ieee80211_free_hw(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL(ieee80211_free_hw);
 
+static const char * const drop_reasons_monitor[] = {
+#define V(x)	#x,
+	[0] = "RX_DROP_MONITOR",
+	MAC80211_DROP_REASONS_MONITOR(V)
+};
+
+static struct drop_reason_list drop_reason_list_monitor = {
+	.reasons = drop_reasons_monitor,
+	.n_reasons = ARRAY_SIZE(drop_reasons_monitor),
+};
+
+static const char * const drop_reasons_unusable[] = {
+	[0] = "RX_DROP_UNUSABLE",
+	MAC80211_DROP_REASONS_UNUSABLE(V)
+#undef V
+};
+
+static struct drop_reason_list drop_reason_list_unusable = {
+	.reasons = drop_reasons_unusable,
+	.n_reasons = ARRAY_SIZE(drop_reasons_unusable),
+};
+
 static int __init ieee80211_init(void)
 {
 	struct sk_buff *skb;
@@ -1557,6 +1579,11 @@ static int __init ieee80211_init(void)
 	if (ret)
 		goto err_netdev;
 
+	drop_reasons_register_subsys(SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR,
+				     &drop_reason_list_monitor);
+	drop_reasons_register_subsys(SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE,
+				     &drop_reason_list_unusable);
+
 	return 0;
  err_netdev:
 	rc80211_minstrel_exit();
@@ -1572,6 +1599,9 @@ static void __exit ieee80211_exit(void)
 
 	ieee80211_iface_exit();
 
+	drop_reasons_unregister_subsys(SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR);
+	drop_reasons_unregister_subsys(SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE);
+
 	rcu_barrier();
 }
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1c957194554b..bac29a17c11f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1826,7 +1826,7 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 				cfg80211_rx_unexpected_4addr_frame(
 					rx->sdata->dev, sta->sta.addr,
 					GFP_ATOMIC);
-			return RX_DROP_MONITOR;
+			return RX_DROP_M_UNEXPECTED_4ADDR_FRAME;
 		}
 		/*
 		 * Update counter and free packet here to avoid
@@ -1961,7 +1961,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 				cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 							     skb->data,
 							     skb->len);
-			return RX_DROP_MONITOR; /* unexpected BIP keyidx */
+			return RX_DROP_M_BAD_BCN_KEYIDX;
 		}
 
 		rx->key = ieee80211_rx_get_bigtk(rx, mmie_keyidx);
@@ -1975,7 +1975,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 
 		if (mmie_keyidx < NUM_DEFAULT_KEYS ||
 		    mmie_keyidx >= NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS)
-			return RX_DROP_MONITOR; /* unexpected BIP keyidx */
+			return RX_DROP_M_BAD_MGMT_KEYIDX; /* unexpected BIP keyidx */
 		if (rx->link_sta) {
 			if (ieee80211_is_group_privacy_action(skb) &&
 			    test_sta_flag(rx->sta, WLAN_STA_MFP))
@@ -3957,7 +3957,8 @@ ieee80211_rx_h_mgmt(struct ieee80211_rx_data *rx)
 }
 
 static void ieee80211_rx_cooked_monitor(struct ieee80211_rx_data *rx,
-					struct ieee80211_rate *rate)
+					struct ieee80211_rate *rate,
+					ieee80211_rx_result reason)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_local *local = rx->local;
@@ -4021,42 +4022,38 @@ static void ieee80211_rx_cooked_monitor(struct ieee80211_rx_data *rx,
 	}
 
  out_free_skb:
-	dev_kfree_skb(skb);
+	kfree_skb_reason(skb, (__force u32)reason);
 }
 
 static void ieee80211_rx_handlers_result(struct ieee80211_rx_data *rx,
 					 ieee80211_rx_result res)
 {
-	switch (res) {
-	case RX_DROP_MONITOR:
-		I802_DEBUG_INC(rx->sdata->local->rx_handlers_drop);
-		if (rx->sta)
-			rx->link_sta->rx_stats.dropped++;
-		fallthrough;
-	case RX_CONTINUE: {
-		struct ieee80211_rate *rate = NULL;
-		struct ieee80211_supported_band *sband;
-		struct ieee80211_rx_status *status;
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_rate *rate = NULL;
 
-		status = IEEE80211_SKB_RXCB((rx->skb));
-
-		sband = rx->local->hw.wiphy->bands[status->band];
-		if (status->encoding == RX_ENC_LEGACY)
-			rate = &sband->bitrates[status->rate_idx];
-
-		ieee80211_rx_cooked_monitor(rx, rate);
-		break;
-		}
-	case RX_DROP_UNUSABLE:
-		I802_DEBUG_INC(rx->sdata->local->rx_handlers_drop);
-		if (rx->sta)
-			rx->link_sta->rx_stats.dropped++;
-		dev_kfree_skb(rx->skb);
-		break;
-	case RX_QUEUED:
+	if (res == RX_QUEUED) {
 		I802_DEBUG_INC(rx->sdata->local->rx_handlers_queued);
-		break;
+		return;
 	}
+
+	if (res != RX_CONTINUE) {
+		I802_DEBUG_INC(rx->sdata->local->rx_handlers_drop);
+		if (rx->sta)
+			rx->link_sta->rx_stats.dropped++;
+	}
+
+	if (u32_get_bits((__force u32)res, SKB_DROP_REASON_SUBSYS_MASK) ==
+			SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE) {
+		kfree_skb_reason(rx->skb, (__force u32)res);
+		return;
+	}
+
+	sband = rx->local->hw.wiphy->bands[status->band];
+	if (status->encoding == RX_ENC_LEGACY)
+		rate = &sband->bitrates[status->rate_idx];
+
+	ieee80211_rx_cooked_monitor(rx, rate, res);
 }
 
 static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 20f742b5503b..4133496da378 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -550,7 +550,7 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 		if (res < 0 ||
 		    (!res && !(status->flag & RX_FLAG_ALLOW_SAME_PN))) {
 			key->u.ccmp.replays++;
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_REPLAY;
 		}
 
 		if (!(status->flag & RX_FLAG_DECRYPTED)) {
@@ -564,7 +564,7 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 				    skb->data + hdrlen + IEEE80211_CCMP_HDR_LEN,
 				    data_len,
 				    skb->data + skb->len - mic_len))
-				return RX_DROP_UNUSABLE;
+				return RX_DROP_U_MIC_FAIL;
 		}
 
 		memcpy(key->u.ccmp.rx_pn[queue], pn, IEEE80211_CCMP_PN_LEN);
@@ -746,7 +746,7 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 		if (res < 0 ||
 		    (!res && !(status->flag & RX_FLAG_ALLOW_SAME_PN))) {
 			key->u.gcmp.replays++;
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_REPLAY;
 		}
 
 		if (!(status->flag & RX_FLAG_DECRYPTED)) {
@@ -761,7 +761,7 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 				    data_len,
 				    skb->data + skb->len -
 				    IEEE80211_GCMP_MIC_LEN))
-				return RX_DROP_UNUSABLE;
+				return RX_DROP_U_MIC_FAIL;
 		}
 
 		memcpy(key->u.gcmp.rx_pn[queue], pn, IEEE80211_GCMP_PN_LEN);
@@ -930,13 +930,13 @@ ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx)
 		(skb->data + skb->len - sizeof(*mmie));
 	if (mmie->element_id != WLAN_EID_MMIE ||
 	    mmie->length != sizeof(*mmie) - 2)
-		return RX_DROP_UNUSABLE; /* Invalid MMIE */
+		return RX_DROP_U_BAD_MMIE; /* Invalid MMIE */
 
 	bip_ipn_swap(ipn, mmie->sequence_number);
 
 	if (memcmp(ipn, key->u.aes_cmac.rx_pn, 6) <= 0) {
 		key->u.aes_cmac.replays++;
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_REPLAY;
 	}
 
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
@@ -946,7 +946,7 @@ ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx)
 				   skb->data + 24, skb->len - 24, mic);
 		if (crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_cmac.icverrors++;
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_MIC_FAIL;
 		}
 	}
 
@@ -986,7 +986,7 @@ ieee80211_crypto_aes_cmac_256_decrypt(struct ieee80211_rx_data *rx)
 
 	if (memcmp(ipn, key->u.aes_cmac.rx_pn, 6) <= 0) {
 		key->u.aes_cmac.replays++;
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_REPLAY;
 	}
 
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
@@ -996,7 +996,7 @@ ieee80211_crypto_aes_cmac_256_decrypt(struct ieee80211_rx_data *rx)
 				       skb->data + 24, skb->len - 24, mic);
 		if (crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_cmac.icverrors++;
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_MIC_FAIL;
 		}
 	}
 
@@ -1079,13 +1079,13 @@ ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx)
 		(skb->data + skb->len - sizeof(*mmie));
 	if (mmie->element_id != WLAN_EID_MMIE ||
 	    mmie->length != sizeof(*mmie) - 2)
-		return RX_DROP_UNUSABLE; /* Invalid MMIE */
+		return RX_DROP_U_BAD_MMIE; /* Invalid MMIE */
 
 	bip_ipn_swap(ipn, mmie->sequence_number);
 
 	if (memcmp(ipn, key->u.aes_gmac.rx_pn, 6) <= 0) {
 		key->u.aes_gmac.replays++;
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_REPLAY;
 	}
 
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
@@ -1104,7 +1104,7 @@ ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx)
 		    crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_gmac.icverrors++;
 			kfree(mic);
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_MIC_FAIL;
 		}
 		kfree(mic);
 	}
-- 
2.39.2

