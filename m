Return-Path: <linux-wireless+bounces-30153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A87FCE5C6D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4DF43002682
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0908230D35;
	Mon, 29 Dec 2025 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JxFALWQG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4046224F3
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977817; cv=none; b=RkDC6q3ofR3u7zDhOj/vPhiK13bcxPz+lI3uEvEe6rdVVvjCEmtBgdHPSqYgd/ttFsASZcgGZ9bhG4pC/wSWFRp2sDvVnNxDClUvBI5rFLii46ik9Q4ECkVi6wSz23D/LOCfmPrKul8dXdgf3EwEQMS/Ha9sxoLdG2eIG/ETetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977817; c=relaxed/simple;
	bh=121zfvFiJ8oLlkv33N3o9y3DS1bXpZfQ46M1WDlro7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhifatPpp3flicbJ9+zSGsb+gLbph70J0yqK/RlloHx2vDQbXFyHrG+uUfO8GbLiKUpL604AlwiE/2ue3LEfovOXKDAOOvEhq+YkEOnImRGkwLDxKIZpg7gL9dCYv0lNn90Hx1ALRjg2vS53HYXY+c2WScnAauTHWDW0PSq8mHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JxFALWQG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BT3ADfG4282689, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766977813; bh=A+Ki4PBlcOWnrfmIDbfsYJze9g2v0EqM+WiJaYjRCvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JxFALWQGAQHfa+CGb9QwPFoqXE4tBkKZQpGTd2Z33Mo8BAHxPpZ7nuIJg4MDgVdsE
	 FVhn46//u5dZFoYdr7Fqk4YB3Z851S0+m3SJFX0gQmRXv0rZxWrr6LyIaceTXZRoiP
	 aPc+fZmG8FTH0kPdLO2ybnyjnEpydr15hkjhz3dVJYHOdMK4vTjZU1J6vYHtc3t6+e
	 Lg8e5gM7lFym8wxRmMW7ZV8g8MsqCw2Bc9k5M8KEmw8aT54BoQTSSP+4vTjV/5BQ6m
	 wKTqGYpPO/zO6gJIvLpNDUnPaMzzxiXQz8VIajDQHWch0heMyO2f1SBt1rTbtCiyXv
	 oKbH8m9t4YI8Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BT3ADfG4282689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 11:10:13 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:14 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 29 Dec 2025 11:10:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 06/12] wifi: rtw89: efuse: read hardware version from efuse for WiFi 7 chips
Date: Mon, 29 Dec 2025 11:09:20 +0800
Message-ID: <20251229030926.27004-7-pkshih@realtek.com>
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

Hardware version from efuse prioritizes to the version from register.
For WiFi 7 chips, this becomes required, so implement this in common flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/efuse.c    |  4 ---
 drivers/net/wireless/realtek/rtw89/efuse.h    |  6 +++++
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 26 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  5 +++-
 drivers/net/wireless/realtek/rtw89/mac.h      | 11 ++++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  1 +
 6 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index 6c6c763510af..a2757a88d55d 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -7,10 +7,6 @@
 #include "mac.h"
 #include "reg.h"
 
-#define EF_FV_OFSET 0x5ea
-#define EF_CV_MASK GENMASK(7, 4)
-#define EF_CV_INV 15
-
 #define EFUSE_B1_MSSDEVTYPE_MASK GENMASK(3, 0)
 #define EFUSE_B1_MSSCUSTIDX0_MASK GENMASK(7, 4)
 #define EFUSE_B2_MSSKEYNUM_MASK GENMASK(3, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.h b/drivers/net/wireless/realtek/rtw89/efuse.h
index a96fc1044791..a14a9dfed8e8 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.h
+++ b/drivers/net/wireless/realtek/rtw89/efuse.h
@@ -11,6 +11,11 @@
 #define RTW89_EFUSE_BLOCK_SIZE_MASK GENMASK(15, 0)
 #define RTW89_EFUSE_MAX_BLOCK_SIZE 0x10000
 
+#define EF_FV_OFSET 0x5EA
+#define EF_FV_OFSET_BE_V1 0x17CA
+#define EF_CV_MASK GENMASK(7, 4)
+#define EF_CV_INV 15
+
 struct rtw89_efuse_block_cfg {
 	u32 offset;
 	u32 size;
@@ -26,5 +31,6 @@ int rtw89_read_efuse_ver(struct rtw89_dev *rtwdev, u8 *efv);
 int rtw89_efuse_recognize_mss_info_v1(struct rtw89_dev *rtwdev, u8 b1, u8 b2);
 int rtw89_efuse_read_fw_secure_ax(struct rtw89_dev *rtwdev);
 int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev);
+int rtw89_efuse_read_ecv_be(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/efuse_be.c b/drivers/net/wireless/realtek/rtw89/efuse_be.c
index 64768923b0f0..70c1b8be662e 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse_be.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse_be.c
@@ -512,3 +512,29 @@ int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev)
 
 	return 0;
 }
+
+int rtw89_efuse_read_ecv_be(struct rtw89_dev *rtwdev)
+{
+	u32 dump_addr;
+	u8 buff[4]; /* efuse access must 4 bytes align */
+	int ret;
+	u8 ecv;
+	u8 val;
+
+	dump_addr = ALIGN_DOWN(EF_FV_OFSET_BE_V1, 4);
+
+	ret = rtw89_dump_physical_efuse_map_be(rtwdev, buff, dump_addr, 4, false);
+	if (ret)
+		return ret;
+
+	val = buff[EF_FV_OFSET_BE_V1 & 0x3];
+
+	ecv = u8_get_bits(val, EF_CV_MASK);
+	if (ecv == EF_CV_INV)
+		return -ENOENT;
+
+	rtwdev->hal.cv = ecv;
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_efuse_read_ecv_be);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index fae0527e50e8..91854ae9a310 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1529,8 +1529,10 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		return ret;
 
 	if (on) {
-		if (!test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags))
+		if (!test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags)) {
+			rtw89_mac_efuse_read_ecv(rtwdev);
 			mac->efuse_read_fw_secure(rtwdev);
+		}
 
 		set_bit(RTW89_FLAG_POWERON, rtwdev->flags);
 		set_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
@@ -7281,6 +7283,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.parse_phycap_map = rtw89_parse_phycap_map_ax,
 	.cnv_efuse_state = rtw89_cnv_efuse_state_ax,
 	.efuse_read_fw_secure = rtw89_efuse_read_fw_secure_ax,
+	.efuse_read_ecv = NULL,
 
 	.cfg_plt = rtw89_mac_cfg_plt_ax,
 	.get_plt_cnt = rtw89_mac_get_plt_cnt_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 9d0c491f053f..2f3138b155f9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1067,6 +1067,7 @@ struct rtw89_mac_gen_def {
 	int (*parse_phycap_map)(struct rtw89_dev *rtwdev);
 	int (*cnv_efuse_state)(struct rtw89_dev *rtwdev, bool idle);
 	int (*efuse_read_fw_secure)(struct rtw89_dev *rtwdev);
+	int (*efuse_read_ecv)(struct rtw89_dev *rtwdev);
 
 	int (*cfg_plt)(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt);
 	u16 (*get_plt_cnt)(struct rtw89_dev *rtwdev, u8 band);
@@ -1602,6 +1603,16 @@ int rtw89_mac_get_dle_rsvd_qt_cfg(struct rtw89_dev *rtwdev,
 				  struct rtw89_mac_dle_rsvd_qt_cfg *cfg);
 int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable);
 
+static inline int rtw89_mac_efuse_read_ecv(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	if (!mac->efuse_read_ecv)
+		return -ENOENT;
+
+	return mac->efuse_read_ecv(rtwdev);
+}
+
 static inline
 void rtw89_fwdl_secure_idmem_share_mode(struct rtw89_dev *rtwdev, u8 mode)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index c0204e68c172..0b29f43b38bd 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2774,6 +2774,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.parse_phycap_map = rtw89_parse_phycap_map_be,
 	.cnv_efuse_state = rtw89_cnv_efuse_state_be,
 	.efuse_read_fw_secure = rtw89_efuse_read_fw_secure_be,
+	.efuse_read_ecv = rtw89_efuse_read_ecv_be,
 
 	.cfg_plt = rtw89_mac_cfg_plt_be,
 	.get_plt_cnt = rtw89_mac_get_plt_cnt_be,
-- 
2.25.1


