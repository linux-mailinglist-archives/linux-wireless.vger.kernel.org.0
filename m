Return-Path: <linux-wireless+bounces-4412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A585872DA9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 04:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC10F1C22395
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 03:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7F15AC4;
	Wed,  6 Mar 2024 03:47:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11327171D1
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696848; cv=none; b=AY4D+sR1ssBqiuKJqBJKwh8bxiDEvTHfE+bKsZBObTvMZ1vWcSUHXzdYn4u+o3ec6UyFxkLtvDaSt24YcLG7dbrzP14u5lUzhO/NPfTJcKKKUXd+NS8bf7i/JTzm19I5+W/3N5YKZzGS0FWX0G6fuFyA7HYWxsf+GubL4WhHpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696848; c=relaxed/simple;
	bh=+nJZV6zHOpPX4a+ZBt83FDtYPe4mDT0yXOXV4M2w9rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlQ9PdGTO2virp5EjeDILEoSPUDg5JH9EFZKNmb7Hfcda7H7o1FRmFAyauUdeBZivc/7liTBFfiad9XUGHRLVhdnmmBjfTPbcZfHkbdn/oJyVzgPVfGHIqZAsR0pAnrXq3l0FtiQQ2GQ+/JJJmgvkAOORzLchtTGMcZM45ygeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4263lL7y9482476, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4263lL7y9482476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 11:47:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 11:47:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 11:47:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: 8922a: add 8922ae to Makefile and Kconfig
Date: Wed, 6 Mar 2024 11:45:58 +0800
Message-ID: <20240306034558.19648-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306034558.19648-1-pkshih@realtek.com>
References: <20240306034558.19648-1-pkshih@realtek.com>
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


