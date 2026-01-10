Return-Path: <linux-wireless+bounces-30618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB5FD0CD13
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 03:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 596AD3007E7D
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 02:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46691F09AD;
	Sat, 10 Jan 2026 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="o9NFe3KU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DA19F40B
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011644; cv=none; b=awYDiyT27QgpXEsFCaRBNtorXWTKJFlsnXjHPimkPZb7MoXNBVGSR6O1I5VvVADcwPaF0gmIGcZ2en9c2c/6oULm+dwhRWdbHRCyI6xotLctmNWoMQmoyZozw70b7CuErd+tMTQrrSHIhHiv5OSnSf85hXWiYscOdACRlpmlFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011644; c=relaxed/simple;
	bh=JD6SLE2mW/Q2XQ/6odlsfTZ3H0B3IuMrZhYcyXA0y9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+rPzWLq8qEgw5Z1pLvGmUZ5yr7Y2rjFA/INF7y2udISfOW2OUZuZO+64Um7/ve8VNBvF1Lw8RJ0YlGkUrHYrIr/6dxTwkOPfoTOIPDiPuA2bgKlUI13LqQHBCl+OSFG57XPVdSy4Yh8RxGYxcLusk1dQuNm63Rzqub5PSY3ZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=o9NFe3KU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60A2KfV92241726, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768011641; bh=gG5Bc6sz7uQr3RJz3R9KO56xvNwyvW5F9yJtwYGJzlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=o9NFe3KUqwyxjDaifY2zKq1lLwTPvxd3uBBCWns+Lil1zdNZTD0NdvtnSji20hJUx
	 /zCvYXlIRKQ1qPqfM/TQQW29ke71UvrVTLS6rVQpJwECd5IaJXwMSoXpvqtbjzMHfa
	 Dnq5RfQ9SxCd9DyIIqWnUP+rFl38eul9rk186DiUHh5bdelOUGZTLNcQiRzGYbJqzU
	 NopwgWPXFqPMQsXNxvyvdtttDr9H/BAFmTVOeZoIEbnfWUmGs8B+jIE07yPdhG541u
	 t07CyVWbh1xU/ztrNCKiGPrGn+nzbkl24gJWoQLqjDpax/KI5+IN524C3hnoj67skT
	 sYw8IZQ75nqfg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60A2KfV92241726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 10:20:41 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:41 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:40 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 10 Jan 2026 10:20:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 4/8] wifi: rtw89: disable EHT protocol by chip capabilities
Date: Sat, 10 Jan 2026 10:20:15 +0800
Message-ID: <20260110022019.2254969-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260110022019.2254969-1-pkshih@realtek.com>
References: <20260110022019.2254969-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For certain chip models, EHT protocol is disabled, and driver must follow
the capabilities. Otherwise, chips become unusable.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 drivers/net/wireless/realtek/rtw89/fw.h   | 4 ++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 5 +++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d8c3474da4b4..8d999305be4a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5395,7 +5395,7 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 	u8 val, val_mcs13;
 	int sts = 8;
 
-	if (chip->chip_gen == RTW89_CHIP_AX)
+	if (chip->chip_gen == RTW89_CHIP_AX || hal->no_eht)
 		return;
 
 	if (hal->no_mcs_12_13)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 40527354c95d..ef67d8d3cd70 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5100,6 +5100,7 @@ struct rtw89_hal {
 	bool support_cckpd;
 	bool support_igi;
 	bool no_mcs_12_13;
+	bool no_eht;
 
 	atomic_t roc_chanctx_idx;
 	u8 roc_link_index;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 1542634f0146..018b3bed57d2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -42,6 +42,10 @@ struct rtw89_c2hreg_phycap {
 #define RTW89_C2HREG_PHYCAP_W0_BW GENMASK(31, 24)
 #define RTW89_C2HREG_PHYCAP_W1_TX_NSS GENMASK(7, 0)
 #define RTW89_C2HREG_PHYCAP_W1_PROT GENMASK(15, 8)
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11N 1
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11AC 2
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11AX 3
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11BE 4
 #define RTW89_C2HREG_PHYCAP_W1_NIC GENMASK(23, 16)
 #define RTW89_C2HREG_PHYCAP_W1_WL_FUNC GENMASK(31, 24)
 #define RTW89_C2HREG_PHYCAP_W2_HW_TYPE GENMASK(7, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 1375ab324a8b..e0c7fffe6c4a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3081,6 +3081,7 @@ static int rtw89_mac_setup_phycap_part0(struct rtw89_dev *rtwdev)
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_mac_c2h_info c2h_info = {};
 	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 protocol;
 	u8 tx_nss;
 	u8 rx_nss;
 	u8 tx_ant;
@@ -3128,6 +3129,10 @@ static int rtw89_mac_setup_phycap_part0(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_FW, "TX path diversity=%d\n", hal->tx_path_diversity);
 	rtw89_debug(rtwdev, RTW89_DBG_FW, "Antenna diversity=%d\n", hal->ant_diversity);
 
+	protocol = u32_get_bits(phycap->w1, RTW89_C2HREG_PHYCAP_W1_PROT);
+	if (protocol < RTW89_C2HREG_PHYCAP_W1_PROT_11BE)
+		hal->no_eht = true;
+
 	return 0;
 }
 
-- 
2.25.1


