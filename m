Return-Path: <linux-wireless+bounces-28885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22691C557C9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5683AC791
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8375C246333;
	Thu, 13 Nov 2025 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VTEjuoCm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D29253B73
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002641; cv=none; b=iJVacVwG+5IsqjQQqaWhp7zIlGGUR9MwLrA44tL0iAfOM4e7F/JhfluExubG/LqH7Oi6l8y05IXvK9uroXisTrZxGK8xp+Qp2JFe0vEeruRSWM4KwANqB+S7KiQBQJ1SLMWhPJnTzRocfCM+kU7fI5Smp8lMRhLp/zL/cPYkAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002641; c=relaxed/simple;
	bh=IQDMdw3V8X65TlkeUW0Ih2gI/mkY/nXdHiU0vx9ylNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZOqLpnQut7GvYDuZzTds8xMRZoyLdpkQHGFr+O3zIRH1zMxP4TI4d9TY64pGCf9hiVylpKKbcl9R70ZnG/WyU0i3O2S0JPD3c/50rowZBFvO6M4p2CdJ/t2GBn2nECR9fxCjlPk52WFeIV7u/wNjRFPsYdLHjBYDe6YNTAWD2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VTEjuoCm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD2vGLD12839378, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763002636; bh=gDkaknY5J3SP5zisxYBNWbX3UU8/kNinzhXlmJHpbB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=VTEjuoCmJaSujEqbcQUquGyUnm2b+SauHKaX1GX0JJIi+MBetQF7Gv2tx40S4gHGL
	 IKrKI2Xm/I98nFOm/44viyQdu/ovPuIsea0izGSg+s1Z4NS5nVhLuNhCvyOvCFbENp
	 2jvZc9PlXDrGETL8ac5tElwEFWXBpXgYQhzBKy+epc5CHq9ZZUX2/unCPIuavDceKz
	 9Qn1oY5gHC0SPd7Ch9hmYzhMg4wS71bJ0TzLhEU4zU9peJ2y/TQ63+ER7PSn6Rz6FI
	 zX4NcQlVFYXSevxPyigkwnDHsW9dKxyknZJ/UOFiyvSkFfBi7EECcgcuVVfiNfFGYu
	 qu7Nz7HHTriVQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD2vGLD12839378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:57:16 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:16 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 10:57:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH rtw-next 04/14] wifi: rtw89: phy: calling BB pre-init by chips with/without BB MCU
Date: Thu, 13 Nov 2025 10:56:10 +0800
Message-ID: <20251113025620.31086-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113025620.31086-1-pkshih@realtek.com>
References: <20251113025620.31086-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The existing flow is doing BB pre-init before downloading BB MCU firmware,
because existing chip RTL8922A has BB MCU. However, the coming chips don't
have this, and BB pre-init configuring registers can affect downloading
WiFi-CPU firmware. Therefore, calling BB pre-init afterward for new coming
chips without BB MCU.

For existing WiFi 6 chips, no BB pre-init. For RTL8922A, don't change
the logic.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  4 ++++
 drivers/net/wireless/realtek/rtw89/core.h | 11 ++++++++---
 drivers/net/wireless/realtek/rtw89/mac.c  |  9 ++++++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0cabea7dd92b..ea22925b8772 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5615,6 +5615,7 @@ EXPORT_SYMBOL(rtw89_check_quirks);
 
 int rtw89_core_start(struct rtw89_dev *rtwdev)
 {
+	bool no_bbmcu = !rtwdev->chip->bbmcu_nr;
 	int ret;
 
 	ret = rtw89_mac_preinit(rtwdev);
@@ -5623,6 +5624,9 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	if (no_bbmcu)
+		rtw89_chip_bb_preinit(rtwdev);
+
 	rtw89_phy_init_bb_afe(rtwdev);
 
 	/* above do preinit before downloading firmware */
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f63857b389d7..8943166de52c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7039,12 +7039,17 @@ static inline void rtw89_chip_rfk_hw_init(struct rtw89_dev *rtwdev)
 }
 
 static inline
-void rtw89_chip_bb_preinit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw89_chip_bb_preinit(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (chip->ops->bb_preinit)
-		chip->ops->bb_preinit(rtwdev, phy_idx);
+	if (!chip->ops->bb_preinit)
+		return;
+
+	chip->ops->bb_preinit(rtwdev, RTW89_PHY_0);
+
+	if (rtwdev->dbcc_en)
+		chip->ops->bb_preinit(rtwdev, RTW89_PHY_1);
 }
 
 static inline
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ff160d25a7c9..21f5023c4f69 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4104,9 +4104,12 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
 	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
 
 	if (include_bb) {
-		rtw89_chip_bb_preinit(rtwdev, RTW89_PHY_0);
-		if (rtwdev->dbcc_en)
-			rtw89_chip_bb_preinit(rtwdev, RTW89_PHY_1);
+		/* Only call BB preinit including configuration of BB MCU for
+		 * the chips which need to download BB MCU firmware. Otherwise,
+		 * calling preinit later to prevent touching registers affecting
+		 * download firmware.
+		 */
+		rtw89_chip_bb_preinit(rtwdev);
 	}
 
 	ret = rtw89_mac_dmac_pre_init(rtwdev);
-- 
2.25.1


