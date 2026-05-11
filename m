Return-Path: <linux-wireless+bounces-36202-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP9rNMV/AWqkbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36202-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:05:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AFA508DA2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 022713013A5A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358913B2A0;
	Mon, 11 May 2026 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TyZPdyl0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30503303A1E
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482950; cv=none; b=Z++o5JDvlW/GwgjzAM2MNsbXFin28LzbljQUjIfHF9/l5GAWtDDubUCfkVqnQlxVbxUxw3PRJ3SnyHyGfJO7igUTJyuPQ6yy0KAPWKv4Jh2XgXgEXWJ4n3/j5vyJou6QSCP+gSY5ravKTrw+HVrmGyy3FbcZU467y8Tvg3JS1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482950; c=relaxed/simple;
	bh=QI3DHKoEgZ+7oWYjqnjLT3U5B3nF4F9njZbQbXV+4xI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Azlr2SAl4lQc6WBxsTvQfQgk8hIWuE1fedgzARKX66GKpG/reKpuSR/TA5Qa2BaGCy+5KZ0wIwHvG7r27tp+bvrPbpNxCZPqhdue5ntUce49j9zxU2BQxoBdqxHeTs3HvJxM4ZJxfVjvWAf7GoIKqMAEh8CMkMFahhTgxElTU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TyZPdyl0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B72P4I02540509, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482945; bh=RQqgtRXXUdoP3ZavcVqfPtgKyqPUmRUb5SCAR7JP9Do=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TyZPdyl0n1cTKlKVf+LCpdqRAoBlm40WnDA1QY8lTHuW6MJDmsTRMvLG635uF8E5B
	 0piHe1aZ3Vx+oMRa5SuXdQpJFTJxbPKP/Wkxh9WEUtjCSV4ayC3sPzlQSTXVhhqG4m
	 1RDgFmSMDBY05lrE9VpouctieFJqVLBf9//cEEMU1zI51Wa/AViWUkrpwj+xXRmW3E
	 i27cEyvWJl5XLq59F4BQpljSczxvV4+hhywoCKBr4OmwMAIw1GGtQdumtwX8XtnY4s
	 VgkWxp6D0pfCcECJn77nR/HbZswzqDeRT01tCe0cRtFV8hlG6kKmQnkeWbdISpyrI/
	 uUtcv9bYCPRRA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B72P4I02540509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:02:25 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:26 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:02:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 06/11] wifi: rtw89: phy: set BB wrap of QAM options
Date: Mon, 11 May 2026 15:01:43 +0800
Message-ID: <20260511070148.25257-7-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 89AFA508DA2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36202-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

Apply these options to selected QAM to TX signal under requirements.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h      | 15 ++++
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 79 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 36 +++++++++
 3 files changed, 96 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index d2f443c98412..5a0ffc51ece2 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -597,10 +597,21 @@ enum rtw89_rfsi_ctrl_modulation {
 	RFSI_MAX,
 };
 
+#define MAX_TX_RFSI_CTRL_OPT 10
+
 #define _8nibble(n0, n1, n2, n3, n4, n5, n6, n7) \
 	((n0) << 0  | (n1) << 4  | (n2) << 8  | (n3) << 12 | \
 	 (n4) << 16 | (n5) << 20 | (n6) << 24 | (n7) << 28)
 
+#define _qam_comp_code(c) ((((c) & (BIT(15) | BIT(14))) >> 11) | \
+			   (((c) & BIT(12)) >> 10) | \
+			   (((c) & (BIT(9) | BIT(8))) >> 8))
+
+#define _10qam_comp_code(c0, c1, c2, c3, c4, c5, c6, c7, c8, c9) \
+	_qam_comp_code(c0), _qam_comp_code(c1),  _qam_comp_code(c2),  _qam_comp_code(c3), \
+	_qam_comp_code(c4), _qam_comp_code(c5),  _qam_comp_code(c6),  _qam_comp_code(c7), \
+	_qam_comp_code(c8), _qam_comp_code(c9)
+
 struct rtw89_bb_wrap_common_data {
 	struct {
 		u32 rfsi_ct_opt[2];
@@ -611,6 +622,10 @@ struct rtw89_bb_wrap_common_data {
 struct rtw89_bb_wrap_data {
 	const struct rtw89_bb_wrap_common_data *common;
 	struct {
+		u16 qam_comp_th0[MAX_TX_RFSI_CTRL_OPT];
+		u16 qam_comp_th1[MAX_TX_RFSI_CTRL_OPT]; /* encoded */
+		u16 qam_comp_th2[MAX_TX_RFSI_CTRL_OPT]; /* encoded */
+		u16 qam_comp_ow[MAX_TX_RFSI_CTRL_OPT];
 		u8 oob_dpd_by_cbw[8];
 	} bands[RFSI_CTRL_BAND_NUM];
 	u8 mdpd_by_dbw[4];
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index ca3cfdc90445..fc7f481783c0 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -788,40 +788,51 @@ static void rtw89_phy_bb_wrap_tx_rfsi_scenario_def(struct rtw89_dev *rtwdev,
 static void rtw89_phy_bb_wrap_tx_rfsi_qam_comp_val(struct rtw89_dev *rtwdev,
 						   enum rtw89_mac_idx mac_idx)
 {
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH0_BE4, MASKLWORD, 0x4010, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH0_BE4, MASKHWORD, 0x4410, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH1_BE4, MASKLWORD, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH1_BE4, MASKHWORD, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH2_BE4, MASKLWORD, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH2_BE4, MASKHWORD, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH3_BE4, MASKLWORD, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH3_BE4, MASKHWORD, 0x0, mac_idx);
-
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_L, 0x8, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_M, 0x8, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_H, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_L, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_M, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_H, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_L, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_M, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_2L, 0x8, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_2M, 0x8, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_2H, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_2L, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_2M, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_2H, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_2L, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_2M, 0x0, mac_idx);
-
-	rtw89_write32_idx(rtwdev, R_OW_VAL_0_BE4, MASKLWORD, 0x4010, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OW_VAL_0_BE4, MASKHWORD, 0x4010, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OW_VAL_1_BE4, MASKLWORD, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OW_VAL_1_BE4, MASKHWORD, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OW_VAL_2_BE4, MASKLWORD, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OW_VAL_2_BE4, MASKHWORD, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OW_VAL_3_BE4, MASKLWORD, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OW_VAL_3_BE4, MASKHWORD, 0x0, mac_idx);
+	const struct rtw89_bb_wrap_data *d = rtwdev->phy_info.bb_wrap_data;
+	const u16 *th;
+
+	if (!d || !d->common)
+		return;
+
+	th = d->bands[0].qam_comp_th0;
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH0_BE4, MASKLWORD, th[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH0_BE4, MASKHWORD, th[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH1_BE4, MASKLWORD, th[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH1_BE4, MASKHWORD, th[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH2_BE4, MASKLWORD, th[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH2_BE4, MASKHWORD, th[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH3_BE4, MASKLWORD, th[6], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH3_BE4, MASKHWORD, th[7], mac_idx);
+
+	th = d->bands[0].qam_comp_th1;
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_L, th[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_M, th[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_H, th[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_L, th[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_M, th[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_H, th[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_L, th[6], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_M, th[7], mac_idx);
+
+	th = d->bands[0].qam_comp_th2;
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_2L, th[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_2M, th[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_2H, th[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_2L, th[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_2M, th[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_2H, th[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_2L, th[6], mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_2M, th[7], mac_idx);
+
+	th = d->bands[0].qam_comp_ow;
+	rtw89_write32_idx(rtwdev, R_OW_VAL_0_BE4, MASKLWORD, th[0], mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_0_BE4, MASKHWORD, th[1], mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_1_BE4, MASKLWORD, th[2], mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_1_BE4, MASKHWORD, th[3], mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_2_BE4, MASKLWORD, th[4], mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_2_BE4, MASKHWORD, th[5], mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_3_BE4, MASKLWORD, th[6], mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_3_BE4, MASKHWORD, th[7], mac_idx);
 }
 
 static void rtw89_phy_bb_set_oob_dpd_qam_comp_val(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index a867652907bc..114f53ab9f7c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -316,10 +316,22 @@ static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7025_default = {
 	.common = &rtw8922d_bb_wrap_common_data_7025,
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.qam_comp_th0 = {0x4000, 0x6400, 0x6500, 0x6000, 0, 0, 0, 0, 0, 0},
+		.qam_comp_th1 = {_10qam_comp_code(0x4000, 0x6400, 0x6500, 0x6000,
+						  0, 0, 0, 0, 0, 0)},
+		.qam_comp_th2 = {_10qam_comp_code(0x4000, 0x4400, 0x4400, 0x4000,
+						  0, 0, 0, 0, 0, 0)},
+		.qam_comp_ow = {0x4000, 0x4400, 0x4400, 0x4000, 0, 0, 0, 0, 0, 0},
 		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
 				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
 	},
 	[RFSI_CTRL_BAND_2GHZ] = {
+		.qam_comp_th0 = {0x4000, 0x4400, 0x4500, 0, 0, 0, 0, 0, 0, 0},
+		.qam_comp_th1 = {_10qam_comp_code(0x4000, 0x4400, 0x4500, 0,
+						  0, 0, 0, 0, 0, 0)},
+		.qam_comp_th2 = {_10qam_comp_code(0x4000, 0x4400, 0x4400, 0,
+						  0, 0, 0, 0, 0, 0)},
+		.qam_comp_ow = {0x4000, 0x4400, 0x4400, 0, 0, 0, 0, 0, 0, 0},
 		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
 				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
 	}},
@@ -330,10 +342,22 @@ static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_default = {
 	.common = &rtw8922d_bb_wrap_common_data_7090,
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.qam_comp_th0 = {0x4000, 0x6420, 0x6520, 0x6000, 0, 0, 0, 0, 0, 0},
+		.qam_comp_th1 = {_10qam_comp_code(0x4000, 0x6400, 0x6500, 0x6000,
+						  0, 0, 0, 0, 0, 0)},
+		.qam_comp_th2 = {_10qam_comp_code(0x4000, 0x4400, 0x4400, 0x4000,
+						  0, 0, 0, 0, 0, 0)},
+		.qam_comp_ow = {0x4000, 0x4000, 0x4000, 0x4000, 0, 0, 0, 0, 0, 0},
 		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
 				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
 	},
 	[RFSI_CTRL_BAND_2GHZ] = {
+		.qam_comp_th0 = {0x4000, 0x4400, 0x4500, 0, 0, 0, 0, 0, 0, 0},
+		.qam_comp_th1 = {_10qam_comp_code(0x4000, 0x4400, 0x4500, 0, 0,
+						  0, 0, 0, 0, 0)},
+		.qam_comp_th2 = {_10qam_comp_code(0x4000, 0x4400, 0x4400, 0, 0,
+						  0, 0, 0, 0, 0)},
+		.qam_comp_ow = {0x4000, 0x4000, 0x4000, 0, 0, 0, 0, 0, 0, 0},
 		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
 				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
 	}},
@@ -344,10 +368,22 @@ static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_rfe35_41_44 =
 	.common = &rtw8922d_bb_wrap_common_data_7090,
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.qam_comp_th0 = {0x4000, 0x6420, 0x6520, 0x6000, 0, 0, 0, 0, 0, 0},
+		.qam_comp_th1 = {_10qam_comp_code(0x4000, 0x6400, 0x6500, 0x6000,
+						  0, 0, 0, 0, 0, 0)},
+		.qam_comp_th2 = {_10qam_comp_code(0x4000, 0x4400, 0x4400, 0x4000,
+						  0, 0, 0, 0, 0, 0)},
+		.qam_comp_ow = {0x4000, 0x4000, 0x4000, 0x4000, 0, 0, 0, 0, 0, 0},
 		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
 				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
 	},
 	[RFSI_CTRL_BAND_2GHZ] = {
+		.qam_comp_th0 = {0x4000, 0x4400, 0x4500, 0, 0, 0, 0, 0, 0, 0},
+		.qam_comp_th1 = {_10qam_comp_code(0x4000, 0x4400, 0x4500, 0, 0,
+						  0, 0, 0, 0, 0)},
+		.qam_comp_th2 = {_10qam_comp_code(0x4000, 0x4400, 0x4400, 0, 0,
+						  0, 0, 0, 0, 0)},
+		.qam_comp_ow = {0x4000, 0x4000, 0x4000, 0, 0, 0, 0, 0, 0, 0},
 		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
 				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
 	}},
-- 
2.25.1


