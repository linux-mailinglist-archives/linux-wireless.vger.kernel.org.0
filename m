Return-Path: <linux-wireless+bounces-27423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C65DB7F625
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 15:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7214483665
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 05:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8952737EA;
	Wed, 17 Sep 2025 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rQ2MfGLR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64472614
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088576; cv=none; b=af2AixefK4XcK4WlaiJ7STGchUtoBwuqdl3et8Vk7aADtbMOfPArsWx7AoZWo023Q5XrLP9miqiIO1GMRkWxabLOFR6idl5AtmRYbLmC8CNztkUh05ygSsyOjIiZmXm/5WwZAZXXwJsPuW/BlE6rBjTjjk+uZUUyJbWDHFcZ3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088576; c=relaxed/simple;
	bh=PJvbPc4TJGZNNOJ4llsZPFN3tCtw4Cphg67or+nmwIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbLXLQTDJo9Tu5G68gVo+DiqlLavaIMVDi0JTp9yI6rfPM3bbbI9rMFMYM/tsl/VQiXiQ8JfQ9Lwl8eB3SCDlxm4AW2pw9Cnt+npCAuj8lqUSRjY8koGOQVYlALeoBdJ4ZzCp7F2ajkxB6PSkfis6RnEQx5OBKSGF0HUY4G8pyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rQ2MfGLR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58H5u0kO53954259, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758088560; bh=mVdrt5iIIWYFNw/A6UchDI643aOzwb7x6sI9folz4ek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rQ2MfGLRwSKuIvHVrljaOv966tMLQmpwH50M6UiPOx9OkwfwvSvsNxfgz2HF8hYmh
	 KtFpQtY9JT/uHppnEIu6MWd8D1BKB+LhKxl6Wp3Occuhm1oZ4SWTqeTq7s0oEwUi4S
	 Gacoo+W9QrVaiAhPY+xLMRqJ5zfB6BUxWjpXOec6iyJyeBjoteO1bcY4ebgmJhOLIZ
	 OLU6eL0zjyySjnkXT3keUoSnL4FKq/BI/DRTlD8cG9HF/n7bs/3VfmnJpMlIE90eAz
	 qVG7w4bdsi3ZpmDpAmPnuu3WSMkMiT/gkPLgrKj8Dav305MISiyMWgCNRzmNe7rpVT
	 +GWzZQe6K/FDg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58H5u0kO53954259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:56:00 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 17 Sep 2025 13:56:00 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Sep 2025 13:56:00 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v2 1/6] iw: update nl80211.h
Date: Wed, 17 Sep 2025 13:55:38 +0800
Message-ID: <20250917055543.27499-2-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250917055543.27499-1-kevin_yang@realtek.com>
References: <20250917055543.27499-1-kevin_yang@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
 nl80211.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/nl80211.h b/nl80211.h
index d1a14f2892d9..aed0b4c5d5e8 100644
--- a/nl80211.h
+++ b/nl80211.h
@@ -1943,8 +1943,9 @@ enum nl80211_commands {
  *	The driver must also specify support for this with the extended
  *	features NL80211_EXT_FEATURE_BEACON_RATE_LEGACY,
  *	NL80211_EXT_FEATURE_BEACON_RATE_HT,
- *	NL80211_EXT_FEATURE_BEACON_RATE_VHT and
- *	NL80211_EXT_FEATURE_BEACON_RATE_HE.
+ *	NL80211_EXT_FEATURE_BEACON_RATE_VHT,
+ *	NL80211_EXT_FEATURE_BEACON_RATE_HE and
+ *	NL80211_EXT_FEATURE_BEACON_RATE_EHT.
  *
  * @NL80211_ATTR_FRAME_MATCH: A binary attribute which typically must contain
  *	at least one byte, currently used with @NL80211_CMD_REGISTER_FRAME.
@@ -2283,7 +2284,8 @@ enum nl80211_commands {
  * @NL80211_ATTR_PEER_AID: Association ID for the peer TDLS station (u16).
  *	This is similar to @NL80211_ATTR_STA_AID but with a difference of being
  *	allowed to be used with the first @NL80211_CMD_SET_STATION command to
- *	update a TDLS peer STA entry.
+ *	update a TDLS peer STA entry. For S1G interfaces, this is limited to
+ *	1600 for the current mac80211 implementation.
  *
  * @NL80211_ATTR_COALESCE_RULE: Coalesce rule information.
  *
@@ -2928,6 +2930,12 @@ enum nl80211_commands {
  *	required alongside this attribute. Refer to
  *	@enum nl80211_s1g_short_beacon_attrs for the attribute definitions.
  *
+ * @NL80211_ATTR_BSS_PARAM: nested attribute used with %NL80211_CMD_GET_WIPHY
+ *	which indicates which BSS parameters can be modified. The attribute can
+ *	also be used as flag attribute by user-space in %NL80211_CMD_SET_BSS to
+ *	indicate that it wants strict checking on the BSS parameters to be
+ *	modified.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3489,6 +3497,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_S1G_LONG_BEACON_PERIOD,
 	NL80211_ATTR_S1G_SHORT_BEACON,
+	NL80211_ATTR_BSS_PARAM,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -3735,6 +3744,22 @@ enum nl80211_eht_gi {
 	NL80211_RATE_INFO_EHT_GI_3_2,
 };
 
+/**
+ * enum nl80211_eht_ltf - EHT long training field
+ * @NL80211_RATE_INFO_EHT_1XLTF: 3.2 usec
+ * @NL80211_RATE_INFO_EHT_2XLTF: 6.4 usec
+ * @NL80211_RATE_INFO_EHT_4XLTF: 12.8 usec
+ * @NL80211_RATE_INFO_EHT_6XLTF: 19.2 usec
+ * @NL80211_RATE_INFO_EHT_8XLTF: 25.6 usec
+ */
+enum nl80211_eht_ltf {
+	NL80211_RATE_INFO_EHT_1XLTF,
+	NL80211_RATE_INFO_EHT_2XLTF,
+	NL80211_RATE_INFO_EHT_4XLTF,
+	NL80211_RATE_INFO_EHT_6XLTF,
+	NL80211_RATE_INFO_EHT_8XLTF,
+};
+
 /**
  * enum nl80211_eht_ru_alloc - EHT RU allocation values
  * @NL80211_RATE_INFO_EHT_RU_ALLOC_26: 26-tone RU allocation
@@ -5481,6 +5506,10 @@ enum nl80211_key_attributes {
  *	see &struct nl80211_txrate_he
  * @NL80211_TXRATE_HE_GI: configure HE GI, 0.8us, 1.6us and 3.2us.
  * @NL80211_TXRATE_HE_LTF: configure HE LTF, 1XLTF, 2XLTF and 4XLTF.
+ * @NL80211_TXRATE_EHT: EHT rates allowed for TX rate selection,
+ *	see &struct nl80211_txrate_eht
+ * @NL80211_TXRATE_EHT_GI: configure EHT GI, (u8, see &enum nl80211_eht_gi)
+ * @NL80211_TXRATE_EHT_LTF: configure EHT LTF, (u8, see &enum nl80211_eht_ltf)
  * @__NL80211_TXRATE_AFTER_LAST: internal
  * @NL80211_TXRATE_MAX: highest TX rate attribute
  */
@@ -5493,6 +5522,9 @@ enum nl80211_tx_rate_attributes {
 	NL80211_TXRATE_HE,
 	NL80211_TXRATE_HE_GI,
 	NL80211_TXRATE_HE_LTF,
+	NL80211_TXRATE_EHT,
+	NL80211_TXRATE_EHT_GI,
+	NL80211_TXRATE_EHT_LTF,
 
 	/* keep last */
 	__NL80211_TXRATE_AFTER_LAST,
@@ -5525,6 +5557,15 @@ enum nl80211_txrate_gi {
 	NL80211_TXRATE_FORCE_LGI,
 };
 
+#define NL80211_EHT_NSS_MAX             16
+/**
+ * struct nl80211_txrate_eht - EHT MCS/NSS txrate bitmap
+ * @mcs: MCS bitmap table for each NSS (array index 0 for 1 stream, etc.)
+ */
+struct nl80211_txrate_eht {
+	__u16 mcs[NL80211_EHT_NSS_MAX];
+};
+
 /**
  * enum nl80211_band - Frequency band
  * @NL80211_BAND_2GHZ: 2.4 GHz ISM band
@@ -6649,6 +6690,9 @@ enum nl80211_feature_flags {
  *	(signaling and payload protected) A-MSDUs and this shall be advertised
  *	in the RSNXE.
  *
+ * @NL80211_EXT_FEATURE_BEACON_RATE_EHT: Driver supports beacon rate
+ *	configuration (AP/mesh) with EHT rates.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6724,6 +6768,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_OWE_OFFLOAD_AP,
 	NL80211_EXT_FEATURE_DFS_CONCURRENT,
 	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
+	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.39.0


