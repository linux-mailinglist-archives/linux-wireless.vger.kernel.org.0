Return-Path: <linux-wireless+bounces-21812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAA3A95AA7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD604188EB9F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C773318D63A;
	Tue, 22 Apr 2025 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nINZL8Up"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978C6645
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286442; cv=none; b=nAssftsk/WbRStxc+zljO3MGGfrXiAfJxocjP2o2Lz2H9/+VHdU2hlvZaZqQuSnhYtg7Tr9WyozOxfVkde0fMcf4PESQ5YjNs0eHAdCgYTmQRi66iUCE7TuPbTLI9LhSZ/0JFOn2DQzOVwRBf4WP2GHss++Zga4eXgT0IoGVf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286442; c=relaxed/simple;
	bh=qbb8ZUCxcMb32zQ+zMfRl3P5JOr2oMpsB7QA6dI9OYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtCk+m+MzZhSZt3ewmF8hKa/TrB3QeUCy9vLnF4Q8o1Bo8cf9ALWxOPj1bAJI5jT7CZbFZNhTztJRtH+VRVxaIx4FTbE16QglBN0Jeny3ouZjtSc+TaT7Jyv+R7iK7tholPTVcPftjrIxtgxIFW9V+CHNyFHmGRyZcWbfeMasqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nINZL8Up; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1lJK413859557, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286439; bh=qbb8ZUCxcMb32zQ+zMfRl3P5JOr2oMpsB7QA6dI9OYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nINZL8Upc+ffEQLsaIw/PSrb5orBk8E8HordVR9B758y5NRpsKSet+swLdmkMXcDB
	 5z0HQ4HtZdGC16FVRk9LSjltP5/DWXwoe/XClutSkgF9T4ZbMU/xsVTASlBbUlDCZg
	 obEWgklqk7S8OepgMxNdCWdMhdmb7dnC1F9cfWZc0brg0kt70MEGm9hdc47VHnIoTE
	 JgYMMqdCydfkRtc1LgibZVmxZSnY8o0toC28G6iIKEFoe4Zfzr4Y7qzv3Ii5XIFXeR
	 uwyeOGBkcGM9NucnkO8A1Cj8k1fUu9Ur+RnIoi8vnyoRFsnMpV5qFoJZMeDV2Nlk//
	 jbQRXtBAFDgAw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1lJK413859557
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/12] wifi: rtw89: mcc: make GO+STA mode calculate dynamic beacon offset
Date: Tue, 22 Apr 2025 09:46:15 +0800
Message-ID: <20250422014620.18421-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

There are two roles during MCC and the offset between their TBTT is called
beacon offset. Originally, when MCC runs GO+STA mode, it used fixed beacon
offset to simplify some logic because GO role can master its TSF. However,
if MCC is stopped and restarted before a same GO is down, its TSF might be
discontinuous. Then, there might be undefined behavior happens in GC sides.
So, to let a same GO have a continuous TSF, MCC no longer changes its TSF
to meet a fixed beacon offset. Instead, GO+STA mode also calculates beacon
offset dynamically as what GC+STA mode did.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 84 ++++-------------------
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 16 insertions(+), 69 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index f60e93870b09..b5fb5669eefe 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -557,7 +557,9 @@ static u32 rtw89_mcc_get_tbtt_ofst(struct rtw89_dev *rtwdev,
 	u64 sync_tsf = READ_ONCE(rtwvif_link->sync_bcn_tsf);
 	u32 remainder;
 
-	if (tsf < sync_tsf) {
+	if (role->is_go) {
+		sync_tsf = 0;
+	} else if (tsf < sync_tsf) {
 		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 			    "MCC get tbtt ofst: tsf might not update yet\n");
 		sync_tsf = 0;
@@ -1439,57 +1441,6 @@ static bool rtw89_mcc_duration_decision_on_bt(struct rtw89_dev *rtwdev)
 	return false;
 }
 
-static void rtw89_mcc_sync_tbtt(struct rtw89_dev *rtwdev,
-				struct rtw89_mcc_role *tgt,
-				struct rtw89_mcc_role *src,
-				bool ref_is_src)
-{
-	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
-	struct rtw89_mcc_config *config = &mcc->config;
-	u16 beacon_offset_us = ieee80211_tu_to_usec(config->beacon_offset);
-	u32 bcn_intvl_src_us = ieee80211_tu_to_usec(src->beacon_interval);
-	u32 cur_tbtt_ofst_src;
-	u32 tsf_ofst_tgt;
-	u32 remainder;
-	u64 tbtt_tgt;
-	u64 tsf_src;
-	int ret;
-
-	ret = rtw89_mac_port_get_tsf(rtwdev, src->rtwvif_link, &tsf_src);
-	if (ret) {
-		rtw89_warn(rtwdev, "MCC failed to get port tsf: %d\n", ret);
-		return;
-	}
-
-	cur_tbtt_ofst_src = rtw89_mcc_get_tbtt_ofst(rtwdev, src, tsf_src);
-
-	if (ref_is_src)
-		tbtt_tgt = tsf_src - cur_tbtt_ofst_src + beacon_offset_us;
-	else
-		tbtt_tgt = tsf_src - cur_tbtt_ofst_src +
-			   (bcn_intvl_src_us - beacon_offset_us);
-
-	div_u64_rem(tbtt_tgt, bcn_intvl_src_us, &remainder);
-	tsf_ofst_tgt = bcn_intvl_src_us - remainder;
-
-	config->sync.macid_tgt = tgt->rtwvif_link->mac_id;
-	config->sync.band_tgt = tgt->rtwvif_link->mac_idx;
-	config->sync.port_tgt = tgt->rtwvif_link->port;
-	config->sync.macid_src = src->rtwvif_link->mac_id;
-	config->sync.band_src = src->rtwvif_link->mac_idx;
-	config->sync.port_src = src->rtwvif_link->port;
-	config->sync.offset = tsf_ofst_tgt / 1024;
-	config->sync.enable = true;
-
-	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
-		    "MCC sync tbtt: tgt %d, src %d, offset %d\n",
-		    config->sync.macid_tgt, config->sync.macid_src,
-		    config->sync.offset);
-
-	rtw89_mac_port_tsf_sync(rtwdev, tgt->rtwvif_link, src->rtwvif_link,
-				config->sync.offset);
-}
-
 static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1497,17 +1448,19 @@ static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 	struct rtw89_mcc_config *config = &mcc->config;
 	u32 bcn_intvl_ref_us = ieee80211_tu_to_usec(ref->beacon_interval);
 	u32 tob_ref_us = ieee80211_tu_to_usec(config->pattern.tob_ref);
-	struct rtw89_vif_link *rtwvif_link = ref->rtwvif_link;
 	u64 tsf, start_tsf;
 	u32 cur_tbtt_ofst;
 	u64 min_time;
+	u64 tsf_aux;
 	int ret;
 
-	ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif_link, &tsf);
-	if (ret) {
-		rtw89_warn(rtwdev, "MCC failed to get port tsf: %d\n", ret);
+	if (rtw89_concurrent_via_mrc(rtwdev))
+		ret = __mrc_fw_req_tsf(rtwdev, &tsf, &tsf_aux);
+	else
+		ret = __mcc_fw_req_tsf(rtwdev, &tsf, &tsf_aux);
+
+	if (ret)
 		return ret;
-	}
 
 	min_time = tsf;
 	if (ref->is_go)
@@ -1521,6 +1474,7 @@ static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 		start_tsf += bcn_intvl_ref_us;
 
 	config->start_tsf = start_tsf;
+	config->start_tsf_in_aux_domain = tsf_aux + start_tsf - tsf;
 	return 0;
 }
 
@@ -1537,13 +1491,11 @@ static int rtw89_mcc_fill_config(struct rtw89_dev *rtwdev)
 
 	switch (mcc->mode) {
 	case RTW89_MCC_MODE_GO_STA:
-		config->beacon_offset = RTW89_MCC_DFLT_BCN_OFST_TIME;
+		config->beacon_offset = rtw89_mcc_get_bcn_ofst(rtwdev);
 		if (ref->is_go) {
-			rtw89_mcc_sync_tbtt(rtwdev, ref, aux, false);
 			config->mcc_interval = ref->beacon_interval;
 			rtw89_mcc_set_duration_go_sta(rtwdev, ref, aux);
 		} else {
-			rtw89_mcc_sync_tbtt(rtwdev, aux, ref, true);
 			config->mcc_interval = aux->beacon_interval;
 			rtw89_mcc_set_duration_go_sta(rtwdev, aux, ref);
 		}
@@ -2000,30 +1952,24 @@ static void rtw89_mcc_handle_beacon_noa(struct rtw89_dev *rtwdev, bool enable)
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
 	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_config *config = &mcc->config;
-	struct rtw89_mcc_pattern *pattern = &config->pattern;
-	struct rtw89_mcc_sync *sync = &config->sync;
 	struct ieee80211_p2p_noa_desc noa_desc = {};
-	u64 start_time = config->start_tsf;
 	u32 interval = config->mcc_interval;
 	struct rtw89_vif_link *rtwvif_go;
+	u64 start_time;
 	u32 duration;
 
 	if (mcc->mode != RTW89_MCC_MODE_GO_STA)
 		return;
 
 	if (ref->is_go) {
+		start_time = config->start_tsf;
 		rtwvif_go = ref->rtwvif_link;
 		start_time += ieee80211_tu_to_usec(ref->duration);
 		duration = config->mcc_interval - ref->duration;
 	} else if (aux->is_go) {
+		start_time = config->start_tsf_in_aux_domain;
 		rtwvif_go = aux->rtwvif_link;
-		start_time += ieee80211_tu_to_usec(pattern->tob_ref) +
-			      ieee80211_tu_to_usec(config->beacon_offset) +
-			      ieee80211_tu_to_usec(pattern->toa_aux);
 		duration = config->mcc_interval - aux->duration;
-
-		/* convert time domain from sta(ref) to GO(aux) */
-		start_time += ieee80211_tu_to_usec(sync->offset);
 	} else {
 		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 			    "MCC find no GO: skip updating beacon NoA\n");
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ae5df39b68cd..5b77db6fd578 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5695,6 +5695,7 @@ struct rtw89_mcc_config {
 	struct rtw89_mcc_pattern pattern;
 	struct rtw89_mcc_sync sync;
 	u64 start_tsf;
+	u64 start_tsf_in_aux_domain;
 	u16 mcc_interval; /* TU */
 	u16 beacon_offset; /* TU */
 };
-- 
2.25.1


