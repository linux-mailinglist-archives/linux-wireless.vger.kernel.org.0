Return-Path: <linux-wireless+bounces-29138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7ADC71EF9
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 04:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FEAE347D58
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 03:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1D26FA77;
	Thu, 20 Nov 2025 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WZZLdpvf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF4C2F90CD
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608302; cv=none; b=rFMc4qV5ppn/rBa016fynCOJAZGbJQC7ntfuzuTATrFO3/A/jLOEdqmcXTUKcVRKzrGiaLHaifrVUrjvfcHHwwKvekY5IErXPspi83skjGIacwYvypPZ2hUVRGRi7/SVq7HQs4ePBiljsSAihFNt5teP/hxrXJoB5Wm2+6JR64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608302; c=relaxed/simple;
	bh=gppxq/olqprTVP/t1gngiG3o5TwwixtOSyNHnWbjnzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPYfzJFKLviUVulxWWz68wdbIUWK/3ZWMID4s+Rp55MxgBoQ1Z+E10Jk9A2/LjqDX+GN6dzBHpD7CVfbQpAtzsuQowwxFyP9UIfnbunQs2L0cOFeEmYTIaqZPaWRTiSCStPMaGVjLydUY80fc2oq+wprlvn3onj03Im3BrPHeSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WZZLdpvf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AK3BV1A0696589, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763608291; bh=rYjEgIc7JjBlFH9SgXdzR76bt2L2Wt/lodxPnR2MTWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WZZLdpvfeJTM59+oGzU1jAlGUZwvsIvWNz0GFmMFiQVUXpbx1ZJDds8sfVHv/UYV6
	 SqSjGEb+HnQaVYbIEcQBcP9cw0uaYU6KliSAqvFfg1srtao/m/zmic9FxKhBTF3rga
	 w5g/5E0CBzpvcjdGRKN38yZL7myW0fYLPhQpbhxeUJYJyDVzifkUYPR++wS+n7MayO
	 it7P+KDi+O6BLRYyZBpXs8HhK91hcWljf62fvAAZ5pHwi0XEP95/t+NINy9POpei5v
	 OXBI6JNfU/mz0ixl+AedB4uqnG4IGeWTuLrmWG7s3qKIg+1ei+aLBG8RCCElu7qOLS
	 E8lO93mhjPTYg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AK3BV1A0696589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 11:11:31 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 11:11:31 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 11:11:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 20 Nov 2025 11:11:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <geert@linux-m68k.org>
Subject: [PATCH v2 rtw-next 1/2] wifi: rtw89: 8852a: correct field mask of reset DAC/ADC FIFO
Date: Thu, 20 Nov 2025 11:10:43 +0800
Message-ID: <20251120031044.12493-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251120031044.12493-1-pkshih@realtek.com>
References: <20251120031044.12493-1-pkshih@realtek.com>
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

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: add Reported-by
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


