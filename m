Return-Path: <linux-wireless+bounces-23784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC566ACFB11
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 04:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531A31893C64
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 02:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C393A1DC98B;
	Fri,  6 Jun 2025 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="l3siJ+N2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896D1D5CE0
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175411; cv=none; b=Z9DqQBdjheUsOKfEiUx/It+NqDG76wjyNC3IEnlG3QdAYMnXuAv3HMK2GmOlmP1YT7yr895ZROL49q/wq3NW74XsINVyg3OgxQKq0L7v5jbUK1nj45A366XBmn2S2zjMKrQQXRqAWYcQ7/8C25kdQa8blm9Dbmntq2P+Ne6HtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175411; c=relaxed/simple;
	bh=pmysAxkIIMmQZ1epnx5TOemDs4IECIH5rQVyh3ehdaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bp+038Y8L+nZKzhxqukgB/69tCW1oPGGQfajsxuykcTCDKMFTsZIg8vffmqr3KXpC79VY6abMRta1fQHxJfd/tJiFkr/uDNaNCF+jvdHO0gtDkZzpeqDK2Nggiz0a3XQhskZBi7w+AYAqYIHJN4t65P2p2T09b3yIL5ZAoszTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=l3siJ+N2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55623QdP42620770, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749175407; bh=hC1RDPw9kQxdS2zQ346eMeJgcenteYWH0qWOiHwxg8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=l3siJ+N215cR3dBbzq+2p5lQWg22wc5PJ5Biz7jeZeyZcpL787f7GINLHK8vj8Tgj
	 sZTm1XKecKRbTJHqVf0I6EPeuwYRpaUC//OqhGF6SPmrd8kZvpj56v6JWygi6GfqoU
	 z1tHN6fumW8R9F35tPL9rg+ztUJefkxHXHB10e2iFlIWTNB9GCycNvlGLrj63hM4II
	 WQ3zpxkGdBXz3Vu1T8TooQ8OubO49sf6rOps/kgKUvb3AwJNlwN4+HTavjk067Ru7F
	 RGtSVqAbfZBeld78tZmPCCys/JxzwVDWPjdwS5ZY8EYuTKE8kPtYmHUWuFqQ7F2oEG
	 fvRwdE1QRQ47A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55623QdP42620770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 10:03:26 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Jun 2025 10:03:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Jun
 2025 10:03:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 2/6] wifi: rtw89: fw: add RFE type to RF TSSI H2C command
Date: Fri, 6 Jun 2025 10:02:58 +0800
Message-ID: <20250606020302.16873-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250606020302.16873-1-pkshih@realtek.com>
References: <20250606020302.16873-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Append a new field for RFE (RF Front End) type to RF TSSI H2C command.
FW has forward compatibility when handling this H2C command, so just
need to consider backward cases in FW point of view.

              | old FW | new FW
  ------------------------------
   old driver |    O   |    X
  ------------------------------
   new driver |    O   |    O

Currently only RTL8922A uses this RF TSSI H2C command. Increase its FW
format max and will let new FW binary align with it. Then, old driver
won't load new FW.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c       | 2 ++
 drivers/net/wireless/realtek/rtw89/fw.h       | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 36147040c35b..1d37ea7f1391 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6032,6 +6032,7 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			 const struct rtw89_chan *chan, enum rtw89_tssi_mode tssi_mode)
 {
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_h2c_rf_tssi *h2c;
 	u32 len = sizeof(*h2c);
@@ -6054,6 +6055,7 @@ int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	h2c->hwtx_en = true;
 	h2c->cv = hal->cv;
 	h2c->tssi_mode = tssi_mode;
+	h2c->rfe_type = efuse->rfe_type;
 
 	rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(rtwdev, phy_idx, chan, h2c);
 	rtw89_phy_rfk_tssi_fill_fwcmd_tmeter_tbl(rtwdev, phy_idx, chan, h2c);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 0fcc824e41be..2fc2d1d61e29 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4435,6 +4435,7 @@ struct rtw89_h2c_rf_tssi {
 	u8 pg_thermal[2];
 	u8 ftable[2][128];
 	u8 tssi_mode;
+	u8 rfe_type;
 } __packed;
 
 struct rtw89_h2c_rf_iqk {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 1d0f6e7df497..680168f31466 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -15,7 +15,7 @@
 #include "sar.h"
 #include "util.h"
 
-#define RTW8922A_FW_FORMAT_MAX 3
+#define RTW8922A_FW_FORMAT_MAX 4
 #define RTW8922A_FW_BASENAME "rtw89/rtw8922a_fw"
 #define RTW8922A_MODULE_FIRMWARE \
 	RTW8922A_FW_BASENAME "-" __stringify(RTW8922A_FW_FORMAT_MAX) ".bin"
-- 
2.25.1


