Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82E523D113
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Aug 2020 21:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgHET4M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Aug 2020 15:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgHEQqQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Aug 2020 12:46:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8CDC0A889F;
        Wed,  5 Aug 2020 07:04:20 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k3K1i-00GoxW-Em; Wed, 05 Aug 2020 16:04:18 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [RFC 2/4] netlink: consistently use NLA_POLICY_MIN_LEN()
Date:   Wed,  5 Aug 2020 16:03:22 +0200
Message-Id: <20200805154803.58b1511df73a.I38ad2c00d1d856ca5627af9bb1fc320317abb3b5@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805140324.72855-1-johannes@sipsolutions.net>
References: <20200805140324.72855-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Change places that open-code NLA_POLICY_MIN_LEN() to
use the macro instead, giving us flexibility in how we
handle the details of the macro.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/macsec.c            | 2 +-
 drivers/net/wireguard/netlink.c | 4 ++--
 net/wireless/nl80211.c          | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 9159846b8b93..124045cbcda3 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1611,7 +1611,7 @@ static const struct nla_policy macsec_genl_rxsc_policy[NUM_MACSEC_RXSC_ATTR] = {
 static const struct nla_policy macsec_genl_sa_policy[NUM_MACSEC_SA_ATTR] = {
 	[MACSEC_SA_ATTR_AN] = { .type = NLA_U8 },
 	[MACSEC_SA_ATTR_ACTIVE] = { .type = NLA_U8 },
-	[MACSEC_SA_ATTR_PN] = { .type = NLA_MIN_LEN, .len = 4 },
+	[MACSEC_SA_ATTR_PN] = NLA_POLICY_MIN_LEN(4),
 	[MACSEC_SA_ATTR_KEYID] = { .type = NLA_BINARY,
 				   .len = MACSEC_KEYID_LEN, },
 	[MACSEC_SA_ATTR_KEY] = { .type = NLA_BINARY,
diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 0e6c6eb9384e..d0f3b6d7f408 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -34,7 +34,7 @@ static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
 	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
 	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(NOISE_SYMMETRIC_KEY_LEN),
 	[WGPEER_A_FLAGS]				= { .type = NLA_U32 },
-	[WGPEER_A_ENDPOINT]				= { .type = NLA_MIN_LEN, .len = sizeof(struct sockaddr) },
+	[WGPEER_A_ENDPOINT]				= NLA_POLICY_MIN_LEN(sizeof(struct sockaddr)),
 	[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]	= { .type = NLA_U16 },
 	[WGPEER_A_LAST_HANDSHAKE_TIME]			= NLA_POLICY_EXACT_LEN(sizeof(struct __kernel_timespec)),
 	[WGPEER_A_RX_BYTES]				= { .type = NLA_U64 },
@@ -45,7 +45,7 @@ static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
 
 static const struct nla_policy allowedip_policy[WGALLOWEDIP_A_MAX + 1] = {
 	[WGALLOWEDIP_A_FAMILY]		= { .type = NLA_U16 },
-	[WGALLOWEDIP_A_IPADDR]		= { .type = NLA_MIN_LEN, .len = sizeof(struct in_addr) },
+	[WGALLOWEDIP_A_IPADDR]		= NLA_POLICY_MIN_LEN(sizeof(struct in_addr)),
 	[WGALLOWEDIP_A_CIDR_MASK]	= { .type = NLA_U8 }
 };
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 248e845ebd5b..076e3e96c809 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -706,7 +706,7 @@ nl80211_wowlan_tcp_policy[NUM_NL80211_WOWLAN_TCP] = {
 	[NL80211_WOWLAN_TCP_DST_MAC] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
 	[NL80211_WOWLAN_TCP_SRC_PORT] = { .type = NLA_U16 },
 	[NL80211_WOWLAN_TCP_DST_PORT] = { .type = NLA_U16 },
-	[NL80211_WOWLAN_TCP_DATA_PAYLOAD] = { .type = NLA_MIN_LEN, .len = 1 },
+	[NL80211_WOWLAN_TCP_DATA_PAYLOAD] = NLA_POLICY_MIN_LEN(1),
 	[NL80211_WOWLAN_TCP_DATA_PAYLOAD_SEQ] = {
 		.len = sizeof(struct nl80211_wowlan_tcp_data_seq)
 	},
@@ -714,8 +714,8 @@ nl80211_wowlan_tcp_policy[NUM_NL80211_WOWLAN_TCP] = {
 		.len = sizeof(struct nl80211_wowlan_tcp_data_token)
 	},
 	[NL80211_WOWLAN_TCP_DATA_INTERVAL] = { .type = NLA_U32 },
-	[NL80211_WOWLAN_TCP_WAKE_PAYLOAD] = { .type = NLA_MIN_LEN, .len = 1 },
-	[NL80211_WOWLAN_TCP_WAKE_MASK] = { .type = NLA_MIN_LEN, .len = 1 },
+	[NL80211_WOWLAN_TCP_WAKE_PAYLOAD] = NLA_POLICY_MIN_LEN(1),
+	[NL80211_WOWLAN_TCP_WAKE_MASK] = NLA_POLICY_MIN_LEN(1),
 };
 #endif /* CONFIG_PM */
 
-- 
2.26.2

