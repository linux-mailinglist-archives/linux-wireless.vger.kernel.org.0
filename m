Return-Path: <linux-wireless+bounces-38037-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JOq8He5RO2p+WAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38037-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 240246BB263
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="XAybcHE/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38037-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38037-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A934930250BA
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745BC30BB91;
	Wed, 24 Jun 2026 03:41:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2350309EEC
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:40:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272460; cv=none; b=eV98tkzN/dUkBntKTbDstBrX76PrU9TFzJny3BfVOXrFJ97+VMTyWM06IK/ekQJr3onCAPqXfavZkDFk1P5uZjcHcV5Ih4GwTe7+4qYEjtrMPysBwbOyuaCoB2U+wjF7viEpOk/5M0/KA72GARfR9796bMZVmsne7zjTPNPvzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272460; c=relaxed/simple;
	bh=c/YJEhvn5qlCd6yH2fqTnhjtprXKxU3zaJm79WG1fjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNv0lQ43uI2RpFhljvt4CXDFmbs2ktuXsXrGfZXsmgVyKYMmJHOtD+SpKR+BRAMNYNLNeU77kJGCSlW9gaO4Ele/e2PPEykBVXdMfVxMdQyrDAW278IzFfADzE2nYBuptOr3z4lkiIWuX0jFyR4qkvCp9YCz2YnN+RmDkjZW0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XAybcHE/; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65O3euccF3888886, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782272456; bh=LMSFu/kO8EJZzVG5HxYmhV0Z1WSXYWH5FltTemjQ3t8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XAybcHE/rDCDOSk5gJEiOsBwIIL9AalRouOGBVVcOspIhuHNw7M1EjXFdtXR/Ofqi
	 7HLQqDxUR13I7EM+1lRxeURgLYOqSULp/mkPVMtAK9WziqGdr9AAPx6WkTq+tgjqeF
	 gvdaPtc66X3ZPoT/BvHBtfmxQdoZYc1/hUwb9A5fAGHMHqxNNSSFd0xKjx3uO5bOGw
	 G8N/itcPfQRMUAmObEpm44M1FCJBsUcr50r1n+s/jSyMfzCPMM2sLap/096fA4O17X
	 WEB9B9vwQYAVHX6pdOFBQAljofHMIlAgB/H9CSAQWEre3b6ev+Vu++LrGyNaKgm2yX
	 RgUDRttOGgMQg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65O3euccF3888886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 11:40:56 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:40:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:40:56 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Jun 2026 11:40:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 06/10] wifi: rtw89: coex: Refine third party module related coexistence
Date: Wed, 24 Jun 2026 11:39:37 +0800
Message-ID: <20260624033941.45918-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260624033941.45918-1-pkshih@realtek.com>
References: <20260624033941.45918-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
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
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38037-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:ku920601@realtek.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 240246BB263

From: Ching-Te Ku <ku920601@realtek.com>

The incoming chip reserved several IO ports to coexist with the other
vendor's stand along chips. In order to configured them easier add the
structure.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     |  8 ++--
 drivers/net/wireless/realtek/rtw89/core.h     | 31 +++++++++++---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 40 +++++++++++++++++++
 4 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 8fa51867055b..5159338960f3 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -7655,7 +7655,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		goto exit;
 	}
 
-	if (!cx->bt0.enable.now && !cx->other.type) {
+	if (!cx->bt0.enable.now && !cx->bt_ext.func_type) {
 		_action_bt_off(rtwdev);
 		goto exit;
 	}
@@ -7776,7 +7776,7 @@ static void _set_init_info(struct rtw89_dev *rtwdev)
 		dm->init_info.init_v7.wl_only = (u8)dm->wl_only;
 		dm->init_info.init_v7.bt_only = (u8)dm->bt_only;
 		dm->init_info.init_v7.wl_init_ok = (u8)wl->status.map.init_ok;
-		dm->init_info.init_v7.cx_other = btc->cx.other.type;
+		dm->init_info.init_v7.cx_other = btc->cx.bt_ext.func_type;
 		dm->init_info.init_v7.wl_guard_ch = chip->afh_guard_ch;
 		dm->init_info.init_v7.module = btc->mdinfo.md_v7;
 	} else {
@@ -7784,7 +7784,7 @@ static void _set_init_info(struct rtw89_dev *rtwdev)
 		dm->init_info.init.bt_only = (u8)dm->bt_only;
 		dm->init_info.init.wl_init_ok = (u8)wl->status.map.init_ok;
 		dm->init_info.init.dbcc_en = rtwdev->dbcc_en;
-		dm->init_info.init.cx_other = btc->cx.other.type;
+		dm->init_info.init.cx_other = btc->cx.bt_ext.func_type;
 		dm->init_info.init.wl_guard_ch = chip->afh_guard_ch;
 		dm->init_info.init.module = btc->mdinfo.md;
 	}
@@ -8927,7 +8927,7 @@ static int _show_cx_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 	p += scnprintf(p, end - p,
 		       "3rd_coex:%d, dbcc:%d, tx_num:%d, rx_num:%d\n",
-		       btc->cx.other.type, rtwdev->dbcc_en, hal->tx_nss,
+		       btc->cx.bt_ext.func_type, rtwdev->dbcc_en, hal->tx_nss,
 		       hal->rx_nss);
 
 	return p - buf;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 31ac9fa4282e..2366894bf609 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1445,6 +1445,12 @@ enum rtw89_btc_bt_state_cnt {
 	BTC_BCNT_NUM,
 };
 
+enum rtw89_btc_bt_rf_band {
+	BTC_BT_B2G = 0x0, /* 2.4GHz */
+	BTC_BT_B5G = 0x1, /* 5GHz or 6GHz */
+	BTC_BT_BMAX = 0x2
+};
+
 enum rtw89_btc_bt_profile {
 	BTC_BT_NOPROFILE = 0,
 	BTC_BT_HFP = BIT(0),
@@ -1975,10 +1981,25 @@ struct rtw89_btc_bt_link_info {
 	u32 rsvd: 19;
 };
 
-struct rtw89_btc_3rdcx_info {
-	u8 type;   /* 0: none, 1:zigbee, 2:LTE  */
-	u8 hw_coex;
-	u16 rsvd;
+struct rtw89_btc_extsoc_info {
+	u8 chip_id;
+	u8 max_tx_pwr;
+	u8 rf_band_map;
+	u8 ant_iso_to_wl;
+
+	u8 link_weight[BTC_BT_BMAX];
+
+	u8 func_type; /* 0: none, 1:zigbee, 2:LTE */
+	u8 hw_coex; /* Hard-Wire coex interface support */
+	u8 pta_type; /* 0: RTK 4-wire mode, 1: 3-wire mode */
+	u8 pta_req_exist;
+
+	u32 hpta_cfg;
+	u32 hmbx_cfg;
+	u32 swout_cfg;
+	u32 swin_cfg;
+	u32 profile_map[BTC_BT_BMAX];
+	u32 bcnt[BTC_BCNT_NUM];
 };
 
 struct rtw89_btc_dm_emap {
@@ -2267,7 +2288,7 @@ struct rtw89_btc_cx {
 	struct rtw89_btc_wl_info wl;
 	struct rtw89_btc_bt_info bt0;
 	struct rtw89_btc_bt_info bt1;
-	struct rtw89_btc_3rdcx_info other;
+	struct rtw89_btc_extsoc_info bt_ext;
 	u32 state_map;
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index ad3618dfd57d..91897aeced28 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2745,7 +2745,7 @@ static void rtw8922a_btc_set_rfe(struct rtw89_dev *rtwdev)
 	if (module->kt_ver <= 1)
 		module->wa_type |= BTC_WA_HFP_ZB;
 
-	rtwdev->btc.cx.other.type = BTC_3CX_NONE;
+	rtwdev->btc.cx.bt_ext.func_type = BTC_3CX_NONE;
 
 	if (module->rfe_type == 0) {
 		rtwdev->btc.dm.error.map.rfe_type0 = true;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 838c26231897..888973f4ef95 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2997,6 +2997,46 @@ static u32 rtw8922d_chan_to_rf18_val(struct rtw89_dev *rtwdev,
 
 static void rtw8922d_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
+	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
+	struct rtw89_btc_module_v7 *module = &md->md_v7;
+
+	module->rfe_type = rtwdev->efuse.rfe_type;
+	module->kt_ver = rtwdev->hal.cv;
+	module->bt_solo = 0;
+	module->switch_type = BTC_SWITCH_INTERNAL;
+	module->wa_type = 0;
+
+	module->ant.type = BTC_ANT_SHARED;
+	module->ant.num = 2;
+	module->ant.isolation = 10;
+	module->ant.diversity = 0;
+	module->ant.single_pos = RF_PATH_A;
+	module->ant.btg_pos = RF_PATH_B;
+
+	if (module->kt_ver <= 1)
+		module->wa_type |= BTC_WA_HFP_ZB;
+
+	rtwdev->btc.cx.bt_ext.func_type = BTC_3CX_NONE;
+
+	if (module->rfe_type == 0) {
+		rtwdev->btc.dm.error.map.rfe_type0 = true;
+		return;
+	}
+
+	module->ant.num = (module->rfe_type % 2) ?  2 : 3;
+
+	if (module->kt_ver == 0)
+		module->ant.num = 2;
+
+	if (module->ant.num == 3) {
+		module->ant.type = BTC_ANT_DEDICATED;
+		module->bt_pos = BTC_BT_ALONE;
+	} else {
+		module->ant.type = BTC_ANT_SHARED;
+		module->bt_pos = BTC_BT_BTG;
+	}
+	rtwdev->btc.btg_pos = module->ant.btg_pos;
+	rtwdev->btc.ant_type = module->ant.type;
 }
 
 static void rtw8922d_btc_init_cfg(struct rtw89_dev *rtwdev)
-- 
2.25.1


