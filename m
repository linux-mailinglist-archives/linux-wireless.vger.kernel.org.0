Return-Path: <linux-wireless+bounces-25151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD4AFF7FF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570AF17329A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B974C206F27;
	Thu, 10 Jul 2025 04:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pPC2EO+g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208AD280A3B
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121497; cv=none; b=fcyiOI1mwE+Roh1pLHETyCthsOk2YrG1HRIMh5CZPUpcyU8y7TR7fSQx2RZO/gJP7Hi11kHnI8l2srwdO+vr/HnuALB/EWc0fm3bQmfuCcxtKvuTUVaWYw3CG9jT+Hmjm6hH9eJJ2ycjZxUZl5SebCxqikm+ZfFQvL08ZnME3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121497; c=relaxed/simple;
	bh=0sTlX3eiot2YW92fAeht1nTV5Ji7sfWlemSqwKQC85E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgUWD3D1L9WZYKwKZ9ACnTvJXnT/tt58GcgN1aTfhmB4RACPPtevzTjFM3tjvhv9uZejobcUhQn2T5kiuocjOt/LXhiPCIog5KmNN/qHTS50ja440O9rnyDY8gP0X3NdHEvsOQHPKMdDYTqp1Myuee8wElCDaykbH8+AoE8ZBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pPC2EO+g; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4OrtkE2455772, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121493; bh=Zl0vpWxaHQNZ0hAz7k5rb736WcLhDeylwtF6vVbxkfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pPC2EO+gSzEg+gy37MtzOZhvVeHhuyxolpDcz4ousxOarrJsbI+0kBH/UCfNodL4h
	 +pcCcEb+Lq1Yz7/qHQTwp3q7qXDOpHzoTVltbi48q2W8H8dIAW5elhAdlYwdNNaHHL
	 Va2nPy1c8iwdkCA66RHEwsw116Idebw7pcjMk5wb16KMuhyMTxGxeF6Hb5xNh2G702
	 lXiifM2TDoNiKl9dacK8Laz5JkYyyV6705SOYMbf/cYamwVOLZCmu+LJNRmcPBQTCm
	 8ZAOCwZVza8TJQoHfSF3O+qldbZPIXiafLYmH8MSygIvlkvzYIwr5BZ62EO83KM/Fk
	 xsfD3S/IEZTqA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4OrtkE2455772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:24:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:24:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:24:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/14] wifi: rtw89: add DIG suspend/resume flow when scan and connection
Date: Thu, 10 Jul 2025 12:24:11 +0800
Message-ID: <20250710042423.73617-3-pkshih@realtek.com>
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

The PD lower bound set after one interface is connected, If second
interface needs to connect, packets might not be detected because the
PD lower bound is too high. Therefore, a DIG suspend/resume flow is
added to decrease the PD lower bound during scanning or connection,
and the original PD level is resumed afterward.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c |  4 ++
 drivers/net/wireless/realtek/rtw89/core.c |  2 +
 drivers/net/wireless/realtek/rtw89/core.h |  2 +
 drivers/net/wireless/realtek/rtw89/fw.c   |  2 +
 drivers/net/wireless/realtek/rtw89/phy.c  | 50 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h  |  2 +
 6 files changed, 62 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 32cd09f77e37..1277b1af2a4c 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -7,6 +7,7 @@
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
+#include "phy.h"
 #include "ps.h"
 #include "sar.h"
 #include "util.h"
@@ -2281,6 +2282,7 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_START);
 
 	rtw89_mcc_start_beacon_noa(rtwdev);
+	rtw89_phy_dig_suspend(rtwdev);
 
 	rtw89_mcc_prepare(rtwdev, true);
 	return 0;
@@ -2372,6 +2374,7 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
 
 	rtw89_mcc_stop_beacon_noa(rtwdev);
 	rtw89_fw_h2c_mcc_dig(rtwdev, RTW89_CHANCTX_0, 0, 0, false);
+	rtw89_phy_dig_resume(rtwdev, true);
 
 	rtw89_mcc_prepare(rtwdev, false);
 }
@@ -2715,6 +2718,7 @@ void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
 		return;
 	case RTW89_ENTITY_MODE_MCC_PREPARE:
 		delay = ieee80211_tu_to_usec(RTW89_CHANCTX_TIME_MCC_PREPARE);
+		rtw89_phy_dig_suspend(rtwdev);
 		break;
 	case RTW89_ENTITY_MODE_MCC:
 		delay = ieee80211_tu_to_usec(RTW89_CHANCTX_TIME_MCC);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 23d050041583..da82a88cce98 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4082,6 +4082,7 @@ int rtw89_core_sta_link_add(struct rtw89_dev *rtwdev,
 						     &rtwsta_link->tx_retry);
 			rtw89_mac_set_tx_retry_limit(rtwdev, rtwsta_link, false, 60);
 		}
+		rtw89_phy_dig_suspend(rtwdev);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		ret = rtw89_mac_set_macid_pause(rtwdev, rtwsta_link->mac_id, false);
 		if (ret) {
@@ -4270,6 +4271,7 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 		if (vif->p2p)
 			rtw89_mac_set_tx_retry_limit(rtwdev, rtwsta_link, false,
 						     rtwsta_link->tx_retry);
+		rtw89_phy_dig_resume(rtwdev, false);
 	}
 
 	rtw89_assoc_link_set(rtwsta_link);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1d8f89e83c9a..6c048141e17d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5243,8 +5243,10 @@ struct rtw89_dig_info {
 	s8 tia_gain_a[TIA_GAIN_NUM];
 	s8 tia_gain_g[TIA_GAIN_NUM];
 	s8 *tia_gain;
+	u32 bak_dig;
 	bool is_linked_pre;
 	bool bypass_dig;
+	bool pause_dig;
 };
 
 enum rtw89_multi_cfo_mode {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 3a3109ab7111..ae38ea640384 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7798,6 +7798,7 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rx_fltr);
 
 	rtw89_chanctx_pause(rtwdev, &pause_parm);
+	rtw89_phy_dig_suspend(rtwdev);
 
 	if (mode == RTW89_ENTITY_MODE_MCC)
 		rtw89_hw_scan_update_beacon_noa(rtwdev, req);
@@ -7831,6 +7832,7 @@ static int rtw89_hw_scan_complete_cb(struct rtw89_dev *rtwdev, void *data)
 	ieee80211_wake_queues(rtwdev->hw);
 	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif_link, true);
 	rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
+	rtw89_phy_dig_resume(rtwdev, true);
 
 	rtw89_hw_scan_cleanup(rtwdev, rtwvif_link);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a7412d139902..d607577b353c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6390,6 +6390,7 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
 	u32 pd_val;
 
 	pd_val = __rtw89_phy_dig_dyn_pd_th(rtwdev, bb, rssi, enable, chan);
+	dig->bak_dig = pd_val;
 
 	rtw89_phy_write32_idx(rtwdev, dig_regs->seg0_pd_reg,
 			      dig_regs->pd_lower_bound_mask, pd_val, bb->phy_idx);
@@ -6532,6 +6533,52 @@ static void rtw89_phy_dig_mcc(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 	}
 }
 
+static void rtw89_phy_dig_ctrl(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
+			       bool pause_dig, bool restore)
+{
+	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
+	struct rtw89_dig_info *dig = &bb->dig;
+	bool en_dig;
+	u32 pd_val;
+
+	if (dig->pause_dig == pause_dig)
+		return;
+
+	if (pause_dig) {
+		en_dig = false;
+		pd_val = 0;
+	} else {
+		en_dig = rtwdev->total_sta_assoc > 0;
+		pd_val = restore ? dig->bak_dig : 0;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_DIG, "%s <%s> PD_low=%d", __func__,
+		    pause_dig ? "suspend" : "resume", pd_val);
+
+	rtw89_phy_write32_idx(rtwdev, dig_regs->seg0_pd_reg,
+			      dig_regs->pd_lower_bound_mask, pd_val, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->seg0_pd_reg,
+			      dig_regs->pd_spatial_reuse_en, en_dig, bb->phy_idx);
+
+	dig->pause_dig = pause_dig;
+}
+
+void rtw89_phy_dig_suspend(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_bb_ctx *bb;
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		rtw89_phy_dig_ctrl(rtwdev, bb, true, false);
+}
+
+void rtw89_phy_dig_resume(struct rtw89_dev *rtwdev, bool restore)
+{
+	struct rtw89_bb_ctx *bb;
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		rtw89_phy_dig_ctrl(rtwdev, bb, false, restore);
+}
+
 static void __rtw89_phy_dig(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 {
 	struct rtw89_dig_info *dig = &bb->dig;
@@ -6553,6 +6600,9 @@ static void __rtw89_phy_dig(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 		return;
 	}
 
+	if (unlikely(dig->pause_dig))
+		return;
+
 	if (!dig->is_linked_pre && is_linked) {
 		rtw89_debug(rtwdev, RTW89_DBG_DIG, "First connected\n");
 		rtw89_phy_dig_update_para(rtwdev, bb);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 63cc33c16c9a..dc156376d951 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -1010,6 +1010,8 @@ void rtw89_phy_set_phy_regs(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			    u32 val);
 void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb);
 void rtw89_phy_dig(struct rtw89_dev *rtwdev);
+void rtw89_phy_dig_suspend(struct rtw89_dev *rtwdev);
+void rtw89_phy_dig_resume(struct rtw89_dev *rtwdev, bool restore);
 void rtw89_phy_tx_path_div_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_antdiv_parse(struct rtw89_dev *rtwdev,
 			    struct rtw89_rx_phy_ppdu *phy_ppdu);
-- 
2.25.1


