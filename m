Return-Path: <linux-wireless+bounces-4583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223DA878C64
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 02:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ACF1C20FFE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 01:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC5D79CF;
	Tue, 12 Mar 2024 01:39:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35B79C8
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207542; cv=none; b=d4uFtl5aoxWrC95+6cQ5J3LGclDegfJNpsPeSsJrxEmGuOjc6WRAUa/hiAJndQmvVzR/KCxVykX07Oj7bt2RaN3G726YJS0MIxEYn5HI5QC1osotgWlihbwo5ZtFskZNKqtXfh/lX6Y+HZnTnGIU2mVd7pAXNLsuR3j2tVsXEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207542; c=relaxed/simple;
	bh=+nJZV6zHOpPX4a+ZBt83FDtYPe4mDT0yXOXV4M2w9rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtXJcso3iebgjdrV7POtqVwuzT88p5ujDNSfDCSRD/t8TW7k5taEcYNnsdWjbYqvqjuwO4y3Ra8hiB/a758S4yN7itmdQMe/eMOm7HyKqotCqJR4L258bA9TMpYjcoLa/GsjMYd5UKQoL0Fq+jphComywVYesKNV7fuXaOWIbYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42C1cuf673941770, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42C1cuf673941770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 09:38:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 09:38:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 12 Mar
 2024 09:38:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 6/6] wifi: rtw89: 8922a: add 8922ae to Makefile and Kconfig
Date: Tue, 12 Mar 2024 09:37:21 +0800
Message-ID: <20240312013721.17452-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312013721.17452-1-pkshih@realtek.com>
References: <20240312013721.17452-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Add 8922AE to Makefile and Kconfig. Currently, it can support STA, AP and
monitor modes with good performance. Implemented initial BT-coexistence
function only, and will to fine tune this component.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile | 12 +++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 90ffbab7cc4c..eaea4eaeb361 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -28,6 +28,9 @@ config RTW89_8852B
 config RTW89_8852C
 	tristate
 
+config RTW89_8922A
+	tristate
+
 config RTW89_8851BE
 	tristate "Realtek 8851BE PCI wireless network (Wi-Fi 6) adapter"
 	depends on PCI
@@ -72,6 +75,18 @@ config RTW89_8852CE
 
 	  802.11ax PCIe wireless network (Wi-Fi 6E) adapter
 
+config RTW89_8922AE
+	tristate "Realtek 8922AE PCI wireless network (Wi-Fi 7) adapter"
+	depends on PCI
+	select RTW89_CORE
+	select RTW89_PCI
+	select RTW89_8922A
+	help
+	  Select this option will enable support for 8922AE chipset
+
+	  802.11be PCIe wireless network (Wi-Fi 7) adapter
+	  supporting 2x2 2GHz/5GHz/6GHz 4096-QAM 160MHz channels.
+
 config RTW89_DEBUG
 	bool
 
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 41940099af1b..86a553fb0136 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -4,10 +4,13 @@ obj-$(CONFIG_RTW89_CORE) += rtw89_core.o
 rtw89_core-y += core.o \
 		mac80211.o \
 		mac.o \
+		mac_be.o \
 		phy.o \
+		phy_be.o \
 		fw.o \
 		cam.o \
 		efuse.o \
+		efuse_be.o \
 		regd.o \
 		sar.o \
 		coex.o \
@@ -54,8 +57,15 @@ rtw89_8852c-objs := rtw8852c.o \
 obj-$(CONFIG_RTW89_8852CE) += rtw89_8852ce.o
 rtw89_8852ce-objs := rtw8852ce.o
 
+obj-$(CONFIG_RTW89_8922A) += rtw89_8922a.o
+rtw89_8922a-objs := rtw8922a.o \
+		    rtw8922a_rfk.o
+
+obj-$(CONFIG_RTW89_8922AE) += rtw89_8922ae.o
+rtw89_8922ae-objs := rtw8922ae.o
+
 rtw89_core-$(CONFIG_RTW89_DEBUG) += debug.o
 
 obj-$(CONFIG_RTW89_PCI) += rtw89_pci.o
-rtw89_pci-y := pci.o
+rtw89_pci-y := pci.o pci_be.o
 
-- 
2.25.1


