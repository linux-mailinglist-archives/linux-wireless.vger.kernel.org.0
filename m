Return-Path: <linux-wireless+bounces-28528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A24CC3036E
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 10:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14FF3B45B7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4C234D3B9;
	Tue,  4 Nov 2025 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z0gdqB27"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA33112C4
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247479; cv=none; b=DFdMjdqKYDweIeadECz43OqgBxF7vNQQm/UxjneFl0w3MxB0jBtMEcASutOfzcMtIcjgzfgOqAtOzitr56DrL+GqyjM1spKOnqSLczbAolkk+wTPeLbZWG/F4aUNuhLVM/w+A9pwZwr0OAdGr6BCowBNk+SDRya8mugcxMEyiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247479; c=relaxed/simple;
	bh=SYiJ+LrWJLGgsJPYCwMy4I+jvy8Y+wVuh1YjVSOHcjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISbeHF0EGrQ2paM+yBkQGPIGqEh48aGlevepqw5sJZhtCO8naViH1WFx95F4gG3AZyBwcWv8KYX/kjaeB+eceqiYexVvbiwbEhtCSnPbyVGxd39reOdO8ufnVD+P2B6Xfhi4verHDEVolYA+BwncCfzAsIDh+T2r75lhIb7zZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z0gdqB27; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A49BFhX43073547, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762247475; bh=UggJnsNR+fuVyREu7CnDoeP45O6c83K2PHvNvDjdrRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=Z0gdqB27lox1fwXm4F8Y07mHwKZK6gVcyisdtfX9JF5MZcirozfm8yDBi1GlE9wq1
	 QPwJn2Syr8J09FNhUF6B0lqaAfImTPdI79czln0iWb06vFS4ns6Dkl9klew46fJuxc
	 w/ksktT0nFE+iuTPnfBnMewBo5XxGkrpIie+fKh0FtXBewmgZaOrRvm954Z4CRxLxq
	 Ft9DqY76K3cFTRAFyqvuaN7GEkud3nBkM9vrD9s9m4HvI8X4hXXfwBLPHPG+P+Tbgs
	 MeCLEwR1kSRHUNq23oXc2cwZY1KzK8oWPvMYy13GIZy3TXSR48A+8/DlX4wy/lewha
	 yXZqLdMonCIUw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A49BFhX43073547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 17:11:15 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 17:11:15 +0800
Received: from [127.0.1.1] (172.21.146.58) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 17:11:15 +0800
From: <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 6/8] wifi: rtw89: consider data rate/bandwidth/GI for injected packets
Date: Tue, 4 Nov 2025 17:14:11 +0800
Message-ID: <1762247653-26864-7-git-send-email-pkshih@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
References: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ping-Ke Shih <pkshih@realtek.com>

To send injected packets with configurable rate/bandwidth/GI, fill TXWD
fields according to SKB's info->control.rates[0] annotated by mac80211.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 67 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  2 +
 2 files changed, 69 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1f92be300ea7..9bb3c05bb738 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -321,6 +321,26 @@ static const struct ieee80211_supported_band rtw89_sband_6ghz = {
 	.n_bitrates	= ARRAY_SIZE(rtw89_bitrates) - 4,
 };
 
+static const struct rtw89_hw_rate_def {
+	enum rtw89_hw_rate ht;
+	enum rtw89_hw_rate vht[RTW89_NSS_NUM];
+} rtw89_hw_rate[RTW89_CHIP_GEN_NUM] = {
+	[RTW89_CHIP_AX] = {
+		.ht = RTW89_HW_RATE_MCS0,
+		.vht = {RTW89_HW_RATE_VHT_NSS1_MCS0,
+			RTW89_HW_RATE_VHT_NSS2_MCS0,
+			RTW89_HW_RATE_VHT_NSS3_MCS0,
+			RTW89_HW_RATE_VHT_NSS4_MCS0},
+	},
+	[RTW89_CHIP_BE] = {
+		.ht = RTW89_HW_RATE_V1_MCS0,
+		.vht = {RTW89_HW_RATE_V1_VHT_NSS1_MCS0,
+			RTW89_HW_RATE_V1_VHT_NSS2_MCS0,
+			RTW89_HW_RATE_V1_VHT_NSS3_MCS0,
+			RTW89_HW_RATE_V1_VHT_NSS4_MCS0},
+	},
+};
+
 static void __rtw89_traffic_stats_accu(struct rtw89_traffic_stats *stats,
 				       struct sk_buff *skb, bool tx)
 {
@@ -1097,6 +1117,44 @@ rtw89_core_tx_wake(struct rtw89_dev *rtwdev,
 	rtw89_mac_notify_wake(rtwdev);
 }
 
+static void rtw89_core_tx_update_injection(struct rtw89_dev *rtwdev,
+					   struct rtw89_core_tx_request *tx_req,
+					   struct ieee80211_tx_info *info)
+{
+	const struct rtw89_hw_rate_def *hw_rate = &rtw89_hw_rate[rtwdev->chip->chip_gen];
+	enum mac80211_rate_control_flags flags = info->control.rates[0].flags;
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	const struct rtw89_chan *chan;
+	u8 idx = info->control.rates[0].idx;
+	u8 nss, mcs;
+
+	desc_info->use_rate = true;
+	desc_info->dis_data_fb = true;
+
+	if (flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
+		desc_info->data_bw = 3;
+	else if (flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+		desc_info->data_bw = 2;
+	else if (flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+		desc_info->data_bw = 1;
+
+	if (flags & IEEE80211_TX_RC_SHORT_GI)
+		desc_info->gi_ltf = 1;
+
+	if (flags & IEEE80211_TX_RC_VHT_MCS) {
+		nss = umin(idx >> 4, ARRAY_SIZE(hw_rate->vht) - 1);
+		mcs = idx & 0xf;
+		desc_info->data_rate = hw_rate->vht[nss] + mcs;
+	} else if (flags & IEEE80211_TX_RC_MCS) {
+		desc_info->data_rate = hw_rate->ht + idx;
+	} else {
+		chan = rtw89_chan_get(rtwdev, tx_req->rtwvif_link->chanctx_idx);
+
+		desc_info->data_rate = idx + (chan->band_type == RTW89_BAND_2G ?
+					      RTW89_HW_RATE_CCK1 : RTW89_HW_RATE_OFDM6);
+	}
+}
+
 static void
 rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
@@ -1152,6 +1210,9 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 		rtw89_core_tx_update_h2c_info(rtwdev, tx_req);
 		break;
 	}
+
+	if (unlikely(info->flags & IEEE80211_TX_CTL_INJECTED))
+		rtw89_core_tx_update_injection(rtwdev, tx_req, info);
 }
 
 static void rtw89_tx_wait_work(struct wiphy *wiphy, struct wiphy_work *work)
@@ -1381,6 +1442,8 @@ static __le32 rtw89_build_txwd_body5(struct rtw89_tx_desc_info *desc_info)
 static __le32 rtw89_build_txwd_body7_v1(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_BODY7_USE_RATE_V1, desc_info->use_rate) |
+		    FIELD_PREP(RTW89_TXWD_BODY7_DATA_BW, desc_info->data_bw) |
+		    FIELD_PREP(RTW89_TXWD_BODY7_GI_LTF, desc_info->gi_ltf) |
 		    FIELD_PREP(RTW89_TXWD_BODY7_DATA_RATE, desc_info->data_rate);
 
 	return cpu_to_le32(dword);
@@ -1389,6 +1452,8 @@ static __le32 rtw89_build_txwd_body7_v1(struct rtw89_tx_desc_info *desc_info)
 static __le32 rtw89_build_txwd_info0(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_INFO0_USE_RATE, desc_info->use_rate) |
+		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_BW, desc_info->data_bw) |
+		    FIELD_PREP(RTW89_TXWD_INFO0_GI_LTF, desc_info->gi_ltf) |
 		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_RATE, desc_info->data_rate) |
 		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_STBC, desc_info->stbc) |
 		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_LDPC, desc_info->ldpc) |
@@ -1568,6 +1633,8 @@ static __le32 rtw89_build_txwd_body6_v2(struct rtw89_tx_desc_info *desc_info)
 static __le32 rtw89_build_txwd_body7_v2(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(BE_TXD_BODY7_USERATE_SEL, desc_info->use_rate) |
+		    FIELD_PREP(BE_TXD_BODY7_DATA_BW, desc_info->data_bw) |
+		    FIELD_PREP(BE_TXD_BODY7_GI_LTF, desc_info->gi_ltf) |
 		    FIELD_PREP(BE_TXD_BODY7_DATA_ER, desc_info->er_cap) |
 		    FIELD_PREP(BE_TXD_BODY7_DATA_BW_ER, 0) |
 		    FIELD_PREP(BE_TXD_BODY7_DATARATE, desc_info->data_rate);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 01bfc5b473f5..02d9d42cdbb5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1178,6 +1178,8 @@ struct rtw89_tx_desc_info {
 	u8 sec_seq[6];
 	u16 data_rate;
 	u16 data_retry_lowest_rate;
+	u8 data_bw;
+	u8 gi_ltf;
 	bool fw_dl;
 	u16 seq;
 	bool a_ctrl_bsr;
-- 
2.25.1


