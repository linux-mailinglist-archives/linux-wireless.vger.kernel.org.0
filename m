Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C86661534E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 21:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKAUbj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 16:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKAUbi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 16:31:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DED81CB2B
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 13:31:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d26so39968023eje.10
        for <linux-wireless@vger.kernel.org>; Tue, 01 Nov 2022 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX+SeaK7YxeJ/MpwfO44f2md6iN2lR7P8obPbuef5Xs=;
        b=J3sLXvzpXmdlfT8pezcOvTN6IqmWeTyqwtxFuSeeW/SdLnN8oYwfm0S7sZh4r6pWIm
         jrrVzAGhAnfCV1SOPk3kSHwYwxrxkdxGGI6MUkkrZ3KJQG0w1BJvIvo3H6bFFT7d6Sfk
         NGXPzjXk5ydT4BFvn6xBLJlk4n54YwIsLK1RQQy//FMn3/sHN31HIDylUdK9TWO85X62
         gmSSGUBTjE8dNcVQ2sPhBkFuJT2WEVI8cvXnAXf5qLF7ImjhunZmig4hS426zeboDaHM
         xNQqmn2EbgnhOlH+rKVA1jzqyKKUBq7Nx4YcdoieEoYo/NgCYP+w7eaXtLBuQ9MwbJ9q
         xZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FX+SeaK7YxeJ/MpwfO44f2md6iN2lR7P8obPbuef5Xs=;
        b=tABmiZoTXoJbdcsoTBRghfj13+O1DLoHkwSaNFWR/EAqMtRNO6WBwVH87vk3zQwd2C
         EogDlvrqvosnpME+9GlNT56wY8xAUM5PMfzPg/Kdx6KfjWWvAAgJMLNzQ2jZRcxGmcuZ
         y/COizLU1xdO8M1Ui84+G2RGisgWzW5MtXwBTlu6kxfLIJUgoNP03YsWZHA/qPvA06G1
         2ZR/PhPGQNVanCinHZXba/u3GvNbbBexIXvRfSFHBPi+JujgQMHDCwdqJKsz9yHGwz35
         QjMwzlD2Y9ruc5fJqF/oYAFjOtmC/02QGlIw41bNU55HLEkEpx9RhQna+07n3HgKurBI
         YNTA==
X-Gm-Message-State: ACrzQf1nWyzVEGCri+wQGc38QcXjRhNEyn/uD8YIFmXaXCsfiIOkXwE9
        UgfSh8sWjgQ8mkkQe/x7W1AMKHeTwwI=
X-Google-Smtp-Source: AMsMyM7eIXXoIN2Z3q/A13ax3ni4jVt4zmjFXocbenIRAzqrolWBCYsxQa7rGRTBPy3B/I2BiFTlHA==
X-Received: by 2002:a17:907:88ca:b0:7ad:b635:2f1c with SMTP id rq10-20020a17090788ca00b007adb6352f1cmr18122552ejc.6.1667334694627;
        Tue, 01 Nov 2022 13:31:34 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0076ff600bf2csm4553162eja.63.2022.11.01.13.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 13:31:34 -0700 (PDT)
Message-ID: <80aba428-0aff-f4b2-dea5-35d1425982b6@gmail.com>
Date:   Tue, 1 Nov 2022 22:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v4 1/5] wifi: rtl8xxxu: Add central frequency offset tracking
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
v4:
 - Rebased on top of wireless-next.
 
v3:
 - No change.
 
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
index ad3f32f4c6e7..eee48817d4d7 100644
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
@@ -1485,6 +1498,7 @@ struct rtl8xxxu_fileops {
 			     struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
 			     bool short_preamble, bool ampdu_enable,
 			     u32 rts_rate);
+	void (*set_crystal_cap) (struct rtl8xxxu_priv *priv, u8 crystal_cap);
 	int writeN_block_size;
 	int rx_agg_buf_size;
 	char tx_desc_size;
@@ -1594,6 +1608,7 @@ void rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 void rtl8723bu_set_ps_tdma(struct rtl8xxxu_priv *priv,
 			   u8 arg1, u8 arg2, u8 arg3, u8 arg4, u8 arg5);
 void rtl8723bu_phy_init_antenna_selection(struct rtl8xxxu_priv *priv);
+void rtl8723a_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap);
 
 extern struct rtl8xxxu_fileops rtl8188fu_fops;
 extern struct rtl8xxxu_fileops rtl8192cu_fops;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 0025bb32538d..9f40d261ac71 100644
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
@@ -1659,6 +1681,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
+	.set_crystal_cap = rtl8188f_set_crystal_cap,
 	.writeN_block_size = 128,
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 550290ae9e17..bc0ec72d0126 100644
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
@@ -1691,6 +1690,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
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
index a27fe06d6f77..9bfcb1e12183 100644
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
@@ -1663,6 +1662,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
+	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.writeN_block_size = 1024,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 65bb4dc8f555..3bd9e5370b23 100644
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
@@ -4327,6 +4319,15 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
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
@@ -5294,7 +5295,8 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 static void rtl8xxxu_rx_parse_phystats(struct rtl8xxxu_priv *priv,
 				       struct ieee80211_rx_status *rx_status,
 				       struct rtl8723au_phy_stats *phy_stats,
-				       u32 rxmcs)
+				       u32 rxmcs, struct ieee80211_hdr *hdr,
+				       bool crc_icv_err)
 {
 	if (phy_stats->sgi_en)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
@@ -5320,6 +5322,21 @@ static void rtl8xxxu_rx_parse_phystats(struct rtl8xxxu_priv *priv,
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
@@ -5802,7 +5819,8 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 
 		if (rx_desc->phy_stats)
 			rtl8xxxu_rx_parse_phystats(priv, rx_status, phy_stats,
-						   rx_desc->rxmcs);
+						   rx_desc->rxmcs, (struct ieee80211_hdr *)skb->data,
+						   rx_desc->crc32 || rx_desc->icverr);
 
 		rx_status->mactime = rx_desc->tsfl;
 		rx_status->flag |= RX_FLAG_MACTIME_START;
@@ -5873,7 +5891,8 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 
 	if (rx_desc->phy_stats)
 		rtl8xxxu_rx_parse_phystats(priv, rx_status, phy_stats,
-					   rx_desc->rxmcs);
+					   rx_desc->rxmcs, (struct ieee80211_hdr *)skb->data,
+					   rx_desc->crc32 || rx_desc->icverr);
 
 	rx_status->mactime = rx_desc->tsfl;
 	rx_status->flag |= RX_FLAG_MACTIME_START;
@@ -6488,6 +6507,94 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
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
@@ -6512,6 +6619,10 @@ static void rtl8xxxu_watchdog_callback(struct work_struct *work)
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
