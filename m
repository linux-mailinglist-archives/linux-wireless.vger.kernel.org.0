Return-Path: <linux-wireless+bounces-12827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA0977931
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD4C1F244B2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14E81BA292;
	Fri, 13 Sep 2024 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CNxJvYaO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADB186E3D
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211670; cv=none; b=L4I0jCeRnFgwch1DYvXf9iFFCWYkvVeyql1hYKuPDn0f9bDWu+Mlk3s2thRvucMDWVZ4VKhC7hQVGiL5tptr90DZ+uxDvecE9cOaWn84jARSCplCVktCkBj6bX8xZuPPxs0AQPURNXFD9wh8MZ3/CrHMdHZSXDFkJ+Wu+vUl/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211670; c=relaxed/simple;
	bh=fBzHpdNPT6rdxC49PasvSJxLsm+Vu3e8XmGIFWa81UE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+qcZQ0dZEWuLCUFJhFQbZBInGFEU2jcHTqNOyAJT37FNGoiDDhYCiaCpZY1Jr0fXJcu5IjPjBjZEZSy6m3focxunHxYgDmIx80NQKTMWZqFQaGSoOYt540PuEWb3EZ53e7+6C3uBcgYWspaxybYC56QUlB+bTJ8vCG2B0tCdlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CNxJvYaO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48D7EOI202542230, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726211664; bh=fBzHpdNPT6rdxC49PasvSJxLsm+Vu3e8XmGIFWa81UE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CNxJvYaO64teLq2uvrgyN0QA7XNHd3RomPz49oCfkanX/C9X6MX1wDYNXeUZCkIBO
	 DcjHA1wCrtpYf2yfDcZh2RjQLMmMuTyKsD0FjGkHdPmzs/bWrq6ad4U1YszI7lvXp1
	 a78nF6Qq0/o6+AnUzrF5pzVKv9JCfrbSELZfDvVrU+PF0x6ivrOHBXYD7cGlM+q6Fx
	 tAje+W5J/2cAO5QmTK2Y6YJo5onwE576TTES14qz5nfGUVrC3KHUUm3QZyi/tzBouW
	 wtFAuf6rVeSo3J4s3EgbXYafm8lgqQuHgGm0a7hAhsPqSPHTDdB2PE7epb3pczj14x
	 uti0OyO2Kk5xw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48D7EOI202542230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 15:14:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 15:14:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 13 Sep
 2024 15:14:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] wifi: rtw89: rfk: add firmware debug log of TSSI
Date: Fri, 13 Sep 2024 15:13:38 +0800
Message-ID: <20240913071340.41822-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913071340.41822-1-pkshih@realtek.com>
References: <20240913071340.41822-1-pkshih@realtek.com>
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

TSSI is short for transmitter signal strength indication. Print out the
TSSI log from firmware C2H events.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  |  8 ++++++
 drivers/net/wireless/realtek/rtw89/phy.c | 35 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 78820bd28098..4980a7041fb8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4362,6 +4362,14 @@ struct rtw89_c2h_rf_rxdck_rpt_log {
 	u8 timeout[2];
 } __packed;
 
+struct rtw89_c2h_rf_tssi_rpt_log {
+	s8 alignment_power[2][2][4];
+	u8 alignment_power_cw_h[2][2][4];
+	u8 alignment_power_cw_l[2][2][4];
+	u8 tssi_alimk_state[2][2];
+	u8 default_txagc_offset[2][2];
+} __packed;
+
 struct rtw89_c2h_rf_txgapk_rpt_log {
 	__le32 r0x8010[2];
 	__le32 chk_cnt;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 0c0d25e602c9..c2116c2987fd 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2692,7 +2692,9 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 	struct rtw89_c2h_rf_txgapk_rpt_log *txgapk;
 	struct rtw89_c2h_rf_rxdck_rpt_log *rxdck;
 	struct rtw89_c2h_rf_dack_rpt_log *dack;
+	struct rtw89_c2h_rf_tssi_rpt_log *tssi;
 	struct rtw89_c2h_rf_dpk_rpt_log *dpk;
+	int i, j, k;
 
 	switch (func) {
 	case RTW89_PHY_C2H_RFK_LOG_FUNC_DPK:
@@ -2770,6 +2772,39 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 			    rxdck->ver, rxdck->band, rxdck->bw, rxdck->ch,
 			    rxdck->timeout);
 		return;
+	case RTW89_PHY_C2H_RFK_LOG_FUNC_TSSI:
+		if (len != sizeof(*tssi))
+			goto out;
+
+		tssi = content;
+		for (i = 0; i < 2; i++) {
+			for (j = 0; j < 2; j++) {
+				for (k = 0; k < 4; k++) {
+					rtw89_debug(rtwdev, RTW89_DBG_RFK,
+						    "[TSSI] alignment_power_cw_h[%d][%d][%d]=%d\n",
+						    i, j, k, tssi->alignment_power_cw_h[i][j][k]);
+					rtw89_debug(rtwdev, RTW89_DBG_RFK,
+						    "[TSSI] alignment_power_cw_l[%d][%d][%d]=%d\n",
+						    i, j, k, tssi->alignment_power_cw_l[i][j][k]);
+					rtw89_debug(rtwdev, RTW89_DBG_RFK,
+						    "[TSSI] alignment_power[%d][%d][%d]=%d\n",
+						    i, j, k, tssi->alignment_power[i][j][k]);
+					rtw89_debug(rtwdev, RTW89_DBG_RFK,
+						    "[TSSI] alignment_power_cw[%d][%d][%d]=%d\n",
+						    i, j, k,
+						    (tssi->alignment_power_cw_h[i][j][k] << 8) +
+						     tssi->alignment_power_cw_l[i][j][k]);
+				}
+
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[TSSI] tssi_alimk_state[%d][%d]=%d\n",
+					    i, j, tssi->tssi_alimk_state[i][j]);
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[TSSI] default_txagc_offset[%d]=%d\n",
+					    j, tssi->default_txagc_offset[0][j]);
+			}
+		}
+		return;
 	case RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK:
 		if (len != sizeof(*txgapk))
 			goto out;
-- 
2.25.1


