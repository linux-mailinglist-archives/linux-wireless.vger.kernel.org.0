Return-Path: <linux-wireless+bounces-36199-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AdZK/1+AWoMbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36199-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:02:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FEB508C9C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1A0B3007E28
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1A13115A5;
	Mon, 11 May 2026 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YORcowV4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51232B9B5
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482937; cv=none; b=cmtUr6c/dbUtkEkg+RwQG8XC9js/kD2QfxoApaZWPwcDlSyEateOqWi8A7cqD3FKj3ryoi9JX0fZulZTrhOyqMJqF3qs7iL4fDm7xSWV1hiSWoJgvAGe91d4Ur/Ta7Q5AW4wIZtp841GOe0me7Sx/iV+TctukiksayRWjcxHbYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482937; c=relaxed/simple;
	bh=PGzf4KiCiNa6Oesui3nD9DJAPLdh9ECIReB419CYIvs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3QWrY8BNJ5jBzoDfs9z54awvguf0GiPahO1Csc4tXkIaorxit+92usgPDrIG0HGaOS1NIuAwXJSLPECnGGD2pOwyX+936G2PL2gqWpgJQFvUhvPqqXV7FW7cZMhIt/BxsofVT1GCxdokOqQo3HGVo+qgAxABD6RZJXNI4oJVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YORcowV4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B728Mm82540453, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482928; bh=7H4V5RtNCXhkkDBLLdnkobs5gVvv94A4wuF7BScBg3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YORcowV4bgpK7NP5KK8EiKDeiWteU53VTUeuW4yfICAkxuTaqNzH0CE6uz/s0cwyo
	 O80qDm9T66z2PSWqGb3RADyXigAJ4XDVyN89kn88Cu/Wy4aVrV+tlQDsj9ZgBi8xL6
	 +FCFeJ15rcMzW2KIRkR5864yyn7nO8hDI67qCzpJQm9nj3iHpyk3jRPOxQajIs5I2J
	 LcEKxYidUZMlVQzVVMLYvf6bH8I8vWlqkiRlt4u9XL5jnvzF273irNKbqHFif2RFpK
	 7MTuVwzcJBezkkjfaz56cLLuPxbP2VKrCZG+SrIP3Ydd3cRoPJBLZmIQlGnXp0/0Ka
	 hIapp3KiQxySg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B728Mm82540453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:02:08 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:09 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:02:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 03/11] wifi: rtw89: phy: set BB wrap of DPD by bandwidth
Date: Mon, 11 May 2026 15:01:40 +0800
Message-ID: <20260511070148.25257-4-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 10FEB508C9C
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
	TAGGED_FROM(0.00)[bounces-36199-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

Apply different settings to out-of-band DPD (digital pre-distortion) by
bandwidth, as hardware defines separate registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h      |  15 ++
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 156 ++++++++++--------
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  27 +++
 3 files changed, 127 insertions(+), 71 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 0851a56cfe61..c7cf99fe46fb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -569,12 +569,27 @@ struct rtw89_phy_rfk_log_fmt {
 	const struct rtw89_fw_element_hdr *elm[RTW89_PHY_C2H_RFK_LOG_FUNC_NUM];
 };
 
+enum rtw89_rfsi_ctrl_band {
+	RFSI_CTRL_BAND_5_6GHZ,
+	RFSI_CTRL_BAND_2GHZ,
+
+	RFSI_CTRL_BAND_NUM,
+};
+
 enum rtw89_mdpd_onoff {
 	MDPD_ON = 0,
 	MDPD_OFF = 1,
 };
 
+enum rtw89_oob_dpd_onoff {
+	OOB_DPD_OFF = 0,
+	OOB_DPD_ON = 1,
+};
+
 struct rtw89_bb_wrap_data {
+	struct {
+		u8 oob_dpd_by_cbw[8];
+	} bands[RFSI_CTRL_BAND_NUM];
 	u8 mdpd_by_dbw[4];
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 94b977d29518..4ba18e821578 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -810,77 +810,91 @@ static void rtw89_phy_bb_wrap_tx_rfsi_qam_comp_val(struct rtw89_dev *rtwdev,
 static void rtw89_phy_bb_set_oob_dpd_qam_comp_val(struct rtw89_dev *rtwdev,
 						  enum rtw89_mac_idx mac_idx)
 {
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK0_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK1_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK2_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK3_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK4_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK5_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK6_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK7_BE4, 0x0, mac_idx);
-
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK0_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK1_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK2_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK3_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK4_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK5_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK6_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK7_BE4, 0x0, mac_idx);
-
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH0_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH1_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH2_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH3_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH4_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH5_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH6_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH7_BE4, 0x0, mac_idx);
-
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH0_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH1_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH2_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH3_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH4_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH5_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH6_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH7_BE4, 0x0, mac_idx);
-
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH0_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH1_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH2_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH3_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH4_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH5_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH6_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH7_BE4, 0x0, mac_idx);
-
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW0_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW1_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW2_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW3_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW4_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW5_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW6_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW7_BE4, 0x0, mac_idx);
-
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW0_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW1_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW2_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW3_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW4_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW5_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW6_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW7_BE4, 0x0, mac_idx);
-
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW0_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW1_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW2_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW3_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW4_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW5_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW6_BE4, 0x0, mac_idx);
-	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW7_BE4, 0x0, mac_idx);
+	const struct rtw89_bb_wrap_data *d = rtwdev->phy_info.bb_wrap_data;
+	u8 th;
+
+	if (!d)
+		return;
+
+	th = d->bands[0].oob_dpd_by_cbw[0];
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK0_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK1_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK2_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK3_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK4_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK5_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK6_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK7_BE4, th, mac_idx);
+
+	th = d->bands[0].oob_dpd_by_cbw[1];
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK0_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK1_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK2_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK3_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK4_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK5_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK6_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK7_BE4, th, mac_idx);
+
+	th = d->bands[0].oob_dpd_by_cbw[2];
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH0_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH1_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH2_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH3_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH4_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH5_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH6_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH7_BE4, th, mac_idx);
+
+	th = d->bands[0].oob_dpd_by_cbw[3];
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH0_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH1_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH2_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH3_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH4_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH5_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH6_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH7_BE4, th, mac_idx);
+
+	th = d->bands[0].oob_dpd_by_cbw[4];
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH0_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH1_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH2_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH3_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH4_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH5_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH6_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH7_BE4, th, mac_idx);
+
+	th = d->bands[0].oob_dpd_by_cbw[5];
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW0_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW1_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW2_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW3_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW4_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW5_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW6_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW7_BE4, th, mac_idx);
+
+	th = d->bands[0].oob_dpd_by_cbw[6];
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW0_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW1_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW2_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW3_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW4_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW5_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW6_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW7_BE4, th, mac_idx);
+
+	th = d->bands[0].oob_dpd_by_cbw[7];
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW0_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW1_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW2_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW3_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW4_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW5_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW6_BE4, th, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW7_BE4, th, mac_idx);
 }
 
 static void rtw89_phy_bb_set_mdpd_qam_comp_val(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 326d12da2962..2e5e264e75db 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -287,14 +287,41 @@ static const struct rtw89_efuse_block_cfg rtw8922d_efuse_blocks[] = {
 };
 
 static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7025_default = {
+	.bands = {
+	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
+				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
+	},
+	[RFSI_CTRL_BAND_2GHZ] = {
+		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
+				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
+	}},
 	.mdpd_by_dbw = {MDPD_ON, MDPD_ON, MDPD_ON, MDPD_ON},
 };
 
 static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_default = {
+	.bands = {
+	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
+				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
+	},
+	[RFSI_CTRL_BAND_2GHZ] = {
+		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
+				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
+	}},
 	.mdpd_by_dbw = {MDPD_OFF, MDPD_OFF, MDPD_ON, MDPD_ON},
 };
 
 static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_rfe35_41_44 = {
+	.bands = {
+	[RFSI_CTRL_BAND_5_6GHZ] = {
+		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
+				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
+	},
+	[RFSI_CTRL_BAND_2GHZ] = {
+		.oob_dpd_by_cbw = {OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF,
+				   OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF, OOB_DPD_OFF},
+	}},
 	.mdpd_by_dbw = {MDPD_OFF, MDPD_OFF, MDPD_ON, MDPD_ON},
 };
 
-- 
2.25.1


