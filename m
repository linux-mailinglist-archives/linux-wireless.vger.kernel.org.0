Return-Path: <linux-wireless+bounces-2227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E142832582
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5029B223DB
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A7928E16;
	Fri, 19 Jan 2024 08:15:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BF28E10
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652146; cv=none; b=kPg+jT9GCgTiHxkArEhqbsVvQgFrmaPYqdzo2y0NKG3al90n8v8xzYonTmRNUjN9aNZv05lx4iq2Ug34F3VejB+R4Cfrby95dlgkj0rofD+/UeRnsQLGZ4/1f3rIsUmUg0CgyoUylw34kEKZ76nbmc1qJ/Vdsjj/JoKHof56pwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652146; c=relaxed/simple;
	bh=BpSL7+zMUqjHxi/NQeqwbF2wgcL56Z0gvZBbVUaflD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPTX3fZ5fwFpltPlXUCcV39MO4ou9pGyuBm9MlETe93gPv2roYPgIqtdDsvXYswtANsDLLcpOpKZF5/m/8pmZt5Innh+XKibORvLwE+NorE2kVk63XxClM62yFAajjPIV/E4lv4koWztRS7Fpw2E7MfWGGKm/B5729TIEiO9iUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40J8FcxN62212431, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40J8FcxN62212431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 16:15:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 19 Jan 2024 16:15:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jan
 2024 16:15:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/8] wifi: rtw89: Set default CQM config if not present
Date: Fri, 19 Jan 2024 16:14:56 +0800
Message-ID: <20240119081501.25223-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119081501.25223-1-pkshih@realtek.com>
References: <20240119081501.25223-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

When wpa_supplicant is initiated by users and not by NetworkManager,
the CQM configuration might not be set. Without this setting, ICs
with connection monitor handled by driver won't detect connection
loss. To fix this we prepare a default setting upon associated at
first, then update again if any is given later.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  2 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 11 +++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h   |  3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 347703b68dfd..dfca642a7570 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3493,6 +3493,8 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 			rtw89_warn(rtwdev, "failed to send h2c general packet\n");
 			return ret;
 		}
+
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
 	}
 
 	return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d967120a8813..ed0ac3726336 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3216,6 +3216,8 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 	struct ieee80211_bss_conf *bss_conf = vif ? &vif->bss_conf : NULL;
+	s32 thold = RTW89_DEFAULT_CQM_THOLD;
+	u32 hyst = RTW89_DEFAULT_CQM_HYST;
 	struct rtw89_h2c_bcnfltr *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -3236,14 +3238,19 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_bcnfltr *)skb->data;
 
+	if (bss_conf->cqm_rssi_hyst)
+		hyst = bss_conf->cqm_rssi_hyst;
+	if (bss_conf->cqm_rssi_thold)
+		thold = bss_conf->cqm_rssi_thold;
+
 	h2c->w0 = le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_RSSI) |
 		  le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_BCN) |
 		  le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_EN) |
 		  le32_encode_bits(RTW89_BCN_FLTR_OFFLOAD_MODE_DEFAULT,
 				   RTW89_H2C_BCNFLTR_W0_MODE) |
 		  le32_encode_bits(RTW89_BCN_LOSS_CNT, RTW89_H2C_BCNFLTR_W0_BCN_LOSS_CNT) |
-		  le32_encode_bits(bss_conf->cqm_rssi_hyst, RTW89_H2C_BCNFLTR_W0_RSSI_HYST) |
-		  le32_encode_bits(bss_conf->cqm_rssi_thold + MAX_RSSI,
+		  le32_encode_bits(hyst, RTW89_H2C_BCNFLTR_W0_RSSI_HYST) |
+		  le32_encode_bits(thold + MAX_RSSI,
 				   RTW89_H2C_BCNFLTR_W0_RSSI_THRESHOLD) |
 		  le32_encode_bits(rtwvif->mac_id, RTW89_H2C_BCNFLTR_W0_MAC_ID);
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index f64fba138834..5d51611d5f6d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -188,6 +188,9 @@ enum rtw89_p2pps_action {
 	RTW89_P2P_ACT_TERMINATE = 3,
 };
 
+#define RTW89_DEFAULT_CQM_HYST 4
+#define RTW89_DEFAULT_CQM_THOLD -70
+
 enum rtw89_bcn_fltr_offload_mode {
 	RTW89_BCN_FLTR_OFFLOAD_MODE_0 = 0,
 	RTW89_BCN_FLTR_OFFLOAD_MODE_1,
-- 
2.25.1


