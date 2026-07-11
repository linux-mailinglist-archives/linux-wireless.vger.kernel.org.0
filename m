Return-Path: <linux-wireless+bounces-38866-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G2lhHuPHUWryIgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38866-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 06:34:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D24307404FC
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 06:34:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NDww9BA5;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38866-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38866-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C14A30309A1
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 04:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D922A4E1;
	Sat, 11 Jul 2026 04:34:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04311F63D9
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 04:34:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783744479; cv=none; b=QBYuQmFDf8KWgG1Ouw73LthTwT+xLR4ofcWe2fnNsaAuSXiVgPKE1gz0hcW9S9COB2S/4xvIjlGPa0HOfbypAd3mSdmvv3CJUGJyT/Dj3VChqx2nFmWqRcgmy2iCnkTcSNWj3LzWnmmusjGGaREbcTXj1uLwCtCPk0fvPM7KKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783744479; c=relaxed/simple;
	bh=7W9Y9NkogQ2wcTEPY+Ftfyuh8aIRhcrcerb6YPnGdhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eg2SbiM1trF3qPxxjLDBbcIqRHrEmwfvSmnwi1v5iMFfdXlbB2VXTrcwQrp/XnoGak1/b/BPJMxLlP+XiMEw3Z5fQO+3L2m2vjYWQYHkQUYZbvqEwT1E6IomsU+MCUmlgAelHlRRt4LvWavaFOwKEYafQwvSxNJstA37hOcJtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDww9BA5; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47d70879764so985335f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 21:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783744476; x=1784349276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KFVd0PnUU6xpPdk60y2eMzRpByTjMeoSgiy77ryGbBg=;
        b=NDww9BA5kTZ4UnoCpkq3qRrMHLZlcIq16fteIg92YQSYLcAQox9le+6hakmhdmteNy
         f8/NTdEqhCJLvItVjExGX0x5JAwjXG7CNekNUMNfm9HTy4i+LyrSX9iRE4Jru7pDIwVG
         4wgjoJr0J1oeVD3q8hckWBDX3xhfCr4XSLgWI7JM3nR7oLKZNmEnlUNAPm7f8+K8bt6r
         2KlQmt6BkRZDUttrcsoIyRRQRh0+wwxbqV4csDohNPwQnfZjn/Miajl/E8Z1kJywbXky
         8C8DNDo6agpgSA2gHc0DeXD797Bw2Ej+3BBoeXDv0zrsOklxrGX2s6APeJEKZHjyEh4Q
         9qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783744476; x=1784349276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KFVd0PnUU6xpPdk60y2eMzRpByTjMeoSgiy77ryGbBg=;
        b=NRZVqouW/GfC2MfY4LF1Q3D2kb7EyK7SMZ+8FvfQf5QfPg4p57yzbj9SokrtrobdAl
         AnDoYIG6x+IF+IPngHZSEopLfjNOvyIx+lYhkPokWZimox7w57GVE7CMtOYt1rQXueCS
         E7LJQUkUcVN/i7eHV++uOnJfngqFEBJJznTsl9FwgqoDj/F6fBhTMfqN6IFvZB9bYayg
         r45Z4m0FGqtfEZ5QlEDS/2+lyEarCHguRnVFS3sGfN2jOcgEbYbz9qqxwxmj05/mm/Jr
         jSxomz3hkCscVSiISMOFqMvuxSPiatqh3jtcFH20adqf6kQAbLNLePAEOyt40mAxv/vQ
         gwRw==
X-Gm-Message-State: AOJu0Yz+qT7UgVXMAjx+PA7gr0KZFD5cOs8mbfk6eff88Ey5Y7GmQAZw
	hMhvK73pBmfF1KnPVuwjr8MH4Dpwje+0pDf6Yhe5fw1cldhGuhBF4NQG3pZPE0UPP+w=
X-Gm-Gg: AfdE7cl0byQpBJahy50jwntOksGVplNRt/2gae6ZvnphxdtqT5GeOzbVmlsSAdlFQDx
	vJLJup+x+7I1PQxbxqVWh6Mvdldr54pv3VNs+pqcv8HSJv21/NEohFOmXM8v9ghm1gWdS+q6dJ8
	FJoehTmOMStZ2L6Al4oO28tvSzqs0+GvJlmcx6uCEWx2vWDnXBuiDca6ttJV0WAi0L6yVZomJ6B
	YFdpovEgnasrr2jgG4isICskfBRKFg2E/WZhwO61iffZPt5ZLsgtEdRYstGOLdquWS0rXsKWIcQ
	7jQuFT0cnDZgWpBOY/ZRfUKUWKfqoEOhgHb0Dvf+tmaD51j73Kj5D1rA9f+6ekjfQgoTIjG2xDc
	fnUoERhq1B0bXBCIOktAW+Ut5VCnur8DjQdlp23Aoq+JGZ5kbPmW14s3nd2O5LAlLhFIPS9oJZ/
	2h2U1RUqFMZAdoBW2QSQDQgYwnD3Dv2dH0YFqO
X-Received: by 2002:a05:6000:3c6:b0:47d:f023:b4b3 with SMTP id ffacd0b85a97d-47f2dce9728mr1266859f8f.34.1783744476096;
        Fri, 10 Jul 2026 21:34:36 -0700 (PDT)
Received: from localhost ([102.128.173.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm69989039f8f.37.2026.07.10.21.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 21:34:35 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loukot@gmail.com
Subject: [PATCH] wifi: nl80211: say why the association BSS lookup failed
Date: Sat, 11 Jul 2026 06:34:32 +0200
Message-ID: <20260711043432.2767225-1-loukot@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38866-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loukot@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D24307404FC

The BSS lookup for an association request can fail for three distinct
reasons: cfg80211 has no scan entry at all for the BSSID/channel, an
entry exists but is older than IEEE80211_SCAN_RESULT_EXPIRE (and not
held), or a fresh entry exists but its use_for flags do not allow
this use. All three currently surface as the same generic extack
message "Error fetching BSS for link" on the MLO path, and as a bare
-ENOENT with no message on the non-MLO path.

Since wpa_supplicant logs the extack message verbatim ("nl80211:
kernel reports: ..."), that message is often the only diagnostic a
user sees when an MLO association degrades to fewer links, and it
does not say whether rescanning would help. In practice the expired
case is common for MLO partner links: 6 GHz is passive-scan in many
regulatory domains, so the partner-link entry is routinely stale by
the time userspace requests the association even though the link is
perfectly usable.

Add a cfg80211 helper that classifies, on the failure path only, why
matching entries were rejected, and set a distinct extack message
for each case in nl80211_assoc_bss(). Also give the -EINVAL paths
there proper messages while at it, and keep pointing the bad_attr at
the failing link.

Signed-off-by: Louis Kotze <loukot@gmail.com>
---
Compile-tested (W=1 clean) and exercised on a UML/hwsim rig: an MLO
reassociation whose partner-link entry had aged out now gets
"nl80211: kernel reports: BSS not found in scan results" in the
wpa_supplicant debug log instead of the generic message.

 net/wireless/core.h    | 12 +++++++++++
 net/wireless/nl80211.c | 37 +++++++++++++++++++++++--------
 net/wireless/scan.c    | 49 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 9 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index df47ed6208a5..a3778c6e07e4 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -332,6 +332,18 @@ void ieee80211_set_bitrate_flags(struct wiphy *wiphy);
 void cfg80211_bss_expire(struct cfg80211_registered_device *rdev);
 void cfg80211_bss_age(struct cfg80211_registered_device *rdev,
                       unsigned long age_secs);
+
+/* why __cfg80211_get_bss() found no usable BSS entry */
+#define CFG80211_BSS_MISS_EXPIRED	BIT(0)
+#define CFG80211_BSS_MISS_USE_FOR	BIT(1)
+
+u32 cfg80211_get_bss_miss_reasons(struct wiphy *wiphy,
+				  struct ieee80211_channel *channel,
+				  const u8 *bssid,
+				  const u8 *ssid, size_t ssid_len,
+				  enum ieee80211_bss_type bss_type,
+				  enum ieee80211_privacy privacy,
+				  u32 use_for);
 void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 				     unsigned int link,
 				     struct ieee80211_channel *channel);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 242071ad10d6..a68390ae6d2c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13036,6 +13036,7 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 }
 
 static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device *rdev,
+					      struct genl_info *info,
 					      const u8 *ssid, int ssid_len,
 					      struct nlattr **attrs,
 					      int assoc_link_id, int link_id)
@@ -13043,10 +13044,12 @@ static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device
 	struct ieee80211_channel *chan;
 	struct cfg80211_bss *bss;
 	const u8 *bssid;
-	u32 freq, use_for = 0;
+	u32 freq, miss, use_for = 0;
 
-	if (!attrs[NL80211_ATTR_MAC] || !attrs[NL80211_ATTR_WIPHY_FREQ])
+	if (!attrs[NL80211_ATTR_MAC] || !attrs[NL80211_ATTR_WIPHY_FREQ]) {
+		NL_SET_ERR_MSG(info->extack, "BSSID or frequency missing");
 		return ERR_PTR(-EINVAL);
+	}
 
 	bssid = nla_data(attrs[NL80211_ATTR_MAC]);
 
@@ -13055,8 +13058,10 @@ static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device
 		freq += nla_get_u32(attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
 
 	chan = nl80211_get_valid_chan(&rdev->wiphy, freq);
-	if (!chan)
+	if (!chan) {
+		NL_SET_ERR_MSG(info->extack, "invalid or disabled channel");
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (assoc_link_id >= 0)
 		use_for = NL80211_BSS_USE_FOR_MLD_LINK;
@@ -13068,8 +13073,23 @@ static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device
 				 IEEE80211_BSS_TYPE_ESS,
 				 IEEE80211_PRIVACY_ANY,
 				 use_for);
-	if (!bss)
+	if (!bss) {
+		miss = cfg80211_get_bss_miss_reasons(&rdev->wiphy, chan,
+						     bssid, ssid, ssid_len,
+						     IEEE80211_BSS_TYPE_ESS,
+						     IEEE80211_PRIVACY_ANY,
+						     use_for);
+		if (miss & CFG80211_BSS_MISS_USE_FOR)
+			NL_SET_ERR_MSG(info->extack,
+				       "BSS cannot be used for this association");
+		else if (miss & CFG80211_BSS_MISS_EXPIRED)
+			NL_SET_ERR_MSG(info->extack,
+				       "BSS entry is expired, scan again");
+		else
+			NL_SET_ERR_MSG(info->extack,
+				       "BSS not found in scan results");
 		return ERR_PTR(-ENOENT);
+	}
 
 	return bss;
 }
@@ -13106,13 +13126,12 @@ static int nl80211_process_links(struct cfg80211_registered_device *rdev,
 			return -EINVAL;
 		}
 		links[link_id].bss =
-			nl80211_assoc_bss(rdev, ssid, ssid_len, attrs,
+			nl80211_assoc_bss(rdev, info, ssid, ssid_len, attrs,
 					  assoc_link_id, link_id);
 		if (IS_ERR(links[link_id].bss)) {
 			err = PTR_ERR(links[link_id].bss);
 			links[link_id].bss = NULL;
-			NL_SET_ERR_MSG_ATTR(info->extack, link,
-					    "Error fetching BSS for link");
+			NL_SET_BAD_ATTR(info->extack, link);
 			return err;
 		}
 
@@ -13328,8 +13347,8 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		if (req.link_id >= 0)
 			return -EINVAL;
 
-		req.bss = nl80211_assoc_bss(rdev, ssid, ssid_len, info->attrs,
-					    -1, -1);
+		req.bss = nl80211_assoc_bss(rdev, info, ssid, ssid_len,
+					    info->attrs, -1, -1);
 		if (IS_ERR(req.bss))
 			return PTR_ERR(req.bss);
 		ap_addr = req.bss->bssid;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 05b7dc6b766c..f0e13b178b74 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1655,6 +1655,55 @@ struct cfg80211_bss *__cfg80211_get_bss(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(__cfg80211_get_bss);
 
+/*
+ * Report why __cfg80211_get_bss() with the same arguments found no
+ * usable entry: matching entries exist but are expired, or are not
+ * usable for the requested use. Returns 0 if no entry matches at all.
+ */
+u32 cfg80211_get_bss_miss_reasons(struct wiphy *wiphy,
+				  struct ieee80211_channel *channel,
+				  const u8 *bssid,
+				  const u8 *ssid, size_t ssid_len,
+				  enum ieee80211_bss_type bss_type,
+				  enum ieee80211_privacy privacy,
+				  u32 use_for)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct cfg80211_internal_bss *bss;
+	unsigned long now = jiffies;
+	u32 reasons = 0;
+	int bss_privacy;
+
+	spin_lock_bh(&rdev->bss_lock);
+
+	list_for_each_entry(bss, &rdev->bss_list, list) {
+		if (!cfg80211_bss_type_match(bss->pub.capability,
+					     bss->pub.channel->band, bss_type))
+			continue;
+
+		bss_privacy = (bss->pub.capability & WLAN_CAPABILITY_PRIVACY);
+		if ((privacy == IEEE80211_PRIVACY_ON && !bss_privacy) ||
+		    (privacy == IEEE80211_PRIVACY_OFF && bss_privacy))
+			continue;
+		if (channel && bss->pub.channel != channel)
+			continue;
+		if (!is_valid_ether_addr(bss->pub.bssid))
+			continue;
+		if (!is_bss(&bss->pub, bssid, ssid, ssid_len))
+			continue;
+
+		if (time_after(now, bss->ts + IEEE80211_SCAN_RESULT_EXPIRE) &&
+		    !atomic_read(&bss->hold))
+			reasons |= CFG80211_BSS_MISS_EXPIRED;
+		else if ((bss->pub.use_for & use_for) != use_for)
+			reasons |= CFG80211_BSS_MISS_USE_FOR;
+	}
+
+	spin_unlock_bh(&rdev->bss_lock);
+
+	return reasons;
+}
+
 static bool rb_insert_bss(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_internal_bss *bss)
 {

base-commit: ac798f757d6475dc6fee2ec899980d6740714596
-- 
2.55.0


