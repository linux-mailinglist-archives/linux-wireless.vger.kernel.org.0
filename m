Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5067786
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 03:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfGMBcX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 21:32:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39930 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfGMBcX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 21:32:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so1064750pfn.6
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2019 18:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3jCSuFKL9j7VUBsAit4UFmDrhFwKOB0gVJMMTst91k=;
        b=N9Unm34NPvdfvrEU75paft9nyv4ecN710aQTcKKLJjjCk6R8m62VjbveIg1R+tWA2+
         cCU61WVicKKp17DB0CDzIE5CKWJKC9zK1peHjasai2xCdKxSEFtsQht/U/eaIAwMyG0q
         rFOGRkAspvfF/sVZsc1qQBVw5/W3u5czLF7J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3jCSuFKL9j7VUBsAit4UFmDrhFwKOB0gVJMMTst91k=;
        b=NJ8jWkHtZ5B3YMKxPKID8sVBNUoXdncIQGi2wJ4U5oGBaNAHU0T/c44o8/IFe9K4FY
         JevySYuKa1EIZ1wRg3SZW7Z6uNo4FxereuB+e1SZKfZNUDanTAFlOlOWNe7V8GcRYsdh
         HB6mziV5luku41UvpLCk8O4P8VTbOWbY84sfMD+gfUXsRiQ98mPWueHUfuFpplHAww1a
         79vHmsmhWk1x56MPKNNa1HkDJZ1KOqHXASaRNDhZqgeLUDV0yZL2JbMDTMuZd+lOXhbM
         oEiTYnDErJzWMn/WRaBIew79WLsT6MiGOBGlUDPNMwwcKRd0sglcw4u4JK8pnp9OZjoX
         Mu/w==
X-Gm-Message-State: APjAAAUlhmEV/HDkUQWo2jZeHWzQEYfJoJB5DYQIVuH5kfizg6H3AWKq
        NqvlzX8AnX4fwiugtkFryG3iGSu6BWY=
X-Google-Smtp-Source: APXvYqw3qK+6OhUeDnHd/u6kz/gMUXHw3C+Obvc0tZrL+8iJVy7bUKvMnAsFavMH21/tuBiiPQTUGA==
X-Received: by 2002:a63:394:: with SMTP id 142mr14482194pgd.43.1562981541946;
        Fri, 12 Jul 2019 18:32:21 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id h1sm13337438pfo.152.2019.07.12.18.32.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 18:32:20 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     <linux-wireless@vger.kernel.org>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] rtw88: make functions static
Date:   Fri, 12 Jul 2019 18:32:15 -0700
Message-Id: <20190713013215.215008-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

They're only used in phy.c.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 13 ++++++++++---
 drivers/net/wireless/realtek/rtw88/phy.h | 13 -------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 4ec8dcf17361..4bb36eba7080 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -140,7 +140,7 @@ void rtw_phy_init(struct rtw_dev *rtwdev)
 	dm_info->igi_history[0] = rtw_read32_mask(rtwdev, addr, mask);
 }
 
-void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
+static void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_hal *hal = &rtwdev->hal;
@@ -1603,8 +1603,15 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 	return (s8)rtwdev->chip->max_power_index;
 }
 
-void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate, u8 bw,
-			     u8 ch, u8 regd, struct rtw_power_params *pwr_param)
+struct rtw_power_params {
+	u8 pwr_base;
+	s8 pwr_offset;
+	s8 pwr_limit;
+};
+
+static void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate,
+				    u8 bw, u8 ch, u8 regd,
+				    struct rtw_power_params *pwr_param)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_txpwr_idx *pwr_idx;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index 7c8eb732b13c..0f90ea24c6d7 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -103,19 +103,6 @@ static inline int rtw_check_supported_rfe(struct rtw_dev *rtwdev)
 	return 0;
 }
 
-void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi);
-
-struct rtw_power_params {
-	u8 pwr_base;
-	s8 pwr_offset;
-	s8 pwr_limit;
-};
-
-void
-rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path,
-			u8 rate, u8 bw, u8 ch, u8 regd,
-			struct rtw_power_params *pwr_param);
-
 #define	MASKBYTE0		0xff
 #define	MASKBYTE1		0xff00
 #define	MASKBYTE2		0xff0000
-- 
2.22.0.510.g264f2c817a-goog

