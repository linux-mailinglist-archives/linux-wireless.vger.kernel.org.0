Return-Path: <linux-wireless+bounces-30925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D788DD38C4C
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 05:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5134300DB21
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 04:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A4F2FE567;
	Sat, 17 Jan 2026 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aMqSgkaO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6440818C02E
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624947; cv=none; b=Z6S2VhA451YNqmOZdYmiVyGlarbdRNvC0fDrvid7EKWkVPJXY/Pxn1Hvtn3hjY2kes7szC2LdjQ8eaELzX3RvFOVEAJ2Y/06B63MDVvhYKS6rf7X5jn/VZsf2hI6tXqm0nsgwk8s7osAljDa601Ze7wlWUj8OG8bHzw3baFhzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624947; c=relaxed/simple;
	bh=HwuXcijun5VMQhZzuubJSFOfWdjRGKpQdnCtLqRCohI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8S4u/Fsco79q9I6m+uNMNReJqUmbffQN81nH6GKPsAOXmI9f6mI9wGdo83Ih05hLpe8Bit0h4ZLu+Wv/X52j/9lFQz0DQbRMVdni21v2+0j73+4jV2lp5IOeTLXf/7bHDagX/vTl+osoqtzLk3oRaev8UDJXX8GA8s1wdK/TUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aMqSgkaO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60H4gNSd92464482, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768624943; bh=1z7w5RwY5F4Uc7nC5VU+3B99tD8YOnriSdP0hxpEqKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aMqSgkaOkDFXqWBalSIfzkN5425wK+kmuFXaPUCqR03dMoiazUpyBdAzDNSIFr5pB
	 u4ZrhYV9Go87LuZFHF4nELmarhtUBes1OuoE1aws3ab7YzNoR6EtsGTZMT5oc0Dkln
	 PArcheCxJNB7WMirqdB7HUx5/OEw61IfvM/pZ4+06e7jETH2hTkZHDKo34kukM4tcY
	 5KVutu0btXVmjjWF65+lZXE0iyPbzy7g+Z5y/jTOZho6M+fkvRPmynQJcKkwha6Lgu
	 b2lPYaH9QdC5BeY5v/mgmj8JV7TIlrz247xVW2Jz1DUIVvDVhfSjx3DbFtajiz2BjH
	 jOp530NqK787Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60H4gNSd92464482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 12:42:23 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:24 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 12:42:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 5/9] wifi: rtw89: phy: add firmware element of digital TX power compensation
Date: Sat, 17 Jan 2026 12:41:53 +0800
Message-ID: <20260117044157.2392958-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117044157.2392958-1-pkshih@realtek.com>
References: <20260117044157.2392958-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Define and set compensation value to corresponding frequency bands.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 23 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c   | 23 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  1 +
 4 files changed, 59 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 0b5509468582..c0af61992226 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -60,6 +60,28 @@ static enum rtw89_subband rtw89_get_subband_type(enum rtw89_band band,
 	}
 }
 
+static enum rtw89_tx_comp_band rtw89_get_tx_comp_band(enum rtw89_band band,
+						      u8 center_chan)
+{
+	switch (band) {
+	default:
+	case RTW89_BAND_2G:
+		return RTW89_TX_COMP_BAND_2GHZ;
+	case RTW89_BAND_5G:
+		if (center_chan < 149)
+			return RTW89_TX_COMP_BAND_5GHZ_L;
+		else
+			return RTW89_TX_COMP_BAND_5GHZ_H;
+	case RTW89_BAND_6G:
+		if (center_chan < 65)
+			return RTW89_TX_COMP_BAND_5GHZ_H;
+		else if (center_chan < 193)
+			return RTW89_TX_COMP_BAND_6GHZ_M;
+		else
+			return RTW89_TX_COMP_BAND_6GHZ_UH;
+	}
+}
+
 static enum rtw89_sc_offset rtw89_get_primary_chan_idx(enum rtw89_bandwidth bw,
 						       u32 center_freq,
 						       u32 primary_freq)
@@ -123,6 +145,7 @@ void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
 
 	chan->freq = center_freq;
 	chan->subband_type = rtw89_get_subband_type(band, center_chan);
+	chan->tx_comp_band = rtw89_get_tx_comp_band(band, center_chan);
 	chan->pri_ch_idx = rtw89_get_primary_chan_idx(bandwidth, center_freq,
 						      primary_freq);
 	chan->pri_sb_idx = rtw89_get_primary_sb_idx(center_chan, primary_chan,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 509357a1c072..c39ce15d30c8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -115,6 +115,16 @@ enum rtw89_subband {
 	RTW89_SUBBAND_2GHZ_5GHZ_NR = RTW89_CH_5G_BAND_4 + 1,
 };
 
+enum rtw89_tx_comp_band {
+	RTW89_TX_COMP_BAND_2GHZ,
+	RTW89_TX_COMP_BAND_5GHZ_L,
+	RTW89_TX_COMP_BAND_5GHZ_H,
+	RTW89_TX_COMP_BAND_6GHZ_M,
+	RTW89_TX_COMP_BAND_6GHZ_UH,
+
+	RTW89_TX_COMP_BAND_NR,
+};
+
 enum rtw89_gain_offset {
 	RTW89_GAIN_OFFSET_2G_CCK,
 	RTW89_GAIN_OFFSET_2G_OFDM,
@@ -991,6 +1001,7 @@ struct rtw89_chan {
 	 */
 	u32 freq;
 	enum rtw89_subband subband_type;
+	enum rtw89_tx_comp_band tx_comp_band;
 	enum rtw89_sc_offset pri_ch_idx;
 	u8 pri_sb_idx;
 };
@@ -4831,6 +4842,7 @@ struct rtw89_fw_elm_info {
 	const struct rtw89_regd_data *regd;
 	const struct rtw89_fw_element_hdr *afe;
 	const struct rtw89_fw_element_hdr *diag_mac;
+	const struct rtw89_fw_element_hdr *tx_comp;
 };
 
 enum rtw89_fw_mss_dev_type {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 329606a5bc20..46161e06a1d9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1382,6 +1382,26 @@ int rtw89_recognize_diag_mac_from_elm(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static
+int rtw89_build_tx_comp_from_elm(struct rtw89_dev *rtwdev,
+				 const struct rtw89_fw_element_hdr *elm,
+				 const union rtw89_fw_element_arg arg)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u16 aid;
+
+	aid = le16_to_cpu(elm->aid);
+	if (aid && aid != hal->aid)
+		return 1; /* ignore if aid not matched */
+	else if (elm_info->tx_comp)
+		return 1; /* ignore if an element is existing */
+
+	elm_info->tx_comp = elm;
+
+	return 0;
+}
+
 static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_BBMCU0] = {__rtw89_fw_recognize_from_elm,
 					{ .fw_type = RTW89_FW_BBMCU0 }, NULL},
@@ -1473,6 +1493,9 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_DIAG_MAC] = {
 		rtw89_recognize_diag_mac_from_elm, {}, NULL,
 	},
+	[RTW89_FW_ELEMENT_ID_TX_COMP] = {
+		rtw89_build_tx_comp_from_elm, {}, NULL,
+	},
 };
 
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 146403d285b4..521702f97d50 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4262,6 +4262,7 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_6GHZ = 26,
 	RTW89_FW_ELEMENT_ID_AFE_PWR_SEQ = 27,
 	RTW89_FW_ELEMENT_ID_DIAG_MAC = 28,
+	RTW89_FW_ELEMENT_ID_TX_COMP = 29,
 
 	RTW89_FW_ELEMENT_ID_NUM,
 };
-- 
2.25.1


