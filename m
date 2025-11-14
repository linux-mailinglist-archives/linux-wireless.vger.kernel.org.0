Return-Path: <linux-wireless+bounces-28956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9BBC5B78E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D47735738F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE422EB5B4;
	Fri, 14 Nov 2025 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CQf3CLha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175322EB857
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100177; cv=none; b=QGMeavE14oEukby/3P6QjvOLz+nx2moNgJvIdan8Xdgj51lK6OgETbFxTEX8ZkZDy37opUXPma3WQOUxidSYwUfKtZPgFqs7b7qA+l2zqYHEwKten4nz/A69Yeu29MGUhHykfCM3x+K9jjR60RRoqznm/SDRO8w+ThWacHBTbC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100177; c=relaxed/simple;
	bh=PA+4TFYJrZLTOYyekuINo463vA5tz4g61B7V+QH1BBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNp3k4eL5vBsGyqahQc7eRCUwz6eO42qtwu1iUXCIBEhnOHnutHQDXLlRu5Fhh23aw8ycasGiOAB39Lu8h7jXBMk148VvUl1hOdjtvP24F06lcRMe/+H6CeZHjv/Anfm7Vk2PpNpcMJj0HmSVQftI8KBQKbAAFyjyWbLBBb+ZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CQf3CLha; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE62qV821038290, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100172; bh=z1zoKf6UaQhOEmyys5dUZxsdRwtJ3wLm33D+b4hAS8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CQf3CLhaHgNDhXVENehjls+TJwppUpQay1JvsXgwV2Yd1aRH7hrvOSZgyYFM0z2oe
	 dnadjrAyTOknCYwSSMljdSZ2fnXm8pO0jq24wEL4gsY0jarp1IC95iaO+Cc2Wzl25d
	 PBWTmp5U0UD+J+fHigjE/YZKP3m1ZjBFbGeUrjYOA/Gc8XAya189R2O0d6OsqMfHmq
	 2kZmsu6BnzMuDk1EQ/r/9w2VLZGmpj2dyoTbDV/dYLkpATr3/p07MO8PVsWIoAIYV3
	 huEEMFogByOTm+OAu1JgrqFmZDxMzSV1aiUoV86sGp1d8HVr9pn3cl8zgOVgUnTbgB
	 uoPpMQfjPZLjg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE62qV821038290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:52 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:53 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 09/14] wifi: rtw89: fw: print band and port where beacon update on
Date: Fri, 14 Nov 2025 14:01:23 +0800
Message-ID: <20251114060128.35363-10-pkshih@realtek.com>
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

The C2H event of BCN_UPD_DONE is to notify driver that firmware changes
beacon content on certain band/port asked by driver. Print the
notification for debug purpose for now.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: add missing '\n' to debug message
---
 drivers/net/wireless/realtek/rtw89/fw.h  |  9 +++++++++
 drivers/net/wireless/realtek/rtw89/mac.c | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 87c55a1a9d94..bb3e7bbb41de 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3648,6 +3648,15 @@ struct rtw89_fw_c2h_log_fmt {
 #define RTW89_C2H_FW_LOG_SIGNATURE 0xA5A5
 #define RTW89_C2H_FW_LOG_STR_BUF_SIZE 512
 
+struct rtw89_c2h_bcn_upd_done {
+	struct rtw89_c2h_hdr hdr;
+	__le32 w2;
+} __packed;
+
+#define RTW89_C2H_BCN_UPD_DONE_W2_PORT GENMASK(2, 0)
+#define RTW89_C2H_BCN_UPD_DONE_W2_MBSSID GENMASK(6, 3)
+#define RTW89_C2H_BCN_UPD_DONE_W2_BAND_IDX BIT(7)
+
 struct rtw89_c2h_mac_bcnfltr_rpt {
 	__le32 w0;
 	__le32 w1;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 21f5023c4f69..386cc982d7c9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5309,8 +5309,19 @@ rtw89_mac_c2h_bcn_cnt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 }
 
 static void
-rtw89_mac_c2h_bcn_upd_done(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+rtw89_mac_c2h_bcn_upd_done(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 len)
 {
+	const struct rtw89_c2h_bcn_upd_done *c2h =
+		(const struct rtw89_c2h_bcn_upd_done *)skb_c2h->data;
+	u8 band, port, mbssid;
+
+	port = le32_get_bits(c2h->w2, RTW89_C2H_BCN_UPD_DONE_W2_PORT);
+	mbssid = le32_get_bits(c2h->w2, RTW89_C2H_BCN_UPD_DONE_W2_MBSSID);
+	band = le32_get_bits(c2h->w2, RTW89_C2H_BCN_UPD_DONE_W2_BAND_IDX);
+
+	rtw89_debug(rtwdev, RTW89_DBG_FW,
+		    "BCN update done on port:%d mbssid:%d band:%d\n",
+		    port, mbssid, band);
 }
 
 static void
-- 
2.25.1


