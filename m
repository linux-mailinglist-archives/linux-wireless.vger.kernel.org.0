Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5C561179C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 18:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ1Qgd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJ1QgL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 12:36:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19551CB504
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 09:36:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d26so14154342eje.10
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3i3lT8HzRiiC5M+khV2RgcwSrzTul72VH4EjzSqYBU4=;
        b=AqAtDkOtQY7XgwW0DszFKEWFQDieTO1H34U3DgM1PAm6AUclsl4pynLcQtNqOfW9iB
         vfihrSP8Q7HJf0TImMGl0aLmpXnpC53Wr9+kHVz1ueuGshl+2js074CTCNe9lSOZs/H0
         Q7fsVv23/CfzBvsyqs/qmCZlQh8lpV425dBfqzsbCPdEWs2uSCMTs8gtUd7L7O9LJIhM
         KWxTYFxrzpIFtS25VoQ+aNHZKnNBdCbbcmZ1zOs0o1yXsvNJ29x4LaaitpZbI99qTuzS
         njAZ63DL75OAHascmACwhrocDyR4vPlYJszUUcJwtjc+iJIiN+VdgAm2UsnkjNLSFaoP
         z0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3i3lT8HzRiiC5M+khV2RgcwSrzTul72VH4EjzSqYBU4=;
        b=6jLY8PA3AzlXGWSRzNCp57pNUXcgERdMOkvmjkk7eJPpr+M4oY0KudMPQE3RpihlCx
         z1nkpFt0mkcc5U2XzKuD5/+9WYsNH36/Pxcx5v3WGWdBvqR+IJ/hVXKUFIb+iVfP9mLN
         uiqvr+nlCuR4d0o3rl19Z/YvDGZQj5t1cSztUOkO5hucfXkRTP+9+Yqqq4QX1DbNP3SZ
         crnTu2j/DruONZFILsCUKONCutu187zifKHHMaIswUTI5+kl7UnmBoFkAbNlkbPx1deT
         VFOMzO0V+EiXYrrGV9ocj4AQKhFwwNLGbnx7izFeRNRD3AM6S6CW4P83XDBtsjCADBK9
         7kOg==
X-Gm-Message-State: ACrzQf1copm30GUNsX7ZfpEFhk2eyCh2AZQMwxwdE4+Nt3Zqte3s6Ju+
        rL4R9LFZ8mfgRGTQGlZ2lh3iVc8fSQw=
X-Google-Smtp-Source: AMsMyM4gTbx/4sf1wIUHXBQo4zQQqZgFB8toO4yJqyng7XY6yK4ScCoqEG8esR3TVdddnd7ZSZhpWQ==
X-Received: by 2002:a17:907:5cb:b0:791:96ec:f436 with SMTP id wg11-20020a17090705cb00b0079196ecf436mr221855ejb.100.1666974968279;
        Fri, 28 Oct 2022 09:36:08 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id ek14-20020a056402370e00b00458a03203b1sm2899553edb.31.2022.10.28.09.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:36:07 -0700 (PDT)
Message-ID: <69627c1a-7e85-ff97-ac4e-7097c3ed91b6@gmail.com>
Date:   Fri, 28 Oct 2022 19:36:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v3 2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
In-Reply-To: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
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
index 371dc4a68404..79210ba927ae 100644
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
@@ -1683,6 +1714,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
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
@@ -1711,6 +1733,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
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
index 86a3457fd951..861c33a6d7f9 100644
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
+		val32 = rtl8xxxu_read32(priv, REG_AGC_RPT);
+		if (priv->cck_agc_report_type)
+			val32 |= AGC_RPT_CCK;
+		else
+			val32 &= ~AGC_RPT_CCK;
+		rtl8xxxu_write32(priv, REG_AGC_RPT, val32);
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
