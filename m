Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC94164F940
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiLQOWG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLQOWE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:22:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E1D10078
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:22:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n20so12428887ejh.0
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rgS070PtBkxV9Bjowr87MJEjOVWpQt2qD7ONrkn+sA=;
        b=hBCDyIgHeHWWMQMBwzScgtN1E00rnUU0VeFezGW8I6CCmLz/UC+zYGkuSTEUd8WCdt
         aZyhXUR4NZEHzi5R5fXhD+OefaRbzPiIWuANKAhiGPyVbQ0ripg+3SWu5jRp/WV6e6Kl
         G7UpsPG/zW3OzWKJ0nQtqJ8tUlapuKOubCXI1zdECHOxfKa9Dt7Mwsu0HZqljGiAwn/2
         j9V6Q+ux2ODq8KxCny+nxKhosYM8KJMkQcmOOZbdHoHSEzmYfCsfCVZjp68fSt1pbWvn
         Uln2KnaQYmguAFxbxhkA/kE24LWD6OSwhO8laPE9XSjqNHaJyNi2j/BX1kaN4B1Uml6t
         DR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rgS070PtBkxV9Bjowr87MJEjOVWpQt2qD7ONrkn+sA=;
        b=ve5L/gztdrOUNBtSrnwnIEZCMfrnFxYXHYN6543FcogNLErEwQvPpumBDQD8SOXi29
         tTt0XCe7Q3h16iB3J5yT/gbiwu5k9jcLSnEZEgnkyiHyVcDZLwYRyjO3Ad1xuAVc7zOf
         V/Mo3RWtAHwfzlMQhuFfgMLGU58KuGH6mNC9kdDtKsL4zFxDAW/OgIi9krvAJgPaKmy8
         3itG6wN+l9Kdd4jsFjhMD1fq7rZ/bnSSn5QFVp47rFPi2fxRW7E3yxvpUW5UQpGycv21
         EUK6yejSDioymC2P9Xeq6b5r4AmJwxpzcintnyneExxNw6PK7T7MWJsxK6GddtcwvhCv
         LdJA==
X-Gm-Message-State: ANoB5pnbtV2zWjQYGlC5l6/UHr1xp/gl2RqEHSg3bKwrj6YJwckMNMYk
        lOn6/Oarh218y6SGT1ktMZS3srXfdkg=
X-Google-Smtp-Source: AA0mqf7GrijCDf3dxtLu49Lk7PftnX9gqDxllB8kXrEHibgcR3Nhe8FqeoCeAPoGfwynhrUNo8tSgA==
X-Received: by 2002:a17:906:5ad2:b0:7c1:98e:ed20 with SMTP id x18-20020a1709065ad200b007c1098eed20mr29714580ejs.35.1671286920862;
        Sat, 17 Dec 2022 06:22:00 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id bq18-20020a170906d0d200b00782fbb7f5f7sm2020155ejb.113.2022.12.17.06.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 06:22:00 -0800 (PST)
Message-ID: <5acc1e5d-62d6-3a6a-0f9e-cbc8b809b1d7@gmail.com>
Date:   Sat, 17 Dec 2022 16:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v3 5/5] wifi: rtl8xxxu: Add rate control code for RTL8188EU
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
References: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
In-Reply-To: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
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

Copied from the newer vendor driver, v5.2.2.4.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Implement suggestions from Ping-Ke Shih:
   - Remove unnecessary assignment in rtl8188e_power_training_try_state().
   - Use >>= in rtl8188e_power_training_decision().
   - Remove empty line in rtl8188e_handle_ra_tx_report2().
   - Move closing parenthesis in rtl8xxxu_parse_rxdesc16().
 - Remove unused arrays retry_penalty_up and trying_necessary.
   Reported-by: kernel test robot <lkp@intel.com>

v2:
 - Implement suggestions from Ping-Ke Shih:
   - Add missing break in two switch statements.
   - Remove unnecessary initialisation of idx in rtl8188e_set_tx_rpt_timing().
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  39 ++
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         | 590 +++++++++++++++++-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 130 +++-
 3 files changed, 729 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 29f5dbee16b0..be9479f969b7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -531,6 +531,7 @@ struct rtl8xxxu_txdesc40 {
 #define TXDESC32_CTS_SELF_ENABLE	BIT(11)
 #define TXDESC32_RTS_CTS_ENABLE		BIT(12)
 #define TXDESC32_HW_RTS_ENABLE		BIT(13)
+#define TXDESC32_PT_STAGE_MASK		GENMASK(17, 15)
 #define TXDESC_PRIME_CH_OFF_LOWER	BIT(20)
 #define TXDESC_PRIME_CH_OFF_UPPER	BIT(21)
 #define TXDESC32_SHORT_PREAMBLE		BIT(24)
@@ -1376,6 +1377,39 @@ struct rtl8xxxu_ra_report {
 	u8 desc_rate;
 };
 
+struct rtl8xxxu_ra_info {
+	u8 rate_id;
+	u32 rate_mask;
+	u32 ra_use_rate;
+	u8 rate_sgi;
+	u8 rssi_sta_ra;		/* Percentage */
+	u8 pre_rssi_sta_ra;
+	u8 sgi_enable;
+	u8 decision_rate;
+	u8 pre_rate;
+	u8 highest_rate;
+	u8 lowest_rate;
+	u32 nsc_up;
+	u32 nsc_down;
+	u32 total;
+	u16 retry[5];
+	u16 drop;
+	u16 rpt_time;
+	u16 pre_min_rpt_time;
+	u8 dynamic_tx_rpt_timing_counter;
+	u8 ra_waiting_counter;
+	u8 ra_pending_counter;
+	u8 ra_drop_after_down;
+	u8 pt_try_state;	/* 0 trying state, 1 for decision state */
+	u8 pt_stage;		/* 0~6 */
+	u8 pt_stop_count;	/* Stop PT counter */
+	u8 pt_pre_rate;		/* if rate change do PT */
+	u8 pt_pre_rssi;		/* if RSSI change 5% do PT */
+	u8 pt_mode_ss;		/* decide which rate should do PT */
+	u8 ra_stage;		/* StageRA, decide how many times RA will be done between PT */
+	u8 pt_smooth_factor;
+};
+
 #define CFO_TH_XTAL_HIGH	20 /* kHz */
 #define CFO_TH_XTAL_LOW	10 /* kHz */
 #define CFO_TH_ATC		80 /* kHz */
@@ -1509,6 +1543,7 @@ struct rtl8xxxu_priv {
 	struct rtl8xxxu_btcoex bt_coex;
 	struct rtl8xxxu_ra_report ra_report;
 	struct rtl8xxxu_cfo_tracking cfo_tracking;
+	struct rtl8xxxu_ra_info ra_info;
 };
 
 struct rtl8xxxu_rx_urb {
@@ -1684,6 +1719,10 @@ void rtl8723bu_phy_init_antenna_selection(struct rtl8xxxu_priv *priv);
 void rtl8723a_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap);
 void rtl8188f_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap);
 s8 rtl8723a_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt);
+void rtl8xxxu_update_ra_report(struct rtl8xxxu_ra_report *rarpt,
+			       u8 rate, u8 sgi, u8 bw);
+void rtl8188e_ra_info_init_all(struct rtl8xxxu_ra_info *ra);
+void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_priv *priv, struct sk_buff *skb);
 
 extern struct rtl8xxxu_fileops rtl8188fu_fops;
 extern struct rtl8xxxu_fileops rtl8188eu_fops;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index ae9a2bec1643..3ac1be2552ec 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -280,6 +280,123 @@ static const struct rtl8xxxu_rfregval rtl8188eu_radioa_init_table[] = {
 	{0xff, 0xffffffff}
 };
 
+#define PERENTRY		23
+#define RETRYSIZE		5
+#define RATESIZE		28
+#define TX_RPT2_ITEM_SIZE	8
+
+static const u8 retry_penalty[PERENTRY][RETRYSIZE + 1] = {
+	{5, 4, 3, 2, 0, 3}, /* 92 , idx=0 */
+	{6, 5, 4, 3, 0, 4}, /* 86 , idx=1 */
+	{6, 5, 4, 2, 0, 4}, /* 81 , idx=2 */
+	{8, 7, 6, 4, 0, 6}, /* 75 , idx=3 */
+	{10, 9, 8, 6, 0, 8}, /* 71 , idx=4 */
+	{10, 9, 8, 4, 0, 8}, /* 66 , idx=5 */
+	{10, 9, 8, 2, 0, 8}, /* 62 , idx=6 */
+	{10, 9, 8, 0, 0, 8}, /* 59 , idx=7 */
+	{18, 17, 16, 8, 0, 16}, /* 53 , idx=8 */
+	{26, 25, 24, 16, 0, 24}, /* 50 , idx=9 */
+	{34, 33, 32, 24, 0, 32}, /* 47 , idx=0x0a */
+	{34, 31, 28, 20, 0, 32}, /* 43 , idx=0x0b */
+	{34, 31, 27, 18, 0, 32}, /* 40 , idx=0x0c */
+	{34, 31, 26, 16, 0, 32}, /* 37 , idx=0x0d */
+	{34, 30, 22, 16, 0, 32}, /* 32 , idx=0x0e */
+	{34, 30, 24, 16, 0, 32}, /* 26 , idx=0x0f */
+	{49, 46, 40, 16, 0, 48}, /* 20 , idx=0x10 */
+	{49, 45, 32, 0, 0, 48}, /* 17 , idx=0x11 */
+	{49, 45, 22, 18, 0, 48}, /* 15 , idx=0x12 */
+	{49, 40, 24, 16, 0, 48}, /* 12 , idx=0x13 */
+	{49, 32, 18, 12, 0, 48}, /* 9 , idx=0x14 */
+	{49, 22, 18, 14, 0, 48}, /* 6 , idx=0x15 */
+	{49, 16, 16, 0, 0, 48} /* 3, idx=0x16 */
+};
+
+static const u8 pt_penalty[RETRYSIZE + 1] = {34, 31, 30, 24, 0, 32};
+
+static const u8 retry_penalty_idx_normal[2][RATESIZE] = {
+	{ /* RSSI>TH */
+		4, 4, 4, 5,
+		4, 4, 5, 7, 7, 7, 8, 0x0a,
+		4, 4, 4, 4, 6, 0x0a, 0x0b, 0x0d,
+		5, 5, 7, 7, 8, 0x0b, 0x0d, 0x0f
+	},
+	{ /* RSSI<TH */
+		0x0a, 0x0a, 0x0b, 0x0c,
+		0x0a, 0x0a, 0x0b, 0x0c, 0x0d, 0x10, 0x13, 0x13,
+		0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x11, 0x13, 0x13,
+		9, 9, 9, 9, 0x0c, 0x0e, 0x11, 0x13
+	}
+};
+
+static const u8 retry_penalty_idx_cut_i[2][RATESIZE] = {
+	{ /* RSSI>TH */
+		4, 4, 4, 5,
+		4, 4, 5, 7, 7, 7, 8, 0x0a,
+		4, 4, 4, 4, 6, 0x0a, 0x0b, 0x0d,
+		5, 5, 7, 7, 8, 0x0b, 0x0d, 0x0f
+	},
+	{ /* RSSI<TH */
+		0x0a, 0x0a, 0x0b, 0x0c,
+		0x0a, 0x0a, 0x0b, 0x0c, 0x0d, 0x10, 0x13, 0x13,
+		0x06, 0x07, 0x08, 0x0d, 0x0e, 0x11, 0x11, 0x11,
+		9, 9, 9, 9, 0x0c, 0x0e, 0x11, 0x13
+	}
+};
+
+static const u8 retry_penalty_up_idx_normal[RATESIZE] = {
+	0x0c, 0x0d, 0x0d, 0x0f,
+	0x0d, 0x0e, 0x0f, 0x0f, 0x10, 0x12, 0x13, 0x14,
+	0x0f, 0x10, 0x10, 0x12, 0x12, 0x13, 0x14, 0x15,
+	0x11, 0x11, 0x12, 0x13, 0x13, 0x13, 0x14, 0x15
+};
+
+static const u8 retry_penalty_up_idx_cut_i[RATESIZE] = {
+	0x0c, 0x0d, 0x0d, 0x0f,
+	0x0d, 0x0e, 0x0f, 0x0f, 0x10, 0x12, 0x13, 0x14,
+	0x0b, 0x0b, 0x11, 0x11, 0x12, 0x12, 0x12, 0x12,
+	0x11, 0x11, 0x12, 0x13, 0x13, 0x13, 0x14, 0x15
+};
+
+static const u8 rssi_threshold[RATESIZE] = {
+	0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0x24, 0x26, 0x2a,
+	0x18, 0x1a, 0x1d, 0x1f, 0x21, 0x27, 0x29, 0x2a,
+	0, 0, 0, 0x1f, 0x23, 0x28, 0x2a, 0x2c
+};
+
+static const u16 n_threshold_high[RATESIZE] = {
+	4, 4, 8, 16,
+	24, 36, 48, 72, 96, 144, 192, 216,
+	60, 80, 100, 160, 240, 400, 600, 800,
+	300, 320, 480, 720, 1000, 1200, 1600, 2000
+};
+
+static const u16 n_threshold_low[RATESIZE] = {
+	2, 2, 4, 8,
+	12, 18, 24, 36, 48, 72, 96, 108,
+	30, 40, 50, 80, 120, 200, 300, 400,
+	150, 160, 240, 360, 500, 600, 800, 1000
+};
+
+static const u8 dropping_necessary[RATESIZE] = {
+	1, 1, 1, 1,
+	1, 2, 3, 4, 5, 6, 7, 8,
+	1, 2, 3, 4, 5, 6, 7, 8,
+	5, 6, 7, 8, 9, 10, 11, 12
+};
+
+static const u8 pending_for_rate_up_fail[5] = {2, 10, 24, 40, 60};
+
+static const u16 dynamic_tx_rpt_timing[6] = {
+	0x186a, 0x30d4, 0x493e, 0x61a8, 0x7a12, 0x927c /* 200ms-1200ms */
+};
+
+enum rtl8188e_tx_rpt_timing {
+	DEFAULT_TIMING = 0,
+	INCREASE_TIMING,
+	DECREASE_TIMING
+};
+
 static int rtl8188eu_identify_chip(struct rtl8xxxu_priv *priv)
 {
 	struct device *dev = &priv->udev->dev;
@@ -1233,6 +1350,477 @@ static s8 rtl8188e_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 	return rx_pwr_all;
 }
 
+static void rtl8188e_set_tx_rpt_timing(struct rtl8xxxu_ra_info *ra, u8 timing)
+{
+	u8 idx;
+
+	for (idx = 0; idx < 5; idx++)
+		if (dynamic_tx_rpt_timing[idx] == ra->rpt_time)
+			break;
+
+	if (timing == DEFAULT_TIMING) {
+		idx = 0; /* 200ms */
+	} else if (timing == INCREASE_TIMING) {
+		if (idx < 5)
+			idx++;
+	} else if (timing == DECREASE_TIMING) {
+		if (idx > 0)
+			idx--;
+	}
+
+	ra->rpt_time = dynamic_tx_rpt_timing[idx];
+}
+
+static void rtl8188e_rate_down(struct rtl8xxxu_ra_info *ra)
+{
+	u8 rate_id = ra->pre_rate;
+	u8 lowest_rate = ra->lowest_rate;
+	u8 highest_rate = ra->highest_rate;
+	s8 i;
+
+	if (rate_id > highest_rate) {
+		rate_id = highest_rate;
+	} else if (ra->rate_sgi) {
+		ra->rate_sgi = 0;
+	} else if (rate_id > lowest_rate) {
+		if (rate_id > 0) {
+			for (i = rate_id - 1; i >= lowest_rate; i--) {
+				if (ra->ra_use_rate & BIT(i)) {
+					rate_id = i;
+					goto rate_down_finish;
+				}
+			}
+		}
+	} else if (rate_id <= lowest_rate) {
+		rate_id = lowest_rate;
+	}
+
+rate_down_finish:
+	if (ra->ra_waiting_counter == 1) {
+		ra->ra_waiting_counter++;
+		ra->ra_pending_counter++;
+	} else if (ra->ra_waiting_counter > 1) {
+		ra->ra_waiting_counter = 0;
+		ra->ra_pending_counter = 0;
+	}
+
+	if (ra->ra_pending_counter >= 4)
+		ra->ra_pending_counter = 4;
+
+	ra->ra_drop_after_down = 1;
+
+	ra->decision_rate = rate_id;
+
+	rtl8188e_set_tx_rpt_timing(ra, DECREASE_TIMING);
+}
+
+static void rtl8188e_rate_up(struct rtl8xxxu_ra_info *ra)
+{
+	u8 rate_id = ra->pre_rate;
+	u8 highest_rate = ra->highest_rate;
+	u8 i;
+
+	if (ra->ra_waiting_counter == 1) {
+		ra->ra_waiting_counter = 0;
+		ra->ra_pending_counter = 0;
+	} else if (ra->ra_waiting_counter > 1) {
+		ra->pre_rssi_sta_ra = ra->rssi_sta_ra;
+		goto rate_up_finish;
+	}
+
+	rtl8188e_set_tx_rpt_timing(ra, DEFAULT_TIMING);
+
+	if (rate_id < highest_rate) {
+		for (i = rate_id + 1; i <= highest_rate; i++) {
+			if (ra->ra_use_rate & BIT(i)) {
+				rate_id = i;
+				goto rate_up_finish;
+			}
+		}
+	} else if (rate_id == highest_rate) {
+		if (ra->sgi_enable && !ra->rate_sgi)
+			ra->rate_sgi = 1;
+		else if (!ra->sgi_enable)
+			ra->rate_sgi = 0;
+	} else { /* rate_id > ra->highest_rate */
+		rate_id = highest_rate;
+	}
+
+rate_up_finish:
+	if (ra->ra_waiting_counter == (4 + pending_for_rate_up_fail[ra->ra_pending_counter]))
+		ra->ra_waiting_counter = 0;
+	else
+		ra->ra_waiting_counter++;
+
+	ra->decision_rate = rate_id;
+}
+
+static void rtl8188e_reset_ra_counter(struct rtl8xxxu_ra_info *ra)
+{
+	u8 rate_id = ra->decision_rate;
+
+	ra->nsc_up = (n_threshold_high[rate_id] + n_threshold_low[rate_id]) >> 1;
+	ra->nsc_down = (n_threshold_high[rate_id] + n_threshold_low[rate_id]) >> 1;
+}
+
+static void rtl8188e_rate_decision(struct rtl8xxxu_ra_info *ra)
+{
+	struct rtl8xxxu_priv *priv = container_of(ra, struct rtl8xxxu_priv, ra_info);
+	const u8 *retry_penalty_idx_0;
+	const u8 *retry_penalty_idx_1;
+	const u8 *retry_penalty_up_idx;
+	u8 rate_id, penalty_id1, penalty_id2;
+	int i;
+
+	if (ra->total == 0)
+		return;
+
+	if (ra->ra_drop_after_down) {
+		ra->ra_drop_after_down--;
+
+		rtl8188e_reset_ra_counter(ra);
+
+		return;
+	}
+
+	if (priv->chip_cut == 8) { /* cut I */
+		retry_penalty_idx_0 = retry_penalty_idx_cut_i[0];
+		retry_penalty_idx_1 = retry_penalty_idx_cut_i[1];
+		retry_penalty_up_idx = retry_penalty_up_idx_cut_i;
+	} else {
+		retry_penalty_idx_0 = retry_penalty_idx_normal[0];
+		retry_penalty_idx_1 = retry_penalty_idx_normal[1];
+		retry_penalty_up_idx = retry_penalty_up_idx_normal;
+	}
+
+	if (ra->rssi_sta_ra < (ra->pre_rssi_sta_ra - 3) ||
+	    ra->rssi_sta_ra > (ra->pre_rssi_sta_ra + 3)) {
+		ra->pre_rssi_sta_ra = ra->rssi_sta_ra;
+		ra->ra_waiting_counter = 0;
+		ra->ra_pending_counter = 0;
+	}
+
+	/* Start RA decision */
+	if (ra->pre_rate > ra->highest_rate)
+		rate_id = ra->highest_rate;
+	else
+		rate_id = ra->pre_rate;
+
+	/* rate down */
+	if (ra->rssi_sta_ra > rssi_threshold[rate_id])
+		penalty_id1 = retry_penalty_idx_0[rate_id];
+	else
+		penalty_id1 = retry_penalty_idx_1[rate_id];
+
+	for (i = 0; i < 5; i++)
+		ra->nsc_down += ra->retry[i] * retry_penalty[penalty_id1][i];
+
+	if (ra->nsc_down > (ra->total * retry_penalty[penalty_id1][5]))
+		ra->nsc_down -= ra->total * retry_penalty[penalty_id1][5];
+	else
+		ra->nsc_down = 0;
+
+	/* rate up */
+	penalty_id2 = retry_penalty_up_idx[rate_id];
+
+	for (i = 0; i < 5; i++)
+		ra->nsc_up += ra->retry[i] * retry_penalty[penalty_id2][i];
+
+	if (ra->nsc_up > (ra->total * retry_penalty[penalty_id2][5]))
+		ra->nsc_up -= ra->total * retry_penalty[penalty_id2][5];
+	else
+		ra->nsc_up = 0;
+
+	if (ra->nsc_down < n_threshold_low[rate_id] ||
+	    ra->drop > dropping_necessary[rate_id]) {
+		rtl8188e_rate_down(ra);
+
+		rtl8xxxu_update_ra_report(&priv->ra_report, ra->decision_rate,
+					  ra->rate_sgi, priv->ra_report.txrate.bw);
+	} else if (ra->nsc_up > n_threshold_high[rate_id]) {
+		rtl8188e_rate_up(ra);
+
+		rtl8xxxu_update_ra_report(&priv->ra_report, ra->decision_rate,
+					  ra->rate_sgi, priv->ra_report.txrate.bw);
+	}
+
+	if (ra->decision_rate == ra->pre_rate)
+		ra->dynamic_tx_rpt_timing_counter++;
+	else
+		ra->dynamic_tx_rpt_timing_counter = 0;
+
+	if (ra->dynamic_tx_rpt_timing_counter >= 4) {
+		/* Rate didn't change 4 times, extend RPT timing */
+		rtl8188e_set_tx_rpt_timing(ra, INCREASE_TIMING);
+		ra->dynamic_tx_rpt_timing_counter = 0;
+	}
+
+	ra->pre_rate = ra->decision_rate;
+
+	rtl8188e_reset_ra_counter(ra);
+}
+
+static void rtl8188e_power_training_try_state(struct rtl8xxxu_ra_info *ra)
+{
+	ra->pt_try_state = 0;
+	switch (ra->pt_mode_ss) {
+	case 3:
+		if (ra->decision_rate >= DESC_RATE_MCS13)
+			ra->pt_try_state = 1;
+		break;
+	case 2:
+		if (ra->decision_rate >= DESC_RATE_MCS5)
+			ra->pt_try_state = 1;
+		break;
+	case 1:
+		if (ra->decision_rate >= DESC_RATE_48M)
+			ra->pt_try_state = 1;
+		break;
+	case 0:
+		if (ra->decision_rate >= DESC_RATE_11M)
+			ra->pt_try_state = 1;
+		break;
+	default:
+		break;
+	}
+
+	if (ra->rssi_sta_ra < 48) {
+		ra->pt_stage = 0;
+	} else if (ra->pt_try_state == 1) {
+		if ((ra->pt_stop_count >= 10) ||
+		    (ra->pt_pre_rssi > ra->rssi_sta_ra + 5) ||
+		    (ra->pt_pre_rssi < ra->rssi_sta_ra - 5) ||
+		    (ra->decision_rate != ra->pt_pre_rate)) {
+			if (ra->pt_stage == 0)
+				ra->pt_stage = 1;
+			else if (ra->pt_stage == 1)
+				ra->pt_stage = 3;
+			else
+				ra->pt_stage = 5;
+
+			ra->pt_pre_rssi = ra->rssi_sta_ra;
+			ra->pt_stop_count = 0;
+		} else {
+			ra->ra_stage = 0;
+			ra->pt_stop_count++;
+		}
+	} else {
+		ra->pt_stage = 0;
+		ra->ra_stage = 0;
+	}
+
+	ra->pt_pre_rate = ra->decision_rate;
+
+	/* TODO: implement the "false alarm" statistics for this */
+	/* Disable power training when noisy environment */
+	/* if (p_dm_odm->is_disable_power_training) { */
+	if (1) {
+		ra->pt_stage = 0;
+		ra->ra_stage = 0;
+		ra->pt_stop_count = 0;
+	}
+}
+
+static void rtl8188e_power_training_decision(struct rtl8xxxu_ra_info *ra)
+{
+	u8 temp_stage;
+	u32 numsc;
+	u32 num_total;
+	u8 stage_id;
+	u8 j;
+
+	numsc = 0;
+	num_total = ra->total * pt_penalty[5];
+	for (j = 0; j <= 4; j++) {
+		numsc += ra->retry[j] * pt_penalty[j];
+
+		if (numsc > num_total)
+			break;
+	}
+
+	j >>= 1;
+	temp_stage = (ra->pt_stage + 1) >> 1;
+	if (temp_stage > j)
+		stage_id = temp_stage - j;
+	else
+		stage_id = 0;
+
+	ra->pt_smooth_factor = (ra->pt_smooth_factor >> 1) +
+			       (ra->pt_smooth_factor >> 2) +
+			       stage_id * 16 + 2;
+	if (ra->pt_smooth_factor > 192)
+		ra->pt_smooth_factor = 192;
+	stage_id = ra->pt_smooth_factor >> 6;
+	temp_stage = stage_id * 2;
+	if (temp_stage != 0)
+		temp_stage--;
+	if (ra->drop > 3)
+		temp_stage = 0;
+	ra->pt_stage = temp_stage;
+}
+
+void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
+{
+	u32 *_rx_desc = (u32 *)(skb->data - sizeof(struct rtl8xxxu_rxdesc16));
+	struct rtl8xxxu_rxdesc16 *rx_desc = (struct rtl8xxxu_rxdesc16 *)_rx_desc;
+	struct device *dev = &priv->udev->dev;
+	struct rtl8xxxu_ra_info *ra = &priv->ra_info;
+	u32 tx_rpt_len = rx_desc->pktlen & 0x3ff;
+	u32 items = tx_rpt_len / TX_RPT2_ITEM_SIZE;
+	u64 macid_valid = ((u64)_rx_desc[5] << 32) | _rx_desc[4];
+	u32 macid;
+	u8 *rpt = skb->data;
+	bool valid;
+	u16 min_rpt_time = 0x927c;
+
+	dev_dbg(dev, "%s: len: %d items: %d\n", __func__, tx_rpt_len, items);
+
+	for (macid = 0; macid < items; macid++) {
+		valid = false;
+
+		if (macid < 64)
+			valid = macid_valid & BIT(macid);
+
+		if (valid) {
+			ra->retry[0] = le16_to_cpu(*(__le16 *)rpt);
+			ra->retry[1] = rpt[2];
+			ra->retry[2] = rpt[3];
+			ra->retry[3] = rpt[4];
+			ra->retry[4] = rpt[5];
+			ra->drop = rpt[6];
+			ra->total = ra->retry[0] + ra->retry[1] + ra->retry[2] +
+				    ra->retry[3] + ra->retry[4] + ra->drop;
+
+			if (ra->total > 0) {
+				if (ra->ra_stage < 5)
+					rtl8188e_rate_decision(ra);
+				else if (ra->ra_stage == 5)
+					rtl8188e_power_training_try_state(ra);
+				else /* ra->ra_stage == 6 */
+					rtl8188e_power_training_decision(ra);
+
+				if (ra->ra_stage <= 5)
+					ra->ra_stage++;
+				else
+					ra->ra_stage = 0;
+			}
+		} else if (macid == 0) {
+			dev_warn(dev, "%s: TX report item 0 not valid\n", __func__);
+		}
+
+		dev_dbg(dev, "%s:  valid: %d retry: %d %d %d %d %d drop: %d\n",
+			__func__, valid,
+			ra->retry[0], ra->retry[1], ra->retry[2],
+			ra->retry[3], ra->retry[4], ra->drop);
+
+		if (min_rpt_time > ra->rpt_time)
+			min_rpt_time = ra->rpt_time;
+
+		rpt += TX_RPT2_ITEM_SIZE;
+
+		/*
+		 * We only use macid 0, so only the first item is relevant.
+		 * AP mode will use more of them if it's ever implemented.
+		 */
+		break;
+	}
+
+	if (min_rpt_time != ra->pre_min_rpt_time) {
+		rtl8xxxu_write16(priv, REG_TX_REPORT_TIME, min_rpt_time);
+		ra->pre_min_rpt_time = min_rpt_time;
+	}
+}
+
+static void rtl8188e_arfb_refresh(struct rtl8xxxu_ra_info *ra)
+{
+	s8 i;
+
+	ra->ra_use_rate = ra->rate_mask;
+
+	/* Highest rate */
+	if (ra->ra_use_rate) {
+		for (i = RATESIZE; i >= 0; i--) {
+			if (ra->ra_use_rate & BIT(i)) {
+				ra->highest_rate = i;
+				break;
+			}
+		}
+	} else {
+		ra->highest_rate = 0;
+	}
+
+	/* Lowest rate */
+	if (ra->ra_use_rate) {
+		for (i = 0; i < RATESIZE; i++) {
+			if (ra->ra_use_rate & BIT(i)) {
+				ra->lowest_rate = i;
+				break;
+			}
+		}
+	} else {
+		ra->lowest_rate = 0;
+	}
+
+	if (ra->highest_rate > DESC_RATE_MCS7)
+		ra->pt_mode_ss = 3;
+	else if (ra->highest_rate > DESC_RATE_54M)
+		ra->pt_mode_ss = 2;
+	else if (ra->highest_rate > DESC_RATE_11M)
+		ra->pt_mode_ss = 1;
+	else
+		ra->pt_mode_ss = 0;
+}
+
+static void
+rtl8188e_update_rate_mask(struct rtl8xxxu_priv *priv,
+			  u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
+{
+	struct rtl8xxxu_ra_info *ra = &priv->ra_info;
+
+	ra->rate_id = rateid;
+	ra->rate_mask = ramask;
+	ra->sgi_enable = sgi;
+
+	rtl8188e_arfb_refresh(ra);
+}
+
+void rtl8188e_ra_info_init_all(struct rtl8xxxu_ra_info *ra)
+{
+	ra->decision_rate = DESC_RATE_MCS7;
+	ra->pre_rate = DESC_RATE_MCS7;
+	ra->highest_rate = DESC_RATE_MCS7;
+	ra->lowest_rate = 0;
+	ra->rate_id = 0;
+	ra->rate_mask = 0xfffff;
+	ra->rssi_sta_ra = 0;
+	ra->pre_rssi_sta_ra = 0;
+	ra->sgi_enable = 0;
+	ra->ra_use_rate = 0xfffff;
+	ra->nsc_down = (n_threshold_high[DESC_RATE_MCS7] + n_threshold_low[DESC_RATE_MCS7]) / 2;
+	ra->nsc_up = (n_threshold_high[DESC_RATE_MCS7] + n_threshold_low[DESC_RATE_MCS7]) / 2;
+	ra->rate_sgi = 0;
+	ra->rpt_time = 0x927c;
+	ra->drop = 0;
+	ra->retry[0] = 0;
+	ra->retry[1] = 0;
+	ra->retry[2] = 0;
+	ra->retry[3] = 0;
+	ra->retry[4] = 0;
+	ra->total = 0;
+	ra->ra_waiting_counter = 0;
+	ra->ra_pending_counter = 0;
+	ra->ra_drop_after_down = 0;
+
+	ra->pt_try_state = 0;
+	ra->pt_stage = 5;
+	ra->pt_smooth_factor = 192;
+	ra->pt_stop_count = 0;
+	ra->pt_pre_rate = 0;
+	ra->pt_pre_rssi = 0;
+	ra->pt_mode_ss = 0;
+	ra->ra_stage = 0;
+}
+
 struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.identify_chip = rtl8188eu_identify_chip,
 	.parse_efuse = rtl8188eu_parse_efuse,
@@ -1252,7 +1840,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.disable_rf = rtl8188e_disable_rf,
 	.usb_quirks = rtl8188e_usb_quirks,
 	.set_tx_power = rtl8188f_set_tx_power,
-	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
+	.update_rate_mask = rtl8188e_update_rate_mask,
 	.report_connect = rtl8xxxu_gen2_report_connect,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v3,
 	.set_crystal_cap = rtl8188f_set_crystal_cap,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index c63d3459d8d2..b8fc9e119047 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3981,7 +3981,25 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		 * Enable TX report and TX report timer for 8723bu/8188eu/...
 		 */
 		if (fops->has_tx_report) {
+			/*
+			 * The RTL8188EU has two types of TX reports:
+			 * rpt_sel=1:
+			 *   One report for one frame. We can use this for frames
+			 *   with IEEE80211_TX_CTL_REQ_TX_STATUS.
+			 * rpt_sel=2:
+			 *   One report for many frames transmitted over a period
+			 *   of time. (This is what REG_TX_REPORT_TIME is for.) The
+			 *   report includes the number of frames transmitted
+			 *   successfully, and the number of unsuccessful
+			 *   transmissions. We use this for software rate control.
+			 *
+			 * Bit 0 of REG_TX_REPORT_CTRL is required for both types.
+			 * Bit 1 (TX_REPORT_CTRL_TIMER_ENABLE) is required for
+			 * type 2.
+			 */
 			val8 = rtl8xxxu_read8(priv, REG_TX_REPORT_CTRL);
+			if (priv->rtl_chip == RTL8188E)
+				val8 |= BIT(0);
 			val8 |= TX_REPORT_CTRL_TIMER_ENABLE;
 			rtl8xxxu_write8(priv, REG_TX_REPORT_CTRL, val8);
 			/* Set MAX RPT MACID */
@@ -4272,6 +4290,9 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		priv->cfo_tracking.crystal_cap = priv->default_crystal_cap;
 	}
 
+	if (priv->rtl_chip == RTL8188E)
+		rtl8188e_ra_info_init_all(&priv->ra_info);
+
 exit:
 	return ret;
 }
@@ -4635,8 +4656,8 @@ static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv *priv, u8 slot_time)
 	}
 }
 
-static void rtl8xxxu_update_ra_report(struct rtl8xxxu_ra_report *rarpt,
-				      u8 rate, u8 sgi, u8 bw)
+void rtl8xxxu_update_ra_report(struct rtl8xxxu_ra_report *rarpt,
+			       u8 rate, u8 sgi, u8 bw)
 {
 	u8 mcs, nss;
 
@@ -5120,6 +5141,7 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
+	struct rtl8xxxu_ra_info *ra = &priv->ra_info;
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate;
@@ -5135,9 +5157,10 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
 	if (ieee80211_is_data(hdr->frame_control)) {
-		rate = DESC_RATE_MCS7; /* TODO: software rate control */
+		rate = ra->decision_rate;
 		tx_desc->txdw5 = cpu_to_le32(rate);
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_USE_DRIVER_RATE);
+		tx_desc->txdw4 |= le32_encode_bits(ra->pt_stage, TXDESC32_PT_STAGE_MASK);
 		/* Data/RTS rate FB limit */
 		tx_desc->txdw5 |= cpu_to_le32(0x0001ff00);
 	}
@@ -5176,7 +5199,7 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	if (short_preamble)
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_SHORT_PREAMBLE);
 
-	if (sgi)
+	if (sgi && ra->rate_sgi)
 		tx_desc->txdw5 |= cpu_to_le32(TXDESC32_SHORT_GI);
 
 	/*
@@ -5767,6 +5790,44 @@ static void rtl8723bu_handle_c2h(struct rtl8xxxu_priv *priv,
 	schedule_work(&priv->c2hcmd_work);
 }
 
+static void rtl8188e_c2hcmd_callback(struct work_struct *work)
+{
+	struct rtl8xxxu_priv *priv = container_of(work, struct rtl8xxxu_priv, c2hcmd_work);
+	struct device *dev = &priv->udev->dev;
+	struct sk_buff *skb = NULL;
+	struct rtl8xxxu_rxdesc16 *rx_desc;
+
+	while (!skb_queue_empty(&priv->c2hcmd_queue)) {
+		skb = skb_dequeue(&priv->c2hcmd_queue);
+
+		rx_desc = (struct rtl8xxxu_rxdesc16 *)(skb->data - sizeof(struct rtl8xxxu_rxdesc16));
+
+		switch (rx_desc->rpt_sel) {
+		case 1:
+			dev_dbg(dev, "C2H TX report type 1\n");
+
+			break;
+		case 2:
+			dev_dbg(dev, "C2H TX report type 2\n");
+
+			rtl8188e_handle_ra_tx_report2(priv, skb);
+
+			break;
+		case 3:
+			dev_dbg(dev, "C2H USB interrupt report\n");
+
+			break;
+		default:
+			dev_warn(dev, "%s: rpt_sel should not be %d\n",
+				 __func__, rx_desc->rpt_sel);
+
+			break;
+		}
+
+		dev_kfree_skb(skb);
+	}
+}
+
 int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 {
 	struct ieee80211_hw *hw = priv->hw;
@@ -5822,38 +5883,45 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 
 		skb_pull(skb, sizeof(struct rtl8xxxu_rxdesc16));
 
-		phy_stats = (struct rtl8723au_phy_stats *)skb->data;
+		if (rx_desc->rpt_sel) {
+			skb_queue_tail(&priv->c2hcmd_queue, skb);
+			schedule_work(&priv->c2hcmd_work);
+		} else {
+			phy_stats = (struct rtl8723au_phy_stats *)skb->data;
 
-		skb_pull(skb, drvinfo_sz + desc_shift);
+			skb_pull(skb, drvinfo_sz + desc_shift);
 
-		skb_trim(skb, pkt_len);
+			skb_trim(skb, pkt_len);
 
-		if (rx_desc->phy_stats)
-			rtl8xxxu_rx_parse_phystats(priv, rx_status, phy_stats,
-						   rx_desc->rxmcs, (struct ieee80211_hdr *)skb->data,
-						   rx_desc->crc32 || rx_desc->icverr);
+			if (rx_desc->phy_stats)
+				rtl8xxxu_rx_parse_phystats(
+					priv, rx_status, phy_stats,
+					rx_desc->rxmcs,
+					(struct ieee80211_hdr *)skb->data,
+					rx_desc->crc32 || rx_desc->icverr);
 
-		rx_status->mactime = rx_desc->tsfl;
-		rx_status->flag |= RX_FLAG_MACTIME_START;
+			rx_status->mactime = rx_desc->tsfl;
+			rx_status->flag |= RX_FLAG_MACTIME_START;
 
-		if (!rx_desc->swdec)
-			rx_status->flag |= RX_FLAG_DECRYPTED;
-		if (rx_desc->crc32)
-			rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-		if (rx_desc->bw)
-			rx_status->bw = RATE_INFO_BW_40;
+			if (!rx_desc->swdec)
+				rx_status->flag |= RX_FLAG_DECRYPTED;
+			if (rx_desc->crc32)
+				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
+			if (rx_desc->bw)
+				rx_status->bw = RATE_INFO_BW_40;
 
-		if (rx_desc->rxht) {
-			rx_status->encoding = RX_ENC_HT;
-			rx_status->rate_idx = rx_desc->rxmcs - DESC_RATE_MCS0;
-		} else {
-			rx_status->rate_idx = rx_desc->rxmcs;
-		}
+			if (rx_desc->rxht) {
+				rx_status->encoding = RX_ENC_HT;
+				rx_status->rate_idx = rx_desc->rxmcs - DESC_RATE_MCS0;
+			} else {
+				rx_status->rate_idx = rx_desc->rxmcs;
+			}
 
-		rx_status->freq = hw->conf.chandef.chan->center_freq;
-		rx_status->band = hw->conf.chandef.chan->band;
+			rx_status->freq = hw->conf.chandef.chan->center_freq;
+			rx_status->band = hw->conf.chandef.chan->band;
 
-		ieee80211_rx_irqsafe(hw, skb);
+			ieee80211_rx_irqsafe(hw, skb);
+		}
 
 		skb = next_skb;
 		if (skb)
@@ -6940,7 +7008,6 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	spin_lock_init(&priv->rx_urb_lock);
 	INIT_WORK(&priv->rx_urb_wq, rtl8xxxu_rx_urb_work);
 	INIT_DELAYED_WORK(&priv->ra_watchdog, rtl8xxxu_watchdog_callback);
-	INIT_WORK(&priv->c2hcmd_work, rtl8xxxu_c2hcmd_callback);
 	skb_queue_head_init(&priv->c2hcmd_queue);
 
 	usb_set_intfdata(interface, hw);
@@ -6958,6 +7025,11 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	hw->wiphy->available_antennas_tx = BIT(priv->tx_paths) - 1;
 	hw->wiphy->available_antennas_rx = BIT(priv->rx_paths) - 1;
 
+	if (priv->rtl_chip == RTL8188E)
+		INIT_WORK(&priv->c2hcmd_work, rtl8188e_c2hcmd_callback);
+	else
+		INIT_WORK(&priv->c2hcmd_work, rtl8xxxu_c2hcmd_callback);
+
 	ret = rtl8xxxu_read_efuse(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to read EFuse\n");
-- 
2.38.0
