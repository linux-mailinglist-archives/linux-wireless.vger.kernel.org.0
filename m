Return-Path: <linux-wireless+bounces-25153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC0CAFF801
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277DE5A4092
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2DD27F4D4;
	Thu, 10 Jul 2025 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WsuDarqk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20675206F27
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121508; cv=none; b=rzf+3dDcsZIJvL7NQmAw/nhqmRBHWsKxB02excmsUW5TXGoVDoZv3g2bcxLBpUZ3oVaTy1CV0XSgZ2jEhnFr3fLcXJPbGR7PJe/wbK40uGGJEPH8rzfcU7cqhmdAlTr8uVuP1oRoSunBOgKw4dPLh1i7WYE+IRQ7em9sPHbjJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121508; c=relaxed/simple;
	bh=SfMpzxutwVcgsjAwkmfVejRK0/8QYsBRPgGAJu1ll4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u84fdQrsDk2pN/jU2L2vOfv1zg/oQLgm5OvnKzqCpiwMObSMrDCeFdxL4hwkTL/NargDV2joueVi3ZyeSD+W+NWSiCzxAYJmO8H0rO/HsriCwO3BthSGGo12GLr3PJ4Mm0Yt91j2b8o5RBgpq8AR4V9aCg6VJ4hGip3egMQ/FCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WsuDarqk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4P4OJ02455804, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121504; bh=EycqjlRZkvqEJ5zTooZv403FKPERVgZz+oXX6IwVNmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WsuDarqknfKPJuXfRpLNBo56d9E9RICERFp2ypx6Tkj6BxF75m8smxBw1stRKtp18
	 nTinDnf6o00tQgfmADyMSWdJs2E/CiHG1POK2ibGbztNpnGOyUSjUsZoFjYTgRbpTe
	 tp0hIWjAIiOO6hxiS+f+T9/MRN9AzKifU+ZTbtTL72mZJUZU/0q+j+aF5aXPjO5zFo
	 tgxmDZnI8KTun6SPB5fLOQx0vlP+UOtqNBedSikE7OYUHlVCJReeX28PHGWM6/OBJp
	 sI/GGKTCyv+QplX2eflwCGyyggukgy8BfTPQ4aO7UC5qvNB2G/U51Z5WqwQ1yL+Zgb
	 pkea2Zn2by4AA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4P4OJ02455804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:25:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:25:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:25:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/14] wifi: rtw89: mcc: when MCC stop forcing to stay at GO role
Date: Thu, 10 Jul 2025 12:24:13 +0800
Message-ID: <20250710042423.73617-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710042423.73617-1-pkshih@realtek.com>
References: <20250710042423.73617-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

MCC stop might triggered by scan, and need to force to stay at GO role
to keep TX beacon. Also, AX chips need to TX more 3 beacons to ensure
GC can receive once NoA beacon before scan when GC in courtesy mode.
BE chips no needs to TX 3 more beacon because it can TX beacon every
200TU during scan, even GC in courtesy mode can receive beacon every
600TU.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c |  8 ++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  3 ++-
 drivers/net/wireless/realtek/rtw89/fw.c   | 21 ++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/mac.c  |  1 +
 drivers/net/wireless/realtek/rtw89/wow.c  |  2 +-
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index e5ef4f6ab5ca..6c80e08ae99d 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2336,9 +2336,11 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_stop_sel sel = {
 		.hint.target = pause ? pause->trigger : NULL,
 	};
+	bool rsn_scan;
 	int ret;
 
 	if (!pause) {
@@ -2346,6 +2348,12 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
 		bitmap_zero(hal->changes, NUM_OF_RTW89_CHANCTX_CHANGES);
 	}
 
+	rsn_scan = pause && pause->rsn == RTW89_CHANCTX_PAUSE_REASON_HW_SCAN;
+	if (rsn_scan && ref->is_go)
+		sel.hint.target = ref->rtwvif_link;
+	else if (rsn_scan && aux->is_go)
+		sel.hint.target = aux->rtwvif_link;
+
 	/* by default, stop at ref */
 	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_stop_sel_iterator, &sel);
 	if (!sel.filled)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6c048141e17d..c179fcf5b50a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3860,7 +3860,7 @@ struct rtw89_scan_option {
 	u16 slow_pd;
 	u16 norm_cy;
 	u8 opch_end;
-	u16 delay;
+	u16 delay; /* in unit of ms */
 	u64 prohib_chan;
 	enum rtw89_phy_idx band;
 	enum rtw89_scan_be_operation operation;
@@ -5549,6 +5549,7 @@ struct rtw89_hw_scan_info {
 	struct rtw89_hw_scan_extra_op extra_op;
 	bool connected;
 	bool abort;
+	u16 delay; /* in unit of ms */
 };
 
 enum rtw89_phy_bb_gain_band {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ae38ea640384..1fd88dc7da85 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5583,7 +5583,6 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 	return 0;
 }
 
-#define RTW89_SCAN_DELAY_TSF_UNIT 1000000
 int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *option,
 				 struct rtw89_vif_link *rtwvif_link,
@@ -5615,7 +5614,7 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 			scan_mode = RTW89_SCAN_IMMEDIATE;
 		} else {
 			scan_mode = RTW89_SCAN_DELAY;
-			tsf += (u64)option->delay * RTW89_SCAN_DELAY_TSF_UNIT;
+			tsf += (u64)option->delay * 1000;
 		}
 	}
 
@@ -5781,7 +5780,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 				   RTW89_H2C_SCANOFLD_BE_W4_PROBE_5G) |
 		  le32_encode_bits(probe_id[NL80211_BAND_6GHZ],
 				   RTW89_H2C_SCANOFLD_BE_W4_PROBE_6G) |
-		  le32_encode_bits(option->delay, RTW89_H2C_SCANOFLD_BE_W4_DELAY_START);
+		  le32_encode_bits(option->delay / 1000, RTW89_H2C_SCANOFLD_BE_W4_DELAY_START);
 
 	h2c->w5 = le32_encode_bits(option->mlo_mode, RTW89_H2C_SCANOFLD_BE_W5_MLO_MODE);
 
@@ -6826,6 +6825,7 @@ static void rtw89_hw_scan_cleanup(struct rtw89_dev *rtwdev,
 	scan_info->scanning_vif = NULL;
 	scan_info->abort = false;
 	scan_info->connected = false;
+	scan_info->delay = 0;
 }
 
 static bool rtw89_is_6ghz_wildcard_probe_req(struct rtw89_dev *rtwdev,
@@ -7628,9 +7628,22 @@ static void rtw89_hw_scan_update_link_beacon_noa(struct rtw89_dev *rtwdev,
 						 u16 tu)
 {
 	struct ieee80211_p2p_noa_desc noa_desc = {};
+	struct ieee80211_bss_conf *bss_conf;
+	u16 beacon_int;
 	u64 tsf;
 	int ret;
 
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	beacon_int = bss_conf->beacon_int;
+
+	rcu_read_unlock();
+
+	tu += beacon_int * 3;
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_AX)
+		rtwdev->scan_info.delay = ieee80211_tu_to_usec(beacon_int * 3) / 1000;
+
 	ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif_link, &tsf);
 	if (ret) {
 		rtw89_warn(rtwdev, "%s: failed to get tsf\n", __func__);
@@ -7770,6 +7783,7 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	rtwdev->scan_info.connected = rtw89_is_any_vif_connected_or_connecting(rtwdev);
 	rtwdev->scan_info.scanning_vif = rtwvif_link;
 	rtwdev->scan_info.abort = false;
+	rtwdev->scan_info.delay = 0;
 	rtwvif->scan_ies = &scan_req->ies;
 	rtwvif->scan_req = req;
 
@@ -7912,6 +7926,7 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev,
 	connected = rtwdev->scan_info.connected;
 	opt.enable = enable;
 	opt.target_ch_mode = connected;
+	opt.delay = rtwdev->scan_info.delay;
 	if (enable) {
 		ret = mac->add_chan_list(rtwdev, rtwvif_link);
 		if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ff4335ef4033..37b113e3bd26 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5049,6 +5049,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 
 		if (rtwvif_link && rtwvif->scan_req &&
 		    !list_empty(&rtwdev->scan_info.chan_list)) {
+			rtwdev->scan_info.delay = 0;
 			ret = rtw89_hw_scan_offload(rtwdev, rtwvif_link, true);
 			if (ret) {
 				rtw89_hw_scan_abort(rtwdev, rtwvif_link);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index c935d6683d83..4f759c75389e 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1477,7 +1477,7 @@ static int rtw89_pno_scan_offload(struct rtw89_dev *rtwdev, bool enable)
 	opt.enable = enable;
 	opt.repeat = RTW89_SCAN_NORMAL;
 	opt.norm_pd = max(interval, 1) * 10; /* in unit of 100ms */
-	opt.delay = max(rtw_wow->nd_config->delay, 1);
+	opt.delay = max(rtw_wow->nd_config->delay, 1) * 1000;
 
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
 		opt.operation = enable ? RTW89_SCAN_OP_START : RTW89_SCAN_OP_STOP;
-- 
2.25.1


