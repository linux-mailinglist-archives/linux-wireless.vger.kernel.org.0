Return-Path: <linux-wireless+bounces-28895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98904C557E6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0553B15E5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216B246333;
	Thu, 13 Nov 2025 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="okG01uvh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083026FA67
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 02:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002692; cv=none; b=tgWSZw//r40CD9zZ+58NpDLu4Rtet4EdGWTiacSMwPL5EN2Gq30yFgwf8hD3mHCu2MTcB/CrjUbdql99K85B6Qg7mr/1FQ9maFpJMiPPahvDtD+ScNao0x+LhyyA+2yxZc/FiGjANM679C+MD0RdwiB4tad6lB6fVgWxdLBviAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002692; c=relaxed/simple;
	bh=N/Bye48XHZbHwfVOXbznlTPXydnFraFno6bTn72VPRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3Wpq8aX6P6x759PrkkRL0fAR94qJbtAZ4BU7RovuPslLkgqIRqc4mLSB7gHgpqW2KOKBEf+YhXi5JhXulI/urqCC0y/w9QcUX/Jt3XqFNQIzrM3GxFoZafvDJq2h9qMtAMTloNNpakEHp6aajxziTLYeLs413iElwbZfUU7WFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=okG01uvh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD2w9rqD2840240, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763002689; bh=UZ3LT8KWuSpshvoIsyzfGrUb9YLax4BF2/0iz2dHUoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=okG01uvhbEB72St3UB4rYU4AAppGvngo+IHBvNVS+5r6YBAwU5Gt4wNBbpAHo2wbx
	 TvO3T+oAZym53SFRZmRcr8NUrug3Yb/GWx3fIzbhHjTh1G/A2xRNTQgg6KX+PCYTSl
	 mI8U5x+8A7gi8lFt4q/SGy1LZdxFH6hYdUMxFba8+o0LprbJIx8qs/OV3Fri6+lBUq
	 LgGY1EVFY5CWGmKpWDe0N5T3MqyMAp9R3n048Dc/QJq2byQQ7zC/ULGQvpjx4pBC+6
	 EqBarbm2v3kyOPqFfLcGTSddVqMrEeRz++FsVNErLyW4Oqv8vJyb8GcX5fFLq+zMjL
	 aulCbQt2XlWLQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD2w9rqD2840240
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:58:09 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:58:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 10:58:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH rtw-next 14/14] wifi: rtw89: correct user macid mask of RX info for RTL8922D
Date: Thu, 13 Nov 2025 10:56:20 +0800
Message-ID: <20251113025620.31086-15-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

The user MAC ID mask of RX info in MAC PPDU for RTL8922A and RTL8922D
is different, correct it accordingly.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 6 +++++-
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 drivers/net/wireless/realtek/rtw89/txrx.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a14edc321ca7..8078c9aa0ac8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1834,9 +1834,13 @@ static int rtw89_core_rx_process_mac_ppdu(struct rtw89_dev *rtwdev,
 		/* For WiFi 7 chips, RXWD.mac_id of PPDU status is not set
 		 * by hardware, so update mac_id by rxinfo_user[].mac_id.
 		 */
-		if (chip_gen == RTW89_CHIP_BE)
+		if (chip->chip_id == RTL8922A)
 			phy_ppdu->mac_id =
 				le32_get_bits(user->w0, RTW89_RXINFO_USER_MACID);
+		else if (chip->chip_id == RTL8922D)
+			phy_ppdu->mac_id =
+				le32_get_bits(user->w0, RTW89_RXINFO_USER_MACID_V1);
+
 		phy_ppdu->has_data =
 			le32_get_bits(user->w0, RTW89_RXINFO_USER_DATA);
 		phy_ppdu->has_bcn =
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ab71489b89a3..a9cb47ea0b93 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -155,6 +155,7 @@ enum rtw89_core_chip_id {
 	RTL8852C,
 	RTL8851B,
 	RTL8922A,
+	RTL8922D,
 };
 
 enum rtw89_chip_gen {
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index b37dbac7b790..fa324b4a1dde 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -421,6 +421,7 @@ struct rtw89_rxinfo_user {
 #define RTW89_RXINFO_USER_MGMT BIT(3)
 #define RTW89_RXINFO_USER_BCN BIT(4)
 #define RTW89_RXINFO_USER_MACID GENMASK(15, 8)
+#define RTW89_RXINFO_USER_MACID_V1 GENMASK(31, 20)
 
 struct rtw89_rxinfo {
 	__le32 w0;
-- 
2.25.1


