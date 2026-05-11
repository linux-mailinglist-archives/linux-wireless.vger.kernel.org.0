Return-Path: <linux-wireless+bounces-36207-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP5cMaR/AWqkbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36207-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:05:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE1508D85
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2700F30252A0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0CB29D26E;
	Mon, 11 May 2026 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="f6X5VyUX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDC19E839
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482976; cv=none; b=IxjHA2uOokULpVob7S227M57eyF99zO1ROH6EvLl5HPASCb78ZkWMsZftYLdaXqnBR/pwILj1NLLJZZAosWv0AZByRv7/ee1ICggvU1ucisLOOQjP3J198WOVSYpKtMnm/qyW8ADGRCW7UpLOFCL9k+FhWIgu3hbjC22BtY3tgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482976; c=relaxed/simple;
	bh=H8SpMG+7nzVhTkIVzQlVX5Y9weupRro729RveZShvgw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9FA6ubsN6BwicPGZfLOY8CzFNI1UEnCR/T1PgvQvpHyb8V1ZPJ9dP271vDXp2cZ27OHeJ8d1VncXA+zi6ofrE+/5G4nKAsMAttHzasI81bX+UN3Ly9YYdszyRe3xnoqEmzP1XRAVpBMh2YW7SRSWPXlaWujWLXHBwd/H4mCh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=f6X5VyUX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B72pttE2540775, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482971; bh=8rfEWSxrn2PbtwGh958yWT4vK5KM39L1INTB+fSbG6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=f6X5VyUXoSsYq6DT2UDtQqb8dns9FZujvcLnKGo6Kst7kXYscbAFjrb7uDNNaJ2om
	 WUQD7+mGEbWmwMAUKhnqjJ6hpP50cXZJEYVZJsue19Fy3T4lN9+3lo/4LriFkZW0iC
	 7726Io3wTUgmRhpsa8RjAllSUKUYBMamtyNmpFewd4++JcW1M+Huwin78jymHAy59S
	 P2q5O9bl4Zg5ONuSYu1s/7O2MC8vATwkG9nwZNBlg8DPcIKoxSJ59p2WdKwFC54FOr
	 EDi6KMeelGv9U7DQOtfbpix4WLx6+Ic0aob/+7VuONklLAJqQwGij1Uf0XC91rSMEX
	 K6erxSal9od2Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B72pttE2540775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:02:51 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:52 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:02:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 11/11] wifi: rtw89: phy: add BB wrapper generation 3 for RTL8922D variant
Date: Mon, 11 May 2026 15:01:48 +0800
Message-ID: <20260511070148.25257-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260511070148.25257-1-pkshih@realtek.com>
References: <20260511070148.25257-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 5CDE1508D85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36207-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The BB wrapper generation 3 support more settings to fine tune power
threshold and CCK CFIR/filter per RFSI band. Add them accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h      |  18 +++
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 112 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h      |  70 +++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  17 +++
 4 files changed, 212 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index ab3c8bb2e851..0a119b5f8159 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -600,6 +600,16 @@ enum rtw89_rfsi_ctrl_modulation {
 	RFSI_MAX,
 };
 
+enum rtw89_cfir_onoff {
+	CFIR_ON = 1,
+	CFIR_OFF = 0,
+};
+
+enum rtw89_filter_onoff {
+	FILTER_A_ON = 1,
+	FILTER_A_OFF = 0,
+};
+
 #define MAX_TX_RFSI_CTRL_OPT 10
 
 #define _8nibble(n0, n1, n2, n3, n4, n5, n6, n7) \
@@ -626,8 +636,16 @@ struct rtw89_bb_wrap_common_data {
 	u8 qam_th[6];
 };
 
+struct rtw89_bb_wrap_common_data_gen3 {
+	struct {
+		u8 qam_th[6];
+	} bands[RFSI_CTRL_BAND_NUM];
+	u8 cck_val[2];
+};
+
 struct rtw89_bb_wrap_data {
 	const struct rtw89_bb_wrap_common_data *common;
+	const struct rtw89_bb_wrap_common_data_gen3 *common_gen3;
 	struct {
 		u16 qam_comp_th0[MAX_TX_RFSI_CTRL_OPT];
 		u16 qam_comp_th1[MAX_TX_RFSI_CTRL_OPT]; /* encoded */
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 387a3e5fd15a..54c91ed4f73d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -769,6 +769,75 @@ static void rtw89_phy_bb_wrap_tx_rfsi_qam_comp_th_init(struct rtw89_dev *rtwdev,
 	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_TH2_BE4, 0x2, mac_idx);
 }
 
+static void rtw89_phy_bb_wrap_tx_rfsi_qam_comp_th_gen3_init(struct rtw89_dev *rtwdev,
+							    const struct rtw89_chan *chan,
+							    enum rtw89_mac_idx mac_idx)
+{
+	const struct rtw89_bb_wrap_data *d = rtwdev->phy_info.bb_wrap_data;
+	const struct rtw89_bb_wrap_common_data_gen3 *common_gen3;
+	const u8 *ths;
+
+	if (!d || !d->common_gen3)
+		return;
+
+	common_gen3 = d->common_gen3;
+	ths = common_gen3->bands[chan->rfsi_band].qam_th;
+
+	rtw89_write32_idx(rtwdev, R_QAM3_TH0_BE4, B_QAM3_TH0_0_BE4, ths[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH0_BE4, B_QAM3_TH0_1_BE4, ths[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH0_BE4, B_QAM3_TH0_2_BE4, ths[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH0_BE4, B_QAM3_TH0_3_BE4, ths[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH0_BE4, B_QAM3_TH0_4_BE4, ths[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH0_BE4, B_QAM3_TH0_5_BE4, ths[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH0_BE4, B_QAM3_TH0_6_BE4, ths[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH0_BE4, B_QAM3_TH0_7_BE4, ths[0], mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_QAM3_TH0_BE4, B_QAM3_TH1_0_BE4, ths[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH0_BE4, B_QAM3_TH1_1_BE4, ths[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH1_BE4, B_QAM3_TH1_2_BE4, ths[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH1_BE4, B_QAM3_TH1_3_BE4, ths[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH1_BE4, B_QAM3_TH1_4_BE4, ths[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH1_BE4, B_QAM3_TH1_5_BE4, ths[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH1_BE4, B_QAM3_TH1_6_BE4, ths[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH1_BE4, B_QAM3_TH1_7_BE4, ths[1], mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_QAM3_TH1_BE4, B_QAM3_TH2_0_BE4, ths[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH1_BE4, B_QAM3_TH2_1_BE4, ths[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH1_BE4, B_QAM3_TH2_2_BE4, ths[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH1_BE4, B_QAM3_TH2_3_BE4, ths[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH2_BE4, B_QAM3_TH2_4_BE4, ths[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH2_BE4, B_QAM3_TH2_5_BE4, ths[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH2_BE4, B_QAM3_TH2_6_BE4, ths[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH2_BE4, B_QAM3_TH2_7_BE4, ths[2], mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_QAM3_TH2_BE4, B_QAM3_TH3_0_BE4, ths[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH2_BE4, B_QAM3_TH3_1_BE4, ths[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH2_BE4, B_QAM3_TH3_2_BE4, ths[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH2_BE4, B_QAM3_TH3_3_BE4, ths[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH2_BE4, B_QAM3_TH3_4_BE4, ths[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH2_BE4, B_QAM3_TH3_5_BE4, ths[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH3_BE4, B_QAM3_TH3_6_BE4, ths[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH3_BE4, B_QAM3_TH3_7_BE4, ths[3], mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_TH4_0_BE4, ths[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_TH4_1_BE4, ths[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_TH4_2_BE4, ths[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_TH4_3_BE4, ths[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_TH4_4_BE4, ths[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_TH4_5_BE4, ths[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_TH4_6_BE4, ths[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_TH4_7_BE4, ths[4], mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_QAM3_TH3_BE4, B_QAM3_TH5_0_BE4, ths[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH3_BE4, B_QAM3_TH5_1_BE4, ths[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH3_BE4, B_QAM3_TH5_2_BE4, ths[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH3_BE4, B_QAM3_TH5_3_BE4, ths[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH3_BE4, B_QAM3_TH5_4_BE4, ths[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH3_BE4, B_QAM3_TH5_5_BE4, ths[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH3_BE4, B_QAM3_TH5_6_BE4, ths[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH3_BE4, B_QAM3_TH5_7_BE4, ths[5], mac_idx);
+}
+
 static void rtw89_phy_bb_wrap_tx_rfsi_scenario_def(struct rtw89_dev *rtwdev,
 						   enum rtw89_mac_idx mac_idx)
 {
@@ -987,6 +1056,39 @@ static void rtw89_phy_bb_set_cim3k_val(struct rtw89_dev *rtwdev,
 	rtw89_write32_idx(rtwdev, R_CIM3K_SU_FORCE, B_CIM3K_SU_FORCE_VAL, 0, mac_idx);
 }
 
+static void rtw89_phy_bb_set_cck_cfir_filter_val_gen3(struct rtw89_dev *rtwdev,
+						      enum rtw89_mac_idx mac_idx)
+{
+	const struct rtw89_bb_wrap_data *d = rtwdev->phy_info.bb_wrap_data;
+	const struct rtw89_bb_wrap_common_data_gen3 *common_gen3;
+	u8 cck0, cck1;
+
+	if (!d || !d->common_gen3)
+		return;
+
+	common_gen3 = d->common_gen3;
+	cck0 = common_gen3->cck_val[0];
+	cck1 = common_gen3->cck_val[1];
+
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_CFIR0_BE4, cck0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_CFIR1_BE4, cck0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_CFIR2_BE4, cck0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_CFIR3_BE4, cck0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_CFIR4_BE4, cck0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_CFIR5_BE4, cck0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_CFIR6_BE4, cck0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_TH4_BE4, B_QAM3_CFIR7_BE4, cck0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_QAM3_FLTR_BE4, B_QAM3_FLTR0_BE4, cck1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_FLTR_BE4, B_QAM3_FLTR1_BE4, cck1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_FLTR_BE4, B_QAM3_FLTR2_BE4, cck1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_FLTR_BE4, B_QAM3_FLTR3_BE4, cck1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_FLTR_BE4, B_QAM3_FLTR4_BE4, cck1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_FLTR_BE4, B_QAM3_FLTR5_BE4, cck1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_FLTR_BE4, B_QAM3_FLTR6_BE4, cck1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM3_FLTR_BE4, B_QAM3_FLTR7_BE4, cck1, mac_idx);
+}
+
 static void rtw89_phy_bb_wrap_tx_rfsi_ctrl_init(struct rtw89_dev *rtwdev,
 						enum rtw89_mac_idx mac_idx)
 {
@@ -998,18 +1100,18 @@ static void rtw89_phy_bb_wrap_tx_rfsi_ctrl_init(struct rtw89_dev *rtwdev,
 	if (chip_id != RTL8922D)
 		return;
 
+	rtw89_entity_get_conf(rtwdev, &conf);
+	chan = conf.chans[phy_idx];
+
 	rtw89_phy_bb_wrap_tx_rfsi_qam_comp_th_init(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_tx_rfsi_qam_comp_th_gen3_init(rtwdev, chan, mac_idx);
 	rtw89_phy_bb_wrap_tx_rfsi_scenario_def(rtwdev, mac_idx);
 	rtw89_phy_bb_wrap_tx_rfsi_qam_comp_val(rtwdev, mac_idx);
 	rtw89_phy_bb_set_oob_dpd_qam_comp_val(rtwdev, mac_idx);
 	rtw89_phy_bb_set_mdpd_qam_comp_val(rtwdev, mac_idx);
 	rtw89_phy_bb_set_cim3k_val(rtwdev, mac_idx);
-
+	rtw89_phy_bb_set_cck_cfir_filter_val_gen3(rtwdev, mac_idx);
 	rtw89_phy_bb_wrap_set_rfsi_ct_opt(rtwdev, 0, phy_idx);
-
-	rtw89_entity_get_conf(rtwdev, &conf);
-	chan = conf.chans[phy_idx];
-
 	rtw89_phy_bb_wrap_set_rfsi_bandedge_ch(rtwdev, chan, phy_idx);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index e46c32ec8e90..c9bfb163c32e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -10599,6 +10599,17 @@
 #define R_CIM3K_SU_FORCE 0x119F8
 #define B_CIM3K_SU_FORCE_EN BIT(17)
 #define B_CIM3K_SU_FORCE_VAL BIT(18)
+#define R_QAM3_TH0_BE4 0x119FC
+#define B_QAM3_TH0_0_BE4 GENMASK(2, 0)
+#define B_QAM3_TH0_1_BE4 GENMASK(5, 3)
+#define B_QAM3_TH0_2_BE4 GENMASK(8, 6)
+#define B_QAM3_TH0_3_BE4 GENMASK(11, 9)
+#define B_QAM3_TH0_4_BE4 GENMASK(14, 12)
+#define B_QAM3_TH0_5_BE4 GENMASK(17, 15)
+#define B_QAM3_TH0_6_BE4 GENMASK(20, 18)
+#define B_QAM3_TH0_7_BE4 GENMASK(23, 21)
+#define B_QAM3_TH1_0_BE4 GENMASK(26, 24)
+#define B_QAM3_TH1_1_BE4 GENMASK(29, 27)
 #define R_RFSI_CT_OPT_0_BE4 0x11A94
 #define R_RFSI_CT_OPT_8_BE4 0x11A98
 #define R_QAM_COMP_TH0_BE4 0x11A9C
@@ -10634,6 +10645,65 @@
 #define B_BANDEDGE_DBW80_BE4 BIT(31)
 #define R_BANDEDGE_DBWY_BE4 0x11AD0
 #define B_BANDEDGE_DBW160_BE4 BIT(0)
+#define R_QAM3_TH1_BE4 0x11BE8
+#define B_QAM3_TH1_2_BE4 GENMASK(2, 0)
+#define B_QAM3_TH1_3_BE4 GENMASK(5, 3)
+#define B_QAM3_TH1_4_BE4 GENMASK(8, 6)
+#define B_QAM3_TH1_5_BE4 GENMASK(11, 9)
+#define B_QAM3_TH1_6_BE4 GENMASK(14, 12)
+#define B_QAM3_TH1_7_BE4 GENMASK(17, 15)
+#define B_QAM3_TH2_0_BE4 GENMASK(20, 18)
+#define B_QAM3_TH2_1_BE4 GENMASK(23, 21)
+#define B_QAM3_TH2_2_BE4 GENMASK(26, 24)
+#define B_QAM3_TH2_3_BE4 GENMASK(29, 27)
+#define R_QAM3_TH2_BE4 0x11BEC
+#define B_QAM3_TH2_4_BE4 GENMASK(2, 0)
+#define B_QAM3_TH2_5_BE4 GENMASK(5, 3)
+#define B_QAM3_TH2_6_BE4 GENMASK(8, 6)
+#define B_QAM3_TH2_7_BE4 GENMASK(11, 9)
+#define B_QAM3_TH3_0_BE4 GENMASK(14, 12)
+#define B_QAM3_TH3_1_BE4 GENMASK(17, 15)
+#define B_QAM3_TH3_2_BE4 GENMASK(20, 18)
+#define B_QAM3_TH3_3_BE4 GENMASK(23, 21)
+#define B_QAM3_TH3_4_BE4 GENMASK(26, 24)
+#define B_QAM3_TH3_5_BE4 GENMASK(29, 27)
+#define R_QAM3_TH3_BE4 0x11BF4
+#define B_QAM3_TH3_6_BE4 GENMASK(2, 0)
+#define B_QAM3_TH3_7_BE4 GENMASK(5, 3)
+#define B_QAM3_TH5_0_BE4 GENMASK(8, 6)
+#define B_QAM3_TH5_1_BE4 GENMASK(11, 9)
+#define B_QAM3_TH5_2_BE4 GENMASK(14, 12)
+#define B_QAM3_TH5_3_BE4 GENMASK(17, 15)
+#define B_QAM3_TH5_4_BE4 GENMASK(20, 18)
+#define B_QAM3_TH5_5_BE4 GENMASK(23, 21)
+#define B_QAM3_TH5_6_BE4 GENMASK(26, 24)
+#define B_QAM3_TH5_7_BE4 GENMASK(29, 27)
+#define R_QAM3_TH4_BE4 0x11BF8
+#define B_QAM3_TH4_0_BE4 GENMASK(2, 0)
+#define B_QAM3_TH4_1_BE4 GENMASK(5, 3)
+#define B_QAM3_TH4_2_BE4 GENMASK(8, 6)
+#define B_QAM3_TH4_3_BE4 GENMASK(11, 9)
+#define B_QAM3_TH4_4_BE4 GENMASK(14, 12)
+#define B_QAM3_TH4_5_BE4 GENMASK(17, 15)
+#define B_QAM3_TH4_6_BE4 GENMASK(20, 18)
+#define B_QAM3_TH4_7_BE4 GENMASK(23, 21)
+#define B_QAM3_CFIR0_BE4 BIT(24)
+#define B_QAM3_CFIR1_BE4 BIT(25)
+#define B_QAM3_CFIR2_BE4 BIT(26)
+#define B_QAM3_CFIR3_BE4 BIT(27)
+#define B_QAM3_CFIR4_BE4 BIT(28)
+#define B_QAM3_CFIR5_BE4 BIT(29)
+#define B_QAM3_CFIR6_BE4 BIT(30)
+#define B_QAM3_CFIR7_BE4 BIT(31)
+#define R_QAM3_FLTR_BE4 0x11BFC
+#define B_QAM3_FLTR0_BE4 GENMASK(1, 0)
+#define B_QAM3_FLTR1_BE4 GENMASK(3, 2)
+#define B_QAM3_FLTR2_BE4 GENMASK(5, 4)
+#define B_QAM3_FLTR3_BE4 GENMASK(7, 6)
+#define B_QAM3_FLTR4_BE4 GENMASK(9, 8)
+#define B_QAM3_FLTR5_BE4 GENMASK(11, 10)
+#define B_QAM3_FLTR6_BE4 GENMASK(13, 12)
+#define B_QAM3_FLTR7_BE4 GENMASK(15, 14)
 
 #define R_SYS_DBCC_BE4 0x20000
 #define B_SYS_DBCC_BE4 BIT(0)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index ade89234afd6..c6c37e25e4c8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -320,8 +320,23 @@ static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7090
 	.qam_th = {RFSI_BPSK, RFSI_QPSK, RFSI_256QAM, RFSI_MAX, RFSI_MAX, RFSI_MAX},
 };
 
+static const
+struct rtw89_bb_wrap_common_data_gen3 rtw8922d_bb_wrap_common_data_gen3_7090 = {
+	.bands = {
+	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.qam_th = {RFSI_QPSK, RFSI_BPSK, RFSI_256QAM, RFSI_MAX,
+			   RFSI_MAX, RFSI_MAX},
+	},
+	[RFSI_CTRL_BAND_2GHZ] = {
+		.qam_th = {RFSI_MAX, RFSI_MAX, RFSI_256QAM, RFSI_MAX,
+			   RFSI_MAX, RFSI_MAX},
+	}},
+	.cck_val = {CFIR_OFF, FILTER_A_OFF},
+};
+
 static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7025_default = {
 	.common = &rtw8922d_bb_wrap_common_data_7025,
+	.common_gen3 = NULL,
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
 		.qam_comp_th0 = {0x4000, 0x6400, 0x6500, 0x6000, 0, 0, 0, 0, 0, 0},
@@ -348,6 +363,7 @@ static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7025_default = {
 
 static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_default = {
 	.common = &rtw8922d_bb_wrap_common_data_7090,
+	.common_gen3 = &rtw8922d_bb_wrap_common_data_gen3_7090,
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
 		.qam_comp_th0 = {0x4000, 0x6420, 0x6520, 0x6000, 0, 0, 0, 0, 0, 0},
@@ -374,6 +390,7 @@ static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_default = {
 
 static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_rfe35_41_44 = {
 	.common = &rtw8922d_bb_wrap_common_data_7090,
+	.common_gen3 = &rtw8922d_bb_wrap_common_data_gen3_7090,
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
 		.qam_comp_th0 = {0x4000, 0x6420, 0x6520, 0x6000, 0, 0, 0, 0, 0, 0},
-- 
2.25.1


