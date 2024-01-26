Return-Path: <linux-wireless+bounces-2520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DBE83D4CC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920121C22445
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603671D529;
	Fri, 26 Jan 2024 06:34:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C51CF8D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250895; cv=none; b=dgYe4m/GYRKYgCrW91TEOkgh64wOcTeM0Lx5M4MFbfN7F1+GGuLZZpsMITWfZjkXLucsNcVGDyKUTScdwS28KZsK+kq7bb2ZPrsofNzpJ0NF8VijdYUuuKk8s0xiW/YJI0CLkBImIow7fozPTMECW9MNS8U9XiTHrV6TUpqRUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250895; c=relaxed/simple;
	bh=MAaWUjgwoA+nkz39uu/9sUh/BQXEKfTP/T0dmq/GHaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hnn0VgeOe2E9F4+CPUKo7HtTC8jTV5ABHC7n+1ebBwOW7nWeQaQQ8Q0In5Q+jDdG5Tm731IFruZOLSI0jgM+Ie8s8NXrmxymCkW72Gb182Fn3H+YHNzgqmI5vLxlfrYMx3jvnLX6DnLPc6rBfD/5MtE8yFhADJgerZMIVCxpHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40Q6YlpU62085624, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40Q6YlpU62085624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:34:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 26 Jan 2024 14:34:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 14:34:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] wifi: rtw89: add new H2C for PS mode in 802.11be chip
Date: Fri, 26 Jan 2024 14:33:54 +0800
Message-ID: <20240126063356.17857-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126063356.17857-1-pkshih@realtek.com>
References: <20240126063356.17857-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

Because 802.11be chip support MLO mode, driver needs to send new H2C to
pass more connected channel information to firmware, to ensure PS mode
work fine.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 44 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h | 16 +++++++++
 drivers/net/wireless/realtek/rtw89/ps.c |  7 ++--
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7a0671e4ef2c..2f3f2b503507 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2036,6 +2036,50 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_h2c_lps_ch_info *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	if (chip->chip_gen != RTW89_CHIP_BE)
+		return 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c lps_ch_info\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_lps_ch_info *)skb->data;
+
+	h2c->info[0].central_ch = chan->channel;
+	h2c->info[0].pri_ch = chan->primary_channel;
+	h2c->info[0].band = chan->band_type;
+	h2c->info[0].bw = chan->band_width;
+	h2c->mlo_dbcc_mode_lps = cpu_to_le32(MLO_2_PLUS_0_1RF);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_DM,
+			      H2C_FUNC_FW_LPS_CH_INFO, 0, 0, len);
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
 #define H2C_P2P_ACT_LEN 20
 int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			 struct ieee80211_p2p_noa_desc *desc,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 08b8f6d75065..c5c801e9ce3c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1974,6 +1974,17 @@ static inline void SET_LPS_PARM_LASTRPWM(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(15, 8));
 }
 
+struct rtw89_h2c_lps_ch_info {
+	struct {
+		u8 pri_ch;
+		u8 central_ch;
+		u8 bw;
+		u8 band;
+	} __packed info[2];
+
+	__le32 mlo_dbcc_mode_lps;
+} __packed;
+
 static inline void RTW89_SET_FWCMD_CPU_EXCEPTION_TYPE(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 0));
@@ -3896,6 +3907,9 @@ enum rtw89_mcc_h2c_func {
 #define H2C_CL_OUTSRC_RA		0x1
 #define H2C_FUNC_OUTSRC_RA_MACIDCFG	0x0
 
+#define H2C_CL_OUTSRC_DM		0x2
+#define H2C_FUNC_FW_LPS_CH_INFO		0xb
+
 #define H2C_CL_OUTSRC_RF_REG_A		0x8
 #define H2C_CL_OUTSRC_RF_REG_B		0x9
 #define H2C_CL_OUTSRC_RF_FW_NOTIFY	0xa
@@ -4110,6 +4124,8 @@ int rtw89_fw_h2c_init_ba_cam_users(struct rtw89_dev *rtwdev, u8 users,
 
 int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param);
+int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif *rtwvif);
 struct sk_buff *rtw89_fw_h2c_alloc_skb_with_hdr(struct rtw89_dev *rtwdev, u32 len);
 struct sk_buff *rtw89_fw_h2c_alloc_skb_no_hdr(struct rtw89_dev *rtwdev, u32 len);
 int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 917c01e5e9ed..be1dcd9eb955 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -83,16 +83,17 @@ void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
 		rtw89_ps_power_mode_change(rtwdev, false);
 }
 
-static void __rtw89_enter_lps(struct rtw89_dev *rtwdev, u8 mac_id)
+static void __rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	struct rtw89_lps_parm lps_param = {
-		.macid = mac_id,
+		.macid = rtwvif->mac_id,
 		.psmode = RTW89_MAC_AX_PS_MODE_LEGACY,
 		.lastrpwm = RTW89_LAST_RPWM_PS,
 	};
 
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_FW_CTRL);
 	rtw89_fw_h2c_lps_parm(rtwdev, &lps_param);
+	rtw89_fw_h2c_lps_ch_info(rtwdev, rtwvif);
 }
 
 static void __rtw89_leave_lps(struct rtw89_dev *rtwdev, u8 mac_id)
@@ -123,7 +124,7 @@ void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	if (test_and_set_bit(RTW89_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
 
-	__rtw89_enter_lps(rtwdev, rtwvif->mac_id);
+	__rtw89_enter_lps(rtwdev, rtwvif);
 	if (ps_mode)
 		__rtw89_enter_ps_mode(rtwdev, rtwvif);
 }
-- 
2.25.1


