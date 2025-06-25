Return-Path: <linux-wireless+bounces-24484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DB5AE8668
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 16:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E17BA4D3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23541264A7C;
	Wed, 25 Jun 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQbaOju/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2FE266573;
	Wed, 25 Jun 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861549; cv=none; b=YAhqb/3idlCktNgPWq4V1ZKGKzjPuA7dk0ruC2GbaY0AtVwLMgbo5tvoxtEBuI084yykxhLpuWtcvHdnfDqtXL8WCfmh6lYkLgJ9Mi2meINLJHX3w8ASblUJfwhmd3xbdO4WsWnMaInSd8R/MjAfRup2LXkpjYWkGrto0pNG9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861549; c=relaxed/simple;
	bh=ooti5aRiP+r/vzUl75DAjcq1JqYhjChiHekLoh9kh1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQPkS+ygog9GItwi8wIo5EQNAFMq+eQ6YpmVPrLiEgbXVKvFSGQEKVJYqbDOJQcRG4PG2PGk//ByypsfRRYLtzfCar8dtDuJhGlH0/hlownfhGfDtj3NXpzlXO/3ZrQYJd2LqBEH0L8W5RznJusO4aAXiHIbjDJdq4AdkBJ9nuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQbaOju/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748d982e92cso1018675b3a.1;
        Wed, 25 Jun 2025 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750861546; x=1751466346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gaf+j9calOvQuq5f2KKkjhmZldOW4cezU0qA9IROgM=;
        b=OQbaOju/KCyWVSkvdg06XPtWcsBLnAXFme+L1l5/pNAJMGYNlF07D0hFmYT9C66mVp
         Yq0pTfWdvYya7A8b1UpAS3AUdjz0p+7ixVtJ+OdZF2gxwIBCgMQF2idFobKapBrWRaN3
         86e8e8QBwzEqszwgzLC2bXf5q7BbRed2795rgq5uQusOS4EO1P+wO47Yv8vPn7gujTHt
         dF4+G/au6YFnXiXBZJSVYlN11Pj96x1pqV9oyv7PcamiG432itzIfz+4v/K6ty6zQcYa
         1gcNcHab70v0I1iwm3qeqDKxPJCTKYVugp9FyskTwMsPtIM5AtwssU088W7lMd4g4+7G
         hZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750861546; x=1751466346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gaf+j9calOvQuq5f2KKkjhmZldOW4cezU0qA9IROgM=;
        b=EpSPpNY3J47ILZtXsN6YTlP5fYoplyklTBmYCQ3917TUz3eFkc/vUDUG8teI35Vo96
         z2/XN81ZJAlmnhiQYqcrY7TcDO/HpmpGkJHtdlFP02wKeifbSgzv6cTfrdOvjrf4RkbU
         vuxVmpS2nv1+a/r0ZlOMUPp72sbfCcYUtM8PLgczbdsyqQZDmJBF1VcDtyofKBhdMThA
         1K+bbpNQY0hlpMkN09CbA2OxoiY8Q62x0wcVORnwDiewOzlCbbl/lA5Ym4Ki2BC4IEBL
         rNRsWNytosXftgcVwxTFzeQD878UGQV3w3fDtG2SJaOZ5YzL7IMFi64hFxIm3WzMA313
         PLaA==
X-Forwarded-Encrypted: i=1; AJvYcCWQD1sCxGJfxpjGPF3g56WCTk06kSs07FPnaQW9SbZNWgJavRsXw7BiyTNy8VqRg/D+mxaidVNvgbExtc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyritTVNWuJ+JmBPh0OQYdLpiX+Gy/ibqRIPknZWXkvCY8ys5IL
	3hhqJL2blmCqJ6KaTk4TA5EWKmLUHptKUI7+Whv3xI6XMt+kp6/UbsQxBt8Gyg==
X-Gm-Gg: ASbGnctJ4z1FxGkWmQuCXScEZaVKbGMoRZKW+c4zrABGrmDeVlwjimkyxtBg1n6Ofpc
	U54FnrmRfrA6emluejj5Owa0q/WBavFhJ9mqB/ejiJkj+AIAF5spC29U11aKmYPv2iXE/1wNmDG
	cJOvSQ9H087nuj5QOIV7Mev5QiOCH+iAXyh19RUXREHtxq5sd1/4M7uUXsRv92AmgbI2N0Gv0oL
	Rxg9MKhq1cxRyto5CRn98KH7Jq9j0pdPFrF6DRYG67y2BV0hPdw42g0sysR8zsH9mk7tffQQUMj
	E7HoGeEcQFiSteU21deWWbqxHmtLgXyVSw7it2BHYkzm2Q3WU3n8DlmNAfiZoFhHfGAFxdmAjXo
	n0M3QRHuKv/A=
X-Google-Smtp-Source: AGHT+IHWZsVJs3bjakpXmS/j9tChOa1kgGP9vCPU8F4xi0Cy6u3OFesatG0pGJChVzETz0Ab6p6g/w==
X-Received: by 2002:a05:6a00:1146:b0:748:3964:6177 with SMTP id d2e1a72fcca58-74ad44f267dmr5223809b3a.19.1750861546212;
        Wed, 25 Jun 2025 07:25:46 -0700 (PDT)
Received: from tx3000mach.io (static.220.227.itcsa.net. [190.15.220.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08cfbsm4764799b3a.18.2025.06.25.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 07:25:45 -0700 (PDT)
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Date: Wed, 25 Jun 2025 11:25:39 -0300
Message-ID: <20250625142541.44795-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a MR to see if rtl8xxxu can be made to support P2P.

Theoretically this should be handled by mac80211 but it seems that
drivers may have to take some extra steps depending on which device we
are talking about. I know that this patch is so basic that it might be
missing some H2C commands or similar for this to work on Realtek chips
but I don't have the required knowledge for me to implement it, so if
you know a place to read about I'll be glad to hear.

As of now only rtl8192ex devices have their P2P_CLIENT and P2P_GO wiphy
interface modes ensured because those are the only ones I can test on
my rtl8192eu card. The rest of chips have them set from what I've seen
in a cursory Internet search, they might or might not work.

Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8188f.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192e.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192f.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8710b.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8723b.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c  | 29 ++++++++++++++++++-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 +
 10 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
index 766a7a7c7d28..f4f5ad7d88e5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1866,6 +1866,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.has_tx_report = 1,
 	.init_reg_pkt_life_time = 1,
 	.gen2_thermal_meter = 1,
+	.supports_p2p = 0,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
index 3abf14d7044f..3102384b35eb 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
@@ -1749,6 +1749,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.ustime_tsf_edca = 0x28,
 	.max_aggr_num = 0x0c14,
 	.supports_ap = 1,
+	.supports_p2p = 1,
 	.max_macid_num = 16,
 	.max_sec_cam_num = 16,
 	.supports_concurrent = 1,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
index 73034e7e41d1..df9cb7e0e331 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
@@ -645,6 +645,7 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
 	.supports_ap = 1,
+	.supports_p2p = 1,
 	.max_macid_num = 32,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
index 8e123bbfc665..f6cdd0eb5b44 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
@@ -1752,6 +1752,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
 	.supports_ap = 1,
+	.supports_p2p = 1,
 	.max_macid_num = 128,
 	.max_sec_cam_num = 64,
 	.adda_1t_init = 0x0fc01616,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
index cd2156b7a57a..2a505350e6e8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
@@ -2078,6 +2078,7 @@ struct rtl8xxxu_fileops rtl8192fu_fops = {
 	.ustime_tsf_edca = 0x50,
 	.max_aggr_num = 0x1f1f,
 	.supports_ap = 1,
+	.supports_p2p = 1,
 	.max_macid_num = 128,
 	.max_sec_cam_num = 64,
 	.trxff_boundary = 0x3f3f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
index 11c63c320eae..242296a57c92 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
@@ -1860,6 +1860,7 @@ struct rtl8xxxu_fileops rtl8710bu_fops = {
 	.ustime_tsf_edca = 0x28,
 	.max_aggr_num = 0x0c14,
 	.supports_ap = 1,
+	.supports_p2p = 0,
 	.max_macid_num = 16,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x03c00016,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
index ecbc324e4609..381fde571858 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
@@ -519,6 +519,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
+	.supports_p2p = 0,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
index cc2e60b06f64..9837580e316e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
@@ -1750,6 +1750,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.ustime_tsf_edca = 0x50,
 	.max_aggr_num = 0x0c14,
 	.supports_ap = 1,
+	.supports_p2p = 1,
 	.max_macid_num = 128,
 	.max_sec_cam_num = 64,
 	.adda_1t_init = 0x01c00014,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 569856ca677f..ac2691d6f991 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -1600,9 +1600,11 @@ static void rtl8xxxu_set_linktype(struct rtl8xxxu_priv *priv,
 	case NL80211_IFTYPE_ADHOC:
 		type = MSR_LINKTYPE_ADHOC;
 		break;
+	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_STATION:
 		type = MSR_LINKTYPE_STATION;
 		break;
+	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_AP:
 		type = MSR_LINKTYPE_AP;
 		break;
@@ -6780,6 +6782,7 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 		return -EOPNOTSUPP;
 
 	switch (vif->type) {
+	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_STATION:
 		if (port_num == 0) {
 			rtl8xxxu_stop_tx_beacon(priv);
@@ -6790,6 +6793,7 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 			rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
 		}
 		break;
+	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_AP:
 		if (port_num == 1) {
 			rtl8xxxu_switch_ports(priv);
@@ -6839,6 +6843,23 @@ static void rtl8xxxu_remove_interface(struct ieee80211_hw *hw,
 	priv->vifs[rtlvif->port_num] = NULL;
 }
 
+static int rtl8xxxu_change_interface(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     enum nl80211_iftype new_type, bool p2p)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+	int ret;
+
+	dev_dbg(&priv->udev->dev, "%s: p2p %x\n", __func__, p2p);
+
+	rtl8xxxu_remove_interface(hw, vif);
+	vif->type = new_type;
+	vif->p2p = p2p;
+	ret = rtl8xxxu_add_interface(hw, vif);
+
+	return ret;
+}
+
 static int rtl8xxxu_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -7623,6 +7644,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.tx = rtl8xxxu_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.add_interface = rtl8xxxu_add_interface,
+	.change_interface = rtl8xxxu_change_interface,
 	.remove_interface = rtl8xxxu_remove_interface,
 	.config = rtl8xxxu_config,
 	.conf_tx = rtl8xxxu_conf_tx,
@@ -7755,7 +7777,9 @@ static void rtl8xxxu_deinit_led(struct rtl8xxxu_priv *priv)
 
 static const struct ieee80211_iface_limit rtl8xxxu_limits[] = {
 	{ .max = 2, .types = BIT(NL80211_IFTYPE_STATION), },
-	{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
+	{ .max = 1, .types = BIT(NL80211_IFTYPE_AP) |
+			     BIT(NL80211_IFTYPE_P2P_CLIENT) |
+			     BIT(NL80211_IFTYPE_P2P_GO), },
 };
 
 static const struct ieee80211_iface_combination rtl8xxxu_combinations[] = {
@@ -7912,6 +7936,9 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
 	if (priv->fops->supports_ap)
 		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
+	if (priv->fops->supports_p2p)
+		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_P2P_CLIENT) |
+					      BIT(NL80211_IFTYPE_P2P_GO);
 	hw->queues = 4;
 
 	hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index f42463e595cc..7a0a9fd20cdf 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -2013,6 +2013,7 @@ struct rtl8xxxu_fileops {
 	u8 ustime_tsf_edca;
 	u16 max_aggr_num;
 	u8 supports_ap:1;
+	u8 supports_p2p:1;
 	u16 max_macid_num;
 	u16 max_sec_cam_num;
 	u32 adda_1t_init;
-- 
2.50.0


