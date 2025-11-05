Return-Path: <linux-wireless+bounces-28610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF9C361BD
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 15:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C45CD4F9091
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D6C32F75F;
	Wed,  5 Nov 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Sgz6HQn/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0A32D7FF
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353540; cv=none; b=qy74Z8RdFXvnGa/miKUmmKkupHHBAiuwVY74/+yGsrmS+BQ2mgee6zF5zmiy6CtvnGYJBMZTPVfRExmM6HlyjSEDPPW8AI420YxMuiAEhY9nkUNZIckZK8GuDJmKOfCyWjPJ8du6K5Q3cPtrj0d96S2ATNx+pGZ7J5seweibAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353540; c=relaxed/simple;
	bh=9DXmsOEbxp+3WKExWyGspw5MRpXuGnu77nj3ZDYZnLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD0hxf6u8IHbUbIHh9+pw+pGjp6aInmvUwa98rE7kuQSYOjEosNMSBW+SI92e8r8UtqS1iOTevrJBrjmChb42azgMgXLWRgX+Gf4Mh6JhxwD8CaM3vyPggc7dvAxWJ9fxKXLtETH+xzUs3NYElovJzA0+2W1boOjJ+TqxkWITkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Sgz6HQn/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oZqu8SuJGAt77c3hnxqJbbtuRsC7ZoNsPfCz64TndYQ=;
	t=1762353539; x=1763563139; b=Sgz6HQn/Pf8BRs444hgRehCX6Wm4GuMGNqe1LMT1qe8P8wF
	xOd8egkPfmTmD6OwA2v9/47evkxAHr4xDZ0TBeGdNP42Yaxi1URH3bhEqqsa4cgc1s7+lavvroZrE
	BtjAmaT3RzUMCAo0+BbnALqIaW7qMl9pV+D3DaMpuPpTRKzvk4H5Q2cc3AFKgME9pVMVgEVGWbWlv
	aAgFDJ9tQUzgz8z4l8X7a5s8Lm5bwuaLhaKPWFq/pcUaxn+tmwM73edTPyKX6brd6D9n7u18BTF5+
	CoS8JtXp1pD29mc287xkWM/S2UV0eQVd7I4rESJjRzk2vOy+1jTfuT312I48ojmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGef2-0000000FDcs-0FUy;
	Wed, 05 Nov 2025 15:38:56 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 7/8] wifi: ieee80211: split P2P definitions out
Date: Wed,  5 Nov 2025 15:36:55 +0100
Message-ID: <20251105153843.e47b2614e9d2.Id242f61da720e365f6b5d7a4a545fbbc2f1e92b4@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105143843.46279-10-johannes@sipsolutions.net>
References: <20251105143843.46279-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The ieee80211.h file has gotten very long, continue splitting
it by putting P2P definitions into a separate file. Note that
P2P isn't really even IEEE 802.11 but WFA.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-p2p.h | 71 +++++++++++++++++++++++++++++++++++
 include/linux/ieee80211.h     | 53 +-------------------------
 2 files changed, 72 insertions(+), 52 deletions(-)
 create mode 100644 include/linux/ieee80211-p2p.h

diff --git a/include/linux/ieee80211-p2p.h b/include/linux/ieee80211-p2p.h
new file mode 100644
index 000000000000..180891c11f08
--- /dev/null
+++ b/include/linux/ieee80211-p2p.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * WFA P2P definitions
+ *
+ * Copyright (c) 2001-2002, SSH Communications Security Corp and Jouni Malinen
+ * <jkmaline@cc.hut.fi>
+ * Copyright (c) 2002-2003, Jouni Malinen <jkmaline@cc.hut.fi>
+ * Copyright (c) 2005, Devicescape Software, Inc.
+ * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
+ * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
+ * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright (c) 2018 - 2025 Intel Corporation
+ */
+
+#ifndef LINUX_IEEE80211_P2P_H
+#define LINUX_IEEE80211_P2P_H
+
+#include <linux/types.h>
+/*
+ * Peer-to-Peer IE attribute related definitions.
+ */
+/*
+ * enum ieee80211_p2p_attr_id - identifies type of peer-to-peer attribute.
+ */
+enum ieee80211_p2p_attr_id {
+	IEEE80211_P2P_ATTR_STATUS = 0,
+	IEEE80211_P2P_ATTR_MINOR_REASON,
+	IEEE80211_P2P_ATTR_CAPABILITY,
+	IEEE80211_P2P_ATTR_DEVICE_ID,
+	IEEE80211_P2P_ATTR_GO_INTENT,
+	IEEE80211_P2P_ATTR_GO_CONFIG_TIMEOUT,
+	IEEE80211_P2P_ATTR_LISTEN_CHANNEL,
+	IEEE80211_P2P_ATTR_GROUP_BSSID,
+	IEEE80211_P2P_ATTR_EXT_LISTEN_TIMING,
+	IEEE80211_P2P_ATTR_INTENDED_IFACE_ADDR,
+	IEEE80211_P2P_ATTR_MANAGABILITY,
+	IEEE80211_P2P_ATTR_CHANNEL_LIST,
+	IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
+	IEEE80211_P2P_ATTR_DEVICE_INFO,
+	IEEE80211_P2P_ATTR_GROUP_INFO,
+	IEEE80211_P2P_ATTR_GROUP_ID,
+	IEEE80211_P2P_ATTR_INTERFACE,
+	IEEE80211_P2P_ATTR_OPER_CHANNEL,
+	IEEE80211_P2P_ATTR_INVITE_FLAGS,
+	/* 19 - 220: Reserved */
+	IEEE80211_P2P_ATTR_VENDOR_SPECIFIC = 221,
+
+	IEEE80211_P2P_ATTR_MAX
+};
+
+/* Notice of Absence attribute - described in P2P spec 4.1.14 */
+/* Typical max value used here */
+#define IEEE80211_P2P_NOA_DESC_MAX	4
+
+struct ieee80211_p2p_noa_desc {
+	u8 count;
+	__le32 duration;
+	__le32 interval;
+	__le32 start_time;
+} __packed;
+
+struct ieee80211_p2p_noa_attr {
+	u8 index;
+	u8 oppps_ctwindow;
+	struct ieee80211_p2p_noa_desc desc[IEEE80211_P2P_NOA_DESC_MAX];
+} __packed;
+
+#define IEEE80211_P2P_OPPPS_ENABLE_BIT		BIT(7)
+#define IEEE80211_P2P_OPPPS_CTWINDOW_MASK	0x7F
+
+#endif /* LINUX_IEEE80211_P2P_H */
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 1b27bbac145b..fa0f7f917ce7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1333,58 +1333,6 @@ struct ieee80211_tdls_data {
 	} u;
 } __packed;
 
-/*
- * Peer-to-Peer IE attribute related definitions.
- */
-/*
- * enum ieee80211_p2p_attr_id - identifies type of peer-to-peer attribute.
- */
-enum ieee80211_p2p_attr_id {
-	IEEE80211_P2P_ATTR_STATUS = 0,
-	IEEE80211_P2P_ATTR_MINOR_REASON,
-	IEEE80211_P2P_ATTR_CAPABILITY,
-	IEEE80211_P2P_ATTR_DEVICE_ID,
-	IEEE80211_P2P_ATTR_GO_INTENT,
-	IEEE80211_P2P_ATTR_GO_CONFIG_TIMEOUT,
-	IEEE80211_P2P_ATTR_LISTEN_CHANNEL,
-	IEEE80211_P2P_ATTR_GROUP_BSSID,
-	IEEE80211_P2P_ATTR_EXT_LISTEN_TIMING,
-	IEEE80211_P2P_ATTR_INTENDED_IFACE_ADDR,
-	IEEE80211_P2P_ATTR_MANAGABILITY,
-	IEEE80211_P2P_ATTR_CHANNEL_LIST,
-	IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
-	IEEE80211_P2P_ATTR_DEVICE_INFO,
-	IEEE80211_P2P_ATTR_GROUP_INFO,
-	IEEE80211_P2P_ATTR_GROUP_ID,
-	IEEE80211_P2P_ATTR_INTERFACE,
-	IEEE80211_P2P_ATTR_OPER_CHANNEL,
-	IEEE80211_P2P_ATTR_INVITE_FLAGS,
-	/* 19 - 220: Reserved */
-	IEEE80211_P2P_ATTR_VENDOR_SPECIFIC = 221,
-
-	IEEE80211_P2P_ATTR_MAX
-};
-
-/* Notice of Absence attribute - described in P2P spec 4.1.14 */
-/* Typical max value used here */
-#define IEEE80211_P2P_NOA_DESC_MAX	4
-
-struct ieee80211_p2p_noa_desc {
-	u8 count;
-	__le32 duration;
-	__le32 interval;
-	__le32 start_time;
-} __packed;
-
-struct ieee80211_p2p_noa_attr {
-	u8 index;
-	u8 oppps_ctwindow;
-	struct ieee80211_p2p_noa_desc desc[IEEE80211_P2P_NOA_DESC_MAX];
-} __packed;
-
-#define IEEE80211_P2P_OPPPS_ENABLE_BIT		BIT(7)
-#define IEEE80211_P2P_OPPPS_CTWINDOW_MASK	0x7F
-
 /* Authentication algorithms */
 #define WLAN_AUTH_OPEN 0
 #define WLAN_AUTH_SHARED_KEY 1
@@ -2878,6 +2826,7 @@ struct ieee80211_tbtt_info_ge_11 {
 #include "ieee80211-eht.h"
 #include "ieee80211-mesh.h"
 #include "ieee80211-s1g.h"
+#include "ieee80211-p2p.h"
 
 /**
  * ieee80211_check_tim - check if AID bit is set in TIM
-- 
2.51.1


