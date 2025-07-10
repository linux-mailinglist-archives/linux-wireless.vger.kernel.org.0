Return-Path: <linux-wireless+bounces-25232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1088CB00EB3
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 00:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F000B1CA5EBA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADD329553A;
	Thu, 10 Jul 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtJ2T3SD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83632356D2;
	Thu, 10 Jul 2025 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186440; cv=none; b=qxkn/8uNWfnSsaNy5sUm+3BZNoyOLGXfl8vXByBKtTyuq3yv5wLtRtEqdu82D+dcmOj1nLS7bdIB99JrvhgTERMiBk+lv4EPCMon3cNppMgu1slqUlTZI6RJRf+cpdvjiUajD6XW3iKN6QzKjbPj6ZQYTTm8DvTSMi4cynBdnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186440; c=relaxed/simple;
	bh=r6AdqWtTZ2qnLGxwc0fREO+bWIguuCNKLNLLO5wOBrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ptq3+YwWTKT2w3jpPDVgS7wv5r+def08D4QAmTMqEdqLtpgDzF8cAYyZFaWfzm3KmC3egiMqJCb+Pph1Zd+sLVmvn5Z8SidposjEIoUFwl/MZ7zCU2RSr/pKpRMoymgmtxp9w2G707RHx/bM7WtREG1ASTJ4OOg4+GX+hbVT+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtJ2T3SD; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553b6a349ccso1894295e87.0;
        Thu, 10 Jul 2025 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752186437; x=1752791237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdOorZZQI0kjfbKyIxKzRDTltldkWiCtUhipeBKmQH4=;
        b=jtJ2T3SDgPPi7WHdQ0YQyLQNyh8yXsGU47IHjYf4JMjbVnkknkPKSNKZBGCcOjrizQ
         o1YJGgI4Se+uFnU9eDimNuOQSepjpLkmP09bMBNKQ6BgN6k8buW5zwMN6IEyegCwdbMi
         D4sRiIv5fyVT+4dN8Rn+ZTO8gIh1AGRxXg3gDZKrPTKHrAUppY6HFC0eA0aVRtZD/BEN
         w7hfKmsN2fZFQ1byU0X9DIEUgx2cw7ykATJbXwrvZz3AWvtRdRc2ZQoSgZ3xL/5qqmoI
         pIqiV71fC+LMhoxhnTV4WiC0FGLY1DYO+3oUA9GFaX2Hb7pAyiBsSK+IH0SkIKScXsib
         BTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752186437; x=1752791237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdOorZZQI0kjfbKyIxKzRDTltldkWiCtUhipeBKmQH4=;
        b=cNRi1oQICotcXl4YoUgPh5MChZTxZv2xNFD54uV+NHa7L2Rh723Qx8hXGugsUChYLl
         IyjyWGwWiVGqWPYK9pQX7rxVU6dxVACoE0It19FZJAnkYyZts4CVoe8xPEO7lZT332Tk
         LK75x56Y+kyFIYhjKWAo/nffjneU4Yz6Ux0QxqqV35RMvhxKsii8slwYiKj3/O2PgbDu
         xcAkZE8ErhASF1UByM85Nl+Y/XOSNToSahQU60BJydJLZytI8twJeU7VxpZ5vdt+Ewyy
         0pO5K47iictfl+5LskygeqaOCsc/UDAtZfCkmzFKbLqkbSoHULtjIAv1MNqVfYLDPqKo
         s5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUDVM7u3+0whksrxG/tqPzDdMTOb91+JKL1K/X8esdzFa7kHdE3gxysdDAXRzami6xlSjAZlMuY90OpWfDLn5s=@vger.kernel.org, AJvYcCWCiTuRhvQGJ0BZMHXTztscX0RVr/nB0WQBUIneSidgMf7qV4FdT6U1jxa8CHvuPSpz4VRQKzo55vSRcPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdN1+gTGCJhVoP8OCCuqnH6xnsb/j36pQ7Ykkp7EjIjjjQxPIf
	ce95ODP4Q2tLB1rYDtRNyMK1cnH8GU+OeQRDiYtr03KOy3FWCGBx0nMy
X-Gm-Gg: ASbGncvFCt/eQhr7k71bK3e2I4v3a4u3kts5naYgDmkSsSjfdh6b1YWMCOshVJXnKEt
	8OHrLyMvxMPk1CEv9JwZpyeMuvkwcESpmnitCocQ9+/Bz9U+HISoBLZjj61uacdnvmu3aECBVCY
	52ssWKaKeVPhCv07jMO/9Ou9smB1+DNFfxgtVLvORg5WOIoPmuXLSsbAQ8XWQB2sgx6UOglyNac
	9oG1bvKtmiJqI6E9GbCX2qLtsXwwrYGpFBMDED+KXkDSoTGFNC+eahJIYsrtMDjnSMgjJe3VyRY
	E8CIPAS8NkamPN6tPyXV4NBoXuo4Fy9X2hay+rKGSC9RPSirfQ26I90RJrrz/Oy3BDQ7Tvr9leN
	VTrJS7wfpkp8gi3r9b1DZsS10JAx44ZIa/huGICbQhw==
X-Google-Smtp-Source: AGHT+IFTwn7ACh8f7l1zf2MJivnfwnB47P12H0Fe5cLNXrlume4FYdyhVAK2X3x8+ydBmVXcapXkrw==
X-Received: by 2002:ac2:4bce:0:b0:553:518d:8494 with SMTP id 2adb3069b0e04-55a04634ca5mr153324e87.54.1752186436472;
        Thu, 10 Jul 2025 15:27:16 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d0f2asm511052e87.131.2025.07.10.15.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:27:15 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Fiona Klute <fiona.klute@gmx.de>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v3] wifi: rtw88: enable TX reports for the management queue
Date: Fri, 11 Jul 2025 01:24:32 +0300
Message-ID: <20250710222432.3088622-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.47.2
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
from mac table later.

Tables with register values for phy parameters initialization are
copied from vendor driver usually. When table will be regenerated,
manual modifications to it may be lost. To avoid regressions in this
case new callback mac_postinit is introduced, that is called after
parameters from table are set.

Tested on rtl8723cs, that reuses rtw8703b driver.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---

Changes in v2:
 - introduce mac_postinit callback to avoid changing register tables

Changes in v3:
 - merge two patches back together
 - remove unused initialization in rtw_mac_postinit
 - init unused .mac_postinit fields in drivers with NULL

 drivers/net/wireless/realtek/rtw88/mac.c      | 11 +++++++++++
 drivers/net/wireless/realtek/rtw88/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw88/main.c     |  6 ++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |  9 ++++++++-
 drivers/net/wireless/realtek/rtw88/rtw8723x.h |  6 ++++++
 drivers/net/wireless/realtek/rtw88/rtw8812a.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8814a.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 14 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 011b81c82f3ba..e1ec9aa401fa0 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1409,3 +1409,14 @@ int rtw_mac_init(struct rtw_dev *rtwdev)
 
 	return 0;
 }
+
+int rtw_mac_postinit(struct rtw_dev *rtwdev)
+{
+	const struct rtw_chip_info *chip = rtwdev->chip;
+	int ret;
+
+	if (chip->ops->mac_postinit)
+		ret = chip->ops->mac_postinit(rtwdev);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wireless/realtek/rtw88/mac.h
index e92b1483728d5..b73af90ee1d7f 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -38,6 +38,7 @@ void rtw_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
 			     const u8 *data, u32 size);
 int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw);
 int rtw_mac_init(struct rtw_dev *rtwdev);
+int rtw_mac_postinit(struct rtw_dev *rtwdev);
 void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop);
 int rtw_set_trx_fifo_info(struct rtw_dev *rtwdev);
 int rtw_ddma_to_fw_fifo(struct rtw_dev *rtwdev, u32 ocp_src, u32 size);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 97756bdf57b27..b706c5a21a6c5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1412,6 +1412,12 @@ int rtw_power_on(struct rtw_dev *rtwdev)
 
 	chip->ops->phy_set_param(rtwdev);
 
+	ret = rtw_mac_postinit(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to configure mac in postinit\n");
+		goto err_off;
+	}
+
 	ret = rtw_hci_start(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to start hci\n");
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b42538cce3598..43ed6d6b42919 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -858,6 +858,7 @@ struct rtw_chip_ops {
 	int (*power_on)(struct rtw_dev *rtwdev);
 	void (*power_off)(struct rtw_dev *rtwdev);
 	int (*mac_init)(struct rtw_dev *rtwdev);
+	int (*mac_postinit)(struct rtw_dev *rtwdev);
 	int (*dump_fw_crash)(struct rtw_dev *rtwdev);
 	void (*shutdown)(struct rtw_dev *rtwdev);
 	int (*read_efuse)(struct rtw_dev *rtwdev, u8 *map);
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
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812a.c b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
index 03b441639611f..2078eb6e36280 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -919,6 +919,7 @@ static const struct rtw_chip_ops rtw8812a_ops = {
 	.query_phy_status	= rtw8812a_query_phy_status,
 	.set_channel		= rtw88xxa_set_channel,
 	.mac_init		= NULL,
+	.mac_postinit		= NULL,
 	.read_rf		= rtw88xxa_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_antenna		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814a.c b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
index 4a1f850d05c87..ca1079e120235 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8814a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
@@ -2055,6 +2055,7 @@ static const struct rtw_chip_ops rtw8814a_ops = {
 	.query_phy_status	= rtw8814a_query_phy_status,
 	.set_channel		= rtw8814a_set_channel,
 	.mac_init		= rtw8814a_mac_init,
+	.mac_postinit		= NULL,
 	.read_rf		= rtw_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_tx_power_index	= rtw8814a_set_tx_power_index,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index 1d02ea400b2e6..414b77eef07c6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -865,6 +865,7 @@ static const struct rtw_chip_ops rtw8821a_ops = {
 	.query_phy_status	= rtw8821a_query_phy_status,
 	.set_channel		= rtw88xxa_set_channel,
 	.mac_init		= NULL,
+	.mac_postinit		= NULL,
 	.read_rf		= rtw88xxa_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_antenna		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index a2a358d6033f6..2078b067562e7 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1663,6 +1663,7 @@ static const struct rtw_chip_ops rtw8821c_ops = {
 	.query_phy_status	= query_phy_status,
 	.set_channel		= rtw8821c_set_channel,
 	.mac_init		= rtw8821c_mac_init,
+	.mac_postinit		= NULL,
 	.read_rf		= rtw_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_antenna		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index bb5c41905afe1..89b6485b229a8 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2154,6 +2154,7 @@ static const struct rtw_chip_ops rtw8822b_ops = {
 	.query_phy_status	= query_phy_status,
 	.set_channel		= rtw8822b_set_channel,
 	.mac_init		= rtw8822b_mac_init,
+	.mac_postinit		= NULL,
 	.read_rf		= rtw_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_tx_power_index	= rtw8822b_set_tx_power_index,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 58c1958e6170d..28c121cf1e683 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4964,6 +4964,7 @@ static const struct rtw_chip_ops rtw8822c_ops = {
 	.query_phy_status	= query_phy_status,
 	.set_channel		= rtw8822c_set_channel,
 	.mac_init		= rtw8822c_mac_init,
+	.mac_postinit		= NULL,
 	.dump_fw_crash		= rtw8822c_dump_fw_crash,
 	.read_rf		= rtw_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_mix,
-- 
2.47.2


