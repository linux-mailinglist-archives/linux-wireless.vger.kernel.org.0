Return-Path: <linux-wireless+bounces-9634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0FF919DA3
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 04:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E74B22211
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E858134D1;
	Thu, 27 Jun 2024 02:59:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6E13FF6
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457179; cv=none; b=jf2EFtGAr4TipOQIsEzIhvy6zopL7PXtVIIoAA2FbBT+Vl3vrvlw2weJOseWeMhDAUep8JlBl4oRBHEMis1gl21fuwvt8f1CHLVoaGQ7S5iyEyEnsD+Scp87zjlIAdfGCZjnK/uzjVtxn6c4FiP+FjJ4hb+rUM6g2RaDfnVLF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457179; c=relaxed/simple;
	bh=a638qQXRzKXiQ7W6xu9jltvnROy2sCxLakZKBJekvCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcyOg+ocX3M46nBhNitNEWcQUQ5mLlyJqztokB6ax+Q+SYSkcaIocWEKTfPZ06Nc+xmD/MnEWMHPguUf9llnnwEoUtvcjfFlDLXQ4/e+VLEysyYyJLj0lDSSy2A1Z/2d7m5zlc+8dakEagDUXmsva6AQBUG/nEPXjJWXNzjn2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45R2xZ4M12591148, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45R2xZ4M12591148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 10:59:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 10:59:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Jun
 2024 10:59:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: 8852bt: rfk: add RCK
Date: Thu, 27 Jun 2024 10:58:49 +0800
Message-ID: <20240627025849.25198-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627025849.25198-1-pkshih@realtek.com>
References: <20240627025849.25198-1-pkshih@realtek.com>
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

RCK is synchronize RC calibration. Driver triggers this calibration and
writes the result to registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 43 +++++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 6c2fecb58940..fa0e49d58112 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -407,6 +407,41 @@ static void _rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	}
 }
 
+static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	u32 rf_reg5;
+	u32 rck_val;
+	u32 val;
+	int ret;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RCK] ====== S%d RCK ======\n", path);
+
+	rf_reg5 = rtw89_read_rf(rtwdev, path, RR_RSV1, RFREG_MASK);
+
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RR_MOD_V_RX);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RCK] RF0x00 = 0x%05x\n",
+		    rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK));
+
+	/* RCK trigger */
+	rtw89_write_rf(rtwdev, path, RR_RCKC, RFREG_MASK, 0x00240);
+
+	ret = read_poll_timeout_atomic(rtw89_read_rf, val, val, 2, 30,
+				       false, rtwdev, path, RR_RCKS, BIT(3));
+
+	rck_val = rtw89_read_rf(rtwdev, path, RR_RCKC, RR_RCKC_CA);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RCK] rck_val = 0x%x, ret = %d\n",
+		    rck_val, ret);
+
+	rtw89_write_rf(rtwdev, path, RR_RCKC, RFREG_MASK, rck_val);
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RFREG_MASK, rf_reg5);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RCK] RF 0x1b = 0x%x\n",
+		    rtw89_read_rf(rtwdev, path, RR_RCKC, RFREG_MASK));
+}
+
 static void _drck(struct rtw89_dev *rtwdev)
 {
 	u32 rck_d;
@@ -3790,6 +3825,14 @@ void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev)
 	_set_dpd_backoff(rtwdev, RTW89_PHY_0);
 }
 
+void rtw8852bt_rck(struct rtw89_dev *rtwdev)
+{
+	u8 path;
+
+	for (path = 0; path < RF_PATH_NUM_8852BT; path++)
+		_rck(rtwdev, path);
+}
+
 void rtw8852bt_dack(struct rtw89_dev *rtwdev)
 {
 	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
index 772a5b099377..09918835c6e8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
@@ -7,6 +7,7 @@
 
 #include "core.h"
 
+void rtw8852bt_rck(struct rtw89_dev *rtwdev);
 void rtw8852bt_dack(struct rtw89_dev *rtwdev);
 void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852bt_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-- 
2.25.1


