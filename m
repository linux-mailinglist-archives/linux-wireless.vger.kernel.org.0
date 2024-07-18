Return-Path: <linux-wireless+bounces-10329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493F934683
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 04:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14904B21E5B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 02:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BEB30358;
	Thu, 18 Jul 2024 02:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FslFvXIW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4E2E62D
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721271161; cv=none; b=oRzSBnB+M3x0ulYjwuX4GMbibC4RFVq2NWc9Hpt/i76dadWNQdYQ2EJDC5ULl3POTvbxS0p6o620ZBt8sqBQO+WUpqd07Dc5IZnkZBRZxD9KcTpYGXXndUgdOHYqfrUS80ytCbiDKtllA4ih0rcDS0UM0cLaH2fjsJEwUaFFAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721271161; c=relaxed/simple;
	bh=wXpk51tnSa2+9gxTQttNgSNYxMVVHK7elbqdo+ybQPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzsRbZWaa7odfUwgAqMuY0bQXidDsTmcsfZ2kOQiKI8TmUY63XhtxAB8NXWuzDRlXVPf7Wm9LvyfQVPLWBHtzLsGSWCXPrqUIAsxofp+hO2/8kjgNyteZP0zwezBCcGY4xWZmdCQ/tUJ9mKtyqAeErRf+yUIsT1D0nMUEyIffvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FslFvXIW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46I2qcyQ72860524, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721271158; bh=wXpk51tnSa2+9gxTQttNgSNYxMVVHK7elbqdo+ybQPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FslFvXIWppwIajatJITD5hKIAvZJoHEk56hjyqVMJR+2uTaT5M3jCQIou2gQ7sf6K
	 u0+Kj7s9Kc/BeOPrb8iyXqzFB18I2B4LqzMOE0WXBvrafyk3jC/HyVFKJrzOMM5gUm
	 O3omiMdSq58OtCqFswXtnV7oxi2u9DFDKPEOh9uKfDzceirmpJOafOSkyn/Fyu5cra
	 6xAzEmRoUImYa7xnHFw9khsj7q9u9gkL2zBdiwjnH2k+xGsU0l4O4aT3qpp6M64zAm
	 lToDMPxh6UI20105qGwbMoAGZgP9DMji/F9RWuWQOmVpZzK4TSEquSxRKBDkh3qvZj
	 ZVCq31NbRv3zw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46I2qcyQ72860524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 10:52:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 10:52:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jul
 2024 10:52:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
Date: Thu, 18 Jul 2024 10:51:38 +0800
Message-ID: <20240718025138.18777-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718025138.18777-1-pkshih@realtek.com>
References: <20240718025138.18777-1-pkshih@realtek.com>
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

RTL8852BE-VT is a WiFi 6 2x2 chip, which can operate on 2/5 GHz channels
and 80MHz bandwidth.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 3c9f864805b1..5fa46b320da6 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -68,6 +68,18 @@ config RTW89_8852BE
 
 	  802.11ax PCIe wireless network (Wi-Fi 6) adapter
 
+config RTW89_8852BTE
+	tristate "Realtek 8852BE-VT PCI wireless network (Wi-Fi 6) adapter"
+	depends on PCI
+	select RTW89_CORE
+	select RTW89_PCI
+	select RTW89_8852BT
+	select RTW89_8852B_COMMON
+	help
+	  Select this option will enable support for 8852BE-VT chipset
+
+	  802.11ax PCIe wireless network (Wi-Fi 6) adapter
+
 config RTW89_8852CE
 	tristate "Realtek 8852CE PCI wireless network (Wi-Fi 6E) adapter"
 	depends on PCI
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 1f1050a7a89d..c751013e811e 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -52,6 +52,14 @@ rtw89_8852b-objs := rtw8852b.o \
 obj-$(CONFIG_RTW89_8852BE) += rtw89_8852be.o
 rtw89_8852be-objs := rtw8852be.o
 
+obj-$(CONFIG_RTW89_8852BT) += rtw89_8852bt.o
+rtw89_8852bt-objs := rtw8852bt.o \
+		    rtw8852bt_rfk.o \
+		    rtw8852bt_rfk_table.o
+
+obj-$(CONFIG_RTW89_8852BTE) += rtw89_8852bte.o
+rtw89_8852bte-objs := rtw8852bte.o
+
 obj-$(CONFIG_RTW89_8852C) += rtw89_8852c.o
 rtw89_8852c-objs := rtw8852c.o \
 		    rtw8852c_table.o \
-- 
2.25.1


