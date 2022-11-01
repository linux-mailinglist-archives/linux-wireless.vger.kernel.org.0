Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111A9615358
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 21:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKAUdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiKAUdO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 16:33:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F6D1EC42
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 13:33:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a13so23494671edj.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Nov 2022 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jImU1NNC1c3Ajnzr22m6tNEziSK+c84GKzrxKyxQok4=;
        b=DJk4phpZxiBVx8Iq5+m0YuOvLYsIk9kRCu+YlCJ/KUMZtr72KsXagCFDPW26EfIGpU
         iZZ+3rRTA16etugFC8riLTAH06KUkyNOpbm5nq5hDBaxEGyOh9NsX0yNKau05P72cy7o
         AABY0nEPfxj2OBeW2NM9aHLVznAyvefbDvSM1nKvmgVXS+RgK/Moa3TW9xD4ls6JvXvO
         ReM6sXDcDO/xI5KRCbBM39KczNrB/NxqfcCTr/jfNHza2o5uHbm/53dhbeW8YSuF8p5G
         vnRvXGy6u4YSRc2L/NCCVyv/YTfpj/ME2maypydr1ndjzVQXvg1kS/7poU+W3p3FL9Fa
         i42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jImU1NNC1c3Ajnzr22m6tNEziSK+c84GKzrxKyxQok4=;
        b=4hN8Gn/QUTnyq/jV3MC1Uz1xy4lfuTiB7fcg+l7LTHVJkxQWLFmFZTAMoyNKJ20wJ/
         tyunPsgAvMBDIQq8SGV6rxnf+4520K1DUDX5q1EyncWPN2yfdqC3hZk8aI4spm2P8aPX
         r+KxRFc03VQHy8LVdPxhBJ7DfMZzA+p17p1X3678ej/GOaT8+cJ9sC3zO1aOLsGtXItd
         r7LGquiBO0mjtrJWxJs1sLzEVj7D9eITQrRKaj0CjkRS87eJ7PC/dLukoBlPhPo66OCW
         mW6mLMx/nD8HeA+YS9qk1eX+aa6n9IqEzx2ahGfXwLSyEaqANqIT76eSseDWLg3Mlb+H
         869A==
X-Gm-Message-State: ACrzQf31YcUsjtLWq+Y27aWsCqvYr0baAs/TWzbYS5etJNrCJ13hYSPt
        LxPKwv2tR+3GzAaEyYQ4aa1CYLUjnvk=
X-Google-Smtp-Source: AMsMyM46cM3CqU0j3bsVheA8cJIi15p/J7+GuzUZPhOWc/FjS7aV0snPeZlRrPtQRdtFhWLGHzshag==
X-Received: by 2002:aa7:d40e:0:b0:463:3844:f160 with SMTP id z14-20020aa7d40e000000b004633844f160mr15449494edq.296.1667334791239;
        Tue, 01 Nov 2022 13:33:11 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b007addcbd402esm2282795ejb.215.2022.11.01.13.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 13:33:10 -0700 (PDT)
Message-ID: <926c838f-4997-698b-4da9-44582e2af99a@gmail.com>
Date:   Tue, 1 Nov 2022 22:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v4 2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <80aba428-0aff-f4b2-dea5-35d1425982b6@gmail.com>
In-Reply-To: <80aba428-0aff-f4b2-dea5-35d1425982b6@gmail.com>
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
v4:
 - Rebased on top of wireless-next.
 
v3:
 - Feedback from Ping-Ke Shih:
   - Use the name REG_AGC_RPT for register 0xa80.
   - Use the name AGC_RPT_CCK for bit 7 of REG_AGC_RPT.
   
v2:
 - No change.
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 ++
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         | 32 ++++++++++++++++
 .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         |  1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 23 +++++++++++
 .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         | 23 +++++++++++
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         | 29 ++++++++++++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 38 ++++++++++++-------
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  3 ++
 8 files changed, 138 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index eee48817d4d7..6ff554ba0250 100644
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
@@ -1499,6 +1500,7 @@ struct rtl8xxxu_fileops {
 			     bool short_preamble, bool ampdu_enable,
 			     u32 rts_rate);
 	void (*set_crystal_cap) (struct rtl8xxxu_priv *priv, u8 crystal_cap);
+	s8 (*cck_rssi) (struct rtl8xxxu_priv *priv, u8 cck_agc_rpt);
 	int writeN_block_size;
 	int rx_agg_buf_size;
 	char tx_desc_size;
@@ -1609,6 +1611,7 @@ void rtl8723bu_set_ps_tdma(struct rtl8xxxu_priv *priv,
 			   u8 arg1, u8 arg2, u8 arg3, u8 arg4, u8 arg5);
 void rtl8723bu_phy_init_antenna_selection(struct rtl8xxxu_priv *priv);
 void rtl8723a_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap);
+s8 rtl8723a_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt);
 
 extern struct rtl8xxxu_fileops rtl8188fu_fops;
 extern struct rtl8xxxu_fileops rtl8192cu_fops;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 9f40d261ac71..5a5b7fa4283c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1658,6 +1658,37 @@ static void rtl8188f_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
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
@@ -1682,6 +1713,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
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
index bc0ec72d0126..973a02afc82b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1670,6 +1670,28 @@ static void rtl8192e_enable_rf(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write8(priv, REG_PAD_CTRL1, val8);
 }
 
+static s8 rtl8192e_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
+{
+	static const s8 lna_gain_table_0[8] = {15, 9, -10, -21, -23, -27, -43, -44};
+	static const s8 lna_gain_table_1[8] = {24, 18, 13, -4, -11, -18, -31, -36};
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
@@ -1691,6 +1713,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
+	.cck_rssi = rtl8192e_cck_rssi,
 	.writeN_block_size = 128,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index 552763a2215c..8d8eb16a0970 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -386,6 +386,28 @@ void rtl8723a_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
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
@@ -408,6 +430,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.report_connect = rtl8xxxu_gen1_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v1,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
+	.cck_rssi = rtl8723a_cck_rssi,
 	.writeN_block_size = 1024,
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 9bfcb1e12183..9214c1d3b644 100644
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
@@ -1663,6 +1691,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
+	.cck_rssi = rtl8723b_cck_rssi,
 	.writeN_block_size = 1024,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 3bd9e5370b23..51cb22ee55cd 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4318,6 +4318,29 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
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
+		val32 = rtl8xxxu_read32(priv, REG_AGC_RPT);
+		if (priv->cck_agc_report_type)
+			val32 |= AGC_RPT_CCK;
+		else
+			val32 &= ~AGC_RPT_CCK;
+		rtl8xxxu_write32(priv, REG_AGC_RPT, val32);
 	}
 
 	/* Initialise the center frequency offset tracking */
@@ -5307,20 +5330,7 @@ static void rtl8xxxu_rx_parse_phystats(struct rtl8xxxu_priv *priv,
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
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 190bc0e8dc33..04bf77959fba 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -960,6 +960,9 @@
 #define  CCK_PD_TYPE1_LV3_TH		0xdd
 #define  CCK_PD_TYPE1_LV4_TH		0xed
 
+#define REG_AGC_RPT			0xa80
+#define  AGC_RPT_CCK			BIT(7)
+
 #define REG_CONFIG_ANT_A		0x0b68
 #define REG_CONFIG_ANT_B		0x0b6c
 
-- 
2.38.0
