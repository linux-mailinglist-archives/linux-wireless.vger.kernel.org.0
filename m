Return-Path: <linux-wireless+bounces-36203-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN/iNld/AWqkbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36203-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:03:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 434CC508D12
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F34A3008766
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209130E85C;
	Mon, 11 May 2026 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CNtJuF2a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019B3B2A0
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482955; cv=none; b=I1XBbP9Y87Bc+zeU8PafSH6AEbgPHVzm40NogHFyLyQyz39COrwu/B3VgMejZ0IIR/hyf/AxTWWFYxRr+6Dq+PCVvSbK73Q3Bq3It/aQpG7sCMi9493Wuu85LyFCGpGse+UamWbE+hb3chKw+kHwgpQPRZK2LQvdVti3iQE8/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482955; c=relaxed/simple;
	bh=pY+sg7Zda8ZzLnGN2nNQl0ZpEI2HLABZCgbxt+f/laU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swOSOFoYqeVIU7YRN4W6xGswNqWePRFYmQ1XMpSWNQMVIHnrzozsxWfXtMfWf5PZWm5um4EaFw6wFieEEs/eq3Jy/NnbMaEJYgyvP7ROA7NIsgkqNnhO/YOQlFcuwtVUVyAeMBs892BtXGL7aqJF+yLlDQ4gvYIZ5Mondh+t89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CNtJuF2a; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B72UC902540526, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482950; bh=cQwv6aTILrIb0EUIul+MTpQL5QLGm9yzH4UqHanWR0U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CNtJuF2aw5e2OP5fwkD1U5CSqAvQ97nYQvAvTYCcbIL3uWwGiVATj55+3asdAB9MI
	 LTjplSPy1IT48upiwyXVZRBTn00BB4zenlMsmXk8jpCNth3+Ib21hjVI5rWzWvveHm
	 7PlIpbKlEa/r+CSzODo4TDTf64U0AYJTz/fBfpBoxGTU1XwhGf9ZeqOvjV1uhFfBZ+
	 DILhFMgMkyJPRkCx8zYKlvvCh2DP9ZIBA1HrD2pioI2jMDnAGkLoPzk/5ADtu5YLPc
	 7f9ZCpg1bP0Ko4eD2c1iLfjFTZj0GoUgrwcSzGIoEmpdk4v1zYeaLuqpwP/3hkpurT
	 OBp2G40QylW3g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B72UC902540526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:02:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:31 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:31 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:02:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 07/11] wifi: rtw89: phy: set BB wrap of trigger-base partial band
Date: Mon, 11 May 2026 15:01:44 +0800
Message-ID: <20260511070148.25257-8-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 434CC508D12
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
	TAGGED_FROM(0.00)[bounces-36203-lists,linux-wireless=lfdr.de];
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

Apply options to trigger-base partial band. For example, TX at RU-106 on
a 160MHz bandwidth.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h      | 1 +
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 8 +++++++-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 5a0ffc51ece2..51495701b102 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -615,6 +615,7 @@ enum rtw89_rfsi_ctrl_modulation {
 struct rtw89_bb_wrap_common_data {
 	struct {
 		u32 rfsi_ct_opt[2];
+		u8 pb_tb;
 	} bands[RFSI_CTRL_BAND_NUM];
 	u8 qam_th[6];
 };
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index fc7f481783c0..75806ffc6242 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -771,13 +771,19 @@ static void rtw89_phy_bb_wrap_tx_rfsi_qam_comp_th_init(struct rtw89_dev *rtwdev,
 static void rtw89_phy_bb_wrap_tx_rfsi_scenario_def(struct rtw89_dev *rtwdev,
 						   enum rtw89_mac_idx mac_idx)
 {
+	const struct rtw89_bb_wrap_data *d = rtwdev->phy_info.bb_wrap_data;
+	u8 pb_tb = 0;
+
+	if (d && d->common)
+		pb_tb = d->common->bands[0].pb_tb;
+
 	rtw89_write32_idx(rtwdev, R_RFSI_CT_DEF_BE4, B_RFSI_CT_ER_BE4, 0x0, mac_idx);
 	rtw89_write32_idx(rtwdev, R_RFSI_CT_DEF_BE4, B_RFSI_CT_SUBF_BE4, 0x0, mac_idx);
 	rtw89_write32_idx(rtwdev, R_RFSI_CT_DEF_BE4, B_RFSI_CT_FTM_BE4, 0x0, mac_idx);
 	rtw89_write32_idx(rtwdev, R_RFSI_CT_DEF_BE4, B_RFSI_CT_SENS_BE4, 0x0, mac_idx);
 
 	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_DEF_BE, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_PB_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_PB_BE4, pb_tb, mac_idx);
 	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_DL_WO_BE4, 0x0, mac_idx);
 	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_DL_BF_BE4, 0x0, mac_idx);
 	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_MUMIMO_BE4, 0x0, mac_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 114f53ab9f7c..15c44dd0d9fa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -291,10 +291,12 @@ static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7025
 	[RFSI_CTRL_BAND_5_6GHZ] = {
 		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
 				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
+		.pb_tb = 3,
 	},
 	[RFSI_CTRL_BAND_2GHZ] = {
 		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
 				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
+		.pb_tb = 0,
 	}},
 	.qam_th = {RFSI_BPSK, RFSI_QPSK, RFSI_256QAM, RFSI_MAX, RFSI_MAX, RFSI_MAX},
 };
@@ -304,10 +306,12 @@ static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7090
 	[RFSI_CTRL_BAND_5_6GHZ] = {
 		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
 				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
+		.pb_tb = 3,
 	},
 	[RFSI_CTRL_BAND_2GHZ] = {
 		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
 				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
+		.pb_tb = 0,
 	}},
 	.qam_th = {RFSI_BPSK, RFSI_QPSK, RFSI_256QAM, RFSI_MAX, RFSI_MAX, RFSI_MAX},
 };
-- 
2.25.1


