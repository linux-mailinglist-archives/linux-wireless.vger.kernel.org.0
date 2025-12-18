Return-Path: <linux-wireless+bounces-29893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A7CCA806
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A17F301843F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6025A32D0EA;
	Thu, 18 Dec 2025 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dccOvibG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98D329C6E
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039567; cv=none; b=iCRefqPkBdG1CfhzL410MO9bF+Hr8sAkEQbxprAhvjrMGfEaMaJRKv/gxzoExRLwy4At1NMFHrR7nKqhnzkMvg7+pkWh8ti090FNuHEqjq7FqPtTRfJsGqRy7K3mLCSFxaT2V7w1J/ZZaemWXboP0IM/DKx5hjwyiQPwGlMMBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039567; c=relaxed/simple;
	bh=5ouBFMJ8hobGrYLxJWKNjq28OiTR7bvcIHZj6Zjfvp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uErgrqtlauqaHhbXv2saspLMXA3HYg3KQ0pBh7ebFZIwYxjiDA3NCItKk1BgZFvbqgFT74o4Xf4rAmQZjC+eC2MKkBrH+Lv4yT9Mk94VwmAyJues3C9cofwSUeKHCqqNFzKhlCi5cb4lWkyyjbfB4ua80/0vaLYPhqqsNwFXoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dccOvibG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BI6WaiH63338903, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766039556; bh=vxnxHEZwLCnuIsf+o4mzDPG/8aBJrSzaOkcQ5CJm4CA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dccOvibGxHWd6vFPCJ9/VZL1r5DD7PbbxnaIXMGRKzV6egddxDoSRNHNET52lgHYP
	 Jff4t+yk71Kr6QVhyLAe8ueg9rPnKa0ycxsxLIiAZlexs2jSng7Rs6zjfmGM8628rk
	 63R9gwrFcdTf9gLL7LzSmpW93sQnql4G8V9Tdut6G6yXNKFRYuk5pH0O/lXa2/Oj9n
	 eiKluXGomRWCVQ/cQK10AhKx4hQiDuXWGt2uboN8NSsESigKtBa7K5nwR/wxKtvojC
	 9hEAZ6UM8rX6Vipbs2FCOv6NviWoNTMQKbdHpfe3kgB/vj7KsEMbFBhcvui8ZwRBZS
	 +L2A6fz5R2dpQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BI6WaiH63338903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 14:32:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:32:36 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:32:36 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Dec 2025 14:32:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 11/12] wifi: rtw89: setting TBTT AGG number when mac port initialization
Date: Thu, 18 Dec 2025 14:31:16 +0800
Message-ID: <20251218063117.26278-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251218063117.26278-1-pkshih@realtek.com>
References: <20251218063117.26278-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chih-Kang Chang <gary.chang@realtek.com>

When initializing mac port, needs to set TBTT AGG number to trigger TBTT
related interrupts. Otherwise, after sending join info H2C command with
disconnection mode, firmware will clear TBTT AGG number. Without the
setting from mac port initialization after that, this port will not be
able to transmit beacons.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8987077bf756..b7cb7a33f3d4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4446,6 +4446,7 @@ static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev,
 #define BCN_HOLD_DEF 200
 #define BCN_MASK_DEF 0
 #define TBTT_ERLY_DEF 5
+#define TBTT_AGG_DEF 1
 #define BCN_SET_UNIT 32
 #define BCN_ERLY_SET_DLY (10 * 2)
 
@@ -4749,6 +4750,16 @@ static void rtw89_mac_port_cfg_tbtt_early(struct rtw89_dev *rtwdev,
 				B_AX_TBTTERLY_MASK, TBTT_ERLY_DEF);
 }
 
+static void rtw89_mac_port_cfg_tbtt_agg(struct rtw89_dev *rtwdev,
+					struct rtw89_vif_link *rtwvif_link)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
+
+	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->tbtt_agg,
+				B_AX_TBTT_AGG_NUM_MASK, TBTT_AGG_DEF);
+}
+
 static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link)
 {
@@ -5009,6 +5020,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_tbtt_agg(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif_link, true);
-- 
2.25.1


