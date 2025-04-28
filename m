Return-Path: <linux-wireless+bounces-22136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC477A9EF05
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253EF3A5785
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FC86323;
	Mon, 28 Apr 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Nn9fnRZ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C5263F4B
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839557; cv=none; b=uhCBUPxn1BUVbZJND1f8J3gxwRYYNZrbWqCe/mAByDVRrtg5EOuq/5XVV+m0PlgdKNdge2tSFbwSCE5N9/JHzQBHKcPqZQpcjuCPOVsbFxWBtcNcVS0Su4VKiMIvFFEn6f53RxaFxLdfZ3p/YIbnHzVdomLjal6y7iLO+VAJXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839557; c=relaxed/simple;
	bh=dmvknZOOLAAUflNlWoXhZVZ6QSVezN7ad0/2IkDQEuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5M+WW8z+zZldEld7Happuax/kjV1uCGISjN/JQqOnLdHYPHU4SYynogXzNJCWBEcoa6prUBiapvJhdC3jOa6P6HBjUz4l16xNfHPsws0RSVhS66gq9mr87mWvBKGWWxCV8YlZ7wbhLcvA1RuYt2lP/to5tyiq2DyhjLDbpLj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Nn9fnRZ/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBPrP422101250, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839553; bh=dmvknZOOLAAUflNlWoXhZVZ6QSVezN7ad0/2IkDQEuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Nn9fnRZ/HWx2yDgQWNUoAF8PLI3FgIhetWjVgrAEkEFkFM5QsZJk0peS2mtlNUZmT
	 a8uNyQ8BETsbFoQZM7kjR6YfVBnHFzwZu0Lk8rgkeEAiFVS2CWDxzVEFfpIKs0DzV6
	 ehJ+25lwXJAHgug5HjaHMdq/9nPzoiM96q3RlAq61prAWoWgSKxsvIV4WJkjhc7hyo
	 iysbOUCgxBNJXzvzJW3aR6BdRKNfbIuqCQT0tBWL+VF7yDr/KBZTgNIsOO3ejylkTb
	 6Yg2fvc1YWZlfp6oQMG67oSUXa11Mjf2YexY/DNMw+ECZqdZqIyCM0TEb7diOT+oKG
	 Kb0VbT/LqXSXQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBPrP422101250
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:25:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:25:53 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:25:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/10] wifi: rtw89: extend join_info H2C command for MLO fields
Date: Mon, 28 Apr 2025 19:24:52 +0800
Message-ID: <20250428112456.13165-7-pkshih@realtek.com>
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

The join_info H2C command is used to indicate a station is connected and
tell FW to create/maintain an instance for it. Extend to fill MLO fields.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 26 +++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h |  2 ++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7d410cef9bd6..64895c27017f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4007,8 +4007,9 @@ rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_li
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			   struct rtw89_sta_link *rtwsta_link, bool dis_conn)
 {
-	struct sk_buff *skb;
 	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	bool is_mld = ieee80211_vif_is_mld(vif);
 	u8 self_role = rtwvif_link->self_role;
 	enum rtw89_fw_sta_type sta_type;
 	u8 net_type = rtwvif_link->net_type;
@@ -4016,6 +4017,8 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 	struct rtw89_h2c_join *h2c;
 	u32 len = sizeof(*h2c);
 	bool format_v1 = false;
+	struct sk_buff *skb;
+	u8 main_mac_id;
 	int ret;
 
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
@@ -4058,7 +4061,26 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 
 	sta_type = rtw89_fw_get_sta_type(rtwdev, rtwvif_link, rtwsta_link);
 
-	h2c_v1->w1 = le32_encode_bits(sta_type, RTW89_H2C_JOININFO_W1_STA_TYPE);
+	if (rtwsta_link)
+		main_mac_id = rtw89_sta_get_main_macid(rtwsta_link->rtwsta);
+	else
+		main_mac_id = rtw89_vif_get_main_macid(rtwvif_link->rtwvif);
+
+	h2c_v1->w1 = le32_encode_bits(sta_type, RTW89_H2C_JOININFO_W1_STA_TYPE) |
+		     le32_encode_bits(is_mld, RTW89_H2C_JOININFO_W1_IS_MLD) |
+		     le32_encode_bits(main_mac_id, RTW89_H2C_JOININFO_W1_MAIN_MACID) |
+		     le32_encode_bits(RTW89_H2C_JOININFO_MLO_MODE_MLSR,
+				      RTW89_H2C_JOININFO_W1_MLO_MODE) |
+		     le32_encode_bits(0, RTW89_H2C_JOININFO_W1_EMLSR_CAB) |
+		     le32_encode_bits(0, RTW89_H2C_JOININFO_W1_NSTR_EN) |
+		     le32_encode_bits(0, RTW89_H2C_JOININFO_W1_INIT_PWR_STATE) |
+		     le32_encode_bits(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US,
+				      RTW89_H2C_JOININFO_W1_EMLSR_PADDING) |
+		     le32_encode_bits(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US,
+				      RTW89_H2C_JOININFO_W1_EMLSR_TRANS_DELAY) |
+		     le32_encode_bits(0, RTW89_H2C_JOININFO_W2_MACID_EXT) |
+		     le32_encode_bits(0, RTW89_H2C_JOININFO_W2_MAIN_MACID_EXT);
+
 	h2c_v1->w2 = 0;
 
 done:
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index dd085a46b9e3..c7337bf46686 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1636,6 +1636,8 @@ struct rtw89_h2c_join_v1 {
 #define RTW89_H2C_JOININFO_W1_IS_MLD BIT(3)
 #define RTW89_H2C_JOININFO_W1_MAIN_MACID GENMASK(11, 4)
 #define RTW89_H2C_JOININFO_W1_MLO_MODE BIT(12)
+#define RTW89_H2C_JOININFO_MLO_MODE_MLMR 0
+#define RTW89_H2C_JOININFO_MLO_MODE_MLSR 1
 #define RTW89_H2C_JOININFO_W1_EMLSR_CAB BIT(13)
 #define RTW89_H2C_JOININFO_W1_NSTR_EN BIT(14)
 #define RTW89_H2C_JOININFO_W1_INIT_PWR_STATE BIT(15)
-- 
2.25.1


