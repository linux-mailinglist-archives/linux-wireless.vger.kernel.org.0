Return-Path: <linux-wireless+bounces-10384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C9937405
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 08:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35101F210CD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 06:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8901B86E7;
	Fri, 19 Jul 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZlXSFuL4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5094084D
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721370315; cv=none; b=HT+9XCm4JbhfZp5YWod4WUJrIlIj9/3JmcNNP4U0ltf+B1+lv5ywY67OUVs0MH4PrB/eFWV+72lmtu+/J4d5LuShm635IhXuuZdAuusDWvqM6H3Lftv5zEg+wI3YbodGkfOLf4xQ8zwXphW+WgUCtuFa2T8/G14YW6nhRo4ToYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721370315; c=relaxed/simple;
	bh=1b5CKL1+XCUGDh8UQDLAgivV1um5EtghmUc0+xNbzT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7MvhGpItRFfqOpXNuYDFPqa1mxjc1fEYUiXO1A8rRCdIwAPJlyevt/Pi1gI1otPDGS+ARgArWbmpwU4LgVto+1hBKJaTeEYl/84pwiSURHRU7fKfMbUDpJ1YN/vzCJxmGDY2oKSvtvPZrHcyX8EsPNQMEfjLorsG+oLvv+UOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZlXSFuL4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46J6PB1C0182682, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721370311; bh=1b5CKL1+XCUGDh8UQDLAgivV1um5EtghmUc0+xNbzT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZlXSFuL4Qk1wcuQsnr4e/KzDgiJWsLrbBpkcoA1iWZKT4+VvbAH/aXKd+hjKFtp1N
	 5uUEoY53Za+Uy8nUpzFciluLecZuuxZ3h0TA/8bB2/ORHaSYLZTlOhYM7IxQLvw3cp
	 03bzgv0mopoZcIUdaX/xGbfz6Q/S5P/d/osXMIs5PdcF+4vlglzo5NB/sez35sW4+y
	 yne64Un4NnjQFLuWFQCIjs1iU+gH+qrA9EcqxVA5kzw34OQHiegqsujjrvADWcatPP
	 BibQZKE/XA4f1WpP0+sAnCJa6S813mvZFo2QrrrT1w7VWPAnKpWObnf8c9pc9025mk
	 n6oIDspaaftsg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46J6PB1C0182682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 14:25:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 14:25:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jul
 2024 14:25:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
Date: Fri, 19 Jul 2024 14:24:14 +0800
Message-ID: <20240719062414.21953-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719062414.21953-1-pkshih@realtek.com>
References: <20240719062414.21953-1-pkshih@realtek.com>
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
v2: add missing RTW89_8852BT
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 3c9f864805b1..17965487992e 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -28,6 +28,9 @@ config RTW89_8852B_COMMON
 config RTW89_8852B
 	tristate
 
+config RTW89_8852BT
+	tristate
+
 config RTW89_8852C
 	tristate
 
@@ -68,6 +71,18 @@ config RTW89_8852BE
 
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


