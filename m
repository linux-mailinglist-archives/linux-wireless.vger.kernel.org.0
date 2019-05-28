Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E492C653
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfE1MTO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 08:19:14 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49026 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfE1MTO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 08:19:14 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hVb4Q-0004vf-CG; Tue, 28 May 2019 14:19:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     j@w1.fi, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: fill all policy .type entries
Date:   Tue, 28 May 2019 14:19:07 +0200
Message-Id: <20190528121907.4115-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.17.2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For old commands, it's fine to have .type = NLA_UNSPEC and it
behaves the same as NLA_MIN_LEN. However, for new commands with
strict validation this is no longer true, and for policy export
to userspace these are also ignored.

Fix up the remaining ones that don't have a type.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 78 ++++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 21 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c391b560d986..4892f307f51d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -304,8 +304,11 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_IFINDEX] = { .type = NLA_U32 },
 	[NL80211_ATTR_IFNAME] = { .type = NLA_NUL_STRING, .len = IFNAMSIZ-1 },
 
-	[NL80211_ATTR_MAC] = { .len = ETH_ALEN },
-	[NL80211_ATTR_PREV_BSSID] = { .len = ETH_ALEN },
+	[NL80211_ATTR_MAC] = { .type = NLA_EXACT_LEN_WARN, .len = ETH_ALEN },
+	[NL80211_ATTR_PREV_BSSID] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = ETH_ALEN
+	},
 
 	[NL80211_ATTR_KEY] = { .type = NLA_NESTED, },
 	[NL80211_ATTR_KEY_DATA] = { .type = NLA_BINARY,
@@ -356,7 +359,10 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MESH_CONFIG] = { .type = NLA_NESTED },
 	[NL80211_ATTR_SUPPORT_MESH_AUTH] = { .type = NLA_FLAG },
 
-	[NL80211_ATTR_HT_CAPABILITY] = { .len = NL80211_HT_CAPABILITY_LEN },
+	[NL80211_ATTR_HT_CAPABILITY] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = NL80211_HT_CAPABILITY_LEN
+	},
 
 	[NL80211_ATTR_MGMT_SUBTYPE] = { .type = NLA_U8 },
 	[NL80211_ATTR_IE] = NLA_POLICY_VALIDATE_FN(NLA_BINARY,
@@ -386,7 +392,10 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_WPA_VERSIONS] = { .type = NLA_U32 },
 	[NL80211_ATTR_PID] = { .type = NLA_U32 },
 	[NL80211_ATTR_4ADDR] = { .type = NLA_U8 },
-	[NL80211_ATTR_PMKID] = { .len = WLAN_PMKID_LEN },
+	[NL80211_ATTR_PMKID] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = WLAN_PMKID_LEN
+	},
 	[NL80211_ATTR_DURATION] = { .type = NLA_U32 },
 	[NL80211_ATTR_COOKIE] = { .type = NLA_U64 },
 	[NL80211_ATTR_TX_RATES] = { .type = NLA_NESTED },
@@ -448,7 +457,10 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_WDEV] = { .type = NLA_U64 },
 	[NL80211_ATTR_USER_REG_HINT_TYPE] = { .type = NLA_U32 },
 	[NL80211_ATTR_AUTH_DATA] = { .type = NLA_BINARY, },
-	[NL80211_ATTR_VHT_CAPABILITY] = { .len = NL80211_VHT_CAPABILITY_LEN },
+	[NL80211_ATTR_VHT_CAPABILITY] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = NL80211_VHT_CAPABILITY_LEN
+	},
 	[NL80211_ATTR_SCAN_FLAGS] = { .type = NLA_U32 },
 	[NL80211_ATTR_P2P_CTWINDOW] = NLA_POLICY_MAX(NLA_U8, 127),
 	[NL80211_ATTR_P2P_OPPPS] = NLA_POLICY_MAX(NLA_U8, 1),
@@ -484,7 +496,10 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_VENDOR_DATA] = { .type = NLA_BINARY },
 	[NL80211_ATTR_QOS_MAP] = { .type = NLA_BINARY,
 				   .len = IEEE80211_QOS_MAP_LEN_MAX },
-	[NL80211_ATTR_MAC_HINT] = { .len = ETH_ALEN },
+	[NL80211_ATTR_MAC_HINT] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = ETH_ALEN
+	},
 	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
 	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
 	[NL80211_ATTR_SOCKET_OWNER] = { .type = NLA_FLAG },
@@ -495,7 +510,10 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_MAX(NLA_U8, IEEE80211_NUM_UPS - 1),
 	[NL80211_ATTR_ADMITTED_TIME] = { .type = NLA_U16 },
 	[NL80211_ATTR_SMPS_MODE] = { .type = NLA_U8 },
-	[NL80211_ATTR_MAC_MASK] = { .len = ETH_ALEN },
+	[NL80211_ATTR_MAC_MASK] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = ETH_ALEN
+	},
 	[NL80211_ATTR_WIPHY_SELF_MANAGED_REG] = { .type = NLA_FLAG },
 	[NL80211_ATTR_NETNS_FD] = { .type = NLA_U32 },
 	[NL80211_ATTR_SCHED_SCAN_DELAY] = { .type = NLA_U32 },
@@ -507,15 +525,21 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MU_MIMO_GROUP_DATA] = {
 		.len = VHT_MUMIMO_GROUPS_DATA_LEN
 	},
-	[NL80211_ATTR_MU_MIMO_FOLLOW_MAC_ADDR] = { .len = ETH_ALEN },
+	[NL80211_ATTR_MU_MIMO_FOLLOW_MAC_ADDR] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = ETH_ALEN
+	},
 	[NL80211_ATTR_NAN_MASTER_PREF] = NLA_POLICY_MIN(NLA_U8, 1),
 	[NL80211_ATTR_BANDS] = { .type = NLA_U32 },
 	[NL80211_ATTR_NAN_FUNC] = { .type = NLA_NESTED },
 	[NL80211_ATTR_FILS_KEK] = { .type = NLA_BINARY,
 				    .len = FILS_MAX_KEK_LEN },
-	[NL80211_ATTR_FILS_NONCES] = { .len = 2 * FILS_NONCE_LEN },
+	[NL80211_ATTR_FILS_NONCES] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = 2 * FILS_NONCE_LEN
+	},
 	[NL80211_ATTR_MULTICAST_TO_UNICAST_ENABLED] = { .type = NLA_FLAG, },
-	[NL80211_ATTR_BSSID] = { .len = ETH_ALEN },
+	[NL80211_ATTR_BSSID] = { .type = NLA_EXACT_LEN_WARN, .len = ETH_ALEN },
 	[NL80211_ATTR_SCHED_SCAN_RELATIVE_RSSI] = { .type = NLA_S8 },
 	[NL80211_ATTR_SCHED_SCAN_RSSI_ADJUST] = {
 		.len = sizeof(struct nl80211_bss_select_rssi_adjust)
@@ -528,7 +552,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_FILS_ERP_NEXT_SEQ_NUM] = { .type = NLA_U16 },
 	[NL80211_ATTR_FILS_ERP_RRK] = { .type = NLA_BINARY,
 					.len = FILS_ERP_MAX_RRK_LEN },
-	[NL80211_ATTR_FILS_CACHE_ID] = { .len = 2 },
+	[NL80211_ATTR_FILS_CACHE_ID] = { .type = NLA_EXACT_LEN_WARN, .len = 2 },
 	[NL80211_ATTR_PMK] = { .type = NLA_BINARY, .len = PMK_MAX_LEN },
 	[NL80211_ATTR_SCHED_SCAN_MULTI] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT] = { .type = NLA_FLAG },
@@ -589,10 +613,13 @@ static const struct nla_policy
 nl80211_wowlan_tcp_policy[NUM_NL80211_WOWLAN_TCP] = {
 	[NL80211_WOWLAN_TCP_SRC_IPV4] = { .type = NLA_U32 },
 	[NL80211_WOWLAN_TCP_DST_IPV4] = { .type = NLA_U32 },
-	[NL80211_WOWLAN_TCP_DST_MAC] = { .len = ETH_ALEN },
+	[NL80211_WOWLAN_TCP_DST_MAC] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = ETH_ALEN
+	},
 	[NL80211_WOWLAN_TCP_SRC_PORT] = { .type = NLA_U16 },
 	[NL80211_WOWLAN_TCP_DST_PORT] = { .type = NLA_U16 },
-	[NL80211_WOWLAN_TCP_DATA_PAYLOAD] = { .len = 1 },
+	[NL80211_WOWLAN_TCP_DATA_PAYLOAD] = { .type = NLA_MIN_LEN, .len = 1 },
 	[NL80211_WOWLAN_TCP_DATA_PAYLOAD_SEQ] = {
 		.len = sizeof(struct nl80211_wowlan_tcp_data_seq)
 	},
@@ -600,8 +627,8 @@ nl80211_wowlan_tcp_policy[NUM_NL80211_WOWLAN_TCP] = {
 		.len = sizeof(struct nl80211_wowlan_tcp_data_token)
 	},
 	[NL80211_WOWLAN_TCP_DATA_INTERVAL] = { .type = NLA_U32 },
-	[NL80211_WOWLAN_TCP_WAKE_PAYLOAD] = { .len = 1 },
-	[NL80211_WOWLAN_TCP_WAKE_MASK] = { .len = 1 },
+	[NL80211_WOWLAN_TCP_WAKE_PAYLOAD] = { .type = NLA_MIN_LEN, .len = 1 },
+	[NL80211_WOWLAN_TCP_WAKE_MASK] = { .type = NLA_MIN_LEN, .len = 1 },
 };
 #endif /* CONFIG_PM */
 
@@ -619,9 +646,12 @@ nl80211_coalesce_policy[NUM_NL80211_ATTR_COALESCE_RULE] = {
 /* policy for GTK rekey offload attributes */
 static const struct nla_policy
 nl80211_rekey_policy[NUM_NL80211_REKEY_DATA] = {
-	[NL80211_REKEY_DATA_KEK] = { .len = NL80211_KEK_LEN },
-	[NL80211_REKEY_DATA_KCK] = { .len = NL80211_KCK_LEN },
-	[NL80211_REKEY_DATA_REPLAY_CTR] = { .len = NL80211_REPLAY_CTR_LEN },
+	[NL80211_REKEY_DATA_KEK] = { .type = NLA_EXACT_LEN_WARN, .len = NL80211_KEK_LEN },
+	[NL80211_REKEY_DATA_KCK] = { .type = NLA_EXACT_LEN_WARN, .len = NL80211_KCK_LEN },
+	[NL80211_REKEY_DATA_REPLAY_CTR] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = NL80211_REPLAY_CTR_LEN
+	},
 };
 
 static const struct nla_policy
@@ -635,7 +665,10 @@ static const struct nla_policy
 nl80211_match_policy[NL80211_SCHED_SCAN_MATCH_ATTR_MAX + 1] = {
 	[NL80211_SCHED_SCAN_MATCH_ATTR_SSID] = { .type = NLA_BINARY,
 						 .len = IEEE80211_MAX_SSID_LEN },
-	[NL80211_SCHED_SCAN_MATCH_ATTR_BSSID] = { .len = ETH_ALEN },
+	[NL80211_SCHED_SCAN_MATCH_ATTR_BSSID] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = ETH_ALEN
+	},
 	[NL80211_SCHED_SCAN_MATCH_ATTR_RSSI] = { .type = NLA_U32 },
 	[NL80211_SCHED_SCAN_MATCH_PER_BAND_RSSI] =
 		NLA_POLICY_NESTED(nl80211_match_band_rssi_policy),
@@ -667,7 +700,10 @@ nl80211_nan_func_policy[NL80211_NAN_FUNC_ATTR_MAX + 1] = {
 	[NL80211_NAN_FUNC_SUBSCRIBE_ACTIVE] = { .type = NLA_FLAG },
 	[NL80211_NAN_FUNC_FOLLOW_UP_ID] = { .type = NLA_U8 },
 	[NL80211_NAN_FUNC_FOLLOW_UP_REQ_ID] = { .type = NLA_U8 },
-	[NL80211_NAN_FUNC_FOLLOW_UP_DEST] = { .len = ETH_ALEN },
+	[NL80211_NAN_FUNC_FOLLOW_UP_DEST] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = ETH_ALEN
+	},
 	[NL80211_NAN_FUNC_CLOSE_RANGE] = { .type = NLA_FLAG },
 	[NL80211_NAN_FUNC_TTL] = { .type = NLA_U32 },
 	[NL80211_NAN_FUNC_SERVICE_INFO] = { .type = NLA_BINARY,
@@ -4057,7 +4093,7 @@ static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 				    .len = NL80211_MAX_SUPP_RATES },
 	[NL80211_TXRATE_HT] = { .type = NLA_BINARY,
 				.len = NL80211_MAX_SUPP_HT_RATES },
-	[NL80211_TXRATE_VHT] = { .len = sizeof(struct nl80211_txrate_vht)},
+	[NL80211_TXRATE_VHT] = { .type = NLA_EXACT_LEN_WARN, .len = sizeof(struct nl80211_txrate_vht)},
 	[NL80211_TXRATE_GI] = { .type = NLA_U8 },
 };
 
-- 
2.17.2

