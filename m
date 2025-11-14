Return-Path: <linux-wireless+bounces-28961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6852C5B782
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031813BE356
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4E2ECD19;
	Fri, 14 Nov 2025 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SEdIDQVj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D02DF137
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100202; cv=none; b=CL4kRDToMoWsdmu8WEl8WW/R3VuGRVfAgFIrVNnqyxMi1ZOZ70LK6q0prqY75QhfW6aM00w0NFBUmGbAkX4whSgf3Wq+e93PGy506jiQIPRvSTRAtkFzW2mG9HwpDQin1mdGlUS8kDRl7m5NPlVBwJ7XyKhDP37UHA1zqmieTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100202; c=relaxed/simple;
	bh=PSh0tcK5saKUvU0b6148OnFy0Lx3M3bgK2IK919YWGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnzhTywgrRPCTAye7N/Qf29ds5c1rKeM/1SrhKcvzYThQo58scnDo+NMgRJgsycAwcjlsO7CnfHUWv1j4yEtlvuw7Nra6TixLi5LhS1EoudnwvKDliHO25sJHwfVIAma9JTdVYjBd3U8KdA1gD82s0w7Yk924Sc0nmu/OzocTPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SEdIDQVj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE63IAt81038383, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100198; bh=4IdzJZmEMuBEXllys1asRpG5GWZhvdsn/0RKlq0pecM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SEdIDQVjzKGu0t0N9UVG/2aWVd4UUfAXLzFLsP9JtmrGqACpCNLNpN4/uEFurBi1z
	 7L6Jt8E6/Iou9gfSBn9SLutBpJaH6jD1K4wQs8Y4ZGRodRZO3pGXRgYF3mWMtLTQKB
	 LNzOttqW8AvAW+BzD9BsGfRJ5QtE3QSIX7Rs8l7uvtUXfctyatju8eEL2+oweqwCvl
	 eP3CW6TMU7zd4rBEfYPcZZwd5v1RqA6Mq1t9i7rAsjHYaHDLpm90cae9YLDGqV2Raa
	 fmW8BQVlP8wph3mIYHmqvU9cDnyo2g2mdvbLMmrxx81UNcm74DZh490IissYnIl38+
	 g4Rfht9tj+UKg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE63IAt81038383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:03:18 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:03:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:03:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 14/14] wifi: rtw89: correct user macid mask of RX info for RTL8922D
Date: Fri, 14 Nov 2025 14:01:28 +0800
Message-ID: <20251114060128.35363-15-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114060128.35363-1-pkshih@realtek.com>
References: <20251114060128.35363-1-pkshih@realtek.com>
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
v2: no change
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


