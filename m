Return-Path: <linux-wireless+bounces-38897-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z5c6B90EU2pWWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38897-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:07:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A876B743A50
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:07:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=PGtkEbvW;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38897-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38897-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BE26300EF4E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BCD2571DA;
	Sun, 12 Jul 2026 03:06:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453AC27A476
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:06:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825610; cv=none; b=RvvDnDpkMqlZLUqtif5+aldTi+E93kP16WgvZFANLzogSwSbGDc3H+bYlp4Xtet2ylHJyJ8ZV3U8Hzgcs4JWb2RhR7cYvCMM/fGj7hUPYNAegkMSdcTXV/PyI2vZ8+Mtio9U2zyWS5COMbBtPr5DnBLbIOClQz/dfy4Nn9d5ZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825610; c=relaxed/simple;
	bh=h1bvQsqSOIVmTCFXyCC29n180nLTvsefkQJLTXNP0j8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hazUiwQeTjo2bqVEBZ0r1qCf10r7u5fwZND6++Kmdwtg4x/gmmNx+TR0n0WUuZ6W3syVqL3rk29UzEE6wNAHepYPsoI6/ECwH3NI6lECsds9jNvUMyHIH8QnJq6ueEUslLjEftW02GAxuprl9GhNPMe9131cDduD3mESTm2QFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PGtkEbvW; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C36kPJ2525961, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783825606; bh=yI/HU5Q1wsBtNHBYclZbhNXLrClzmEr5qzupJWah8Sc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PGtkEbvWq0iopQv6AnI9gyMGH1PXPmM2mZ5GTaIOiBlYNmREN/Zpoom5nggZTM5BX
	 BFEqWHzKSoI9LNOCXGCf1Y/5Bk0mVoypxt2v7OcTothPpeXaWTOuDRZ3k/b3D+T1GS
	 6GPPW6OeF1VH/pLeEy3dEqxNbOW53aC53hcC6YPkm2S/ElvBZOPJ2iNXALp+7a/rb5
	 mmAkURtrDNm95Ar4jKCeS4Wqw218pY5BVdmedwRYSq94SGZd3mz0tvl2kXORDOv4Ik
	 1+Mw8m3L2+HMSQNXas+LnrTmay9g3umNkHyBPxddUHPS9Zr9MNxmYOFF4Cgr4eIKJz
	 AEHaPnsKMOyKg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C36kPJ2525961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:06:46 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:06:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 08/11] wifi: rtw89: coex: Correct SET_RFE settings
Date: Sun, 12 Jul 2026 11:05:03 +0800
Message-ID: <20260712030506.43438-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712030506.43438-1-pkshih@realtek.com>
References: <20260712030506.43438-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38897-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A876B743A50

From: Ching-Te Ku <ku920601@realtek.com>

Because of dual-BT & dual-MAC, RTL8922D has more complex antenna settings.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.h     |  31 +++
 drivers/net/wireless/realtek/rtw89/core.h     |  11 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 213 ++++++++++++++++--
 3 files changed, 231 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index fdd63e2c0837..e17407696d8a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -143,6 +143,11 @@ enum btc_switch {
 	BTC_SWITCH_EXTERNAL
 };
 
+enum btc_ant_switch_type {
+	BTC_SWITCH_V1_NONE = 0, /* independent antenna */
+	BTC_SWITCH_V1_INTERNAL, /* internal-switch: BTGA structure */
+};
+
 enum btc_pkt_type {
 	PACKET_DHCP,
 	PACKET_ARP,
@@ -262,6 +267,32 @@ enum btc_chip_feature {
 	BTC_FEAT_DUAL_BTGA = BIT(9) /* the future A-Die */
 };
 
+enum btc_efuse_ant_function_map {
+	BTC_EFMAP_NONE = 0,
+	BTC_EFMAP_BT0 = BIT(0),
+	BTC_EFMAP_BT1 = BIT(1),
+	BTC_EFMAP_ZB = BIT(2), /* ZB or thread */
+	BTC_EFMAP_24GP = BIT(3),
+	BTC_EFMAP_ULL = BIT(4),
+};
+
+enum btc_extsoc_interface { /* cx->other.hw_coex */
+	BTC_EXTSOC_INTF_NONE = 0,
+	BTC_EXTSOC_INTF_PTA = BIT(0),
+	BTC_EXTSOC_INTF_MBX = BIT(1),
+	BTC_EXTSOC_INTF_SWIO = BIT(2),
+	BTC_EXTSOC_INTF_MAX,
+};
+
+enum btc_esoc_type {
+	BTC_ESOC_NONE,
+	BTC_ESOC_8761,
+	BTC_ESOC_8771,
+	BTC_ESOC_SILAB_MG21,
+	BTC_ESOC_NORDI_NRF52840,
+	BTC_ESOC_MAX,
+};
+
 enum btc_wl_mode {
 	BTC_WL_MODE_11B = 0,
 	BTC_WL_MODE_11A = 1,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f784e8437292..d876de21482f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2434,6 +2434,15 @@ struct rtw89_btc_wl_tx_limit_para {
 	u16 tx_retry;
 };
 
+struct rtw89_btc_wl_trx_nss_para {
+	u8 tx_limit;
+	u8 rx_limit;
+	u8 tx_ss;
+	u8 rx_ss;
+	u8 tx_path;
+	u8 rx_path;
+};
+
 enum rtw89_btc_bt_scan_type {
 	BTC_SCAN_INQ	= 0,
 	BTC_SCAN_PAGE,
@@ -3616,6 +3625,7 @@ struct rtw89_btc_dm {
 	struct rtw89_btc_bind_info fdd_bind;
 	struct rtw89_btc_fddt_info fddt_info;
 	struct rtw89_btc_fddr_info fddr_info;
+	struct rtw89_btc_wl_trx_nss_para wl_trx_nss;
 	u32 cnt_dm[BTC_DCNT_NUM];
 	u32 cnt_notify[BTC_NCNT_NUM];
 	u8 ant_xmap[BTC_RF_NUM][BTC_ALL_BT_EZL]; /* WL-BT ANT interact-map */
@@ -3664,6 +3674,7 @@ struct rtw89_btc_dm {
 	u8 wl_tx_pwr_phy_map;
 	u8 vid;
 	u8 client_ps_tdma_on;
+	u8 wl_trx_nss_en;
 
 	u8 wl_pre_agc: 2;
 	u8 wl_lna2: 1;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index aeade858ce95..c28670e82c3e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -3106,46 +3106,211 @@ static u32 rtw8922d_chan_to_rf18_val(struct rtw89_dev *rtwdev,
 
 static void rtw8922d_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_cx *cx = &btc->cx;
 	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
-	struct rtw89_btc_module_v7 *module = &md->md_v7;
+	struct rtw89_btc_module_v10 *module = &md->md_v10;
+	u8 efuse_bt_func, efuse_ant_info, bt_sw_gpio_pos;
+	u8 is_combo, is_bt_share;
 
+	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s !!\n", __func__);
+
+	/* get from final capability of device */
 	module->rfe_type = rtwdev->efuse.rfe_type;
 	module->kt_ver = rtwdev->hal.cv;
-	module->bt_solo = 0;
-	module->switch_type = BTC_SWITCH_INTERNAL;
+	module->kt_ver_adie = rtwdev->hal.acv;
 	module->wa_type = 0;
+	dm->wl_trx_nss_en = 0;
 
-	module->ant.type = BTC_ANT_SHARED;
 	module->ant.num = 2;
-	module->ant.isolation = 10;
-	module->ant.diversity = 0;
-	module->ant.single_pos = RF_PATH_A;
-	module->ant.btg_pos = RF_PATH_B;
+	module->ant.single_pos = BTC_RF_S0; /* WL 1ss+1Ant 0:s0(A)/ 1:s1(B) */
 
-	if (module->kt_ver <= 1)
-		module->wa_type |= BTC_WA_HFP_ZB;
+	/* set default antenna isolation */
+	cx->bt0.ant_iso_to_wl = module->ant.isolation;
+	cx->bt1.ant_iso_to_wl = module->ant.isolation;
 
-	rtwdev->btc.cx.bt_ext.func_type = BTC_3CX_NONE;
+	module->ant.stream_cnt = 2;
+	module->ant.btg_pos = BTC_RF_S1; /* BTG0 at WL-S1 */
+	module->ant.btg1_pos = BTC_RF_S0; /* BTG1 at WL-S0 if Dual-BTGA */
 
-	if (module->rfe_type == 0) {
-		rtwdev->btc.dm.error.map.rfe_type0 = true;
-		return;
+	cx->bt0.band_56G_support = 1;
+	cx->bt1.band_56G_support = 1;
+	cx->bt0.func_type = BTC_BTF_BT;
+	cx->bt1.func_type = BTC_BTF_BT;
+
+	efuse_bt_func = rtwdev->efuse.bt_setting_2;
+
+	switch ((efuse_bt_func & 0xe0) >> 5) { /* 0xcd[7:5] */
+	default:
+	case 0:
+	case 1:
+		bt_sw_gpio_pos = 5;
+		break;
+	case 2:
+		bt_sw_gpio_pos = 11;
+		break;
+	case 3:
+		bt_sw_gpio_pos = 15;
+		break;
+	case 4:
+		bt_sw_gpio_pos = 20;
+		break;
 	}
 
-	module->ant.num = (module->rfe_type % 2) ?  2 : 3;
+	efuse_bt_func &= 0x1f; /* 0xcd[4:0] */
+	efuse_ant_info = rtwdev->efuse.bt_setting_3;
+	module->ant.num = (efuse_ant_info & 0xe0) >> 5; /* 0xCE[7:5] */
+	is_combo = (efuse_ant_info & 0xe) >> 1; /* 0xCE[3:1] */
+	is_bt_share = efuse_ant_info & BIT(0); /* 0xCE[0] */
 
-	if (module->kt_ver == 0)
-		module->ant.num = 2;
+	memset(dm->ant_xmap, 0, sizeof(dm->ant_xmap));
 
-	if (module->ant.num == 3) {
-		module->ant.type = BTC_ANT_DEDICATED;
-		module->bt_pos = BTC_BT_ALONE;
-	} else {
+	/* To-Do: "RFE_TYpe" to "ant.num" translation */
+	switch (module->ant.num) {
+	case 1: /* 1-Ant WL-S0 only & BT0 only */
 		module->ant.type = BTC_ANT_SHARED;
-		module->bt_pos = BTC_BT_BTG;
+		module->bt0_pos = BTC_BT_BTG;
+		module->bt0_sw_type = BTC_SWITCH_INTERNAL;
+		module->ant.btg_pos = BTC_RF_S0; /* BTG0 at WL-S0 */
+		module->ant.stream_cnt = 1;
+		module->ant.func[0] = BTC_EFMAP_BT0;
+		dm->ant_xmap[BTC_RF_S0][BTC_BT_1ST] = 1; /* BT0 shared with S0*/
+		dm->ant_xmap[BTC_RF_S1][BTC_BT_1ST] = 0; /* WL 1T1R no RF-S1 */
+		break;
+	case 2: /* 2-Ant */
+	default:
+		if (is_combo) {
+			if (efuse_bt_func == (BTC_EFMAP_BT0 | BTC_EFMAP_BT1))
+				module->ant.func[0] = BTC_EFMAP_BT1;
+
+			module->ant.func[1] = BTC_EFMAP_BT0;
+		} else {
+			module->ant.func[0] = BTC_EFMAP_NONE;
+			module->ant.func[1] = BTC_EFMAP_NONE;
+		}
+
+		if (is_bt_share) { /* WL-S0 + (WL-S1 & BT0-S1) */
+			module->ant.type = BTC_ANT_SHARED;
+			module->bt0_pos = BTC_BT_BTG;
+			module->bt0_sw_type = BTC_SWITCH_INTERNAL;
+			dm->ant_xmap[BTC_RF_S1][BTC_BT_1ST] = 1;
+		} else { /* WL-S0 + BT0-S1 */
+			module->ant.type = BTC_ANT_DEDICATED;
+			module->bt0_pos = BTC_BT_ALONE;
+			module->bt0_sw_type = BTC_SWITCH_V1_NONE;
+		}
+
+		if (module->ant.func[0] == BTC_EFMAP_BT1) { /* if 2nd BT exist */
+			dm->ant_xmap[BTC_RF_S0][BTC_BT_2ND] = 1;
+			if (module->rfe_type == 12) { /* WL-S0 & BT1 by SPDT */
+				module->bt1_pos = BTC_BT_ALONE;
+				/* Todo: set SPDT GPIO-ctrl */
+				module->bt1_sw_type = bt_sw_gpio_pos;
+			} else { /* WL-S0 & BT1-S1 by BTGA */
+				module->bt1_pos = BTC_BT_BTG;
+				module->bt1_sw_type = BTC_SWITCH_INTERNAL;
+			}
+		}
+
+		dm->wl_trx_nss_en = 1; /* 1ss MIMO-PS capability if 1-BT */
+		break;
+	case 3: /* 3-Ant, 3 different BT-configuration */
+		if (is_bt_share) {
+			module->ant.func[0] = BTC_EFMAP_NONE;
+			module->ant.func[1] = BTC_EFMAP_BT0;
+			module->ant.func[2] = efuse_bt_func & (~BTC_EFMAP_BT0);
+			module->ant.type = BTC_ANT_SHARED;
+			module->bt0_pos = BTC_BT_BTG;
+			module->bt0_sw_type = BTC_SWITCH_INTERNAL;
+			dm->ant_xmap[BTC_RF_S1][BTC_BT_1ST] = 1;
+			dm->wl_trx_nss_en = 1; /* 1ss MIMO-PS capability */
+		} else {
+			module->ant.func[0] = BTC_EFMAP_NONE;
+			module->ant.func[1] = BTC_EFMAP_NONE;
+			module->ant.func[2] = efuse_bt_func;
+			module->ant.type = BTC_ANT_DEDICATED;
+			module->bt0_pos = BTC_BT_ALONE;
+			module->bt0_sw_type = BTC_SWITCH_V1_NONE;
+		}
+
+		module->bt1_pos = BTC_BT_ALONE; /* BT1 may exist or not */
+		module->bt1_sw_type = BTC_SWITCH_V1_NONE;
+		break;
+	case 4: /* 4-Ant,  WL-S0 + WL-S1 + BT0 + BT1 */
+		module->ant.func[0] = BTC_EFMAP_NONE;
+		module->ant.func[1] = BTC_EFMAP_NONE;
+		module->ant.func[2] = BTC_EFMAP_BT0;
+		module->ant.func[3] = efuse_bt_func & (~BTC_EFMAP_BT0);
+		module->ant.type = BTC_ANT_DEDICATED;
+		module->bt0_pos = BTC_BT_ALONE;
+		module->bt0_sw_type = BTC_SWITCH_V1_NONE;
+		module->bt1_pos = BTC_BT_ALONE;
+		module->bt1_sw_type = BTC_SWITCH_V1_NONE;
+		break;
+	case 5:
+		module->ant.func[0] = BTC_EFMAP_NONE;
+		module->ant.func[1] = BTC_EFMAP_NONE;
+		module->ant.func[2] = BTC_EFMAP_BT0;
+		module->ant.func[3] = BTC_EFMAP_BT1;
+		module->ant.func[4] = BTC_EFMAP_ZB;
+		module->ant.type = BTC_ANT_DEDICATED;
+		module->bt0_pos = BTC_BT_ALONE;
+		module->bt0_sw_type = BTC_SWITCH_V1_NONE;
+		module->bt1_pos = BTC_BT_ALONE;
+		module->bt1_sw_type = BTC_SWITCH_V1_NONE;
+		break;
 	}
-	rtwdev->btc.btg_pos = module->ant.btg_pos;
-	rtwdev->btc.ant_type = module->ant.type;
+
+	/*
+	 * if only BT0 at BTGA: 2-Ant, 3-Ant(BT1 used dedicated-ant)
+	 * can setup dm->wl_trx_nss_en = 1, WL MIMO-PS to 1T1R
+	 * (WL at WL-S0 only, BT0 at WL-S1)
+	 * tx_limit/rx_limit is decided by _set_trx_nss()
+	 */
+	if (dm->wl_trx_nss_en &&
+	    (dm->wl_trx_nss.tx_limit && dm->wl_trx_nss.rx_limit)) {
+		module->ant.type = BTC_ANT_DEDICATED;
+		module->ant.stream_cnt = 1;
+		dm->ant_xmap[BTC_RF_S0][BTC_BT_1ST] = 0; /* wl 1ss-> RF-S0 */
+		dm->ant_xmap[BTC_RF_S1][BTC_BT_1ST] = 0; /* BT0-> RF-S1 */
+		dm->ant_xmap[BTC_RF_S0][BTC_BT_2ND] = 0;
+		dm->ant_xmap[BTC_RF_S1][BTC_BT_2ND] = 0; /* BT1 -> 3rd Ant */
+	}
+
+	/*
+	 * Todo: call HALBB API to set BT0/1 at WL_S0 or WL_S1
+	 * r_sel_gnt_bt_rx_path0[1:0], r_sel_gnt_bt_rx_path1[1:0]
+	 * WL_S0 with BT1 -> r_sel_gnt_bt_rx_path0[1:0]= 2b'10
+	 * WL_S1 with BT0 -> r_sel_gnt_bt_rx_path1[1:0]= 2b'01
+	 */
+
+	/* To Do: setup ext-SOC coex if exist */
+	switch (cx->bt_ext.chip_id) {
+	default:
+	case BTC_ESOC_NONE:
+		memset(&cx->bt_ext, 0, sizeof(struct rtw89_btc_extsoc_info));
+		cx->bt_ext.max_tx_pwr = RTW89_BTC_BT_DEF_LE_TX_PWR;
+		cx->bt_ext.ant_iso_to_wl = RTW89_BTC_DEFAULT_ANISO;
+		break;
+	case BTC_ESOC_8771:
+		cx->bt_ext.func_type = BTC_BTF_THREAD;
+		cx->bt_ext.hw_coex = BTC_EXTSOC_INTF_PTA;
+		cx->bt_ext.rf_band_map = 0x1; /* 2.4GHz only */
+		cx->bt_ext.link_weight[BTC_BT_B2G] = 10;
+		cx->bt_ext.profile_map[BTC_BT_B2G] |= BTC_BT_THREAD;
+		/* use GPIO 12~15 for Ext-4-wire-PTA */
+		cx->bt_ext.hpta_cfg = BIT(12) | BIT(13) | BIT(14) | BIT(15);
+		/* for Ext-SOC locate at Ant-2 */
+		if (module->ant.num >= 5)
+			module->ant.func[4] = BTC_EFMAP_ZB;
+		else
+			module->ant.func[module->ant.num - 1] = BTC_EFMAP_ZB;
+		break;
+	}
+
+	dm->ant_xmap[BTC_RF_S0][BTC_BT_EXT] = 0;
+	dm->ant_xmap[BTC_RF_S1][BTC_BT_EXT] = 0;
 }
 
 static void rtw8922d_btc_init_cfg(struct rtw89_dev *rtwdev)
-- 
2.25.1


