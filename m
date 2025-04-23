Return-Path: <linux-wireless+bounces-21939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877BDA99955
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 22:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3071C3B4C18
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 20:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9710267725;
	Wed, 23 Apr 2025 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfPHpIuD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA62676D5;
	Wed, 23 Apr 2025 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439567; cv=none; b=i7pCujXjhu/HYCj+C9IYybaAUJ7yOXbUJTd9pu8NeNiyeL1QzzyHl60l3QUxjccA8Kw7la72xjVDrLPFLquZEWotTIpDqZKlUVVoptSxv8Vq5N6bePXxP6FoZDFS90YWmY8ZS7LJSim9pzjovjT/M6nZSDmGrm7dgp0y3YaqofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439567; c=relaxed/simple;
	bh=ypATHgxe9OKMMT4ueyZaXJY+x4E9WbNaG82oxo9s5uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOe9sKNh4HwuBPpjXZMrwspruEAbbjI7/YuLiCZepBIkfdC+0Ibs02d9PG4w/7nS05jG/d1POrBkwYe0Z8q6obpL3E9vIxKtAd/2fWZe+jvePfLK6LagwOsAaUkqL5zSrGIm35Hu/ZWQo8JIvE+23HOVrrxSJAVvb7F4buaD/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfPHpIuD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso292966a91.3;
        Wed, 23 Apr 2025 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745439565; x=1746044365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jfULKrr/5lq04eW6UVhSPrwpZEUbOVGhJ57dD7II/gs=;
        b=cfPHpIuDQNA3+uhad/mL1JTq3BhEX1yiK3YwvSXxEjq3ZEflPksZ50A7nwRGYQbHum
         frxDfKpv93lpvBwhM3/6Pvnsp0P4uocrLIKTqvEvy4NAo0T7b+d9LhZdr2Ow54xnDoPW
         UEdFx4HKh4irchO828pM2sE9yC40jABTGXkZysuDlPTqF0asE1wmcxQhBbU+cdlIa0BQ
         fi1KbQ7EKvjf/k2oB4GND/jr9Qlnxub/dc+tyyE2xUhvz53y3/StOrf8NQ+EFsJmy9rZ
         iOLnKsCpr3XVQlMkbx+j2ONc+wrDsFtZbtMiygsjywNMQ87L+9G0aX40TvjJ9o7Uc12a
         lIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439565; x=1746044365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfULKrr/5lq04eW6UVhSPrwpZEUbOVGhJ57dD7II/gs=;
        b=aZgb7WdRBawOuI24nfFUD5XA2KOMVDSa0cBUZatjGvBxmtmX1E6ysNFl3Ym0HxUr4n
         G01ji1xeJaYWEThDUK6cRSBIr8mXsJD4iIGX2hMjltqDHnDhzxe8V2ayTT5VTq0qcPgU
         ir+XcESVc/hMW4AsadcN6YJ/clC/bvJq2r60zu6fyJC008U9ky6RWYoWUCVTIHHDIPZv
         NZv1bYdBpQf5V6CsWeDigb1LStw3admHw2CYcv3Ql9lb128e6/Y168HAtQF55mt/lAMy
         Bu89wb9aELzzLMpDdF7NNGPeL1kKelP7fwLrauZ3RY5sYPjSF07t5beml+0aK/fYhUrW
         ZEgA==
X-Forwarded-Encrypted: i=1; AJvYcCXq6/kW1BWpWDE5xUbVJxHzrJ8sSF8YF+lR7D9VHcjz0dGkE7boLsmBrflyLAxbdURmKKa5xlETLPAMsSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWWyyWPssSUEBQuhSLuJOCTSNgACtUJJUs5mGuICUm50hsu10t
	L8aqBzaaEkK2MXhl0sM5IWASxOqhoAMOxGgxIuJpqAuwvk+ayP0T0p7R0KWl
X-Gm-Gg: ASbGncuBVaiLl9+2CVB+ZxEGdeg8f52s9UD+2PZ+383zSdscJlv0sHWyiGfclk/yhyg
	UUpGEMcq8Jr0bM34j8Xde4UD0FyOJEHiJpVHwqsBcAhbzpgcC2uRNJl/9CPaw9NKZ9z6k86YGDE
	OPQ/Wsk/GCm819B0BAO4TX6t6zclV1pWK/nM2ScJJXWoWguAred0GQd1RTgZ00TQuLzjtEBaqLf
	ZDUOIhL0i0YHJFRLLSY9xaZlnIOIzBOnNBF6FtQGR9VAv79nIzu1QrFl9zDRAzYREFW8GBy87gH
	MBcbKHK2E01qI4UgC+k2Qy6ReaI+JcZATUzF+6mXEoDdRkuM8HEN6NSnyv3wjZ8Rig==
X-Google-Smtp-Source: AGHT+IHOpwScgngCcl2LpJpGPdxM/kMXRM3zuPqm/nt9/Fh8wPU6B5okiHMJ8CY4mrNOYD0kZWs+4g==
X-Received: by 2002:a17:90a:d60c:b0:2ff:6aa6:47a3 with SMTP id 98e67ed59e1d1-309ed31b6d3mr195116a91.25.1745439564720;
        Wed, 23 Apr 2025 13:19:24 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309e0d06a91sm2087633a91.46.2025.04.23.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:19:24 -0700 (PDT)
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Date: Wed, 23 Apr 2025 17:18:25 -0300
Message-ID: <20250423201826.1054254-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC to see if rtl8xxxu can be made to support P2P.

Theoretically this should be handled by mac80211 but it seems that
drivers may have to take some extra steps depending on which device we
are talking about. I know that this patch is so basic that it might be
missing some H2C commands or similar for this to work on Realtek chips
but I don't have the required knowledge for me to implement it, so if
you know a place to read about I'll be glad to hear.

As of now only rtl8192ex devices will have their P2P_CLIENT, P2P_GO
and P2P_DEVICE wiphy interface modes set because those are the only
ones I can test on my rtl8192eu card.

Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/8192e.c |  3 ++
 drivers/net/wireless/realtek/rtl8xxxu/core.c  | 34 ++++++++++++++++++-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 ++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
index 8e123bbfc665..3e78c5b73726 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
@@ -1752,6 +1752,9 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
 	.supports_ap = 1,
+	.supports_p2p_client = 1,
+	.supports_p2p_go = 1,
+	.supports_p2p_device = 1,
 	.max_macid_num = 128,
 	.max_sec_cam_num = 64,
 	.adda_1t_init = 0x0fc01616,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 569856ca677f..a86c4a9083b2 100644
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
@@ -6780,6 +6782,8 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 		return -EOPNOTSUPP;
 
 	switch (vif->type) {
+	case NL80211_IFTYPE_P2P_CLIENT:
+		fallthrough;
 	case NL80211_IFTYPE_STATION:
 		if (port_num == 0) {
 			rtl8xxxu_stop_tx_beacon(priv);
@@ -6790,6 +6794,8 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 			rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
 		}
 		break;
+	case NL80211_IFTYPE_P2P_GO:
+		fallthrough;
 	case NL80211_IFTYPE_AP:
 		if (port_num == 1) {
 			rtl8xxxu_switch_ports(priv);
@@ -6839,6 +6845,23 @@ static void rtl8xxxu_remove_interface(struct ieee80211_hw *hw,
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
@@ -7623,6 +7646,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.tx = rtl8xxxu_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.add_interface = rtl8xxxu_add_interface,
+	.change_interface = rtl8xxxu_change_interface,
 	.remove_interface = rtl8xxxu_remove_interface,
 	.config = rtl8xxxu_config,
 	.conf_tx = rtl8xxxu_conf_tx,
@@ -7755,7 +7779,9 @@ static void rtl8xxxu_deinit_led(struct rtl8xxxu_priv *priv)
 
 static const struct ieee80211_iface_limit rtl8xxxu_limits[] = {
 	{ .max = 2, .types = BIT(NL80211_IFTYPE_STATION), },
-	{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
+	{ .max = 1, .types = BIT(NL80211_IFTYPE_AP) |
+			     BIT(NL80211_IFTYPE_P2P_CLIENT) |
+			     BIT(NL80211_IFTYPE_P2P_GO), },
 };
 
 static const struct ieee80211_iface_combination rtl8xxxu_combinations[] = {
@@ -7912,6 +7938,12 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
 	if (priv->fops->supports_ap)
 		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
+	if (priv->fops->supports_p2p_client)
+		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_P2P_CLIENT);
+	if (priv->fops->supports_p2p_go)
+		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_P2P_GO);
+	if (priv->fops->supports_p2p_device)
+		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_P2P_DEVICE);
 	hw->queues = 4;
 
 	hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index f42463e595cc..954f3fc24ce8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -2013,6 +2013,9 @@ struct rtl8xxxu_fileops {
 	u8 ustime_tsf_edca;
 	u16 max_aggr_num;
 	u8 supports_ap:1;
+	u8 supports_p2p_client:1;
+	u8 supports_p2p_go:1;
+	u8 supports_p2p_device:1;
 	u16 max_macid_num;
 	u16 max_sec_cam_num;
 	u32 adda_1t_init;
-- 
2.49.0


