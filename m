Return-Path: <linux-wireless+bounces-11610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346259566BC
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E104F2848F4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E315C124;
	Mon, 19 Aug 2024 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bGRAjdoM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581E15DBAB
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059086; cv=none; b=Qk+Y2+91USXc2F9wIA0jSJhqZ6aAZnC1/C1rPWF6sBSMnbxaQOWyDJXml/IDKbl4PsJZYEIPBWe2/B5sT8ze2+unX59l5TJTZr2k2fXpZkOIiUkuJvcJBfz1T/oPzx6ghl1tI/RIvzuzIg7LaEGLo9rH1muyZQSOb8yZKqjOXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059086; c=relaxed/simple;
	bh=IJLV1djGS5+nGxME2FaHtnHIGJZA8YeMiFgEYrVBWbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPbkCT0FFNW7mtdO29Gq1EnSrsoiM1LJCcDoW0u+ZPWJnEeceUJL4uFn5Ip+m7m/W5gsbp1figmFlg6gtC3YInxzerckjpuVZCrZwgQYCZNpJcTAt0mQDa6h01VM67M/YzcGPijAJo1D04GvPq4TIL6pEdL5iC+X1m+pN6cPyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bGRAjdoM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J9I2ZX04126071, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724059082; bh=IJLV1djGS5+nGxME2FaHtnHIGJZA8YeMiFgEYrVBWbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bGRAjdoMvX5VFU0DMPmgxZFrGUyeq7owHkP4miUflLy9eWY/BVHDZ7QnubUkCznBS
	 ZMGdI/X4nQNTbVY/Mnyy+FgOY71r+9GBTJTeg6Mmj3K4XSOtLHCHdKPXeC7PnGDPom
	 7w6dmAOl2NJcFLM6lBxAWwfw1pqYz7A6GGxUvg+HTXa80BqCu1YCo5dkBxTK4lK+st
	 qdfu6nyXvlkh9VfpciKUQoMMKP2HFIFOC9nnnMnEv57wBXZ1dXDHY5G50uQxLXP0tT
	 35C0jqk+YfNR5SNKISOjh4RFV6dekMs2tWYZ2eQ2+9vkwN1arQqvgS4cvbwyMru8NQ
	 TzC5iue2MI6KQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J9I2ZX04126071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:18:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 17:18:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 17:18:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 6/8] wifi: rtw89: 8922a: use right chanctx whenever possible in RFK flow
Date: Mon, 19 Aug 2024 17:17:22 +0800
Message-ID: <20240819091724.33730-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819091724.33730-1-pkshih@realtek.com>
References: <20240819091724.33730-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

No longer access chan with hard-code RTW89_CHANCTX_X whenever possible.
Instead, obtain the right chanctx from somewhere and use it in RTL8922A
RFK (RF calibration) related code.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c       | 25 ++++++++-----------
 drivers/net/wireless/realtek/rtw89/fw.h       | 17 ++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.c      | 18 ++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.h      |  6 +++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 22 +++++++++-------
 5 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 47aa365991c1..e378aaef2d5a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5267,10 +5267,8 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
-			 enum rtw89_tssi_mode tssi_mode)
+			 const struct rtw89_chan *chan, enum rtw89_tssi_mode tssi_mode)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       RTW89_CHANCTX_0);
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_h2c_rf_tssi *h2c;
 	u32 len = sizeof(*h2c);
@@ -5314,7 +5312,8 @@ int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	return ret;
 }
 
-int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			const struct rtw89_chan *chan)
 {
 	struct rtw89_h2c_rf_iqk *h2c;
 	u32 len = sizeof(*h2c);
@@ -5349,10 +5348,9 @@ int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return ret;
 }
 
-int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       RTW89_CHANCTX_0);
 	struct rtw89_h2c_rf_dpk *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -5392,10 +5390,9 @@ int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return ret;
 }
 
-int rtw89_fw_h2c_rf_txgapk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+int rtw89_fw_h2c_rf_txgapk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			   const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       RTW89_CHANCTX_0);
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_h2c_rf_txgapk *h2c;
 	u32 len = sizeof(*h2c);
@@ -5436,7 +5433,8 @@ int rtw89_fw_h2c_rf_txgapk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return ret;
 }
 
-int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			 const struct rtw89_chan *chan)
 {
 	struct rtw89_h2c_rf_dack *h2c;
 	u32 len = sizeof(*h2c);
@@ -5472,10 +5470,9 @@ int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return ret;
 }
 
-int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       RTW89_CHANCTX_0);
 	struct rtw89_h2c_rf_rxdck *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 663eda5d0452..e6d8eea6f708 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4453,12 +4453,17 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
-			 enum rtw89_tssi_mode tssi_mode);
-int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-int rtw89_fw_h2c_rf_txgapk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+			 const struct rtw89_chan *chan, enum rtw89_tssi_mode tssi_mode);
+int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			const struct rtw89_chan *chan);
+int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			const struct rtw89_chan *chan);
+int rtw89_fw_h2c_rf_txgapk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			   const struct rtw89_chan *chan);
+int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			 const struct rtw89_chan *chan);
+int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  const struct rtw89_chan *chan);
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 7306fb679e95..59b98aa876dd 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3084,6 +3084,7 @@ EXPORT_SYMBOL(rtw89_phy_rfk_pre_ntfy_and_wait);
 
 int rtw89_phy_rfk_tssi_and_wait(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy_idx,
+				const struct rtw89_chan *chan,
 				enum rtw89_tssi_mode tssi_mode,
 				unsigned int ms)
 {
@@ -3091,7 +3092,7 @@ int rtw89_phy_rfk_tssi_and_wait(struct rtw89_dev *rtwdev,
 
 	rtw89_phy_rfk_report_prep(rtwdev);
 
-	ret = rtw89_fw_h2c_rf_tssi(rtwdev, phy_idx, tssi_mode);
+	ret = rtw89_fw_h2c_rf_tssi(rtwdev, phy_idx, chan, tssi_mode);
 	if (ret)
 		return ret;
 
@@ -3101,13 +3102,14 @@ EXPORT_SYMBOL(rtw89_phy_rfk_tssi_and_wait);
 
 int rtw89_phy_rfk_iqk_and_wait(struct rtw89_dev *rtwdev,
 			       enum rtw89_phy_idx phy_idx,
+			       const struct rtw89_chan *chan,
 			       unsigned int ms)
 {
 	int ret;
 
 	rtw89_phy_rfk_report_prep(rtwdev);
 
-	ret = rtw89_fw_h2c_rf_iqk(rtwdev, phy_idx);
+	ret = rtw89_fw_h2c_rf_iqk(rtwdev, phy_idx, chan);
 	if (ret)
 		return ret;
 
@@ -3117,13 +3119,14 @@ EXPORT_SYMBOL(rtw89_phy_rfk_iqk_and_wait);
 
 int rtw89_phy_rfk_dpk_and_wait(struct rtw89_dev *rtwdev,
 			       enum rtw89_phy_idx phy_idx,
+			       const struct rtw89_chan *chan,
 			       unsigned int ms)
 {
 	int ret;
 
 	rtw89_phy_rfk_report_prep(rtwdev);
 
-	ret = rtw89_fw_h2c_rf_dpk(rtwdev, phy_idx);
+	ret = rtw89_fw_h2c_rf_dpk(rtwdev, phy_idx, chan);
 	if (ret)
 		return ret;
 
@@ -3133,13 +3136,14 @@ EXPORT_SYMBOL(rtw89_phy_rfk_dpk_and_wait);
 
 int rtw89_phy_rfk_txgapk_and_wait(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx,
+				  const struct rtw89_chan *chan,
 				  unsigned int ms)
 {
 	int ret;
 
 	rtw89_phy_rfk_report_prep(rtwdev);
 
-	ret = rtw89_fw_h2c_rf_txgapk(rtwdev, phy_idx);
+	ret = rtw89_fw_h2c_rf_txgapk(rtwdev, phy_idx, chan);
 	if (ret)
 		return ret;
 
@@ -3149,13 +3153,14 @@ EXPORT_SYMBOL(rtw89_phy_rfk_txgapk_and_wait);
 
 int rtw89_phy_rfk_dack_and_wait(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy_idx,
+				const struct rtw89_chan *chan,
 				unsigned int ms)
 {
 	int ret;
 
 	rtw89_phy_rfk_report_prep(rtwdev);
 
-	ret = rtw89_fw_h2c_rf_dack(rtwdev, phy_idx);
+	ret = rtw89_fw_h2c_rf_dack(rtwdev, phy_idx, chan);
 	if (ret)
 		return ret;
 
@@ -3165,13 +3170,14 @@ EXPORT_SYMBOL(rtw89_phy_rfk_dack_and_wait);
 
 int rtw89_phy_rfk_rxdck_and_wait(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx,
+				 const struct rtw89_chan *chan,
 				 unsigned int ms)
 {
 	int ret;
 
 	rtw89_phy_rfk_report_prep(rtwdev);
 
-	ret = rtw89_fw_h2c_rf_rxdck(rtwdev, phy_idx);
+	ret = rtw89_fw_h2c_rf_rxdck(rtwdev, phy_idx, chan);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 512f17d808fe..6dd8ec46939a 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -907,22 +907,28 @@ int rtw89_phy_rfk_pre_ntfy_and_wait(struct rtw89_dev *rtwdev,
 				    unsigned int ms);
 int rtw89_phy_rfk_tssi_and_wait(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy_idx,
+				const struct rtw89_chan *chan,
 				enum rtw89_tssi_mode tssi_mode,
 				unsigned int ms);
 int rtw89_phy_rfk_iqk_and_wait(struct rtw89_dev *rtwdev,
 			       enum rtw89_phy_idx phy_idx,
+			       const struct rtw89_chan *chan,
 			       unsigned int ms);
 int rtw89_phy_rfk_dpk_and_wait(struct rtw89_dev *rtwdev,
 			       enum rtw89_phy_idx phy_idx,
+			       const struct rtw89_chan *chan,
 			       unsigned int ms);
 int rtw89_phy_rfk_txgapk_and_wait(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx,
+				  const struct rtw89_chan *chan,
 				  unsigned int ms);
 int rtw89_phy_rfk_dack_and_wait(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy_idx,
+				const struct rtw89_chan *chan,
 				unsigned int ms);
 int rtw89_phy_rfk_rxdck_and_wait(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx,
+				 const struct rtw89_chan *chan,
 				 unsigned int ms);
 void rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(struct rtw89_dev *rtwdev,
 					       enum rtw89_phy_idx phy,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index d67bbbffb94e..85bdeeda95de 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1993,10 +1993,12 @@ static void rtw8922a_rfk_init(struct rtw89_dev *rtwdev)
 
 static void rtw8922a_rfk_init_late(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+
 	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, RTW89_PHY_0, 5);
 
-	rtw89_phy_rfk_dack_and_wait(rtwdev, RTW89_PHY_0, 58);
-	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, 32);
+	rtw89_phy_rfk_dack_and_wait(rtwdev, RTW89_PHY_0, chan, 58);
+	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, chan, 32);
 }
 
 static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
@@ -2020,8 +2022,10 @@ static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 
 static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, chanctx_idx);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_CHLK, BTC_WRFK_START);
@@ -2029,11 +2033,11 @@ static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtw
 	_wait_rx_mode(rtwdev, RF_AB);
 
 	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, phy_idx, 5);
-	rtw89_phy_rfk_txgapk_and_wait(rtwdev, phy_idx, 54);
-	rtw89_phy_rfk_iqk_and_wait(rtwdev, phy_idx, 84);
-	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, RTW89_TSSI_NORMAL, 6);
-	rtw89_phy_rfk_dpk_and_wait(rtwdev, phy_idx, 34);
-	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, 32);
+	rtw89_phy_rfk_txgapk_and_wait(rtwdev, phy_idx, chan, 54);
+	rtw89_phy_rfk_iqk_and_wait(rtwdev, phy_idx, chan, 84);
+	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, chan, RTW89_TSSI_NORMAL, 6);
+	rtw89_phy_rfk_dpk_and_wait(rtwdev, phy_idx, chan, 34);
+	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, chan, 32);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_CHLK, BTC_WRFK_STOP);
@@ -2043,7 +2047,7 @@ static void rtw8922a_rfk_band_changed(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx,
 				      const struct rtw89_chan *chan)
 {
-	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, RTW89_TSSI_SCAN, 6);
+	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, chan, RTW89_TSSI_SCAN, 6);
 }
 
 static void rtw8922a_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
-- 
2.25.1


