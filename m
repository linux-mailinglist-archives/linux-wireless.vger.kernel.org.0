Return-Path: <linux-wireless+bounces-14711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9619B5E85
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 10:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BD31F2159E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF5194A73;
	Wed, 30 Oct 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="a/G7diST"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7754BD4
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279793; cv=none; b=GThfgzl9uQachYgYl9xGzQbTEIXgA8x56sO8rvDyuNugR0FBFICzGwCNlEEERyajqXu15uyXlpJ2FxDQTD5E3m4YB32C2DEkzKwcbRO7bBQgjyE2z4hy6xKCgL8KiMC0lkfqpVlO9qRZevHBlgFPDU/STdNevU1HQYxH4w/JJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279793; c=relaxed/simple;
	bh=XHTCaP/GC3/STWhYxt2xN33fYQmC36v3lrOTZli5hkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LeTlKrYBcnSPreKWR9GgEk6rPbJE9VqjvMT6ezt41IOc2Zc3OTehHm8iPeSl4T2BXayIWR7hS7XBZbcrbOjdJFh4/+F4x32y+lZI0h8bYQrWQq1GtXAcDDhp2Xqv8o6qNRgw+pqiI8G6UEsPbzEbXDXcbDXwff3XbQI5vrANPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=a/G7diST; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U9GQZG03795429, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730279786; bh=XHTCaP/GC3/STWhYxt2xN33fYQmC36v3lrOTZli5hkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=a/G7diST5P/CKKRDNPmDkrrbcq1599ZMiueCOCOo0sUuXf20/LhWR/wHHbvIZSlyX
	 DRMO9ZcuAk5nVaJvyBz6RmJraYF0Urx5dCW/i1avoQg1JUuFQXNt1VVKo/K/z9azb0
	 GlOTP7glp3b/P9XcS3M6ferwkLIxnPFwfDay9oPBOk4bJ17wQx1CTpBh1l+SJUESsx
	 EGF9k8W7/XEUEHeGMhPSqO0ZIfEgsItggEuGmhEOxmnmIkdYvGC3Rx7wCx+kfHt71m
	 J3jXWpl/pSPetOyxyQlW6DNhAfeMF5l4pIpdAEG3N9z2bE7c66PL+vK10xR1fcE03b
	 V4Zeu8ih074Hg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U9GQZG03795429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 17:16:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 17:16:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 17:16:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH] wifi: rtw89: 8852b: change RF mode to normal mode when set channel
Date: Wed, 30 Oct 2024 17:16:03 +0800
Message-ID: <20241030091603.6073-1-pkshih@realtek.com>
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

Set the RF mode from 0xA(low power mode) to 0x3(Normal mode) to avoid
abnormal TX waveform in OFDM rate. Originally the RF mode will be changed
to normal mode by the firmware after entering LPS once. Therefore, this
change does not affect power saving.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b_common.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index ede0ca5426ae..f4aa4437fb75 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -905,7 +905,6 @@ static void rtw8852bx_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_ch, u8 bw,
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 rx_path_0;
-	u32 val;
 
 	rx_path_0 = rtw89_phy_read32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, phy_idx);
 
@@ -985,12 +984,11 @@ static void rtw8852bx_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_ch, u8 bw,
 		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH,
 				      pri_ch, phy_idx);
 
-		/*Set RF mode at A */
-		val = chip_id == RTL8852BT ? 0x333 : 0xaaa;
+		/*Set RF mode at 3 */
 		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
-				      B_P0_RFMODE_ORI_RX_ALL, val, phy_idx);
+				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
-				      B_P1_RFMODE_ORI_RX_ALL, val, phy_idx);
+				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
 		break;
 	default:
 		rtw89_warn(rtwdev, "Fail to switch bw (bw:%d, pri ch:%d)\n", bw,
-- 
2.25.1


