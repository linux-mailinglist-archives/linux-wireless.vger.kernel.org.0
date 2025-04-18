Return-Path: <linux-wireless+bounces-21725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D393A938C8
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 16:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8879D464FC1
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FA51BEF6D;
	Fri, 18 Apr 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Obx5u+NR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE61B5EB5
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987176; cv=none; b=D3UBJeXLYccjZgGz1DTQwTU7J79C7P4JODub8EgH8bLEfTDZxmmbPW1zRCqZbwXv11nL1kl9PVRqDzgbDxFrdowjNL9JNxrzmkuAidgEpJRz5llOJoyu7PGX+D99n5QRWsvlguk8Ne27nroR6FkoOLrUCsJEkN6NHnRP/VdP02o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987176; c=relaxed/simple;
	bh=Rn/xv6jgBIwnweQuyPnc67mZbiZPKZmZ/6n+70nJvAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL6pvjZmH4A3L1jr4XSeUFCznq3EGPXfCo8Q43HSMJqHphqjxrFltDHshQIGldKfthWkgeH44DC3ultrWXlXqNL10PgxptyDmEfRlYoTO8mhJKpRa4mwJCqjzfBvCX6/FDAYS5/qBFxkPEcMqhNajyyozqrnLv01jrBaie2AYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Obx5u+NR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so3531823a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744987173; x=1745591973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHQ7sWlAVcM0/VVhC0OUxzsz0J+F9rLBF4CJX7+CYI8=;
        b=Obx5u+NRhXfraCaIdQpRHoh080sUk01GWzrUrH45FJqJLnI7Q443DRDvlAiGE39NG2
         XTjTIw1BItBYDHZIxc+XhIN7D4J/7k+4Pvks1tx6bJ/jMoE+7W7L8KebV7JAiZJj3ITg
         QkVOyMTMh7m6lXWOPGCifFUMfU8qzdv4lmXEXFGQx+Hqw4pZet54pc7kvsPJ/p8VGPAz
         d+Zgv5lcSIBgANFmIDuoa8io3jF/NfJbAZcxZgDyFiKHXA7Cj1q2P3cTFcarTY5vpHdZ
         yl0MY2tqecVPyLMSdMh84WOm1UrK3CoPrBHiTccU9eAMACP/TvEHT93v4NBbvYqDUJXh
         FIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744987173; x=1745591973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHQ7sWlAVcM0/VVhC0OUxzsz0J+F9rLBF4CJX7+CYI8=;
        b=Eu1NS0Eizp2HFyghx5+uZbHBMmNGskqd/G2gC1bhYy6iT3BsmI7BxzExn1wZs7y0+4
         jaWOGRzozknuEDUPlqBEbAnhB6DIoRE0VCA85HHvJ+ZX/dXWpdxmwB9s0n0LVVGvy08k
         XhaJLJGWC+q6ussDc3fdvuIYzdJ93RvTBap0WZjsU2WmGcGzpEUkbIBOACrBYFr5+DWp
         lviJAZfY2U9JJa1J2ID9sC68RugOxWinIacYlhOZRHNIh/8A2LEbg5Nfc1TXCwkYrQIQ
         HSid8sBWs2L/9JQuATbHxtdbuPRL7uWXmFNHCbR3wD7spKzlJT9Y6awt9n3fdzx5zuAc
         hrXw==
X-Gm-Message-State: AOJu0YyxAC3v0y9yG0RZcB0oXP27/RQfrjSdn4TQgVrOgVWTWT+NDh/C
	lmOg/lTJsXOGFLpqvqTb4uCViiw2WWrHm4cG4sCn/+FgokkXDKCki3EWNDI5
X-Gm-Gg: ASbGncsrxGxwD3ai/LMSb7KKxR5XjeFqg/enQcnDAmW6s7NpCbq5E+RUBQwZcT8/PQm
	jzbCytRYU1q5nxxMeQzund3sN7ucBVHRrMQYpstgaBe7pu72zVNEKiK4UNbbL8DoqPPvohADDMD
	lt9ireULJlbLVlbGaFEPplmo7KZVRaT02Pd4NXTc+plQ82hpRJ3QpyvYKjGLhlOOygnge93oCr+
	3ifHHtw/N4/WYtUGANn83rpNJ9/6WzCOXOssTXQTaaadzQIr+6YGFkgtzXAdeZN0qVYOYipxSs0
	0VAlN2rRtpkdj6nIATk3OHyDUQUdyILSqvpNKKxzCL9wTCfCACulbTJ+Bt8gDsHOVCH1mV8TVgR
	TN9/vhlhc4Q==
X-Google-Smtp-Source: AGHT+IGwtfyB400cRlwxaLbUqmmfoYYoIR0LJ3AHjbLWfarZCih/anhk7KFygqBQFL4IWQdWuh03nA==
X-Received: by 2002:a17:907:3d8c:b0:aca:a1d8:981f with SMTP id a640c23a62f3a-acb74ad8db9mr281400766b.12.1744987173126;
        Fri, 18 Apr 2025 07:39:33 -0700 (PDT)
Received: from systol.god.lan (157-21-254-92.ftth.glasoperator.nl. [92.254.21.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625834699sm1036328a12.54.2025.04.18.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 07:39:32 -0700 (PDT)
From: Henk Vergonet <henk.vergonet@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Henk Vergonet <henk.vergonet@gmail.com>
Subject: [PATCH v3] wifi: mt76x2: Add support for LiteOn WN4516R,WN4519R
Date: Fri, 18 Apr 2025 16:39:14 +0200
Message-ID: <20250418143914.31384-1-henk.vergonet@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <aAJfM0vB1X8UgmAM@lore-desk>
References: <aAJfM0vB1X8UgmAM@lore-desk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for:
 - LiteOn WN4516R
 - LiteOn WN4519R
 Both use:
 - A nonstandard USB connector
 - Mediatek chipset MT7600U
 - ASIC revision: 76320044

Disabled VHT support on ASIC revision 76320044:

 This fixes the 5G connectibity issue on LiteOn WN4519R module
 see https://github.com/openwrt/mt76/issues/971

 And may also fix the 5G issues on the XBox One Wireless Adapter
 see https://github.com/openwrt/mt76/issues/200

 I have looked at the FCC info related to the MT7632U chip as mentioned in here:
 https://github.com/openwrt/mt76/issues/459
 These confirm the chipset does not support 'ac' mode and hence VHT should be turned of.

Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c     |  2 ++
 .../net/wireless/mediatek/mt76/mt76x2/usb_init.c    | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 84ef80ab4afb..96cecc576a98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -17,6 +17,8 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
 	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
 	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
+	{ USB_DEVICE(0x0471, 0x2126) }, /* LiteOn WN4516R module, nonstandard USB connector */
+	{ USB_DEVICE(0x0471, 0x7600) }, /* LiteOn WN4519R module, nonstandard USB connector */
 	{ USB_DEVICE(0x2c4e, 0x0103) },	/* Mercury UD13 */
 	{ USB_DEVICE(0x0846, 0x9014) },	/* Netgear WNDA3100v3 */
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 33a14365ec9b..3b5562811511 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -191,6 +191,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt76_usb *usb = &dev->mt76.usb;
+	bool vht;
 	int err;
 
 	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
@@ -217,7 +218,17 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 
 	/* check hw sg support in order to enable AMSDU */
 	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
-	err = mt76_register_device(&dev->mt76, true, mt76x02_rates,
+	switch (dev->mt76.rev) {
+	case 0x76320044:
+		/* these ASIC revisions do not support VHT */
+		vht = false;
+		break;
+	default:
+		vht = true;
+		break;
+	}
+
+	err = mt76_register_device(&dev->mt76, vht, mt76x02_rates,
 				   ARRAY_SIZE(mt76x02_rates));
 	if (err)
 		goto fail;
-- 
2.45.2


