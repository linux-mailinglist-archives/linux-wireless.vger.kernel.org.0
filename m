Return-Path: <linux-wireless+bounces-28292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEEBC0C076
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 08:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ED2F4EE966
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 07:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89700231C91;
	Mon, 27 Oct 2025 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="M22qkS9f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E872F5B
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548606; cv=none; b=Pb3k9dk7lGzIp+NLK/kjzj5wgkrow7Zss4Cs1AmQC6AI9vOgIMXWbPPpHI/Fy7aZBLQFUoCqpcPHOorf6cX4o1fxeTZ65XEBhDNYOMo1/0cpc49Kyqp7mnK+2BFy5CxCxgUX3MyE684KZtzYxRAjMxE0TRqRO+Y273mv8Ercvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548606; c=relaxed/simple;
	bh=pDCkxw1i89NRg2RMux4beknqPnm6KYcOrik5CAdKWfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ba6w8Qfn4yx7MSmMTZ11BmntQwAEvHTS30rgUhSgVtK5A/Ms+HmMXtTdHuUdjfuqkIHpNaN17lRq2TjlEpMYowBzo6Kk5FSINFaN54apJsUjGP6NKJ1AsSce1yLFHhT6qj89ip2zhMJRUO8DeScJT0/tnvB+PRwH3Dv5C0TCpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=M22qkS9f; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59R73JlO4276408, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761548599; bh=rdaBLDtB7s+Kq1p+kvPHOBH+0g/J316+7wCVx2tQNig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=M22qkS9fDia5jm9DdRntdIF4Ha8f69oB/4s+UpN+5ZvcAmPikiPWPJTNVAuoeFuAC
	 qdMoZNKREOWORy83Z7i0dLFlnDo0c+TQNj7dBjC4UJPsUMWtJM/kjrH7rmZ5SC4oPi
	 Kt9VV94NfVU6518QTGQWZijyAuYJQ2dcJffrjtbY4Em85vehD0NgMPmMUirvQt8XBI
	 Tf2W8UDjggiv/PWYrH5uZg6jdRw2gB7Nlk4rBNuCmy+G5dq3EM1wn/cW87+1gF3G2e
	 YpOsRTKh/fmb4idEsskre/gxpZNyJzNpTAOXg993lDtHOq5vdsgw0Qhkh0XlNBAQXp
	 RdwaAhT2dhjpQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59R73JlO4276408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 15:03:19 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 27 Oct 2025 15:03:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Mon, 27 Oct 2025 15:03:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH rtw-next] wifi: rtw88: 8822c: use fixed rate and bandwidth to reply CSI packets
Date: Mon, 27 Oct 2025 15:02:59 +0800
Message-ID: <20251027070259.18931-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chin-Yen Lee <timlee@realtek.com>

AP could trigger beamform and send NDPA packet with 6Mbps rate
on bandwidth 80MHz, but RTL8822C can't reply CSI packet with
the same setting. Therefore, force to use OFDM rate and
bandwidth 20MHz instead.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/bf.c | 8 +++++++-
 drivers/net/wireless/realtek/rtw88/bf.h | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
index c827c4a2814b..0d0ccbc7d00c 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.c
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -124,8 +124,11 @@ void rtw_bf_init_bfer_entry_mu(struct rtw_dev *rtwdev,
 void rtw_bf_cfg_sounding(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 			 enum rtw_trx_desc_rate rate)
 {
+	u8 csi_rsc = CSI_RSC_FOLLOW_RX_PACKET_BW;
 	u32 psf_ctl = 0;
-	u8 csi_rsc = 0x1;
+
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C)
+		csi_rsc = CSI_RSC_PRIMARY_20M_BW;
 
 	psf_ctl = rtw_read32(rtwdev, REG_BBPSF_CTRL) |
 		  BIT_WMAC_USE_NDPARATE |
@@ -387,6 +390,9 @@ void rtw_bf_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
 	csi_cfg = rtw_read32(rtwdev, REG_BBPSF_CTRL) & ~BIT_MASK_CSI_RATE;
 	cur_rrsr = rtw_read16(rtwdev, REG_RRSR);
 
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C)
+		csi_cfg |= BIT_CSI_FORCE_RATE;
+
 	if (rssi >= 40) {
 		if (cur_rate != DESC_RATE54M) {
 			cur_rrsr |= BIT(DESC_RATE54M);
diff --git a/drivers/net/wireless/realtek/rtw88/bf.h b/drivers/net/wireless/realtek/rtw88/bf.h
index 7b40c2c03856..a5d3010e6be6 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.h
+++ b/drivers/net/wireless/realtek/rtw88/bf.h
@@ -33,6 +33,7 @@
 #define BIT_SHIFT_R_MU_RL		12
 #define BIT_SHIFT_WMAC_TXMU_ACKPOLICY	4
 #define BIT_SHIFT_CSI_RATE		24
+#define BIT_CSI_FORCE_RATE		BIT(15)
 
 #define BIT_MASK_R_MU_RL (R_MU_RL << BIT_SHIFT_R_MU_RL)
 #define BIT_MASK_R_MU_TABLE_VALID	0x3f
@@ -48,6 +49,12 @@
 #define RTW_SND_CTRL_REMOVE	0x98
 #define RTW_SND_CTRL_SOUNDING	0x9B
 
+enum csi_rsc {
+	CSI_RSC_PRIMARY_20M_BW = 0,
+	CSI_RSC_FOLLOW_RX_PACKET_BW = 1,
+	CSI_RSC_DUPLICATE_MODE = 2,
+};
+
 enum csi_seg_len {
 	HAL_CSI_SEG_4K = 0,
 	HAL_CSI_SEG_8K = 1,
-- 
2.25.1


