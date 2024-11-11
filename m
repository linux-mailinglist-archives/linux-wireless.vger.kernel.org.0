Return-Path: <linux-wireless+bounces-15162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED98C9C387E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730D2B20E9E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 06:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1BB83A14;
	Mon, 11 Nov 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="hhNWz+rp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D314F108
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731307154; cv=none; b=cJIwx7lcrlF/r44IMW3xhMaToH/9Wo+0Mrgn71bkdGTFLfwLFosyviKpUCck99apEMRdwUy9z+ffg/KCGQVt3GYzY7J6431zqzHRBOBchVDz0m3v0NEgLBFTKxAJsfFhEyK+4avzHHSUMLKrFUkdezy4LMr+howDxwcj6xEUe1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731307154; c=relaxed/simple;
	bh=0xQ0A/pJXja97ZT3/FZcl/or8mNYwxzM4zFcpk1IfLM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TzKebR0NI9UzqHdFXFWKeIDL39eRb4rx6xH2AIdbsflUcO6npRjUPGsbA97BQus+3aVZ06juPqZKuxPCKCAX7xPuiggkhOoZUMqyBH8VolshluK75vlpgDKin4N8/6vYqFYKpecKjK2PJqr7h+X+otYyyMeY3NDQODdrOifJlgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=hhNWz+rp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB6d7fsD1751111, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731307148; bh=0xQ0A/pJXja97ZT3/FZcl/or8mNYwxzM4zFcpk1IfLM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=hhNWz+rppbggLnaTHbEJIMduD0qDk0kHZ7BA0cDPbolkuNfhwmgh/bofwmGC7sjTY
	 +0l6mhXn2MORA7f5fNSrnImykwncIR+MZesO7ly5Hwn6Yb3WWysYsdKDY0git4O4md
	 SefLlw7XEz7Gb8L6Mffliq5eoJX4WdKL++s9o/swNAkw/9OZwOQjNTdG9RiPNM/yZW
	 KuBdnDOZJXcgr1uRwKrQTT+OSiVAedLJTYTZ9avk0J2Mxbqfj3onLgl35Je4A/LqFu
	 1Gtk4E32/2WL2pUtKi6HziM5VkJ21E+1iMoCHo6YlL6U8pmxQurd8Fzbgp62sLhl9y
	 Hnaz5xE2tdWNQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB6d7fsD1751111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 14:39:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 14:39:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Nov
 2024 14:39:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Mon, 11 Nov 2024 14:38:35 +0800
Message-ID: <20241111063835.15454-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

The PCIE wake bit is to control PCIE wake signal to host. When PCIE is
going down, clear this bit to prevent waking up host unexpectedly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 16 +++++++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h    |  9 +++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index b0477ece7012..5050f48756b2 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2516,7 +2516,7 @@ static int rtw89_pci_dphy_delay(struct rtw89_dev *rtwdev)
 				       PCIE_DPHY_DLY_25US, PCIE_PHY_GEN1);
 }
 
-static void rtw89_pci_power_wake(struct rtw89_dev *rtwdev, bool pwr_up)
+static void rtw89_pci_power_wake_ax(struct rtw89_dev *rtwdev, bool pwr_up)
 {
 	if (pwr_up)
 		rtw89_write32_set(rtwdev, R_AX_HCI_OPT_CTRL, BIT_WAKE_CTRL);
@@ -2825,6 +2825,8 @@ static int rtw89_pci_ops_deinit(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 
+	rtw89_pci_power_wake(rtwdev, false);
+
 	if (rtwdev->chip->chip_id == RTL8852A) {
 		/* ltr sw trigger */
 		rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_APP_LTR_IDLE);
@@ -2867,7 +2869,7 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	rtw89_pci_power_wake(rtwdev, true);
+	rtw89_pci_power_wake_ax(rtwdev, true);
 	rtw89_pci_autoload_hang(rtwdev);
 	rtw89_pci_l12_vmain(rtwdev);
 	rtw89_pci_gen2_force_ib(rtwdev);
@@ -2912,6 +2914,13 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_pci_ops_mac_pre_deinit_ax(struct rtw89_dev *rtwdev)
+{
+	rtw89_pci_power_wake_ax(rtwdev, false);
+
+	return 0;
+}
+
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en)
 {
 	u32 val;
@@ -4291,7 +4300,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 					    B_AX_RDU_INT},
 
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_ax,
-	.mac_pre_deinit = NULL,
+	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit_ax,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_ax,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_ax,
@@ -4309,6 +4318,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.l1ss_set = rtw89_pci_l1ss_set_ax,
 
 	.disable_eq = rtw89_pci_disable_eq_ax,
+	.power_wake = rtw89_pci_power_wake_ax,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_ax);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index b68e2d82eea9..d52db4ca1b99 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1290,6 +1290,7 @@ struct rtw89_pci_gen_def {
 	void (*l1ss_set)(struct rtw89_dev *rtwdev, bool enable);
 
 	void (*disable_eq)(struct rtw89_dev *rtwdev);
+	void (*power_wake)(struct rtw89_dev *rtwdev, bool pwr_up);
 };
 
 #define RTW89_PCI_SSID(v, d, ssv, ssd, cust) \
@@ -1805,4 +1806,12 @@ static inline void rtw89_pci_disable_eq(struct rtw89_dev *rtwdev)
 	gen_def->disable_eq(rtwdev);
 }
 
+static inline void rtw89_pci_power_wake(struct rtw89_dev *rtwdev, bool pwr_up)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	gen_def->power_wake(rtwdev, pwr_up);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 34154506f5d4..cd39eebe8186 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -691,5 +691,6 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.l1ss_set = rtw89_pci_l1ss_set_be,
 
 	.disable_eq = rtw89_pci_disable_eq_be,
+	.power_wake = _patch_pcie_power_wake_be,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_be);
-- 
2.25.1


