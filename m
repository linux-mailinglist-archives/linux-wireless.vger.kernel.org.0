Return-Path: <linux-wireless+bounces-32489-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL26CM7FqGlaxAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32489-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EC72092AF
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5EC4300DDFB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 23:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF97E3612E0;
	Wed,  4 Mar 2026 23:51:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52234CFDC
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668267; cv=none; b=hj6QS3wemI8fP2cLN/3WCtNGLRDzoa3RMfAmdJTIZSzqwMK8JXLkBCytaWAmi0Aputay9Dw5ogkpE8fP/IGiordf8HXuzaM1mTxYtWQRPx8EQwrNwgvK6UVSnj/DPEhA7hWlh04XqLleTfLPEVGPkteOfIlAB7Npu7QcYiOGtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668267; c=relaxed/simple;
	bh=zWThluRV6eLvFdcAqteJyZQPVxNcGX3VNjlXT2HMjsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmnRKKQld6pFpS6mJnY+2KIK6HqWS8FcO6L4V3g1nXu/+8sIZD/gdWc3BVKQbVScJHS7nUmhu9bu8aQ1vr9c4elw0XVhseqDHb8nYD4AGUPLN6I/NVaI49eDUmqjH8LEcCxGyiaXHWre8KN8qSWsod+YKclrx02lV/L/6iWBjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6798f3b7163so5779238eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 15:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668265; x=1773273065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAqqe+aeOoyV8Ax1MI/sypRmEwsUTxpCb02A2MgON44=;
        b=LIpFaswXRwJ9i2lKrwEDVQtgCwe0R1bwGqZqkflDZvBQCSyvsbjv0oSAUkxLiCQVB6
         DLYnpKh7KdCKky/2FZfk5+YEUgebubfk2kaCnJiTpFkcnvKPY/ZRChO5H6rdvAtzKc2V
         VsfVu9kMCkVEG1X8MB/NPE8EDvM/kMu+IbPBUaDpUvXy2x3+vWzOrmp/94eZM9NcVidM
         RZBHqt7QhNsor+ntQlV0eG8x+Cgl5WpUPmme0rkCqi3n3vzBAhYsyFIOzNQOqAxGb7nl
         yalWaQ6Wk0GOl/dNe8e+BAF7hpNIdl2o8vMfcrEqG5Y0MCCj5mTe9TuQBMdp9VVu/DFr
         gyTg==
X-Gm-Message-State: AOJu0YzDnr4BoOrA/IVEUxA+E3VTN9Df7VII5sQF45+xvjl7H4m2Vnnr
	C0P4SNf+W4XUZJDBwRRaJkxFfM8HBowIS78iueFtRtLujU6UsbPSa8mLWNaxCA==
X-Gm-Gg: ATEYQzwbaUB+KrHcp/Y7yWuD2mzwsqv+bTEFnRYNlVWygedQw8t5/o8MuRiRfFpBVmd
	QZhk7yIg0WV1JgoqGSY8OcAt3f86doZt8r99fjqm1jnZ6bTevkggJcCqv30Ka0Y+z4twDSfEZ6b
	WYA0WeIw61vjhZ2T9Q1CFFkn6hLlyvJYxJqfWntUb2WMXXotCBZfmIde/+FyJd+2bBGXI1Zj0Jo
	fTevhMv0kMiKSLkwin5Wr5faVK7JH4gYnUOYjSfgC8QyUZIwfXR++g+EOKownx8wDyZ6cf2THo3
	iAuhdkfGFmVk0UGUkoyYTlBzBPRNZQ3+vReYWXNWjmatbsP3KzzmGDt1/6mdq6R22F8y0FM2E1I
	i3KQ4MqOmbJTHzualUX6P5RQg2M0SPHstVB6UOPgZDYwHdpVCeNurxbQzL9H9I4IYwdBhQOGpzn
	rY7t2o5KK/JnoYkYzxL2RthLe+EL/ykpD+O8PUj2sf1gg3kIg=
X-Received: by 2002:a05:6820:220a:b0:67a:1d88:46d5 with SMTP id 006d021491bc7-67b17703b4dmr2382992eaf.31.1772668265499;
        Wed, 04 Mar 2026 15:51:05 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm14410687eaf.7.2026.03.04.15.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:51:05 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	yu-ching.liu@mediatek.com,
	yuchi.wang@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 7/7] wifi: mt76: mt792x: build iface combinations dynamically for optional NAN
Date: Wed,  4 Mar 2026 17:50:20 -0600
Message-ID: <20260304235020.40451-7-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304235020.40451-1-sean.wang@kernel.org>
References: <20260304235020.40451-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C1EC72092AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32489-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Expose NAN capability only when supported by firmware. Split chanctx
interface combinations into base and NAN sets and dynamically append NAN
combinations when available.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   4 +
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 113 ++++++++++++++++--
 2 files changed, 109 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index d3988e5b38c0..57c9a0437c5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -23,6 +23,7 @@
 #define MT792x_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
 
 #define MT792x_FW_TAG_FEATURE	4
+#define MT792x_FW_CAP_NAN	BIT(5)
 #define MT792x_FW_CAP_CNM	BIT(7)
 
 #define MT792x_CHIP_CAP_CLC_EVT_EN BIT(0)
@@ -263,6 +264,9 @@ struct mt792x_dev {
 	struct ieee80211_chanctx_conf *new_ctx;
 
 	struct ieee80211_vif *nan_vif;
+
+	const struct ieee80211_iface_combination *iface_combinations;
+	int n_iface_combinations;
 };
 
 static inline struct mt792x_bss_conf *
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index f12cbfb35f9b..e0850998cb4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -3,6 +3,7 @@
 
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/slab.h>
 
 #include "mt792x.h"
 #include "dma.h"
@@ -60,7 +61,33 @@ static const struct ieee80211_iface_limit if_limits_chanctx_scc[] = {
 	}
 };
 
-static const struct ieee80211_iface_combination if_comb_chanctx[] = {
+static const struct ieee80211_iface_limit if_limits_nan_mcc[] = {
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_STATION),
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_NAN),
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
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_AP),
+	},
+};
+
+static const struct ieee80211_iface_combination if_comb_chanctx_base[] = {
 	{
 		.limits = if_limits_chanctx_mcc,
 		.n_limits = ARRAY_SIZE(if_limits_chanctx_mcc),
@@ -77,6 +104,60 @@ static const struct ieee80211_iface_combination if_comb_chanctx[] = {
 	}
 };
 
+static const struct ieee80211_iface_combination if_comb_chanctx_nan[] = {
+	{
+		.limits = if_limits_nan_mcc,
+		.n_limits = ARRAY_SIZE(if_limits_nan_mcc),
+		.max_interfaces = 3,
+		.num_different_channels = 2,
+		.beacon_int_infra_match = false,
+	},
+	{
+		.limits = if_limits_nan_scc,
+		.n_limits = ARRAY_SIZE(if_limits_nan_scc),
+		.max_interfaces = 4,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = false,
+	},
+};
+
+static int mt792x_setup_iface_combinations(struct mt792x_dev *dev,
+					   struct wiphy *wiphy)
+{
+	const bool cnm = !!(dev->fw_features & MT792x_FW_CAP_CNM);
+	const bool nan = !!(dev->fw_features & MT792x_FW_CAP_NAN);
+	const int n_base = ARRAY_SIZE(if_comb_chanctx_base);
+	const int n_nan = ARRAY_SIZE(if_comb_chanctx_nan);
+	struct ieee80211_iface_combination *comb;
+
+	if (!cnm) {
+		dev->iface_combinations = if_comb;
+		dev->n_iface_combinations = ARRAY_SIZE(if_comb);
+		return 0;
+	}
+
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
+
+	return 0;
+}
+
 void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 	       struct sk_buff *skb)
 {
@@ -621,6 +702,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = phy->dev;
 	struct wiphy *wiphy = hw->wiphy;
+	int err;
 
 	hw->queues = 4;
 	if (dev->has_eht) {
@@ -641,15 +723,17 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	hw->vif_data_size = sizeof(struct mt792x_vif);
 	hw->chanctx_data_size = sizeof(struct mt792x_chanctx);
 
-	if (dev->fw_features & MT792x_FW_CAP_CNM) {
+	if (dev->fw_features & MT792x_FW_CAP_CNM)
 		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-		wiphy->iface_combinations = if_comb_chanctx;
-		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_chanctx);
-	} else {
+	else
 		wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-		wiphy->iface_combinations = if_comb;
-		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
-	}
+
+	err = mt792x_setup_iface_combinations(dev, wiphy);
+	if (err)
+		return err;
+
+	wiphy->iface_combinations = dev->iface_combinations;
+	wiphy->n_iface_combinations = dev->n_iface_combinations;
 	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
 			  WIPHY_FLAG_4ADDR_STATION);
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
@@ -657,6 +741,19 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 				 BIT(NL80211_IFTYPE_P2P_CLIENT) |
 				 BIT(NL80211_IFTYPE_P2P_GO) |
 				 BIT(NL80211_IFTYPE_P2P_DEVICE);
+	if ((dev->fw_features & MT792x_FW_CAP_CNM) &&
+	    (dev->fw_features & MT792x_FW_CAP_NAN)) {
+		wiphy->interface_modes |= BIT(NL80211_IFTYPE_NAN);
+		wiphy->nan_supported_bands = BIT(NL80211_BAND_2GHZ);
+		wiphy->nan_capa.flags = WIPHY_NAN_FLAGS_CONFIGURABLE_SYNC |
+					WIPHY_NAN_FLAGS_USERSPACE_DE;
+		wiphy->nan_capa.op_mode = NAN_OP_MODE_PHY_MODE_MASK;
+		wiphy->nan_capa.n_antennas = 0x22;
+		wiphy->nan_capa.max_channel_switch_time = 12;
+		wiphy->nan_capa.dev_capabilities = NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
+						   NAN_DEV_CAPA_NDPE_SUPPORTED;
+	}
+
 	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
-- 
2.43.0


