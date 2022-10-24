Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AF960BD6F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 00:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJXWc0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 18:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiJXWcC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 18:32:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7112BABD4
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 13:54:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t25so2308657ejb.8
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUK3crGyBeP++Td/LmRcAen/EXYsC1SXWX5gY/YVWKA=;
        b=l49jwq9GWgrxM5as8Ms1ucs+L8oAdCUpI8Jn/zZtjGlEFwjOM0u4/zrPh+mKzt0ayQ
         V5jnLO7eYUn6BSL4TCJ0h9IR0Fp8T3xHzKxqnFEmZfcmRjg3tQG2ulOU0S+KzGhC7YQY
         10l1uxQZ3FT+8tSNIMmuJYm1Af6QT0955jrfcnm5C/QXQEVeQX8pm1cjlgsAeWMsnudk
         fsRCG2CZ9BJjQVBuwcektEZso77p7KHpGCIvuLvlS8whyaObZEgrKr0Z49fxZXpngHMA
         t6Ygn9014xBIr3nRAxDHj4wj6xLhSPDCfxKZxKTFK7xBHHOmOImtpULxkv9899AL32J7
         P5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUK3crGyBeP++Td/LmRcAen/EXYsC1SXWX5gY/YVWKA=;
        b=2/an3wpaoHL/hG87GFYI0dcm37BGuQZ9YyyCE8UHk+sb3HYNaVMe1QUa6dmJJca/Ii
         SAWGmVs05D+pnYAo8hvEJm1/4GIGEtfIU0yxfzBA+XKZm2XBIbUf54kz0soWaEqb04uP
         TFM/on/CqLtJU7IXdUe7WEEPTKEsgKyvWaB5TfJ8QsRxihu5jxGxWPR/yzSr1hsnqt4u
         liENn4P5avtvQ79GBcqfmSFuD0VQ+obVgqe7NVcgFCcE2GdmqgG2flRu9HAlLsx9mB5x
         62kRLb833z5qwYHIt6Z5RLe1qhWJti5WGIQQA0SPd6lYl68MikjReXl1sAcI+/w7YMgX
         IyaQ==
X-Gm-Message-State: ACrzQf2Zd7379S2bQGbfCRj9ZzuQV1HuMFEGakN6c3Zcb3LUyk4T0AY8
        LHRhKDmo1ho0GjK68j1fGgTdYWplKVY=
X-Google-Smtp-Source: AMsMyM61BpRwijRdqs1VIHwfLj02NEf9xetjYPzbXSFm588WUb8yL4AohMS1XCLTPi5454tZ1UpEiw==
X-Received: by 2002:a17:907:8690:b0:791:9f83:6872 with SMTP id qa16-20020a170907869000b007919f836872mr27497578ejc.386.1666644805285;
        Mon, 24 Oct 2022 13:53:25 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078116c361d9sm392765ejc.10.2022.10.24.13.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:53:24 -0700 (PDT)
Message-ID: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
Date:   Mon, 24 Oct 2022 23:53:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 1/5] wifi: rtl8xxxu: Add central frequency offset tracking
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

According to Realtek programmers, "to adjust oscillator to align
central frequency of connected AP. Then, it can yield better
performance." From commit fb8517f4fade ("rtw88: 8822c: add CFO
tracking").

The RTL8192CU and a version of RTL8723AU apparently don't have the
ability to adjust the oscillator, so this doesn't apply to them.

This also doesn't apply to the wifi + bluetooth combo chips (RTL8723AU
and RTL8723BU) because the CFO tracking should only be done when
bluetooth is disabled, and determining that looked complicated.

That leaves only the RTL8192EU and RTL8188FU chips. I tested this with
the latter.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Suggestions from Ping-Ke Shih:
   - Use FIELD_PREP().
   - Let packet_count wrap around.
   - Use clamp().
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  21 ++-
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  39 ++++-
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         |   4 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         |  38 ++++-
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |   4 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 137 ++++++++++++++++--
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   1 +
 7 files changed, 212 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 1b9da71dc38d..14f0b3224553 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -570,7 +570,7 @@ struct rtl8723au_phy_stats {
 	u8	cck_rpt_b_ofdm_cfosho_b;
 	u8	reserved_1;
 	u8	noise_power_db_msb;
-	u8	path_cfotail[RTL8723A_MAX_RF_PATHS];
+	s8	path_cfotail[RTL8723A_MAX_RF_PATHS];
 	u8	pcts_mask[RTL8723A_MAX_RF_PATHS];
 	s8	stream_rxevm[RTL8723A_MAX_RF_PATHS];
 	u8	path_rxsnr[RTL8723A_MAX_RF_PATHS];
@@ -1323,6 +1323,19 @@ struct rtl8xxxu_ra_report {
 	u8 desc_rate;
 };
 
+#define CFO_TH_XTAL_HIGH	20 /* kHz */
+#define CFO_TH_XTAL_LOW	10 /* kHz */
+#define CFO_TH_ATC		80 /* kHz */
+
+struct rtl8xxxu_cfo_tracking {
+	bool adjust;
+	bool atc_status;
+	int cfo_tail[2];
+	u8 crystal_cap;
+	u32 packet_count;
+	u32 packet_count_pre;
+};
+
 struct rtl8xxxu_priv {
 	struct ieee80211_hw *hw;
 	struct usb_device *udev;
@@ -1381,9 +1394,8 @@ struct rtl8xxxu_priv {
 	u32 ep_tx_high_queue:1;
 	u32 ep_tx_normal_queue:1;
 	u32 ep_tx_low_queue:1;
-	u32 has_xtalk:1;
 	u32 rx_buf_aggregation:1;
-	u8 xtalk;
+	u8 default_crystal_cap;
 	unsigned int pipe_interrupt;
 	unsigned int pipe_in;
 	unsigned int pipe_out[TXDESC_QUEUE_MAX];
@@ -1441,6 +1453,7 @@ struct rtl8xxxu_priv {
 	struct sk_buff_head c2hcmd_queue;
 	struct rtl8xxxu_btcoex bt_coex;
 	struct rtl8xxxu_ra_report ra_report;
+	struct rtl8xxxu_cfo_tracking cfo_tracking;
 };
 
 struct rtl8xxxu_rx_urb {
@@ -1486,6 +1499,7 @@ struct rtl8xxxu_fileops {
 			     struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
 			     bool short_preamble, bool ampdu_enable,
 			     u32 rts_rate);
+	void (*set_crystal_cap) (struct rtl8xxxu_priv *priv, u8 crystal_cap);
 	int writeN_block_size;
 	int rx_agg_buf_size;
 	char tx_desc_size;
@@ -1596,6 +1610,7 @@ void rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 void rtl8723bu_set_ps_tdma(struct rtl8xxxu_priv *priv,
 			   u8 arg1, u8 arg2, u8 arg3, u8 arg4, u8 arg5);
 void rtl8723bu_phy_init_antenna_selection(struct rtl8xxxu_priv *priv);
+void rtl8723a_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap);
 
 extern struct rtl8xxxu_fileops rtl8188fu_fops;
 extern struct rtl8xxxu_fileops rtl8192cu_fops;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index bb88bab7c72a..371dc4a68404 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -703,7 +703,7 @@ static int rtl8188fu_parse_efuse(struct rtl8xxxu_priv *priv)
 	priv->ofdm_tx_power_diff[0].a = efuse->tx_power_index_A.ht20_ofdm_1s_diff.a;
 	priv->ht20_tx_power_diff[0].a = efuse->tx_power_index_A.ht20_ofdm_1s_diff.b;
 
-	priv->xtalk = efuse->xtal_k & 0x3f;
+	priv->default_crystal_cap = efuse->xtal_k & 0x3f;
 
 	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
 	dev_info(&priv->udev->dev, "Product: %.7s\n", efuse->device_name);
@@ -737,7 +737,6 @@ static void rtl8188fu_init_phy_bb(struct rtl8xxxu_priv *priv)
 {
 	u8 val8;
 	u16 val16;
-	u32 val32;
 
 	/* Enable BB and RF */
 	val16 = rtl8xxxu_read16(priv, REG_SYS_FUNC);
@@ -759,12 +758,6 @@ static void rtl8188fu_init_phy_bb(struct rtl8xxxu_priv *priv)
 
 	rtl8xxxu_init_phy_regs(priv, rtl8188fu_phy_init_table);
 	rtl8xxxu_init_phy_regs(priv, rtl8188f_agc_table);
-
-	val32 = rtl8xxxu_read32(priv, REG_AFE_XTAL_CTRL);
-	val8 = priv->xtalk;
-	val32 &= ~0x007FF800;
-	val32 |= ((val8 | (val8 << 6)) << 11);
-	rtl8xxxu_write32(priv, REG_AFE_XTAL_CTRL, val32);
 }
 
 static int rtl8188fu_init_phy_rf(struct rtl8xxxu_priv *priv)
@@ -1636,6 +1629,35 @@ static void rtl8188f_usb_quirks(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32(priv, REG_TXDMA_OFFSET_CHK, val32);
 }
 
+#define XTAL1	GENMASK(22, 17)
+#define XTAL0	GENMASK(16, 11)
+
+static void rtl8188f_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
+{
+	struct rtl8xxxu_cfo_tracking *cfo = &priv->cfo_tracking;
+	u32 val32;
+
+	if (crystal_cap == cfo->crystal_cap)
+		return;
+
+	val32 = rtl8xxxu_read32(priv, REG_AFE_XTAL_CTRL);
+
+	dev_dbg(&priv->udev->dev,
+	        "%s: Adjusting crystal cap from 0x%x (actually 0x%lx 0x%lx) to 0x%x\n",
+	        __func__,
+	        cfo->crystal_cap,
+	        FIELD_GET(XTAL1, val32),
+	        FIELD_GET(XTAL0, val32),
+	        crystal_cap);
+
+	val32 &= ~(XTAL1 | XTAL0);
+	val32 |= FIELD_PREP(XTAL1, crystal_cap) |
+		 FIELD_PREP(XTAL0, crystal_cap);
+	rtl8xxxu_write32(priv, REG_AFE_XTAL_CTRL, val32);
+
+	cfo->crystal_cap = crystal_cap;
+}
+
 struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.parse_efuse = rtl8188fu_parse_efuse,
 	.load_firmware = rtl8188fu_load_firmware,
@@ -1660,6 +1682,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
+	.set_crystal_cap = rtl8188f_set_crystal_cap,
 	.writeN_block_size = 128,
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 3a94fef4ca57..20924bafcb50 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -635,8 +635,7 @@ static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
 			efuse->tx_power_index_B.pwr_diff[i - 1].ht40;
 	}
 
-	priv->has_xtalk = 1;
-	priv->xtalk = priv->efuse_wifi.efuse8192eu.xtal_k & 0x3f;
+	priv->default_crystal_cap = priv->efuse_wifi.efuse8192eu.xtal_k & 0x3f;
 
 	/*
 	 * device_info section seems to be laid out as records
@@ -1711,6 +1710,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
+	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.writeN_block_size = 128,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index 44565bf4c1c2..552763a2215c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -166,10 +166,10 @@ static int rtl8723au_parse_efuse(struct rtl8xxxu_priv *priv)
 	       efuse->ht20_max_power_offset,
 	       sizeof(efuse->ht20_max_power_offset));
 
-	if (priv->efuse_wifi.efuse8723.version >= 0x01) {
-		priv->has_xtalk = 1;
-		priv->xtalk = priv->efuse_wifi.efuse8723.xtal_k & 0x3f;
-	}
+	if (priv->efuse_wifi.efuse8723.version >= 0x01)
+		priv->default_crystal_cap = priv->efuse_wifi.efuse8723.xtal_k & 0x3f;
+	else
+		priv->fops->set_crystal_cap = NULL;
 
 	priv->power_base = &rtl8723a_power_base;
 
@@ -357,6 +357,35 @@ static int rtl8723au_power_on(struct rtl8xxxu_priv *priv)
 	return ret;
 }
 
+#define XTAL1	GENMASK(23, 18)
+#define XTAL0	GENMASK(17, 12)
+
+void rtl8723a_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
+{
+	struct rtl8xxxu_cfo_tracking *cfo = &priv->cfo_tracking;
+	u32 val32;
+
+	if (crystal_cap == cfo->crystal_cap)
+		return;
+
+	val32 = rtl8xxxu_read32(priv, REG_MAC_PHY_CTRL);
+
+	dev_dbg(&priv->udev->dev,
+	        "%s: Adjusting crystal cap from 0x%x (actually 0x%lx 0x%lx) to 0x%x\n",
+	        __func__,
+	        cfo->crystal_cap,
+	        FIELD_GET(XTAL1, val32),
+	        FIELD_GET(XTAL0, val32),
+	        crystal_cap);
+
+	val32 &= ~(XTAL1 | XTAL0);
+	val32 |= FIELD_PREP(XTAL1, crystal_cap) |
+		 FIELD_PREP(XTAL0, crystal_cap);
+	rtl8xxxu_write32(priv, REG_MAC_PHY_CTRL, val32);
+
+	cfo->crystal_cap = crystal_cap;
+}
+
 struct rtl8xxxu_fileops rtl8723au_fops = {
 	.parse_efuse = rtl8723au_parse_efuse,
 	.load_firmware = rtl8723au_load_firmware,
@@ -378,6 +407,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.update_rate_mask = rtl8xxxu_update_rate_mask,
 	.report_connect = rtl8xxxu_gen1_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v1,
+	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.writeN_block_size = 1024,
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index de5da6e51da7..ead2ff5edad1 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -445,8 +445,7 @@ static int rtl8723bu_parse_efuse(struct rtl8xxxu_priv *priv)
 			efuse->tx_power_index_B.pwr_diff[i - 1].ht40;
 	}
 
-	priv->has_xtalk = 1;
-	priv->xtalk = priv->efuse_wifi.efuse8723bu.xtal_k & 0x3f;
+	priv->default_crystal_cap = priv->efuse_wifi.efuse8723bu.xtal_k & 0x3f;
 
 	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
 	dev_info(&priv->udev->dev, "Product: %.41s\n", efuse->device_name);
@@ -1664,6 +1663,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
+	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.writeN_block_size = 1024,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 33a8ee545113..86a3457fd951 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -2286,7 +2286,6 @@ void rtl8xxxu_gen1_init_phy_bb(struct rtl8xxxu_priv *priv)
  */
 static int rtl8xxxu_init_phy_bb(struct rtl8xxxu_priv *priv)
 {
-	u8 val8;
 	u32 val32;
 
 	priv->fops->init_phy_bb(priv);
@@ -2351,15 +2350,8 @@ static int rtl8xxxu_init_phy_bb(struct rtl8xxxu_priv *priv)
 		rtl8xxxu_write32(priv, REG_TX_TO_TX, val32);
 	}
 
-	if (priv->has_xtalk) {
-		val32 = rtl8xxxu_read32(priv, REG_MAC_PHY_CTRL);
-
-		val8 = priv->xtalk;
-		val32 &= 0xff000fff;
-		val32 |= ((val8 | (val8 << 6)) << 12);
-
-		rtl8xxxu_write32(priv, REG_MAC_PHY_CTRL, val32);
-	}
+	if (priv->fops->set_crystal_cap)
+		priv->fops->set_crystal_cap(priv, priv->default_crystal_cap);
 
 	if (priv->rtl_chip == RTL8192E)
 		rtl8xxxu_write32(priv, REG_AFE_XTAL_CTRL, 0x000f81fb);
@@ -4334,6 +4326,15 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		val32 |= 0x0007e000;
 		rtl8xxxu_write32(priv, REG_AFE_MISC, val32);
 	}
+
+	/* Initialise the center frequency offset tracking */
+	if (priv->fops->set_crystal_cap) {
+		val32 = rtl8xxxu_read32(priv, REG_OFDM1_CFO_TRACKING);
+		priv->cfo_tracking.atc_status = val32 & CFO_TRACKING_ATC_STATUS;
+		priv->cfo_tracking.adjust = true;
+		priv->cfo_tracking.crystal_cap = priv->default_crystal_cap;
+	}
+
 exit:
 	return ret;
 }
@@ -5301,7 +5302,8 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 static void rtl8xxxu_rx_parse_phystats(struct rtl8xxxu_priv *priv,
 				       struct ieee80211_rx_status *rx_status,
 				       struct rtl8723au_phy_stats *phy_stats,
-				       u32 rxmcs)
+				       u32 rxmcs, struct ieee80211_hdr *hdr,
+				       bool crc_icv_err)
 {
 	if (phy_stats->sgi_en)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
@@ -5327,6 +5329,21 @@ static void rtl8xxxu_rx_parse_phystats(struct rtl8xxxu_priv *priv,
 			break;
 		}
 	} else {
+		bool parse_cfo = priv->fops->set_crystal_cap &&
+				 priv->vif &&
+				 priv->vif->type == NL80211_IFTYPE_STATION &&
+				 priv->vif->cfg.assoc &&
+				 !crc_icv_err &&
+				 !ieee80211_is_ctl(hdr->frame_control) &&
+				 ether_addr_equal(priv->vif->bss_conf.bssid, hdr->addr2);
+
+		if (parse_cfo) {
+			priv->cfo_tracking.cfo_tail[0] = phy_stats->path_cfotail[0];
+			priv->cfo_tracking.cfo_tail[1] = phy_stats->path_cfotail[1];
+
+			priv->cfo_tracking.packet_count++;
+		}
+
 		rx_status->signal =
 			(phy_stats->cck_sig_qual_ofdm_pwdb_all >> 1) - 110;
 	}
@@ -5809,7 +5826,8 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 
 		if (rx_desc->phy_stats)
 			rtl8xxxu_rx_parse_phystats(priv, rx_status, phy_stats,
-						   rx_desc->rxmcs);
+						   rx_desc->rxmcs, (struct ieee80211_hdr *)skb->data,
+						   rx_desc->crc32 || rx_desc->icverr);
 
 		rx_status->mactime = rx_desc->tsfl;
 		rx_status->flag |= RX_FLAG_MACTIME_START;
@@ -5880,7 +5898,8 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 
 	if (rx_desc->phy_stats)
 		rtl8xxxu_rx_parse_phystats(priv, rx_status, phy_stats,
-					   rx_desc->rxmcs);
+					   rx_desc->rxmcs, (struct ieee80211_hdr *)skb->data,
+					   rx_desc->crc32 || rx_desc->icverr);
 
 	rx_status->mactime = rx_desc->tsfl;
 	rx_status->flag |= RX_FLAG_MACTIME_START;
@@ -6495,6 +6514,94 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 	}
 }
 
+static void rtl8xxxu_set_atc_status(struct rtl8xxxu_priv *priv, bool atc_status)
+{
+	struct rtl8xxxu_cfo_tracking *cfo = &priv->cfo_tracking;
+	u32 val32;
+
+	if (atc_status == cfo->atc_status)
+		return;
+
+	cfo->atc_status = atc_status;
+
+	val32 = rtl8xxxu_read32(priv, REG_OFDM1_CFO_TRACKING);
+	if (atc_status)
+		val32 |= CFO_TRACKING_ATC_STATUS;
+	else
+		val32 &= ~CFO_TRACKING_ATC_STATUS;
+	rtl8xxxu_write32(priv, REG_OFDM1_CFO_TRACKING, val32);
+}
+
+/* Central frequency offset correction */
+static void rtl8xxxu_track_cfo(struct rtl8xxxu_priv *priv)
+{
+	struct rtl8xxxu_cfo_tracking *cfo = &priv->cfo_tracking;
+	int cfo_khz_a, cfo_khz_b, cfo_average;
+	int crystal_cap;
+
+	if (!priv->vif || !priv->vif->cfg.assoc) {
+		/* Reset */
+		cfo->adjust = true;
+
+		if (cfo->crystal_cap > priv->default_crystal_cap)
+			priv->fops->set_crystal_cap(priv, cfo->crystal_cap - 1);
+		else if (cfo->crystal_cap < priv->default_crystal_cap)
+			priv->fops->set_crystal_cap(priv, cfo->crystal_cap + 1);
+
+		rtl8xxxu_set_atc_status(priv, true);
+
+		return;
+	}
+
+	if (cfo->packet_count == cfo->packet_count_pre)
+		/* No new information. */
+		return;
+
+	cfo->packet_count_pre = cfo->packet_count;
+
+	/* CFO_tail[1:0] is S(8,7), (num_subcarrier>>7) x 312.5K = CFO value(K Hz) */
+	cfo_khz_a = (int)((cfo->cfo_tail[0] * 3125) / 10) >> 7;
+	cfo_khz_b = (int)((cfo->cfo_tail[1] * 3125) / 10) >> 7;
+
+	if (priv->tx_paths == 1)
+		cfo_average = cfo_khz_a;
+	else
+		cfo_average = (cfo_khz_a + cfo_khz_b) / 2;
+
+	dev_dbg(&priv->udev->dev, "cfo_average: %d\n", cfo_average);
+
+	if (cfo->adjust) {
+		if (abs(cfo_average) < CFO_TH_XTAL_LOW)
+			cfo->adjust = false;
+	} else {
+		if (abs(cfo_average) > CFO_TH_XTAL_HIGH)
+			cfo->adjust = true;
+	}
+
+	/*
+	 * TODO: We should return here only if bluetooth is enabled.
+	 * See the vendor drivers for how to determine that.
+	 */
+	if (priv->has_bluetooth)
+		return;
+
+	if (!cfo->adjust)
+		return;
+
+	crystal_cap = cfo->crystal_cap;
+
+	if (cfo_average > CFO_TH_XTAL_LOW)
+		crystal_cap++;
+	else if (cfo_average < -CFO_TH_XTAL_LOW)
+		crystal_cap--;
+
+	crystal_cap = clamp(crystal_cap, 0, 0x3f);
+
+	priv->fops->set_crystal_cap(priv, crystal_cap);
+
+	rtl8xxxu_set_atc_status(priv, abs(cfo_average) >= CFO_TH_ATC);
+}
+
 static void rtl8xxxu_watchdog_callback(struct work_struct *work)
 {
 	struct ieee80211_vif *vif;
@@ -6519,6 +6626,10 @@ static void rtl8xxxu_watchdog_callback(struct work_struct *work)
 		rcu_read_unlock();
 
 		signal = ieee80211_ave_rssi(vif);
+
+		if (priv->fops->set_crystal_cap)
+			rtl8xxxu_track_cfo(priv);
+
 		rtl8xxxu_refresh_rate_mask(priv, signal, sta);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 35bde1404793..190bc0e8dc33 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -1027,6 +1027,7 @@
 
 #define REG_OFDM1_TRX_PATH_ENABLE	0x0d04
 #define REG_OFDM1_CFO_TRACKING		0x0d2c
+#define  CFO_TRACKING_ATC_STATUS	BIT(11)
 #define REG_OFDM1_CSI_FIX_MASK1		0x0d40
 #define REG_OFDM1_CSI_FIX_MASK2		0x0d44
 
-- 
2.38.0
