Return-Path: <linux-wireless+bounces-21208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BFCA7EC1D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 21:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AAB161CB2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8C3214;
	Mon,  7 Apr 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUcvZdn4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99D2AEE3
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051126; cv=none; b=orsDXgBjAf9dAP//eBzhY/PI0dX0oJ5+oLK0T5q+BGTdTsdhLI7LhoEHH2BWNtDhqDkPltP+xnYsBGdpppYG4dU0OwIssRHN2ThKwnGvtXxE/wHbsyXE+ZtneHX0glC6gfKshL36B3YsnvY0Y9RYH63hBJaNgln1EXPWOU6jBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051126; c=relaxed/simple;
	bh=iGsBLOZw4JzeSoMQlpcvwwxpXxXh0Xq3KIb4Lj3+xpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjSGkNFnNdSns2j7Z5UMvBDd6JmiJ9pT4y0CURAq0VKVjq4SkTjAfBOd98pTV2TFbpfXFP/Q8+V3a/UEAKtFTcQvExD5egJDL1aehV2MXazsjIzGiEFvkxIavvMAfUCBLTJWrSdwlFcF6eDoUnK6IMREcKszNhl3vsZIOyOmGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUcvZdn4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso796373366b.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744051123; x=1744655923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGu1XTxubzqy7PTXDOVdOtmV+HSHKwFlKswqmRXSA+o=;
        b=VUcvZdn4gnxCcoqy44EZZCJYfGs/eQcD9GmGTwVQvpLaM1vdftCNAEk/wvpcvFxseO
         GStYlDqYux+GXk7qa2emTNnn+43oYH5C4GCP8WxdE9Nj121W3LFTKEVWHjFl4Wc7r0Vj
         id0unXdclCLDTt4imbzyRHWPK4m7WLBPG5hD/iVi63QDwKcCB5cd/+jMuJetMqvZ/Jwe
         iWCKOSlzuEhtlKbv8a41+8bkFN/1trzr/4krDdmiUEJ6iYSEn0ltTSCfrIAvz2t9Ummn
         fQ3HQ40PRHNFBrdVEFa13ylwMnbyyuQH5CGudeLbQNdEZCTkJdrtEInXUA+86Ur5nc9/
         vQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744051123; x=1744655923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGu1XTxubzqy7PTXDOVdOtmV+HSHKwFlKswqmRXSA+o=;
        b=dtz5Z26E/eTratC98zlNeQUNdTmXU5j+w75staKvqJf5mxUB/++rIHi5FVfcP/xHeY
         n//+7Y37fh03XprPv4+h3kQAsouRULFLKc6F+MQ4fr//VWKcxpiJ3mwhV8AhexixGI93
         xD/FS9YBDvIltKL/L0ZGG6IdBErxAMAGJq9o15eUR1QSvf2ZHOOaYmq0DhY39BPKMTE0
         FDruIWyLVmVxFyvMabPd3On1QN0SfUa8kxMnhCJ8p/ZDGzLxeNJcxcuttvcvfJVRSzIH
         KVx96sMxPSTPCBNtCCXYMTyeRabzKzuNnPX+8dcQsZtGQFrQ2dhc01rkSXTpbmLgOusP
         d4Ww==
X-Gm-Message-State: AOJu0YxM4BlgQkCnOyGOxkdU5Ld1G3SQ9/6CdIKxRdOH/KxcfzXhzbJR
	DZzD0JZalyTXGKX4zcfT/DYrGyiJe1ZHk9yRnOX42VW8JTm53BGpFNYCXs9l
X-Gm-Gg: ASbGncuedk0tS5HyOUQnPNyetsjLIUl/v3IieUUq89szS8e1N5NxyQIPVl1oRYqKNWg
	fw1g/1Zun17YltYzMBiwVHCrjxuqrYSDygrOqFrzBwDGhjpTNpZuPeg8DO8OqEw3y2H0JDQ0J6X
	y6h6h6NxHPMxIxPIEWhSM9WcxFImNbsMLV8EORAJkIiyyShmtaM/e7UcREw1tsbxntsHxO5HRLS
	0tTcZCSBMmfqSMDLPL6nmtcOr/0Jkhy9d+zkC/xy9HHBpDAgU8u9MJM3tVx0G3zx3vsO0N7fLxJ
	wL2G8dKaFgdOd4dnzsmmrOkVJeEZ+oVP8jo8scawo1EoGftvn37YXsy7n+godbcTejfCKJhvLMK
	C21yok6DRSaVi7BYhytgFVVCIc/4nY5qy4iahkV95UIapZKfeu+KT0SNwY4ke
X-Google-Smtp-Source: AGHT+IHJumOX2Hi/t0SHkpI+MnhvUOml5OoELzkBbas1M9H1ciwlWfiD0Rxdy8bz6gCZ76ywkGdJ9A==
X-Received: by 2002:a17:907:1b1e:b0:ac7:19f0:aa5a with SMTP id a640c23a62f3a-ac7e72ce4dcmr839122466b.27.1744051122267;
        Mon, 07 Apr 2025 11:38:42 -0700 (PDT)
Received: from hp.NAT.swidnica_mmp.vectranet.pl (178235177162.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe99b24sm795355866b.53.2025.04.07.11.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:38:41 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	j@w1.fi,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v2 wireless-next 1/2] wifi: cfg80211: allow send/recv tagged EAPOLs
Date: Mon,  7 Apr 2025 20:34:07 +0200
Message-ID: <20250407183818.759759-1-janusz.dziedzic@gmail.com>
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
NL80211_ATTR_CONTROL_PORT_OVER_NL80211 used and allow to setup
VLAN id for both TX/RX direction.

When set for RX direction:
 - lower layer should check vlan id and strip 8021Q header before
   pass it to usermode
When set for TX direction:
 - lower layer should add proper 8021Q header

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
[v2]:
 - reuse NL80211_ATTR_VLAN_ID
 - check NL80211_ATTR_CONTROL_PORT_OVER_NL80211
 - fix mac80211 compilation

 include/net/cfg80211.h       |  8 +++++++-
 include/uapi/linux/nl80211.h |  3 ++-
 net/mac80211/ieee80211_i.h   |  2 +-
 net/mac80211/tx.c            |  2 +-
 net/wireless/nl80211.c       | 10 +++++++++-
 net/wireless/rdev-ops.h      |  7 ++++---
 net/wireless/trace.h         | 12 ++++++++----
 7 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index efbd79c67be2..47cc25ebb56b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1258,6 +1258,11 @@ struct survey_info {
  *	port frames over NL80211 instead of the network interface.
  * @control_port_no_preauth: disables pre-auth rx over the nl80211 control
  *	port for mac80211
+ * @control_port_vlan_id: if set (nonzero) userspace expect to receive also
+ *	8021Q tagged control port protocol frames. Verification of VLAN id
+ *	should be done in lower layer. Also 8021Q header should be stripped.
+ *	For tx path userspace expect lower layer will add proper 8021Q header
+ *	and setup VLAN id.
  * @psk: PSK (for devices supporting 4-way-handshake offload)
  * @sae_pwd: password for SAE authentication (for devices supporting SAE
  *	offload)
@@ -1290,6 +1295,7 @@ struct cfg80211_crypto_settings {
 	bool control_port_no_encrypt;
 	bool control_port_over_nl80211;
 	bool control_port_no_preauth;
+	u16 control_port_vlan_id;
 	const u8 *psk;
 	const u8 *sae_pwd;
 	u8 sae_pwd_len;
@@ -4963,7 +4969,7 @@ struct cfg80211_ops {
 				   const u8 *buf, size_t len,
 				   const u8 *dest, const __be16 proto,
 				   const bool noencrypt, int link_id,
-				   u64 *cookie);
+				   u64 *cookie, u16 vlan_id);
 
 	int	(*get_ftm_responder_stats)(struct wiphy *wiphy,
 				struct net_device *dev,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ddcc4cda74af..1564b4420cab 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2670,7 +2670,8 @@ enum nl80211_commands {
  *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
  *
  * @NL80211_ATTR_VLAN_ID: VLAN ID (1..4094) for the station and VLAN group key
- *	(u16).
+ *	(u16). For %NL80211_ATTR_CONTROL_PORT_OVER_NL80211 allow to receive
+ *	and send tagged (8021Q) control port packets.
  *
  * @NL80211_ATTR_HE_BSS_COLOR: nested attribute for BSS Color Settings.
  *
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fb05f3cd37ec..7012bda050bb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2105,7 +2105,7 @@ void ieee80211_clear_fast_xmit(struct sta_info *sta);
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted,
-			      int link_id, u64 *cookie);
+			      int link_id, u64 *cookie, u16 vlan_id);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
 void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 20179db88c4a..1988234b6149 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -6139,7 +6139,7 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted,
-			      int link_id, u64 *cookie)
+			      int link_id, u64 *cookie, u16 vlan_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f039a7d0d6f7..07ae84b0212f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11009,6 +11009,10 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 
 		if (info->attrs[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH])
 			settings->control_port_no_preauth = true;
+
+		if (info->attrs[NL80211_ATTR_VLAN_ID])
+			settings->control_port_vlan_id =
+				nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
 	}
 
 	if (info->attrs[NL80211_ATTR_CIPHER_SUITES_PAIRWISE]) {
@@ -15790,6 +15794,7 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	u8 *dest;
 	u16 proto;
 	bool noencrypt;
+	u16 vlan_id = 0;
 	u64 cookie = 0;
 	int link_id;
 	int err;
@@ -15835,9 +15840,12 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 
 	link_id = nl80211_link_id_or_invalid(info->attrs);
 
+	if (info->attrs[NL80211_ATTR_VLAN_ID])
+		vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
+
 	err = rdev_tx_control_port(rdev, dev, buf, len,
 				   dest, cpu_to_be16(proto), noencrypt, link_id,
-				   dont_wait_for_ack ? NULL : &cookie);
+				   dont_wait_for_ack ? NULL : &cookie, vlan_id);
 	if (!err && !dont_wait_for_ack)
 		nl_set_extack_cookie_u64(info->extack, cookie);
 	return err;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 9f4783c2354c..23e581a99a9c 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -769,13 +769,14 @@ static inline int rdev_tx_control_port(struct cfg80211_registered_device *rdev,
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
index 4ed9fada4ec0..4e92601fd72e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2170,8 +2170,8 @@ TRACE_EVENT(rdev_mgmt_tx,
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
@@ -2179,6 +2179,7 @@ TRACE_EVENT(rdev_tx_control_port,
 		__field(__be16, proto)
 		__field(bool, unencrypted)
 		__field(int, link_id)
+		__field(u16, vlan_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -2187,13 +2188,16 @@ TRACE_EVENT(rdev_tx_control_port,
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


