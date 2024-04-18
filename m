Return-Path: <linux-wireless+bounces-6481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D312A8A910E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 04:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750C61F2218A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936F04EB58;
	Thu, 18 Apr 2024 02:12:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA34EB23
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406363; cv=none; b=ZP4eMHzYe5xrk3Rew3ImB4+JjXX0rtA/crDWHK9acaLFmMPWpm4++LD9VcsdL7gP0ZuEBjJQ+CV3KaYfUZkOv3rYgcphDjOCeZuBLhXh6sZ3VcNCkfwCG62Amy4vFnsHpu9wIPWQCEK/3zoIiWIX6h1QvBefHkiIUOHDkU0rgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406363; c=relaxed/simple;
	bh=0oPL5b7BNK2VDfQOD97anN6VovNyPtDCHhQZ8sZnCTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXLXSHfuNCZHHM1YJm5iPSZWGrav3zUxzZpJCFep9PyEaiGQwfgGzl32ZT/mQWdGxLjMcJoPI2stnefxmXdRyCIJdRPC995AhgR0tCQc5I2s1oot2xjLlvhS/uJmI3WWRvym5Eq6I+riWur/X7e0ZnH58JmKtcgxM/pUgY+0l8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I2Cdg663994701, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I2Cdg663994701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:12:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:12:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:12:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 3/9] wifi: rtw89: coex: Add version 3 report map of H2C command
Date: Thu, 18 Apr 2024 10:12:01 +0800
Message-ID: <20240418021207.32173-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418021207.32173-1-pkshih@realtek.com>
References: <20240418021207.32173-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Ching-Te Ku <ku920601@realtek.com>

The map is the H2C index for driver forward the driver status to firmware.
The status is for firmware to make mechanism decision, if driver provided
the wrong index to firmware, it will make parse the status incorrectly.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 40 ++++++++++++++++++-----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 3da4f54126dd..37eb85d63657 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -133,7 +133,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
-	 .fwlrole = 8,   .frptmap = 7,    .fcxctrl = 7,  .fcxinit = 7,
+	 .fwlrole = 8,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .drvinfo_type = 1, .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8851B, RTW89_FW_VER_CODE(0, 29, 29, 0),
@@ -252,13 +252,24 @@ enum btc_btf_set_report_en {
 	RPT_EN_MONITER,
 };
 
-#define BTF_SET_REPORT_VER 1
-struct rtw89_btc_btf_set_report {
+struct rtw89_btc_btf_set_report_v1 {
 	u8 fver;
 	__le32 enable;
 	__le32 para;
 } __packed;
 
+struct rtw89_btc_btf_set_report_v8 {
+	u8 type;
+	u8 fver;
+	u8 len;
+	__le32 map;
+} __packed;
+
+union rtw89_fbtc_rtp_ctrl {
+	struct rtw89_btc_btf_set_report_v1 v1;
+	struct rtw89_btc_btf_set_report_v8 v8;
+};
+
 #define BTF_SET_SLOT_TABLE_VER 1
 struct rtw89_btc_btf_set_slot_table {
 	u8 fver;
@@ -2187,7 +2198,7 @@ static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_smap *wl_smap = &btc->cx.wl.status.map;
 	struct rtw89_btc_btf_fwinfo *fwinfo = &btc->fwinfo;
-	struct rtw89_btc_btf_set_report r = {0};
+	union rtw89_fbtc_rtp_ctrl r;
 	u32 val, bit_map;
 	int ret;
 
@@ -2208,11 +2219,24 @@ static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
 	if (val == fwinfo->rpt_en_map)
 		return;
 
-	r.fver = BTF_SET_REPORT_VER;
-	r.enable = cpu_to_le32(val);
-	r.para = cpu_to_le32(rpt_state);
+	if (btc->ver->fcxbtcrpt == 8) {
+		r.v8.type = SET_REPORT_EN;
+		r.v8.fver = btc->ver->fcxbtcrpt;
+		r.v8.len = sizeof(r.v8.map);
+		r.v8.map = cpu_to_le32(val);
+		ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_REPORT_EN, &r.v8,
+				   sizeof(r.v8));
+	} else {
+		if (btc->ver->fcxbtcrpt == 105)
+			r.v1.fver = 5;
+		else
+			r.v1.fver = btc->ver->fcxbtcrpt;
+		r.v1.enable = cpu_to_le32(val);
+		r.v1.para = cpu_to_le32(rpt_state);
+		ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_REPORT_EN, &r.v1,
+				   sizeof(r.v1));
+	}
 
-	ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_REPORT_EN, &r, sizeof(r));
 	if (!ret)
 		fwinfo->rpt_en_map = val;
 }
-- 
2.25.1


