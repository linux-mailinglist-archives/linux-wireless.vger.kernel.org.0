Return-Path: <linux-wireless+bounces-38892-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /OJLOLsEU2pLWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38892-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DCC743A3D
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=WXhVkpAY;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38892-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38892-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACF813011BC4
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373592571DA;
	Sun, 12 Jul 2026 03:06:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625E27A476
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:06:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825584; cv=none; b=mraFx5eua+Vs932E62uQKJWW5ZN+4i/HtysFRn9kIvPG6qYFdWSZlwOGFmTMSfrp/nyR5tresZAO4k4cNUxODhfVMBtwoboK9FgzkqXjM05yECQlHZKRyeIdRDyxEdBpU9MUUvSONL8yc/AK3RRR3l/RQlKcTfNRwaZ/OI9nLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825584; c=relaxed/simple;
	bh=IK1erWUT4SlV448M+rmQV84Bo15ULpXGQMwtQVSsbcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0tBsTdVZpvjrR8i3Lzq9ANvT4dpqXr+sU56DMf+hAhclaSYWZGJh1ANXFZmrL2aqa8IZCFc1OjNdDYN3Gk6xlag+z/Gj8+LxXWFM0SPNyAlaw/vxPRxV+DHxJMwY7DB+Temq+pKTTEr206bPuaQ6avYh2BJGMGdWXvpc5PIjAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WXhVkpAY; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C36K0b8525856, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783825580; bh=nNsVxX/VGIDw9z1aNtjjy9z5zqLwVfpzQy6xHt9N2Wo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WXhVkpAYLda4T6a+mIcTWwU4WrW1DLwsf46+l/zbu2KnCrOW8FLatRPMt5/AtG7MN
	 9R4cQhZLJO34paT9zDXv0E5n03VxsutQzTBadAMg2KejuKzpfyKqQr4VI0Ij1Uh8g3
	 BttGtZd2dm9Him2A9kVixaTxRjbuBTKSyTimCpF0w2hUt5UGz169fgzf2786sg6Olo
	 rNLeTbZ4AbTSXYXGL4LvXniA+ZkMXf9AyeMpUjtD6rCelVKD+qdVYJLVhKSbo06tdS
	 u8VQb+CYi8ZvG36yzViYKJa/SKyUevR82ZKM600fKcFMqoHhTvoLAQH9fy186R1SCA
	 DIsI98jJLzuaw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C36K0b8525856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:06:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:20 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:06:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 03/11] wifi: rtw89: coex: Update driver outsource info to firmware version 6
Date: Sun, 12 Jul 2026 11:04:58 +0800
Message-ID: <20260712030506.43438-4-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38892-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41DCC743A3D

From: Ching-Te Ku <ku920601@realtek.com>

In order to make dual MAC Wi-Fi performance more stable, and take effect
in time, offload more register/ hardware control to firmware.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c |  13 ++-
 drivers/net/wireless/realtek/rtw89/core.h |  89 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.c   | 101 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h   |   8 +-
 4 files changed, 199 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 72586179ec2c..78360e73d959 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2923,7 +2923,12 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 index)
 		else
 			return;
 
-		rtw89_fw_h2c_cxdrv_osi_info(rtwdev, index);
+		if (ver->fcxosi == 1)
+			rtw89_fw_h2c_cxdrv_osi_info(rtwdev, index);
+		else if (ver->fcxosi == 6)
+			rtw89_fw_h2c_cxdrv_osi_info_v6(rtwdev, index);
+		else
+			return;
 		break;
 	default:
 		break;
@@ -3090,7 +3095,11 @@ static void _set_gnt_v1(struct rtw89_dev *rtwdev, u8 phy_map,
 	}
 
 	memcpy(osi->gnt_set, dm->gnt.band, sizeof(osi->gnt_set));
-	memcpy(osi->wlact_set, dm->gnt.bt, sizeof(osi->wlact_set));
+
+	for (i = 0; i < BTC_ALL_BT; i++) {
+		osi->wlact_set[i].wlan_act_en = dm->gnt.bt[i].wlan_act_en;
+		osi->wlact_set[i].wlan_act = dm->gnt.bt[i].wlan_act;
+	}
 
 	/* GBT source should be GBT_S1 in 1+1 (HWB0:5G + HWB1:2G) case */
 	if (osi->rf_band[BTC_RF_S0] == 1 &&
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0b20ee7d7a28..676d3ba855d7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1322,6 +1322,17 @@ struct rtw89_mac_ax_gnt {
 	u8 gnt_wl;
 } __packed;
 
+struct rtw89_btc_gnt_ctrl {
+	u8 gnt_zb_sw_en;
+	u8 gnt_zb;
+	u8 gnt_bt1_sw_en;
+	u8 gnt_bt1;
+	u8 gnt_bt0_sw_en;
+	u8 gnt_bt0;
+	u8 gnt_wl_sw_en;
+	u8 gnt_wl;
+} __packed;
+
 struct rtw89_mac_ax_wl_act {
 	u8 wlan_act_en;
 	u8 wlan_act;
@@ -3374,27 +3385,89 @@ enum btc_rf_path {
 	BTC_RF_NUM,
 };
 
-struct rtw89_btc_fbtc_outsrc_set_info {
-	u8 rf_band[BTC_RF_NUM]; /* 0:2G, 1:non-2G */
+struct rtw89_btc_fbtc_outsrc_set_info_v1 {
+	u8 rf_band[BTC_RF_NUM];
 	u8 btg_rx[BTC_RF_NUM];
 	u8 nbtg_tx[BTC_RF_NUM];
 
-	struct rtw89_mac_ax_gnt gnt_set[BTC_RF_NUM]; /* refer to btc_gnt_ctrl */
-	struct rtw89_mac_ax_wl_act wlact_set[BTC_RF_NUM]; /* BT0/BT1 */
+	struct rtw89_mac_ax_gnt gnt_set[BTC_RF_NUM];
+	struct rtw89_mac_ax_wl_act wlact_set[BTC_ALL_BT];
 
 	u8 pta_req_hw_band;
 	u8 rf_gbt_source;
 	u8 bt_enable_state;
 	u8 wl_btg_standby_chg;
-	/* bit[15]-> 0:2G/1:5G,6G, bit[14:0]-> WL HWBx ch freq in MHz */
+
+	u8 fbd_group_en[RTW89_MAC_NUM][2];
+	__le16 rf_center_freq[RTW89_MAC_NUM];
+	__le16 fbd_group_bound[RTW89_MAC_NUM][2];
+	__le16 freq_diff_thres[RTW89_MAC_NUM][BTC_ALL_BT];
+} __packed;
+
+struct rtw89_btc_fbtc_outsrc_set_info_v6 {
+	u8 rf_band[BTC_RF_NUM];
+	u8 btg_rx[BTC_RF_NUM];
+	u8 nbtg_tx[BTC_RF_NUM];
+
+	struct rtw89_btc_gnt_ctrl gnt_set[RTW89_MAC_AX_COEX_GNT_NR];
+	struct rtw89_mac_ax_wl_act wlact_set[BTC_ALL_BT_EZL];
+
+	u8 pta_req_hw_band;
+	u8 rf_gbt_source;
+	u8 bt_enable_state;
+	u8 bt_plut_type;
+	u8 wl_tx_limit_en;
+	u8 fc_exec;
+	u8 wl_btg_standby_chg;
+	u8 rsvd;
+	u8 bb_path_sel_bt[BTC_RF_NUM];
+	u8 bb_phy_sel_bt[RTW89_PHY_NUM];
+	u8 fbd_group_en[RTW89_MAC_NUM][2];
+	__le16 rf_center_freq[RTW89_MAC_NUM];
+	__le16 freq_diff_thres[RTW89_MAC_NUM][BTC_ALL_BT_EZL];
+	__le16 fbd_group_bound[RTW89_MAC_NUM][2];
+	__le32 wl_tx_limit_time;
+} __packed;
+
+struct rtw89_btc_fbtc_outsrc_set_info {
+	u8 rf_band[BTC_RF_NUM]; /* 0:2GHz/1:5GHz for MPI_bb_hwsi_ignore_gnt_wl() */
+	u8 btg_rx[BTC_RF_NUM]; /* for MPI_bb_btg_bt_rx() */
+	u8 nbtg_tx[BTC_RF_NUM]; /* for MPI_bb_nbtg_bt_tx pre=AGC control */
+
+	struct rtw89_mac_ax_gnt gnt_set[BTC_RF_NUM]; /* refer to btc_gnt_ctrl */
+	struct rtw89_btc_gnt_ctrl gnt_set_be[RTW89_MAC_AX_COEX_GNT_NR];
+	struct rtw89_mac_ax_wl_act wlact_set[BTC_ALL_BT_EZL];
+
+	u8 pta_req_hw_band; /* Bind PTA to HWB0 or HWB1, only for 8922a 1-PTA */
+	u8 rf_gbt_source; /* gbt from S0 or S1 for RF 0x2[9], only for 8922a */
+
+	/* The followngs are for 8922c/d  new Multi-PTA design */
+	/* 0:BT0/1:BT1/2:ZB on/off for MAC(0xe580[0]/0xe680[0])/ RF 0x4[3:2] */
+	u8 bt_enable_state;
+	u8 bt_plut_type;   /* BT polluted type, refer to enum btc_plt_map */
+
+	u8 wl_tx_limit_en;
+	u8 fc_exec;
+	u8 wl_btg_standby_chg; /* keep RX-IQGen on in standby mode */
+	u8 rsvd;
+
+	u8 bb_path_sel_bt[BTC_RF_NUM]; /* bb s0(1) select GNT_BT0 or BT1 */
+	u8 bb_phy_sel_bt[RTW89_PHY_NUM]; /* bb phy0(1) select GNT_BT0 or BT1 */
+
 	/* forbidden group-> bit[1]:fbd rf-band, bit[0]: fbd enable */
 	u8 fbd_group_en[RTW89_MAC_NUM][2]; /* HWB0/1 +.Group0/1 */
+
+	/* bit[15]-> 0:2G/1:5G,6G, bit[14:0]-> WL HWBx ch freq in MHz */
 	u16 rf_center_freq[RTW89_MAC_NUM]; /* HWB0/1 */
-	/* forbidden group boundary: [15:8]->UP, [7:0]->LO */
-	u16 fbd_group_bound[RTW89_MAC_NUM][2]; /* HWB0/1 +.Group0/1 */
+
 	/* 11-bit in MHz, freq diff threshold */
 	u16 freq_diff_thres[RTW89_MAC_NUM][BTC_ALL_BT_EZL]; /* HWB0/1 vs.BT0/1/2 */
-} __packed;
+
+	/* forbidden group boundary: [15:8]->UP, [7:0]->LO */
+	u16 fbd_group_bound[RTW89_MAC_NUM][2]; /* HWB0/1 +.Group0/1 */
+
+	u32 wl_tx_limit_time;
+};
 
 union rtw89_btc_fbtc_slot_u {
 	struct rtw89_btc_fbtc_slot v1[CXST_MAX];
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 59e51e67d51b..027f8121efd1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6404,6 +6404,7 @@ int rtw89_fw_h2c_cxdrv_osi_info(struct rtw89_dev *rtwdev, u8 type)
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	int ret;
+	u8 i, j;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -6416,7 +6417,105 @@ int rtw89_fw_h2c_cxdrv_osi_info(struct rtw89_dev *rtwdev, u8 type)
 	h2c->hdr.type = type;
 	h2c->hdr.ver = btc->ver->fcxosi;
 	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
-	h2c->osi = *osi;
+
+	memcpy(h2c->osi.rf_band, osi->rf_band, sizeof(osi->rf_band));
+	memcpy(h2c->osi.btg_rx, osi->btg_rx, sizeof(osi->btg_rx));
+	memcpy(h2c->osi.nbtg_tx, osi->nbtg_tx, sizeof(osi->nbtg_tx));
+
+	for (i = 0; i < BTC_RF_NUM; i++) {
+		h2c->osi.gnt_set[i] = osi->gnt_set[i];
+		h2c->osi.wlact_set[i] = osi->wlact_set[i];
+	}
+
+	h2c->osi.pta_req_hw_band = osi->pta_req_hw_band;
+	h2c->osi.rf_gbt_source = osi->rf_gbt_source;
+	h2c->osi.bt_enable_state = osi->bt_enable_state;
+	h2c->osi.wl_btg_standby_chg = osi->wl_btg_standby_chg;
+
+	memcpy(h2c->osi.fbd_group_en, osi->fbd_group_en, sizeof(osi->fbd_group_en));
+
+	for (i = 0; i < RTW89_MAC_NUM; i++) {
+		h2c->osi.rf_center_freq[i] = cpu_to_le16(osi->rf_center_freq[i]);
+		for (j = 0; j < BTC_RF_NUM; j++)
+			h2c->osi.fbd_group_bound[i][j] = cpu_to_le16(osi->fbd_group_bound[i][j]);
+	}
+
+	for (i = 0; i < RTW89_MAC_NUM; i++) {
+		for (j = 0; j < BTC_ALL_BT; j++)
+			h2c->osi.freq_diff_thres[i][j] = cpu_to_le16(osi->freq_diff_thres[i][j]);
+	}
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
+int rtw89_fw_h2c_cxdrv_osi_info_v6(struct rtw89_dev *rtwdev, u8 type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_fbtc_outsrc_set_info *osi = &btc->dm.ost_info;
+	struct rtw89_h2c_cxosi_v6 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+	u8 i, j;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_osi_v6\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxosi_v6 *)skb->data;
+
+	h2c->hdr.type = type;
+	h2c->hdr.ver = btc->ver->fcxosi;
+	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
+
+	memcpy(h2c->osi.rf_band, osi->rf_band, sizeof(osi->rf_band));
+	memcpy(h2c->osi.btg_rx, osi->btg_rx, sizeof(osi->btg_rx));
+	memcpy(h2c->osi.nbtg_tx, osi->nbtg_tx, sizeof(osi->nbtg_tx));
+	memcpy(h2c->osi.gnt_set, osi->gnt_set, sizeof(osi->gnt_set));
+	memcpy(h2c->osi.wlact_set, osi->wlact_set, sizeof(osi->wlact_set));
+
+	h2c->osi.pta_req_hw_band = osi->pta_req_hw_band;
+	h2c->osi.rf_gbt_source = osi->rf_gbt_source;
+	h2c->osi.bt_enable_state = osi->bt_enable_state;
+	h2c->osi.bt_plut_type = osi->bt_plut_type;
+	h2c->osi.wl_tx_limit_en = osi->wl_tx_limit_en;
+	h2c->osi.fc_exec = osi->fc_exec;
+	h2c->osi.wl_btg_standby_chg = osi->wl_btg_standby_chg;
+	h2c->osi.rsvd = osi->rsvd;
+
+	memcpy(h2c->osi.bb_path_sel_bt, osi->bb_path_sel_bt, sizeof(osi->bb_path_sel_bt));
+	memcpy(h2c->osi.bb_phy_sel_bt, osi->bb_phy_sel_bt, sizeof(osi->bb_phy_sel_bt));
+	memcpy(h2c->osi.fbd_group_en, osi->fbd_group_en, sizeof(osi->fbd_group_en));
+
+	for (i = 0; i < RTW89_MAC_NUM; i++) {
+		h2c->osi.rf_center_freq[i] = cpu_to_le16(osi->rf_center_freq[i]);
+		for (j = 0; j < BTC_RF_NUM; j++)
+			h2c->osi.fbd_group_bound[i][j] = cpu_to_le16(osi->fbd_group_bound[i][j]);
+	}
+
+	for (i = 0; i < RTW89_MAC_NUM; i++) {
+		for (j = 0; j < BTC_ALL_BT_EZL; j++)
+			h2c->osi.freq_diff_thres[i][j] = cpu_to_le16(osi->freq_diff_thres[i][j]);
+	}
+
+	h2c->osi.wl_tx_limit_time = cpu_to_le32(osi->wl_tx_limit_time);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, BTFC_SET,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 72f56d32e3b0..c6131778f6a2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2455,7 +2455,12 @@ struct rtw89_h2c_cxrole_v10 {
 
 struct rtw89_h2c_cxosi {
 	struct rtw89_h2c_cxhdr_v7 hdr;
-	struct rtw89_btc_fbtc_outsrc_set_info osi;
+	struct rtw89_btc_fbtc_outsrc_set_info_v1 osi;
+} __packed;
+
+struct rtw89_h2c_cxosi_v6 {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	struct rtw89_btc_fbtc_outsrc_set_info_v6 osi;
 } __packed;
 
 struct rtw89_h2c_cxinit {
@@ -5385,6 +5390,7 @@ int rtw89_fw_h2c_cxdrv_role_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v10(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_osi_info(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_osi_info_v6(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl_v9(struct rtw89_dev *rtwdev, u8 type);
-- 
2.25.1


