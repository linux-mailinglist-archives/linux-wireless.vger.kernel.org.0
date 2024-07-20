Return-Path: <linux-wireless+bounces-10413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF6937EBE
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 04:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0901F21A20
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 02:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308DD3D6D;
	Sat, 20 Jul 2024 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YJu9mAJl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE559473
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721441696; cv=none; b=e9TOeL7ycyvSIvKuth1fw79dBCvNsn9rrqMI+jlLTOND5lNe65l6d8NFY2a1lN69vuTfSPsSTU4DLX6W/imgW94ZT/aRtgc2m/eIhgLFB+ebOcoS0bn3RMWLaF1S+d1CEjS7mzXd16ueSTAPQJ1jQGL2/rfqjyUZIpIsStxPp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721441696; c=relaxed/simple;
	bh=l8g9oqnmv9PSagqlrxiAoPwaSEYCpgoZPCKbIf53xug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGprjpctwvjASUfnGe82br1JW0Ji0V3c6QRt1GEV68HNSV/JiWWGmeD50ykjCIU9I3eaDBfIp3lggJyBsXc6blHrDKrSdMyd/l8wWXaUGtpjf97Aw/ybCOauKzSpAmS5bWnBwB+n8+4veVByva2KmkPdNhj/cTujc7Ul0ovm3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YJu9mAJl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46K2EqXC21147904, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721441692; bh=l8g9oqnmv9PSagqlrxiAoPwaSEYCpgoZPCKbIf53xug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YJu9mAJlM+R39AFGXtFxTtiqzwzi7vnWefzQY+EMK/bOrwb5au8oNCzkZld/YBQxo
	 wgfZtGbLodWmCXhQJswARaI8BRz1tDaWuB44fGTNv1J06nhNdjDirollPtQD6E/NxH
	 Mb13DOxFeyr6jDfJGc94BnE+aw/sX50CoXnruAgQ7/4OwxwQ7Wuk3+/vJ5UlL5qUtf
	 nHC/Beg/0ylhqZo9uJp2ZKLXdKpRo3L4M8W6qQtu79mp7raZvUD241wojcao+r285u
	 dYp/TO8XkcOuQ4fJAcLDA2cvMA/6brGOxM4Cgb+ZXCNBYiP9psyCj92cLTqIP919nT
	 s4jQUutjY5h0g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46K2EqXC21147904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 10:14:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 20 Jul 2024 10:14:52 +0800
Received: from [127.0.1.1] (172.16.22.168) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 20 Jul
 2024 10:14:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 7/7] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
Date: Sat, 20 Jul 2024 10:13:40 +0800
Message-ID: <20240720021340.12102-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240720021340.12102-1-pkshih@realtek.com>
References: <20240720021340.12102-1-pkshih@realtek.com>
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
v3: no change
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


