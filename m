Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3996360BD8A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 00:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJXWif (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 18:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiJXWiL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 18:38:11 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50BC248C86
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 14:01:28 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id a67so33440749edf.12
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iL5IxU4ag5e42KhfKvIV7D5t0Zjj2uNWATzzLvJ6Lc4=;
        b=YsU7x8P7+qCD6ZBNAiLukHDm3K9UUBb2o0B6xxy43DNEgBzY2ge+BOCF9q5Wh1yFxo
         0m3+dZT09IKVKdRvJnrr2DCl6xoJyb0OkttkEOVBk8Qh8zMbmdszRKNjVaw+9qx/lMMr
         HVN5JplHwxOwxXAzM0IZ5AqtpbdFq7ffynx5NxGJltJ6ahykhsputsIeOqkMHww1/7FP
         9JTFcKaVEfhEFXbwhGtDiPlgM+1rnIIvbLnj1I87cojHQQCy4nQnqGB1CF8J3SVpDZ0o
         UFQweDaYEJ8tnX/2S3sjwPFx8zK+cx1cRjrhYubUahqgs1sXYFPFVj+2eo8iLSjsHgto
         RcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iL5IxU4ag5e42KhfKvIV7D5t0Zjj2uNWATzzLvJ6Lc4=;
        b=gAuFvRa6Oel8zwQ0FR4o6xfdrF3LLVSw6cJwuAMsjITg1rSqlPDsqqXGjlUomzaoHD
         z/Rt8Sr+WziyNFSSpAEajTthLAUE6qrSo/y9reBo8VX7slYfWG7TuxPnzWZFusQUbQj/
         cS4PyY4jbqZ2YTn4AL2GBWWIj1C3PFPr5RSWEErCKRMYHxYP3g6cGhjK6nLM95k6533P
         AofY7afaEHW8rR3bHmY26i8k3A+hwwnugd9wOFSDI5OdxJC245rnDo+NFqJ7mlYXEcNe
         luRTq5SnXzXd5k96wcK2sJeMNw4y8AkjQkDUwIArQ5iVQgQ/BpKO8UZOD77tRfQZPslE
         jcJw==
X-Gm-Message-State: ACrzQf3rGtdUGXpgTsh7/fo4RSQ3J07hRBakRogiC6pApXD5SAqMVfSK
        2HrZWRe1e5ievZSIglamRs32LGoOhuU=
X-Google-Smtp-Source: AMsMyM5b9FZ9HNmbHshIWft2FpRQKnGqyC0Zy97dYvMs+bv87N9yQF0pt8VOMCdPbRg3Z1l87eYpwg==
X-Received: by 2002:a05:6402:3487:b0:45d:2674:d187 with SMTP id v7-20020a056402348700b0045d2674d187mr32333180edc.386.1666644896214;
        Mon, 24 Oct 2022 13:54:56 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090609ca00b007262a5e2204sm352900eje.153.2022.10.24.13.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:54:55 -0700 (PDT)
Message-ID: <25b7381d-178c-d909-015e-1acf7698ec13@gmail.com>
Date:   Mon, 24 Oct 2022 23:54:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
In-Reply-To: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 86a3457fd951..7023f6accda7 100644
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
