Return-Path: <linux-wireless+bounces-30155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C11BCE5C76
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 923A33006A48
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F5224F3;
	Mon, 29 Dec 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jzFUoPgK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30371FBEB0
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977828; cv=none; b=Z13eUWSyA/YwJw3IvOEg+AfAPEdOi0qBXaH5RuwNpLjC3Kq6/Sf0NAP1duaFAnchTbDsap8ujO0eNv474UB4POa0a7XIXMPj0uNOKIrc/gG8aA1358tZQyXx/0sT/GFm20btnWgTbNFtWTNNvMVG7NQ/65huNCq1/VOyLiuTZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977828; c=relaxed/simple;
	bh=Du9nI3oGWjhKXzeg9wxBLsYo56QhZR6FtTCX7jHoqak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KK519PO2xaiVvZSKYaPCtfTiZK725BbdSA9sgHmgO4jsfVpaaY5rGnpIjEFQV/5UK3fk8jk6K4Fbat9loGG423rsJcbcc3D31pJX1gwjj6qO+8bfNIvRumIE/jfglzGqZcvQGrX4FQ95zTT0KyhujTZLDv0hDbyjwrISxGJMIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jzFUoPgK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BT3AOVf8282914, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766977824; bh=mlfO4EUl7OToUthO19VkQNvj9TxXVMCBBy95yd/PjNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jzFUoPgKu8EqAsoVpLU0gm2ESAMdw2S1yCgSosVE2TNVXekK0jHNc3qJzeH63YFNA
	 ++DGFsIelbuwQ7gkkOWI/QSaD8gzVvm4hvUVCI9vnXT25NgvQ2Gwnrh+tDcQoLGKC+
	 gWGIdrV1zC8Iphe3w0O7OYPV/8TqEUQhyto/2AiFpaMXWKqHCQLty0vnOhRtKeWk0d
	 N+ajuwO5JTeF++vFQu6JbogS19Jg1SDVwjettNoK4x84i60k4fvKzKeqwQcW91xb9b
	 1YDNlbAxyJUOMVu7m4ZegASd+RJ/wBq8wcostLmVEScEyS16nMNgrBimyve4kGgHm/
	 6MIWuswc4lUKQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BT3AOVf8282914
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 11:10:24 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:24 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 29 Dec 2025 11:10:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 08/12] wifi: rtw89: add default quirks as features to chip_info
Date: Mon, 29 Dec 2025 11:09:22 +0800
Message-ID: <20251229030926.27004-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229030926.27004-1-pkshih@realtek.com>
References: <20251229030926.27004-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The coming chip will support thermal protection by default, so add default
quirks to chip_info.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c      | 3 +++
 drivers/net/wireless/realtek/rtw89/core.h      | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 1 +
 8 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 78cbfd6677e1..e713422ebd7c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5924,6 +5924,9 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	u8 band;
 
+	bitmap_or(rtwdev->quirks, rtwdev->quirks, &rtwdev->chip->default_quirks,
+		  NUM_OF_RTW89_QUIRKS);
+
 	INIT_LIST_HEAD(&rtwdev->ba_list);
 	INIT_LIST_HEAD(&rtwdev->forbid_ba_list);
 	INIT_LIST_HEAD(&rtwdev->rtwvifs_list);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6e39894990bf..93b633d39e47 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4559,6 +4559,7 @@ struct rtw89_chip_info {
 	const struct rtw89_edcca_regs *edcca_regs;
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const struct rtw89_xtal_info *xtal_info;
+	unsigned long default_quirks; /* bitmap of rtw89_quirks */
 };
 
 struct rtw89_chip_variant {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index e3933946d1ca..e06e70751735 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2715,6 +2715,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8851b,
 #endif
 	.xtal_info		= &rtw8851b_xtal_info,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8851b_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 46f5e9c50222..bb12982afef7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2400,6 +2400,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8852a,
 #endif
 	.xtal_info		= &rtw8852a_xtal_info,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index f813ec9242eb..0f18555e619b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1029,6 +1029,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8852b,
 #endif
 	.xtal_info		= NULL,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8852b_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 534ac137b43f..7b637483e9b4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -886,6 +886,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8852bt,
 #endif
 	.xtal_info		= NULL,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8852bt_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index c20c732d2f6a..a82bbe3ec901 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3245,6 +3245,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8852c,
 #endif
 	.xtal_info		= NULL,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 795c00d65d5e..041ffec9a327 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -3011,6 +3011,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8922a,
 #endif
 	.xtal_info		= NULL,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8922a_chip_info);
 
-- 
2.25.1


