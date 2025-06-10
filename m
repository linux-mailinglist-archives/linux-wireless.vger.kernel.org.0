Return-Path: <linux-wireless+bounces-23938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A374FAD3892
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85FC9E6108
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20597246BB5;
	Tue, 10 Jun 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RhxSlsN0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411DF246BB6
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560507; cv=none; b=BdCdDXMCqxDNzXl+PBbJ05L6cnB2Cjh+5ilrLK/YaT9g2r20KzBr43IPu7QIhQGYlRor+i2EIYxrRaW8osHIh+wcOaSD7m6IzWZa4EaxDBV6RNMEfOrXuFsxvzhPb8Wvu5eGOehkUeXcl0ZT5yS2OqT5k5Hm7WuFUthwAnmwHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560507; c=relaxed/simple;
	bh=GgRzhZIH4U6UU5XOW5NrJDNmZwjyGfzUn7ZewxmAZyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4PK3vSD/iEhqL4vVKqHWIdZpHJ3ktim5QaZoJFaTlUL41dfr4oCPIHU89vGU+1rURoImoav68WrU7Z4Q0jLn7Sfu9nKUp0XOPl7Sswe9wlgwouZgNZDRKYBR2e3YiYTQnOjUiIWz1Dm5c6fv1kNVFFfgyIEtaOgLMHx+A2go8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RhxSlsN0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD1gOtA2995881, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560502; bh=VXFTiZzUp+LZnQh94TRfgydUAJgzrvmKcsdmE1v2jK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RhxSlsN0gxXyVmzu4RMXVvpi0BAJhhMo6IlJwLsRSGwiIvloyT1eTIIomT8squpx+
	 rRm/gq1iKI6dPRiAwQEMGJIcG26Kk6dQFjQrlHBUPDcFUCXcTHDH5TjFHOwZzoB1gb
	 MgesyZ6TxbazZtZiRvkhkVRSbN3n0UIzy5Ua0E9OUHyO7r1zCK8XNlQQoSu1EHUugZ
	 1A6dpF5cy0hhesycUA92DhI31t9DcMRs9ggwpoml0zAplxqW67tL18qYAGqLNi9Gun
	 wQcU+C/XaEEAGhx4bQE1mY5Dp4MJKtGkflpizgBGlxQD4ZhdsxMMiuBzGt0JBuR7ZQ
	 SQX1YIG+hqqYA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD1gOtA2995881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:43 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/12] wifi: rtw89: mcc: enlarge TX retry count when GC auth
Date: Tue, 10 Jun 2025 21:00:33 +0800
Message-ID: <20250610130034.14692-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
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

The auth retry only continue 40ms, but the GO might switch to STA role
50ms when MCC. Therefore, enlarge the TX retry count from 32 to 60 to
let GC TX time overlapping with GO timeslot.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 9c4360df77f1..4026cda04ef6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4006,6 +4006,12 @@ int rtw89_core_sta_link_add(struct rtw89_dev *rtwdev,
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta_link,
 					 BTC_ROLE_MSTS_STA_CONN_START);
 		rtw89_chip_rfk_channel(rtwdev, rtwvif_link);
+
+		if (vif->p2p) {
+			rtw89_mac_get_tx_retry_limit(rtwdev, rtwsta_link,
+						     &rtwsta_link->tx_retry);
+			rtw89_mac_set_tx_retry_limit(rtwdev, rtwsta_link, false, 60);
+		}
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		ret = rtw89_mac_set_macid_pause(rtwdev, rtwsta_link->mac_id, false);
 		if (ret) {
@@ -4190,6 +4196,10 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 		}
 
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
+
+		if (vif->p2p)
+			rtw89_mac_set_tx_retry_limit(rtwdev, rtwsta_link, false,
+						     rtwsta_link->tx_retry);
 	}
 
 	rtw89_assoc_link_set(rtwsta_link);
@@ -4208,6 +4218,10 @@ int rtw89_core_sta_link_remove(struct rtw89_dev *rtwdev,
 		rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, false);
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta_link,
 					 BTC_ROLE_MSTS_STA_DIS_CONN);
+
+		if (vif->p2p)
+			rtw89_mac_set_tx_retry_limit(rtwdev, rtwsta_link, false,
+						     rtwsta_link->tx_retry);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta_link,
 						 RTW89_ROLE_REMOVE);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c017bdaf0500..342f6b379f86 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3385,6 +3385,7 @@ struct rtw89_sta_link {
 	unsigned int link_id;
 
 	u8 mac_id;
+	u8 tx_retry;
 	bool er_cap;
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_ra_info ra;
-- 
2.25.1


