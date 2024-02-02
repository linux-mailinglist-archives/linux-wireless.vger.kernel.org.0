Return-Path: <linux-wireless+bounces-2986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E48384665B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 04:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F6C1F27807
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEEFF4E3;
	Fri,  2 Feb 2024 03:07:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CD2F4E6
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843264; cv=none; b=lz6168lLXlECCnt+qtRRbukYGYAnZmvvcgd1SIGHZURFqrxGzieCWY8YoG6RUj/X3z7KskGm8T1Zz6Z7smBDP4cjwlKHBRJN7lhmidV7bZEWeSNbU/5jZJ2b62WEbtt8VCOf7Mdy6pnQUr2LVnxL8rSaF4tRaWQrbJF9rlQ73TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843264; c=relaxed/simple;
	bh=JQLuYbbSynmIdAO3iCAULezuzK17l3UzfnSUupjAhH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9BVd6Y5TnUTPVXrW6mn5Nm+f4pgnkph0SZWIvbqj6agrQdkJzyNZYAQdzvKbjNqJSJmMCUr5/sml774TJftyWsKsxtc21HOIK4SuurTi/HnYGtAVmlbgWXn9A4c3D1w8NS/+g7DCgMEzfm2olnoyV0A1aIbEg/SJtVN6POJ8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41237aiO61863093, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41237aiO61863093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:07:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 2 Feb 2024 11:07:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Feb
 2024 11:07:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 05/11] wifi: rtw89: rfk: add H2C command to trigger DPK
Date: Fri, 2 Feb 2024 11:06:36 +0800
Message-ID: <20240202030642.108385-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202030642.108385-1-pkshih@realtek.com>
References: <20240202030642.108385-1-pkshih@realtek.com>
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

DPK is short for digital pre-distortion calibration. It can adjusts digital
waveform according to PA linear characteristics dynamically to enhance
TX EVM.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 43 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h | 13 ++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f1239b00479d..1218bab049c3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4628,6 +4628,49 @@ int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return ret;
 }
 
+int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       RTW89_SUB_ENTITY_0);
+	struct rtw89_h2c_rf_dpk *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c RF DPK\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_rf_dpk *)skb->data;
+
+	h2c->len = len;
+	h2c->phy = phy_idx;
+	h2c->dpk_enable = true;
+	h2c->kpath = RF_AB;
+	h2c->cur_band = chan->band_type;
+	h2c->cur_bw = chan->band_width;
+	h2c->cur_ch = chan->channel;
+	h2c->dpk_dbg_en = rtw89_debug_is_enabled(rtwdev, RTW89_DBG_RFK);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
+			      H2C_FUNC_RFK_DPK_OFFLOAD, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 7e803abe47c6..f48d21a772aa 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3936,6 +3936,7 @@ enum rtw89_mcc_h2c_func {
 
 enum rtw89_rfk_offload_h2c_func {
 	H2C_FUNC_RFK_IQK_OFFLOAD = 0x1,
+	H2C_FUNC_RFK_DPK_OFFLOAD = 0x3,
 	H2C_FUNC_RFK_RXDCK_OFFLOAD = 0x6,
 	H2C_FUNC_RFK_PRE_NOTIFY = 0x8,
 };
@@ -3989,6 +3990,17 @@ struct rtw89_h2c_rf_iqk {
 	__le32 dbcc;
 } __packed;
 
+struct rtw89_h2c_rf_dpk {
+	u8 len;
+	u8 phy;
+	u8 dpk_enable;
+	u8 kpath;
+	u8 cur_band;
+	u8 cur_bw;
+	u8 cur_ch;
+	u8 dpk_dbg_en;
+} __packed;
+
 struct rtw89_h2c_rf_rxdck {
 	u8 len;
 	u8 phy;
@@ -4188,6 +4200,7 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
-- 
2.25.1


