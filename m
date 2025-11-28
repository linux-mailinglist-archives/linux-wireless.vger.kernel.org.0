Return-Path: <linux-wireless+bounces-29415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C7BC9251C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 952184E8B89
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA35D32D43C;
	Fri, 28 Nov 2025 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="h6EaXg3F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CAC329E79
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339685; cv=none; b=MXmFjekYD48VMhcAq3lD+nkeAqldu1e0kc1O7WHAixh5Kk924bwRs2EYD8hM/a9SFShtpMRvIho6cFYBGKo9Yo2/RPt4IIqq+qomOneaQkXUNfbs+ZA39Vk4CgzuCknvA0r3yFlY4VdlUlALdtZUm62TfBU44Kj5shEuKc9OqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339685; c=relaxed/simple;
	bh=vsruVZLMrRWXC5gdMbaq7iUVBRFvWkYwcw11W5ijmEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOHRvrubFhxoz0qT5l6wOQ/FX+18qplmgSjAfGtRPq57hHTdB1NIvkdBU2jkW69XIeU/rMTd2lwmDEnzUqctmGtwYS7sC6aQIwfL6ULdSNBRbWy9qSTizBlsQBJYJJK2HxXkJKzd5Y74I2zb5bUTL3Z0XqJoDb4WRdGTXPO5OIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=h6EaXg3F; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QHXn6GAaW7Zh6Xq0aGumpK5sEs1gvs89G9zFEUgbWNI=;
	t=1764339683; x=1765549283; b=h6EaXg3FUlL6vBk3r8luHhdeXCCH27PPqPsbMGfymEnFl34
	4jGAku1DPY1G/rS4ufTEn3qjEwhnf7r++UnI/hPsqHA5eqZJ0/Rq1MHEcpMEpN406vUjgbgjS8Dvn
	c6n/94B56ZShevrraPL0xb+N62IijAlB2w0aF3OPJF8OeTLMZc+8NSBln8XTio3uLc1zEef57xKcs
	6ZV0+3qzTqlI2bcP7AePrhhMvOaeZuiIYmdQrxB/SynFfDg8yq9uEGnfs+ykJilvxzxGBNk05ExUj
	C3sI5MTRad0bTLt0fW6J/oVE5T1AMrPku2+TH1gdTGcmLlUbtlc/aMlen+PfXZZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLc-00000003926-3xbd;
	Fri, 28 Nov 2025 15:21:21 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 16/18] wifi: ieee80211: add more NAN definitions
Date: Fri, 28 Nov 2025 15:15:54 +0100
Message-ID: <20251128151537.9bd8d5a549c0.Ie8142cf92fc8c97c744a7c8b0a94ce3da6ff75ec@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128141537.287627-20-benjamin@sipsolutions.net>
References: <20251128141537.287627-20-benjamin@sipsolutions.net>
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
2.51.1


