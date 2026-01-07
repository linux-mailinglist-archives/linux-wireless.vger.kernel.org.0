Return-Path: <linux-wireless+bounces-30479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D32ECFF912
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 19:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7096F3360783
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E165833DED5;
	Wed,  7 Jan 2026 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nU16mw0E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189333D4F7
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795832; cv=none; b=sMsiAdA4swdcDUb8ajbRC62VI+a5HoagASrujbYcKzEnxTGieFPid/pZxo+Ir5WEvuQaj/dshmX72GKZp2s/1U//q9vjtHWQTsvJ5LY0UjmfaMLWGlvI1FkGVQVSrw8UcqP5GK3JHnMjvrkWIhBpQHZx6HbnuR1JJDHvyzlw1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795832; c=relaxed/simple;
	bh=1SUTgUPa+Gu2eYBE6141SaHw8Im4sG6PMo3KQP8Eyps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECuhkbMC66hANJ0Ez+cQJboBggBLlZk5Mm8XOcctwifq0xfhzFNaQ4PNhE8eKlmkY2/N/yTaelApewpM3IoOGiUD+7wRges7F4smxe7Liuithr1miCSGDrSPp96IyZUrJcR607wCNFyZHE/eq5+owAkIfHBbAO39mLLzSPDc+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nU16mw0E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sA29sD9Jnbk9BAgPcMAASEHYDl17Esz6mWl7I+9IxoY=;
	t=1767795831; x=1769005431; b=nU16mw0EwTwFVoC7/058wYBido+DyeTtjh32d+QDJM2UZiq
	g30igCO+a995d/abOg1xNOQrRyGYdtmbWYXQOmLEp5yePNVdKdoSleF6pPSWEjeZOEfFi8F6biM0N
	hFIo4Nv0Ge6JO4a1K5G4mCcEdJoMg9t6ddzFZ9PkaHBikI1LrE9VGJBDkza7vQqcClLzR5jbXilfO
	NmPQ9lLTH9s+TrvrzoyweIw4u/LR+PIvqBJCZnGwnNYRvjfGS1pM6bl44dYWFJAZ7DQWUprGtuHck
	yJUPUOBzrf5pWHL0YgrNVYjBZcvoRu/zqbDzWayzoANgnBPubH5O4Mu+wyKtrDBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURw-00000005agF-02QE;
	Wed, 07 Jan 2026 15:23:48 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 17/46] wifi: ieee80211: add more NAN definitions
Date: Wed,  7 Jan 2026 15:22:16 +0100
Message-ID: <20260107152325.d7899b6b7068.Ie8142cf92fc8c97c744a7c8b0a94ce3da6ff75ec@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

These will be needed to implement NAN synchronization in mac80211_hwsim.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-nan.h | 37 +++++++++++++++++++++++++++++++++++
 include/linux/ieee80211.h     |  1 +
 2 files changed, 38 insertions(+)

diff --git a/include/linux/ieee80211-nan.h b/include/linux/ieee80211-nan.h
index d07959bf8a90..a6b0c7473233 100644
--- a/include/linux/ieee80211-nan.h
+++ b/include/linux/ieee80211-nan.h
@@ -32,4 +32,41 @@
 #define NAN_DEV_CAPA_NDPE_SUPPORTED		0x08
 #define NAN_DEV_CAPA_S3_SUPPORTED		0x10
 
+/* NAN attributes, as defined in Wi-Fi Aware (TM) specification 4.0 Table 42 */
+#define NAN_ATTR_MASTER_INDICATION		0x00
+#define NAN_ATTR_CLUSTER_INFO			0x01
+
+struct ieee80211_nan_attr {
+	u8 attr;
+	__le16 length;
+	u8 data[];
+} __packed;
+
+struct ieee80211_nan_master_indication {
+	u8 master_pref;
+	u8 random_factor;
+} __packed;
+
+struct ieee80211_nan_anchor_master_info {
+	union {
+		__le64 master_rank;
+		struct {
+			u8 master_addr[ETH_ALEN];
+			u8 random_factor;
+			u8 master_pref;
+		} __packed;
+	} __packed;
+	u8 hop_count;
+	__le32 ambtt;
+} __packed;
+
+#define for_each_nan_attr(_attr, _data, _datalen)			\
+	for (_attr = (const struct ieee80211_nan_attr *)(_data);	\
+	     (const u8 *)(_data) + (_datalen) - (const u8 *)_attr >=	\
+		(int)sizeof(*_attr) &&					\
+	     (const u8 *)(_data) + (_datalen) - (const u8 *)_attr >=	\
+		(int)sizeof(*_attr) + le16_to_cpu(_attr->length);	\
+	     _attr = (const struct ieee80211_nan_attr *)		\
+		(_attr->data + le16_to_cpu(_attr->length)))
+
 #endif /* LINUX_IEEE80211_NAN_H */
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 96439de55f07..773b1e3888a0 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2231,6 +2231,7 @@ struct ieee80211_multiple_bssid_configuration {
 
 #define WLAN_OUI_WFA			0x506f9a
 #define WLAN_OUI_TYPE_WFA_P2P		9
+#define WLAN_OUI_TYPE_WFA_NAN		0x13
 #define WLAN_OUI_TYPE_WFA_DPP		0x1A
 #define WLAN_OUI_MICROSOFT		0x0050f2
 #define WLAN_OUI_TYPE_MICROSOFT_WPA	1
-- 
2.52.0


