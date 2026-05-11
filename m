Return-Path: <linux-wireless+bounces-36204-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ20IWB/AWqkbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36204-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:04:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EC4508D28
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D787301DE24
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D030274D;
	Mon, 11 May 2026 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="f51r3zYC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098F2DA75C
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482960; cv=none; b=ukwhRIru9Ay7VXyB/1sMbDZTScCFa/pobmAORfcytpFk+Aok9ycV26opszSqILV82HU9je4jJjEIEVhjiNkDyLtuPuf6YOfB1TNSAz5pTr5hHiFWyeYt/fxzXs0N5g9a7vHAAAJaxxSqfjkGjlFKC0wnW99rrm/E8nj/MjAtRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482960; c=relaxed/simple;
	bh=GvChBfjZmcrWgQCsywkXS7q5/QCdk15CduA5bop7SGE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAVm61s00HOI2Pd7EcOq0IpfFfK/z9SapVrGSAzwFi3Vd5XZHzVOq7jVFFbz5zIzlOItit5+L+pOSyOOFRu2WN+Yi7aH5tCRjJ/dxLxA9K5fzysek7heXfG9dYucdHw3ME4mdVAetIo1BbM3TUltXv/w5uPJ2l4qOuZ4JwMujtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=f51r3zYC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B72ZqwC2540545, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482956; bh=fa7XKveUo1vOFtB2/snh6WXWOKa4iEfOJm8abqXlCAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=f51r3zYCUL0LbF4Hs4KqKXzWT78ZhFe27Px1u9n7qvzshLbnIg6RMtuj6M1Y++1se
	 4apVfI7mGyn6oMlBrhBabxGShe/2NuxhqcftREJjJ/C6XDzzvXdJQ0LvHKqXNbD8n9
	 EPUn/VnDZIID4oUQ6u12/3skLoicN1cO8/1peRr4t4g1rgKMab9cia53H2ZWPc56/D
	 vdZf9ADpF/HKjPqEzm9jEYguo9tW+Qoo3VgehxyBGAGpCwIOGcdqGiUAtPb5wZFD6z
	 bBvTBAs1A6of3jFesGtaXxKKoVENR4AFgXEADBTNORuXMZN+icg4JKpZtwJer3Jtwb
	 ZCOETeal7eCHQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B72ZqwC2540545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:02:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:36 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:36 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:02:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 08/11] wifi: rtw89: phy: set BB wrap of CIM3K
Date: Mon, 11 May 2026 15:01:45 +0800
Message-ID: <20260511070148.25257-9-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 20EC4508D28
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
	TAGGED_FROM(0.00)[bounces-36204-lists,linux-wireless=lfdr.de];
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

The options to enable calibrations of CIM 3rd-order for threshold,
non-bandedge and bandedge.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h      | 13 ++++++++++
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 24 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/reg.h      |  3 +++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  4 ++++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 51495701b102..bfe647b2de25 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -586,6 +586,16 @@ enum rtw89_oob_dpd_onoff {
 	OOB_DPD_ON = 1,
 };
 
+enum rtw89_cim3k_onoff {
+	CIM3K_ON = 1,
+	CIM3K_OFF = 0,
+};
+
+enum rtw89_cim3k_en_dis {
+	CIM3K_ENABLE = 1,
+	CIM3K_DISABLE = 0,
+};
+
 enum rtw89_rfsi_ctrl_modulation {
 	RFSI_BPSK = 0,
 	RFSI_QPSK = 1,
@@ -614,6 +624,9 @@ enum rtw89_rfsi_ctrl_modulation {
 
 struct rtw89_bb_wrap_common_data {
 	struct {
+		struct rtw89_bb_wrap_data_cim3k {
+			u8 th, ow, non_bandedge, bandedge;
+		} cim3k;
 		u32 rfsi_ct_opt[2];
 		u8 pb_tb;
 	} bands[RFSI_CTRL_BAND_NUM];
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 75806ffc6242..f8e25167b44d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -964,10 +964,26 @@ static void rtw89_phy_bb_set_mdpd_qam_comp_val(struct rtw89_dev *rtwdev,
 static void rtw89_phy_bb_set_cim3k_val(struct rtw89_dev *rtwdev,
 				       enum rtw89_mac_idx mac_idx)
 {
-	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_TH_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_OW_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_NONBE_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_BANDEDGE_BE4, 0x1, mac_idx);
+	const struct rtw89_bb_wrap_data *d = rtwdev->phy_info.bb_wrap_data;
+	const struct rtw89_bb_wrap_data_cim3k *p;
+
+	if (!d || !d->common)
+		return;
+
+	p = &d->common->bands[0].cim3k;
+
+	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_TH_BE4, p->th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_OW_BE4, p->ow, mac_idx);
+	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_NONBE_BE4,
+			  p->non_bandedge, mac_idx);
+	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_BANDEDGE_BE4,
+			  p->bandedge, mac_idx);
+
+	if (rtwdev->chip->chip_id != RTL8922D)
+		return;
+
+	rtw89_write32_idx(rtwdev, R_CIM3K_SU_FORCE, B_CIM3K_SU_FORCE_EN, 1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_CIM3K_SU_FORCE, B_CIM3K_SU_FORCE_VAL, 0, mac_idx);
 }
 
 static void rtw89_phy_bb_wrap_tx_rfsi_ctrl_init(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 716747c3a10e..e46c32ec8e90 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -10596,6 +10596,9 @@
 #define B_FBTB_CT_MUMIMO_BE4 GENMASK(19, 16)
 #define B_FBTB_CT_FTM_BE4 GENMASK(23, 20)
 #define B_FBTB_CT_SENS_BE4 GENMASK(27, 24)
+#define R_CIM3K_SU_FORCE 0x119F8
+#define B_CIM3K_SU_FORCE_EN BIT(17)
+#define B_CIM3K_SU_FORCE_VAL BIT(18)
 #define R_RFSI_CT_OPT_0_BE4 0x11A94
 #define R_RFSI_CT_OPT_8_BE4 0x11A98
 #define R_QAM_COMP_TH0_BE4 0x11A9C
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 15c44dd0d9fa..ec94067aa1a5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -289,11 +289,13 @@ static const struct rtw89_efuse_block_cfg rtw8922d_efuse_blocks[] = {
 static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7025 = {
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.cim3k = {CIM3K_OFF, CIM3K_OFF, CIM3K_ENABLE, CIM3K_ENABLE},
 		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
 				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
 		.pb_tb = 3,
 	},
 	[RFSI_CTRL_BAND_2GHZ] = {
+		.cim3k = {CIM3K_OFF, CIM3K_OFF, CIM3K_ENABLE, CIM3K_ENABLE},
 		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
 				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
 		.pb_tb = 0,
@@ -304,11 +306,13 @@ static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7025
 static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7090 = {
 	.bands = {
 	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.cim3k = {CIM3K_OFF, CIM3K_OFF, CIM3K_DISABLE, CIM3K_ENABLE},
 		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
 				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
 		.pb_tb = 3,
 	},
 	[RFSI_CTRL_BAND_2GHZ] = {
+		.cim3k = {CIM3K_OFF, CIM3K_OFF, CIM3K_DISABLE, CIM3K_ENABLE},
 		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
 				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
 		.pb_tb = 0,
-- 
2.25.1


