Return-Path: <linux-wireless+bounces-7926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FA68CB8FD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 04:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C74F1C21BD9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 02:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9734C6D;
	Wed, 22 May 2024 02:39:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3451F614
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345543; cv=none; b=Op4hpExWvZYm2e+15t9b6glmDZmomTRNMK/em1IxMqnefdDM3vpvpVoysLhGL8jlF/CnjeepbJVOrfN3R5tmnohIruMWx1B5AJaNIeGzO0+gS/orsGIjZ2Rv9LsdFfvfQpqT0W9MFC7WStCRz3+wpHmKP+iiX5h8KLtqhclhZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345543; c=relaxed/simple;
	bh=YCtySaZeCYfSEhHyMOjbLuquVV/1hfvqrkwuNOVs9SM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g0a/VinI2LNElQyCOe3nxV5GDLXPnRPcwG7ZTlLwqT9oQpDWVyfUOytmTHui+4VyNyuKDifi4fKN2tmuXcRAVTd5lY324XDxg2xN6Yuqseo76W0L2XJAElPyOKU7RvbaJkvsXwlShlo7tEnhsgnnvkZ/jjECro7aKsz0Hn7wm1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44M2cvN833357140, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44M2cvN833357140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 10:38:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 10:38:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 May
 2024 10:38:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: fill STBC and LDPC capabilities to TX descriptor
Date: Wed, 22 May 2024 10:38:29 +0800
Message-ID: <20240522023830.9798-1-pkshih@realtek.com>
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

Fill STBC and LDPC fields to get better performance when transmitting under
noisy environment. Old chips like 8852AE use firmware command to enable
these two capabilities, but newer chips must use TX descriptor.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 12 ++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/txrx.h |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 8b6cb310eaba..36d31608157f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -813,6 +813,8 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	desc_info->mac_id = rtw89_core_tx_get_mac_id(rtwdev, tx_req);
 	desc_info->port = desc_info->hiq ? rtwvif->port : 0;
 	desc_info->er_cap = rtwsta ? rtwsta->er_cap : false;
+	desc_info->stbc = rtwsta ? rtwsta->ra.stbc_cap : false;
+	desc_info->ldpc = rtwsta ? rtwsta->ra.ldpc_cap : false;
 
 	/* enable wd_info for AMPDU */
 	desc_info->en_wd_info = true;
@@ -1127,6 +1129,8 @@ static __le32 rtw89_build_txwd_info0(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_INFO0_USE_RATE, desc_info->use_rate) |
 		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_RATE, desc_info->data_rate) |
+		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_STBC, desc_info->stbc) |
+		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_LDPC, desc_info->ldpc) |
 		    FIELD_PREP(RTW89_TXWD_INFO0_DISDATAFB, desc_info->dis_data_fb) |
 		    FIELD_PREP(RTW89_TXWD_INFO0_MULTIPORT_ID, desc_info->port);
 
@@ -1135,7 +1139,9 @@ static __le32 rtw89_build_txwd_info0(struct rtw89_tx_desc_info *desc_info)
 
 static __le32 rtw89_build_txwd_info0_v1(struct rtw89_tx_desc_info *desc_info)
 {
-	u32 dword = FIELD_PREP(RTW89_TXWD_INFO0_DISDATAFB, desc_info->dis_data_fb) |
+	u32 dword = FIELD_PREP(RTW89_TXWD_INFO0_DATA_STBC, desc_info->stbc) |
+		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_LDPC, desc_info->ldpc) |
+		    FIELD_PREP(RTW89_TXWD_INFO0_DISDATAFB, desc_info->dis_data_fb) |
 		    FIELD_PREP(RTW89_TXWD_INFO0_MULTIPORT_ID, desc_info->port) |
 		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_ER, desc_info->er_cap) |
 		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_BW_ER, 0);
@@ -1301,7 +1307,9 @@ static __le32 rtw89_build_txwd_body7_v2(struct rtw89_tx_desc_info *desc_info)
 
 static __le32 rtw89_build_txwd_info0_v2(struct rtw89_tx_desc_info *desc_info)
 {
-	u32 dword = FIELD_PREP(BE_TXD_INFO0_DISDATAFB, desc_info->dis_data_fb) |
+	u32 dword = FIELD_PREP(BE_TXD_INFO0_DATA_STBC, desc_info->stbc) |
+		    FIELD_PREP(BE_TXD_INFO0_DATA_LDPC, desc_info->ldpc) |
+		    FIELD_PREP(BE_TXD_INFO0_DISDATAFB, desc_info->dis_data_fb) |
 		    FIELD_PREP(BE_TXD_INFO0_MULTIPORT_ID, desc_info->port);
 
 	return cpu_to_le32(dword);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c0f2afb4888a..351296aba534 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1129,6 +1129,8 @@ struct rtw89_tx_desc_info {
 	bool hiq;
 	u8 port;
 	bool er_cap;
+	bool stbc;
+	bool ldpc;
 };
 
 struct rtw89_core_tx_request {
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index c467a80ffa88..11049a50de2c 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -113,6 +113,8 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define RTW89_TXWD_INFO0_GI_LTF GENMASK(27, 25)
 #define RTW89_TXWD_INFO0_DATA_RATE GENMASK(24, 16)
 #define RTW89_TXWD_INFO0_DATA_ER BIT(15)
+#define RTW89_TXWD_INFO0_DATA_STBC BIT(12)
+#define RTW89_TXWD_INFO0_DATA_LDPC BIT(11)
 #define RTW89_TXWD_INFO0_DISDATAFB BIT(10)
 #define RTW89_TXWD_INFO0_DATA_BW_ER BIT(8)
 #define RTW89_TXWD_INFO0_MULTIPORT_ID GENMASK(6, 4)
-- 
2.25.1


