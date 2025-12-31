Return-Path: <linux-wireless+bounces-30224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FFACEBA37
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6614930C1336
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B812B316193;
	Wed, 31 Dec 2025 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eKP7fJFx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB9315D47
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172089; cv=none; b=Gq/PAKbxqR4HtCNNA/H4dGnpEG9hwd6ADRlN9UUNCouljOylDN0QFqpW/jtGDRP2kJHEKbKjs6OPnPoQxsVsPvPEx5YiCwvJ+ZcCnvx8o8F1SR3yUwXcH7RCZ2hDzYaiGHJYtEXk4/DLMbptQXPWZTQPnoFncjg4O6oyRWHpPW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172089; c=relaxed/simple;
	bh=kQgLUEdfxefft7S3wODh694ReA2cgq434xvMQ9U3nLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJJl+B8lXN+i6gXwixKeCkGAKymKnO416FBOL5rVAlobbBJNE8QBIhzkI3D/yF0mkos8ZOwAPNW55ZJBq0HUHBLRO+UgxQ7oK/UjOf4tQq67lhBhjh9PUO6DFAooJLeeqieFRR+jEN1sGl/A1ncvPHlLG3+Nugf2a4mKYrWqXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eKP7fJFx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV985xfC881295, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172085; bh=9Qwha/5+pxW7uQze3zBWrXIXq+gclsT5tDvtVcAdZ8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eKP7fJFx3qG9N85mWoifQzm4njMLMmEoskHfTJvbiJShxIxSJmfY+1wZsr9JvvCks
	 fNv7pmSo+WEr0LhC3qgorWm2SxbolfdEvFKiJqDnaic369FSC4LNnmdXgz0wXPIhWH
	 2LP7RxzDvCaBYRzrQuDkmWSxeNk8ypECEvq+CvcEjuqW4tIFiB31QdzhnkYAdFsX09
	 c4JXRXcoasd7PzB/9swG3OR4zt45YjTtOepa70uBdHE38TIC3Zf0UAZFnHqU2Ocrpt
	 2fLubnkGmvoZ9+gEnTmtssyBRcsN1hUaVA9m4iuxuqj7KmIzlLqam971EIrPVmoUXw
	 HIqOt6amDU1xg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV985xfC881295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:08:05 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:08:06 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:08:04 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:08:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/11] wifi: rtw89: 8852b: refine hardware parameters for RFE type 5
Date: Wed, 31 Dec 2025 17:06:47 +0800
Message-ID: <20251231090647.56407-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231090647.56407-1-pkshih@realtek.com>
References: <20251231090647.56407-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

The RFE type 5 should set different DSWR parameters when card power on.
Therefore, add the corresponding register settings for this type.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 24 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 081623f84dd9..9f963bd85f02 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -323,7 +323,9 @@
 #define B_AX_PCIE_HCISYS_PWR_STE_MASK GENMASK(1, 0)
 
 #define R_AX_SPS_DIG_OFF_CTRL0 0x0400
+#define B_AX_R1_L1_MASK GENMASK(7, 6)
 #define B_AX_C3_L1_MASK GENMASK(5, 4)
+#define B_AX_C2_L1_MASK GENMASK(3, 2)
 #define B_AX_C1_L1_MASK GENMASK(1, 0)
 
 #define R_AX_AFE_OFF_CTRL1 0x0444
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 0f18555e619b..a138d89bce84 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -313,6 +313,27 @@ static void rtw8852b_pwr_sps_ana(struct rtw89_dev *rtwdev)
 		rtw89_write16(rtwdev, R_AX_SPS_ANA_ON_CTRL2, RTL8852B_RFE_05_SPS_ANA);
 }
 
+static void rtw8852b_pwr_sps_dig_off(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+
+	if (efuse->rfe_type == 0x5) {
+		rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_OFF_CTRL0,
+				   B_AX_C1_L1_MASK, 0x1);
+		rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_OFF_CTRL0,
+				   B_AX_C2_L1_MASK, 0x1);
+		rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_OFF_CTRL0,
+				   B_AX_C3_L1_MASK, 0x2);
+		rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_OFF_CTRL0,
+				   B_AX_R1_L1_MASK, 0x1);
+	} else {
+		rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_OFF_CTRL0,
+				   B_AX_C1_L1_MASK, 0x1);
+		rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_OFF_CTRL0,
+				   B_AX_C3_L1_MASK, 0x3);
+	}
+}
+
 static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -338,8 +359,7 @@ static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_OFF_CTRL0, B_AX_C1_L1_MASK, 0x1);
-	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_OFF_CTRL0, B_AX_C3_L1_MASK, 0x3);
+	rtw8852b_pwr_sps_dig_off(rtwdev);
 	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
 	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFN_ONMAC);
 
-- 
2.25.1


