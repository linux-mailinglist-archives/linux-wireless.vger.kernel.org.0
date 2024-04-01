Return-Path: <linux-wireless+bounces-5706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7FB8937C4
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 05:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9959281B8A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 03:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8169443D;
	Mon,  1 Apr 2024 03:31:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC82F3E
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 03:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711942299; cv=none; b=B8UlZpT9p8sKvT+VnI6UixRy5BHoOx7fekD6P2vLtRqNJpLkNACDhNdPzzxtM7hZgrfrHK5+tXK/xRlSlgQKCmYOxdWY4kdC4wXOU5xmCk2B5lhGb8UAc2lODGf6lmkWE5cv3hfhpPfkpDfyaiv0RBTsiMdkq1DO07cDVmhBADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711942299; c=relaxed/simple;
	bh=xUblZ8Xu4vAyoBewjt2qFGEL2mQV2zEx029l6nm+cZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IQB9qZi/6CiGTrSLedXb7OTIq1PGKm+ZWNNX+d4grgv4kPsxmsJ1SNbMkO4X8tEZr2Z7mU6xtx8VN0a2KHnmjcTexWxObO2GwrQkuvaoJI/+5HNov3bybRYoF7rIaxMclF4P/mUQzoXNGDgmHxWPmH0bl60+rbFXaTsuucu7v2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4313VX7J02396653, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4313VX7J02396653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 1 Apr 2024 11:31:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 11:31:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 11:31:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH] wifi: rtw88: Set default CQM config if not present
Date: Mon, 1 Apr 2024 11:30:19 +0800
Message-ID: <20240401033019.9664-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Po-Hao Huang <phhuang@realtek.com>

When wpa_supplicant is initiated by users and not by NetworkManager,
the CQM configuration might not be set. Without this setting, ICs
with connection quality monitor handled by firmware won't detect
connection loss. To fix this we prepare a default setting upon
associated at first, then update again if any is given later.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 14 ++++++++++----
 drivers/net/wireless/realtek/rtw88/fw.h       |  2 ++
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 ++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 3f037ddcecf1..ab7d414d0ba6 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -783,12 +783,18 @@ void rtw_fw_beacon_filter_config(struct rtw_dev *rtwdev, bool connect,
 	static const u8 rssi_min = 0, rssi_max = 100, rssi_offset = 100;
 	struct rtw_sta_info *si =
 		sta ? (struct rtw_sta_info *)sta->drv_priv : NULL;
-	s32 threshold = bss_conf->cqm_rssi_thold + rssi_offset;
+	s32 thold = RTW_DEFAULT_CQM_THOLD;
+	u32 hyst = RTW_DEFAULT_CQM_HYST;
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 
 	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_BCN_FILTER))
 		return;
 
+	if (bss_conf->cqm_rssi_thold)
+		thold = bss_conf->cqm_rssi_thold;
+	if (bss_conf->cqm_rssi_hyst)
+		hyst = bss_conf->cqm_rssi_hyst;
+
 	if (!connect) {
 		SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_BCN_FILTER_OFFLOAD_P1);
 		SET_BCN_FILTER_OFFLOAD_P1_ENABLE(h2c_pkt, connect);
@@ -805,15 +811,15 @@ void rtw_fw_beacon_filter_config(struct rtw_dev *rtwdev, bool connect,
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 
 	memset(h2c_pkt, 0, sizeof(h2c_pkt));
-	threshold = clamp_t(s32, threshold, rssi_min, rssi_max);
+	thold = clamp_t(s32, thold + rssi_offset, rssi_min, rssi_max);
 	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_BCN_FILTER_OFFLOAD_P1);
 	SET_BCN_FILTER_OFFLOAD_P1_ENABLE(h2c_pkt, connect);
 	SET_BCN_FILTER_OFFLOAD_P1_OFFLOAD_MODE(h2c_pkt,
 					       BCN_FILTER_OFFLOAD_MODE_DEFAULT);
-	SET_BCN_FILTER_OFFLOAD_P1_THRESHOLD(h2c_pkt, (u8)threshold);
+	SET_BCN_FILTER_OFFLOAD_P1_THRESHOLD(h2c_pkt, thold);
 	SET_BCN_FILTER_OFFLOAD_P1_BCN_LOSS_CNT(h2c_pkt, BCN_LOSS_CNT);
 	SET_BCN_FILTER_OFFLOAD_P1_MACID(h2c_pkt, si->mac_id);
-	SET_BCN_FILTER_OFFLOAD_P1_HYST(h2c_pkt, bss_conf->cqm_rssi_hyst);
+	SET_BCN_FILTER_OFFLOAD_P1_HYST(h2c_pkt, hyst);
 	SET_BCN_FILTER_OFFLOAD_P1_BCN_INTERVAL(h2c_pkt, bss_conf->beacon_int);
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 84e47c71ea12..e999c24e4634 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -29,6 +29,8 @@
 #define BCN_FILTER_CONNECTION_LOSS	1
 #define BCN_FILTER_CONNECTED		2
 #define BCN_FILTER_NOTIFY_BEACON_LOSS	3
+#define RTW_DEFAULT_CQM_THOLD		-70
+#define RTW_DEFAULT_CQM_HYST		4
 
 #define SCAN_NOTIFY_TIMEOUT  msecs_to_jiffies(10)
 
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 7af5bf7fe5b6..0acebbfa13c4 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -386,6 +386,8 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw_coex_media_status_notify(rtwdev, vif->cfg.assoc);
 			if (rtw_bf_support)
 				rtw_bf_assoc(rtwdev, vif, conf);
+
+			rtw_fw_beacon_filter_config(rtwdev, true, vif);
 		} else {
 			rtw_leave_lps(rtwdev);
 			rtw_bf_disassoc(rtwdev, vif, conf);
-- 
2.25.1


