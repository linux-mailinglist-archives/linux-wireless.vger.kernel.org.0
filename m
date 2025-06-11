Return-Path: <linux-wireless+bounces-23950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B434AD47EF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AD817B376
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 01:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922542AA4;
	Wed, 11 Jun 2025 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="a74I0HkR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F243169
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605762; cv=none; b=pW5b0mttohGRHimJf1qUKS690iENrehT1ihSGCXOHQmFNSOfIyhB2yq31tfRy1HzUrp4JA+OLN7Ve8REqOGWUVWxHvBifpYi/ImsOFHaiQ9PyRKQg5lQ60JHJYTFwO2fUk2wK8EBHXB/8bT3ucz8zMHDl44+7GtId4v8TVFET6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605762; c=relaxed/simple;
	bh=lwcHplLDk/GbTR6up6e9ivSkuyvoeQFe5gsStyybC2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFXQmHrLyWc/cWbc+TaKV3d+NQ0P+bDvSvg5pu1ycrZkg2liT3+0TpxtvcUyPrlJkDwT0WwVpEkLA8buWD0gR5BNhum4ZqrAZsmoODdjUvLrvOf6E+xM9pXixzgyeNr99PNFcbeg/2XdbAiqVbo2aCynie3u6q28sj3XEpJUvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=a74I0HkR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B1ZvaX63938168, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749605757; bh=aV44MWXb5dnfemTj7BQxIu1CKVvpd+7GPGgCCMbP3G8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=a74I0HkRUe1zdc23It14JkeA2YPM6HPtSORY7+Sourkowaz484DgxiE8ME8AJtxWw
	 R45lfTdfFSuArwxyaZfscEg7QDvL96bTSSsSIcXHwS17bM75+HgJPulDe3/AOpf8YG
	 FzmjiEnQatM1SIu8bL1morgNuL5Cl+tjH1h7SNIgmRzwgMXJ7XBjt/chTXjekF9Q0u
	 BB4EVL6lBG4YfmeunGuOEkySzcbwqzO6MY7BA55MkWwwpFlZGQyd52A/J4CJoYrn92
	 uUwuZFT5l0BXrU0mr3XENluSdUckF3jFDxC+dL5YL8evMJbEZvi7VCMgDJBoGbl0u1
	 CZ/MeJYNY/M8g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B1ZvaX63938168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:35:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 09:35:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 09:35:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/10] wifi: rtw89: coex: refine debug log with format version and readable string
Date: Wed, 11 Jun 2025 09:35:05 +0800
Message-ID: <20250611013510.15519-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611013510.15519-1-pkshih@realtek.com>
References: <20250611013510.15519-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

Fix unexpected line warp. Collect firmware report format version and
driver support report format version code to check unexpected C2H report
exception.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 148 ++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/core.h |  51 ++++----
 2 files changed, 133 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 34455badc650..54ee4136491d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -278,6 +278,39 @@ static u32 chip_id_to_bt_rom_code_id(u32 id)
 	}
 }
 
+#define CASE_BTC_MLME_STATE(e) case MLME_##e: return #e
+
+static const char *id_to_mlme_state(u32 id)
+{
+	switch (id) {
+	CASE_BTC_MLME_STATE(NO_LINK);
+	CASE_BTC_MLME_STATE(LINKING);
+	CASE_BTC_MLME_STATE(LINKED);
+	default:
+		return "unknown";
+	}
+}
+
+static char *chip_id_str(u32 id)
+{
+	switch (id) {
+	case RTL8852A:
+		return "RTL8852A";
+	case RTL8852B:
+		return "RTL8852B";
+	case RTL8852C:
+		return "RTL8852C";
+	case RTL8852BT:
+		return "RTL8852BT";
+	case RTL8851B:
+		return "RTL8851B";
+	case RTL8922A:
+		return "RTL8922A";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 struct rtw89_btc_btf_tlv {
 	u8 type;
 	u8 len;
@@ -1354,6 +1387,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			   u8 *prptbuf, u32 index)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_ver *fwsubver = &btc->fwinfo.fw_subver;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
@@ -1396,23 +1430,29 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		if (ver->fcxbtcrpt == 1) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v1);
+			fwsubver->fcxbtcrpt = pfwinfo->rpt_ctrl.finfo.v1.fver;
 		} else if (ver->fcxbtcrpt == 4) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v4;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v4);
+			fwsubver->fcxbtcrpt = pfwinfo->rpt_ctrl.finfo.v4.fver;
 		} else if (ver->fcxbtcrpt == 5) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v5;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v5);
+			fwsubver->fcxbtcrpt = pfwinfo->rpt_ctrl.finfo.v5.fver;
 		} else if (ver->fcxbtcrpt == 105) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v105;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v105);
+			fwsubver->fcxbtcrpt = pfwinfo->rpt_ctrl.finfo.v105.fver;
 			pcinfo->req_fver = 5;
 			break;
 		} else if (ver->fcxbtcrpt == 8) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v8;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v8);
+			fwsubver->fcxbtcrpt = pfwinfo->rpt_ctrl.finfo.v8.fver;
 		} else if (ver->fcxbtcrpt == 7) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v7);
+			fwsubver->fcxbtcrpt = pfwinfo->rpt_ctrl.finfo.v7.fver;
 		} else {
 			goto err;
 		}
@@ -1423,9 +1463,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		if (ver->fcxtdma == 1) {
 			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo.v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo.v1);
+			fwsubver->fcxtdma = 0;
 		} else if (ver->fcxtdma == 3 || ver->fcxtdma == 7) {
 			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo.v3;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo.v3);
+			fwsubver->fcxtdma = pfwinfo->rpt_fbtc_tdma.finfo.v3.fver;
 		} else {
 			goto err;
 		}
@@ -1436,9 +1478,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		if (ver->fcxslots == 1) {
 			pfinfo = &pfwinfo->rpt_fbtc_slots.finfo.v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_slots.finfo.v1);
+			fwsubver->fcxslots = pfwinfo->rpt_fbtc_slots.finfo.v1.fver;
 		} else if (ver->fcxslots == 7) {
 			pfinfo = &pfwinfo->rpt_fbtc_slots.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_slots.finfo.v7);
+			fwsubver->fcxslots = pfwinfo->rpt_fbtc_slots.finfo.v7.fver;
 		} else {
 			goto err;
 		}
@@ -1451,22 +1495,27 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v2;
 			pcysta->v2 = pfwinfo->rpt_fbtc_cysta.finfo.v2;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v2);
+			fwsubver->fcxcysta = pfwinfo->rpt_fbtc_cysta.finfo.v2.fver;
 		} else if (ver->fcxcysta == 3) {
 			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v3;
 			pcysta->v3 = pfwinfo->rpt_fbtc_cysta.finfo.v3;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v3);
+			fwsubver->fcxcysta = pfwinfo->rpt_fbtc_cysta.finfo.v3.fver;
 		} else if (ver->fcxcysta == 4) {
 			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v4;
 			pcysta->v4 = pfwinfo->rpt_fbtc_cysta.finfo.v4;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v4);
+			fwsubver->fcxcysta = pfwinfo->rpt_fbtc_cysta.finfo.v4.fver;
 		} else if (ver->fcxcysta == 5) {
 			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v5;
 			pcysta->v5 = pfwinfo->rpt_fbtc_cysta.finfo.v5;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v5);
+			fwsubver->fcxcysta = pfwinfo->rpt_fbtc_cysta.finfo.v5.fver;
 		} else if (ver->fcxcysta == 7) {
 			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v7;
 			pcysta->v7 = pfwinfo->rpt_fbtc_cysta.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v7);
+			fwsubver->fcxcysta = pfwinfo->rpt_fbtc_cysta.finfo.v7.fver;
 		} else {
 			goto err;
 		}
@@ -1482,11 +1531,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo.v2.step[0]) *
 					  trace_step +
 					  offsetof(struct rtw89_btc_fbtc_steps_v2, step);
+			fwsubver->fcxstep = pfwinfo->rpt_fbtc_step.finfo.v2.fver;
 		} else if (ver->fcxstep == 3) {
 			pfinfo = &pfwinfo->rpt_fbtc_step.finfo.v3;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo.v3.step[0]) *
 					  trace_step +
 					  offsetof(struct rtw89_btc_fbtc_steps_v3, step);
+			fwsubver->fcxstep = pfwinfo->rpt_fbtc_step.finfo.v3.fver;
 		} else {
 			goto err;
 		}
@@ -1497,12 +1548,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		if (ver->fcxnullsta == 1) {
 			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo.v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo.v1);
+			fwsubver->fcxnullsta = pfwinfo->rpt_fbtc_nullsta.finfo.v1.fver;
 		} else if (ver->fcxnullsta == 2) {
 			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo.v2;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo.v2);
+			fwsubver->fcxnullsta = pfwinfo->rpt_fbtc_nullsta.finfo.v2.fver;
 		} else if (ver->fcxnullsta == 7) {
 			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo.v7);
+			fwsubver->fcxnullsta = pfwinfo->rpt_fbtc_nullsta.finfo.v7.fver;
 		} else {
 			goto err;
 		}
@@ -1513,12 +1567,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		if (ver->fcxmreg == 1) {
 			pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo.v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo.v1);
+			fwsubver->fcxmreg = pfwinfo->rpt_fbtc_mregval.finfo.v1.fver;
 		} else if (ver->fcxmreg == 2) {
 			pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo.v2;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo.v2);
+			fwsubver->fcxmreg = pfwinfo->rpt_fbtc_mregval.finfo.v2.fver;
 		} else if (ver->fcxmreg == 7) {
 			pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo.v7);
+			fwsubver->fcxmreg = pfwinfo->rpt_fbtc_mregval.finfo.v7.fver;
 		} else {
 			goto err;
 		}
@@ -1529,9 +1586,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		if (ver->fcxgpiodbg == 7) {
 			pfinfo = &pfwinfo->rpt_fbtc_gpio_dbg.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_gpio_dbg.finfo.v7);
+			fwsubver->fcxgpiodbg = pfwinfo->rpt_fbtc_gpio_dbg.finfo.v7.fver;
 		} else {
 			pfinfo = &pfwinfo->rpt_fbtc_gpio_dbg.finfo.v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_gpio_dbg.finfo.v1);
+			fwsubver->fcxgpiodbg = pfwinfo->rpt_fbtc_gpio_dbg.finfo.v1.fver;
 		}
 		pcinfo->req_fver = ver->fcxgpiodbg;
 		break;
@@ -1540,9 +1599,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		if (ver->fcxbtver == 1) {
 			pfinfo = &pfwinfo->rpt_fbtc_btver.finfo.v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btver.finfo.v1);
+			fwsubver->fcxbtver = pfwinfo->rpt_fbtc_btver.finfo.v1.fver;
 		} else if (ver->fcxbtver == 7) {
 			pfinfo = &pfwinfo->rpt_fbtc_btver.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btver.finfo.v7);
+			fwsubver->fcxbtver = pfwinfo->rpt_fbtc_btver.finfo.v7.fver;
 		}
 		pcinfo->req_fver = ver->fcxbtver;
 		break;
@@ -1551,12 +1612,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		if (ver->fcxbtscan == 1) {
 			pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo.v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo.v1);
+			fwsubver->fcxbtscan = pfwinfo->rpt_fbtc_btscan.finfo.v1.fver;
 		} else if (ver->fcxbtscan == 2) {
 			pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo.v2;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo.v2);
+			fwsubver->fcxbtscan = pfwinfo->rpt_fbtc_btscan.finfo.v2.fver;
 		} else if (ver->fcxbtscan == 7) {
 			pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo.v7);
+			fwsubver->fcxbtscan = pfwinfo->rpt_fbtc_btscan.finfo.v7.fver;
 		} else {
 			goto err;
 		}
@@ -1567,12 +1631,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		if (ver->fcxbtafh == 1) {
 			pfinfo = &pfwinfo->rpt_fbtc_btafh.finfo.v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo.v1);
+			fwsubver->fcxbtafh = pfwinfo->rpt_fbtc_btafh.finfo.v1.fver;
 		} else if (ver->fcxbtafh == 2) {
 			pfinfo = &pfwinfo->rpt_fbtc_btafh.finfo.v2;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo.v2);
+			fwsubver->fcxbtafh = pfwinfo->rpt_fbtc_btafh.finfo.v2.fver;
 		} else if (ver->fcxbtafh == 7) {
 			pfinfo = &pfwinfo->rpt_fbtc_btafh.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo.v7);
+			fwsubver->fcxbtafh = pfwinfo->rpt_fbtc_btafh.finfo.v7.fver;
 		} else {
 			goto err;
 		}
@@ -1582,6 +1649,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_btdev.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_btdev.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btdev.finfo);
+		fwsubver->fcxbtdevinfo = pfwinfo->rpt_fbtc_btdev.finfo.fver;
 		pcinfo->req_fver = ver->fcxbtdevinfo;
 		break;
 	default:
@@ -8451,11 +8519,9 @@ static int _show_cx_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	if (!(dm->coex_info_map & BTC_COEX_INFO_CX))
 		return 0;
 
-	dm->cnt_notify[BTC_NCNT_SHOW_COEX_INFO]++;
-
 	p += scnprintf(p, end - p,
-		       "========== [BTC COEX INFO (%d)] ==========\n",
-		       chip->chip_id);
+		       "\n========== [BTC COEX INFO (%s)] ==========\n",
+		       chip_id_str(chip->chip_id));
 
 	ver_main = FIELD_GET(GENMASK(31, 24), RTW89_COEX_VERSION);
 	ver_sub = FIELD_GET(GENMASK(23, 16), RTW89_COEX_VERSION);
@@ -8546,10 +8612,11 @@ static int _show_wl_role_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 				continue;
 
 			p += scnprintf(p, end - p,
-				       " [port_%d]        : role=%d(phy-%d), connect=%d(client_cnt=%d), mode=%d, center_ch=%d, bw=%d",
+				       " [port_%d]        : role=%d(phy-%d), connect=%s(client_cnt=%d), mode=%d, center_ch=%d, bw=%d",
 				       plink->pid, plink->role, plink->phy,
-				       plink->connected, plink->client_cnt - 1,
-				       plink->mode, plink->ch, plink->bw);
+				       id_to_mlme_state(plink->connected),
+				       plink->client_cnt - 1, plink->mode,
+				       plink->ch, plink->bw);
 
 			if (plink->connected == MLME_NO_LINK)
 				continue;
@@ -8611,8 +8678,8 @@ static int _show_wl_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	else
 		goto out;
 
-	p += scnprintf(p, end - p, " %-15s : link_mode:%d, ", "[status]",
-		       mode);
+	p += scnprintf(p, end - p, " %-15s : link_mode:%s, ", "[status]",
+		       id_to_linkmode(mode));
 
 	p += scnprintf(p, end - p,
 		       "rf_off:%d, power_save:%d, scan:%s(band:%d/phy_map:0x%x), ",
@@ -9411,7 +9478,6 @@ static int _show_fbtc_slots(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		if (i % 5 == 4)
 			p += scnprintf(p, end - p, "\n");
 	}
-	p += scnprintf(p, end - p, "\n");
 
 	return p - buf;
 }
@@ -9983,7 +10049,7 @@ static int _show_fbtc_cysta_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz
 		return 0;
 
 	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo.v7;
-	p += scnprintf(p, end - p, "\n\r %-15s : cycle:%d", "[slot_stat]",
+	p += scnprintf(p, end - p, "\n %-15s : cycle:%d", "[slot_stat]",
 		       le16_to_cpu(pcysta->cycles));
 
 	for (i = 0; i < CXST_MAX; i++) {
@@ -10131,7 +10197,7 @@ static int _show_fbtc_nullsta(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	ns = &pfwinfo->rpt_fbtc_nullsta.finfo;
 	if (ver->fcxnullsta == 1) {
 		for (i = 0; i < 2; i++) {
-			p += scnprintf(p, end - p, " %-15s : ", "[NULL-STA]");
+			p += scnprintf(p, end - p, " %-15s : ", "\n[NULL-STA]");
 			p += scnprintf(p, end - p, "null-%d", i);
 			p += scnprintf(p, end - p, "[ok:%d/",
 				       le32_to_cpu(ns->v1.result[i][1]));
@@ -10144,13 +10210,13 @@ static int _show_fbtc_nullsta(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 			p += scnprintf(p, end - p, "avg_t:%d.%03d/",
 				       le32_to_cpu(ns->v1.avg_t[i]) / 1000,
 				       le32_to_cpu(ns->v1.avg_t[i]) % 1000);
-			p += scnprintf(p, end - p, "max_t:%d.%03d]\n",
+			p += scnprintf(p, end - p, "max_t:%d.%03d]",
 				       le32_to_cpu(ns->v1.max_t[i]) / 1000,
 				       le32_to_cpu(ns->v1.max_t[i]) % 1000);
 		}
 	} else if (ver->fcxnullsta == 7) {
 		for (i = 0; i < 2; i++) {
-			p += scnprintf(p, end - p, " %-15s : ", "[NULL-STA]");
+			p += scnprintf(p, end - p, " %-15s : ", "\n[NULL-STA]");
 			p += scnprintf(p, end - p, "null-%d", i);
 			p += scnprintf(p, end - p, "[Tx:%d/",
 				       le32_to_cpu(ns->v7.result[i][4]));
@@ -10165,13 +10231,13 @@ static int _show_fbtc_nullsta(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 			p += scnprintf(p, end - p, "avg_t:%d.%03d/",
 				       le32_to_cpu(ns->v7.tavg[i]) / 1000,
 				       le32_to_cpu(ns->v7.tavg[i]) % 1000);
-			p += scnprintf(p, end - p, "max_t:%d.%03d]\n",
+			p += scnprintf(p, end - p, "max_t:%d.%03d]",
 				       le32_to_cpu(ns->v7.tmax[i]) / 1000,
 				       le32_to_cpu(ns->v7.tmax[i]) % 1000);
 		}
 	} else {
 		for (i = 0; i < 2; i++) {
-			p += scnprintf(p, end - p, " %-15s : ", "[NULL-STA]");
+			p += scnprintf(p, end - p, " %-15s : ", "\n[NULL-STA]");
 			p += scnprintf(p, end - p, "null-%d", i);
 			p += scnprintf(p, end - p, "[Tx:%d/",
 				       le32_to_cpu(ns->v2.result[i][4]));
@@ -10186,7 +10252,7 @@ static int _show_fbtc_nullsta(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 			p += scnprintf(p, end - p, "avg_t:%d.%03d/",
 				       le32_to_cpu(ns->v2.avg_t[i]) / 1000,
 				       le32_to_cpu(ns->v2.avg_t[i]) % 1000);
-			p += scnprintf(p, end - p, "max_t:%d.%03d]\n",
+			p += scnprintf(p, end - p, "max_t:%d.%03d]",
 				       le32_to_cpu(ns->v2.max_t[i]) / 1000,
 				       le32_to_cpu(ns->v2.max_t[i]) % 1000);
 		}
@@ -10428,7 +10494,6 @@ static int _show_gpio_dbg(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): stop due rpt_fbtc_gpio_dbg.cinfo\n",
 			    __func__);
-		p += scnprintf(p, end - p, "\n");
 		goto out;
 	}
 
@@ -10701,7 +10766,6 @@ static int _show_mreg_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 				       id_to_regtype(type), offset, val);
 		cnt++;
 	}
-	p += scnprintf(p, end - p, "\n");
 
 out:
 	return p - buf;
@@ -11401,37 +11465,39 @@ static int _show_summary_v8(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 ssize_t rtw89_btc_dump_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
-	struct rtw89_fw_suit *fw_suit = &rtwdev->fw.normal;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_ver *fwsubver = &btc->fwinfo.fw_subver;
 	const struct rtw89_btc_ver *ver = btc->ver;
-	struct rtw89_btc_cx *cx = &btc->cx;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_dm *dm = &btc->dm;
 	char *p = buf, *end = buf + bufsz;
 
+	dm->cnt_notify[BTC_NCNT_SHOW_COEX_INFO]++;
+
 	p += scnprintf(p, end - p,
-		       "=========================================\n");
+		       "\n\n\n** Page:%3d/RunCNT:%3d **",
+		       dm->cnt_notify[BTC_NCNT_SHOW_COEX_INFO],
+		       dm->cnt_dm[BTC_DCNT_RUN]);
 	p += scnprintf(p, end - p,
-		       "WL FW / BT FW		%d.%d.%d.%d / NA\n",
-		       fw_suit->major_ver, fw_suit->minor_ver,
-		       fw_suit->sub_ver, fw_suit->sub_idex);
-	p += scnprintf(p, end - p, "manual			%d\n",
-		       btc->manual_ctrl);
-
+		       "\n========== [BTC FEATURE SUB VER] ==========");
 	p += scnprintf(p, end - p,
-		       "=========================================\n");
-
+		       "\n %-15s : fcxbtcrpt[%d/%d], fcxtdma[%d/%d], fcxslots[%d/%d], fcxcysta[%d/%d]",
+		       "[FW/DRV]", fwsubver->fcxbtcrpt, ver->fcxbtcrpt,
+		       fwsubver->fcxtdma, ver->fcxtdma, fwsubver->fcxslots,
+		       ver->fcxslots, fwsubver->fcxcysta, ver->fcxcysta);
 	p += scnprintf(p, end - p,
-		       "\n\r %-15s : raw_data[%02x %02x %02x %02x %02x %02x] (type:%s/cnt:%d/same:%d)",
-		       "[bt_info]",
-		       bt->raw_info[2], bt->raw_info[3],
-		       bt->raw_info[4], bt->raw_info[5],
-		       bt->raw_info[6], bt->raw_info[7],
-		       bt->raw_info[0] == BTC_BTINFO_AUTO ? "auto" : "reply",
-		       cx->cnt_bt[BTC_BCNT_INFOUPDATE],
-		       cx->cnt_bt[BTC_BCNT_INFOSAME]);
-
+		       "\n %-15s : fcxstep[%d/%d], fcxnullsta[%d/%d], fcxmreg[%d/%d], fcxgpiodbg[%d/%d]",
+		       "[FW/DRV]", fwsubver->fcxstep, ver->fcxstep,
+		       fwsubver->fcxnullsta, ver->fcxnullsta, fwsubver->fcxmreg,
+		       ver->fcxmreg, fwsubver->fcxgpiodbg, ver->fcxgpiodbg);
+	p += scnprintf(p, end - p,
+		       "\n %-15s : fcxbtver[%d/%d], fcxbtscan[%d/%d], fcxbtafh[%d/%d], fcxbtdevinfo[%d/%d]",
+		       "[FW/DRV]", fwsubver->fcxbtver, ver->fcxbtver,
+		       fwsubver->fcxbtscan, ver->fcxbtscan, fwsubver->fcxbtafh,
+		       ver->fcxbtafh, fwsubver->fcxbtdevinfo, ver->fcxbtdevinfo);
 	p += scnprintf(p, end - p,
-		       "\n=========================================\n");
+		       "\n %-15s : fcxosi[%d/%d], fcxmlo[%d/%d],",
+		       "[FW/DRV]", fwsubver->fcxosi, ver->fcxosi,
+		       fwsubver->fcxmlo, ver->fcxmlo);
 
 	p += _show_cx_info(rtwdev, p, end - p);
 	p += _show_wl_info(rtwdev, p, end - p);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6ddc819d6ad0..0c818a8025cc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3146,31 +3146,6 @@ enum rtw89_btc_btfre_type {
 	BTFRE_MAX,
 };
 
-struct rtw89_btc_btf_fwinfo {
-	u32 cnt_c2h;
-	u32 cnt_h2c;
-	u32 cnt_h2c_fail;
-	u32 event[BTF_EVNT_MAX];
-
-	u32 err[BTFRE_MAX];
-	u32 len_mismch;
-	u32 fver_mismch;
-	u32 rpt_en_map;
-
-	struct rtw89_btc_report_ctrl_state rpt_ctrl;
-	struct rtw89_btc_rpt_fbtc_tdma rpt_fbtc_tdma;
-	struct rtw89_btc_rpt_fbtc_slots rpt_fbtc_slots;
-	struct rtw89_btc_rpt_fbtc_cysta rpt_fbtc_cysta;
-	struct rtw89_btc_rpt_fbtc_step rpt_fbtc_step;
-	struct rtw89_btc_rpt_fbtc_nullsta rpt_fbtc_nullsta;
-	struct rtw89_btc_rpt_fbtc_mreg rpt_fbtc_mregval;
-	struct rtw89_btc_rpt_fbtc_gpio_dbg rpt_fbtc_gpio_dbg;
-	struct rtw89_btc_rpt_fbtc_btver rpt_fbtc_btver;
-	struct rtw89_btc_rpt_fbtc_btscan rpt_fbtc_btscan;
-	struct rtw89_btc_rpt_fbtc_btafh rpt_fbtc_btafh;
-	struct rtw89_btc_rpt_fbtc_btdev rpt_fbtc_btdev;
-};
-
 struct rtw89_btc_ver {
 	enum rtw89_core_chip_id chip_id;
 	u32 fw_ver_code;
@@ -3201,6 +3176,32 @@ struct rtw89_btc_ver {
 	u8 fcxmlo;
 };
 
+struct rtw89_btc_btf_fwinfo {
+	u32 cnt_c2h;
+	u32 cnt_h2c;
+	u32 cnt_h2c_fail;
+	u32 event[BTF_EVNT_MAX];
+
+	u32 err[BTFRE_MAX];
+	u32 len_mismch;
+	u32 fver_mismch;
+	u32 rpt_en_map;
+
+	struct rtw89_btc_ver fw_subver;
+	struct rtw89_btc_report_ctrl_state rpt_ctrl;
+	struct rtw89_btc_rpt_fbtc_tdma rpt_fbtc_tdma;
+	struct rtw89_btc_rpt_fbtc_slots rpt_fbtc_slots;
+	struct rtw89_btc_rpt_fbtc_cysta rpt_fbtc_cysta;
+	struct rtw89_btc_rpt_fbtc_step rpt_fbtc_step;
+	struct rtw89_btc_rpt_fbtc_nullsta rpt_fbtc_nullsta;
+	struct rtw89_btc_rpt_fbtc_mreg rpt_fbtc_mregval;
+	struct rtw89_btc_rpt_fbtc_gpio_dbg rpt_fbtc_gpio_dbg;
+	struct rtw89_btc_rpt_fbtc_btver rpt_fbtc_btver;
+	struct rtw89_btc_rpt_fbtc_btscan rpt_fbtc_btscan;
+	struct rtw89_btc_rpt_fbtc_btafh rpt_fbtc_btafh;
+	struct rtw89_btc_rpt_fbtc_btdev rpt_fbtc_btdev;
+};
+
 #define RTW89_BTC_POLICY_MAXLEN 512
 
 struct rtw89_btc {
-- 
2.25.1


