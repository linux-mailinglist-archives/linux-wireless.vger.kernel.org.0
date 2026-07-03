Return-Path: <linux-wireless+bounces-38575-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mYm5KUKjR2rccgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38575-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 13:55:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D94702135
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 13:55:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=J7saerJ1;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38575-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38575-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2713B30617C6
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A82A3C98BE;
	Fri,  3 Jul 2026 11:43:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245FA37EFEF
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 11:43:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079001; cv=none; b=SlM8P9Y72g8HZ8HLQtCy/GCUuWsJZ9JJNNZBrXOQiUuVM3OXXCf1nQCbJTbefLpJLtk+ndDEpS1fYHE5beYdWyKfJWiob9QFuGeBLKO6UZBjVSC5YtwiYUd4j/XYOZ3HpTq3oUU5GNvE69q3Qvkx63d0JP8F16z8vwK7rV937Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079001; c=relaxed/simple;
	bh=7YofISV7j7bX4vo4SFJm0F5UmE/fK+EL4xAjPSt52ig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbKA+zevIrl9lv+McSJcayYfMn9dakvtN6Lb8rd2WBPRUvPYk1T5hHL8CI/b2/tvnhx/SCBxn++Pr2khKuVLXZkFXBJfCRu3yHA84Kuj9x2/H+/qrL5wOYapvVy+LAjtvmGCsuvL90M8FRf6au4/WgMT9Q/8XLcrWBjUNel2veM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=J7saerJ1; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 663BhH0212636875, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783078997; bh=efQxZmxEj/hwbwe8MpjflqV0++HBW9psDEyM3w+PFrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=J7saerJ1+/voHyAX++yynOOc/wNjzHa10kISuZ6e/cpxe+5OFVnup0zrwjPyY6DkK
	 65I8yEroeZRiwIexNtumgDL3TlIgtmi6AgpoPsTD9aXPy2KI6tsTYbQS5gFmnf7b02
	 fekI6WA5bDyAQzHEqg24zz13Z1dgxcGyH2jDDuzvGTQ5+6hWlsDLqzGlbXeTlBMdc1
	 ANMVdNchMcy3KOH9vDgor6GXNc9YwqAIuwYrD3JRHlDRe8E3t6bTYTSWZ0vouqjBiJ
	 cBXHXyZomRMz/3b/uJt5Ava5JGqzl+L1pzhRjXMnVnwwg0czOZIH0meC9Nf3Vl6M10
	 6eP8UdPWpqWIg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 663BhH0212636875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 19:43:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 19:43:16 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 19:43:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 1/9] wifi: rtw89: coex: Add Init info version 10
Date: Fri, 3 Jul 2026 19:43:03 +0800
Message-ID: <20260703114311.2609942-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260703114311.2609942-1-pkshih@realtek.com>
References: <20260703114311.2609942-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38575-lists,linux-wireless=lfdr.de];
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
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2D94702135

From: Ching-Te Ku <ku920601@realtek.com>

The version 10 Init info add I/O offload type & variable Bluetooth
function (EX: Zigbee/Thread...etc) into the structure definition.
Firmware need to synchronize these information to do corresponding
setting.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 58 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/coex.h     |  6 ++
 drivers/net/wireless/realtek/rtw89/core.h     | 54 ++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 41 +++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       |  6 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  2 -
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 -
 .../wireless/realtek/rtw89/rtw8852b_common.c  |  1 -
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 -
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 -
 10 files changed, 159 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 1361d4d54528..43de238c18f8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2822,6 +2822,8 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 index)
 	case CXDRVINFO_INIT:
 		if (ver->fcxinit == 7)
 			rtw89_fw_h2c_cxdrv_init_v7(rtwdev, index);
+		else if (ver->fcxinit == 10)
+			rtw89_fw_h2c_cxdrv_init_v10(rtwdev, index);
 		else
 			rtw89_fw_h2c_cxdrv_init(rtwdev, index);
 		break;
@@ -7884,15 +7886,30 @@ void rtw89_btc_ntfy_poweroff(struct rtw89_dev *rtwdev)
 	btc->cx.wl.status.map.rf_off_pre = btc->cx.wl.status.map.rf_off;
 }
 
+#define BTC_PLATFORM_LITTLE_ENDIAN 0
 static void _set_init_info(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 
-	if (ver->fcxinit == 7) {
+	if (ver->fcxinit == 10) {
+		dm->init_info.init_v10.init_mode = wl->coex_mode;
+		dm->init_info.init_v10.wl_init_ok = wl->status.map.init_ok;
+		dm->init_info.init_v10.endian_type = BTC_PLATFORM_LITTLE_ENDIAN;
+
+		dm->init_info.init_v10.module = btc->mdinfo.md_v10;
+
+		dm->init_info.init_v10.bt0_function = cx->bt0.func_type;
+		dm->init_info.init_v10.bt1_function = cx->bt1.func_type;
+		dm->init_info.init_v10.bt2_function = cx->bt_ext.func_type;
+
+		dm->init_info.init_v10.pta_mode = RTW89_MAC_AX_COEX_RTK_MODE;
+		dm->init_info.init_v10.pta_direction = RTW89_MAC_AX_COEX_INNER;
+	} else if (ver->fcxinit == 7) {
 		dm->init_info.init_v7.wl_only = (u8)dm->wl_only;
 		dm->init_info.init_v7.bt_only = (u8)dm->bt_only;
 		dm->init_info.init_v7.wl_init_ok = (u8)wl->status.map.init_ok;
@@ -7908,6 +7925,12 @@ static void _set_init_info(struct rtw89_dev *rtwdev)
 		dm->init_info.init.wl_guard_ch = chip->afh_guard_ch;
 		dm->init_info.init.module = btc->mdinfo.md;
 	}
+
+	_fw_set_drv_info(rtwdev, CXDRVINFO_INIT);
+	_fw_set_drv_info(rtwdev, CXDRVINFO_CTRL);
+	rtw89_btc_fw_set_slots(rtwdev);
+	btc_fw_set_monreg(rtwdev);
+	_set_wl_tx_power(rtwdev, RTW89_BTC_WL_DEF_TX_PWR, RTW89_PHY_0);
 }
 
 void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
@@ -7918,13 +7941,18 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_btc_ver *ver = btc->ver;
 
+	rtw89_debug(rtwdev, RTW89_DBG_BTC,
+		    "[BTC], %s(): Init %s !!\n", __func__,
+		    chip_id_str(chip->chip_id));
+
 	_reset_btc_var(rtwdev, BTC_RESET_ALL);
 	btc->dm.run_reason = BTC_RSN_NONE;
 	btc->dm.run_action = BTC_ACT_NONE;
-	if (ver->fcxctrl == 7)
+	if (ver->fcxctrl >= 7)
 		btc->ctrl.ctrl_v7.igno_bt = true;
 	else
 		btc->ctrl.ctrl.igno_bt = true;
+	wl->status.map.init_ok = true;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): mode=%d\n", __func__, mode);
@@ -7934,9 +7962,11 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 	dm->wl_only = mode == BTC_MODE_WL ? 1 : 0;
 	dm->bt_only = mode == BTC_MODE_BT ? 1 : 0;
 	wl->status.map.rf_off = mode == BTC_MODE_WLOFF ? 1 : 0;
-
-	chip->ops->btc_set_rfe(rtwdev);
-	chip->ops->btc_init_cfg(rtwdev);
+	dm->vid = rtwdev->custid;
+	if (ver->fcxctrl >= 7)
+		btc->ctrl.ctrl_v7.always_freerun = mode == BTC_MODE_COTX;
+	else
+		btc->ctrl.ctrl.always_freerun = mode == BTC_MODE_COTX;
 
 	if (!wl->status.map.init_ok) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -7946,8 +7976,26 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 		return;
 	}
 
+	if (rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT) {
+		btc->cx.bt1.enable.now = 1;
+		btc->cx.bt1.run_patch_code = 1;
+	}
+
+	if (rtwdev->chip->para_ver & BTC_FEAT_H2C_MACRO) {
+		btc->cx.bt0.enable.now = 1;
+		btc->cx.bt0.run_patch_code = 1;
+		btc->io_oflld_type = BTC_IO_OFLD_BTC_H2C;
+	} else {
+		btc->io_oflld_type = BTC_IO_OFLD_NO_SUPPORT;
+		_update_bt_scbd(rtwdev, true);
+	}
+
+	chip->ops->btc_set_rfe(rtwdev);
+	chip->ops->btc_init_cfg(rtwdev);
+
 	_write_scbd(rtwdev,
 		    BTC_WSCB_ACTIVE | BTC_WSCB_ON | BTC_WSCB_BTLOG, true);
+
 	if (rtw89_mac_get_ctrl_path(rtwdev)) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): PTA owner warning!!\n",
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 6ac14611607c..259c6e2c0e3c 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -16,6 +16,8 @@ enum btc_mode {
 	BTC_MODE_WL,
 	BTC_MODE_BT,
 	BTC_MODE_WLOFF,
+	BTC_MODE_COTX,
+	BTC_MODE_MECHANISM_INIT,
 	BTC_MODE_MAX
 };
 
@@ -212,6 +214,10 @@ enum btc_chip_feature {
 	BTC_FEAT_NEW_BBAPI_FLOW = BIT(3), /* new btg_ctrl/pre_agc_ctrl */
 	BTC_FEAT_MLO_SUPPORT = BIT(4),
 	BTC_FEAT_H2C_MACRO = BIT(5),
+	BTC_FEAT_DUAL_BT = BIT(6),
+	BTC_FEAT_BT_6G = BIT(7),
+	BTC_FEAT_MULTI_PTA = BIT(8),
+	BTC_FEAT_DUAL_BTGA = BIT(9) /* the future A-Die */
 };
 
 enum btc_wl_mode {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5dde620b1e5e..1e72c9b9f3b7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1451,6 +1451,12 @@ enum rtw89_btc_bt_rf_band {
 	BTC_BT_BMAX = 0x2
 };
 
+enum rtw89_btc_io_offload_type {
+	BTC_IO_OFLD_NO_SUPPORT = 0,
+	BTC_IO_OFLD_MAC_API = 1,
+	BTC_IO_OFLD_BTC_H2C = 2
+};
+
 enum rtw89_btc_bt_profile {
 	BTC_BT_NOPROFILE = 0,
 	BTC_BT_HFP = BIT(0),
@@ -1483,6 +1489,19 @@ struct rtw89_btc_ant_info_v7 {
 	u8 rsvd;
 } __packed;
 
+struct rtw89_btc_ant_info_v10 {
+	u8 type;  /* shared, dedicated(non-shared) */
+	u8 num;   /* antenna count  */
+	u8 isolation; /* Ant-Iso between WL/BT */
+	u8 single_pos; /* wifi 1ss-1ant at 0:S0 or 1:S1 */
+
+	u8 stream_cnt; /* spatial_stream count: Tx[7:4], Rx[3:0] */
+	u8 btg_pos;    /* BT0 btg-circuit at 0:WL-S0/1:WL-S1 */
+	u8 btg1_pos;   /* BT1 btg-circuit at 0:WL-S0/1:WL-S1 */
+	u8 func[5]; /* function at 1~5 Ant refer to enum btc_bt_func_type */
+	u8 ant_xmap[2][4];
+} __packed;
+
 enum rtw89_tfc_dir {
 	RTW89_TFC_UL,
 	RTW89_TFC_DL,
@@ -2129,9 +2148,24 @@ struct rtw89_btc_module_v7 {
 	struct rtw89_btc_ant_info_v7 ant;
 } __packed;
 
+struct rtw89_btc_module_v10 {
+	u8 rfe_type;
+	u8 wa_type; /* Refer to enum btc_wa_type */
+	u8 kt_ver;
+	u8 kt_ver_adie;
+
+	u8 bt0_pos; /* wl-end view: get from efuse, must compare bt.btg_type*/
+	u8 bt0_sw_type; /* BT Ant-switch: None(non-share), Int(BTG), Ext(SPDT)*/
+	u8 bt1_pos; /* BTC_BT_ALONE or BTC_BT_BTG */
+	u8 bt1_sw_type;
+
+	struct rtw89_btc_ant_info_v10 ant;
+} __packed;
+
 union rtw89_btc_module_info {
 	struct rtw89_btc_module md;
 	struct rtw89_btc_module_v7 md_v7;
+	struct rtw89_btc_module_v10 md_v10;
 };
 
 #define RTW89_BTC_DM_MAXSTEP 30
@@ -2170,9 +2204,24 @@ struct rtw89_btc_init_info_v7 {
 	struct rtw89_btc_module_v7 module;
 } __packed;
 
+struct rtw89_btc_init_info_v10 {
+	u8 endian_type; /* 0: little-endian, 1:big-endian */
+	u8 init_mode; /* refer to enum BTC_MODE_xxx  */
+	u8 wl_init_ok;
+	u8 bt0_function;
+
+	u8 bt1_function;
+	u8 bt2_function;
+	u8 pta_mode;
+	u8 pta_direction;
+
+	struct rtw89_btc_module_v10 module;
+};
+
 union rtw89_btc_init_info_u {
 	struct rtw89_btc_init_info init;
 	struct rtw89_btc_init_info_v7 init_v7;
+	struct rtw89_btc_init_info_v10 init_v10;
 };
 
 struct rtw89_btc_wl_tx_limit_para {
@@ -2253,6 +2302,7 @@ struct rtw89_btc_bt_info {
 	u8 raw_info[BTC_BTINFO_MAX]; /* raw bt info from mailbox */
 	u8 txpwr_info[BTC_BTINFO_MAX];
 	u8 rssi_level;
+	u8 func_type;
 
 	u32 scbd;
 	u32 feature;
@@ -3173,6 +3223,7 @@ struct rtw89_btc_dm {
 	u8 run_reason;
 	u8 run_action;
 	u8 wl_tx_pwr_phy_map;
+	u8 vid;
 
 	u8 wl_pre_agc: 2;
 	u8 wl_lna2: 1;
@@ -3203,7 +3254,7 @@ struct rtw89_btc_ctrl_v7 {
 
 union rtw89_btc_ctrl_list {
 	struct rtw89_btc_ctrl ctrl;
-	struct rtw89_btc_ctrl_v7 ctrl_v7;
+	struct rtw89_btc_ctrl_v7 ctrl_v7; /* ver 8, 9 is the same */
 };
 
 struct rtw89_btc_dbg {
@@ -3425,6 +3476,7 @@ struct rtw89_btc {
 	u8 policy[RTW89_BTC_POLICY_MAXLEN];
 	u8 ant_type;
 	u8 btg_pos;
+	u8 io_oflld_type;
 	u16 policy_len;
 	u16 policy_type;
 	u32 hubmsg_cnt;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9d98805835d6..b97c6e9c18bc 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5863,6 +5863,47 @@ int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev, u8 type)
 	return ret;
 }
 
+int rtw89_fw_h2c_cxdrv_init_v10(struct rtw89_dev *rtwdev, u8 type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_init_info_v10 *init_info = &dm->init_info.init_v10;
+	struct rtw89_h2c_cxinit_v10 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_init_v10\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxinit_v10 *)skb->data;
+
+	h2c->hdr.type = type;
+	h2c->hdr.ver = btc->ver->fcxinit;
+	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
+	h2c->init = *init_info;
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, BTFC_SET,
+			      SET_DRV_INFO, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 #define PORT_DATA_OFFSET 4
 #define H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN 12
 #define H2C_LEN_CXDRVINFO_ROLE_SIZE(max_role_num) \
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 71e8554a7af7..de8b77de8705 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2592,6 +2592,11 @@ struct rtw89_h2c_cxinit_v7 {
 	struct rtw89_btc_init_info_v7 init;
 } __packed;
 
+struct rtw89_h2c_cxinit_v10 {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	struct rtw89_btc_init_info_v10 init;
+} __packed;
+
 static inline void RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(void *cmd, u8 val)
 {
 	u8p_replace_bits((u8 *)(cmd) + 2, val, GENMASK(7, 0));
@@ -5380,6 +5385,7 @@ int rtw89_fw_h2c_tx_history(struct rtw89_dev *rtwdev, u16 mac_id);
 int rtw89_fw_h2c_drv_ctrl_fw(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_init_v10(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 4caf231c6287..a1a63588cb90 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2277,8 +2277,6 @@ static void rtw8851b_btc_init_cfg(struct rtw89_dev *rtwdev)
 
 	/* enable BT counter 0xda40[16,2] = 2b'11 */
 	rtw89_write32_set(rtwdev, R_AX_CSR_MODE, B_AX_BT_CNT_RST | B_AX_STATIS_BT_EN);
-
-	btc->cx.wl.status.map.init_ok = true;
 }
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 78addc0aef69..055c67a07cea 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1945,7 +1945,6 @@ static void rtw8852a_btc_init_cfg(struct rtw89_dev *rtwdev)
 	 /* enable BT counter 0xda40[16,2] = 2b'11 */
 	rtw89_write32_set(rtwdev,
 			  R_AX_CSR_MODE, B_AX_BT_CNT_RST | B_AX_STATIS_BT_EN);
-	btc->cx.wl.status.map.init_ok = true;
 }
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index df5fbae50ff5..7d409a64869f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -1838,7 +1838,6 @@ static void __rtw8852bx_btc_init_cfg(struct rtw89_dev *rtwdev)
 
 	 /* enable BT counter 0xda40[16,2] = 2b'11 */
 	rtw89_write32_set(rtwdev, R_AX_CSR_MODE, B_AX_BT_CNT_RST | B_AX_STATIS_BT_EN);
-	btc->cx.wl.status.map.init_ok = true;
 }
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 29a3c90021f3..9e630b897986 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2761,7 +2761,6 @@ static void rtw8852c_btc_init_cfg(struct rtw89_dev *rtwdev)
 	rtw89_write32_set(rtwdev,
 			  R_AX_BT_CNT_CFG, B_AX_BT_CNT_EN |
 			  B_AX_BT_CNT_RST_V1);
-	btc->cx.wl.status.map.init_ok = true;
 }
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 6d4301661b04..382034eb27d0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2828,7 +2828,6 @@ static void rtw8922a_btc_init_cfg(struct rtw89_dev *rtwdev)
 	rtw89_write32(rtwdev, R_BTC_ZB_COEX_TBL_1, 0xda5a5a5a);
 
 	rtw89_write32(rtwdev, R_BTC_ZB_BREAK_TBL, 0xf0ffffff);
-	btc->cx.wl.status.map.init_ok = true;
 }
 
 static void
-- 
2.25.1


