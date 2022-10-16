Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293DC600263
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Oct 2022 19:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJPR2n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Oct 2022 13:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJPR2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Oct 2022 13:28:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB0FD52
        for <linux-wireless@vger.kernel.org>; Sun, 16 Oct 2022 10:28:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s30so13121581eds.1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Oct 2022 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oyL57LTC9iwpk+CJtWGwYbo5mf67Zd1cH8KjsLtLy1Q=;
        b=IrWtXdU2Vh2zDEpZUdXA3NXsRV/0i4Fyvtc2NqRSp/gYwfhh0uPa9YxfZhXrmxsFxU
         exQSb73HrRqYhZ8pVRrA484DxNokd97Vdp0DLvySpyoBpKVJp353AIp0nO9vT1xhecF/
         T228QZUw81R0bhggfTJrSheB8Fec0Srr2lQi/Zcg6MHa0FKgr6QrVGuL9oIoakiQ1ebC
         LirZg42+PMUOdrUgpQMxGJsh2t/aoZ42orVQ2xwWcR/3LTsBSKag5ZimjeBCW1wtc/3t
         8oy0PS13ID/ydhFtp9/QfEbGgwCcUIWFada7dGrXc/56/6aV5ldpFtzM9wtCV1hHbYkR
         hhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyL57LTC9iwpk+CJtWGwYbo5mf67Zd1cH8KjsLtLy1Q=;
        b=tZ2TEKW21S57eFrfUVc3n3hTEvKXxQBqBT/pGv5hsj0UT9CqJrk6wG3PM+vU4gaCHc
         Rj7XgW7P1RnjFJu0VmYP//jy8oHUTm6D+NFUW7NEXyESvBrz5HntNQrb/D9tCosJsX1v
         hRhLJdFz99ZQFDzKztOj4G2sOPsiQFN3YKpUITfjNODRcgSk6Bmga0LmWFEhWhnxfQCa
         rvunS2yYXolyslNv0Jj/gm8+PmsF36ExMwfkNESB0aDB9EsAr8lqgSl0hzjTHrpzaVls
         xsids3INIrydKf2OvEM0De3K/jv1UOQubNfq3A1bAIXfpZ/wZKi5oIE+19jOmLZqrCAA
         ojVg==
X-Gm-Message-State: ACrzQf3EN5qvFvvbX1ECsZ9uuQbXabEAUyXYZzvLSjr19l2JSKFNl2wY
        7p59LwikTsQQxB9bvaOrCskfpLqpfd4=
X-Google-Smtp-Source: AMsMyM69nZvr1jQZz2ydd2ROEMCXB1XB2GWZPtN+aSu5sbz+0EtlGCimgrYLMssS1UZNbXPmkB7W0g==
X-Received: by 2002:aa7:dbd2:0:b0:45c:97bb:4ae0 with SMTP id v18-20020aa7dbd2000000b0045c97bb4ae0mr6820629edt.417.1665941311469;
        Sun, 16 Oct 2022 10:28:31 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id d9-20020a170906370900b0073022b796a7sm4906121ejc.93.2022.10.16.10.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 10:28:31 -0700 (PDT)
Message-ID: <28d0202b-4afd-0ea6-e597-a8c6c85c58aa@gmail.com>
Date:   Sun, 16 Oct 2022 20:28:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
In-Reply-To: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
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

The CCK RSSI calculation is incorrect for the RTL8723BU, RTL8192EU,
and RTL8188FU. Add new functions for these chips with code copied from
their vendor drivers. Use the old code only for the RTL8723AU and
RTL8192CU.

I didn't notice any difference in the reported signal strength with my
RTL8188FU, but I didn't look very hard either.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 ++
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         | 32 ++++++++++++++++
 .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         |  1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 23 +++++++++++
 .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         | 23 +++++++++++
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         | 29 ++++++++++++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 38 ++++++++++++-------
 7 files changed, 135 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 14f0b3224553..34eb040214ad 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1395,6 +1395,7 @@ struct rtl8xxxu_priv {
 	u32 ep_tx_normal_queue:1;
 	u32 ep_tx_low_queue:1;
 	u32 rx_buf_aggregation:1;
+	u32 cck_agc_report_type:1;
 	u8 default_crystal_cap;
 	unsigned int pipe_interrupt;
 	unsigned int pipe_in;
@@ -1500,6 +1501,7 @@ struct rtl8xxxu_fileops {
 			     bool short_preamble, bool ampdu_enable,
 			     u32 rts_rate);
 	void (*set_crystal_cap) (struct rtl8xxxu_priv *priv, u8 crystal_cap);
+	s8 (*cck_rssi) (struct rtl8xxxu_priv *priv, u8 cck_agc_rpt);
 	int writeN_block_size;
 	int rx_agg_buf_size;
 	char tx_desc_size;
@@ -1611,6 +1613,7 @@ void rtl8723bu_set_ps_tdma(struct rtl8xxxu_priv *priv,
 			   u8 arg1, u8 arg2, u8 arg3, u8 arg4, u8 arg5);
 void rtl8723bu_phy_init_antenna_selection(struct rtl8xxxu_priv *priv);
 void rtl8723a_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap);
+s8 rtl8723a_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt);
 
 extern struct rtl8xxxu_fileops rtl8188fu_fops;
 extern struct rtl8xxxu_fileops rtl8192cu_fops;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 39ae4d971ff6..5917c918ab1e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1654,6 +1654,37 @@ static void rtl8188f_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
 	cfo->crystal_cap = crystal_cap;
 }
 
+static s8 rtl8188f_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
+{
+	s8 rx_pwr_all = 0x00;
+	u8 vga_idx, lna_idx;
+
+	lna_idx = (cck_agc_rpt & 0xE0) >> 5;
+	vga_idx = cck_agc_rpt & 0x1F;
+
+	switch (lna_idx) {
+	case 7:
+		if (vga_idx <= 27)
+			rx_pwr_all = -100 + 2 * (27 - vga_idx);
+		else
+			rx_pwr_all = -100;
+		break;
+	case 5:
+		rx_pwr_all = -74 + 2 * (21 - vga_idx);
+		break;
+	case 3:
+		rx_pwr_all = -60 + 2 * (20 - vga_idx);
+		break;
+	case 1:
+		rx_pwr_all = -44 + 2 * (19 - vga_idx);
+		break;
+	default:
+		break;
+	}
+
+	return rx_pwr_all;
+}
+
 struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.parse_efuse = rtl8188fu_parse_efuse,
 	.load_firmware = rtl8188fu_load_firmware,
@@ -1679,6 +1710,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8188f_set_crystal_cap,
+	.cck_rssi = rtl8188f_cck_rssi,
 	.writeN_block_size = 128,
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index e9bc94edfa79..9dfeeaa74927 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -561,6 +561,7 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.update_rate_mask = rtl8xxxu_update_rate_mask,
 	.report_connect = rtl8xxxu_gen1_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v1,
+	.cck_rssi = rtl8723a_cck_rssi,
 	.writeN_block_size = 128,
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 20924bafcb50..8af2c9dd923e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1689,6 +1689,28 @@ static void rtl8192eu_init_aggregation(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32(priv, REG_RXDMA_AGG_PG_TH, agg_rx);
 }
 
+static s8 rtl8192e_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
+{
+	static const s8 lna_gain_table_0[8] = { 15, 9, -10, -21, -23, -27, -43, -44 };
+	static const s8 lna_gain_table_1[8] = { 24, 18, 13, -4, -11, -18, -31, -36 };
+
+	s8 rx_pwr_all = 0x00;
+	u8 vga_idx, lna_idx;
+	s8 lna_gain = 0;
+
+	lna_idx = (cck_agc_rpt & 0xE0) >> 5;
+	vga_idx = cck_agc_rpt & 0x1F;
+
+	if (priv->cck_agc_report_type == 0)
+		lna_gain = lna_gain_table_0[lna_idx];
+	else
+		lna_gain = lna_gain_table_1[lna_idx];
+
+	rx_pwr_all = lna_gain - (2 * vga_idx);
+
+	return rx_pwr_all;
+}
+
 struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.parse_efuse = rtl8192eu_parse_efuse,
 	.load_firmware = rtl8192eu_load_firmware,
@@ -1711,6 +1733,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
+	.cck_rssi = rtl8192e_cck_rssi,
 	.writeN_block_size = 128,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index 6a452d00f03b..4e54b1035e53 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -383,6 +383,28 @@ void rtl8723a_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
 	cfo->crystal_cap = crystal_cap;
 }
 
+s8 rtl8723a_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
+{
+	s8 rx_pwr_all = 0x00;
+
+	switch (cck_agc_rpt & 0xc0) {
+	case 0xc0:
+		rx_pwr_all = -46 - (cck_agc_rpt & 0x3e);
+		break;
+	case 0x80:
+		rx_pwr_all = -26 - (cck_agc_rpt & 0x3e);
+		break;
+	case 0x40:
+		rx_pwr_all = -12 - (cck_agc_rpt & 0x3e);
+		break;
+	case 0x00:
+		rx_pwr_all = 16 - (cck_agc_rpt & 0x3e);
+		break;
+	}
+
+	return rx_pwr_all;
+}
+
 struct rtl8xxxu_fileops rtl8723au_fops = {
 	.parse_efuse = rtl8723au_parse_efuse,
 	.load_firmware = rtl8723au_load_firmware,
@@ -405,6 +427,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.report_connect = rtl8xxxu_gen1_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v1,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
+	.cck_rssi = rtl8723a_cck_rssi,
 	.writeN_block_size = 1024,
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index ead2ff5edad1..7acbcf32aad7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1639,6 +1639,34 @@ static void rtl8723bu_init_statistics(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32(priv, REG_OFDM0_FA_RSTC, val32);
 }
 
+static s8 rtl8723b_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
+{
+	s8 rx_pwr_all = 0x00;
+	u8 vga_idx, lna_idx;
+
+	lna_idx = (cck_agc_rpt & 0xE0) >> 5;
+	vga_idx = cck_agc_rpt & 0x1F;
+
+	switch (lna_idx) {
+	case 6:
+		rx_pwr_all = -34 - (2 * vga_idx);
+		break;
+	case 4:
+		rx_pwr_all = -14 - (2 * vga_idx);
+		break;
+	case 1:
+		rx_pwr_all = 6 - (2 * vga_idx);
+		break;
+	case 0:
+		rx_pwr_all = 16 - (2 * vga_idx);
+		break;
+	default:
+		break;
+	}
+
+	return rx_pwr_all;
+}
+
 struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.parse_efuse = rtl8723bu_parse_efuse,
 	.load_firmware = rtl8723bu_load_firmware,
@@ -1664,6 +1692,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
+	.cck_rssi = rtl8723b_cck_rssi,
 	.writeN_block_size = 1024,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 947916363e3f..2efc99896b96 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4325,6 +4325,29 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		val32 &= 0xfff00fff;
 		val32 |= 0x0007e000;
 		rtl8xxxu_write32(priv, REG_AFE_MISC, val32);
+
+		/*
+		 * 0x824[9] = 0x82C[9] = 0xA80[7] those registers setting
+		 * should be equal or CCK RSSI report may be incorrect
+		 */
+		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XA_HSSI_PARM2);
+		priv->cck_agc_report_type = val32 & FPGA0_HSSI_PARM2_CCK_HIGH_PWR;
+
+		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XB_HSSI_PARM2);
+		if (priv->cck_agc_report_type != (bool)(val32 & FPGA0_HSSI_PARM2_CCK_HIGH_PWR)) {
+			if (priv->cck_agc_report_type)
+				val32 |= FPGA0_HSSI_PARM2_CCK_HIGH_PWR;
+			else
+				val32 &= ~FPGA0_HSSI_PARM2_CCK_HIGH_PWR;
+			rtl8xxxu_write32(priv, REG_FPGA0_XB_HSSI_PARM2, val32);
+		}
+
+		val32 = rtl8xxxu_read32(priv, 0xa80);
+		if (priv->cck_agc_report_type)
+			val32 |= BIT(7);
+		else
+			val32 &= ~BIT(7);
+		rtl8xxxu_write32(priv, 0xa80, val32);
 	}
 
 	/* Initialise the center frequency offset tracking */
@@ -5314,20 +5337,7 @@ static void rtl8xxxu_rx_parse_phystats(struct rtl8xxxu_priv *priv,
 		 */
 		u8 cck_agc_rpt = phy_stats->cck_agc_rpt_ofdm_cfosho_a;
 
-		switch (cck_agc_rpt & 0xc0) {
-		case 0xc0:
-			rx_status->signal = -46 - (cck_agc_rpt & 0x3e);
-			break;
-		case 0x80:
-			rx_status->signal = -26 - (cck_agc_rpt & 0x3e);
-			break;
-		case 0x40:
-			rx_status->signal = -12 - (cck_agc_rpt & 0x3e);
-			break;
-		case 0x00:
-			rx_status->signal = 16 - (cck_agc_rpt & 0x3e);
-			break;
-		}
+		rx_status->signal = priv->fops->cck_rssi(priv, cck_agc_rpt);
 	} else {
 		bool parse_cfo = priv->fops->set_crystal_cap &&
 				 priv->vif &&
-- 
2.38.0
