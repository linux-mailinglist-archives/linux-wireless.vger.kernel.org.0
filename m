Return-Path: <linux-wireless+bounces-7652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A138C5912
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 17:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E8D283A03
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B480217F398;
	Tue, 14 May 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YbjS75tX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453917EBA6;
	Tue, 14 May 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701892; cv=none; b=apWzzTX01mRAc4VtV/SW0ZAM4lLLMnUYuxmWLJNbcJOLIfXwGfe8QaimaJOZKXabnzPzjMlVym63vridx4v5Co11unONlnpnM9OTjjBdxgk1BgH6sKnMaEOUxFgHXQIIbWzKSKdgo8DZVsnwozaBEWQGb3q2QWRiu7JEumjTm/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701892; c=relaxed/simple;
	bh=23y+UJ5pwLExAtfwQqC8M2QubpaMy0NV+G7Fb5nYuy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OarKrE8oI5OJsM2nSos+0YLMBrDwxz9nlg6i1mPb6wUn7gJakBcZUqUc6f5ui7/dosEDkQZVmEl+50l25nWBOP5gUkqqS6IEaRaqlyMYl9eshP0JII9KBZpdiL4QE2wa7MgeWqs3USM+/ScaDm1GTgodjiM0yZb6MzqUP4kwwmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YbjS75tX; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4242C1C000D;
	Tue, 14 May 2024 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715701888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GC6vphaMtsQYBsWq7tPRncewuro5e75gbpvX8lW6DpY=;
	b=YbjS75tXNZ+5VHWUuHSb4yYvVB5WvVKvTf2RU7EInsv+TuqD7BFZzJyB1Grh1IEZm4Tvyl
	XSmWyfBk5j9pPOvEI44Wh0FsY7f2QKMNcP0mYsjTr38Og8qh5u29aFPrzuWviJHmpspZWs
	Vf4yWfYwQbEvprWTqVWxChEO+I1S5sclz+hOIJM4bO525kF3hJuJwiQG+iqxkgtDv0RmAj
	KHYyUwbSyvZpdKb1nZkKK4ZF1n6mJSDHjboTCNuBuLQcaefJPLApytnSeSXgoztLKyxkwq
	WIOLB2JWAMaBfBq70aqc4fd/OMUDbCLvpcGXmBh776vKso+tXA4A1XVXgsM5Ew==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 14 May 2024 17:51:22 +0200
Subject: [PATCH v2 4/6] wifi: wilc1000: add function to read mac address
 from eFuse
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240514-mac_addr_at_probe-v2-4-afef09f1cd10@bootlin.com>
References: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
In-Reply-To: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Heiko Thiery <Heiko.Thiery@kontron.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

wilc driver currently reads and sets mac address by firmware calls. It
means that we can not access mac address if no interface has been brought
up (so firmware is up and running). Another way to get mac address is to
read it directly from eFUSE.

Add a function helper to read the mac address written in eFuse, without
firmware assistance

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Changes in v2:
- move introduced helper at bottom of file
- export its symbol to make it accessible from sdio/spi modules
---
 drivers/net/wireless/microchip/wilc1000/fw.h     | 13 +++++++
 drivers/net/wireless/microchip/wilc1000/netdev.h |  2 +
 drivers/net/wireless/microchip/wilc1000/wlan.c   | 49 ++++++++++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/wlan.h   |  1 +
 4 files changed, 65 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/fw.h b/drivers/net/wireless/microchip/wilc1000/fw.h
index 5c5cac4aab02..7a930e89614c 100644
--- a/drivers/net/wireless/microchip/wilc1000/fw.h
+++ b/drivers/net/wireless/microchip/wilc1000/fw.h
@@ -13,6 +13,12 @@
 #define WILC_MAX_RATES_SUPPORTED		12
 #define WILC_MAX_NUM_PMKIDS			16
 #define WILC_MAX_NUM_SCANNED_CH			14
+#define WILC_NVMEM_MAX_NUM_BANK			6
+#define WILC_NVMEM_BANK_BASE			0x30000000
+#define WILC_NVMEM_LOW_BANK_OFFSET		0x102c
+#define WILC_NVMEM_HIGH_BANK_OFFSET		0x1380
+#define WILC_NVMEM_IS_BANK_USED			BIT(31)
+#define WILC_NVMEM_IS_BANK_INVALID		BIT(30)
 
 struct wilc_assoc_resp {
 	__le16 capab_info;
@@ -127,4 +133,11 @@ struct wilc_external_auth_param {
 	__le32 key_mgmt_suites;
 	__le16 status;
 } __packed;
+
+static inline u32 get_bank_offset_from_bank_index(unsigned int i)
+{
+	return (((i) < 2) ? WILC_NVMEM_LOW_BANK_OFFSET + ((i) * 32) :
+		WILC_NVMEM_HIGH_BANK_OFFSET + ((i) - 2) * 16);
+}
+
 #endif
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index eecee3973d6a..20ba030022a1 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -14,6 +14,7 @@
 #include <linux/if_arp.h>
 #include <linux/gpio/consumer.h>
 #include <linux/rculist.h>
+#include <uapi/linux/if_ether.h>
 
 #include "hif.h"
 #include "wlan.h"
@@ -278,6 +279,7 @@ struct wilc {
 	struct ieee80211_rate bitrates[ARRAY_SIZE(wilc_bitrates)];
 	struct ieee80211_supported_band band;
 	u32 cipher_suites[ARRAY_SIZE(wilc_cipher_suites)];
+	u8 nv_mac_address[ETH_ALEN];
 };
 
 struct wilc_wfi_mon_priv {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 37c32d17856e..b3fee8c8b7ad 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1472,6 +1472,55 @@ u32 wilc_get_chipid(struct wilc *wilc, bool update)
 	return wilc->chipid;
 }
 
+int wilc_load_mac_from_nv(struct wilc *wl)
+{
+	int ret = -EINVAL;
+	unsigned int i;
+
+	acquire_bus(wl, WILC_BUS_ACQUIRE_AND_WAKEUP);
+
+	for (i = 0; i < WILC_NVMEM_MAX_NUM_BANK; i++) {
+		int bank_offset = get_bank_offset_from_bank_index(i);
+		u32 reg1, reg2;
+		u8 invalid;
+		u8 used;
+
+		ret = wl->hif_func->hif_read_reg(wl,
+						 WILC_NVMEM_BANK_BASE + bank_offset,
+						 &reg1);
+		if (ret) {
+			pr_err("Can not read address %d lower part", i);
+			break;
+		}
+		ret = wl->hif_func->hif_read_reg(wl,
+						 WILC_NVMEM_BANK_BASE + bank_offset + 4,
+						 &reg2);
+		if (ret) {
+			pr_err("Can not read address %d upper part", i);
+			break;
+		}
+
+		used = FIELD_GET(WILC_NVMEM_IS_BANK_USED, reg1);
+		invalid = FIELD_GET(WILC_NVMEM_IS_BANK_INVALID, reg1);
+		if (!used || invalid)
+			continue;
+
+		wl->nv_mac_address[0] = FIELD_GET(GENMASK(23, 16), reg1);
+		wl->nv_mac_address[1] = FIELD_GET(GENMASK(15, 8), reg1);
+		wl->nv_mac_address[2] = FIELD_GET(GENMASK(7, 0), reg1);
+		wl->nv_mac_address[3] = FIELD_GET(GENMASK(31, 24), reg2);
+		wl->nv_mac_address[4] = FIELD_GET(GENMASK(23, 16), reg2);
+		wl->nv_mac_address[5] = FIELD_GET(GENMASK(15, 8), reg2);
+
+		ret = 0;
+		break;
+	}
+
+	release_bus(wl, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wilc_load_mac_from_nv);
+
 int wilc_wlan_init(struct net_device *dev)
 {
 	int ret = 0;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index 54643d8fef04..d72a0a81bbda 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -445,4 +445,5 @@ int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 			 u32 count);
 int wilc_wlan_init(struct net_device *dev);
 u32 wilc_get_chipid(struct wilc *wilc, bool update);
+int wilc_load_mac_from_nv(struct wilc *wilc);
 #endif

-- 
2.44.0


