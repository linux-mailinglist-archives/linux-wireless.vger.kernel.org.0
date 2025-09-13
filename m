Return-Path: <linux-wireless+bounces-27275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A76B562ED
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Sep 2025 22:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7D3189E8DF
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Sep 2025 20:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2DB15D1;
	Sat, 13 Sep 2025 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONhsV7LM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA67258CDA
	for <linux-wireless@vger.kernel.org>; Sat, 13 Sep 2025 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757795300; cv=none; b=RHAspkOVlJeKrv0v4KogAL+nsUsF/vPfmWs27U2Q8AVCAYMYZzjbLq7Weg7o3geCySRP3yXgAM64KwV4bXFT3WATswujlC5oVfchnjaA0KRodJT87U7ILNwUNsFZnXDZbj2Oq1DT7nWMzrKvHrvYu4pJRve0dyJ6TLp2Erjj9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757795300; c=relaxed/simple;
	bh=LR88v/cJJwQx4DOhx0dDcmOQCijLqX77XZssZoKL4Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SC79QlhTlww5JBewRnh3LtWZN4zQ1H6qDAG0bIK7/2XXt22+q6vu+E1m4q9ZjmTVy8iyfaDasfLL8RNsHvIfqWCzE5Ccitpcy3BvHZDVPrVAbUSsGWujLeUKQ/qnb6HGIkYxEqijLsmauNrQNg+gbsOu3wCnTeHLBHQQ52foaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONhsV7LM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78ead12so384369266b.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Sep 2025 13:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757795295; x=1758400095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp9Qf519v85w8U4wQbMLPJz9nPSuEserszF44qXcWDY=;
        b=ONhsV7LM0Jmlf1ia0qJUzUhGQ5Vd4rKsUlZ8O8r1eUdKdhVphFVIiIqNUhVdz7NN2r
         9gLGqvvKjE+ZZGMqkYJrFcf8YQ6QGc+ZNvuI45A/9R0U/8eAK+0Yir1WjRzt7wnvRQka
         ezdEshcJ5YgeM1joZ+sWkYfHtM7KKQVpcdQwceVb8vVfuPV1n4RXdiDe6LW1XoPU1xXV
         fdlj3R5h66jYrMLvVi3Oy/2U+O2uBSmmMtXgNEj5CxLEiCMHbXt56X9fK5AAlsPuHYEs
         0QFRAZuzdFIylKZA0aM6ykVIY7GLnGma+Fg1Gh/OD5LvKUJdNAsh5KvmKhphYqrFSp/l
         1jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757795295; x=1758400095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp9Qf519v85w8U4wQbMLPJz9nPSuEserszF44qXcWDY=;
        b=CZqMAbrwyTDAPQM1vbTn05ttwWVHNINPqQPCCxbP5swrH7xVGIUQ8oWCOiIOSL9VDK
         U+rFzzFB+lKaXRPSuLOb9mw7MG0AjFIditXcNvcZR05W+iKAOlSJQiIijJKjqMIZQ68T
         amZy5jn3nBFd9ZQvm44ud0v80L7fdn1Nj107OqmJ2qCuO4PrF0KNRrWAP6tZ3Bg7JWBy
         dt2PK6ZPLLONYAePmNqYedzFWwscXQzSGb6oxw0PbzspyELavpXPb28OZpPLrCp+KWSV
         ZCLiF8k/5AeaKB3ZSR3seAjEYshixVi8KPPBIrVFwcuyNxv3Mli3uYLCyHeMcOQIbqgG
         ta5w==
X-Gm-Message-State: AOJu0YxKcZL9tDQmmWBNd1Dg3JeHfkw0P8gFSj74sKmIjXJ4awEeib18
	H3fa6NyJPtjoFhWk/0mmnJnavDWij2CiR3h+FtBd8BiA2EnVNSkVIAepHCTb8yxk
X-Gm-Gg: ASbGncurCGLJW6I4TLoZ2idOJAVKl0FUm0rQDW4kSYJ1V3cTnl0rW6uLmgpry2Cy7s1
	wF+p1Pm5FweAsdjFyfyMvHfJea269UShsco5lCAdMrsagw4wI7y87+Nhp/kKSo/oO9SXzohK9hd
	5oR0mLEfA6+z6ftoqhkjfyU//dg93z4uBXoTCTlkosh/5TWgqf850yNIqaxc9a+/Bb8Ltg2bjz7
	XcwcFwibyTAWkuu0nH8RIqRAJoW23J7iqpqn/qTwAbo1RH6CN3yz9VVJtgxjiU7LFsHzoMC0L96
	p8F+v+zKFs42bWcglFTLZOW8drdUTT6ddQwHEhE4tb12jcF22qI1JrJ+r3JQ891yMpxW314jZ3u
	NMCUuv3ABg/f9w6sXQHQs2MhNKwCtW3OcfsVrFNubStouwr6tOnoluM6Rrfw1
X-Google-Smtp-Source: AGHT+IHdp0lJ8wBKVWE1ADP18JO6FViD07yG6HUCXFuBfCOeYuFxxAw1jqEw9IHwYXhQyCsP9LyksA==
X-Received: by 2002:a17:907:3e24:b0:b04:4d7b:9ad2 with SMTP id a640c23a62f3a-b07c37fbe0emr669171566b.39.1757795294577;
        Sat, 13 Sep 2025 13:28:14 -0700 (PDT)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f1e26sm629095566b.77.2025.09.13.13.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:28:14 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	j@w1.fi,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v3 wireless-next 1/2] wifi: cfg80211: allow send/recv tagged EAPOLs
Date: Sat, 13 Sep 2025 22:28:00 +0200
Message-ID: <20250913202801.448853-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Base on EasyMesh spec and traffic separation we have:
"If a Multi-AP Agent configures a Primary VLAN ID, the Multi-AP Agent
shall send EtherType 0x888E frames on a Wi-Fi link in a Multi-AP
Profile-2 Network Segment with an 802.1Q C-Tag with VLAN ID equal
to the Primary VLAN ID."

Add option that extend current control port implementation when
NL80211_ATTR_CONTROL_PORT_OVER_NL80211_VLAN used and allow to setup
VLAN id for control port frames for both TX/RX direction.

When set for RX direction:
 - lower layer should check vlan id and strip 8021Q header before
   pass it to usermode
When set for TX direction:
 - lower layer should add proper 8021Q header

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 include/net/cfg80211.h       |  8 +++++++-
 include/uapi/linux/nl80211.h |  8 +++++++-
 net/mac80211/ieee80211_i.h   |  2 +-
 net/mac80211/tx.c            |  2 +-
 net/wireless/nl80211.c       | 20 +++++++++++++++++++-
 net/wireless/rdev-ops.h      |  7 ++++---
 net/wireless/trace.h         | 12 ++++++++----
 7 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4072a67c9cc9..ad0bee7e6813 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1485,6 +1485,11 @@ struct cfg80211_s1g_short_beacon {
  * @mbssid_config: AP settings for multiple bssid
  * @s1g_long_beacon_period: S1G long beacon period
  * @s1g_short_beacon: S1G short beacon data
+ * @control_port_vlan_id: if set (nonzero) userspace expect to receive also
+ *	8021Q tagged control port protocol frames. Verification of VLAN id
+ *	should be done in lower layer. Also 8021Q header should be stripped.
+ *	For tx path userspace expect lower layer will add proper 8021Q header
+ *	and setup VLAN id.
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1520,6 +1525,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_mbssid_config mbssid_config;
 	u8 s1g_long_beacon_period;
 	struct cfg80211_s1g_short_beacon s1g_short_beacon;
+	u16 control_port_vlan_id;
 };
 
 
@@ -5091,7 +5097,7 @@ struct cfg80211_ops {
 				   const u8 *buf, size_t len,
 				   const u8 *dest, const __be16 proto,
 				   const bool noencrypt, int link_id,
-				   u64 *cookie);
+				   u64 *cookie, u16 vlan_id);
 
 	int	(*get_ftm_responder_stats)(struct wiphy *wiphy,
 				struct net_device *dev,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index aed0b4c5d5e8..19f6d69ac7d0 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2680,7 +2680,8 @@ enum nl80211_commands {
  *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
  *
  * @NL80211_ATTR_VLAN_ID: VLAN ID (1..4094) for the station and VLAN group key
- *	(u16).
+ *	(u16). For %NL80211_ATTR_CONTROL_PORT_OVER_NL80211_VLAN allow to
+ *	receive and send tagged (8021Q) control port packets.
  *
  * @NL80211_ATTR_HE_BSS_COLOR: nested attribute for BSS Color Settings.
  *
@@ -6692,6 +6693,10 @@ enum nl80211_feature_flags {
  *
  * @NL80211_EXT_FEATURE_BEACON_RATE_EHT: Driver supports beacon rate
  *	configuration (AP/mesh) with EHT rates.
+ * @NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_VLAN: Driver supports
+ *	sending and receiving control port frames over nl80211 with VLAN
+ *	support. Userspace can provide a VLAN ID in the control port request
+ *	to send packets on that VLAN.
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -6769,6 +6774,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_DFS_CONCURRENT,
 	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
 	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
+	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_VLAN,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8a666faeb1ec..2c785ecf70f0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2165,7 +2165,7 @@ void ieee80211_clear_fast_xmit(struct sta_info *sta);
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted,
-			      int link_id, u64 *cookie);
+			      int link_id, u64 *cookie, u16 vlan_id);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
 void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a27e2af5d569..8e0221f68fa7 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -6312,7 +6312,7 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted,
-			      int link_id, u64 *cookie)
+			      int link_id, u64 *cookie, u16 vlan_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b7bc7e5e81dd..2247cb5c75e3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6607,6 +6607,16 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out;
 
+	if (info->attrs[NL80211_ATTR_VLAN_ID]) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_VLAN)) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+		params->control_port_vlan_id =
+			nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
+	}
+
 	if (info->attrs[NL80211_ATTR_INACTIVITY_TIMEOUT]) {
 		if (!(rdev->wiphy.features & NL80211_FEATURE_INACTIVITY_TIMER)) {
 			err = -EOPNOTSUPP;
@@ -16745,6 +16755,7 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	u8 *dest;
 	u16 proto;
 	bool noencrypt;
+	u16 vlan_id = 0;
 	u64 cookie = 0;
 	int link_id;
 	int err;
@@ -16790,9 +16801,16 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 
 	link_id = nl80211_link_id_or_invalid(info->attrs);
 
+	if (info->attrs[NL80211_ATTR_VLAN_ID]) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_VLAN))
+			return -EOPNOTSUPP;
+		vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
+	}
+
 	err = rdev_tx_control_port(rdev, dev, buf, len,
 				   dest, cpu_to_be16(proto), noencrypt, link_id,
-				   dont_wait_for_ack ? NULL : &cookie);
+				   dont_wait_for_ack ? NULL : &cookie, vlan_id);
 	if (!err && !dont_wait_for_ack)
 		nl_set_extack_cookie_u64(info->extack, cookie);
 	return err;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index ac6884bacf3f..5b1e629ee3e8 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -774,13 +774,14 @@ static inline int rdev_tx_control_port(struct cfg80211_registered_device *rdev,
 				       const void *buf, size_t len,
 				       const u8 *dest, __be16 proto,
 				       const bool noencrypt, int link,
-				       u64 *cookie)
+				       u64 *cookie, u16 vlan_id)
 {
 	int ret;
 	trace_rdev_tx_control_port(&rdev->wiphy, dev, buf, len,
-				   dest, proto, noencrypt, link);
+				   dest, proto, noencrypt, link, vlan_id);
 	ret = rdev->ops->tx_control_port(&rdev->wiphy, dev, buf, len,
-					 dest, proto, noencrypt, link, cookie);
+					 dest, proto, noencrypt, link,
+					 cookie, vlan_id);
 	if (cookie)
 		trace_rdev_return_int_cookie(&rdev->wiphy, ret, *cookie);
 	else
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 9b6074155d59..16367fee8fec 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2202,8 +2202,8 @@ TRACE_EVENT(rdev_mgmt_tx,
 TRACE_EVENT(rdev_tx_control_port,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 const u8 *buf, size_t len, const u8 *dest, __be16 proto,
-		 bool unencrypted, int link_id),
-	TP_ARGS(wiphy, netdev, buf, len, dest, proto, unencrypted, link_id),
+		 bool unencrypted, int link_id, u16 vlan_id),
+	TP_ARGS(wiphy, netdev, buf, len, dest, proto, unencrypted, link_id, vlan_id),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
@@ -2211,6 +2211,7 @@ TRACE_EVENT(rdev_tx_control_port,
 		__field(__be16, proto)
 		__field(bool, unencrypted)
 		__field(int, link_id)
+		__field(u16, vlan_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -2219,13 +2220,16 @@ TRACE_EVENT(rdev_tx_control_port,
 		__entry->proto = proto;
 		__entry->unencrypted = unencrypted;
 		__entry->link_id = link_id;
+		__entry->vlan_id = vlan_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM,"
-		  " proto: 0x%x, unencrypted: %s, link: %d",
+		  " proto: 0x%x, unencrypted: %s, link: %d,"
+		  " vlan_id: %hu",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->dest,
 		  be16_to_cpu(__entry->proto),
 		  BOOL_TO_STR(__entry->unencrypted),
-		  __entry->link_id)
+		  __entry->link_id,
+		  __entry->vlan_id)
 );
 
 TRACE_EVENT(rdev_set_noack_map,
-- 
2.43.0


