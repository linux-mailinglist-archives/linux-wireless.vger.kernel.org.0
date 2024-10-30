Return-Path: <linux-wireless+bounces-14696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70079B59DA
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2B61F23E18
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C411946BC;
	Wed, 30 Oct 2024 02:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jwl7Xobe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662533EA69
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254934; cv=none; b=QbFacmfQ4X5VOdedw/n1aaMG9FwZUkC/Zt2y6YiBkBZu/IEVdRxJHoOIMJIBW78ceVYgdos695uFeLhROxA5SEKN+3PbdEBKGFt/er/kW5BgryZW5Tpm2Dvz5nCjH99uyZr74NWnG/VmudMW3Juan72nw6VXZy10iOLGuOCZ+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254934; c=relaxed/simple;
	bh=Zq+4C8WBA2vHSTBl1eVIA3NLN8Tz00awbV0tNwkCEyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apaoL6A9NYw8pCBBgdr589jC6PBphzOomQPp6rw2ODZqRtAH6mQW9hKjkWiGXfTPRjJM49JzAmmCru6FEg8X6FQfU1p4J+J3gki4cFJyHFjSmacPDssK38JtGI8iZWcwGku2Vjq8E5dc0mkNtSOc664zQbeLqkP3wAn6RNdHAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jwl7Xobe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2M8k143310572, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730254928; bh=Zq+4C8WBA2vHSTBl1eVIA3NLN8Tz00awbV0tNwkCEyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jwl7XobeJx+ywPfv37f5NgvMyReJlMgoTdHeLLOCGsNhz8JyU5H9eFEnIzFC4kN/2
	 1KnYdAgh5nkQsWSa6AfOreXUKqd9HA+FKotkby2hW1Pr2EFGEgFBhSx1ciEvV6xES3
	 uS53L2wb3sXgQjE2aaNzOA/2lo06w3hNndBZ98bccPTomGb1ShT+2ZA+3hRZ0tR6lR
	 uGastjueyleTpcCyZjdWkWkZULuKVwxvQWz/fkNd/82CwkmqKKG094zxqsKW7uefq6
	 Yif2ZM6EGpIFDQ9+YQTOEty7CR+3N2bkMJido6vW/zylBePIBD54IO8Fu+hYlGewJi
	 9K0WtxFN0GmtA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2M8k143310572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:22:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:22:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 10:22:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] wifi: rtw89: efuse: move reading efuse of fw secure info to common
Date: Wed, 30 Oct 2024 10:21:28 +0800
Message-ID: <20241030022135.11688-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030022135.11688-1-pkshih@realtek.com>
References: <20241030022135.11688-1-pkshih@realtek.com>
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

The secure key used by certain hardware module is programmed in efuse, so
driver should read the information from efuse before downloading firmware.

Originally only RTL8922AE can support firmware secure boot, and read efuse
during chip power on. To extend to support all chips, move the caller to
common power on flow and add separate functions to read efuse for
WiFi 6 chips.

No logic change at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/efuse.c    | 5 +++++
 drivers/net/wireless/realtek/rtw89/efuse.h    | 1 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 1 -
 drivers/net/wireless/realtek/rtw89/mac.c      | 5 +++++
 drivers/net/wireless/realtek/rtw89/mac.h      | 1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 3 ---
 7 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index e1236079a84a..532623130c41 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -354,3 +354,8 @@ int rtw89_read_efuse_ver(struct rtw89_dev *rtwdev, u8 *ecv)
 	return 0;
 }
 EXPORT_SYMBOL(rtw89_read_efuse_ver);
+
+int rtw89_efuse_read_fw_secure_ax(struct rtw89_dev *rtwdev)
+{
+	return 0;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.h b/drivers/net/wireless/realtek/rtw89/efuse.h
index 72416f56a071..a2f6f36e697f 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.h
+++ b/drivers/net/wireless/realtek/rtw89/efuse.h
@@ -23,6 +23,7 @@ int rtw89_parse_efuse_map_be(struct rtw89_dev *rtwdev);
 int rtw89_parse_phycap_map_be(struct rtw89_dev *rtwdev);
 int rtw89_cnv_efuse_state_be(struct rtw89_dev *rtwdev, bool idle);
 int rtw89_read_efuse_ver(struct rtw89_dev *rtwdev, u8 *efv);
+int rtw89_efuse_read_fw_secure_ax(struct rtw89_dev *rtwdev);
 int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/efuse_be.c b/drivers/net/wireless/realtek/rtw89/efuse_be.c
index 0be26d5fdf7c..756aaf886af9 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse_be.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse_be.c
@@ -559,4 +559,3 @@ int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev)
 
 	return 0;
 }
-EXPORT_SYMBOL(rtw89_efuse_read_fw_secure_be);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 588e2b96bf43..7ed29bc69009 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1444,6 +1444,7 @@ void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev)
 static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 {
 #define PWR_ACT 1
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_pwr_cfg * const *cfg_seq;
 	int (*cfg_func)(struct rtw89_dev *rtwdev);
@@ -1472,6 +1473,9 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		return ret;
 
 	if (on) {
+		if (!test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags))
+			mac->efuse_read_fw_secure(rtwdev);
+
 		set_bit(RTW89_FLAG_POWERON, rtwdev->flags);
 		set_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
 		set_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
@@ -6673,6 +6677,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.parse_efuse_map = rtw89_parse_efuse_map_ax,
 	.parse_phycap_map = rtw89_parse_phycap_map_ax,
 	.cnv_efuse_state = rtw89_cnv_efuse_state_ax,
+	.efuse_read_fw_secure = rtw89_efuse_read_fw_secure_ax,
 
 	.cfg_plt = rtw89_mac_cfg_plt_ax,
 	.get_plt_cnt = rtw89_mac_get_plt_cnt_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 721fa3b4f82b..4d4b505e3bc9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -988,6 +988,7 @@ struct rtw89_mac_gen_def {
 	int (*parse_efuse_map)(struct rtw89_dev *rtwdev);
 	int (*parse_phycap_map)(struct rtw89_dev *rtwdev);
 	int (*cnv_efuse_state)(struct rtw89_dev *rtwdev, bool idle);
+	int (*efuse_read_fw_secure)(struct rtw89_dev *rtwdev);
 
 	int (*cfg_plt)(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt);
 	u16 (*get_plt_cnt)(struct rtw89_dev *rtwdev, u8 band);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 30943462640f..e0d7cf9fd7ee 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2603,6 +2603,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.parse_efuse_map = rtw89_parse_efuse_map_be,
 	.parse_phycap_map = rtw89_parse_phycap_map_be,
 	.cnv_efuse_state = rtw89_cnv_efuse_state_be,
+	.efuse_read_fw_secure = rtw89_efuse_read_fw_secure_be,
 
 	.cfg_plt = rtw89_mac_cfg_plt_be,
 	.get_plt_cnt = rtw89_mac_get_plt_cnt_be,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 27069a55e368..f17cb1204f80 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -399,9 +399,6 @@ static int rtw8922a_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_FEN_BB_IP_RSTN |
 						       B_BE_FEN_BBPLAT_RSTB);
 
-	if (!test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags))
-		rtw89_efuse_read_fw_secure_be(rtwdev);
-
 	return 0;
 }
 
-- 
2.25.1


