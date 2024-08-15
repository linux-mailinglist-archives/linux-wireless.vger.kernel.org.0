Return-Path: <linux-wireless+bounces-11451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A7952902
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99731F23380
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 05:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF516BE30;
	Thu, 15 Aug 2024 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CUJESrbG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A20916BE20
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723700467; cv=none; b=VDaicjErisH1AeItDv+CUe2Kibr7XdqryUtmgDZDOH7Mr4lLwqoyX6WYub5OQjUr4sfmCa3ofWrypP77yYfm99Dol36bFVWteCTE4Ilwa+OrSwDwlDZBk6dSxbQnXTB5f7mPH/XER4NqDkvxzXPTqjFuXS5tjKBCE5QptrBMF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723700467; c=relaxed/simple;
	bh=Jfbi7QnWZjzJVwzJBzpvmdhMmcb1+8gdC6Rn1+1QrMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tNEA2yM3VXQn6/duwHuvP5/3EQbn5ZSoaO1wVNEt+SLB/qcqFz+lN0jTPjEj7wqg9jdSEcnpZnB+jmbFbKO3OlSrQRo7QKUXaijXhw2/LArTfmvCsa16bR2Tv4ZICdI3YxTUSP0hV/bRgPRD8jXnYY5CpLyk+Ts/kkGKZb1GuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CUJESrbG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F5f1r353651605, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723700461; bh=Jfbi7QnWZjzJVwzJBzpvmdhMmcb1+8gdC6Rn1+1QrMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=CUJESrbGOIw3S+PLD//b0anAlvPmXDKRWFUi1vXYhrBaPmPi2oDLgQK2qde5n9hOR
	 FBFbjVqo6pvCr20sKvM9ydItzGMkL4IX8dePsmT76sUVAHMNtu2GiCfHvHXsXa4ipY
	 ei2KxtvNvaij/xYEjVEVwktDn+3zd5dHadmwjEO1sWszalo+3yIRJExnjSd9U13tLT
	 Y2rrQVyXeVwcfcjard99S3nt9jlijq3Hc464nGG/X4pyP7wsCEyv3MtQbOxDcj+E3F
	 Tr1kIHWVJycDjc1v1dcca8++q+yOkU/4448o2O3BVcIAgjDNDPHhEiIv+WtSF5AhGA
	 hu1+yKMVM2eEQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F5f1r353651605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 13:41:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 13:41:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 15 Aug
 2024 13:41:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH] wifi: rtw89: limit the PPDU length for VHT rate to 0x40000
Date: Thu, 15 Aug 2024 21:40:54 +0800
Message-ID: <20240815134054.44649-1-pkshih@realtek.com>
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

From: Chia-Yuan Li <leo.li@realtek.com>

If the PPDU length for VHT rate exceeds 0x40000, calculating the PSDU
length will overflow. TMAC will determine the length to be too small and
as a result, all packets will be sent as ZLD (Zero Length Delimiter).

Fixes: 5f7e92c59b8e ("wifi: rtw89: 8852b: set AMSDU limit to 5000")
Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 7 +++++++
 drivers/net/wireless/realtek/rtw89/reg.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 89875f59d722..a661c176100c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2742,6 +2742,7 @@ bool rtw89_mac_is_qta_dbcc(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 
 static int ptcl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val, reg;
 	int ret;
 
@@ -2780,6 +2781,12 @@ static int ptcl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 				  B_AX_SPE_RPT_PATH_MASK, FWD_TO_WLCPU);
 	}
 
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_AGG_LEN_VHT_0, mac_idx);
+		rtw89_write32_mask(rtwdev, reg,
+				   B_AX_AMPDU_MAX_LEN_VHT_MASK, 0x3FF80);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 7afec48c4056..45730b0d0957 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2506,6 +2506,10 @@
 #define B_AX_RTS_TXTIME_TH_MASK GENMASK(15, 8)
 #define B_AX_RTS_LEN_TH_MASK GENMASK(7, 0)
 
+#define R_AX_AGG_LEN_VHT_0 0xC618
+#define R_AX_AGG_LEN_VHT_0_C1 0xE618
+#define B_AX_AMPDU_MAX_LEN_VHT_MASK GENMASK(19, 0)
+
 #define S_AX_CTS2S_TH_SEC_256B 1
 #define R_AX_SIFS_SETTING 0xC624
 #define R_AX_SIFS_SETTING_C1 0xE624
-- 
2.25.1


