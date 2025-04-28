Return-Path: <linux-wireless+bounces-22135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E27ABA9EF01
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0331889583
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A966263F30;
	Mon, 28 Apr 2025 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HQ/EBzVI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660FC264FAF
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839555; cv=none; b=Vdj0kF2s6cISMDaRAABI1Xl/5K2w+Bco2r+7pBfZYUYF58tkvEWNlJu01F1qrUQZDJljXsyUvoQspQsmPxPOc+SJtNDQI2CcGs+76zQ8pipR9qC4YoxY4AZuIw5LW+FPPFRd5j1WiruG43XNlvuLWs69DG1cLKnxzzkojQWFb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839555; c=relaxed/simple;
	bh=EU268JnlgzYKhX9B2yIsg19fUKWIxWnfXopDjFVHe/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzXohP3M7KBahDkPx+vaqI0nEEAh9iXldPZDsO5Z6pVITz0ynhShAN3c/AJqEsSF0bl/SVOSCynixxt2SyOyfiMflyWjq6q9OEDKUBx5ggbbFvv8r5AQ5yBJzO4En5k5rt1a0V0kFiJd4rqRKFOxDsV4EBEdes/v/GhzhXLinVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HQ/EBzVI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBPpnL62101218, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839551; bh=EU268JnlgzYKhX9B2yIsg19fUKWIxWnfXopDjFVHe/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HQ/EBzVI37NWATXQdweP/Rb7d+Lxm3xHWc4gQR16apg09G1Y75Z4KS5PtbXAOzfFU
	 fqsyTnCPSkJ35+peAYxCItNfOxdoXBja4+71SegsBwrRy7K04uW2jQDU3XO15AtaF5
	 MEM3oA5vxkEjwOHs941YIDzHdg2wwAeELoCsL3qH+vP4kWqL8kIBrJ0lzuOaf96+X/
	 XGdJWsEo0lLiOSMhcO39r/eEOCtN3dpeIcccmU2627pjKk1eY9AsUj2+ow1CjGo/Gk
	 Kt6YLXlT3bcRx1swEe9+VHVwXnPKSvknNJbogf5oqEf865Iw4N6WpMgnR4IDgTNw/H
	 2KG6htxYOxi0g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBPpnL62101218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:25:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:25:51 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:25:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/10] wifi: rtw89: Configure scan band when mlo_dbcc_mode changes
Date: Mon, 28 Apr 2025 19:24:51 +0800
Message-ID: <20250428112456.13165-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428112456.13165-1-pkshih@realtek.com>
References: <20250428112456.13165-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Previously only the first band is used for scanning. With MLO, update
scan parameters accordingly by so we can choose to scan from either band.
C2H event return value reflects current scanning band, mask it out so
we don't treat correct return value as fail.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/fw.h  | 1 +
 drivers/net/wireless/realtek/rtw89/mac.c | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4173794e3892..7d410cef9bd6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5753,7 +5753,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W2_PKTS_CTRL) |
 			   le32_encode_bits(0,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W2_SW_DEF) |
-			   le32_encode_bits(2,
+			   le32_encode_bits(rtw89_is_mlo_1_1(rtwdev) ? 1 : 2,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W2_SS);
 
 		opch->w3 = le32_encode_bits(RTW89_SCANOFLD_PKT_NONE,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 0d89083df49a..dd085a46b9e3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3562,6 +3562,7 @@ struct rtw89_c2h_done_ack {
 #define RTW89_C2H_DONE_ACK_W2_CLASS GENMASK(7, 2)
 #define RTW89_C2H_DONE_ACK_W2_FUNC GENMASK(15, 8)
 #define RTW89_C2H_DONE_ACK_W2_H2C_RETURN GENMASK(23, 16)
+#define	RTW89_C2H_SCAN_DONE_ACK_RETURN GENMASK(5, 0)
 #define RTW89_C2H_DONE_ACK_W2_H2C_SEQ GENMASK(31, 24)
 
 #define RTW89_GET_MAC_C2H_REV_ACK_CAT(c2h) \
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 592fbb6d2728..449865f7b7a9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5118,12 +5118,14 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 			return;
 		case H2C_FUNC_ADD_SCANOFLD_CH:
 			cond = RTW89_SCANOFLD_WAIT_COND_ADD_CH;
+			h2c_return &= RTW89_C2H_SCAN_DONE_ACK_RETURN;
 			break;
 		case H2C_FUNC_SCANOFLD:
 			cond = RTW89_SCANOFLD_WAIT_COND_START;
 			break;
 		case H2C_FUNC_SCANOFLD_BE:
 			cond = RTW89_SCANOFLD_BE_WAIT_COND_START;
+			h2c_return &= RTW89_C2H_SCAN_DONE_ACK_RETURN;
 			break;
 		}
 
-- 
2.25.1


