Return-Path: <linux-wireless+bounces-29298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 551DCC83079
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 02:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 445FB4E2E51
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA161E5B7A;
	Tue, 25 Nov 2025 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mJR+kZYn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D81F4615
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764034477; cv=none; b=FzyIcQZexm+Qs6DOxWprfOVRkkzag8XERcBjOQYeq7lcMPSuGUnUjjnZpqE5ruKemHQ52BJgpn1SEK4NpnuNTKlfY71J8sfVhWWvannUBcTu9DJeUS2AkL/euom8a/n8D5M1Ize68kwUcE/DtrU/Uu8ko74zG46FfX1FUAehMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764034477; c=relaxed/simple;
	bh=TWV+wIb7kLPKKInTmKSRKwHpuIS9mCkn0796R3ySDjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M4LEcu46P1eYRuMksDyQffOy5jvCzVH5CNKAlWJIuGJmeygEQiWuQ129XC/37EPz3bENWRocxCTw0DrTE4eidiRBkLF399+tH14MhIZaP5whhAR2BQCsgqW4d71ukCmz8RJMPB0cnVRMKo0vCOH7p0krj8qxqxPYKyFuGtx67ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mJR+kZYn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AP1YTPH02025134, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764034469; bh=B9GQLgxHrlkqsYXGRgBqGL8J9FfeSu8D7fM7PmEQyfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=mJR+kZYnwhjvSxZMr+25hRX17u2sud5wGgGaOA/GS2+nxu7BaNKf579WcjpbLVqhR
	 g5d0q1PEV2arvLdw5wOPOKel8eozlA1yAf0vawsh6qxOUYpfiDE1Rh6kGX5j8jH5gk
	 bFfg98HKMARn1Cz9CstQXMIe1DbSJtBgYqGMkTjygxnH9jZbIXPay/51JNZ3LxrfIk
	 MR4nlpVhVYb/TzW/TUd8Iz4Tf7mx+7+uEV36ueB7HTXe2sAeU1AokmuUuppWJIHMC8
	 gfU+9nSS4W2BBTolvhYlDGeN/bu3HAVu053D3C8VJ63YP2AHlY6vLK3IkmN1+zI4Pj
	 ueYdorVxB6F2Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AP1YTPH02025134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 09:34:29 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 25 Nov 2025 09:34:30 +0800
Received: from [127.0.1.1] (172.21.146.58) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 25 Nov 2025 09:34:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <andrej.skvortzov@gmail.com>
Subject: [PATCH rtw] wifi: rtw88: limit indirect IO under powered off for RTL8822CS
Date: Tue, 25 Nov 2025 09:38:49 +0800
Message-ID: <1764034729-1251-1-git-send-email-pkshih@realtek.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The indirect IO is necessary for RTL8822CS, but not necessary for other
chips. Otherwiese, it throws errors and becomes unusable.

 rtw88_8723cs mmc1:0001:1: WOW Firmware version 11.0.0, H2C version 0
 rtw88_8723cs mmc1:0001:1: Firmware version 11.0.0, H2C version 0
 rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
 rtw88_8723cs mmc1:0001:1: sdio write8 failed (0x1c): -110
 rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110

By vendor driver, only RTL8822CS and RTL8822ES need indirect IO, but
RTL8822ES isn't supported yet. Therefore, limit it to RTL8822CS only.

Reported-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/07a32e2d6c764eb1bd9415b5a921a652@realtek.com/T/#m997b4522f7209ba629561c776bfd1d13ab24c1d4
Fixes: 58de1f91e033 ("wifi: rtw88: sdio: use indirect IO for device registers before power-on")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 99d7c629eac6..e35de52d8eb4 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -144,8 +144,10 @@ static u32 rtw_sdio_to_io_address(struct rtw_dev *rtwdev, u32 addr,
 
 static bool rtw_sdio_use_direct_io(struct rtw_dev *rtwdev, u32 addr)
 {
+	bool might_indirect_under_power_off = rtwdev->chip->id == RTW_CHIP_TYPE_8822C;
+
 	if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags) &&
-	    !rtw_sdio_is_bus_addr(addr))
+	    !rtw_sdio_is_bus_addr(addr) && might_indirect_under_power_off)
 		return false;
 
 	return !rtw_sdio_is_sdio30_supported(rtwdev) ||
-- 
2.25.1


