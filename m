Return-Path: <linux-wireless+bounces-2988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4CA84665D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 04:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE811C261DD
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DADBCA69;
	Fri,  2 Feb 2024 03:07:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72BC8C3
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843272; cv=none; b=kEx7MSiX2XFw1z/mkbojRQREbyUGb0VpdF+fjvAxHojr4wYYZrzDi6TlX1rOZX7drZHLJ9k40GgLEpOdi+jIsq1oneW/DaIyYUOx2Yhns8dhTpivH7PbB/JtNDtVcLKDjEjscYqi4sA4dhV+Q3p7cBu7cYTx16vlDEsoLmFl3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843272; c=relaxed/simple;
	bh=+67Zr/xwvvXL8p9hFUpjj7IuAu0AIVLcbOjuj4RV3HA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1Gt5jSnbD3aRsjdwWKWx1Rrr9OgKLNFqwugsSQeYNWU+uWg3a9TCLF20diNLLFo6nYH2uL1UA9W/fBEGJwtfwagfMDkgiUwKJZomwUKIjRh6b8bViU+x2GiBFKebpsHQnagjudHJYI2UlFIgBpCoOUmJQK46lOA8hZx7aQpNP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41237iq061863117, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41237iq061863117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:07:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 2 Feb 2024 11:07:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Feb
 2024 11:07:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/11] wifi: rtw89: rfk: add H2C command to trigger TXGAPK
Date: Fri, 2 Feb 2024 11:06:38 +0800
Message-ID: <20240202030642.108385-8-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

TXGAPK stands for TX power gap calibration. Use this calibration to
compensate TX power gap to output expected power.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 44 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h | 13 ++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5b6693ffa290..3f5e72209001 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4671,6 +4671,50 @@ int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return ret;
 }
 
+int rtw89_fw_h2c_rf_txgapk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       RTW89_SUB_ENTITY_0);
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_h2c_rf_txgapk *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c RF TXGAPK\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_rf_txgapk *)skb->data;
+
+	h2c->len = len;
+	h2c->ktype = 2;
+	h2c->phy = phy_idx;
+	h2c->kpath = RF_AB;
+	h2c->band = chan->band_type;
+	h2c->bw = chan->band_width;
+	h2c->ch = chan->channel;
+	h2c->cv = hal->cv;
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
+			      H2C_FUNC_RFK_TXGAPK_OFFLOAD, 0, 0, len);
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
 int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	struct rtw89_h2c_rf_dack *h2c;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 0fdc62fdd25a..666c3e7ec0d0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3937,6 +3937,7 @@ enum rtw89_mcc_h2c_func {
 enum rtw89_rfk_offload_h2c_func {
 	H2C_FUNC_RFK_IQK_OFFLOAD = 0x1,
 	H2C_FUNC_RFK_DPK_OFFLOAD = 0x3,
+	H2C_FUNC_RFK_TXGAPK_OFFLOAD = 0x4,
 	H2C_FUNC_RFK_DACK_OFFLOAD = 0x5,
 	H2C_FUNC_RFK_RXDCK_OFFLOAD = 0x6,
 	H2C_FUNC_RFK_PRE_NOTIFY = 0x8,
@@ -4002,6 +4003,17 @@ struct rtw89_h2c_rf_dpk {
 	u8 dpk_dbg_en;
 } __packed;
 
+struct rtw89_h2c_rf_txgapk {
+	u8 len;
+	u8 ktype;
+	u8 phy;
+	u8 kpath;
+	u8 band;
+	u8 bw;
+	u8 ch;
+	u8 cv;
+} __packed;
+
 struct rtw89_h2c_rf_dack {
 	__le32 len;
 	__le32 phy;
@@ -4208,6 +4220,7 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+int rtw89_fw_h2c_rf_txgapk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
-- 
2.25.1


