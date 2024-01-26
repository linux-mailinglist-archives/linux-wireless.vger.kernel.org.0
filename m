Return-Path: <linux-wireless+bounces-2521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2381583D48C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC252850AE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE31D537;
	Fri, 26 Jan 2024 06:34:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9C1D535
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250899; cv=none; b=kLbbro8SnSqH/VjhVKCntHyVnitxMJDwVWC6SUu0iFzoHk6h+SbdMw+m/zxRz2FtGf/xc/LHIeaJ1H1EuQSZPrBONCixf4Qiv9vpzf6DWWsuXpWJQvrSEAlSNSIDAzC0TRVyC9zO29BOD+NTsv8oVzTJrGUU+DvFjw2YuLaGTo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250899; c=relaxed/simple;
	bh=WDj+G0jRqQ4Cb9kumLw0PePOI28uqfdpTq9VKeL78n4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDcxSliMPREF40HwXOV9kLpr/DjjMDLekyOYfcg1hCvY/LHP+Mp+BGPWvbcEp4nIAx6k8khQSqtfE0+dnZ11AJ6jle1Oxqi7sscysDIspvTdlWTbXzcu60/COtwVQgXPDhc0NCfvN1lbzbtsB6MNySxrdfxVbKSk5BbuRSszVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40Q6YpgL62085629, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40Q6YpgL62085629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:34:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 26 Jan 2024 14:34:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 14:34:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/7] wifi: rtw89: update ps_state register for chips with different generation
Date: Fri, 26 Jan 2024 14:33:55 +0800
Message-ID: <20240126063356.17857-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126063356.17857-1-pkshih@realtek.com>
References: <20240126063356.17857-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

The ps_state register is used for driver to check if the WiFi chip leave
power save mode successfully. The register is changed for new generation,
so update it.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 1 +
 drivers/net/wireless/realtek/rtw89/mac.h    | 1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 1 +
 drivers/net/wireless/realtek/rtw89/ps.c     | 3 ++-
 drivers/net/wireless/realtek/rtw89/reg.h    | 3 +++
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ec6acd52f3b2..14a331760655 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6184,6 +6184,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.rx_fltr = R_AX_RX_FLTR_OPT,
 	.port_base = &rtw89_port_base_ax,
 	.agg_len_ht = R_AX_AGG_LEN_HT_0,
+	.ps_status = R_AX_PPWRBIT_SETTING,
 
 	.muedca_ctrl = {
 		.addr = R_AX_MUEDCA_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8056c85c8dba..f9e2dcc22da1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -894,6 +894,7 @@ struct rtw89_mac_gen_def {
 	u32 rx_fltr;
 	const struct rtw89_port_reg *port_base;
 	u32 agg_len_ht;
+	u32 ps_status;
 
 	struct rtw89_reg_def muedca_ctrl;
 	struct rtw89_reg_def bfee_ctrl;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index c67cdff14abd..eb7d8d6fd3ad 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2218,6 +2218,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.rx_fltr = R_BE_RX_FLTR_OPT,
 	.port_base = &rtw89_port_base_be,
 	.agg_len_ht = R_BE_AGG_LEN_HT_0,
+	.ps_status = R_BE_WMTX_POWER_BE_BIT_CTL,
 
 	.muedca_ctrl = {
 		.addr = R_BE_MUEDCA_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index be1dcd9eb955..31290d8cb7f7 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -14,6 +14,7 @@
 
 static int rtw89_fw_leave_lps_check(struct rtw89_dev *rtwdev, u8 macid)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 pwr_en_bit = 0xE;
 	u32 chk_msk = pwr_en_bit << (4 * macid);
 	u32 polling;
@@ -21,7 +22,7 @@ static int rtw89_fw_leave_lps_check(struct rtw89_dev *rtwdev, u8 macid)
 
 	ret = read_poll_timeout_atomic(rtw89_read32_mask, polling, !polling,
 				       1000, 50000, false, rtwdev,
-				       R_AX_PPWRBIT_SETTING, chk_msk);
+				       mac->ps_status, chk_msk);
 	if (ret) {
 		rtw89_info(rtwdev, "rtw89: failed to leave lps state\n");
 		return -EBUSY;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index acc96d30d085..67d9d83f1539 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6761,6 +6761,9 @@
 #define B_BE_UPD_HGQMD BIT(1)
 #define B_BE_UPD_TIMIE BIT(0)
 
+#define R_BE_WMTX_POWER_BE_BIT_CTL 0x10E0C
+#define R_BE_WMTX_POWER_BE_BIT_CTL_C1 0x14E0C
+
 #define R_BE_WMTX_TCR_BE_4 0x10E2C
 #define R_BE_WMTX_TCR_BE_4_C1 0x14E2C
 #define B_BE_UL_EHT_MUMIMO_LTF_MODE BIT(30)
-- 
2.25.1


