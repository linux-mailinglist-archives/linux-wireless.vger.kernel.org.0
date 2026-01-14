Return-Path: <linux-wireless+bounces-30793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0528FD1BF67
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62B12300C036
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E5C17A303;
	Wed, 14 Jan 2026 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AtIb8Xf2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904C1E1DEC
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354829; cv=none; b=GvzCgn/HiYLgW/LnypcgqANv1jd9FvCyKVyoc7ZT+8AVusTAoAL8nVZIriAR/ut1el3KL8g6oqH1Bq/o2h1SU4bLav8sMxg2hruADY4Tjm8TNaj1mcHQZ9pVsHWWzWZDfl1JaE/mjeLUrueDmHGGI3bzPLWqX0rRJNBH9U84KA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354829; c=relaxed/simple;
	bh=BBwGi3CYQMEtGIEk7jGFEkFvMTTiVT4wAljRPe65lNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jU/54nLvE1PTgPsoZuTvQyvD373dCM0vj8FrVBFKaYceM5DvPi+NjIBLDnJKYMHXEJ808KbeVLIPggpzZbOyw8L77Fs22vRw49cOnWY/G25Ik0EM9Bd3gXiUUvMppMhCfjrc2EHNdZIWeYg+sif4eJqWDZlaBhOlHMY/ssTkVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AtIb8Xf2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1eOz954168544, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354824; bh=CcxO1nUVa6d4T3vP4FGTfEPfqMBxJE9rEASS6wtgVYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AtIb8Xf2arFPPOaiFM+F480J2ibEYbBdAD+dhwWXulnVnDYEgfu7RiLk6hLAe/IFS
	 UrXa1vLqQs0Jvv6wKs3PqFNj0Tw3A7VlqqGf/G8r0WFZKSD/n4pQAdw/rQtYwlP789
	 Vu0Ty0NI6il6bkVGPAkIiJK392DATuITWjTJF4iX4eUmjmpik0On1fW9djbnMATlPe
	 6Tb5Ffz5qD6YREMJmHaqXs9mbd8gI9Vy+l1Wg08d2n62CLY+e3Vyc/Obb39XkYlpyO
	 K8y0j2JenxgRbANXhEWajieOMe4lcVJu6vB8tenQ8Ld0dcxgSOYbAJIh1ZfC5AhUxW
	 91pxCGcKfEYWQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1eOz954168544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:40:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:25 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:25 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:40:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 01/12] wifi: rtw89: mac: clear global interrupt right after power-on
Date: Wed, 14 Jan 2026 09:39:39 +0800
Message-ID: <20260114013950.19704-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The global interrupt indicator is always persistent, and firmware will
handle it right after boot. To prevent this unnecessary handling, clear
the indicator before downloading firmware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    |  2 +
 drivers/net/wireless/realtek/rtw89/mac.h    |  9 +++
 drivers/net/wireless/realtek/rtw89/mac_be.c | 10 ++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 66 +++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 3b9c6f9b7f5a..bbe531567ec0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1554,6 +1554,7 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		set_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
 
 		rtw89_mac_update_scoreboard(rtwdev, MAC_AX_NOTIFY_TP_MAJOR);
+		rtw89_mac_clr_aon_intr(rtwdev);
 	} else {
 		clear_bit(RTW89_FLAG_POWERON, rtwdev->flags);
 		clear_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
@@ -7298,6 +7299,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.sys_init = sys_init_ax,
 	.trx_init = trx_init_ax,
 	.preload_init = preload_init_set_ax,
+	.clr_aon_intr = NULL,
 	.err_imr_ctrl = err_imr_ctrl_ax,
 	.mac_func_en = NULL,
 	.hci_func_en = rtw89_mac_hci_func_en_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 14fffb660a29..784a1cf4c6f4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1039,6 +1039,7 @@ struct rtw89_mac_gen_def {
 	int (*trx_init)(struct rtw89_dev *rtwdev);
 	int (*preload_init)(struct rtw89_dev *rtwdev, u8 mac_idx,
 			    enum rtw89_qta_mode mode);
+	void (*clr_aon_intr)(struct rtw89_dev *rtwdev);
 	void (*err_imr_ctrl)(struct rtw89_dev *rtwdev, bool en);
 	int (*mac_func_en)(struct rtw89_dev *rtwdev);
 	void (*hci_func_en)(struct rtw89_dev *rtwdev);
@@ -1251,6 +1252,14 @@ int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 band,
 	return mac->check_mac_en(rtwdev, band, sel);
 }
 
+static inline void rtw89_mac_clr_aon_intr(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	if (mac->clr_aon_intr)
+		mac->clr_aon_intr(rtwdev);
+}
+
 int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val);
 int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val);
 int rtw89_mac_dle_dfi_cfg(struct rtw89_dev *rtwdev, struct rtw89_mac_dle_dfi_ctrl *ctrl);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 58135864786f..a30107de2aca 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1870,6 +1870,15 @@ static int preload_init_be(struct rtw89_dev *rtwdev, u8 mac_idx,
 	return 0;
 }
 
+static void clr_aon_intr_be(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE)
+		return;
+
+	rtw89_write32_clr(rtwdev, R_BE_FWS0IMR, B_BE_FS_GPIOA_INT_EN);
+	rtw89_write32_set(rtwdev, R_BE_FWS0ISR, B_BE_FS_GPIOA_INT);
+}
+
 static int dbcc_bb_ctrl_be(struct rtw89_dev *rtwdev, bool bb1_en)
 {
 	u32 set = B_BE_FEN_BB1PLAT_RSTB | B_BE_FEN_BB1_IP_RSTN;
@@ -3041,6 +3050,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.sys_init = sys_init_be,
 	.trx_init = trx_init_be,
 	.preload_init = preload_init_be,
+	.clr_aon_intr = clr_aon_intr_be,
 	.err_imr_ctrl = err_imr_ctrl_be,
 	.mac_func_en = mac_func_en_be,
 	.hci_func_en = rtw89_mac_hci_func_en_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 0555d2c0dee9..edf0223b28a3 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4309,6 +4309,72 @@
 
 #define R_BE_SECURE_BOOT_MALLOC_INFO 0x0184
 
+#define R_BE_FWS0IMR 0x0190
+#define B_BE_FS_HALT_H2C_INT_EN BIT(31)
+#define B_BE_FS_FSM_HIOE_TO_EVENT_INT_EN BIT(30)
+#define B_BE_FS_HCI_SUS_INT_EN BIT(29)
+#define B_BE_FS_HCI_RES_INT_EN BIT(28)
+#define B_BE_FS_HCI_RESET_INT_EN BIT(27)
+#define B_BE_FS_BT_SB1_INT_EN BIT(26)
+#define B_BE_FS_ACT2RECOVERY_INT_EN BIT(25)
+#define B_BE_FS_GEN1GEN2_SWITCH_INT_EN BIT(24)
+#define B_BE_FS_USB_LPMRSM_INT_EN BIT(22)
+#define B_BE_FS_USB_LPMINT_INT_EN BIT(21)
+#define B_BE_FS_PWMERR_INT_EN BIT(20)
+#define B_BE_FS_PDNINT_EN BIT(19)
+#define B_BE_FS_SPSA_OCP_INT_EN BIT(18)
+#define B_BE_FS_SPSD_OCP_INT_EN BIT(17)
+#define B_BE_FS_BT_SB0_INT_EN BIT(16)
+#define B_BE_FS_GPIOF_INT_EN BIT(15)
+#define B_BE_FS_GPIOE_INT_EN BIT(14)
+#define B_BE_FS_GPIOD_INT_EN BIT(13)
+#define B_BE_FS_GPIOC_INT_EN BIT(12)
+#define B_BE_FS_GPIOB_INT_EN BIT(11)
+#define B_BE_FS_GPIOA_INT_EN BIT(10)
+#define B_BE_FS_GPIO9_INT_EN BIT(9)
+#define B_BE_FS_GPIO8_INT_EN BIT(8)
+#define B_BE_FS_GPIO7_INT_EN BIT(7)
+#define B_BE_FS_GPIO6_INT_EN BIT(6)
+#define B_BE_FS_GPIO5_INT_EN BIT(5)
+#define B_BE_FS_GPIO4_INT_EN BIT(4)
+#define B_BE_FS_GPIO3_INT_EN BIT(3)
+#define B_BE_FS_GPIO2_INT_EN BIT(2)
+#define B_BE_FS_GPIO1_INT_EN BIT(1)
+#define B_BE_FS_GPIO0_INT_EN BIT(0)
+
+#define R_BE_FWS0ISR 0x0194
+#define B_BE_FS_HALT_H2C_INT BIT(31)
+#define B_BE_FS_FSM_HIOE_TO_EVENT_INT BIT(30)
+#define B_BE_FS_HCI_SUS_INT BIT(29)
+#define B_BE_FS_HCI_RES_INT BIT(28)
+#define B_BE_FS_HCI_RESET_INT BIT(27)
+#define B_BE_FS_BT_SB1_INT BIT(26)
+#define B_BE_FS_ACT2RECOVERY_INT BIT(25)
+#define B_BE_FS_GEN1GEN2_SWITCH_INT BIT(24)
+#define B_BE_FS_USB_LPMRSM_INT BIT(22)
+#define B_BE_FS_USB_LPMINT_INT BIT(21)
+#define B_BE_FS_PWMERR_INT BIT(20)
+#define B_BE_FS_PDNINT BIT(19)
+#define B_BE_FS_SPSA_OCP_INT BIT(18)
+#define B_BE_FS_SPSD_OCP_INT BIT(17)
+#define B_BE_FS_BT_SB0_INT BIT(16)
+#define B_BE_FS_GPIOF_INT BIT(15)
+#define B_BE_FS_GPIOE_INT BIT(14)
+#define B_BE_FS_GPIOD_INT BIT(13)
+#define B_BE_FS_GPIOC_INT BIT(12)
+#define B_BE_FS_GPIOB_INT BIT(11)
+#define B_BE_FS_GPIOA_INT BIT(10)
+#define B_BE_FS_GPIO9_INT BIT(9)
+#define B_BE_FS_GPIO8_INT BIT(8)
+#define B_BE_FS_GPIO7_INT BIT(7)
+#define B_BE_FS_GPIO6_INT BIT(6)
+#define B_BE_FS_GPIO5_INT BIT(5)
+#define B_BE_FS_GPIO4_INT BIT(4)
+#define B_BE_FS_GPIO3_INT BIT(3)
+#define B_BE_FS_GPIO2_INT BIT(2)
+#define B_BE_FS_GPIO1_INT BIT(1)
+#define B_BE_FS_GPIO0_INT BIT(0)
+
 #define R_BE_FWS1IMR 0x0198
 #define B_BE_FS_RPWM_INT_EN_V1 BIT(24)
 #define B_BE_PCIE_HOTRST_EN BIT(22)
-- 
2.25.1


