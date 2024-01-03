Return-Path: <linux-wireless+bounces-1435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973B48228B0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 08:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82861C22D4C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 07:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA62179AC;
	Wed,  3 Jan 2024 07:03:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA551798C
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40373JYX0863407, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40373JYX0863407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 15:03:19 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 3 Jan 2024 15:03:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 3 Jan 2024
 15:03:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw88: 8822ce: refine power parameters for RFE type 5
Date: Wed, 3 Jan 2024 15:01:55 +0800
Message-ID: <20240103070155.119488-1-pkshih@realtek.com>
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
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Refine the power parameters for better step response especially at high
current ramp case that is caused by power inductor variation.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 4 ++++
 drivers/net/wireless/realtek/rtw88/reg.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 2bfc0e822b8d..9986a4cb37eb 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1450,6 +1450,7 @@ static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 	const struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct pci_dev *pdev = rtwpci->pdev;
 	const struct rtw_intf_phy_para *para;
 	u16 cut;
@@ -1498,6 +1499,9 @@ static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
 			rtw_err(rtwdev, "failed to set PCI cap, ret = %d\n",
 				ret);
 	}
+
+	if (chip->id == RTW_CHIP_TYPE_8822C && efuse->rfe_option == 5)
+		rtw_write32_mask(rtwdev, REG_ANAPARSW_MAC_0, BIT_CF_L_V2, 0x1);
 }
 
 static int __maybe_unused rtw_pci_suspend(struct device *dev)
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 1634f03784f1..b122f226924b 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -557,6 +557,9 @@
 #define REG_RFE_INV16		0x0cbe
 #define BIT_RFE_BUF_EN		BIT(3)
 
+#define REG_ANAPARSW_MAC_0	0x1010
+#define BIT_CF_L_V2		GENMASK(29, 28)
+
 #define REG_ANAPAR_XTAL_0	0x1040
 #define BIT_XCAP_0		GENMASK(23, 10)
 #define REG_CPU_DMEM_CON	0x1080
-- 
2.25.1


