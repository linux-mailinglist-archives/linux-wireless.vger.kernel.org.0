Return-Path: <linux-wireless+bounces-28884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17168C557C8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162843ABF8F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E81B246333;
	Thu, 13 Nov 2025 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Rr8uT1Ct"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC6253B73
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002635; cv=none; b=YpJa9a7267GSYRxNNFiL4CbeSZuiH6gSqqy3DIw/w7/TwnKFDffWBhqxZ10KdGN/HEkNpUzZtqRSXNZS9kHnwBCPnva5Ov8jS+jKUPeE+CixX3SWVsNGkTHf1NFa/Abx22AD7DkirH+2lJHof0+aRPKdtUvw88uA2xFwS+V01B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002635; c=relaxed/simple;
	bh=olbqZCL1Ddo9Li6pM3L3/ebH6j2ffXVnoobnAjDM9Ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cG9Ly1J9/RHgzGDHictsZuGnqrN09LrStb9inaS3aIGz4Ncz6pQ1WDrAgniP2OezmkV7mcCpx5QDxqt4e6zASQWtJxhdEKHfc+IELXi4NwrKIZXW6BcRodv5NmDhp9EqjvVHijb+/Z7HZJLEwXTfeOIH76tQ7kFOwo7MkM1NV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Rr8uT1Ct; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD2vApgD2839372, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763002631; bh=JiQXJQZsspM9qON7YN6tNLoyeG7uFywMp2rgvf4Gyjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Rr8uT1CtlS7iuL0TjX+WmMQVYA15ysAcIgJf8pkhPIGktoDlyFr/jDWAPbImN9OBN
	 UrTyRNQgb804D0BDi/EGd9N3Bhq1Jy17aD6OXbfdEGVJ7UO2gdNx3DmxX4ple0L374
	 dLsFJ4bLKP1t8iUEyL4bS+dapRQpG7jnSd0cYaP4BLlJw7MWhB0PCJWn1W2CCfs3k3
	 4njIkrQoNOEqq4sLxXhu0jbt23QlZw2C/DlCGeIHYgu4jHngDVtK1t2yKFnCClTIqB
	 OW+qAOOu1fU7f2vAL/DWSd34Y20gj19YqRARdxjpwaFQJqmPbOQo44vFnepLSL9UgR
	 iWw31+ryfR5MQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD2vApgD2839372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:57:11 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:11 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 10:57:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH rtw-next 03/14] wifi: rtw89: mac: separate pre-init code before downloading firmware
Date: Thu, 13 Nov 2025 10:56:09 +0800
Message-ID: <20251113025620.31086-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113025620.31086-1-pkshih@realtek.com>
References: <20251113025620.31086-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Driver needs to initialize registers before downloading firmware, so
move pre-init part (power on) from original rtw89_mac_init(). The
consequence patches will add more pre-init codes before downloading
firmware.

Since rtw89_phy_init_bb_afe() is used by coming RTL8922D, don't change
logic at all for existing chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  8 ++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 15 +++++++++++----
 drivers/net/wireless/realtek/rtw89/mac.h  |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a15a911484bb..0cabea7dd92b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5617,8 +5617,16 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 {
 	int ret;
 
+	ret = rtw89_mac_preinit(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "mac preinit fail, ret: %d\n", ret);
+		return ret;
+	}
+
 	rtw89_phy_init_bb_afe(rtwdev);
 
+	/* above do preinit before downloading firmware */
+
 	ret = rtw89_mac_init(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "mac init fail, ret:%d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index dab0a76556c9..ff160d25a7c9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4126,17 +4126,24 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
 	return 0;
 }
 
-int rtw89_mac_init(struct rtw89_dev *rtwdev)
+int rtw89_mac_preinit(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-	bool include_bb = !!chip->bbmcu_nr;
 	int ret;
 
 	ret = rtw89_mac_pwr_on(rtwdev);
 	if (ret)
 		return ret;
 
+	return 0;
+}
+
+int rtw89_mac_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool include_bb = !!chip->bbmcu_nr;
+	int ret;
+
 	ret = rtw89_mac_partial_init(rtwdev, include_bb);
 	if (ret)
 		goto fail;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 3cc97fd0c0ec..d203db444a34 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1201,6 +1201,7 @@ rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev);
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev);
 int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb);
+int rtw89_mac_preinit(struct rtw89_dev *rtwdev);
 int rtw89_mac_init(struct rtw89_dev *rtwdev);
 int rtw89_mac_dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 		       enum rtw89_qta_mode ext_mode);
-- 
2.25.1


