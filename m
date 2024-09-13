Return-Path: <linux-wireless+bounces-12826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF021977930
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 09:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3F41F242C8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 07:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4B1B9831;
	Fri, 13 Sep 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FeKFtfcZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B71BA894
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211668; cv=none; b=Xj+Z/4zb8mK6y4HtaORtHwTGsy/mhKc4EdUsfq17mjtyEj+lTVIIdfhNUqybGi6zvvQVS6bt7JALUKYPhHuIE2yFjZCg3JkSFO9Oo9k1YQY9SDM1YM6VF/IXqIf4COroffVKPq/tcvqtfAMYYqPIgiJlM+Swe+nTQ1Z8TFB+eaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211668; c=relaxed/simple;
	bh=4XPCBVLzUaVwCkqrMvWzlNLpdaVOZXEAeemFd89r/S0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGhvwYd8evvPqQ+GZl6q8ecuzsVpJAfpcobIUvcGoPFLOHhPG81jZSjeI3iIUkgAXr66/I7ngYeiACY3NX1OYzkYuDqK13bdvof1AYy3KT52hlbGpu0OY231j1+BfhBmVCeu3qwSXKrh0OF3WUxHwuTu2v0YF20Sscj3cWf6gmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FeKFtfcZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48D7ELVo82542223, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726211661; bh=4XPCBVLzUaVwCkqrMvWzlNLpdaVOZXEAeemFd89r/S0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FeKFtfcZEescfFApOM89tlNIufGK4JBUGaPqa6pIiYiIPjtsz2fBym5vWqWHHcM1s
	 69t4qlldZcL/9cwhD9cPH+1vesOGzRrhT5KZ4798p/qkO+E2coNbPvlPyEZtf5hRb3
	 vW5MCQ6qf8603pyCoLiKdzfjig08y4IO/Ra1NXshvSYnpKulfj43tyaRbsYqHm4Jcx
	 cZj15DdwTUrY7RZPTlQHJCVMabAhZbABCf9NkoNLPQgIWPVY41zCQEmcH8aaOrwHrK
	 MMCtFDWA+0mRW8it9rvU4EqvWzrg/hGMKcK96u2YOeA2AK5SMlpwsHbhVEFoiswRpf
	 Vk6AxNOry/R3A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48D7ELVo82542223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 15:14:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 15:14:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 13 Sep
 2024 15:14:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: 8922a: rfk: support firmware command RX DCK v1 format
Date: Fri, 13 Sep 2024 15:13:37 +0800
Message-ID: <20240913071340.41822-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913071340.41822-1-pkshih@realtek.com>
References: <20240913071340.41822-1-pkshih@realtek.com>
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

RX DCK stands for receiver DC calibration. The v1 format adds a field to
indicate the calibration is for operation channel or an average value for
all scanning channels. Update the format accordingly, and increase
firmware format sequence to 2.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 35 +++++++++++++------
 drivers/net/wireless/realtek/rtw89/fw.h       |  9 +++--
 drivers/net/wireless/realtek/rtw89/phy.c      |  4 +--
 drivers/net/wireless/realtek/rtw89/phy.h      |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  6 ++--
 6 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4ed9034fdb46..64b7fd1f6079 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4445,6 +4445,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_SCAN_OFFLOAD_BE_V0,
 	RTW89_FW_FEATURE_WOW_REASON_V1,
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
+	RTW89_FW_FEATURE_RFK_RXDCK_V0,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d9b0e7ebe619..93a338bbf59c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -687,6 +687,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 12, 0, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 22, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, RFK_PRE_NOTIFY_V0),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 42, 0, RFK_RXDCK_V0),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -5518,30 +5519,44 @@ int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 }
 
 int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
-			  const struct rtw89_chan *chan)
+			  const struct rtw89_chan *chan, bool is_chl_k)
 {
+	struct rtw89_h2c_rf_rxdck_v0 *v0;
 	struct rtw89_h2c_rf_rxdck *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
+	int ver = -1;
 	int ret;
 
+	if (RTW89_CHK_FW_FEATURE(RFK_RXDCK_V0, &rtwdev->fw)) {
+		len = sizeof(*v0);
+		ver = 0;
+	}
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c RF RXDCK\n");
 		return -ENOMEM;
 	}
 	skb_put(skb, len);
-	h2c = (struct rtw89_h2c_rf_rxdck *)skb->data;
+	v0 = (struct rtw89_h2c_rf_rxdck_v0 *)skb->data;
+
+	v0->len = len;
+	v0->phy = phy_idx;
+	v0->is_afe = false;
+	v0->kpath = RF_AB;
+	v0->cur_band = chan->band_type;
+	v0->cur_bw = chan->band_width;
+	v0->cur_ch = chan->channel;
+	v0->rxdck_dbg_en = rtw89_debug_is_enabled(rtwdev, RTW89_DBG_RFK);
+
+	if (ver == 0)
+		goto hdr;
 
-	h2c->len = len;
-	h2c->phy = phy_idx;
-	h2c->is_afe = false;
-	h2c->kpath = RF_AB;
-	h2c->cur_band = chan->band_type;
-	h2c->cur_bw = chan->band_width;
-	h2c->cur_ch = chan->channel;
-	h2c->rxdck_dbg_en = rtw89_debug_is_enabled(rtwdev, RTW89_DBG_RFK);
+	h2c = (struct rtw89_h2c_rf_rxdck *)skb->data;
+	h2c->is_chl_k = is_chl_k;
 
+hdr:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
 			      H2C_FUNC_RFK_RXDCK_OFFLOAD, 0, 0, len);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ad47e77d740b..78820bd28098 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4286,7 +4286,7 @@ struct rtw89_h2c_rf_dack {
 	__le32 type;
 } __packed;
 
-struct rtw89_h2c_rf_rxdck {
+struct rtw89_h2c_rf_rxdck_v0 {
 	u8 len;
 	u8 phy;
 	u8 is_afe;
@@ -4297,6 +4297,11 @@ struct rtw89_h2c_rf_rxdck {
 	u8 rxdck_dbg_en;
 } __packed;
 
+struct rtw89_h2c_rf_rxdck {
+	struct rtw89_h2c_rf_rxdck_v0 v0;
+	u8 is_chl_k;
+} __packed;
+
 enum rtw89_rf_log_type {
 	RTW89_RF_RUN_LOG = 0,
 	RTW89_RF_RPT_LOG = 1,
@@ -4501,7 +4506,7 @@ int rtw89_fw_h2c_rf_txgapk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			 const struct rtw89_chan *chan);
 int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
-			  const struct rtw89_chan *chan);
+			  const struct rtw89_chan *chan, bool is_chl_k);
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c7165e757842..0c0d25e602c9 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3171,13 +3171,13 @@ EXPORT_SYMBOL(rtw89_phy_rfk_dack_and_wait);
 int rtw89_phy_rfk_rxdck_and_wait(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx,
 				 const struct rtw89_chan *chan,
-				 unsigned int ms)
+				 bool is_chl_k, unsigned int ms)
 {
 	int ret;
 
 	rtw89_phy_rfk_report_prep(rtwdev);
 
-	ret = rtw89_fw_h2c_rf_rxdck(rtwdev, phy_idx, chan);
+	ret = rtw89_fw_h2c_rf_rxdck(rtwdev, phy_idx, chan, is_chl_k);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 6dd8ec46939a..d00faf151d39 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -929,7 +929,7 @@ int rtw89_phy_rfk_dack_and_wait(struct rtw89_dev *rtwdev,
 int rtw89_phy_rfk_rxdck_and_wait(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx,
 				 const struct rtw89_chan *chan,
-				 unsigned int ms);
+				 bool is_chl_k, unsigned int ms);
 void rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(struct rtw89_dev *rtwdev,
 					       enum rtw89_phy_idx phy,
 					       const struct rtw89_chan *chan,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index fb422bff4912..c2be460f6238 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -13,7 +13,7 @@
 #include "rtw8922a_rfk.h"
 #include "util.h"
 
-#define RTW8922A_FW_FORMAT_MAX 1
+#define RTW8922A_FW_FORMAT_MAX 2
 #define RTW8922A_FW_BASENAME "rtw89/rtw8922a_fw"
 #define RTW8922A_MODULE_FIRMWARE \
 	RTW8922A_FW_BASENAME "-" __stringify(RTW8922A_FW_FORMAT_MAX) ".bin"
@@ -1998,7 +1998,7 @@ static void rtw8922a_rfk_init_late(struct rtw89_dev *rtwdev)
 	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, RTW89_PHY_0, 5);
 
 	rtw89_phy_rfk_dack_and_wait(rtwdev, RTW89_PHY_0, chan, 58);
-	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, chan, 32);
+	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, chan, false, 32);
 }
 
 static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
@@ -2037,7 +2037,7 @@ static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtw
 	rtw89_phy_rfk_iqk_and_wait(rtwdev, phy_idx, chan, 84);
 	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, chan, RTW89_TSSI_NORMAL, 20);
 	rtw89_phy_rfk_dpk_and_wait(rtwdev, phy_idx, chan, 34);
-	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, chan, 32);
+	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, chan, true, 32);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_CHLK, BTC_WRFK_STOP);
-- 
2.25.1


