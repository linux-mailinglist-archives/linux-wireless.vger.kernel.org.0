Return-Path: <linux-wireless+bounces-16565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE6B9F7233
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 02:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDEF97A55D4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 01:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1641170808;
	Thu, 19 Dec 2024 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KUotI4kN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7413BAF1
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572739; cv=none; b=Ox1+2mOgwXg7X+ZQWujtbA3MSbDaTcnfnDjLfswi2bWsy2NTC7X5Pus876Xx5nqdI1HMeGN7I1HOEiccmF8Vq2RXWinmh6djVkaVawld3abRBwEnhGTjaqbZJIsEimVyOW1UduYr7qvw6K/StKqb27ZElEDQ17nfJTkXWtrpUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572739; c=relaxed/simple;
	bh=F3q4T40f5m54OUTw3VuGb8MMcv93E8RriGM41v8pisA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AkQz51J9e8d9HDGPWsx8u0vadTh4cCWer9LO4n+Bu0dcRRw32pCOmCUkeB80TJuXB3y+4b0pZ2wx9WulxiX0ocSWxyQT/Td5Dd2IVRlLSEJj6TdwnWJwBxkB2QXuCdd9q3NJERB8e9nLPeFjBnwLQalxszC8tBbJ6tsebIid8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KUotI4kN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ1jWegD3210812, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734572732; bh=F3q4T40f5m54OUTw3VuGb8MMcv93E8RriGM41v8pisA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=KUotI4kNJji3PPS7XiA6tFziDHLw5PonC1pyH4kVzx3jkbhOiL0uYtuKZWxE0GUL0
	 QWiLG2FvvNftP4yokbMjuk3a3qK4VJo+82YdFQ/QChWmYFwFR721xRa+n6hVR5oPks
	 CRgVe1vz9mN8YtMM1sgFqnpt4VuwaQVKGt4ErxIScEGvK8/q/fuQZ3m2zIcFzwVIoI
	 O/pnDpuoJLs6X+Cc8gD4GoH0/RYQJJExVYGDEsUqHZ9f+1XvnGGxT+rN+u+ef8HTRw
	 cmV7pN1/wePLFSw4Bt1qYOkvA/9NSQrYiPYAkmJJIFF+7777Ir3tPQ3GSq6/161iab
	 n4P1R1Mi8TLfg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ1jWegD3210812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 09:45:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 09:45:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 19 Dec
 2024 09:45:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH] wifi: rtw89: adjust thermal protection step and more RTL8852BE-VT ID
Date: Thu, 19 Dec 2024 09:45:11 +0800
Message-ID: <20241219014511.9056-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

To have better tuning of TX duty for fields usage, adjust thermal
protection step to 5, then TX duty reduce to 75% at most. Add RTL8852BE-VT
ID to enable this function by the way.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h       | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 155538370a89..37722a0b6a8b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4728,7 +4728,7 @@ enum rtw89_dm_type {
 };
 
 #define RTW89_THERMAL_PROT_LV_MAX 5
-#define RTW89_THERMAL_PROT_STEP 19 /* -19% for each level */
+#define RTW89_THERMAL_PROT_STEP 5 /* -5% for each level */
 
 struct rtw89_hal {
 	u32 rx_fltr;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index e4f40c2e287d..d1eebecfcd73 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -9,6 +9,12 @@
 #include "reg.h"
 #include "rtw8852bt.h"
 
+static const struct rtw89_pci_ssid_quirk rtw8852bt_pci_ssid_quirks[] = {
+	{RTW89_PCI_SSID(PCI_VENDOR_ID_REALTEK, 0xB520, 0x103C, 0x88E9, HP),
+	 .bitmap = BIT(RTW89_QUIRK_THERMAL_PROT_110C)},
+	{},
+};
+
 static const struct rtw89_pci_info rtw8852bt_pci_info = {
 	.gen_def		= &rtw89_pci_gen_ax,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
@@ -61,7 +67,7 @@ static const struct rtw89_pci_info rtw8852bt_pci_info = {
 	.disable_intr		= rtw89_pci_disable_intr,
 	.recognize_intrs	= rtw89_pci_recognize_intrs,
 
-	.ssid_quirks		= NULL,
+	.ssid_quirks		= rtw8852bt_pci_ssid_quirks,
 };
 
 static const struct rtw89_driver_info rtw89_8852bte_info = {
-- 
2.25.1


