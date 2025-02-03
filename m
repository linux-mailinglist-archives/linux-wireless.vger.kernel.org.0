Return-Path: <linux-wireless+bounces-18280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D9A25311
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 08:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0DD188438E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB0B1E7C06;
	Mon,  3 Feb 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="legtLZd5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913FC1E7C20
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738567797; cv=none; b=Ix00uknYdaaVDpvf/bP0BnhrJ0puf3OMtl4o0TAf91xRroO8vv8TkuAQcEDcDRog81DMq3DkTgk6yIICuZiTLu0NIbxJloBinQY2gHiWucoljJ/CiCv7dTZe9lWlGtJtOElVe/e3+x+5vHnzFmh211JIgwETYFBloNx6/oNFbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738567797; c=relaxed/simple;
	bh=1y35sW3X1LMncpTXvRTBIF0k7f+HOQtZTOjgsc/VmiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMOj9OYVOOWQdg/xe7ygV48b1UgN/xILNJtcJWQG99ZLT3BF+Uw1pqbc2tOPQ15izRhW5S1WF0C5maB01Ccc/XaQFXNMxFK08t+ay1CwgoTb22O6DCr5uEEdZ0ilhS/BHb+wEmBQiHp9mzKG4O0iP1EcH55Q1fnz7O7QF/mfW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=legtLZd5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5137TolY61321531, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738567790; bh=1y35sW3X1LMncpTXvRTBIF0k7f+HOQtZTOjgsc/VmiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=legtLZd5G/JzHym0jJJXmJSkL9qlHHNZRpG7Dh31QkhfQRXh7Iwe4j/JMBdpkk2yP
	 SGu/2a/Y/RwcQ4gcyow9SUmLd1TlS5ESbF1CfU3emvvGwsifhUybxIoWFAfPdsHF/j
	 rqBecUNapdq5KlPmfnwiLNbUc1Zm5BakuRwVhr1QLW3QDR0vVpQc8aSihRILYU1vmi
	 0iq6oo0QMlklcxJSZYXYxfenug8Iv1efRaD/XdIQxTSLUicBok5cfQms3VbmBejsnT
	 tL2kBOC392VjIPCvuY54ggOc3s+CxBOmKzgM1j1K4QJrkWcFWqr0TSZH7fTugn6+I1
	 zba4eSoVua8EQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5137TolY61321531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 15:29:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 15:29:50 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 15:29:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>
Subject: [PATCH 1/4] wifi: rtw89: call power_on ahead before selecting firmware
Date: Mon, 3 Feb 2025 15:29:08 +0800
Message-ID: <20250203072911.47313-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203072911.47313-1-pkshih@realtek.com>
References: <20250203072911.47313-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Driver selects firmware by hardware version, which normally can be read
from registers before selecting firmware. However, certain chips such as
RTL8851B, it needs to read hardware version from efuse while doing
power_on, but do power_on after selecting firmware in current flow.

To resolve this flow problem, move power_on out from
rtw89_mac_partial_init(), and call rtw89_mac_pwr_on() separately at
proper places to have expected flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 23 +++++++++++-------
 drivers/net/wireless/realtek/rtw89/mac.c  | 29 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/mac.h  |  1 +
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index da41a417dd7d..ad28f11f2d24 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5040,8 +5040,6 @@ static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 
 	rtw89_hci_mac_pre_deinit(rtwdev);
 
-	rtw89_mac_pwr_off(rtwdev);
-
 	return 0;
 }
 
@@ -5122,36 +5120,45 @@ int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 
 	rtw89_read_chip_ver(rtwdev);
 
+	ret = rtw89_mac_pwr_on(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to power on\n");
+		return ret;
+	}
+
 	ret = rtw89_wait_firmware_completion(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to wait firmware completion\n");
-		return ret;
+		goto out;
 	}
 
 	ret = rtw89_fw_recognize(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to recognize firmware\n");
-		return ret;
+		goto out;
 	}
 
 	ret = rtw89_chip_efuse_info_setup(rtwdev);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = rtw89_fw_recognize_elements(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to recognize firmware elements\n");
-		return ret;
+		goto out;
 	}
 
 	ret = rtw89_chip_board_info_setup(rtwdev);
 	if (ret)
-		return ret;
+		goto out;
 
 	rtw89_core_setup_rfe_parms(rtwdev);
 	rtwdev->ps_mode = rtw89_update_ps_mode(rtwdev);
 
-	return 0;
+out:
+	rtw89_mac_pwr_off(rtwdev);
+
+	return ret;
 }
 EXPORT_SYMBOL(rtw89_chip_info_setup);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f698807790ff..3f38f8ed6876 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1495,6 +1495,21 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 #undef PWR_ACT
 }
 
+int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = rtw89_mac_power_switch(rtwdev, true);
+	if (ret) {
+		rtw89_mac_power_switch(rtwdev, false);
+		ret = rtw89_mac_power_switch(rtwdev, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev)
 {
 	rtw89_mac_power_switch(rtwdev, false);
@@ -3996,14 +4011,6 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
 {
 	int ret;
 
-	ret = rtw89_mac_power_switch(rtwdev, true);
-	if (ret) {
-		rtw89_mac_power_switch(rtwdev, false);
-		ret = rtw89_mac_power_switch(rtwdev, true);
-		if (ret)
-			return ret;
-	}
-
 	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
 
 	if (include_bb) {
@@ -4036,6 +4043,10 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 	bool include_bb = !!chip->bbmcu_nr;
 	int ret;
 
+	ret = rtw89_mac_pwr_on(rtwdev);
+	if (ret)
+		return ret;
+
 	ret = rtw89_mac_partial_init(rtwdev, include_bb);
 	if (ret)
 		goto fail;
@@ -4067,7 +4078,7 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 
 	return ret;
 fail:
-	rtw89_mac_power_switch(rtwdev, false);
+	rtw89_mac_pwr_off(rtwdev);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8edea96d037f..6389f54264e5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1145,6 +1145,7 @@ rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 	rtw89_write32_set(rtwdev, reg, bit);
 }
 
+int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev);
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev);
 int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb);
 int rtw89_mac_init(struct rtw89_dev *rtwdev);
-- 
2.25.1


