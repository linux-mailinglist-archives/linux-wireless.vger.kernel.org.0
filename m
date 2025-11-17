Return-Path: <linux-wireless+bounces-29017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE00C623E4
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 04:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7E93B46AA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 03:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0BE314B79;
	Mon, 17 Nov 2025 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="U2VZG+nq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3F1B0F23
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763350203; cv=none; b=CM8zkt3gH+eQpNtFXf16928TV+fJJqUXmeYYX5eF6cls7+MW19MAn+jhiummNvD9PFNHkOi0M6rLRu/m1gquPfGDuPBB/31owf1hdxHkPpWTim/lNewpxPjtJzdY9weo7ekboJVC87JNF6AhvciVgkBV+5Zem3wdZpDlnbElfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763350203; c=relaxed/simple;
	bh=MLJqHrzm7bGU/POiCaS4rGX6lDKruIarxNonLPbcZdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRco+tTWXJh9EtUDfgImSIPawqVTbTKO7H8wfBvetDZWDQJLW8dFh5iqPKq2GUV5bgruV95yg6mnDnjqvo6xRjBG6unxx+5DtWXPrngueSuF6QdzLsTTcA55/cm47DFq3CDyUQ6EvPR9KHBbgKU0MuiBJnepzLSBemOLhjO9XPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=U2VZG+nq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AH3TsZ422763588, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763350194; bh=BfTfJGEVJsgjqYUuFXKgQ2Z+U/PMhOn1GOh+6IFcq6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=U2VZG+nq4PYFjtDZ5fz/EXN1Of2IiuF3lBz868axiusQJZ4sXcJ5gpcSRoLawH3jH
	 BfIpVD9F0dGXb3TDxW34oiEYlLj0W7eISOdEOp8Tk7DTgArml4z5L0+8+pz49DJ6II
	 Yj/LMz+S8g928oFai5EPR0DMZ+G9uj4v0VBWhVdXZngd6D8Mn5MMna4Wj5yRFF0jLR
	 q2NhUpc8V1G5o/k5xj08GOOlIhsqqpDneFSmZ7vcDVjQLQJrO/A8bftF+FyQ+kVEdo
	 0q577T++6ztNrxNctGVi6iEy0sNg4tffK4J7p5u+f8g717SOsL3bGeSb3MFV9pMP5s
	 +hDZ9BLOWp05Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AH3TsZ422763588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 11:29:54 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 17 Nov 2025 11:29:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Mon, 17 Nov 2025 11:29:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <geert@linux-m68k.org>
Subject: [PATCH rtw-next 1/2] wifi: rtw89: 8852a: correct field mask of reset DAC/ADC FIFO
Date: Mon, 17 Nov 2025 11:29:09 +0800
Message-ID: <20251117032910.11224-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251117032910.11224-1-pkshih@realtek.com>
References: <20251117032910.11224-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The field mask should be bits 16-31, but suddenly use wrong bits 24-31,
rarely causing a little performance degraded if DAC/DAC FIFO stays on
an unexpected state.

Found this by Geert who works on bit field functions.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index e74257d19412..463399413318 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -756,8 +756,8 @@ static void _iqk_rxk_setting(struct rtw89_dev *rtwdev, u8 path)
 	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_FLTRST, 0x1);
 	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H2, 0x0);
 	udelay(1);
-	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RST, 0x0303);
-	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RST, 0x0000);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0303);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0000);
 
 	switch (iqk_info->iqk_band[path]) {
 	case RTW89_BAND_2G:
@@ -1239,8 +1239,8 @@ static void _iqk_txk_setting(struct rtw89_dev *rtwdev, u8 path)
 	udelay(1);
 	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0x0041);
 	udelay(1);
-	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RST, 0x0303);
-	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RST, 0x0000);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0303);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0000);
 	switch (iqk_info->iqk_band[path]) {
 	case RTW89_BAND_2G:
 		rtw89_write_rf(rtwdev, path, RR_XALNA2, RR_XALNA2_SW, 0x00);
-- 
2.25.1


