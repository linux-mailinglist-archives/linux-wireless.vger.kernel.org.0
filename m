Return-Path: <linux-wireless+bounces-18769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D453A30C6A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 14:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23E61888847
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BCF1FCFE3;
	Tue, 11 Feb 2025 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj3Yg24Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9FD1FCF72;
	Tue, 11 Feb 2025 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739279082; cv=none; b=q+dZYPoWzmZGD3A5N8KkyDwKsIu/1cPAhYuM/xFTsoeZ9x5ca5eN4XsBTjjweodIHGTw79/X8Jxwxz9n+RWiUsUCkRobCltry+znWRrSXO8AP5HyXee/VWlEvxqhObDyoApZ8mKqZ600ixmxesZXyY59PxNbmrqvedwUpH4sw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739279082; c=relaxed/simple;
	bh=MWz8r53x6JKskpZTb3ZcKNyWb9ZN4JNbsQQMjFXtmFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB7y34phDJS682MiMMHpekgsIYcXj+mLuj/hbZow/BVzSQROVoj+A3gcGW/C0uqObhM6ZpyY+K29Sz6hq+xenGvtEJSuK2CFtBAALbC/UftCT8iiSV2fBIBkrwaUTQ51FluoojRsMi0y6PvsCktGjF7PJ833PbJGuitr76+ZozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj3Yg24Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f5a224544so45886705ad.0;
        Tue, 11 Feb 2025 05:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739279080; x=1739883880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AWVQ5JDwyWX96+y/ZkNAFitVnZqUVOS0KXpyg4X4zAA=;
        b=Jj3Yg24ZKRHxiQqkYWGd2nozWJg1xpPlYO/VtzUcgJJRWRnkTlYVs6GHowkmddcxJI
         OjviiC8jMbw+O6JEuM5Or/uXy+lfCxmpAsKfZYISXIXpCuwic4CgqE/hdgv26iztEAwB
         ISPwSoqJgg3ZK658tSr4KK9vEFYrYRpm82wsf5nXUfKhFmxgm0v7yDNWBHF8OTZ+ygov
         renBvQUK/gRXS5D4udLdreQDiqXU1bSKyGA+il0w4ok5FLc7Z9e2neeT5b3f6IvaKY4C
         AOTneIGKWpRimHBZ0/T6C9InD7fbdbXsXS2zqW1I2J4mewvOUk491jsXs82mcGLbdZFM
         Hb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739279080; x=1739883880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWVQ5JDwyWX96+y/ZkNAFitVnZqUVOS0KXpyg4X4zAA=;
        b=wNPIWI4Ht8Jrp6N0jDThEQxVDHVNR+26KVzJsvcJdzjQvPyEnmNLanvOWOKftqvgJ/
         T6dLVtfjQ4JWLYzbXNgROBHiZJ+jVgnOu18b0+tMFjKf4EA+zoSkHU8lmGiEE/ac6JgB
         ZwRmWfx6NFuxyKLGRrtiVEwrjJPD0IelMeRchA/MKRH+5EmYAykOsSqOEdqT8lH1tGla
         176Zmxi+a5CHAnYjeEzRUiK7DTq99rsd2kcY1Qkir/Ad2G/6UGIWHJ4l2u/RvlW78nBx
         HiNlSNa91Uv4XFE4/zfciDYlDYk1E4bpnrseeWty1F4b0iqOHPnmYS1Kh6Wl4aodk9X5
         Pp1A==
X-Forwarded-Encrypted: i=1; AJvYcCVy0hxPXj1j24b555ZKX8+1qr9plB5fqUV7TkGeK8vyFKQHr2RADl1Oi6Hjq783NlNMOtchOEXxysqPeaxLEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWm0jnVKI1fubSvQIu5XD9cHcDjbpKsRG/QLGrDkboLbNThMG/
	jdAAWVbUMOPLlcRLbqfMHLzfhD0IXNeY/6t741qYISPEY+piQbQWEr9wf/st
X-Gm-Gg: ASbGnctT0CTamlW57kNzJrr1P3HzPsgYfoEfkzCyWZ6Aiz7fCKkAP/KcCyj/SeQbdOV
	vfO+9o9tGzelcJAoRdBX3ZkYjjQn0VgG36LvOpvP5AyYKyt0XAsmNjwBLvmjshRzqu4tsEmjy7E
	ENUjj6SJex9dAW1vb2u88UMlEUNGLaVphHsEUFGX2fozEQqCPcdD7dKsDDWhDB06yKllmx4KwNx
	9w9vtpScrfz0qL1UVdXnho9sDcttz7NXObVn9/9d6Kl269xHu6v87XgEbNaDScd1x+w5SCMbNAY
	DNdRz8Vc0s4rEVpvc1/rmeFQBdJ718653WOKet4TzFT9LyXA15ZA6Ju8PLXoeFQOYQ==
X-Google-Smtp-Source: AGHT+IFBTmud6yU40zzjppMHvaz99oJnfYbiEIsUUwtcHHijXBfZLBQLRdIcmELGtmZukO2XX8K3JQ==
X-Received: by 2002:a05:6a21:3115:b0:1e1:c03c:b420 with SMTP id adf61e73a8af0-1ee03b415acmr35203584637.31.1739279079546;
        Tue, 11 Feb 2025 05:04:39 -0800 (PST)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-730775e4896sm5781703b3a.39.2025.02.11.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 05:04:39 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: pkshih@realtek.com,
	linux-wireless@vger.kernel.org,
	Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH v6.13] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Tue, 11 Feb 2025 21:04:32 +0800
Message-ID: <20250211130432.1091-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 9c1df813e08832c3836c254bc8a2f83ff22dbc06 ]

The PCIE wake bit is to control PCIE wake signal to host. When PCIE is
going down, clear this bit to prevent waking up host unexpectedly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241111063835.15454-1-pkshih@realtek.com
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
Some users of RTL8852BE chip may encounter a shutdown issue [1] and this
upstream patch fixes it, so backport it to kernel 6.13.

[1] https://github.com/lwfinger/rtw89/issues/372
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 16 +++++++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h    |  9 +++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index f923bec03..c3a027735 100644
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
@@ -4325,7 +4334,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 					    B_AX_RDU_INT},
 
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_ax,
-	.mac_pre_deinit = NULL,
+	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit_ax,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_ax,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_ax,
@@ -4343,6 +4352,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.l1ss_set = rtw89_pci_l1ss_set_ax,
 
 	.disable_eq = rtw89_pci_disable_eq_ax,
+	.power_wake = rtw89_pci_power_wake_ax,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_ax);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index b68e2d82e..d52db4ca1 100644
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
index 34154506f..cd39eebe8 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -691,5 +691,6 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.l1ss_set = rtw89_pci_l1ss_set_be,
 
 	.disable_eq = rtw89_pci_disable_eq_be,
+	.power_wake = _patch_pcie_power_wake_be,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_be);
-- 
2.48.1


