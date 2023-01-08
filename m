Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B5661603
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 16:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjAHPGt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 10:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHPGs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 10:06:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A62C765
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 07:06:46 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ss4so7004941ejb.11
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jan 2023 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8svGX5B5qn+ChM/ekdahzdCleP/0Pw4yrYrqJ470rJc=;
        b=dC79gqWYFexPy88p0nk7lAnAm1xtvUrObpiTRWIie5CX9N2jHU92lNlwk2l/MN17mm
         Y2mF2Gf7Efeg82pPcgoEFadsxWQ/ZE0EjAsiRiSiWya7WWTvkK5npYWWBYerwBz2cZTs
         /aTdvg/voBRbH5R20VW0ZpjvQ4vtKi4x3UJLABtT0T1V4+NvUmJVZ1Zg88nMXrbp2mDv
         R33n12efEsBreCoYA5WpUuDRaVy8y/B1pTXftMrPoDCLQfJmmTozPhLYSmGkNnYLaYtm
         epEvB0HhF/fGmD4+6aNHn87oUleNq6axu/ywqGRbOow5h7p4iBuE86l4oXKd3Uo/bi/5
         vRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8svGX5B5qn+ChM/ekdahzdCleP/0Pw4yrYrqJ470rJc=;
        b=oLBXeySksaNYoWDRU1UxZ9clR+QM1dHGLiSJZ1nDbcTMgkgJ/6+cVRyFMbdigvFHmM
         Tv5KvSkz9a6g+lzDTsaA/28gMa9G0Bdohr6MndShUHBlTT62Qpvzv2avUmOQeyhGS72q
         ROA2TW7Ldqx827ybFUfOi5kvXEIhtRpPDkgsJ4FNjI73tZJPTh0MEtvWMAhax7ggShTQ
         wtbzUWMu54WoUpXDNvFEn+EUGdk8DQgCMAyddmSdCCyrLuUIDAARGYEdT/ExhswSo0el
         84PxxoIzIVSdJQr1YUr7F3WjV4Qug2k4v2w0WOkrOxYgNkWkFcIDDvuIf2Jrv0gekIHy
         2w7w==
X-Gm-Message-State: AFqh2koKTi/S7oDibtbaSfqo98lb3EdQQkm62wF1dmTD9EH4JLfhmIhY
        2FIbQ8DMuaXA8B0i6S91ODQQJTbuHb4=
X-Google-Smtp-Source: AMrXdXt/Bxsg2I8ZtaXKm7Y3kyy82BCGkJWYGgGujt3p9pHuZL7jkHe+xeABD3/bQRbIKxWzs32Aqg==
X-Received: by 2002:a17:907:c28f:b0:7c1:eb:b2a7 with SMTP id tk15-20020a170907c28f00b007c100ebb2a7mr17978830ejc.13.1673190405179;
        Sun, 08 Jan 2023 07:06:45 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709061daa00b0084cc87c03ebsm2602207ejh.110.2023.01.08.07.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 07:06:44 -0800 (PST)
Message-ID: <2aab4f3f-e914-4fe1-f29a-deac91774d05@gmail.com>
Date:   Sun, 8 Jan 2023 17:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 1/2] wifi: rtl8xxxu: Report the RSSI to the firmware
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Or in the case of RTL8188EU, report the RSSI to the rate control code.

The rate control code for RTL8188EU is less likely to switch to a lower
rate when the RSSI is high. The firmware-based rate control in the other
chips probably works the same way.

This affects all the chips, but it was only tested with RTL8188EU,
RTL8188FU, and RTL8192EU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Suggestion from Ping-Ke Shih:
   - Make h2c_size 4 instead of 3 in rtl8xxxu_gen1_report_rssi().
     Just to make it less confusing. It doesn't change the behaviour.
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 23 +++++++++++++
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |  6 ++++
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         |  1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         |  1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         |  1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  1 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 34 +++++++++++++++++++
 8 files changed, 68 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index be9479f969b7..90268479d3ad 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1168,6 +1168,26 @@ struct h2c_cmd {
 			u8 cmd;
 			u8 data;
 		} __packed bt_grant;
+		struct {
+			u8 cmd;
+			u8 macid;
+			u8 unknown0;
+			u8 rssi;
+			/*
+			 * [0]   - is_rx
+			 * [1]   - stbc_en
+			 * [2]   - noisy_decision
+			 * [6]   - bf_en
+			 */
+			u8 data;
+			/*
+			 * [0:6] - ra_th_offset
+			 * [7]   - ra_offset_direction
+			 */
+			u8 ra_th_offset;
+			u8 unknown1;
+			u8 unknown2;
+		} __packed rssi_report;
 	};
 };
 
@@ -1585,6 +1605,7 @@ struct rtl8xxxu_fileops {
 				  u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
 	void (*report_connect) (struct rtl8xxxu_priv *priv,
 				u8 macid, bool connect);
+	void (*report_rssi) (struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
 	void (*fill_txdesc) (struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			     struct ieee80211_tx_info *tx_info,
 			     struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
@@ -1686,6 +1707,8 @@ void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
 				  u8 macid, bool connect);
 void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
 				  u8 macid, bool connect);
+void rtl8xxxu_gen1_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
+void rtl8xxxu_gen2_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
 void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen1_enable_rf(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen1_disable_rf(struct rtl8xxxu_priv *priv);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index 37658a090aee..08f3b93ad8d0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -1784,6 +1784,11 @@ rtl8188e_update_rate_mask(struct rtl8xxxu_priv *priv,
 	rtl8188e_arfb_refresh(ra);
 }
 
+static void rtl8188e_ra_set_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi)
+{
+	priv->ra_info.rssi_sta_ra = rssi;
+}
+
 void rtl8188e_ra_info_init_all(struct rtl8xxxu_ra_info *ra)
 {
 	ra->decision_rate = DESC_RATE_MCS7;
@@ -1842,6 +1847,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.set_tx_power = rtl8188f_set_tx_power,
 	.update_rate_mask = rtl8188e_update_rate_mask,
 	.report_connect = rtl8xxxu_gen2_report_connect,
+	.report_rssi = rtl8188e_ra_set_rssi,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v3,
 	.set_crystal_cap = rtl8188f_set_crystal_cap,
 	.cck_rssi = rtl8188e_cck_rssi,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index f5a0c7a8a581..af6e2c8a5025 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1732,6 +1732,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.set_tx_power = rtl8188f_set_tx_power,
 	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
 	.report_connect = rtl8xxxu_gen2_report_connect,
+	.report_rssi = rtl8xxxu_gen2_report_rssi,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8188f_set_crystal_cap,
 	.cck_rssi = rtl8188f_cck_rssi,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index 8981a86c833f..e61d65c3579b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -609,6 +609,7 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.set_tx_power = rtl8xxxu_gen1_set_tx_power,
 	.update_rate_mask = rtl8xxxu_update_rate_mask,
 	.report_connect = rtl8xxxu_gen1_report_connect,
+	.report_rssi = rtl8xxxu_gen1_report_rssi,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v1,
 	.cck_rssi = rtl8723a_cck_rssi,
 	.writeN_block_size = 128,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index ca1688600947..4a1c9bcafe31 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1784,6 +1784,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.set_tx_power = rtl8192e_set_tx_power,
 	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
 	.report_connect = rtl8xxxu_gen2_report_connect,
+	.report_rssi = rtl8xxxu_gen2_report_rssi,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.cck_rssi = rtl8192e_cck_rssi,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index e881ee33c6e8..5ed523db2d87 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -478,6 +478,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.set_tx_power = rtl8xxxu_gen1_set_tx_power,
 	.update_rate_mask = rtl8xxxu_update_rate_mask,
 	.report_connect = rtl8xxxu_gen1_report_connect,
+	.report_rssi = rtl8xxxu_gen1_report_rssi,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v1,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.cck_rssi = rtl8723a_cck_rssi,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 0ed667d5ed25..21613d60dc22 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1727,6 +1727,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.set_tx_power = rtl8723b_set_tx_power,
 	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
 	.report_connect = rtl8xxxu_gen2_report_connect,
+	.report_rssi = rtl8xxxu_gen2_report_rssi,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.cck_rssi = rtl8723b_cck_rssi,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index fd97c040948a..4c76fad67150 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4461,6 +4461,37 @@ void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
 	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
 }
 
+void rtl8xxxu_gen1_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi)
+{
+	struct h2c_cmd h2c;
+	const int h2c_size = 4;
+
+	memset(&h2c, 0, sizeof(struct h2c_cmd));
+
+	h2c.rssi_report.cmd = H2C_SET_RSSI;
+	h2c.rssi_report.macid = macid;
+	h2c.rssi_report.rssi = rssi;
+
+	rtl8xxxu_gen1_h2c_cmd(priv, &h2c, h2c_size);
+}
+
+void rtl8xxxu_gen2_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi)
+{
+	struct h2c_cmd h2c;
+	int h2c_size = sizeof(h2c.rssi_report);
+
+	if (priv->rtl_chip == RTL8723B)
+		h2c_size = 4;
+
+	memset(&h2c, 0, sizeof(struct h2c_cmd));
+
+	h2c.rssi_report.cmd = H2C_8723B_RSSI_SETTING;
+	h2c.rssi_report.macid = macid;
+	h2c.rssi_report.rssi = rssi;
+
+	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, h2c_size);
+}
+
 void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
 {
 	u8 agg_ctrl, usb_spec, page_thresh, timeout;
@@ -6701,6 +6732,9 @@ static void rtl8xxxu_watchdog_callback(struct work_struct *work)
 
 		signal = ieee80211_ave_rssi(vif);
 
+		priv->fops->report_rssi(priv, 0,
+					rtl8xxxu_signal_to_snr(signal));
+
 		if (priv->fops->set_crystal_cap)
 			rtl8xxxu_track_cfo(priv);
 
-- 
2.38.0
