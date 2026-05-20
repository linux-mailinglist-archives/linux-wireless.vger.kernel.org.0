Return-Path: <linux-wireless+bounces-36711-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JkBBaGsDWqP1QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36711-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:44:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A612F58E0BF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11C9A307B8B8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD643E1200;
	Wed, 20 May 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aeQ47zk9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548863438BA
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280743; cv=none; b=EiUaU07LKz+8nhBOCWUcKMM7kheiEopubYthXSO65sdjLpjQfFXUb829Aqlk4QKjCztjFKcau/42720RXpHWztLqeDV1Rd2KDY+H2gvdorThw2XJ/ATNy2YxAOsVEi0kHLLco4ZPL10Ew8PUEPnneyqaDXCJjnPSY6ChNDm69DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280743; c=relaxed/simple;
	bh=8A6lU5zhwlSvg3oVzdCNmlyOpl4RzpX6gkC2AhXsj0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bq4Rti0mieViVAgs9Snk/1r00LDnXooKxy8FBSfG0TnUXOSUYSkAF9nBBy9PxtGM7za3UnUH8IWER5axFFDYZV9eUmXunK38WrGF5GfCH1RK1btrMOF8KqlZIHbYjEeueMFNlC/UiTpnih40WwXur2Dew1epTwwEVqomySATF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aeQ47zk9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64KCcxVY3095609, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779280739; bh=ghHBzPM/F9Oo+ToAfd7a9DvAxKXCeLICsjfu14NN8UI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aeQ47zk9N51ZLctly1VzGgHoeBsB3VCREawxFIGuaap78RZKXY0Q560Fik009BEv7
	 Mq/3l56VlD7wjfMqW1xvK71T4ZLWBhqBM0W6L9EmtPJn+1CbYjR1uisyKQKxBqoNym
	 o4nrIL3oMpyZ0DpfeXXr6SdA4lyaxq45CSKMmE9UL7zNnIEQ/+vysbwDYiKJqpPf3X
	 DtqLQKiq/IQHd4Td7W5rJQTUUfp1cdm8AkSpfG2IBnVWHelgrnyTy9M+2zlW5Yq1Sr
	 s2Ynif7cuMSKFH3YH/6UQzfJTLUOjYEGUI1DivkbKXdxkIT7rk3dGvCKudY/xQ8WTn
	 SNne36TYkp2Qg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64KCcxVY3095609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 20:38:59 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:39:00 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:39:00 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 20 May 2026 20:39:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 7/7] wifi: rtw89: 8922d: configure TX shape settings
Date: Wed, 20 May 2026 20:38:23 +0800
Message-ID: <20260520123823.1792954-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260520123823.1792954-1-pkshih@realtek.com>
References: <20260520123823.1792954-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36711-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A612F58E0BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zong-Zhe Yang <kevin_yang@realtek.com>

By default, BB enables triangular spectrum by a series of register
settings. According to band and regulation, RF parameters determine whether
TX shape needs to be restricted or not. So now, clear the corresponding
settings if it has no need to do.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  4 ++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 61 +++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c0279e9e9bed..b704d3251e97 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -10622,6 +10622,8 @@
 #define R_RFSI_CT_OPT_0_BE4 0x11A94
 #define R_RFSI_CT_OPT_8_BE4 0x11A98
 #define R_QAM_COMP_TH0_BE4 0x11A9C
+#define B_QAM_COMP_TH_TRIANGULAR_L GENMASK(11, 10)
+#define B_QAM_COMP_TH_TRIANGULAR_H GENMASK(27, 26)
 #define R_QAM_COMP_TH1_BE4 0x11AA0
 #define R_QAM_COMP_TH2_BE4 0x11AA4
 #define R_QAM_COMP_TH3_BE4 0x11AA8
@@ -10645,6 +10647,8 @@
 #define B_QAM_COMP_TH6_2L GENMASK(9, 5)
 #define B_QAM_COMP_TH6_2M GENMASK(19, 15)
 #define R_OW_VAL_0_BE4 0x11AAC
+#define B_OW_VAL_TRIANGULAR_L GENMASK(11, 10)
+#define B_OW_VAL_TRIANGULAR_H GENMASK(27, 26)
 #define R_OW_VAL_1_BE4 0x11AB0
 #define R_OW_VAL_2_BE4 0x11AB4
 #define R_OW_VAL_3_BE4 0x11AB8
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 18af9211c2df..c38a38856398 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2680,6 +2680,66 @@ static void rtw8922d_set_txpwr_ref(struct rtw89_dev *rtwdev,
 				     B_BE_PWR_REF_CTRL_CCK, ref_cck);
 }
 
+static void rtw8922d_set_tx_shape(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_bb_wrap_data *d = rtwdev->phy_info.bb_wrap_data;
+	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
+	const struct rtw89_tx_shape *tx_shape = &rfe_parms->tx_shape;
+	u8 tx_shape_idx;
+	u8 band, regd;
+	const u16 *th;
+
+	band = chan->band_type;
+	regd = rtw89_regd_get(rtwdev, band);
+	tx_shape_idx = (*tx_shape->lmt)[band][RTW89_RS_OFDM][regd];
+
+	if (tx_shape_idx == 0)
+		goto disable;
+
+	th = d->bands[chan->rfsi_band].qam_comp_th0;
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH0_BE4, MASKLWORD, th[0], phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH0_BE4, MASKHWORD, th[1], phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH1_BE4, MASKLWORD, th[2], phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH1_BE4, MASKHWORD, th[3], phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH2_BE4, MASKLWORD, th[4], phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH2_BE4, MASKHWORD, th[5], phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH3_BE4, MASKLWORD, th[6], phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH3_BE4, MASKHWORD, th[7], phy_idx);
+
+	th = d->bands[chan->rfsi_band].qam_comp_ow;
+	rtw89_write32_idx(rtwdev, R_OW_VAL_0_BE4, MASKLWORD, th[0], phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_0_BE4, MASKHWORD, th[1], phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_1_BE4, MASKLWORD, th[2], phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_1_BE4, MASKHWORD, th[3], phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_2_BE4, MASKLWORD, th[4], phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_2_BE4, MASKHWORD, th[5], phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_3_BE4, MASKLWORD, th[6], phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_3_BE4, MASKHWORD, th[7], phy_idx);
+
+	return;
+
+disable:
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH0_BE4, B_QAM_COMP_TH_TRIANGULAR_L, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH0_BE4, B_QAM_COMP_TH_TRIANGULAR_H, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH1_BE4, B_QAM_COMP_TH_TRIANGULAR_L, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH1_BE4, B_QAM_COMP_TH_TRIANGULAR_H, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH2_BE4, B_QAM_COMP_TH_TRIANGULAR_L, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH2_BE4, B_QAM_COMP_TH_TRIANGULAR_H, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH3_BE4, B_QAM_COMP_TH_TRIANGULAR_L, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH3_BE4, B_QAM_COMP_TH_TRIANGULAR_H, 0, phy_idx);
+
+	rtw89_write32_idx(rtwdev, R_OW_VAL_0_BE4, B_OW_VAL_TRIANGULAR_L, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_0_BE4, B_OW_VAL_TRIANGULAR_H, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_1_BE4, B_OW_VAL_TRIANGULAR_L, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_1_BE4, B_OW_VAL_TRIANGULAR_H, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_2_BE4, B_OW_VAL_TRIANGULAR_L, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_2_BE4, B_OW_VAL_TRIANGULAR_H, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_3_BE4, B_OW_VAL_TRIANGULAR_L, 0, phy_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_3_BE4, B_OW_VAL_TRIANGULAR_H, 0, phy_idx);
+}
+
 static void rtw8922d_set_txpwr_sar_diff(struct rtw89_dev *rtwdev,
 					const struct rtw89_chan *chan,
 					enum rtw89_phy_idx phy_idx)
@@ -2711,6 +2771,7 @@ static void rtw8922d_set_txpwr(struct rtw89_dev *rtwdev,
 {
 	rtw89_phy_set_txpwr_byrate(rtwdev, chan, phy_idx);
 	rtw89_phy_set_txpwr_offset(rtwdev, chan, phy_idx);
+	rtw8922d_set_tx_shape(rtwdev, chan, phy_idx);
 	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
 	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
 	rtw8922d_set_txpwr_ref(rtwdev, chan, phy_idx);
-- 
2.25.1


