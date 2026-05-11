Return-Path: <linux-wireless+bounces-36200-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAjYKgR/AWqkbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36200-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:02:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C8508CAA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 257C7301455A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547B19E839;
	Mon, 11 May 2026 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="csmGxi9z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26A30E85C
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482941; cv=none; b=Fte0/t1AXQSl0f7n2vVkLH2UZ3EWt4LKH/Pjkk+zr1Pof38TTWapjntp3KhQzjiNnN0iJiCFhWcYVSVvzPIL1xd7WkIs2gse08K+5bfj7hY1RkSgJk/NlwqhZltdhe10xZhAFeFas9UHsxSLkTUO5HWRdpXRRIpMgKOmLbgKmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482941; c=relaxed/simple;
	bh=hj8M9TgIcPXA9AmkazJeZDmWZRV4FOMs8sxQSRwjC14=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5TFQxOu8XgqO7coSQlwGJyWTQiyzNL2TCyDO9OO0ITwJnO5/5c1z60QXm9Qr4GtsVfqAR1a+zSQlJBdmFO4T5AYq4zGEH+JkNdckudCHIzcz9bVId7HDazN1R/RhHQakZazbL7qmpMHDhSB0vZ/fcW5bwGqNaTw1UuLRcWksKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=csmGxi9z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B72DZk82540475, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482934; bh=MZ4rPwLkNnhuuxmhxCb9rT3cuXHj5rEsYn519J9LYWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=csmGxi9z80g2c/MmxWOycS5JmqfdutLY4CM/yKA79/JsPZU3CvTsqlikMm5bAnno9
	 46gDxRRoR7atObhzkoEOWL6pm1GwhZIOK7Ke0EPPCjgC0pkgw2qdE7rwTj1ubQ23WB
	 eWW4OtvmY8293qFCIyNGFuBg0likI32iIATJSmmGzq0hi2wRIfG4aTTxFIj+zLvFCE
	 fFay4WXFJeyh1MbA1BEBlfZsnlW7cdmnHSYjsUm3xhljdIK29lPdK45mTSXybJPcjc
	 3qJsgkzPWI8xIcZMerzaEywnLNXvFUF4VnBis0cohJqf5qfNasAom/RVeDLLEjZKEd
	 RoiY3fAKVhSiQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B72DZk82540475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:02:14 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:14 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:02:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 04/11] wifi: rtw89: phy: set BB wrap of control options
Date: Mon, 11 May 2026 15:01:41 +0800
Message-ID: <20260511070148.25257-5-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 392C8508CAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36200-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

Set main options to control BB wrap functions. For example, enable options
by data bandwidth or channel bandwidth.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h      | 11 ++++++++
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 11 ++++++--
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 27 +++++++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index c7cf99fe46fb..a3e12590f473 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -586,7 +586,18 @@ enum rtw89_oob_dpd_onoff {
 	OOB_DPD_ON = 1,
 };
 
+#define _8nibble(n0, n1, n2, n3, n4, n5, n6, n7) \
+	((n0) << 0  | (n1) << 4  | (n2) << 8  | (n3) << 12 | \
+	 (n4) << 16 | (n5) << 20 | (n6) << 24 | (n7) << 28)
+
+struct rtw89_bb_wrap_common_data {
+	struct {
+		u32 rfsi_ct_opt[2];
+	} bands[RFSI_CTRL_BAND_NUM];
+};
+
 struct rtw89_bb_wrap_data {
+	const struct rtw89_bb_wrap_common_data *common;
 	struct {
 		u8 oob_dpd_by_cbw[8];
 	} bands[RFSI_CTRL_BAND_NUM];
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 4ba18e821578..c52306b9fec4 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -648,13 +648,20 @@ static u32 rtw89_phy_bb_wrap_be_bandedge_decision(struct rtw89_dev *rtwdev,
 void rtw89_phy_bb_wrap_set_rfsi_ct_opt(struct rtw89_dev *rtwdev,
 				       enum rtw89_phy_idx phy_idx)
 {
+	const struct rtw89_bb_wrap_data *d = rtwdev->phy_info.bb_wrap_data;
+	const u32 *val;
 	u32 reg;
 
+	if (!d || !d->common)
+		return;
+
+	val = d->common->bands[0].rfsi_ct_opt;
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_RFSI_CT_OPT_0_BE4, phy_idx);
-	rtw89_write32(rtwdev, reg, 0x00010001);
+	rtw89_write32(rtwdev, reg, val[0]);
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_RFSI_CT_OPT_8_BE4, phy_idx);
-	rtw89_write32(rtwdev, reg, 0x00010001);
+	rtw89_write32(rtwdev, reg, val[1]);
 }
 EXPORT_SYMBOL(rtw89_phy_bb_wrap_set_rfsi_ct_opt);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 2e5e264e75db..18d75184f82b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -286,7 +286,32 @@ static const struct rtw89_efuse_block_cfg rtw8922d_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_ADIE]		= {.offset = 0x70000, .size = 0x10},
 };
 
+static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7025 = {
+	.bands = {
+	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
+				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
+	},
+	[RFSI_CTRL_BAND_2GHZ] = {
+		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
+				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
+	}},
+};
+
+static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7090 = {
+	.bands = {
+	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
+				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
+	},
+	[RFSI_CTRL_BAND_2GHZ] = {
+		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
+				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
+	}},
+};
+
 static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7025_default = {
+	.common = &rtw8922d_bb_wrap_common_data_7025,
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
 		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
@@ -300,6 +325,7 @@ static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7025_default = {
 };
 
 static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_default = {
+	.common = &rtw8922d_bb_wrap_common_data_7090,
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
 		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
@@ -313,6 +339,7 @@ static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_default = {
 };
 
 static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_rfe35_41_44 = {
+	.common = &rtw8922d_bb_wrap_common_data_7090,
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
 		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
-- 
2.25.1


