Return-Path: <linux-wireless+bounces-37107-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKtqNGlOGWrzuQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37107-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362D5FF2B9
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C5C5300D729
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247203AD50B;
	Fri, 29 May 2026 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qeaVTrWx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B290348C56
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043213; cv=none; b=IwenvtqYYpKkj5/sqzo8WmNBo/RpM0My8pMZDTSvf6VpIgnhc5kfLWXpENIgzcheL9UI8ymCVArmZOd2pdObzeIajzoJ98kRgJwm6Td/r7cvDs3CzyTUXi286cSIlZlmC0RJYhppDAKotLu1ppsqA1qZf8tEEw6DPbAo4E28XDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043213; c=relaxed/simple;
	bh=+bhDpvrCLJU3gjehWxHH1ATJMsQdpKC3EJPG2S7rhS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqVreo5lE1DcmobcshH5i5cyjx+Pq/CtgtHRSflTCOkDcfMdZXDp0oeYJEQbxPfxFRyxO0O0p6pw3JfsO6k2f4NphzQwX1X/GJw1iqQzX0rzH4e5F1GyvtHDgu+gh2qurfjI5SLI547lvbQhjouG52izHrpW7RIKHmazc6N87IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qeaVTrWx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7QwBAc1n9YsrdNBIFCruiX3yWC01qQsnwx/3iIrX5Ug=;
	t=1780043211; x=1781252811; b=qeaVTrWxr5tUmlofg2KVgpVvyw8Mr3KzvduoTNrptNz/O9/
	EsCnVtSl2uqP35vhO8seU+YASGVv7EtqcH4zZfFxMY8xAduTvCSPtSAYLG0QCGZz4Ka/GXwdjN95T
	C6XbYEQTWvHQAIFN/mMaLUNEUZKalpN0L/7c4Y6UmhA4l3muf966g5898P8WJvOo2hzkzm9PIJINP
	1ixTvwGY9gsQ084H/e8jwEbxq0bckBDgQZmREWEWPmNu7U6F2NWDABHR9WG6sux47qUNxKn2E8cVA
	8+zYD6i+rVJl6P0mTib5ktNOSVT3Hc86jxtZ9VrXarMHlGKJMOvrOjOYuW37OeGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYK-00000009bVp-3SPV;
	Fri, 29 May 2026 10:26:49 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 01/16] wifi: ieee80211: define some UHR link reconfiguration frame types
Date: Fri, 29 May 2026 10:24:54 +0200
Message-ID: <20260529102644.03029bae6447.If22b0c1e10d9db712dca408a420469b3d385b4ea@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529082644.106145-18-johannes@sipsolutions.net>
References: <20260529082644.106145-18-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37107-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 5362D5FF2B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Define some values needed for UHR link reconfiguration frames,
in particular to prepare for UHR mode change request/handling.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-uhr.h | 51 +++++++++++++++++++++++++++++++++++
 include/linux/ieee80211.h     | 17 ++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index f4f4bd8256df..71faf4a6825e 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -8,6 +8,7 @@
 #define LINUX_IEEE80211_UHR_H
 
 #include <linux/types.h>
+#include <linux/bitfield.h>
 #include <linux/if_ether.h>
 
 #define IEEE80211_UHR_OPER_PARAMS_DPS_ENA		0x0001
@@ -463,4 +464,54 @@ struct ieee80211_smd_info {
 	__le16 timeout;
 } __packed;
 
+enum ieee80211_protected_uhr_action {
+	IEEE80211_PROTECTED_UHR_ACTION_LINK_RECONFIG_REQUEST	= 0,
+	IEEE80211_PROTECTED_UHR_ACTION_LINK_RECONFIG_RESPONSE	= 1,
+	IEEE80211_PROTECTED_UHR_ACTION_LINK_RECONFIG_NOTIFY	= 2,
+};
+
+enum ieee80211_uhr_link_reconfig_request_type {
+	IEEE80211_UHR_LINK_RECONFIG_REQUEST_ST_PREP		= 0,
+	IEEE80211_UHR_LINK_RECONFIG_REQUEST_ST_EXEC		= 1,
+	IEEE80211_UHR_LINK_RECONFIG_REQUEST_OMP_REQUEST		= 3,
+};
+
+enum ieee80211_uhr_link_reconfig_response_type {
+	IEEE80211_UHR_LINK_RECONFIG_RESPONSE_ST_PREP		= 0,
+	IEEE80211_UHR_LINK_RECONFIG_RESPONSE_ST_EXEC		= 1,
+};
+
+enum ieee80211_uhr_link_reconfig_notify_type {
+	IEEE80211_UHR_LINK_RECONFIG_NOTIFY_DL_DRAINED		= 2,
+	IEEE80211_UHR_LINK_RECONFIG_NOTIFY_OMP_RESPONSE		= 3,
+};
+
+enum ieee80211_uhr_mode_change_control {
+	IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_ID		= 0x003f,
+	IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_ENABLE		= 0x0040,
+	IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_UPDATE		= 0x0080,
+	IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_LENGTH		= 0x0f00,
+	IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_SPECIFIC		= 0xf000,
+};
+
+enum ieee80211_uhr_mode_change_mode_id {
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_DPS			= 0,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_NPCA			= 1,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_DUO			= 2,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_DSO			= 3,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_P_EDCA		= 4,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_ELR_RX		= 5,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_AOM			= 6,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_LLI			= 7,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_CO_BF			= 8,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_CO_SR			= 9,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_EMLSR			= 10,
+	IEEE80211_UHR_MODE_CHANGE_MODE_ID_DBE			= 11,
+};
+
+struct ieee80211_uhr_mode_change_tuple {
+	__le16 control;
+	u8 variable[];
+} __packed;
+
 #endif /* LINUX_IEEE80211_UHR_H */
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 11106589acc6..d40484451e9a 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1174,6 +1174,22 @@ struct ieee80211_mgmt {
 					u8 control;
 					u8 variable[];
 				} __packed eml_omn;
+				struct {
+					u8 dialog_token;
+					u8 type;
+					u8 variable[];
+				} __packed uhr_link_reconf_req;
+				struct {
+					u8 dialog_token;
+					u8 type;
+					u8 count;
+					u8 variable[];
+				} __packed uhr_link_reconf_resp;
+				struct {
+					u8 dialog_token;
+					u8 type;
+					u8 variable[];
+				} __packed uhr_link_reconf_notif;
 			};
 		} __packed action;
 		DECLARE_FLEX_ARRAY(u8, body); /* Generic frame body */
@@ -1837,6 +1853,7 @@ enum ieee80211_category {
 	WLAN_CATEGORY_VHT = 21,
 	WLAN_CATEGORY_S1G = 22,
 	WLAN_CATEGORY_PROTECTED_EHT = 37,
+	WLAN_CATEGORY_PROTECTED_UHR = 43,
 	WLAN_CATEGORY_VENDOR_SPECIFIC_PROTECTED = 126,
 	WLAN_CATEGORY_VENDOR_SPECIFIC = 127,
 };
-- 
2.53.0


