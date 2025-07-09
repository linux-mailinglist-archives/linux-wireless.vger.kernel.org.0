Return-Path: <linux-wireless+bounces-25144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8BAFF4CE
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 00:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345B1588594
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A68825C82E;
	Wed,  9 Jul 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDjflDin"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7E258CF2;
	Wed,  9 Jul 2025 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100562; cv=none; b=ruZMEU0hDYsnVHps/ZjmtlXDZkUdiwC96vvQjJwghXRvdYMc6XHC/N7RWyrHEeMhdfJSRWzxaorKfsI8fYpKv9y638Pxh5PUCdBxNHkeIjmH55FVC1iQHb+DbovyYebvkj2vsWt6m9t3ddIsweOJz1sBhkB4ffhREh8pDhh1hmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100562; c=relaxed/simple;
	bh=cudM931q96Enm/V/abm5Y7W00+CM/ur/OOjYNcCoXqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnZ30Zeon11J32/BE+7a7KEaGqyhWfg1hrlNTR4aBF0p5tcKMLsmJvHbi6jeBp1QBsxtlwwKEigiXEjdzymfAaP5ZWhiQHERBNdmKWWCwqArgRdhlyzCMO9DsvTwR9L+gnXnz0kY7MrmvI4kpu43LfQ3fmDgh18pPORY9S/zITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDjflDin; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so409310e87.0;
        Wed, 09 Jul 2025 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752100558; x=1752705358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sF2pH7vg7mkam0Ppnm/J2rn06QMb7fY+GacdRu7g/8=;
        b=TDjflDinZgTn2RX1zE64yVKZfXWsgOFPHpaKPeasNMxQDu//pNPWGHFi4YVmnWPu7i
         NpKkxNlfkIJx1NlowbSblB8uGjjo8FR6+Q7L7Hpnv8W4WvfiFefSoqD79SqTiq+pU9Am
         VSMOInGbYEb06y9s1leKg6gUGC/0DAxj6DDmMJiqN+CgXGSqPgTTvFpU5zrNT+uqleh7
         PjVZluT2MxhusCLAeGGbYGAt7fN1k14fLOgQ505vbWYjWCuk4gksrdtSL+7y86542MFV
         bXRJMnjS24tGHvbTRD4ji00Fh69LGyfa0Nc/1/QUqkg6MdYSzy19i9nw2TXhzpn/8xor
         5dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752100558; x=1752705358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sF2pH7vg7mkam0Ppnm/J2rn06QMb7fY+GacdRu7g/8=;
        b=gQ5Xff+zO+9OsK8Zzoe3po7WCao3TNAc4xnK33S0yRfL9Osgg8aj3ev01P0NpTxLwJ
         Lb+6wloDcaZl3JauLrJ+i1sQdNRHoxexsMk6qtO8x2z2VAxhU8v5k+wfi2j6W3t0z0w1
         +oN+RN3+T2AYHlgahj0noks7zuyF1gaU6gnlHl1hdJf7dQ61WkvU3uTccawJ3YXwkKND
         cZI6eVCZ6RXkURYYbcoSRnrNPcfdB6C526MahdUqV1tmo8bYMR+xRhO8TKkYhjUVmbLP
         46eGnmnxKPKKw6NzRox/22+5xGVf5fQORvkcKMHw3vSTXClvKl6eddjBWR7vARCxnNbM
         X6Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUFKMluI2VOk44Yb4MVYT7Ugb8kB1VjPBksjbGYXoDQeLmoHxwOU9kxhyG+BY3Y3gbYvGQRmTLAeH27uIKJA50=@vger.kernel.org, AJvYcCX/HgZeyWO8/T1QOmUY5vEwcGRPRouQKw7uttKJPftQju4vxu8bsoKLlP8R/3pyXTHaUNnRvnOLZZSjlLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbigpNICnE/8GyMKw25u36mYB3OuY/LPO7gbOrj2Ii3H5qj2ag
	AWwfGwPRir93afZXzmQlSv56aM1N0UqkgLYjvJUBGeWj6SH6wtOVz8fv
X-Gm-Gg: ASbGncuO/2GzgZTExLzCSgvyednCK7hcPCq946DiJOCdkFE803RrxnqFLZaV8n6Dywo
	t3mpEw+KZvCVhJkH9rfYBrFQFoUCHiU6rF8GXXC9q/NVWwgs35YGAVE3rmyALimL81LpnAdyVCo
	JpW4RK2jll8KEbbT7b922KzwVVtfIhfeZzrxtjLuVTLgCccBTF/yBbyOEcIA6CiBSI7CQPcSd/D
	xQ7q8hPhtErCkwVlLFTCnX50H9DHpemrKx5HZHEhWA9uFdpymmc7klPXcej9CydgBUSfnkIGYHf
	cJ0in68TppcbfS0sJkzTX1MBE8Ny19KomlwMGkcSyfcpdiMWpyA5o5h51hxL9D0uWFYCLqMIzVn
	Rztc7H+Q=
X-Google-Smtp-Source: AGHT+IGdavaqdnmk/dYZImRnU7cuatf8trGDKnz1v5IfVvrEBFdhGrnmBRxNK6gbLzUFddF+osb4tw==
X-Received: by 2002:a05:6512:6ce:b0:553:35f5:7aac with SMTP id 2adb3069b0e04-559000c4384mr403655e87.48.1752100557858;
        Wed, 09 Jul 2025 15:35:57 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b74335sm54149e87.215.2025.07.09.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:35:57 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Fiona Klute <fiona.klute@gmx.de>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2 2/2] wifi: rtw88: enable TX reports for the management queue
Date: Thu, 10 Jul 2025 01:31:59 +0300
Message-ID: <20250709223159.2787192-3-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709223159.2787192-1-andrej.skvortzov@gmail.com>
References: <20250709223159.2787192-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed for AP mode. Otherwise client sees the network, but
can't connect to it.

REG_FWHW_TXQ_CTRL+1 is set to WLAN_TXQ_RPT_EN (0x1F) in common mac
init function (__rtw8723x_mac_init), but the value was overwritten
from mac table later. mac_postinit is run after registers from mac
table are set, this allows to set correct values.

Tested on rtl8723cs, that reuses rtw8703b driver.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723x.c | 9 ++++++++-
 drivers/net/wireless/realtek/rtw88/rtw8723x.h | 6 ++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 03475af973b52..821c28d9cb5d4 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1832,6 +1832,7 @@ static const struct rtw_chip_ops rtw8703b_ops = {
 	.power_on		= rtw_power_on,
 	.power_off		= rtw_power_off,
 	.mac_init		= rtw8723x_mac_init,
+	.mac_postinit		= rtw8723x_mac_postinit,
 	.dump_fw_crash		= NULL,
 	.shutdown		= NULL,
 	.read_efuse		= rtw8703b_read_efuse,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index bf69f5b06ce26..8715e0435f173 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1397,6 +1397,7 @@ static const struct rtw_chip_ops rtw8723d_ops = {
 	.query_phy_status	= query_phy_status,
 	.set_channel		= rtw8723d_set_channel,
 	.mac_init		= rtw8723x_mac_init,
+	.mac_postinit		= rtw8723x_mac_postinit,
 	.shutdown		= rtw8723d_shutdown,
 	.read_rf		= rtw_phy_read_rf_sipi,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
index 4c77963fdd370..3f3e9b0c44e80 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
@@ -353,7 +353,6 @@ static int __rtw8723x_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 
 static int __rtw8723x_mac_init(struct rtw_dev *rtwdev)
 {
-	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 1, WLAN_TXQ_RPT_EN);
 	rtw_write32(rtwdev, REG_TCR, BIT_TCR_CFG);
 
 	rtw_write16(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
@@ -370,6 +369,13 @@ static int __rtw8723x_mac_init(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static int __rtw8723x_mac_postinit(struct rtw_dev *rtwdev)
+{
+	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 1, WLAN_TXQ_RPT_EN);
+
+	return 0;
+}
+
 static void __rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 {
 	u8 ldo_pwr;
@@ -760,6 +766,7 @@ const struct rtw8723x_common rtw8723x_common = {
 	.lck = __rtw8723x_lck,
 	.read_efuse = __rtw8723x_read_efuse,
 	.mac_init = __rtw8723x_mac_init,
+	.mac_postinit = __rtw8723x_mac_postinit,
 	.cfg_ldo25 = __rtw8723x_cfg_ldo25,
 	.set_tx_power_index = __rtw8723x_set_tx_power_index,
 	.efuse_grant = __rtw8723x_efuse_grant,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.h b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
index a99af527c92cf..0fc70dfdfc8b2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723x.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
@@ -137,6 +137,7 @@ struct rtw8723x_common {
 	void (*lck)(struct rtw_dev *rtwdev);
 	int (*read_efuse)(struct rtw_dev *rtwdev, u8 *log_map);
 	int (*mac_init)(struct rtw_dev *rtwdev);
+	int (*mac_postinit)(struct rtw_dev *rtwdev);
 	void (*cfg_ldo25)(struct rtw_dev *rtwdev, bool enable);
 	void (*set_tx_power_index)(struct rtw_dev *rtwdev);
 	void (*efuse_grant)(struct rtw_dev *rtwdev, bool on);
@@ -383,6 +384,11 @@ static inline int rtw8723x_mac_init(struct rtw_dev *rtwdev)
 	return rtw8723x_common.mac_init(rtwdev);
 }
 
+static inline int rtw8723x_mac_postinit(struct rtw_dev *rtwdev)
+{
+	return rtw8723x_common.mac_postinit(rtwdev);
+}
+
 static inline void rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 {
 	rtw8723x_common.cfg_ldo25(rtwdev, enable);
-- 
2.47.2


