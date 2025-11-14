Return-Path: <linux-wireless+bounces-28950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6AC5B76D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89631356C47
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1302DC792;
	Fri, 14 Nov 2025 06:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pA2L0jr+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98832DC333
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100146; cv=none; b=SkFuMDxkYhkhh0lCKmMKIl+z9LrPel8W17h7+HaaSLmgp+0rgUXGIef+iIYizBhmHEjnLzchchU4Kffv+k8mtUw3nbcWqjHZ3hdaQ94FuBnTzdwFvOERiT/f345hg+a7NeYeqKiwIrjueU2dkrT3EgV7Bv8crB92L04edIMhw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100146; c=relaxed/simple;
	bh=oPGWw+5vlzHNM2uGMepCMrsE0NgEfld0kzBDtRNk72Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7jjaQeNlDgJ/cbEsmBQoqlSgiCAhnW4rxDvnk8eF8UKdg+LJ72WvhYMIwqKrlLMuOSMysxZ2pTFdf8Ji42KhLFG/7FOEF85shqTWURjOYv/Pd7FZfgmEYNpQR8Rt2SHDgLHDq3G/zMVn+GFVSq3IQ53wxkmuKX3klQw3EkqVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pA2L0jr+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE62KS201037617, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100140; bh=ZnjJCEVzfHwhuXkgd7CBgNJpP5o+ZADQombvFxi4j7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pA2L0jr+N1bdmh5VBcPhnzXThj3dmxoJhA56wOFiOXln14LoKgudPp9rbMIQRweHz
	 xmfhHrfsBJ9JebvByYhH+c1n9yhd+8KMWPtSPWTaGu5PYzJSJj4/zzATjahzhjifvm
	 t80K6m2rk6pydcyaOP3J/T9v1WN1456smOc/8+DuwlHZkv4D6gJCNLaV/2wNf9HDDQ
	 593qhMam3SwAddF07slNUkqH7mOv76FLCcTH71yk8QRqAZ2dxuozr7WB32b44ttfc2
	 2S/GVDS3+eIx49xxBghfvrRpuArHh42ZOSa2vZWZ9nmVWfp+iKWcXVmMET1skdL4GD
	 cqyOrwHDb+/LA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE62KS201037617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:20 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 03/14] wifi: rtw89: mac: separate pre-init code before downloading firmware
Date: Fri, 14 Nov 2025 14:01:17 +0800
Message-ID: <20251114060128.35363-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114060128.35363-1-pkshih@realtek.com>
References: <20251114060128.35363-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Driver needs to initialize registers before downloading firmware, so
move pre-init part (power on) from original rtw89_mac_init(). The
consequence patches will add more pre-init codes before downloading
firmware.

Since rtw89_phy_init_bb_afe() is used by coming RTL8922D, don't change
logic at all for existing chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/core.c |  8 ++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 15 +++++++++++----
 drivers/net/wireless/realtek/rtw89/mac.h  |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a15a911484bb..0cabea7dd92b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5617,8 +5617,16 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 {
 	int ret;
 
+	ret = rtw89_mac_preinit(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "mac preinit fail, ret: %d\n", ret);
+		return ret;
+	}
+
 	rtw89_phy_init_bb_afe(rtwdev);
 
+	/* above do preinit before downloading firmware */
+
 	ret = rtw89_mac_init(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "mac init fail, ret:%d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index dab0a76556c9..ff160d25a7c9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4126,17 +4126,24 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
 	return 0;
 }
 
-int rtw89_mac_init(struct rtw89_dev *rtwdev)
+int rtw89_mac_preinit(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-	bool include_bb = !!chip->bbmcu_nr;
 	int ret;
 
 	ret = rtw89_mac_pwr_on(rtwdev);
 	if (ret)
 		return ret;
 
+	return 0;
+}
+
+int rtw89_mac_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool include_bb = !!chip->bbmcu_nr;
+	int ret;
+
 	ret = rtw89_mac_partial_init(rtwdev, include_bb);
 	if (ret)
 		goto fail;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 3cc97fd0c0ec..d203db444a34 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1201,6 +1201,7 @@ rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev);
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev);
 int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb);
+int rtw89_mac_preinit(struct rtw89_dev *rtwdev);
 int rtw89_mac_init(struct rtw89_dev *rtwdev);
 int rtw89_mac_dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 		       enum rtw89_qta_mode ext_mode);
-- 
2.25.1


