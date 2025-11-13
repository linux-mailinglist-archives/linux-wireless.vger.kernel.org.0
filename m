Return-Path: <linux-wireless+bounces-28890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D7C557DA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8E23AFBF8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC4253B73;
	Thu, 13 Nov 2025 02:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="o4W4w4Ue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1183246333
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002666; cv=none; b=UNRk/mp5jA0vufm/jGuTxmE6D2wS4svHhpuSGOB8sGkZN1RbCy8VhCFK4eFWyptqyzUNSGPoPScbsBvXHrcPke726Jgjz7svuQfXaTw6jlSs0FyEe9fSFaNkstx04kEiOTmyTXcpELOaeSlclvl+rVVmWtIzAWbDnrmNg20MdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002666; c=relaxed/simple;
	bh=2WsRMSfNhXJx7UL4ZtLRxy4ajx9mvJmQ4E9voM71Y9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8s41gZ56+hP73tevZ/SrXm0zUJwUY7QOCUu3jPAadAsvsklEm/s8TYxM3hdLGkfP/32GcH22m3+vgeo2CL9sR5mV+v2Wnpqf4s1Zt8nQ//oQhaSzpbTMe0sgnO4loKrRUeYlv9WDKqPKSBzYwKomaoR09ykhtgBSuxGC0gSfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=o4W4w4Ue; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD2vg2232839467, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763002662; bh=JVRc3o4Aqb4zI6SlMCbbFfc5sjDK7H/1aiBB5dbwimg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=o4W4w4Uefv7NOMEXQDWlzCVJrrys/AHvLjcvyGQ0NC9HbkWive2LPxWhbqMVaWlUN
	 97N+EIw/0uskL5d5Tnm5sABi1rBe9uyGnkP0HDRBkNB+iXBR1ZH9KyAf4k/kMPFYYL
	 014Kw6LQZoFu45HnshkUGOeCAzJ1+34B1TgDB6RzoEClGVepO5JmqAgShcIJ39PSVz
	 byE549QWeg3LrYY+k4BaJSEKLIgZ5gntAqlAwCJGP60W9QxV/LUajgYkbvCQTDUTyW
	 pqOMPspRsr7AxDbv6hf0rQrAhRonsfTjzY5dQRXGW+1+aZFbvMefpi1HoMWUM/M7/1
	 uHCL6Yq+uvYVw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD2vg2232839467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:57:42 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:43 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 10:57:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH rtw-next 09/14] wifi: rtw89: fw: print band and port where beacon update on
Date: Thu, 13 Nov 2025 10:56:15 +0800
Message-ID: <20251113025620.31086-10-pkshih@realtek.com>
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

The C2H event of BCN_UPD_DONE is to notify driver that firmware changes
beacon content on certain band/port asked by driver. Print the
notification for debug purpose for now.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
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
index 21f5023c4f69..b120507729ae 100644
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
+		    "BCN update done on port:%d mbssid:%d band:%d",
+		    port, mbssid, band);
 }
 
 static void
-- 
2.25.1


