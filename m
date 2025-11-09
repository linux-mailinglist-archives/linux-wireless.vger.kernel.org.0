Return-Path: <linux-wireless+bounces-28710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (unknown [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B18C44644
	for <lists+linux-wireless@lfdr.de>; Sun, 09 Nov 2025 20:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271083AEB2F
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Nov 2025 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71ADDF59;
	Sun,  9 Nov 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxVFDHLk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742621FF26
	for <linux-wireless@vger.kernel.org>; Sun,  9 Nov 2025 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716965; cv=none; b=cuWmkoP+H/4vAPKpXlwXdqYQhKMMEudFZobp2VUgZj9P2dokdH/80If/dYeiyQk4O11gL54nZyedvpSFdua5Rvpkz9OXIF3qzRH8EWM2yVQPQ0BSlZMLuYzhVXDBiNY0yDAyVO8BAdfYTCyK8l2MvqVX1cSzuqRhgpwpRl1xZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716965; c=relaxed/simple;
	bh=rGzRSH9E9SHNDSVPpKtzz/IaFGA0wlGD3xE4MSTAvoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CSZwmf1EURvGOePAA556b5xWVdaD5JADDkYFJsOYlQ5oWX/XUnbvUyobeFfGCXIupiNbDAflJDsyaOof8uL6ZMU3/wgDudvj1z5z7LT9XmOMb4N7Ap8g/fpqRtDS02wWOYjGnNWwSayJhlWX0N8PLXiH7M5U1wxzgpeFVH+VpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxVFDHLk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b72bf7e703fso419738866b.2
        for <linux-wireless@vger.kernel.org>; Sun, 09 Nov 2025 11:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716960; x=1763321760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NzNrNq1JIwHoCfJLiF/0MO7bnsCQzOekfszqFDQxBYE=;
        b=XxVFDHLk36tFbvYO5YXyTM+tWAK4S19WM2So+i05ZTee46erV+t1QZUAIFB+S3yi55
         bONLB/HWyXBmh62tXU3InxvjJgdjUKg65DSr3yhQwhqA61Ib+h9JDicE5g3Uj7WTAnJF
         noXL/WfTM6EUAYV4cu4EmkwRHR3PyRGqB8GtoTKaW/eRN/CDu4mdFjQBMviSFihyN+rN
         9BNmsoCpIYhm9+imzQttYUDZnxygQ3vDcyr+Ux+9GK8nJuyJnsoqftdhywbxCdlEzlSw
         g/vDwFVeKIMteWkSC67YYSqiFOKFFJr6n7T7ofB/0DGxCu7YtLLqX2uY+mxu1PIo8o0z
         Bguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716960; x=1763321760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzNrNq1JIwHoCfJLiF/0MO7bnsCQzOekfszqFDQxBYE=;
        b=K2IH1sP/JUVHqK1f9gXhcKFCp8OryCq3Y59DbBxQvwPHP7Dnv8JRSVPLIdLoaQ6s+5
         m2G+9dMe7jE11o0afaCjyGmx6FwgXSBpqLBgI1cpYu+4ZAh5BiR3lbjwGbEzKsv8M+n/
         zVRWu4fAyj8yb/ZJ8oYIkcGu4XZvX/Io5W80FhMCmwlSkz3R7n72vUFc2ZwvsEthrZxT
         MbynocblEEHBJ8XvLobWoxAGQPmYS56E3x1/iux1rBO1IGnlCHHeT/oHGIFBr2NVc4ZN
         wcCSXNfE2n6/OA+yaZwlfJ2Ta183FuXfqFGkXyFTBrFzmLska8y1SojJ9Pl8VQaN6Z4C
         WmEA==
X-Gm-Message-State: AOJu0YwlGV6DRpXHpowpQbk6P2qtOMT818CLzmwAqZGHO2z9eCbtVBnv
	qbn4q0rZQ3U/u1veabdcfQ+/Np0gCY8lGmy8pdYZI5zy5j11wRR0YFwULkFLp9j+
X-Gm-Gg: ASbGnctKexf3UcKs2QtDLrU0znLB4RvIn/2FYu7ET4L8tNY6J17x0ppxksuddpn31ev
	TpKGEZXeKfzng8LFoigML5kLNGuxN5mynimnhWj+goo+hf9ckN3vw3lI9bZV/LaLhl0wqCj1d6X
	+MU5dzVFI7+jwNf1kmO9knFvIl9tWkn9EO+Bm78BU1+yh4CJyEidT2B4cyktbz168EdwfWCi+PZ
	JxnHd4a+qoZKVcRn57ET8vqnygyGNBcHkXp7nrYW/F9x/cTRLLsYMsjEAMPhfl5CFct7NmlARUn
	ARhel7RtCO5Gr9CC5R4H9M4ALpofN/gI+K3lOAzXooMbFixITL5N26XxCd0ed+mmYRf90Eedi+A
	PxTCBbzR3hekXFHyWASZmW77cNndLFkydFItB1TVmZIdV+4XBsELL/QEh7yTHa7jVOknZ+yXZ9F
	Bc0HxVufoXiZjYIOFXSCdSC94pKR6aQp0sXA2s
X-Google-Smtp-Source: AGHT+IHnLY/fY48BaOXZq2myZ19RfILbPdvqCpvmtxFbVHhOxOghq0ZRAB9lOylcXVAAOwueqmYWuQ==
X-Received: by 2002:a17:907:7e8f:b0:b3f:33f6:fb57 with SMTP id a640c23a62f3a-b72e02d4ab0mr500958166b.9.1762716960160;
        Sun, 09 Nov 2025 11:36:00 -0800 (PST)
Received: from hp.. (93-159-26-33.cgnat.inetia.pl. [93.159.26.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf31286esm873219766b.21.2025.11.09.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:35:59 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	j@w1.fi,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v4 wireless-next 1/2] wifi: cfg80211: allow send/recv tagged EAPOLs
Date: Sun,  9 Nov 2025 20:35:42 +0100
Message-ID: <20251109193543.2858854-1-janusz.dziedzic@gmail.com>
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

While easy mesh AP could serve both fronthaul + backhaul:

RX accept EAPOL:
 - with VLAN tag (backhaul STA) - strips tag, forwards to userspace
 - without VLAN tag (regular client) forwards to userspace as-is

TX (controlled by hostapd per-STA):
 - For backhaul STA: hostapd sets NL80211_ATTR_VLAN_ID,
   frame is tagged with Primary VLAN ID
 - For regular client: hostapd omits NL80211_ATTR_VLAN_ID
   frame sent without VLAN tag

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 include/net/cfg80211.h       | 23 +++++++++++++++++++++-
 include/uapi/linux/nl80211.h |  8 +++++++-
 net/mac80211/ieee80211_i.h   |  2 +-
 net/mac80211/tx.c            |  2 +-
 net/wireless/nl80211.c       | 37 +++++++++++++++++++++++++++++++++++-
 net/wireless/rdev-ops.h      |  7 ++++---
 net/wireless/trace.h         | 11 +++++++----
 7 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f2e8963cfaac..e7baa35a588a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1499,6 +1499,12 @@ struct cfg80211_s1g_short_beacon {
  * @mbssid_config: AP settings for multiple bssid
  * @s1g_long_beacon_period: S1G long beacon period
  * @s1g_short_beacon: S1G short beacon data
+ * @control_port_vlan_id: VLAN ID for control port protocol frames; 0 means
+ *	no encapsulation. If set (nonzero) userspace expect to receive also
+ *	802.1Q tagged control port protocol frames. Verification of VLAN id
+ *	should be done in lower layer. Also 802.1Q header should be stripped.
+ *	For tx path userspace expect lower layer will add proper 802.1Q header
+ *	and setup VLAN id.
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1534,6 +1540,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_mbssid_config mbssid_config;
 	u8 s1g_long_beacon_period;
 	struct cfg80211_s1g_short_beacon s1g_short_beacon;
+	u16 control_port_vlan_id;
 };
 
 
@@ -3321,6 +3328,12 @@ enum cfg80211_assoc_req_flags {
  *	valid iff @link_id >= 0
  * @ext_mld_capa_ops: extended MLD capabilities and operations set by
  *	userspace for the association
+ * @control_port_vlan_id: VLAN ID for control port protocol frames; 0 means
+ *	no encapsulation. If set (nonzero) userspace expects to receive
+ *	802.1Q tagged control port protocol frames. Verification of VLAN id
+ *	should be done in lower layer. Also 802.1Q header should be stripped.
+ *	For tx path userspace expects lower layer will add proper 802.1Q header
+ *	and setup VLAN id.
  */
 struct cfg80211_assoc_request {
 	struct cfg80211_bss *bss;
@@ -3342,6 +3355,7 @@ struct cfg80211_assoc_request {
 	const u8 *ap_mld_addr;
 	s8 link_id;
 	u16 ext_mld_capa_ops;
+	u16 control_port_vlan_id;
 };
 
 /**
@@ -3520,6 +3534,12 @@ struct cfg80211_bss_selection {
  * @edmg: define the EDMG channels.
  *	This may specify multiple channels and bonding options for the driver
  *	to choose from, based on BSS configuration.
+ * @control_port_vlan_id: VLAN ID for control port protocol frames; 0 means
+ *	no encapsulation. If set (nonzero) userspace expects to receive
+ *	802.1Q tagged control port protocol frames. Verification of VLAN id
+ *	should be done in lower layer. Also 802.1Q header should be stripped.
+ *	For tx path userspace expects lower layer will add proper 802.1Q header
+ *	and setup VLAN id.
  */
 struct cfg80211_connect_params {
 	struct ieee80211_channel *channel;
@@ -3554,6 +3574,7 @@ struct cfg80211_connect_params {
 	size_t fils_erp_rrk_len;
 	bool want_1x;
 	struct ieee80211_edmg edmg;
+	u16 control_port_vlan_id;
 };
 
 /**
@@ -5168,7 +5189,7 @@ struct cfg80211_ops {
 				   const u8 *buf, size_t len,
 				   const u8 *dest, const __be16 proto,
 				   const bool noencrypt, int link_id,
-				   u64 *cookie);
+				   u64 *cookie, u16 vlan_id);
 
 	int	(*get_ftm_responder_stats)(struct wiphy *wiphy,
 				struct net_device *dev,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8134f10e4e6c..14311e6cf037 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2700,7 +2700,8 @@ enum nl80211_commands {
  *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
  *
  * @NL80211_ATTR_VLAN_ID: VLAN ID (1..4094) for the station and VLAN group key
- *	(u16).
+ *	(u16). For %NL80211_ATTR_CONTROL_PORT_OVER_NL80211_VLAN allow to
+ *	receive and send tagged (802.1Q) control port packets.
  *
  * @NL80211_ATTR_HE_BSS_COLOR: nested attribute for BSS Color Settings.
  *
@@ -6743,6 +6744,10 @@ enum nl80211_feature_flags {
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
@@ -6820,6 +6825,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_DFS_CONCURRENT,
 	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
 	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
+	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_VLAN,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 878c3b14aeb8..b5442916df64 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2164,7 +2164,7 @@ void ieee80211_clear_fast_xmit(struct sta_info *sta);
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted,
-			      int link_id, u64 *cookie);
+			      int link_id, u64 *cookie, u16 vlan_id);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
 void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e7b141c55f7a..b2eb72cca892 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -6318,7 +6318,7 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted,
-			      int link_id, u64 *cookie)
+			      int link_id, u64 *cookie, u16 vlan_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2187e148389d..1af3a286dda6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6690,6 +6690,16 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -12445,6 +12455,15 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = nl80211_crypto_settings(rdev, info, &req.crypto, 1);
+	if (!err && info->attrs[NL80211_ATTR_VLAN_ID]) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_VLAN)) {
+			err = -EOPNOTSUPP;
+			goto free;
+		}
+		req.control_port_vlan_id =
+			nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
+	}
 	if (!err) {
 		struct nlattr *link;
 		int rem = 0;
@@ -13107,6 +13126,14 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
+	if (info->attrs[NL80211_ATTR_VLAN_ID]) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_VLAN))
+			return -EOPNOTSUPP;
+		connect.control_port_vlan_id =
+			nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
+	}
+
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_STATION &&
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
@@ -17017,6 +17044,7 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	size_t len;
 	u8 *dest;
 	u16 proto;
+	u16 vlan_id = 0;
 	bool noencrypt;
 	u64 cookie = 0;
 	int link_id;
@@ -17063,9 +17091,16 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 
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
index ac6884bacf3f..3c158fd14198 100644
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
+					 dest, proto, noencrypt, link, cookie,
+					 vlan_id);
 	if (cookie)
 		trace_rdev_return_int_cookie(&rdev->wiphy, ret, *cookie);
 	else
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 2b71f1d867a0..f22ebb29c166 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2223,8 +2223,9 @@ TRACE_EVENT(rdev_mgmt_tx,
 TRACE_EVENT(rdev_tx_control_port,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 const u8 *buf, size_t len, const u8 *dest, __be16 proto,
-		 bool unencrypted, int link_id),
-	TP_ARGS(wiphy, netdev, buf, len, dest, proto, unencrypted, link_id),
+		 bool unencrypted, int link_id, u16 vlan_id),
+	TP_ARGS(wiphy, netdev, buf, len, dest, proto, unencrypted, link_id,
+		vlan_id),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
@@ -2232,6 +2233,7 @@ TRACE_EVENT(rdev_tx_control_port,
 		__field(__be16, proto)
 		__field(bool, unencrypted)
 		__field(int, link_id)
+		__field(u16, vlan_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -2240,13 +2242,14 @@ TRACE_EVENT(rdev_tx_control_port,
 		__entry->proto = proto;
 		__entry->unencrypted = unencrypted;
 		__entry->link_id = link_id;
+		__entry->vlan_id = vlan_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM,"
-		  " proto: 0x%x, unencrypted: %s, link: %d",
+		  " proto: 0x%x, unencrypted: %s, link: %d, vlan: %u",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->dest,
 		  be16_to_cpu(__entry->proto),
 		  BOOL_TO_STR(__entry->unencrypted),
-		  __entry->link_id)
+		  __entry->link_id, __entry->vlan_id)
 );
 
 TRACE_EVENT(rdev_set_noack_map,
-- 
2.43.0


