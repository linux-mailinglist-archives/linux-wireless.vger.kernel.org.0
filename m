Return-Path: <linux-wireless+bounces-38068-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7rdYAqR0PGrdoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38068-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:21:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 810186C1F84
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:21:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38068-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38068-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95585304E31B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925242046BA;
	Thu, 25 Jun 2026 00:20:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF151F37D3
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 00:20:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346809; cv=none; b=ML/O9qyFwalAiDjJVmaS2qtXXcmiDrLnKH7uBfaG4RKYZll2GT3Yx5at49tmSvEDEEquAtFDvhFgXU+8BKmCpu14uYszJahygCY7A3Z7i8Y/tGZO2kAER7uhMcui8qlW705pXUEW6X/DcIA5yn8I3wBrOaYfTzW/ap699vdhCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346809; c=relaxed/simple;
	bh=OD6kIrNITgn75LzI9+1xyXQoWXJt0Vky/PboFsZycsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wcj3qBwUHq/7oEN6wGwYk59R0U/0VBE1Lc/Wa5Dr+hqayMc/fXXndcQhYN1WN/2LJ9FIlNJ+mPx6xuSBJVGUXM9qMxB+4NfiGwQpZeYt9NmnQW6K8cSStyJSba0vNgf3e1Xceb3pLVDRiEidguPne/yDAcaBZ8KU/l4Nwv+/8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c88b8fe9059so580080a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 17:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346807; x=1782951607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxGQdM0c2TatqyA1QygknbGg8MMT1//ZBGDzhZkibBo=;
        b=GE0HsxQPsvJiXvE85erAvjaeNAEN6fO4IARjlpBq/SLEmjhwQMMPLRFNOe6thfDaSJ
         t0h97CsIIO+XN8p4dVISIJyXgTds4jLl+LUindpfx1FhnMTf7A2FiIEPH5bZa3CWz4zr
         KxSfdmMXnmSBNWul9so8LfT1uBDB4eYjD0S9CzJJNR/JSkgLizHgxQ6kea+RRF8DwdWA
         8vG3KIVQAF32ym97lddlnfUDMo4UFfbr3/ZE5svzzpL6pxfpv2bUEFqWClwO3ohuAToJ
         aEvFdOJLmUmzAJb0nCW2tOjOsSIPsQdPxMeFKvH1WKPGU4ebtqI9/+0YCPNxF3wgsioA
         Vdeg==
X-Forwarded-Encrypted: i=1; AFNElJ+XaiV1cuKWYUCZ7+MW+7knTyfPRmgSNam7JLm2ydojHwkxolznA26K9k5/SxVtPDp9oZ8OnCIZ/PnFSTv6mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymMko3nuJ5VNB0Jsdw95AsGn6NoMackWlEvxdaBgCz3xAjvomJ
	jbVVvpM9sxr9arw/NOlSvC3WgVbdF2/14SE0Sa8bCczs8cjmu9xs5VrC
X-Gm-Gg: AfdE7cmgCf9rRLKlk04y4gThMpWP/Szj8Nvqxtg7mTlUmalP9MMB6QWeHotoiW3Fvax
	ANg/W5uMmOzUlZNm+TA91gGdwY9F47hGWAZnAs8k/Hy6xV3Ozs8pBixdxT0WcVZuh99KH3RgL8l
	uSPbuVbP9Q9s1l+o4VOTN4yjj2Y9JpNSe/W0xMVlDbWKTBDLuVmXw8tH9RsPFY18VLiC3APUlfS
	y10E+y3/7/embm0O9wolY2fhrrdNj2jby+Y+fF2Gkk3rqK7Lu+g+d1RiILp2LdNgDevo/vrfb4W
	LBtv9KH1N0AN+QMnCZZRhgN8S77gUo4T3qfTdOvLNWklioPMDgia+F/tACvG9oZ6D8yBiuWRmqQ
	otQDhr++PPSyRVQRW5uGZrtmCJjD/iRzhDE/TXzYjuy1eNduHwLyuLsFwLXVwbe+IFLGLQlwfk/
	2/Xv9lq5dydyJPSJvQyWHGIx+d5Z6f1NqViTZ+SbbtJObsDZ6EoCZ/j5NduxB0PhkiS93WBloWT
	x4HxBxVrpX7CpqfPXMaDellAYJ81A==
X-Received: by 2002:a05:6a21:9982:b0:3ba:e5e2:73bf with SMTP id adf61e73a8af0-3bd4afd8113mr325777637.43.1782346807421;
        Wed, 24 Jun 2026 17:20:07 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0d10sm586839a12.21.2026.06.24.17.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:20:06 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: chengwei.yu@mediatek.com,
	yu-ching.liu@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 9/9] wifi: mt76: mt792x: advertise NAN data support
Date: Wed, 24 Jun 2026 19:18:34 -0500
Message-ID: <20260625001834.475094-10-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625001834.475094-1-sean.wang@kernel.org>
References: <20260625001834.475094-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38068-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:chengwei.yu@mediatek.com,m:yu-ching.liu@mediatek.com,m:jenhao.yang@mediatek.com,m:posh.sun@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 810186C1F84

From: Sean Wang <sean.wang@mediatek.com>

Advertise NAN and NAN data support when firmware exposes NAN
capability.

Add NAN interface combinations on top of the dynamic combination
framework, advertise 2.4 GHz and 5 GHz NAN bands, and enable secure
NAN.

Keep the base interface combinations unchanged when NAN is unavailable
so existing STA/AP/P2P modes keep the same limits.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Co-developed-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 96 ++++++++++++++++++-
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index ffe0bcdf1df6..411c04640add 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -3,6 +3,7 @@
 
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/slab.h>
 
 #include "mt792x.h"
 #include "dma.h"
@@ -60,6 +61,40 @@ static const struct ieee80211_iface_limit if_limits_chanctx_scc[] = {
 	}
 };
 
+static const struct ieee80211_iface_limit if_limits_nan_mcc[] = {
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_STATION),
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_NAN),
+	},
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_NAN_DATA),
+	},
+};
+
+static const struct ieee80211_iface_limit if_limits_nan_scc[] = {
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_STATION),
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_NAN),
+	},
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_NAN_DATA),
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_AP),
+	},
+};
+
 static const struct ieee80211_iface_combination if_comb_chanctx_base[] = {
 	{
 		.limits = if_limits_chanctx_mcc,
@@ -77,9 +112,31 @@ static const struct ieee80211_iface_combination if_comb_chanctx_base[] = {
 	}
 };
 
-static int mt792x_setup_iface_combinations(struct mt792x_dev *dev)
+static const struct ieee80211_iface_combination if_comb_chanctx_nan[] = {
+	{
+		.limits = if_limits_nan_mcc,
+		.n_limits = ARRAY_SIZE(if_limits_nan_mcc),
+		.max_interfaces = MT792x_MAX_INTERFACES,
+		.num_different_channels = 2,
+		.beacon_int_infra_match = false,
+	},
+	{
+		.limits = if_limits_nan_scc,
+		.n_limits = ARRAY_SIZE(if_limits_nan_scc),
+		.max_interfaces = MT792x_MAX_INTERFACES,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = false,
+	},
+};
+
+static int mt792x_setup_iface_combinations(struct mt792x_dev *dev,
+					   struct wiphy *wiphy)
 {
 	const bool cnm = !!(dev->fw_features & MT792x_FW_CAP_CNM);
+	const bool nan = !!(dev->fw_features & MT792x_FW_CAP_NAN);
+	const int n_base = ARRAY_SIZE(if_comb_chanctx_base);
+	const int n_nan = ARRAY_SIZE(if_comb_chanctx_nan);
+	struct ieee80211_iface_combination *comb;
 
 	if (!cnm) {
 		dev->iface_combinations = if_comb;
@@ -87,8 +144,24 @@ static int mt792x_setup_iface_combinations(struct mt792x_dev *dev)
 		return 0;
 	}
 
-	dev->iface_combinations = if_comb_chanctx_base;
-	dev->n_iface_combinations = ARRAY_SIZE(if_comb_chanctx_base);
+	/* CNM enabled, NAN optional */
+	if (!nan) {
+		dev->iface_combinations = if_comb_chanctx_base;
+		dev->n_iface_combinations = ARRAY_SIZE(if_comb_chanctx_base);
+		return 0;
+	}
+
+	/* CNM + NAN: dynamically build base + nan list */
+	comb = devm_kcalloc(&wiphy->dev, n_base + n_nan, sizeof(*comb),
+			    GFP_KERNEL);
+	if (!comb)
+		return -ENOMEM;
+
+	memcpy(comb, if_comb_chanctx_base, sizeof(if_comb_chanctx_base));
+	memcpy(comb + n_base, if_comb_chanctx_nan, sizeof(if_comb_chanctx_nan));
+
+	dev->iface_combinations = comb;
+	dev->n_iface_combinations = n_base + n_nan;
 
 	return 0;
 }
@@ -705,7 +778,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	else
 		wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
 
-	err = mt792x_setup_iface_combinations(dev);
+	err = mt792x_setup_iface_combinations(dev, wiphy);
 	if (err)
 		return err;
 
@@ -719,6 +792,21 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 				 BIT(NL80211_IFTYPE_P2P_GO) |
 				 BIT(NL80211_IFTYPE_P2P_DEVICE);
 
+	if ((dev->fw_features & MT792x_FW_CAP_CNM) &&
+	    (dev->fw_features & MT792x_FW_CAP_NAN)) {
+		wiphy->interface_modes |= BIT(NL80211_IFTYPE_NAN) |
+					  BIT(NL80211_IFTYPE_NAN_DATA);
+		wiphy->nan_supported_bands = BIT(NL80211_BAND_2GHZ) |
+					      BIT(NL80211_BAND_5GHZ);
+		wiphy->nan_capa.flags = WIPHY_NAN_FLAGS_CONFIGURABLE_SYNC |
+					WIPHY_NAN_FLAGS_USERSPACE_DE;
+		wiphy->nan_capa.op_mode = NAN_OP_MODE_PHY_MODE_MASK;
+		wiphy->nan_capa.n_antennas = 0x22;
+		wiphy->nan_capa.max_channel_switch_time = 12;
+		wiphy->nan_capa.dev_capabilities = NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED;
+		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SECURE_NAN);
+	}
+
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
 	wiphy->max_sched_scan_plan_interval =
-- 
2.43.0


