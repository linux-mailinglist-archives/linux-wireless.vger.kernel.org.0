Return-Path: <linux-wireless+bounces-35451-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQ4A5l28GkMTwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35451-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 10:58:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67650480B7F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 10:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 431E9318B6F8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708C3D8108;
	Tue, 28 Apr 2026 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="o1YS5FMu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D34A3D905F
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365424; cv=none; b=pJKyz0Nw/iy8XKgY0hqzwpUReRWeTInObwEB0ClmnueF6+5iGHZdjv8AtqsI8/fsuWyexEPD9UHdsSPbl9geuz2VhovFiEoDgZzeVxk2Pm9DbgFI6shxwmo2ZKxVc9ZD5mYLeKsVge7dVuQJ/0egKScAYJUGN+I7ke3s1ZRWC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365424; c=relaxed/simple;
	bh=GGZYbkswQ/Jbg21zAqNyJaguMzKpLMakzijSlOefBfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rf7CMelErVTKE5/jrZ5IrYVPVs8zDkz6gx2tcE4ileF/8jGyPeAYwFzKsN7LkR9s3uK7ahf5vgnqNNMUh8S9r/kjE2r3PcQBnywXvPV+JEE3DA+sgnIpbgVD0IYQeEtfL94YoRtFDSGNr/30dtRP/OpM+vXwOpFkNHLBoLYHRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=o1YS5FMu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+/8h0gtx5iy6SYYmks643lJymA6berkRW2/RZK6ryv0=; t=1777365422; x=1778575022; 
	b=o1YS5FMuv+vNJgUCeJcHMXyh+HPAG2WIRdOcuYJs3D0yKgGbJ/i30Z1g5ZdkTEdr0zB1+6B65PC
	fXqDcGgGq9mltVnSLxyt1IW6zqvUx12XKIjBb3Zh5WHLl0PAqjj7l+Y7zH5vyutZ+ugntlIedJC+n
	g4l93UQ82D5LQrFCA9dsU+YhJ9u4wmpUQt4gmyEgBHC7Y8fb2H/u1jvgW2DOHypDcgMeBMSAKcbpW
	8tw2zN/fEh4hKfmUfkQNV8yEDHG77W00lDSSxuVzIOFjm0BZgRp2WQe8SxtfVEfzAvWErG5gWyCJk
	IDjpQ401jlU8PLiGCztU+P5FvrRkcdiD3jDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHdwB-0000000HASI-1uHU;
	Tue, 28 Apr 2026 10:36:59 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: update UHR capabilities field order
Date: Tue, 28 Apr 2026 10:36:57 +0200
Message-ID: <20260428103657.b40af50f182d.I75306a092dc2c8a9eb7276160f0b7144b4846d18@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 67650480B7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-35451-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim]

From: Johannes Berg <johannes.berg@intel.com>

Since 802.11bn D1.4 the DBE capabilities are after the
PHY capabilities, not between MAC and PHY, adjust the
code accordingly.

Also add a struct for DBE capabilities and use it for
checking the correct length instead of hard-coding the
lengths.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211-uhr.h | 55 +++++++++++++----------------------
 net/mac80211/main.c           |  3 +-
 net/mac80211/mlme.c           |  3 +-
 net/mac80211/uhr.c            |  5 +---
 net/mac80211/util.c           |  3 +-
 5 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index d199f3ebdba0..f4f4bd8256df 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -372,6 +372,12 @@ ieee80211_uhr_npca_dis_subch_bitmap(const struct ieee80211_uhr_operation *oper)
 #define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES	0x08
 #define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES	0x10
 
+struct ieee80211_uhr_cap_dbe {
+	u8 cap;
+	/* present 0, 1 or 2 times depending on _PRES bits */
+	struct ieee80211_eht_mcs_nss_supp_bw eht_mcs_map[];
+} __packed;
+
 /**
  * enum ieee80211_uhr_dbe_max_supported_bw - DBE Maximum Supported Bandwidth
  *
@@ -394,12 +400,6 @@ struct ieee80211_uhr_cap_mac {
 	u8 mac_cap[5];
 } __packed;
 
-struct ieee80211_uhr_cap {
-	struct ieee80211_uhr_cap_mac mac;
-	/* DBE, PHY capabilities */
-	u8 variable[];
-} __packed;
-
 #define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80	0x01
 #define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80	0x02
 #define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160	0x04
@@ -413,11 +413,18 @@ struct ieee80211_uhr_cap_phy {
 	u8 cap;
 } __packed;
 
+struct ieee80211_uhr_cap {
+	struct ieee80211_uhr_cap_mac mac;
+	struct ieee80211_uhr_cap_phy phy;
+	/* optional DBE capabilities */
+	u8 variable[];
+} __packed;
+
 static inline bool ieee80211_uhr_capa_size_ok(const u8 *data, u8 len,
 					      bool from_ap)
 {
 	const struct ieee80211_uhr_cap *cap = (const void *)data;
-	size_t needed = sizeof(*cap) + sizeof(struct ieee80211_uhr_cap_phy);
+	size_t needed = sizeof(*cap);
 
 	if (len < needed)
 		return false;
@@ -427,44 +434,24 @@ static inline bool ieee80211_uhr_capa_size_ok(const u8 *data, u8 len,
 	 * in the UHR MAC Capabilities Information field.
 	 */
 	if (from_ap && cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
-		u8 dbe;
+		const struct ieee80211_uhr_cap_dbe *dbe;
 
-		needed += 1;
+		needed += sizeof(struct ieee80211_uhr_cap_dbe);
 		if (len < needed)
 			return false;
 
-		dbe = cap->variable[0];
+		dbe = (const void *)cap->variable;
 
-		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES)
-			needed += 3;
+		if (dbe->cap & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES)
+			needed += sizeof(dbe->eht_mcs_map[0]);
 
-		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES)
-			needed += 3;
+		if (dbe->cap & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES)
+			needed += sizeof(dbe->eht_mcs_map[0]);
 	}
 
 	return len >= needed;
 }
 
-static inline const struct ieee80211_uhr_cap_phy *
-ieee80211_uhr_phy_cap(const struct ieee80211_uhr_cap *cap, bool from_ap)
-{
-	u8 offs = 0;
-
-	if (from_ap && cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
-		u8 dbe = cap->variable[0];
-
-		offs += 1;
-
-		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES)
-			offs += 3;
-
-		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES)
-			offs += 3;
-	}
-
-	return (const void *)&cap->variable[offs];
-}
-
 #define IEEE80211_SMD_INFO_CAPA_DL_DATA_FWD		0x01
 #define IEEE80211_SMD_INFO_CAPA_MAX_NUM_PREP		0x0E
 #define IEEE80211_SMD_INFO_CAPA_TYPE			0x10
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index f47dd58770ad..21f7fa0cb60e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1459,8 +1459,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 
 	if (supp_uhr)
 		local->scan_ies_len +=
-			3 + sizeof(struct ieee80211_uhr_cap) +
-			sizeof(struct ieee80211_uhr_cap_phy);
+			3 + sizeof(struct ieee80211_uhr_cap);
 
 	if (!local->ops->hw_scan) {
 		/* For hw_scan, driver needs to set these up. */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 05e9644d4917..6693e7e04da2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2225,8 +2225,7 @@ ieee80211_link_common_elems_size(struct ieee80211_sub_if_data *sdata,
 		sizeof(struct ieee80211_eht_mcs_nss_supp) +
 		IEEE80211_EHT_PPE_THRES_MAX_LEN;
 
-	size += 2 + 1 + sizeof(struct ieee80211_uhr_cap) +
-		sizeof(struct ieee80211_uhr_cap_phy);
+	size += 2 + 1 + sizeof(struct ieee80211_uhr_cap);
 
 	return size;
 }
diff --git a/net/mac80211/uhr.c b/net/mac80211/uhr.c
index 2d8f5e5480ef..ca3b471b7981 100644
--- a/net/mac80211/uhr.c
+++ b/net/mac80211/uhr.c
@@ -15,7 +15,6 @@ ieee80211_uhr_cap_ie_to_sta_uhr_cap(struct ieee80211_sub_if_data *sdata,
 				    struct link_sta_info *link_sta)
 {
 	struct ieee80211_sta_uhr_cap *sta_uhr_cap = &link_sta->pub->uhr_cap;
-	bool from_ap;
 
 	memset(sta_uhr_cap, 0, sizeof(*sta_uhr_cap));
 
@@ -23,8 +22,6 @@ ieee80211_uhr_cap_ie_to_sta_uhr_cap(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	sta_uhr_cap->has_uhr = true;
-
 	sta_uhr_cap->mac = uhr_cap->mac;
-	from_ap = sdata->vif.type == NL80211_IFTYPE_STATION;
-	sta_uhr_cap->phy = *ieee80211_uhr_phy_cap(uhr_cap, from_ap);
+	sta_uhr_cap->phy = uhr_cap->phy;
 }
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 89e82d34ae48..2cc058766c1c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4640,8 +4640,7 @@ int ieee80211_put_uhr_cap(struct sk_buff *skb,
 	if (!uhr_cap)
 		return 0;
 
-	len = 2 + 1 + sizeof(struct ieee80211_uhr_cap) +
-	      sizeof(struct ieee80211_uhr_cap_phy);
+	len = 2 + 1 + sizeof(struct ieee80211_uhr_cap);
 
 	if (skb_tailroom(skb) < len)
 		return -ENOBUFS;
-- 
2.53.0


