Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04E06EE6A3
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 19:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjDYR2c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 13:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjDYR2a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 13:28:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A795BBA
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 10:28:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f109b1808so1140048566b.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682443703; x=1685035703;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITuiQ6OqeiQaxifI3IOSW/SbXJgCUZCvljqm02GpdNA=;
        b=ImuJaq4KjD8BikjqgXb/PnVHwofxojhU8gt6b+jlagJg6VyOsCTl5uixC/jvjDZGuI
         oCAQ9zf77maEf6dHGI1QkBSj/9ezJwHYxcB6JVhKDDNXbwBPYSvbLIVdiucMvafbAIoQ
         gmXclQn5HNd8wJKhzn9FZHbhqmDFRYiuKTcS8g7LnqvlPsxhtK4fX1Mo9HCQh2FDicwi
         ZnBniGJjKjBvHi46UdDMjQ6gtMVYtPph2NGMC6ZLSH5X4KyZyY56Xohd9AwXTfShWld7
         zkDKUeoFliwSkTowowd0SwZ+5Tdo66jDRFuGVK9LF4yHE0K/jdyroc4fdIbOqRVz/zcG
         ucSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682443703; x=1685035703;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ITuiQ6OqeiQaxifI3IOSW/SbXJgCUZCvljqm02GpdNA=;
        b=LGkw2j8efTghrgSGHp2o7OFjFtUX23v/BEJtBpN3jXTLp8lzp+kuRWWG6V2GM3fTKQ
         NrPHFoi6+Fhx1/xgST5AF5JkteAkPbcBmYIN8nxMaZMCJv3mUPpZOh/3skX9kG2Omz0a
         xd65lB9cGkDApLUtx8vFXEjPX1+ro56mVXG/wqL8wkQB9va76kABodEckqpL4bB4d6x8
         PYzH63z1x0X5UTR9fC2vz/d97r17MgcnDKU0wPJTTrMUafHgOTkPvbObxSZdFoXv1K6x
         jnI2/VvZDGHR4+eB6DGFvjiSugMbinLwEs3aUOCCqSIqAtUzje68obxtKtfDEBXwzSEn
         z+VQ==
X-Gm-Message-State: AAQBX9dyG+7bFHtzAGOSDDQMmCQgxRlDv1jEpRM5xlGYr9qC0Kf0Sv5A
        ep/vqfM4SIX80/gSy/iTQ1sFG2/9yRo=
X-Google-Smtp-Source: AKy350ZKztCnMMOzVE7tzuCxgG1uePG5vD9Ub0p47R015m5NXZf/DckhbddHTN9SWTR0fTmG6m93pg==
X-Received: by 2002:a17:906:1345:b0:94e:61d3:d13b with SMTP id x5-20020a170906134500b0094e61d3d13bmr13929407ejb.75.1682443702300;
        Tue, 25 Apr 2023 10:28:22 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id qf19-20020a1709077f1300b0094ef923a6ccsm6921597ejc.219.2023.04.25.10.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 10:28:21 -0700 (PDT)
Message-ID: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
Date:   Tue, 25 Apr 2023 20:28:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a newer chip, similar to the RTL8710BU in that it uses the same
PHY status structs.

Features: 2.4 GHz, b/g/n mode, 2T2R, 300 Mbps.

It can allegedly have Bluetooth, but that's not implemented here.

This chip can have many RFE (RF front end) types, of which type 5 is
the only one tested. Many of the other types need different
initialisation tables. They can be added if someone wants them.

The vendor driver v5.8.6.2_35538.20191028_COEX20190910-0d02 from
https://github.com/BrightX/rtl8192fu was used as reference.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/Kconfig |    3 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   47 +
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    3 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 2081 +++++++++++++++++
 .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         |    1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |    1 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  104 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   15 +
 8 files changed, 2225 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/Kconfig b/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
index 82bcaf44a65f..44ad94757a03 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
+++ b/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
@@ -11,7 +11,8 @@ config RTL8XXXU
 	  parts written to utilize the Linux mac80211 stack.
 	  The driver is known to work with a number of RTL8723AU,
 	  RL8188CU, RTL8188RU, RTL8191CU, RTL8192CU, RTL8723BU, RTL8192EU,
-	  RTL8188FU, RTL8188EU, and RTL8710BU (aka RTL8188GU) devices.
+	  RTL8188FU, RTL8188EU, RTL8710BU (aka RTL8188GU), and RTL8192FU
+	  devices.
 
 	  This driver is under development and has a limited feature
 	  set. In particular it does not yet support 40MHz channels
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 8eafbf1cee71..91c2bd8762a5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -39,6 +39,7 @@
 #define TX_TOTAL_PAGE_NUM_8188E		0xa9
 #define TX_TOTAL_PAGE_NUM_8192E		0xf3
 #define TX_TOTAL_PAGE_NUM_8723B		0xf7
+#define TX_TOTAL_PAGE_NUM_8192F		0xf7
 /* (HPQ + LPQ + NPQ + PUBQ) = TX_TOTAL_PAGE_NUM */
 #define TX_PAGE_NUM_PUBQ		0xe7
 #define TX_PAGE_NUM_HI_PQ		0x0c
@@ -65,6 +66,11 @@
 #define TX_PAGE_NUM_LO_PQ_8723B		0x02
 #define TX_PAGE_NUM_NORM_PQ_8723B	0x02
 
+#define TX_PAGE_NUM_PUBQ_8192F		0xde
+#define TX_PAGE_NUM_HI_PQ_8192F		0x08
+#define TX_PAGE_NUM_LO_PQ_8192F		0x08
+#define TX_PAGE_NUM_NORM_PQ_8192F	0x08
+
 #define RTL_FW_PAGE_SIZE		4096
 #define RTL8XXXU_FIRMWARE_POLL_MAX	1000
 
@@ -81,6 +87,7 @@
 #define EFUSE_REAL_CONTENT_LEN_8723A	512
 #define EFUSE_BT_MAP_LEN_8723A		1024
 #define EFUSE_MAX_WORD_UNIT		4
+#define EFUSE_UNDEFINED			0xff
 
 enum rtl8xxxu_rtl_chip {
 	RTL8192S = 0x81920,
@@ -105,6 +112,7 @@ enum rtl8xxxu_rtl_chip {
 	RTL8195A = 0x8195a,
 	RTL8188F = 0x8188f,
 	RTL8710B = 0x8710b,
+	RTL8192F = 0x8192f,
 };
 
 enum rtl8xxxu_rx_type {
@@ -1246,6 +1254,40 @@ struct rtl8710bu_efuse {
 	u8 res7[0x3c];
 } __packed;
 
+struct rtl8192fu_efuse {
+	__le16 rtl_id;
+	u8 res0[0x0e];
+	struct rtl8192eu_efuse_tx_power tx_power_index_A;	/* 0x10 */
+	struct rtl8192eu_efuse_tx_power tx_power_index_B;	/* 0x3a */
+	u8 res2[0x54];
+	u8 channel_plan;		/* 0xb8 */
+	u8 xtal_k;			/* 0xb9 */
+	u8 thermal_meter;		/* 0xba */
+	u8 iqk_lck;			/* 0xbb */
+	u8 pa_type;			/* 0xbc */
+	u8 lna_type_2g;			/* 0xbd */
+	u8 res3[1];
+	u8 lna_type_5g;			/* 0xbf */
+	u8 res4[1];
+	u8 rf_board_option;		/* 0xc1 */
+	u8 rf_feature_option;		/* 0xc2 */
+	u8 rf_bt_setting;		/* 0xc3 */
+	u8 eeprom_version;		/* 0xc4 */
+	u8 eeprom_customer_id;		/* 0xc5 */
+	u8 res5[3];
+	u8 rf_antenna_option;		/* 0xc9 */
+	u8 rfe_option;			/* 0xca */
+	u8 country_code;		/* 0xcb */
+	u8 res6[52];
+	u8 vid[2];			/* 0x100 */
+	u8 pid[2];			/* 0x102 */
+	u8 usb_optional_function;	/* 0x104 */
+	u8 res7[2];
+	u8 mac_addr[ETH_ALEN];		/* 0x107 */
+	u8 device_info[80];		/* 0x10d */
+	u8 res9[163];
+} __packed;
+
 struct rtl8xxxu_reg8val {
 	u16 reg;
 	u8 val;
@@ -1791,6 +1833,7 @@ struct rtl8xxxu_priv {
 	u32 cck_agc_report_type:1;
 	u32 cck_new_agc:1;
 	u8 default_crystal_cap;
+	u8 rfe_type;
 	unsigned int pipe_interrupt;
 	unsigned int pipe_in;
 	unsigned int pipe_out[TXDESC_QUEUE_MAX];
@@ -1830,6 +1873,7 @@ struct rtl8xxxu_priv {
 		struct rtl8188fu_efuse efuse8188fu;
 		struct rtl8188eu_efuse efuse8188eu;
 		struct rtl8710bu_efuse efuse8710bu;
+		struct rtl8192fu_efuse efuse8192fu;
 	} efuse_wifi;
 	u32 adda_backup[RTL8XXXU_ADDA_REGS];
 	u32 mac_backup[RTL8XXXU_MAC_REGS];
@@ -1928,6 +1972,7 @@ struct rtl8xxxu_fileops {
 	u8 init_reg_hmtfr:1;
 	u8 ampdu_max_time;
 	u8 ustime_tsf_edca;
+	u16 max_aggr_num;
 	u32 adda_1t_init;
 	u32 adda_1t_path_on;
 	u32 adda_2t_path_on_a;
@@ -2014,6 +2059,7 @@ void rtl8xxxu_gen1_phy_iq_calibrate(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen1_init_phy_bb(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv,
 				int channel, bool ht40);
+void rtl8188f_channel_to_group(int channel, int *group, int *cck_group);
 void rtl8188f_set_tx_power(struct rtl8xxxu_priv *priv,
 			   int channel, bool ht40);
 void rtl8xxxu_gen1_config_channel(struct ieee80211_hw *hw);
@@ -2078,6 +2124,7 @@ void rtl8xxxu_update_ra_report(struct rtl8xxxu_ra_report *rarpt,
 void rtl8188e_ra_info_init_all(struct rtl8xxxu_ra_info *ra);
 void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_priv *priv, struct sk_buff *skb);
 
+extern struct rtl8xxxu_fileops rtl8192fu_fops;
 extern struct rtl8xxxu_fileops rtl8710bu_fops;
 extern struct rtl8xxxu_fileops rtl8188fu_fops;
 extern struct rtl8xxxu_fileops rtl8188eu_fops;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index dbdfd7787465..6108568b4e2a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -351,7 +351,7 @@ static int rtl8188fu_identify_chip(struct rtl8xxxu_priv *priv)
 	return ret;
 }
 
-static void rtl8188f_channel_to_group(int channel, int *group, int *cck_group)
+void rtl8188f_channel_to_group(int channel, int *group, int *cck_group)
 {
 	if (channel < 3)
 		*group = 0;
@@ -1748,6 +1748,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.init_reg_hmtfr = 1,
 	.ampdu_max_time = 0x70,
 	.ustime_tsf_edca = 0x28,
+	.max_aggr_num = 0x0c14,
 	.adda_1t_init = 0x03c00014,
 	.adda_1t_path_on = 0x03c00014,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
new file mode 100644
index 000000000000..5728bb45e29e
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
@@ -0,0 +1,2081 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RTL8XXXU mac80211 USB driver - 8192fu specific subdriver
+ *
+ * Copyright (c) 2023 Bitterblue Smith <rtl8821cerfe2@gmail.com>
+ *
+ * Portions copied from existing rtl8xxxu code:
+ * Copyright (c) 2014 - 2017 Jes Sorensen <Jes.Sorensen@gmail.com>
+ *
+ * Portions, notably calibration code:
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/usb.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/wireless.h>
+#include <linux/firmware.h>
+#include <linux/moduleparam.h>
+#include <net/mac80211.h>
+#include "rtl8xxxu.h"
+#include "rtl8xxxu_regs.h"
+
+static const struct rtl8xxxu_reg8val rtl8192f_mac_init_table[] = {
+	{0x420, 0x00},	{0x422, 0x78},	{0x428, 0x0a},	{0x429, 0x10},
+	{0x430, 0x00},	{0x431, 0x00},	{0x432, 0x00},	{0x433, 0x01},
+	{0x434, 0x04},	{0x435, 0x05},	{0x436, 0x07},	{0x437, 0x08},
+	{0x43c, 0x04},	{0x43d, 0x05},	{0x43e, 0x07},	{0x43f, 0x08},
+	{0x440, 0x5d},	{0x441, 0x01},	{0x442, 0x00},	{0x444, 0x10},
+	{0x445, 0xf0},	{0x446, 0x0e},	{0x447, 0x1f},	{0x448, 0x00},
+	{0x449, 0x00},	{0x44a, 0x00},	{0x44b, 0x00},	{0x44c, 0x10},
+	{0x44d, 0xf0},	{0x44e, 0x0e},	{0x44f, 0x00},	{0x450, 0x00},
+	{0x451, 0x00},	{0x452, 0x00},	{0x453, 0x00},	{0x480, 0x20},
+	{0x49c, 0x30},	{0x49d, 0xf0},	{0x49e, 0x03},	{0x49f, 0x3e},
+	{0x4a0, 0x00},	{0x4a1, 0x00},	{0x4a2, 0x00},	{0x4a3, 0x00},
+	{0x4a4, 0x15},	{0x4a5, 0xf0},	{0x4a6, 0x01},	{0x4a7, 0x0e},
+	{0x4a8, 0xe0},	{0x4a9, 0x00},	{0x4aa, 0x00},	{0x4ab, 0x00},
+	{0x2448, 0x06},	{0x244a, 0x06},	{0x244c, 0x06},	{0x244e, 0x06},
+	{0x4c7, 0x80},	{0x4c8, 0xff},	{0x4c9, 0x08},	{0x4ca, 0x3c},
+	{0x4cb, 0x3c},	{0x4cc, 0xff},	{0x4cd, 0xff},	{0x4ce, 0x01},
+	{0x500, 0x26},	{0x501, 0xa2},	{0x502, 0x2f},	{0x503, 0x00},
+	{0x504, 0x28},	{0x505, 0xa3},	{0x506, 0x5e},	{0x507, 0x00},
+	{0x508, 0x2b},	{0x509, 0xa4},	{0x50a, 0x5e},	{0x50b, 0x00},
+	{0x50c, 0x4f},	{0x50d, 0xa4},	{0x50e, 0x00},	{0x50f, 0x00},
+	{0x512, 0x1c},	{0x514, 0x0a},	{0x516, 0x0a},	{0x521, 0x2f},
+	{0x525, 0x0f},	{0x550, 0x10},	{0x551, 0x10},	{0x559, 0x02},
+	{0x55c, 0x50},	{0x55d, 0xff},	{0x605, 0x30},	{0x608, 0x0e},
+	{0x609, 0x2a},	{0x60c, 0x18},	{0x620, 0xff},	{0x621, 0xff},
+	{0x622, 0xff},	{0x623, 0xff},	{0x624, 0xff},	{0x625, 0xff},
+	{0x626, 0xff},	{0x627, 0xff},	{0x638, 0x50},	{0x63c, 0x0a},
+	{0x63d, 0x0a},	{0x63e, 0x0e},	{0x63f, 0x0e},	{0x640, 0x40},
+	{0x642, 0x40},	{0x643, 0x00},	{0x652, 0xc8},	{0x66e, 0x05},
+	{0x6a0, 0xff},	{0x6a1, 0xff},	{0x6a2, 0xff},	{0x6a3, 0xff},
+	{0x6a4, 0xff},	{0x6a5, 0xff},	{0x6de, 0x84},	{0x700, 0x21},
+	{0x701, 0x43},	{0x702, 0x65},	{0x703, 0x87},	{0x708, 0x21},
+	{0x709, 0x43},	{0x70a, 0x65},	{0x70b, 0x87},	{0x718, 0x40},
+	{0x7c0, 0x38},	{0x7c2, 0x0f},	{0x7c3, 0xc0},	{0x073, 0x04},
+	{0x7c4, 0x77},	{0x024, 0xc7},	{0x7ec, 0xff},	{0x7ed, 0xff},
+	{0x7ee, 0xff},	{0x7ef, 0xff},
+	{0xffff, 0xff},
+};
+
+/* If updating the phy init table, also update rtl8192f_revise_cck_tx_psf(). */
+static const struct rtl8xxxu_reg32val rtl8192fu_phy_init_table[] = {
+	{0x800, 0x80006C00},	{0x804, 0x00004001},
+	{0x808, 0x0000FC00},	{0x80C, 0x00000000},
+	{0x810, 0x20200322},	{0x814, 0x020C3910},
+	{0x818, 0x00000385},	{0x81C, 0x07000000},
+	{0x820, 0x01000100},	{0x824, 0x00390204},
+	{0x828, 0x01000100},	{0x82C, 0x00390204},
+	{0x830, 0x25252525},	{0x834, 0x25252525},
+	{0x838, 0x25252525},	{0x83C, 0x25252525},
+	{0x840, 0x00010000},	{0x844, 0x00010000},
+	{0x848, 0x25252525},	{0x84C, 0x25252525},
+	{0x850, 0x00031FE0},	{0x854, 0x00000000},
+	{0x858, 0x569A569A},	{0x85C, 0x00400040},
+	{0x860, 0x66F60000},	{0x864, 0x061F0000},
+	{0x868, 0x25252525},	{0x86C, 0x25252525},
+	{0x870, 0x00000300},	{0x874, 0x04003400},
+	{0x878, 0x08080808},	{0x87C, 0x004F0201},
+	{0x880, 0xD8001402},	{0x884, 0xC0000120},
+	{0x888, 0x00000000},	{0x88C, 0xCC0000C0},
+	{0x890, 0x00000000},	{0x894, 0xFFFFFFFE},
+	{0x898, 0x40302010},	{0x89C, 0x00706050},
+	{0x900, 0x00000000},	{0x904, 0x00000023},
+	{0x908, 0x00000F00},	{0x90C, 0x81121313},
+	{0x910, 0x024C0000},	{0x914, 0x00000000},
+	{0x918, 0x00000000},	{0x91C, 0x00000000},
+	{0x920, 0x00000000},	{0x924, 0x00000000},
+	{0x928, 0x00000000},	{0x92C, 0x00000000},
+	{0x930, 0x88000000},	{0x934, 0x00000245},
+	{0x938, 0x00024588},	{0x93C, 0x00000000},
+	{0x940, 0x000007FF},	{0x944, 0x3F3F0000},
+	{0x948, 0x000001A3},	{0x94C, 0x20200008},
+	{0x950, 0x00338A98},	{0x954, 0x00000000},
+	{0x958, 0xCBCAD87A},	{0x95C, 0x06EB5735},
+	{0x960, 0x00000000},	{0x964, 0x00000000},
+	{0x968, 0x00000000},	{0x96C, 0x00000003},
+	{0x970, 0x00000000},	{0x974, 0x00000000},
+	{0x978, 0x00000000},	{0x97C, 0x10030000},
+	{0x980, 0x00000000},	{0x984, 0x02800280},
+	{0x988, 0x020A5704},	{0x98C, 0x1461C826},
+	{0x990, 0x0001469E},	{0x994, 0x008858D1},
+	{0x998, 0x400086C9},	{0x99C, 0x44444242},
+	{0x9A0, 0x00000000},	{0x9A4, 0x00000000},
+	{0x9A8, 0x00000000},	{0x9AC, 0xC0000000},
+	{0xA00, 0x00D047C8},	{0xA04, 0xC1FF0008},
+	{0xA08, 0x88838300},	{0xA0C, 0x2E20100F},
+	{0xA10, 0x9500BB78},	{0xA14, 0x11144028},
+	{0xA18, 0x00881117},	{0xA1C, 0x89140F00},
+	{0xA20, 0xE82C0001},	{0xA24, 0x64B80C1C},
+	{0xA28, 0x00158810},	{0xA2C, 0x10BB8000},
+	{0xA70, 0x00008000},	{0xA74, 0x80800100},
+	{0xA78, 0x000089F0},	{0xA7C, 0x225B0606},
+	{0xA80, 0x20803210},	{0xA84, 0x00200200},
+	{0xA88, 0x00000000},	{0xA8C, 0x00000000},
+	{0xA90, 0x00000000},	{0xA94, 0x00000000},
+	{0xA98, 0x00000000},	{0xA9C, 0x00460000},
+	{0xAA0, 0x00000000},	{0xAA4, 0x00020014},
+	{0xAA8, 0xBA0A0008},	{0xAAC, 0x01235667},
+	{0xAB0, 0x00000000},	{0xAB4, 0x00201402},
+	{0xAB8, 0x0000001C},	{0xABC, 0x0000F7FF},
+	{0xAC0, 0xD4C0A742},	{0xAC4, 0x00000000},
+	{0xAC8, 0x00000F08},	{0xACC, 0x00000F07},
+	{0xAD0, 0xA1052A10},	{0xAD4, 0x0D9D8452},
+	{0xAD8, 0x9E024024},	{0xADC, 0x0023C001},
+	{0xAE0, 0x00000391},	{0xB2C, 0x00000000},
+	{0xC00, 0x00000080},	{0xC04, 0x6F005433},
+	{0xC08, 0x000004E4},	{0xC0C, 0x6C6C6C6C},
+	{0xC10, 0x22000000},	{0xC14, 0x40000100},
+	{0xC18, 0x22000000},	{0xC1C, 0x40000100},
+	{0xC20, 0x00000000},	{0xC24, 0x40000100},
+	{0xC28, 0x00000000},	{0xC2C, 0x40000100},
+	{0xC30, 0x0401E809},	{0xC34, 0x30000020},
+	{0xC38, 0x23808080},	{0xC3C, 0x00002F44},
+	{0xC40, 0x1CF8403F},	{0xC44, 0x000100C7},
+	{0xC48, 0xEC060106},	{0xC4C, 0x007F037F},
+	{0xC50, 0x00E48020},	{0xC54, 0x04008017},
+	{0xC58, 0x00000020},	{0xC5C, 0x00708492},
+	{0xC60, 0x09280200},	{0xC64, 0x5014838B},
+	{0xC68, 0x47C006C7},	{0xC6C, 0x00000035},
+	{0xC70, 0x00001007},	{0xC74, 0x02815269},
+	{0xC78, 0x0FE07F1F},	{0xC7C, 0x00B91612},
+	{0xC80, 0x40000100},	{0xC84, 0x32000000},
+	{0xC88, 0x40000100},	{0xC8C, 0xA0240000},
+	{0xC90, 0x400E161E},	{0xC94, 0x00000F00},
+	{0xC98, 0x400E161E},	{0xC9C, 0x0000BDC8},
+	{0xCA0, 0x00000000},	{0xCA4, 0x098300A0},
+	{0xCA8, 0x00006B00},	{0xCAC, 0x87F45B1A},
+	{0xCB0, 0x0000002D},	{0xCB4, 0x00000000},
+	{0xCB8, 0x00000000},	{0xCBC, 0x28100200},
+	{0xCC0, 0x0010A3D0},	{0xCC4, 0x00000F7D},
+	{0xCC8, 0x00000000},	{0xCCC, 0x00000000},
+	{0xCD0, 0x593659AD},	{0xCD4, 0xB7545121},
+	{0xCD8, 0x64B22427},	{0xCDC, 0x00766932},
+	{0xCE0, 0x40201000},	{0xCE4, 0x00000000},
+	{0xCE8, 0x40E04407},	{0xCEC, 0x2E572000},
+	{0xD00, 0x000D8780},	{0xD04, 0x40020403},
+	{0xD08, 0x0002907F},	{0xD0C, 0x20010201},
+	{0xD10, 0x06288888},	{0xD14, 0x8888367B},
+	{0xD18, 0x7D806DB3},	{0xD1C, 0x0000007F},
+	{0xD20, 0x567600B8},	{0xD24, 0x0000018B},
+	{0xD28, 0xD513FF7D},	{0xD2C, 0xCC979975},
+	{0xD30, 0x04928000},	{0xD34, 0x40608000},
+	{0xD38, 0x88DDA000},	{0xD3C, 0x00026EE2},
+	{0xD50, 0x67270001},	{0xD54, 0x20500000},
+	{0xD58, 0x16161616},	{0xD5C, 0x71F20064},
+	{0xD60, 0x4653DA60},	{0xD64, 0x3E718A3C},
+	{0xD68, 0x00000183},	{0xD7C, 0x00000000},
+	{0xD80, 0x50000000},	{0xD84, 0x31310400},
+	{0xD88, 0xF5B50000},	{0xD8C, 0x00000000},
+	{0xD90, 0x00000000},	{0xD94, 0x44BBBB44},
+	{0xD98, 0x44BB44FF},	{0xD9C, 0x06033688},
+	{0xE00, 0x25252525},	{0xE04, 0x25252525},
+	{0xE08, 0x25252525},	{0xE10, 0x25252525},
+	{0xE14, 0x25252525},	{0xE18, 0x25252525},
+	{0xE1C, 0x25252525},	{0xE20, 0x00000000},
+	{0xE24, 0x00200000},	{0xE28, 0x00000000},
+	{0xE2C, 0x00000000},	{0xE30, 0x01007C00},
+	{0xE34, 0x01004800},	{0xE38, 0x10008C0F},
+	{0xE3C, 0x3C008C0F},	{0xE40, 0x01007C00},
+	{0xE44, 0x00000000},	{0xE48, 0x00000000},
+	{0xE4C, 0x00000000},	{0xE50, 0x01007C00},
+	{0xE54, 0x01004800},	{0xE58, 0x10008C0F},
+	{0xE5C, 0x3C008C0F},	{0xE60, 0x02100000},
+	{0xE64, 0xBBBBBBBB},	{0xE68, 0x40404040},
+	{0xE6C, 0x80408040},	{0xE70, 0x80408040},
+	{0xE74, 0x40404040},	{0xE78, 0x00400040},
+	{0xE7C, 0x40404040},	{0xE80, 0x00FF0000},
+	{0xE84, 0x80408040},	{0xE88, 0x40404040},
+	{0xE8C, 0x80408040},	{0xED0, 0x80408040},
+	{0xED4, 0x80408040},	{0xED8, 0x80408040},
+	{0xEDC, 0xC040C040},	{0xEE0, 0xC040C040},
+	{0xEE4, 0x00400040},	{0xEE8, 0xD8001402},
+	{0xEEC, 0xC0000120},	{0xEF0, 0x02000B09},
+	{0xEF4, 0x00000001},	{0xEF8, 0x00000000},
+	{0xF00, 0x00000300},	{0xF04, 0x00000002},
+	{0xF08, 0x00007D0C},	{0xF0C, 0x0000A907},
+	{0xF10, 0x00005807},	{0xF14, 0x00000003},
+	{0xF18, 0x07D003E8},	{0xF1C, 0x8000001F},
+	{0xF20, 0x00000000},	{0xF24, 0x00000000},
+	{0xF28, 0x00000000},	{0xF2C, 0x00000000},
+	{0xF30, 0x00000000},	{0xF34, 0x00000000},
+	{0xF38, 0x00030055},	{0xF3C, 0x0000003A},
+	{0xF40, 0x00000002},	{0xF44, 0x00000000},
+	{0xF48, 0x00000000},	{0xF4C, 0x0B000000},
+	{0xF50, 0x00000000},
+	{0xffff, 0xffffffff},
+};
+
+static const struct rtl8xxxu_reg32val rtl8192f_agc_table[] = {
+	{0xC78, 0x0FA0001F}, {0xC78, 0x0FA0011F},
+	{0xC78, 0x0FA0021F}, {0xC78, 0x0FA0031F},
+	{0xC78, 0x0FA0041F}, {0xC78, 0x0FA0051F},
+	{0xC78, 0x0F90061F}, {0xC78, 0x0F80071F},
+	{0xC78, 0x0F70081F}, {0xC78, 0x0F60091F},
+	{0xC78, 0x0F500A1F}, {0xC78, 0x0F400B1F},
+	{0xC78, 0x0F300C1F}, {0xC78, 0x0F200D1F},
+	{0xC78, 0x0F100E1F}, {0xC78, 0x0F000F1F},
+	{0xC78, 0x0EF0101F}, {0xC78, 0x0EE0111F},
+	{0xC78, 0x0ED0121F}, {0xC78, 0x0EC0131F},
+	{0xC78, 0x0EB0141F}, {0xC78, 0x0EA0151F},
+	{0xC78, 0x0E90161F}, {0xC78, 0x0E80171F},
+	{0xC78, 0x0E70181F}, {0xC78, 0x0E60191F},
+	{0xC78, 0x0E501A1F}, {0xC78, 0x0E401B1F},
+	{0xC78, 0x0E301C1F}, {0xC78, 0x0C701D1F},
+	{0xC78, 0x0C601E1F}, {0xC78, 0x0C501F1F},
+	{0xC78, 0x0C40201F}, {0xC78, 0x0C30211F},
+	{0xC78, 0x0A60221F}, {0xC78, 0x0A50231F},
+	{0xC78, 0x0A40241F}, {0xC78, 0x0A30251F},
+	{0xC78, 0x0860261F}, {0xC78, 0x0850271F},
+	{0xC78, 0x0840281F}, {0xC78, 0x0830291F},
+	{0xC78, 0x06702A1F}, {0xC78, 0x06602B1F},
+	{0xC78, 0x06502C1F}, {0xC78, 0x06402D1F},
+	{0xC78, 0x06302E1F}, {0xC78, 0x04602F1F},
+	{0xC78, 0x0450301F}, {0xC78, 0x0440311F},
+	{0xC78, 0x0430321F}, {0xC78, 0x0260331F},
+	{0xC78, 0x0250341F}, {0xC78, 0x0240351F},
+	{0xC78, 0x0230361F}, {0xC78, 0x0050371F},
+	{0xC78, 0x0040381F}, {0xC78, 0x0030391F},
+	{0xC78, 0x00203A1F}, {0xC78, 0x00103B1F},
+	{0xC78, 0x00003C1F}, {0xC78, 0x00003D1F},
+	{0xC78, 0x00003E1F}, {0xC78, 0x00003F1F},
+
+	{0xC78, 0x0FA0401F}, {0xC78, 0x0FA0411F},
+	{0xC78, 0x0FA0421F}, {0xC78, 0x0FA0431F},
+	{0xC78, 0x0F90441F}, {0xC78, 0x0F80451F},
+	{0xC78, 0x0F70461F}, {0xC78, 0x0F60471F},
+	{0xC78, 0x0F50481F}, {0xC78, 0x0F40491F},
+	{0xC78, 0x0F304A1F}, {0xC78, 0x0F204B1F},
+	{0xC78, 0x0F104C1F}, {0xC78, 0x0F004D1F},
+	{0xC78, 0x0EF04E1F}, {0xC78, 0x0EE04F1F},
+	{0xC78, 0x0ED0501F}, {0xC78, 0x0EC0511F},
+	{0xC78, 0x0EB0521F}, {0xC78, 0x0EA0531F},
+	{0xC78, 0x0E90541F}, {0xC78, 0x0E80551F},
+	{0xC78, 0x0E70561F}, {0xC78, 0x0E60571F},
+	{0xC78, 0x0E50581F}, {0xC78, 0x0E40591F},
+	{0xC78, 0x0E305A1F}, {0xC78, 0x0E205B1F},
+	{0xC78, 0x0E105C1F}, {0xC78, 0x0C505D1F},
+	{0xC78, 0x0C405E1F}, {0xC78, 0x0C305F1F},
+	{0xC78, 0x0C20601F}, {0xC78, 0x0C10611F},
+	{0xC78, 0x0A40621F}, {0xC78, 0x0A30631F},
+	{0xC78, 0x0A20641F}, {0xC78, 0x0A10651F},
+	{0xC78, 0x0840661F}, {0xC78, 0x0830671F},
+	{0xC78, 0x0820681F}, {0xC78, 0x0810691F},
+	{0xC78, 0x06506A1F}, {0xC78, 0x06406B1F},
+	{0xC78, 0x06306C1F}, {0xC78, 0x06206D1F},
+	{0xC78, 0x06106E1F}, {0xC78, 0x04406F1F},
+	{0xC78, 0x0430701F}, {0xC78, 0x0420711F},
+	{0xC78, 0x0410721F}, {0xC78, 0x0240731F},
+	{0xC78, 0x0230741F}, {0xC78, 0x0220751F},
+	{0xC78, 0x0210761F}, {0xC78, 0x0030771F},
+	{0xC78, 0x0020781F}, {0xC78, 0x0010791F},
+	{0xC78, 0x00007A1F}, {0xC78, 0x00007B1F},
+	{0xC78, 0x00007C1F}, {0xC78, 0x00007D1F},
+	{0xC78, 0x00007E1F}, {0xC78, 0x00007F1F},
+
+	{0xC78, 0x0FA0801F}, {0xC78, 0x0FA0811F},
+	{0xC78, 0x0FA0821F}, {0xC78, 0x0FA0831F},
+	{0xC78, 0x0FA0841F}, {0xC78, 0x0FA0851F},
+	{0xC78, 0x0F90861F}, {0xC78, 0x0F80871F},
+	{0xC78, 0x0F70881F}, {0xC78, 0x0F60891F},
+	{0xC78, 0x0F508A1F}, {0xC78, 0x0F408B1F},
+	{0xC78, 0x0F308C1F}, {0xC78, 0x0F208D1F},
+	{0xC78, 0x0F108E1F}, {0xC78, 0x0B908F1F},
+	{0xC78, 0x0B80901F}, {0xC78, 0x0B70911F},
+	{0xC78, 0x0B60921F}, {0xC78, 0x0B50931F},
+	{0xC78, 0x0B40941F}, {0xC78, 0x0B30951F},
+	{0xC78, 0x0B20961F}, {0xC78, 0x0B10971F},
+	{0xC78, 0x0B00981F}, {0xC78, 0x0AF0991F},
+	{0xC78, 0x0AE09A1F}, {0xC78, 0x0AD09B1F},
+	{0xC78, 0x0AC09C1F}, {0xC78, 0x0AB09D1F},
+	{0xC78, 0x0AA09E1F}, {0xC78, 0x0A909F1F},
+	{0xC78, 0x0A80A01F}, {0xC78, 0x0A70A11F},
+	{0xC78, 0x0A60A21F}, {0xC78, 0x0A50A31F},
+	{0xC78, 0x0A40A41F}, {0xC78, 0x0A30A51F},
+	{0xC78, 0x0A20A61F}, {0xC78, 0x0A10A71F},
+	{0xC78, 0x0A00A81F}, {0xC78, 0x0830A91F},
+	{0xC78, 0x0820AA1F}, {0xC78, 0x0810AB1F},
+	{0xC78, 0x0800AC1F}, {0xC78, 0x0640AD1F},
+	{0xC78, 0x0630AE1F}, {0xC78, 0x0620AF1F},
+	{0xC78, 0x0610B01F}, {0xC78, 0x0600B11F},
+	{0xC78, 0x0430B21F}, {0xC78, 0x0420B31F},
+	{0xC78, 0x0410B41F}, {0xC78, 0x0400B51F},
+	{0xC78, 0x0230B61F}, {0xC78, 0x0220B71F},
+	{0xC78, 0x0210B81F}, {0xC78, 0x0200B91F},
+	{0xC78, 0x0000BA1F}, {0xC78, 0x0000BB1F},
+	{0xC78, 0x0000BC1F}, {0xC78, 0x0000BD1F},
+	{0xC78, 0x0000BE1F}, {0xC78, 0x0000BF1F},
+	{0xC50, 0x00E48024}, {0xC50, 0x00E48020},
+	{0xffff, 0xffffffff}
+};
+
+static const struct rtl8xxxu_rfregval rtl8192fu_radioa_init_table[] = {
+	{0x00, 0x30000}, {0x18, 0x0FC07}, {0x81, 0x0FC00}, {0x82, 0x003C0},
+	{0x84, 0x00005}, {0x86, 0xA33A5}, {0x87, 0x00000}, {0x88, 0x58010},
+	{0x8E, 0x64540}, {0x8F, 0x282D8}, {0x51, 0x02C06}, {0x52, 0x7A007},
+	{0x53, 0x10061}, {0x54, 0x60018}, {0x55, 0x82020}, {0x56, 0x08CC6},
+	{0x57, 0x2CC00}, {0x58, 0x00000}, {0x5A, 0x50000}, {0x5B, 0x00006},
+	{0x5C, 0x00015}, {0x65, 0x20000}, {0x6E, 0x38319}, {0xF5, 0x43180},
+	{0xEF, 0x00002}, {0x33, 0x00301}, {0x33, 0x1032A}, {0x33, 0x2032A},
+	{0xEF, 0x00000}, {0xDF, 0x00002}, {0x35, 0x00000}, {0xF0, 0x08008},
+	{0xEF, 0x00800}, {0x33, 0x0040E}, {0x33, 0x04845}, {0x33, 0x08848},
+	{0x33, 0x0C84B}, {0x33, 0x1088A}, {0x33, 0x14C50}, {0x33, 0x18C8E},
+	{0x33, 0x1CCCD}, {0x33, 0x20CD0}, {0x33, 0x24CD3}, {0x33, 0x28CD6},
+	{0x33, 0x4002B}, {0x33, 0x4402E}, {0x33, 0x48846}, {0x33, 0x4C849},
+	{0x33, 0x50888}, {0x33, 0x54CC6}, {0x33, 0x58CC9}, {0x33, 0x5CCCC},
+	{0x33, 0x60CCF}, {0x33, 0x64CD2}, {0x33, 0x68CD5}, {0xEF, 0x00000},
+	{0xEF, 0x00400}, {0x33, 0x01C23}, {0x33, 0x05C23}, {0x33, 0x09D23},
+	{0x33, 0x0DD23}, {0x33, 0x11FA3}, {0x33, 0x15FA3}, {0x33, 0x19FAB},
+	{0x33, 0x1DFAB}, {0xEF, 0x00000}, {0xEF, 0x00200}, {0x33, 0x00030},
+	{0x33, 0x04030}, {0x33, 0x08030}, {0x33, 0x0C030}, {0x33, 0x10030},
+	{0x33, 0x14030}, {0x33, 0x18030}, {0x33, 0x1C030}, {0x33, 0x20030},
+	{0x33, 0x24030}, {0x33, 0x28030}, {0x33, 0x2C030}, {0x33, 0x30030},
+	{0x33, 0x34030}, {0x33, 0x38030}, {0x33, 0x3C030}, {0xEF, 0x00000},
+	{0xEF, 0x00100}, {0x33, 0x44001}, {0x33, 0x48001}, {0x33, 0x4C001},
+	{0x33, 0x50001}, {0x33, 0x54001}, {0x33, 0x58001}, {0x33, 0x5C001},
+	{0x33, 0x60001}, {0x33, 0x64001}, {0x33, 0x68001}, {0x33, 0x6C001},
+	{0x33, 0x70001}, {0x33, 0x74001}, {0x33, 0x78001}, {0x33, 0x04000},
+	{0x33, 0x08000}, {0x33, 0x0C000}, {0x33, 0x10000}, {0x33, 0x14000},
+	{0x33, 0x18001}, {0x33, 0x1C002}, {0x33, 0x20002}, {0x33, 0x24002},
+	{0x33, 0x28002}, {0x33, 0x2C002}, {0x33, 0x30002}, {0x33, 0x34002},
+	{0x33, 0x38002}, {0xEF, 0x00000}, {0x84, 0x00000}, {0xEF, 0x80010},
+	{0x30, 0x20000}, {0x31, 0x0006F}, {0x32, 0x01FF7}, {0xEF, 0x00000},
+	{0x84, 0x00000}, {0xEF, 0x80000}, {0x30, 0x30000}, {0x31, 0x0006F},
+	{0x32, 0xF1DF3}, {0xEF, 0x00000}, {0x84, 0x00000}, {0xEF, 0x80000},
+	{0x30, 0x38000}, {0x31, 0x0006F}, {0x32, 0xF1FF2}, {0xEF, 0x00000},
+	{0x1B, 0x746CE}, {0xEF, 0x20000}, {0x33, 0x30000}, {0x33, 0x38000},
+	{0x33, 0x70000}, {0x33, 0x78000}, {0xEF, 0x00000}, {0xDF, 0x08000},
+	{0xB0, 0xFFBCB}, {0xB3, 0x06000}, {0xB7, 0x18DF0}, {0xB8, 0x38FF0},
+	{0xC9, 0x00600}, {0xDF, 0x00000}, {0xB1, 0x33B8F}, {0xB2, 0x33762},
+	{0xB4, 0x141F0}, {0xB5, 0x14080}, {0xB6, 0x12425}, {0xB9, 0xC0008},
+	{0xBA, 0x40005}, {0xC2, 0x02C01}, {0xC3, 0x0000B}, {0xC4, 0x81E2F},
+	{0xC5, 0x5C28F}, {0xC6, 0x000A0}, {0xCA, 0x02000}, {0xFE, 0x00000},
+	{0x18, 0x08C07}, {0xFE, 0x00000}, {0xFE, 0x00000}, {0xFE, 0x00000},
+	{0x00, 0x31DD5},
+	{0xff, 0xffffffff}
+};
+
+static const struct rtl8xxxu_rfregval rtl8192fu_radiob_init_table[] = {
+	{0x00, 0x30000}, {0x81, 0x0FC00}, {0x82, 0x003C0}, {0x84, 0x00005},
+	{0x86, 0xA33A5}, {0x87, 0x00000}, {0x88, 0x58010}, {0x8E, 0x64540},
+	{0x8F, 0x282D8}, {0x51, 0x02C06}, {0x52, 0x7A007}, {0x53, 0x10061},
+	{0x54, 0x60018}, {0x55, 0x82020}, {0x56, 0x08CC6}, {0x57, 0x2CC00},
+	{0x58, 0x00000}, {0x5A, 0x50000}, {0x5B, 0x00006}, {0x5C, 0x00015},
+	{0x65, 0x20000}, {0x6E, 0x38319}, {0xF5, 0x43180}, {0xEF, 0x00002},
+	{0x33, 0x00301}, {0x33, 0x1032A}, {0x33, 0x2032A}, {0xEF, 0x00000},
+	{0xDF, 0x00002}, {0x35, 0x00000}, {0xF0, 0x08008}, {0xEF, 0x00800},
+	{0x33, 0x0040E}, {0x33, 0x04845}, {0x33, 0x08848}, {0x33, 0x0C84B},
+	{0x33, 0x1088A}, {0x33, 0x14CC8}, {0x33, 0x18CCB}, {0x33, 0x1CCCE},
+	{0x33, 0x20CD1}, {0x33, 0x24CD4}, {0x33, 0x28CD7}, {0x33, 0x4002B},
+	{0x33, 0x4402E}, {0x33, 0x48846}, {0x33, 0x4C849}, {0x33, 0x50888},
+	{0x33, 0x54CC6}, {0x33, 0x58CC9}, {0x33, 0x5CCCC}, {0x33, 0x60CCF},
+	{0x33, 0x64CD2}, {0x33, 0x68CD5}, {0xEF, 0x00000}, {0xEF, 0x00400},
+	{0x33, 0x01D23}, {0x33, 0x05D23}, {0x33, 0x09FA3}, {0x33, 0x0DFA3},
+	{0x33, 0x11D2B}, {0x33, 0x15D2B}, {0x33, 0x19FAB}, {0x33, 0x1DFAB},
+	{0xEF, 0x00000}, {0xEF, 0x00200}, {0x33, 0x00030}, {0x33, 0x04030},
+	{0x33, 0x08030}, {0x33, 0x0C030}, {0x33, 0x10030}, {0x33, 0x14030},
+	{0x33, 0x18030}, {0x33, 0x1C030}, {0x33, 0x20030}, {0x33, 0x24030},
+	{0x33, 0x28030}, {0x33, 0x2C030}, {0x33, 0x30030}, {0x33, 0x34030},
+	{0x33, 0x38030}, {0x33, 0x3C030}, {0xEF, 0x00000}, {0xEF, 0x00100},
+	{0x33, 0x44000}, {0x33, 0x48000}, {0x33, 0x4C000}, {0x33, 0x50000},
+	{0x33, 0x54000}, {0x33, 0x58000}, {0x33, 0x5C000}, {0x33, 0x60000},
+	{0x33, 0x64000}, {0x33, 0x68000}, {0x33, 0x6C000}, {0x33, 0x70000},
+	{0x33, 0x74000}, {0x33, 0x78000}, {0x33, 0x04000}, {0x33, 0x08000},
+	{0x33, 0x0C000}, {0x33, 0x10000}, {0x33, 0x14000}, {0x33, 0x18000},
+	{0x33, 0x1C001}, {0x33, 0x20001}, {0x33, 0x24001}, {0x33, 0x28001},
+	{0x33, 0x2C001}, {0x33, 0x30001}, {0x33, 0x34001}, {0x33, 0x38001},
+	{0xEF, 0x00000}, {0x84, 0x00000}, {0xEF, 0x80010}, {0x30, 0x20000},
+	{0x31, 0x0006F}, {0x32, 0x01FF7}, {0xEF, 0x00000}, {0x84, 0x00000},
+	{0xEF, 0x80000}, {0x30, 0x30000}, {0x31, 0x0006F}, {0x32, 0xF1DF3},
+	{0xEF, 0x00000}, {0x84, 0x00000}, {0xEF, 0x80000}, {0x30, 0x38000},
+	{0x31, 0x0006F}, {0x32, 0xF1FF2}, {0xEF, 0x00000}, {0x1B, 0x746CE},
+	{0xEF, 0x20000}, {0x33, 0x30000}, {0x33, 0x38000}, {0x33, 0x70000},
+	{0x33, 0x78000}, {0xEF, 0x00000}, {0x00, 0x31DD5},
+	{0xff, 0xffffffff}
+};
+
+static int rtl8192fu_identify_chip(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+	u32 sys_cfg, vendor, val32;
+
+	strscpy(priv->chip_name, "8192FU", sizeof(priv->chip_name));
+	priv->rtl_chip = RTL8192F;
+	priv->rf_paths = 2;
+	priv->rx_paths = 2;
+	priv->tx_paths = 2;
+
+	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
+	priv->chip_cut = u32_get_bits(sys_cfg, SYS_CFG_CHIP_VERSION_MASK);
+	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
+		dev_info(dev, "Unsupported test chip\n");
+		return -EOPNOTSUPP;
+	}
+
+	val32 = rtl8xxxu_read32(priv, REG_MULTI_FUNC_CTRL);
+	priv->has_wifi = u32_get_bits(val32, MULTI_WIFI_FUNC_EN);
+	priv->has_bluetooth = u32_get_bits(val32, MULTI_BT_FUNC_EN);
+	priv->has_gps = u32_get_bits(val32, MULTI_GPS_FUNC_EN);
+	priv->is_multi_func = 1;
+
+	vendor = sys_cfg & SYS_CFG_VENDOR_ID;
+	rtl8xxxu_identify_vendor_1bit(priv, vendor);
+
+	val32 = rtl8xxxu_read32(priv, REG_GPIO_OUTSTS);
+	priv->rom_rev = u32_get_bits(val32, GPIO_RF_RL_ID);
+
+	return rtl8xxxu_config_endpoints_no_sie(priv);
+}
+
+static void
+rtl8192f_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
+{
+	u8 cck, ofdmbase, mcsbase;
+	u32 val32, ofdm, mcs;
+	int group, cck_group;
+
+	rtl8188f_channel_to_group(channel, &group, &cck_group);
+
+	cck = priv->cck_tx_power_index_A[cck_group];
+
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_A_CCK1_MCS32, 0x00007f00, cck);
+
+	val32 = (cck << 16) | (cck << 8) | cck;
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_B_CCK11_A_CCK2_11,
+			      0x7f7f7f00, val32);
+
+	ofdmbase = priv->ht40_1s_tx_power_index_A[group];
+	ofdmbase += priv->ofdm_tx_power_diff[RF_A].a;
+	ofdm = ofdmbase | ofdmbase << 8 | ofdmbase << 16 | ofdmbase << 24;
+
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_A_RATE18_06, 0x7f7f7f7f, ofdm);
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_A_RATE54_24, 0x7f7f7f7f, ofdm);
+
+	mcsbase = priv->ht40_1s_tx_power_index_A[group];
+	if (ht40)
+		mcsbase += priv->ht40_tx_power_diff[RF_A].a;
+	else
+		mcsbase += priv->ht20_tx_power_diff[RF_A].a;
+	mcs = mcsbase | mcsbase << 8 | mcsbase << 16 | mcsbase << 24;
+
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_A_MCS03_MCS00, 0x7f7f7f7f, mcs);
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_A_MCS07_MCS04, 0x7f7f7f7f, mcs);
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_A_MCS11_MCS08, 0x7f7f7f7f, mcs);
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_A_MCS15_MCS12, 0x7f7f7f7f, mcs);
+
+	if (priv->tx_paths == 1)
+		return;
+
+	cck = priv->cck_tx_power_index_B[cck_group];
+
+	val32 = (cck << 16) | (cck << 8) | cck;
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_B_CCK1_55_MCS32,
+			      0x7f7f7f00, val32);
+
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_B_CCK11_A_CCK2_11,
+			      0x0000007f, cck);
+
+	ofdmbase = priv->ht40_1s_tx_power_index_B[group];
+	ofdmbase += priv->ofdm_tx_power_diff[RF_B].b;
+	ofdm = ofdmbase | ofdmbase << 8 | ofdmbase << 16 | ofdmbase << 24;
+
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_B_RATE18_06, 0x7f7f7f7f, ofdm);
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_B_RATE54_24, 0x7f7f7f7f, ofdm);
+
+	mcsbase = priv->ht40_1s_tx_power_index_B[group];
+	if (ht40)
+		mcsbase += priv->ht40_tx_power_diff[RF_B].b;
+	else
+		mcsbase += priv->ht20_tx_power_diff[RF_B].b;
+	mcs = mcsbase | mcsbase << 8 | mcsbase << 16 | mcsbase << 24;
+
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_B_MCS03_MCS00, 0x7f7f7f7f, mcs);
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_B_MCS07_MCS04, 0x7f7f7f7f, mcs);
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_B_MCS11_MCS08, 0x7f7f7f7f, mcs);
+	rtl8xxxu_write32_mask(priv, REG_TX_AGC_B_MCS15_MCS12, 0x7f7f7f7f, mcs);
+}
+
+static void rtl8192f_revise_cck_tx_psf(struct rtl8xxxu_priv *priv, u8 channel)
+{
+	if (channel == 13) {
+		/* Special value for channel 13 */
+		rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER1, 0xf8fe0001);
+		/* Normal values */
+		rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER2, 0x64B80C1C);
+		rtl8xxxu_write16(priv, REG_CCK0_DEBUG_PORT, 0x8810);
+		rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER3, 0x01235667);
+	} else if (channel == 14) {
+		/* Normal value */
+		rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER1, 0xE82C0001);
+		/* Special values for channel 14 */
+		rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER2, 0x0000B81C);
+		rtl8xxxu_write16(priv, REG_CCK0_DEBUG_PORT, 0x0000);
+		rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER3, 0x00003667);
+	} else {
+		/* Restore normal values from the phy init table */
+		rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER1, 0xE82C0001);
+		rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER2, 0x64B80C1C);
+		rtl8xxxu_write16(priv, REG_CCK0_DEBUG_PORT, 0x8810);
+		rtl8xxxu_write32(priv, REG_CCK0_TX_FILTER3, 0x01235667);
+	}
+}
+
+static void rtl8192fu_config_kfree(struct rtl8xxxu_priv *priv, u8 channel)
+{
+	u8 bb_gain[3] = { EFUSE_UNDEFINED, EFUSE_UNDEFINED, EFUSE_UNDEFINED };
+	u8 bb_gain_path_mask[2] = { 0x0f, 0xf0 };
+	enum rtl8xxxu_rfpath rfpath;
+	u8 bb_gain_for_path;
+	u8 channel_idx;
+
+	if (channel >= 1 && channel <= 3)
+		channel_idx = 0;
+	if (channel >= 4 && channel <= 9)
+		channel_idx = 1;
+	if (channel >= 10 && channel <= 14)
+		channel_idx = 2;
+
+	rtl8xxxu_read_efuse8(priv, 0x1ee, &bb_gain[1]);
+	rtl8xxxu_read_efuse8(priv, 0x1ec, &bb_gain[0]);
+	rtl8xxxu_read_efuse8(priv, 0x1ea, &bb_gain[2]);
+
+	if (bb_gain[1] == EFUSE_UNDEFINED)
+		return;
+
+	if (bb_gain[0] == EFUSE_UNDEFINED)
+		bb_gain[0] = bb_gain[1];
+
+	if (bb_gain[2] == EFUSE_UNDEFINED)
+		bb_gain[2] = bb_gain[1];
+
+	for (rfpath = RF_A; rfpath < priv->rf_paths; rfpath++) {
+		/* power_trim based on 55[19:14] */
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_UNKNOWN_55,
+					  BIT(5), 1);
+
+		/* enable 55[14] for 0.5db step */
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, 0xf5, BIT(18), 1);
+
+		/* enter power_trim debug mode */
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_UNKNOWN_DF,
+					  BIT(7), 1);
+
+		/* write enable */
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_WE_LUT, BIT(7), 1);
+
+		bb_gain_for_path = (bb_gain[channel_idx] & bb_gain_path_mask[rfpath])
+				 >> __ffs(bb_gain_path_mask[rfpath]);
+
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_TXPA_G3,
+					  0x70000, channel_idx * 2);
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_TXPA_G3,
+					  0x3f, bb_gain_for_path);
+
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_TXPA_G3,
+					  0x70000, channel_idx * 2 + 1);
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_TXPA_G3,
+					  0x3f, bb_gain_for_path);
+
+		/* leave power_trim debug mode */
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_UNKNOWN_DF,
+					  BIT(7), 0);
+
+		/* write disable */
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_WE_LUT, BIT(7), 0);
+	}
+}
+
+static void rtl8192fu_config_channel(struct ieee80211_hw *hw)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+	bool ht40 = conf_is_ht40(&hw->conf);
+	u8 channel, subchannel = 0;
+	bool sec_ch_above = 0;
+	u32 val32;
+
+	channel = (u8)hw->conf.chandef.chan->hw_value;
+
+	if (conf_is_ht40_plus(&hw->conf)) {
+		sec_ch_above = 1;
+		channel += 2;
+		subchannel = 2;
+	} else if (conf_is_ht40_minus(&hw->conf)) {
+		sec_ch_above = 0;
+		channel -= 2;
+		subchannel = 1;
+	}
+
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_MODE_AG);
+
+	rtl8192f_revise_cck_tx_psf(priv, channel);
+
+	/* Set channel */
+	val32 &= ~(BIT(18) | BIT(17)); /* select the 2.4G band(?) */
+	u32p_replace_bits(&val32, channel, 0xff);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_MODE_AG, val32);
+	if (priv->rf_paths > 1)
+		rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_MODE_AG, val32);
+
+	rtl8192fu_config_kfree(priv, channel);
+
+	rtl8xxxu_write8(priv, REG_DATA_SUBCHANNEL, subchannel);
+
+	/* small BW */
+	rtl8xxxu_write32_clear(priv, REG_OFDM0_TX_PSDO_NOISE_WEIGHT, GENMASK(31, 30));
+
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_RF_MODE, FPGA_RF_MODE, ht40);
+	rtl8xxxu_write32_mask(priv, REG_FPGA1_RF_MODE, FPGA_RF_MODE, ht40);
+
+	/* ADC clock = 160M */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_RF_MODE, GENMASK(10, 8), 4);
+
+	/* DAC clock = 80M */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_RF_MODE, BIT(13) | BIT(12), 2);
+
+	/* ADC buffer clk */
+	rtl8xxxu_write32_mask(priv, REG_ANTDIV_PARA1, BIT(27) | BIT(26), 2);
+
+	if (ht40)
+		/* Set Control channel to upper or lower. */
+		rtl8xxxu_write32_mask(priv, REG_CCK0_SYSTEM,
+				      CCK0_SIDEBAND, !sec_ch_above);
+
+	/* Enable CCK */
+	rtl8xxxu_write32_set(priv, REG_FPGA0_RF_MODE, FPGA_RF_MODE_CCK);
+
+	/* RF TRX_BW */
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_MODE_AG);
+	val32 &= ~MODE_AG_BW_MASK;
+	if (ht40)
+		val32 |= MODE_AG_BW_40MHZ_8723B;
+	else
+		val32 |= MODE_AG_BW_20MHZ_8723B;
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_MODE_AG, val32);
+	if (priv->rf_paths > 1)
+		rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_MODE_AG, val32);
+
+	/* Modify RX DFIR parameters */
+	rtl8xxxu_write32_mask(priv, REG_TAP_UPD_97F, BIT(21) | BIT(20), 2);
+
+	rtl8xxxu_write32_mask(priv, REG_DOWNSAM_FACTOR, BIT(29) | BIT(28), 2);
+
+	if (ht40)
+		val32 = 0x3;
+	else
+		val32 = 0x1a3;
+	rtl8xxxu_write32_mask(priv, REG_RX_DFIR_MOD_97F, 0x1ff, val32);
+}
+
+static void rtl8192fu_init_aggregation(struct rtl8xxxu_priv *priv)
+{
+	u32 agg_rx;
+	u8 agg_ctrl;
+
+	/* RX aggregation */
+	agg_ctrl = rtl8xxxu_read8(priv, REG_TRXDMA_CTRL);
+	agg_ctrl &= ~TRXDMA_CTRL_RXDMA_AGG_EN;
+
+	agg_rx = rtl8xxxu_read32(priv, REG_RXDMA_AGG_PG_TH);
+	agg_rx &= ~RXDMA_USB_AGG_ENABLE;
+	agg_rx &= ~0xFF0F; /* reset agg size and timeout */
+
+	rtl8xxxu_write8(priv, REG_TRXDMA_CTRL, agg_ctrl);
+	rtl8xxxu_write32(priv, REG_RXDMA_AGG_PG_TH, agg_rx);
+}
+
+static int rtl8192fu_parse_efuse(struct rtl8xxxu_priv *priv)
+{
+	struct rtl8192fu_efuse *efuse = &priv->efuse_wifi.efuse8192fu;
+	int i;
+
+	if (efuse->rtl_id != cpu_to_le16(0x8129))
+		return -EINVAL;
+
+	ether_addr_copy(priv->mac_addr, efuse->mac_addr);
+
+	memcpy(priv->cck_tx_power_index_A, efuse->tx_power_index_A.cck_base,
+	       sizeof(efuse->tx_power_index_A.cck_base));
+	memcpy(priv->cck_tx_power_index_B, efuse->tx_power_index_B.cck_base,
+	       sizeof(efuse->tx_power_index_B.cck_base));
+
+	memcpy(priv->ht40_1s_tx_power_index_A,
+	       efuse->tx_power_index_A.ht40_base,
+	       sizeof(efuse->tx_power_index_A.ht40_base));
+	memcpy(priv->ht40_1s_tx_power_index_B,
+	       efuse->tx_power_index_B.ht40_base,
+	       sizeof(efuse->tx_power_index_B.ht40_base));
+
+	priv->ht20_tx_power_diff[0].a =
+		efuse->tx_power_index_A.ht20_ofdm_1s_diff.b;
+	priv->ht20_tx_power_diff[0].b =
+		efuse->tx_power_index_B.ht20_ofdm_1s_diff.b;
+
+	priv->ht40_tx_power_diff[0].a = 0;
+	priv->ht40_tx_power_diff[0].b = 0;
+
+	for (i = 1; i < RTL8723B_TX_COUNT; i++) {
+		priv->ofdm_tx_power_diff[i].a =
+			efuse->tx_power_index_A.pwr_diff[i - 1].ofdm;
+		priv->ofdm_tx_power_diff[i].b =
+			efuse->tx_power_index_B.pwr_diff[i - 1].ofdm;
+
+		priv->ht20_tx_power_diff[i].a =
+			efuse->tx_power_index_A.pwr_diff[i - 1].ht20;
+		priv->ht20_tx_power_diff[i].b =
+			efuse->tx_power_index_B.pwr_diff[i - 1].ht20;
+
+		priv->ht40_tx_power_diff[i].a =
+			efuse->tx_power_index_A.pwr_diff[i - 1].ht40;
+		priv->ht40_tx_power_diff[i].b =
+			efuse->tx_power_index_B.pwr_diff[i - 1].ht40;
+	}
+
+	priv->default_crystal_cap = efuse->xtal_k & 0x3f;
+
+	priv->rfe_type = efuse->rfe_option & 0x1f;
+
+	if (priv->rfe_type != 5)
+		dev_warn(&priv->udev->dev,
+			 "%s: RFE type %d was not tested. Please send an email to linux-wireless@vger.kernel.org about this.\n",
+			 __func__, priv->rfe_type);
+
+	return 0;
+}
+
+static int rtl8192fu_load_firmware(struct rtl8xxxu_priv *priv)
+{
+	return rtl8xxxu_load_firmware(priv, "rtlwifi/rtl8192fufw.bin");
+}
+
+static void rtl8192fu_init_phy_bb(struct rtl8xxxu_priv *priv)
+{
+	/* Enable BB and RF */
+	rtl8xxxu_write16_set(priv, REG_SYS_FUNC,
+			     SYS_FUNC_BBRSTB | SYS_FUNC_BB_GLB_RSTN);
+
+	rtl8xxxu_write8(priv, REG_RF_CTRL, RF_ENABLE | RF_RSTB | RF_SDMRSTB);
+
+	/* To Fix MAC loopback mode fail. */
+	rtl8xxxu_write8(priv, REG_LDOHCI12_CTRL, 0xf);
+	rtl8xxxu_write8(priv, 0x15, 0xe9);
+
+	rtl8xxxu_init_phy_regs(priv, rtl8192fu_phy_init_table);
+
+	rtl8xxxu_init_phy_regs(priv, rtl8192f_agc_table);
+}
+
+static int rtl8192fu_init_phy_rf(struct rtl8xxxu_priv *priv)
+{
+	int ret;
+
+	ret = rtl8xxxu_init_phy_rf(priv, rtl8192fu_radioa_init_table, RF_A);
+	if (ret)
+		return ret;
+
+	return rtl8xxxu_init_phy_rf(priv, rtl8192fu_radiob_init_table, RF_B);
+}
+
+static void rtl8192f_phy_lc_calibrate(struct rtl8xxxu_priv *priv)
+{
+	u32 backup_mask = BIT(31) | BIT(30);
+	u32 backup;
+	u32 val32;
+
+	/* Aries's NarrowBand */
+	val32 = rtl8xxxu_read32(priv, REG_OFDM0_TX_PSDO_NOISE_WEIGHT);
+	backup = u32_get_bits(val32, backup_mask);
+
+	u32p_replace_bits(&val32, 0, backup_mask);
+	rtl8xxxu_write32(priv, REG_OFDM0_TX_PSDO_NOISE_WEIGHT, val32);
+
+	rtl8188f_phy_lc_calibrate(priv);
+
+	/* Aries's NarrowBand */
+	val32 = rtl8xxxu_read32(priv, REG_OFDM0_TX_PSDO_NOISE_WEIGHT);
+	u32p_replace_bits(&val32, backup, backup_mask);
+	rtl8xxxu_write32(priv, REG_OFDM0_TX_PSDO_NOISE_WEIGHT, val32);
+
+	/* reset OFDM state */
+	rtl8xxxu_write32_clear(priv, REG_FPGA0_RF_MODE, FPGA_RF_MODE_OFDM);
+	rtl8xxxu_write32_set(priv, REG_FPGA0_RF_MODE, FPGA_RF_MODE_OFDM);
+}
+
+static int rtl8192fu_iqk_path_a(struct rtl8xxxu_priv *priv)
+{
+	u32 reg_eac, reg_e94, reg_e9c, val32;
+	u32 rf_0x58_i, rf_0x58_q;
+	u8 rfe = priv->rfe_type;
+	int result = 0;
+	int ktime, i;
+
+	/* Leave IQK mode */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
+	rtl8xxxu_write32(priv, 0xd94, 0x44ffbb44);
+	rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x00400040);
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005403);
+	rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000804e4);
+	rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
+	rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
+
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(4), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
+	if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12)
+		val32 = 0x30;
+	else
+		val32 = 0xe9;
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x003ff, val32);
+
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
+
+	/* path-A IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x18008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x38008c1c);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK_PI_A, 0x8214000f);
+	rtl8xxxu_write32(priv, REG_RX_IQK_PI_A, 0x28140000);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK, 0x01007c00);
+	rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
+
+	/* LO calibration setting */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x00e62911);
+
+	/* One shot, path A LOK & IQK */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
+
+	mdelay(15);
+
+	ktime = 0;
+	while (rtl8xxxu_read32(priv, 0xe98) == 0 && ktime < 21) {
+		mdelay(5);
+		ktime += 5;
+	}
+
+	/* Check failed */
+	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
+	reg_e94 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_A);
+	reg_e9c = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_A);
+
+	/* reload 0xdf and CCK_IND off */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_WE_LUT, BIT(4), 1);
+
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, 0x58);
+	rf_0x58_i = u32_get_bits(val32, 0xfc000);
+	rf_0x58_q = u32_get_bits(val32, 0x003f0);
+
+	for (i = 0; i < 8; i++) {
+		rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_TXPA_G3,
+					  0x1c000, i);
+		rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_TXPA_G3,
+					  0x00fc0, rf_0x58_i);
+		rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_TXPA_G3,
+					  0x0003f, rf_0x58_q);
+	}
+
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_AC, BIT(14), 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_WE_LUT, BIT(4), 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x00810, 0);
+
+	if (!(reg_eac & BIT(28)) &&
+	    ((reg_e94 & 0x03ff0000) != 0x01420000) &&
+	    ((reg_e9c & 0x03ff0000) != 0x00420000))
+		result |= 0x01;
+
+	return result;
+}
+
+static int rtl8192fu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
+{
+	u32 reg_ea4, reg_eac, reg_e94, reg_e9c, val32;
+	int result = 0;
+	int ktime;
+
+	/* Leave IQK mode */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	/* PA/PAD control by 0x56, and set = 0x0 */
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
+	rtl8xxxu_write_rfreg(priv, RF_A, 0x35, 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x003ff, 0x27);
+
+	/* Enter IQK mode */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
+
+	/* path-A IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x18008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x38008c1c);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK_PI_A, 0x82160027);
+	rtl8xxxu_write32(priv, REG_RX_IQK_PI_A, 0x28160000);
+
+	/* Tx IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK, 0x01007c00);
+	rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
+
+	/* LO calibration setting */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x0086a911);
+
+	/* One shot, path A LOK & IQK */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
+
+	mdelay(15);
+
+	ktime = 0;
+	while (rtl8xxxu_read32(priv, 0xe98) == 0 && ktime < 21) {
+		mdelay(5);
+		ktime += 5;
+	}
+
+	/* Check failed */
+	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
+	reg_e94 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_A);
+	reg_e9c = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_A);
+
+	if (!(reg_eac & BIT(28)) &&
+	    ((reg_e94 & 0x03ff0000) != 0x01420000) &&
+	    ((reg_e9c & 0x03ff0000) != 0x00420000)) {
+		result |= 0x01;
+	} else { /* If TX not OK, ignore RX */
+		/* PA/PAD controlled by 0x0 */
+		rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+		rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF,
+					  BIT(11), 0);
+
+		return result;
+	}
+
+	val32 = 0x80007c00 | (reg_e94 & 0x3ff0000) | ((reg_e9c & 0x3ff0000) >> 16);
+	rtl8xxxu_write32(priv, REG_TX_IQK, val32);
+
+	/* Modify RX IQK mode table */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	/* PA/PAD control by 0x56, and set = 0x0 */
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
+	rtl8xxxu_write_rfreg(priv, RF_A, 0x35, 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x003ff, 0x1e0);
+
+	rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
+	rtl8xxxu_write32(priv, 0xd94, 0x44ffbb44);
+	rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x00400040);
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005403);
+	rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000804e4);
+	rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
+	rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
+
+	/* Enter IQK mode */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
+
+	/* path-A IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x18008c1c);
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x38008c1c);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK_PI_A, 0x82170000);
+	rtl8xxxu_write32(priv, REG_RX_IQK_PI_A, 0x28170000);
+
+	/* RX IQK setting */
+	rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
+
+	/* LO calibration setting */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x0046a8d1);
+
+	/* One shot, path A LOK & IQK */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
+
+	mdelay(15);
+
+	ktime = 0;
+	while (rtl8xxxu_read32(priv, 0xea8) == 0 && ktime < 21) {
+		mdelay(5);
+		ktime += 5;
+	}
+
+	/* Check failed */
+	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
+	reg_ea4 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_A_2);
+
+	/* Leave IQK mode */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 0);
+	rtl8xxxu_write_rfreg(priv, RF_A, 0x35, 0x02000);
+
+	if (!(reg_eac & BIT(27)) &&
+	    ((reg_ea4 & 0x03ff0000) != 0x01320000) &&
+	    ((reg_eac & 0x03ff0000) != 0x00360000))
+		result |= 0x02;
+
+	return result;
+}
+
+static int rtl8192fu_iqk_path_b(struct rtl8xxxu_priv *priv)
+{
+	u32 reg_eac, reg_eb4, reg_ebc, val32;
+	u32 rf_0x58_i, rf_0x58_q;
+	u8 rfe = priv->rfe_type;
+	int result = 0;
+	int ktime, i;
+
+	/* PA/PAD controlled by 0x0 */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
+	rtl8xxxu_write32(priv, 0xd94, 0x44ffbb44);
+	rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x00400040);
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005403);
+	rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000804e4);
+	rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
+	rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000000);
+
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(4), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
+	if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12)
+		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56,
+					  0x003ff, 0x30);
+	else
+		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56,
+					  0x00fff, 0xe9);
+
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
+
+	/* Path B IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x18008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x38008c1c);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK_PI_B, 0x8214000F);
+	rtl8xxxu_write32(priv, REG_RX_IQK_PI_B, 0x28140000);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK, 0x01007c00);
+	rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
+
+	/* LO calibration setting */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x00e62911);
+
+	/* One shot, path B LOK & IQK */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
+
+	mdelay(15);
+
+	ktime = 0;
+	while (rtl8xxxu_read32(priv, 0xeb8) == 0 && ktime < 21) {
+		mdelay(5);
+		ktime += 5;
+	}
+
+	/* Check failed */
+	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
+	reg_eb4 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_B);
+	reg_ebc = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_B);
+
+	/* reload 0xdf and CCK_IND off */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_WE_LUT, BIT(4), 1);
+
+	val32 = rtl8xxxu_read_rfreg(priv, RF_B, 0x58);
+	rf_0x58_i = u32_get_bits(val32, 0xfc000);
+	rf_0x58_q = u32_get_bits(val32, 0x003f0);
+
+	for (i = 0; i < 8; i++) {
+		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_TXPA_G3,
+					  0x1c000, i);
+		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_TXPA_G3,
+					  0x00fc0, rf_0x58_i);
+		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_TXPA_G3,
+					  0x0003f, rf_0x58_q);
+	}
+
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_AC, BIT(14), 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_WE_LUT, BIT(4), 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, 0x00810, 0);
+
+	if (!(reg_eac & BIT(31)) &&
+	    ((reg_eb4 & 0x03ff0000) != 0x01420000) &&
+	    ((reg_ebc & 0x03ff0000) != 0x00420000))
+		result |= 0x01;
+	else
+		dev_warn(&priv->udev->dev, "%s: Path B IQK failed!\n",
+			 __func__);
+
+	return result;
+}
+
+static int rtl8192fu_rx_iqk_path_b(struct rtl8xxxu_priv *priv)
+{
+	u32 reg_eac, reg_eb4, reg_ebc, reg_ec4, reg_ecc, val32;
+	int result = 0;
+	int ktime;
+
+	/* Leave IQK mode */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
+	rtl8xxxu_write_rfreg(priv, RF_B, 0x35, 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56, 0x003ff, 0x67);
+
+	rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
+	rtl8xxxu_write32(priv, 0xd94, 0x44ffbb44);
+	rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x00400040);
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005403);
+	rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000804e4);
+	rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
+	rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000000);
+
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
+
+	/* path-B IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x18008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x38008c1c);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK_PI_B, 0x82160027);
+	rtl8xxxu_write32(priv, REG_RX_IQK_PI_B, 0x28160000);
+
+	/* LO calibration setting */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x0086a911);
+
+	/* One shot, path A LOK & IQK */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
+
+	mdelay(15);
+
+	ktime = 0;
+	while (rtl8xxxu_read32(priv, 0xeb8) == 0 && ktime < 21) {
+		mdelay(5);
+		ktime += 5;
+	}
+
+	/* Check failed */
+	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
+	reg_eb4 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_B);
+	reg_ebc = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_B);
+
+	if (!(reg_eac & BIT(31)) &&
+	    ((reg_eb4 & 0x03ff0000) != 0x01420000) &&
+	    ((reg_ebc & 0x03ff0000) != 0x00420000)) {
+		result |= 0x01;
+	} else {
+		/* PA/PAD controlled by 0x0 */
+		rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF,
+					  BIT(11), 0);
+
+		return result;
+	}
+
+	val32 = 0x80007c00 | (reg_eb4 & 0x03ff0000) | ((reg_ebc >> 16) & 0x03ff);
+	rtl8xxxu_write32(priv, REG_TX_IQK, val32);
+
+	/* Modify RX IQK mode table */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
+	rtl8xxxu_write_rfreg(priv, RF_B, 0x35, 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56, 0x003ff, 0x1e0);
+
+	rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
+	rtl8xxxu_write32(priv, 0xd94, 0x44ffbb44);
+	rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x00400040);
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005403);
+	rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000804e4);
+	rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
+	rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000000);
+
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
+
+	/* Path B IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x38008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x18008c1c);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK_PI_B, 0x82170000);
+	rtl8xxxu_write32(priv, REG_RX_IQK_PI_B, 0x28170000);
+
+	/* IQK setting */
+	rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
+
+	/* LO calibration setting */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x0046a911);
+
+	/* One shot, path A LOK & IQK */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
+
+	mdelay(15);
+
+	ktime = 0;
+	while (rtl8xxxu_read32(priv, 0xec8) == 0 && ktime < 21) {
+		mdelay(5);
+		ktime += 5;
+	}
+
+	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
+	reg_ec4 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_B_2);
+	reg_ecc = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_B_2);
+
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+	rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
+
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(1), 0);
+	rtl8xxxu_write_rfreg(priv, RF_B, 0x35, 0x02000);
+
+	if (!(reg_eac & BIT(30)) &&
+	    ((reg_ec4 & 0x03ff0000) != 0x01320000) &&
+	    ((reg_ecc & 0x03ff0000) != 0x00360000))
+		result |= 0x02;
+	else
+		dev_warn(&priv->udev->dev, "%s: Path B RX IQK failed!\n",
+			 __func__);
+
+	return result;
+}
+
+static void rtl8192fu_phy_iqcalibrate(struct rtl8xxxu_priv *priv,
+				      int result[][8], int t)
+{
+	static const u32 adda_regs[2] = {
+		0xd94, REG_RX_WAIT_CCA
+	};
+	static const u32 iqk_mac_regs[RTL8XXXU_MAC_REGS] = {
+		REG_TXPAUSE, REG_BEACON_CTRL,
+		REG_BEACON_CTRL_1, REG_GPIO_MUXCFG
+	};
+	static const u32 iqk_bb_regs[RTL8XXXU_BB_REGS] = {
+		REG_OFDM0_TRX_PATH_ENABLE, REG_OFDM0_TR_MUX_PAR,
+		REG_FPGA0_XCD_RF_SW_CTRL, REG_CONFIG_ANT_A, REG_CONFIG_ANT_B,
+		REG_DPDT_CTRL, REG_RFE_CTRL_ANTA_SRC,
+		0x938, REG_CCK0_AFE_SETTING
+	};
+	u32 rx_initial_gain_a, rx_initial_gain_b;
+	struct device *dev = &priv->udev->dev;
+	int path_a_ok, path_b_ok;
+	u8 rfe = priv->rfe_type;
+	int retry = 2;
+	u32 i, val32;
+
+	/*
+	 * Note: IQ calibration must be performed after loading
+	 *       PHY_REG.txt , and radio_a, radio_b.txt
+	 */
+
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	rx_initial_gain_a = rtl8xxxu_read32(priv, REG_OFDM0_XA_AGC_CORE1);
+	rx_initial_gain_b = rtl8xxxu_read32(priv, REG_OFDM0_XB_AGC_CORE1);
+
+	if (t == 0) {
+		/* Save ADDA parameters, turn Path A ADDA on */
+		rtl8xxxu_save_regs(priv, adda_regs, priv->adda_backup,
+				   ARRAY_SIZE(adda_regs));
+		rtl8xxxu_save_mac_regs(priv, iqk_mac_regs, priv->mac_backup);
+		rtl8xxxu_save_regs(priv, iqk_bb_regs,
+				   priv->bb_backup, RTL8XXXU_BB_REGS);
+	}
+
+	/* Instead of rtl8xxxu_path_adda_on */
+	rtl8xxxu_write32_set(priv, REG_FPGA0_XCD_RF_PARM, BIT(31));
+
+	/* MAC settings */
+	rtl8xxxu_write8(priv, REG_TXPAUSE, 0xff);
+	rtl8xxxu_write8_clear(priv, REG_GPIO_MUXCFG, GPIO_MUXCFG_IO_SEL_ENBT);
+
+	if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12) {
+		/* in ePA IQK, rfe_func_config & SW both pull down */
+		/* path A */
+		rtl8xxxu_write32_mask(priv, REG_RFE_CTRL_ANTA_SRC, 0xF, 0x7);
+		rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x1, 0x0);
+
+		rtl8xxxu_write32_mask(priv, REG_RFE_CTRL_ANTA_SRC, 0xF00, 0x7);
+		rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x4, 0x0);
+
+		rtl8xxxu_write32_mask(priv, REG_RFE_CTRL_ANTA_SRC, 0xF000, 0x7);
+		rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x8, 0x0);
+
+		/* path B */
+		rtl8xxxu_write32_mask(priv, 0x938, 0xF0, 0x7);
+		rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x20000, 0x0);
+
+		rtl8xxxu_write32_mask(priv, 0x938, 0xF0000, 0x7);
+		rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x100000, 0x0);
+
+		rtl8xxxu_write32_mask(priv, 0x93c, 0xF000, 0x7);
+		rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x8000000, 0x0);
+	}
+
+	if (priv->rf_paths > 1) {
+		/* path B standby */
+		rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x000000);
+		rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_AC, 0x10000);
+		rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
+	}
+
+	for (i = 0; i < retry; i++) {
+		path_a_ok = rtl8192fu_iqk_path_a(priv);
+
+		if (path_a_ok == 0x01) {
+			val32 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_A);
+			result[t][0] = (val32 >> 16) & 0x3ff;
+
+			val32 = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_A);
+			result[t][1] = (val32 >> 16) & 0x3ff;
+			break;
+		} else {
+			result[t][0] = 0x100;
+			result[t][1] = 0x0;
+		}
+	}
+
+	for (i = 0; i < retry; i++) {
+		path_a_ok = rtl8192fu_rx_iqk_path_a(priv);
+
+		if (path_a_ok == 0x03) {
+			val32 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_A_2);
+			result[t][2] = (val32 >> 16) & 0x3ff;
+
+			val32 = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
+			result[t][3] = (val32 >> 16) & 0x3ff;
+			break;
+		} else {
+			result[t][2] = 0x100;
+			result[t][3] = 0x0;
+		}
+	}
+
+	if (!path_a_ok)
+		dev_warn(dev, "%s: Path A IQK failed!\n", __func__);
+
+	if (priv->rf_paths > 1) {
+		for (i = 0; i < retry; i++) {
+			path_b_ok = rtl8192fu_iqk_path_b(priv);
+
+			if (path_b_ok == 0x01) {
+				val32 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_B);
+				result[t][4] = (val32 >> 16) & 0x3ff;
+
+				val32 = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_B);
+				result[t][5] = (val32 >> 16) & 0x3ff;
+				break;
+			} else {
+				result[t][4] = 0x100;
+				result[t][5] = 0x0;
+			}
+		}
+
+		for (i = 0; i < retry; i++) {
+			path_b_ok = rtl8192fu_rx_iqk_path_b(priv);
+
+			if (path_b_ok == 0x03) {
+				val32 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_B_2);
+				result[t][6] = (val32 >> 16) & 0x3ff;
+
+				val32 = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_B_2);
+				result[t][7] = (val32 >> 16) & 0x3ff;
+				break;
+			} else {
+				result[t][6] = 0x100;
+				result[t][7] = 0x0;
+			}
+		}
+
+		if (!path_b_ok)
+			dev_warn(dev, "%s: Path B IQK failed!\n", __func__);
+	}
+
+	/* Back to BB mode, load original value */
+	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
+
+	rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xcc0000c0);
+
+	rtl8xxxu_write32(priv, 0xd94, 0x44bbbb44);
+	rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x80408040);
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005433);
+	rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000004e4);
+	rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04003400);
+	rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
+
+	/* Reload ADDA power saving parameters */
+	rtl8xxxu_restore_regs(priv, adda_regs, priv->adda_backup,
+			      ARRAY_SIZE(adda_regs));
+
+	/* Reload MAC parameters */
+	rtl8xxxu_restore_mac_regs(priv, iqk_mac_regs, priv->mac_backup);
+
+	/* Reload BB parameters */
+	rtl8xxxu_restore_regs(priv, iqk_bb_regs, priv->bb_backup, RTL8XXXU_BB_REGS);
+
+	rtl8xxxu_write32_clear(priv, REG_FPGA0_XCD_RF_PARM, BIT(31));
+
+	/* Restore RX initial gain */
+	rtl8xxxu_write32_mask(priv, REG_OFDM0_XA_AGC_CORE1, 0xff, 0x50);
+	rtl8xxxu_write32_mask(priv, REG_OFDM0_XA_AGC_CORE1, 0xff,
+			      rx_initial_gain_a & 0xff);
+	if (priv->rf_paths > 1) {
+		rtl8xxxu_write32_mask(priv, REG_OFDM0_XB_AGC_CORE1, 0xff, 0x50);
+		rtl8xxxu_write32_mask(priv, REG_OFDM0_XB_AGC_CORE1, 0xff,
+				      rx_initial_gain_b & 0xff);
+	}
+}
+
+static void rtl8192fu_phy_iq_calibrate(struct rtl8xxxu_priv *priv)
+{
+	s32 reg_e94, reg_e9c, reg_ea4, reg_eac;
+	s32 reg_eb4, reg_ebc, reg_ec4, reg_ecc;
+	struct device *dev = &priv->udev->dev;
+	u32 path_a_0xdf, path_a_0x35;
+	u32 path_b_0xdf, path_b_0x35;
+	bool path_a_ok, path_b_ok;
+	u8 rfe = priv->rfe_type;
+	u32 rfe_path_select;
+	int result[4][8]; /* last is final result */
+	int i, candidate;
+	s32 reg_tmp = 0;
+	bool simu;
+	u32 val32;
+
+	rfe_path_select = rtl8xxxu_read32(priv, REG_RFE_PATH_SELECT);
+
+	path_a_0xdf = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF);
+	path_a_0x35 = rtl8xxxu_read_rfreg(priv, RF_A, 0x35);
+	path_b_0xdf = rtl8xxxu_read_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF);
+	path_b_0x35 = rtl8xxxu_read_rfreg(priv, RF_B, 0x35);
+
+	memset(result, 0, sizeof(result));
+	candidate = -1;
+
+	path_a_ok = false;
+	path_b_ok = false;
+
+	for (i = 0; i < 3; i++) {
+		rtl8192fu_phy_iqcalibrate(priv, result, i);
+
+		if (i == 1) {
+			simu = rtl8xxxu_gen2_simularity_compare(priv, result, 0, 1);
+			if (simu) {
+				candidate = 0;
+				break;
+			}
+		}
+
+		if (i == 2) {
+			simu = rtl8xxxu_gen2_simularity_compare(priv, result, 0, 2);
+			if (simu) {
+				candidate = 0;
+				break;
+			}
+
+			simu = rtl8xxxu_gen2_simularity_compare(priv, result, 1, 2);
+			if (simu) {
+				candidate = 1;
+			} else {
+				for (i = 0; i < 8; i++)
+					reg_tmp += result[3][i];
+
+				if (reg_tmp)
+					candidate = 3;
+				else
+					candidate = -1;
+			}
+		}
+	}
+
+	if (candidate >= 0) {
+		reg_e94 = result[candidate][0];
+		reg_e9c = result[candidate][1];
+		reg_ea4 = result[candidate][2];
+		reg_eac = result[candidate][3];
+		reg_eb4 = result[candidate][4];
+		reg_ebc = result[candidate][5];
+		reg_ec4 = result[candidate][6];
+		reg_ecc = result[candidate][7];
+
+		dev_dbg(dev, "%s: candidate is %x\n", __func__, candidate);
+		dev_dbg(dev, "%s: e94=%x e9c=%x ea4=%x eac=%x eb4=%x ebc=%x ec4=%x ecc=%c\n",
+			__func__, reg_e94, reg_e9c, reg_ea4, reg_eac,
+			reg_eb4, reg_ebc, reg_ec4, reg_ecc);
+
+		path_a_ok = true;
+		path_b_ok = true;
+	}
+
+	rtl8xxxu_write32_mask(priv, REG_TX_IQK_TONE_A, 0x3ff00000, 0x100);
+	rtl8xxxu_write32_mask(priv, 0xe20, 0x3ff, 0);
+	rtl8xxxu_write32_mask(priv, REG_TX_IQK_TONE_B, 0x3ff00000, 0x100);
+	rtl8xxxu_write32_mask(priv, REG_TAP_UPD_97F, 0x3ff, 0);
+
+	if (candidate >= 0) {
+		if (reg_e94)
+			rtl8xxxu_fill_iqk_matrix_a(priv, path_a_ok, result,
+						   candidate, (reg_ea4 == 0));
+
+		if (reg_eb4)
+			rtl8xxxu_fill_iqk_matrix_b(priv, path_b_ok, result,
+						   candidate, (reg_ec4 == 0));
+	}
+
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, path_a_0xdf);
+	rtl8xxxu_write_rfreg(priv, RF_A, 0x35, path_a_0x35);
+	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF, path_b_0xdf);
+	rtl8xxxu_write_rfreg(priv, RF_B, 0x35, path_b_0x35);
+
+	if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12) {
+		rtl8xxxu_write32_set(priv, REG_SW_GPIO_SHARE_CTRL_1, 0x70000);
+		rtl8xxxu_write32_clear(priv, REG_LEDCFG0, 0x6c00000);
+		rtl8xxxu_write32_set(priv, REG_PAD_CTRL1, BIT(29) | BIT(28));
+		rtl8xxxu_write32_clear(priv, REG_SW_GPIO_SHARE_CTRL_0,
+				       0x600000 | BIT(4));
+
+		/*
+		 * Originally:
+		 * odm_set_bb_reg(dm, R_0x944, BIT(11) | 0x1F, 0x3F);
+		 *
+		 * It clears bit 11 and sets bits 0..4. The mask doesn't cover
+		 * bit 5 so it's not modified. Is that what it's supposed to
+		 * accomplish?
+		 */
+		val32 = rtl8xxxu_read32(priv, REG_RFE_BUFFER);
+		val32 &= ~BIT(11);
+		val32 |= 0x1f;
+		rtl8xxxu_write32(priv, REG_RFE_BUFFER, val32);
+
+		if (rfe == 7) {
+			rtl8xxxu_write32_mask(priv, REG_RFE_CTRL_ANTA_SRC,
+					      0xfffff, 0x23200);
+			rtl8xxxu_write32_mask(priv, 0x938, 0xfffff, 0x23200);
+			rtl8xxxu_write32_mask(priv, 0x934, 0xf000, 0x3);
+			rtl8xxxu_write32_mask(priv, 0x93c, 0xf000, 0x3);
+		} else {
+			rtl8xxxu_write32_mask(priv, REG_RFE_CTRL_ANTA_SRC,
+					      0xfffff, 0x22200);
+			rtl8xxxu_write32_mask(priv, 0x938, 0xfffff, 0x22200);
+			rtl8xxxu_write32_mask(priv, 0x934, 0xf000, 0x2);
+			rtl8xxxu_write32_mask(priv, 0x93c, 0xf000, 0x2);
+		}
+
+		rtl8xxxu_write32_clear(priv, 0x968, BIT(2));
+
+		if (rfe == 7)
+			rtl8xxxu_write32(priv, 0x920, 0x03000003);
+
+		rtl8xxxu_write32(priv, REG_RFE_PATH_SELECT, rfe_path_select);
+	}
+}
+
+static void rtl8192fu_disabled_to_emu(struct rtl8xxxu_priv *priv)
+{
+	rtl8xxxu_write16_clear(priv, REG_APS_FSMCO,
+			       APS_FSMCO_HW_POWERDOWN | APS_FSMCO_HW_SUSPEND);
+
+	rtl8xxxu_write32_clear(priv, REG_GPIO_INTM, BIT(16));
+
+	rtl8xxxu_write16_clear(priv, REG_APS_FSMCO,
+			       APS_FSMCO_PCIE | APS_FSMCO_HW_SUSPEND);
+}
+
+static int rtl8192fu_emu_to_active(struct rtl8xxxu_priv *priv)
+{
+	u32 val32;
+	u16 val16;
+	int count;
+
+	/* enable LDOA12 MACRO block for all interface */
+	rtl8xxxu_write8_set(priv, REG_LDOA15_CTRL, LDOA15_ENABLE);
+
+	/* disable BT_GPS_SEL pins */
+	rtl8xxxu_write32_clear(priv, REG_PAD_CTRL1, BIT(28));
+
+	mdelay(1);
+
+	/* release analog Ips to digital */
+	rtl8xxxu_write8_clear(priv, REG_SYS_ISO_CTRL, SYS_ISO_ANALOG_IPS);
+
+	val16 = APS_FSMCO_PCIE | APS_FSMCO_HW_SUSPEND | APS_FSMCO_SW_LPS;
+	rtl8xxxu_write16_clear(priv, REG_APS_FSMCO, val16);
+
+	/* wait till 0x04[17] = 1 power ready */
+	for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
+		val32 = rtl8xxxu_read32(priv, REG_APS_FSMCO);
+		if (val32 & BIT(17))
+			break;
+
+		udelay(10);
+	}
+
+	if (!count)
+		return -EBUSY;
+
+	rtl8xxxu_write32_set(priv, REG_APS_FSMCO, APS_FSMCO_WLON_RESET);
+
+	for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
+		val32 = rtl8xxxu_read32(priv, REG_APS_FSMCO);
+		if ((val32 & (APS_FSMCO_MAC_ENABLE | APS_FSMCO_MAC_OFF)) == 0)
+			break;
+
+		udelay(10);
+	}
+
+	if (!count)
+		return -EBUSY;
+
+	/* SWR OCP enable */
+	rtl8xxxu_write32_set(priv, REG_AFE_MISC, BIT(18));
+
+	rtl8xxxu_write16_clear(priv, REG_APS_FSMCO, APS_FSMCO_HW_POWERDOWN);
+
+	rtl8xxxu_write16_clear(priv, REG_APS_FSMCO,
+			       APS_FSMCO_PCIE | APS_FSMCO_HW_SUSPEND);
+
+	/* 0x7c[31]=1, LDO has max output capability */
+	rtl8xxxu_write32_set(priv, REG_LDO_SW_CTRL, BIT(31));
+
+	rtl8xxxu_write16_set(priv, REG_APS_FSMCO, APS_FSMCO_MAC_ENABLE);
+
+	for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
+		val32 = rtl8xxxu_read32(priv, REG_APS_FSMCO);
+		if ((val32 & APS_FSMCO_MAC_ENABLE) == 0)
+			break;
+
+		udelay(10);
+	}
+
+	if (!count)
+		return -EBUSY;
+
+	/* Enable WL control XTAL setting */
+	rtl8xxxu_write8_set(priv, REG_AFE_MISC, AFE_MISC_WL_XTAL_CTRL);
+
+	/* Enable falling edge triggering interrupt */
+	rtl8xxxu_write16_set(priv, REG_GPIO_INTM, GPIO_INTM_EDGE_TRIG_IRQ);
+
+	/* Enable GPIO9 data mode */
+	rtl8xxxu_write16_clear(priv, REG_GPIO_IO_SEL_2, GPIO_IO_SEL_2_GPIO09_IRQ);
+
+	/* Enable GPIO9 input mode */
+	rtl8xxxu_write16_clear(priv, REG_GPIO_IO_SEL_2, GPIO_IO_SEL_2_GPIO09_INPUT);
+
+	/* Enable HSISR GPIO[C:0] interrupt */
+	rtl8xxxu_write8_set(priv, REG_HSIMR, BIT(0));
+
+	/* RF HW ON/OFF Enable */
+	rtl8xxxu_write8_clear(priv, REG_MULTI_FUNC_CTRL, MULTI_WIFI_HW_ROF_EN);
+
+	/* Register Lock Disable */
+	rtl8xxxu_write8_set(priv, REG_RSV_CTRL, BIT(7));
+
+	/* For GPIO9 internal pull high setting */
+	rtl8xxxu_write16_set(priv, REG_MULTI_FUNC_CTRL, BIT(14));
+
+	/* reset RF path S1 */
+	rtl8xxxu_write8(priv, REG_RF_CTRL, 0);
+
+	/* reset RF path S0 */
+	rtl8xxxu_write8(priv, 0x7b, 0);
+
+	/* enable RF path S1 */
+	rtl8xxxu_write8(priv, REG_RF_CTRL, RF_SDMRSTB | RF_RSTB | RF_ENABLE);
+
+	/* enable RF path S0 */
+	rtl8xxxu_write8(priv, 0x7b, RF_SDMRSTB | RF_RSTB | RF_ENABLE);
+
+	/* AFE_Ctrl */
+	rtl8xxxu_write8_set(priv, 0x97, BIT(5));
+
+	/* AFE_Ctrl */
+	rtl8xxxu_write8(priv, 0xdc, 0xcc);
+
+	/* AFE_Ctrl 0x24[4:3]=00 for xtal gmn */
+	rtl8xxxu_write8_clear(priv, REG_AFE_XTAL_CTRL, BIT(4) | BIT(3));
+
+	/* GPIO_A[31:0] Pull down software register */
+	rtl8xxxu_write32(priv, 0x1050, 0xffffffff);
+
+	/* GPIO_B[7:0] Pull down software register */
+	rtl8xxxu_write8(priv, 0x105b, 0xff);
+
+	/* Register Lock Enable */
+	rtl8xxxu_write8_clear(priv, REG_RSV_CTRL, BIT(7));
+
+	return 0;
+}
+
+static int rtl8192fu_active_to_emu(struct rtl8xxxu_priv *priv)
+{
+	u32 val32;
+	int count;
+
+	/* Reset BB, RF enter Power Down mode */
+	rtl8xxxu_write8_clear(priv, REG_SYS_FUNC, SYS_FUNC_BBRSTB);
+
+	/* Enable rising edge triggering interrupt */
+	rtl8xxxu_write16_clear(priv, REG_GPIO_INTM, GPIO_INTM_EDGE_TRIG_IRQ);
+
+	/* release WLON reset */
+	rtl8xxxu_write32_set(priv, REG_APS_FSMCO, APS_FSMCO_WLON_RESET);
+
+	/* turn off MAC by HW state machine */
+	rtl8xxxu_write16_set(priv, REG_APS_FSMCO, APS_FSMCO_MAC_OFF);
+
+	for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
+		val32 = rtl8xxxu_read32(priv, REG_APS_FSMCO);
+		if ((val32 & APS_FSMCO_MAC_OFF) == 0)
+			break;
+
+		udelay(10);
+	}
+
+	if (!count)
+		return -EBUSY;
+
+	/* analog Ips to digital, 1:isolation */
+	rtl8xxxu_write8_set(priv, REG_SYS_ISO_CTRL, SYS_ISO_ANALOG_IPS);
+
+	/* disable LDOA12 MACRO block */
+	rtl8xxxu_write8_clear(priv, REG_LDOA15_CTRL, LDOA15_ENABLE);
+
+	return 0;
+}
+
+static int rtl8192fu_emu_to_disabled(struct rtl8xxxu_priv *priv)
+{
+	u16 val16;
+
+	/* SOP option to disable BG/MB */
+	rtl8xxxu_write8(priv, REG_APS_FSMCO + 3, 0x20);
+
+	/* 0x04[12:11] = 2b'01 enable WL suspend */
+	val16 = rtl8xxxu_read16(priv, REG_APS_FSMCO);
+	val16 &= ~APS_FSMCO_PCIE;
+	val16 |= APS_FSMCO_HW_SUSPEND;
+	rtl8xxxu_write16(priv, REG_APS_FSMCO, val16);
+
+	/* enable GPIO9 as EXT WAKEUP */
+	rtl8xxxu_write32_set(priv, REG_GPIO_INTM, BIT(16));
+
+	return 0;
+}
+
+static int rtl8192fu_active_to_lps(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+	u16 val16;
+	u32 val32;
+	int retry;
+
+	/* Tx Pause */
+	rtl8xxxu_write8(priv, REG_TXPAUSE, 0xff);
+
+	retry = 100;
+
+	/* Poll 32 bit wide REG_SCH_TX_CMD for 0 to ensure no TX is pending. */
+	do {
+		val32 = rtl8xxxu_read32(priv, REG_SCH_TX_CMD);
+		if (!val32)
+			break;
+
+		udelay(10);
+	} while (retry--);
+
+	if (!retry) {
+		dev_warn(dev, "%s: Failed to flush TX queue\n", __func__);
+		return -EBUSY;
+	}
+
+	/* Disable CCK and OFDM, clock gated */
+	rtl8xxxu_write8_clear(priv, REG_SYS_FUNC, SYS_FUNC_BBRSTB);
+
+	udelay(2);
+
+	/* Whole BB is reset */
+	rtl8xxxu_write8_clear(priv, REG_SYS_FUNC, SYS_FUNC_BB_GLB_RSTN);
+
+	/* Reset MAC TRX */
+	val16 = rtl8xxxu_read16(priv, REG_CR);
+	val16 &= 0xff00;
+	val16 |= CR_HCI_RXDMA_ENABLE | CR_HCI_TXDMA_ENABLE;
+	val16 &= ~CR_SECURITY_ENABLE;
+	rtl8xxxu_write16(priv, REG_CR, val16);
+
+	/* Respond TxOK to scheduler */
+	rtl8xxxu_write8_set(priv, REG_DUAL_TSF_RST, DUAL_TSF_TX_OK);
+
+	return 0;
+}
+
+static int rtl8192fu_power_on(struct rtl8xxxu_priv *priv)
+{
+	u16 val16;
+	int ret;
+
+	rtl8xxxu_write8(priv, REG_USB_ACCESS_TIMEOUT, 0x80);
+
+	rtl8192fu_disabled_to_emu(priv);
+
+	ret = rtl8192fu_emu_to_active(priv);
+	if (ret)
+		return ret;
+
+	rtl8xxxu_write16(priv, REG_CR, 0);
+
+	val16 = rtl8xxxu_read16(priv, REG_CR);
+
+	val16 |= CR_HCI_TXDMA_ENABLE | CR_HCI_RXDMA_ENABLE |
+		 CR_TXDMA_ENABLE | CR_RXDMA_ENABLE |
+		 CR_PROTOCOL_ENABLE | CR_SCHEDULE_ENABLE |
+		 CR_SECURITY_ENABLE | CR_CALTIMER_ENABLE;
+	rtl8xxxu_write16(priv, REG_CR, val16);
+
+	return 0;
+}
+
+static void rtl8192fu_power_off(struct rtl8xxxu_priv *priv)
+{
+	rtl8xxxu_flush_fifo(priv);
+
+	/* Stop Tx Report Timer. 0x4EC[Bit1]=b'0 */
+	rtl8xxxu_write8_clear(priv, REG_TX_REPORT_CTRL,
+			      TX_REPORT_CTRL_TIMER_ENABLE);
+
+	/* stop rx */
+	rtl8xxxu_write8(priv, REG_CR, 0x00);
+
+	rtl8192fu_active_to_lps(priv);
+
+	/* Reset Firmware if running in RAM */
+	if (rtl8xxxu_read8(priv, REG_MCU_FW_DL) & MCU_FW_RAM_SEL)
+		rtl8xxxu_firmware_self_reset(priv);
+
+	/* Reset MCU */
+	rtl8xxxu_write16_clear(priv, REG_SYS_FUNC, SYS_FUNC_CPU_ENABLE);
+
+	/* Reset MCU ready status */
+	rtl8xxxu_write8(priv, REG_MCU_FW_DL, 0x00);
+
+	rtl8192fu_active_to_emu(priv);
+	rtl8192fu_emu_to_disabled(priv);
+}
+
+static void rtl8192f_reset_8051(struct rtl8xxxu_priv *priv)
+{
+	rtl8xxxu_write8_clear(priv, REG_RSV_CTRL, BIT(1));
+
+	rtl8xxxu_write8_clear(priv, REG_RSV_CTRL + 1, BIT(0));
+
+	rtl8xxxu_write16_clear(priv, REG_SYS_FUNC, SYS_FUNC_CPU_ENABLE);
+
+	rtl8xxxu_write8_clear(priv, REG_RSV_CTRL, BIT(1));
+
+	rtl8xxxu_write8_set(priv, REG_RSV_CTRL + 1, BIT(0));
+
+	rtl8xxxu_write16_set(priv, REG_SYS_FUNC, SYS_FUNC_CPU_ENABLE);
+}
+
+static void rtl8192f_enable_rf(struct rtl8xxxu_priv *priv)
+{
+	u32 val32;
+
+	rtl8xxxu_write8(priv, REG_RF_CTRL, RF_ENABLE | RF_RSTB | RF_SDMRSTB);
+
+	val32 = rtl8xxxu_read32(priv, REG_OFDM0_TRX_PATH_ENABLE);
+	val32 &= ~(OFDM_RF_PATH_RX_MASK | OFDM_RF_PATH_TX_MASK);
+	val32 |= OFDM_RF_PATH_RX_A | OFDM_RF_PATH_RX_B |
+		 OFDM_RF_PATH_TX_A | OFDM_RF_PATH_TX_B;
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, val32);
+
+	rtl8xxxu_write8(priv, REG_TXPAUSE, 0x00);
+}
+
+static void rtl8192f_disable_rf(struct rtl8xxxu_priv *priv)
+{
+	u32 val32;
+
+	val32 = rtl8xxxu_read32(priv, REG_OFDM0_TRX_PATH_ENABLE);
+	val32 &= ~OFDM_RF_PATH_TX_MASK;
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, val32);
+
+	/* Power down RF module */
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_AC, 0);
+}
+
+static void rtl8192f_usb_quirks(struct rtl8xxxu_priv *priv)
+{
+	u16 val16;
+
+	rtl8xxxu_gen2_usb_quirks(priv);
+
+	val16 = rtl8xxxu_read16(priv, REG_CR);
+	val16 |= (CR_MAC_TX_ENABLE | CR_MAC_RX_ENABLE);
+	rtl8xxxu_write16(priv, REG_CR, val16);
+}
+
+#define XTAL1	GENMASK(6, 1)
+#define XTAL0	GENMASK(30, 25)
+
+static void rtl8192f_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
+{
+	struct rtl8xxxu_cfo_tracking *cfo = &priv->cfo_tracking;
+	u32 xtal1, xtal0;
+
+	if (crystal_cap == cfo->crystal_cap)
+		return;
+
+	xtal1 = rtl8xxxu_read32(priv, REG_AFE_PLL_CTRL);
+	xtal0 = rtl8xxxu_read32(priv, REG_AFE_XTAL_CTRL);
+
+	dev_dbg(&priv->udev->dev,
+		"%s: Adjusting crystal cap from 0x%x (actually 0x%x 0x%x) to 0x%x\n",
+		__func__,
+		cfo->crystal_cap,
+		u32_get_bits(xtal1, XTAL1),
+		u32_get_bits(xtal0, XTAL0),
+		crystal_cap);
+
+	u32p_replace_bits(&xtal1, crystal_cap, XTAL1);
+	u32p_replace_bits(&xtal0, crystal_cap, XTAL0);
+	rtl8xxxu_write32(priv, REG_AFE_PLL_CTRL, xtal1);
+	rtl8xxxu_write32(priv, REG_AFE_XTAL_CTRL, xtal0);
+
+	cfo->crystal_cap = crystal_cap;
+}
+
+static s8 rtl8192f_cck_rssi(struct rtl8xxxu_priv *priv, struct rtl8723au_phy_stats *phy_stats)
+{
+	struct jaguar2_phy_stats_type0 *phy_stats0 = (struct jaguar2_phy_stats_type0 *)phy_stats;
+	u8 lna_idx = (phy_stats0->lna_h << 3) | phy_stats0->lna_l;
+	u8 vga_idx = phy_stats0->vga;
+	s8 rx_pwr_all;
+
+	switch (lna_idx) {
+	case 7:
+		rx_pwr_all = -44 - (2 * vga_idx);
+		break;
+	case 5:
+		rx_pwr_all = -28 - (2 * vga_idx);
+		break;
+	case 3:
+		rx_pwr_all = -10 - (2 * vga_idx);
+		break;
+	case 0:
+		rx_pwr_all = 14 - (2 * vga_idx);
+		break;
+	default:
+		rx_pwr_all = 0;
+		break;
+	}
+
+	return rx_pwr_all;
+}
+
+static int rtl8192fu_led_brightness_set(struct led_classdev *led_cdev,
+					enum led_brightness brightness)
+{
+	struct rtl8xxxu_priv *priv = container_of(led_cdev,
+						  struct rtl8xxxu_priv,
+						  led_cdev);
+	u16 ledcfg;
+
+	/* Values obtained by observing the USB traffic from the Windows driver. */
+	rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_0, 0x20080);
+	rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_1, 0x1b0000);
+
+	if (brightness == LED_OFF) {
+		/* Value obtained like above. */
+		ledcfg = BIT(1) | BIT(7);
+	} else if (brightness == LED_ON) {
+		/* Value obtained like above. */
+		ledcfg = BIT(1) | BIT(7) | BIT(11);
+	} else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
+		/* Value obtained by brute force. */
+		ledcfg = BIT(8) | BIT(9);
+	}
+
+	rtl8xxxu_write16(priv, REG_LEDCFG0, ledcfg);
+
+	return 0;
+}
+
+struct rtl8xxxu_fileops rtl8192fu_fops = {
+	.identify_chip = rtl8192fu_identify_chip,
+	.parse_efuse = rtl8192fu_parse_efuse,
+	.load_firmware = rtl8192fu_load_firmware,
+	.power_on = rtl8192fu_power_on,
+	.power_off = rtl8192fu_power_off,
+	.read_efuse = rtl8xxxu_read_efuse,
+	.reset_8051 = rtl8192f_reset_8051,
+	.llt_init = rtl8xxxu_auto_llt_table,
+	.init_phy_bb = rtl8192fu_init_phy_bb,
+	.init_phy_rf = rtl8192fu_init_phy_rf,
+	.phy_lc_calibrate = rtl8192f_phy_lc_calibrate,
+	.phy_iq_calibrate = rtl8192fu_phy_iq_calibrate,
+	.config_channel = rtl8192fu_config_channel,
+	.parse_rx_desc = rtl8xxxu_parse_rxdesc24,
+	.parse_phystats = jaguar2_rx_parse_phystats,
+	.init_aggregation = rtl8192fu_init_aggregation,
+	.init_burst = rtl8xxxu_init_burst,
+	.enable_rf = rtl8192f_enable_rf,
+	.disable_rf = rtl8192f_disable_rf,
+	.usb_quirks = rtl8192f_usb_quirks,
+	.set_tx_power = rtl8192f_set_tx_power,
+	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
+	.report_connect = rtl8xxxu_gen2_report_connect,
+	.report_rssi = rtl8xxxu_gen2_report_rssi,
+	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
+	.set_crystal_cap = rtl8192f_set_crystal_cap,
+	.cck_rssi = rtl8192f_cck_rssi,
+	.led_classdev_brightness_set = rtl8192fu_led_brightness_set,
+	.writeN_block_size = 254,
+	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
+	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
+	.has_tx_report = 1,
+	.gen2_thermal_meter = 1,
+	.needs_full_init = 1,
+	.init_reg_rxfltmap = 1,
+	.init_reg_pkt_life_time = 1,
+	.init_reg_hmtfr = 1,
+	.ampdu_max_time = 0x5e,
+	.ustime_tsf_edca = 0x50,
+	.max_aggr_num = 0x1f1f,
+	.trxff_boundary = 0x3f3f,
+	.pbp_rx = PBP_PAGE_SIZE_256,
+	.pbp_tx = PBP_PAGE_SIZE_256,
+	.mactable = rtl8192f_mac_init_table,
+	.total_page_num = TX_TOTAL_PAGE_NUM_8192F,
+	.page_num_hi = TX_PAGE_NUM_HI_PQ_8192F,
+	.page_num_lo = TX_PAGE_NUM_LO_PQ_8192F,
+	.page_num_norm = TX_PAGE_NUM_NORM_PQ_8192F,
+};
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
index 22d4704dd31e..2990475100ec 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
@@ -1874,6 +1874,7 @@ struct rtl8xxxu_fileops rtl8710bu_fops = {
 	 * but in rtl8xxxu 0x50 causes slow upload and random packet loss. Why?
 	 */
 	.ustime_tsf_edca = 0x28,
+	.max_aggr_num = 0x0c14,
 	.adda_1t_init = 0x03c00016,
 	.adda_1t_path_on = 0x03c00016,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index abc56c7de6f7..a7ad62a8a7c6 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1741,6 +1741,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.init_reg_hmtfr = 1,
 	.ampdu_max_time = 0x5e,
 	.ustime_tsf_edca = 0x50,
+	.max_aggr_num = 0x0c14,
 	.adda_1t_init = 0x01c00014,
 	.adda_1t_path_on = 0x01c00014,
 	.adda_2t_path_on_a = 0x01c00014,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 1ce18dc8a41e..2c4648a8ed10 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -56,6 +56,7 @@ MODULE_FIRMWARE("rtlwifi/rtl8723bu_bt.bin");
 MODULE_FIRMWARE("rtlwifi/rtl8188fufw.bin");
 MODULE_FIRMWARE("rtlwifi/rtl8710bufw_SMIC.bin");
 MODULE_FIRMWARE("rtlwifi/rtl8710bufw_UMC.bin");
+MODULE_FIRMWARE("rtlwifi/rtl8192fufw.bin");
 
 module_param_named(debug, rtl8xxxu_debug, int, 0600);
 MODULE_PARM_DESC(debug, "Set debug mask");
@@ -2006,12 +2007,18 @@ static int rtl8xxxu_start_firmware(struct rtl8xxxu_priv *priv)
 static int rtl8xxxu_download_firmware(struct rtl8xxxu_priv *priv)
 {
 	int pages, remainder, i, ret;
+	u16 reg_fw_start_address;
 	u16 reg_mcu_fw_dl;
 	u8 val8;
 	u16 val16;
 	u32 val32;
 	u8 *fwptr;
 
+	if (priv->rtl_chip == RTL8192F)
+		reg_fw_start_address = REG_FW_START_ADDRESS_8192F;
+	else
+		reg_fw_start_address = REG_FW_START_ADDRESS;
+
 	if (priv->rtl_chip == RTL8710B) {
 		reg_mcu_fw_dl = REG_8051FW_CTRL_V1_8710B;
 	} else {
@@ -2067,7 +2074,7 @@ static int rtl8xxxu_download_firmware(struct rtl8xxxu_priv *priv)
 		val8 |= i;
 		rtl8xxxu_write8(priv, reg_mcu_fw_dl + 2, val8);
 
-		ret = rtl8xxxu_writeN(priv, REG_FW_START_ADDRESS,
+		ret = rtl8xxxu_writeN(priv, reg_fw_start_address,
 				      fwptr, RTL_FW_PAGE_SIZE);
 		if (ret != RTL_FW_PAGE_SIZE) {
 			ret = -EAGAIN;
@@ -2081,7 +2088,7 @@ static int rtl8xxxu_download_firmware(struct rtl8xxxu_priv *priv)
 		val8 = rtl8xxxu_read8(priv, reg_mcu_fw_dl + 2) & 0xF8;
 		val8 |= i;
 		rtl8xxxu_write8(priv, reg_mcu_fw_dl + 2, val8);
-		ret = rtl8xxxu_writeN(priv, REG_FW_START_ADDRESS,
+		ret = rtl8xxxu_writeN(priv, reg_fw_start_address,
 				      fwptr, remainder);
 		if (ret != remainder) {
 			ret = -EAGAIN;
@@ -2135,6 +2142,7 @@ int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, const char *fw_name)
 	case 0x2300:
 	case 0x88f0:
 	case 0x10b0:
+	case 0x92f0:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2581,6 +2589,7 @@ static int rtl8xxxu_init_queue_priority(struct rtl8xxxu_priv *priv)
 	u16 hiq, mgq, bkq, beq, viq, voq;
 	int hip, mgp, bkp, bep, vip, vop;
 	int ret = 0;
+	u32 val32;
 
 	switch (priv->ep_tx_count) {
 	case 1:
@@ -2663,15 +2672,28 @@ static int rtl8xxxu_init_queue_priority(struct rtl8xxxu_priv *priv)
 	 * queue here .... why?
 	 */
 	if (!ret) {
-		val16 = rtl8xxxu_read16(priv, REG_TRXDMA_CTRL);
-		val16 &= 0x7;
-		val16 |= (voq << TRXDMA_CTRL_VOQ_SHIFT) |
-			(viq << TRXDMA_CTRL_VIQ_SHIFT) |
-			(beq << TRXDMA_CTRL_BEQ_SHIFT) |
-			(bkq << TRXDMA_CTRL_BKQ_SHIFT) |
-			(mgq << TRXDMA_CTRL_MGQ_SHIFT) |
-			(hiq << TRXDMA_CTRL_HIQ_SHIFT);
-		rtl8xxxu_write16(priv, REG_TRXDMA_CTRL, val16);
+		/* Only RTL8192F seems to do it like this. */
+		if (priv->rtl_chip == RTL8192F) {
+			val32 = rtl8xxxu_read32(priv, REG_TRXDMA_CTRL);
+			val32 &= 0x7;
+			val32 |= (voq << TRXDMA_CTRL_VOQ_SHIFT_8192F) |
+				 (viq << TRXDMA_CTRL_VIQ_SHIFT_8192F) |
+				 (beq << TRXDMA_CTRL_BEQ_SHIFT_8192F) |
+				 (bkq << TRXDMA_CTRL_BKQ_SHIFT_8192F) |
+				 (mgq << TRXDMA_CTRL_MGQ_SHIFT_8192F) |
+				 (hiq << TRXDMA_CTRL_HIQ_SHIFT_8192F);
+			rtl8xxxu_write32(priv, REG_TRXDMA_CTRL, val32);
+		} else {
+			val16 = rtl8xxxu_read16(priv, REG_TRXDMA_CTRL);
+			val16 &= 0x7;
+			val16 |= (voq << TRXDMA_CTRL_VOQ_SHIFT) |
+				 (viq << TRXDMA_CTRL_VIQ_SHIFT) |
+				 (beq << TRXDMA_CTRL_BEQ_SHIFT) |
+				 (bkq << TRXDMA_CTRL_BKQ_SHIFT) |
+				 (mgq << TRXDMA_CTRL_MGQ_SHIFT) |
+				 (hiq << TRXDMA_CTRL_HIQ_SHIFT);
+			rtl8xxxu_write16(priv, REG_TRXDMA_CTRL, val16);
+		}
 
 		priv->pipe_out[TXDESC_QUEUE_VO] =
 			usb_sndbulkpipe(priv->udev, priv->out_ep[vop]);
@@ -2842,10 +2864,14 @@ void rtl8xxxu_fill_iqk_matrix_b(struct rtl8xxxu_priv *priv, bool iqk_ok,
 
 	reg = (result[candidate][7] >> 6) & 0xf;
 
-	val32 = rtl8xxxu_read32(priv, REG_OFDM0_AGCR_SSI_TABLE);
-	val32 &= ~0x0000f000;
-	val32 |= (reg << 12);
-	rtl8xxxu_write32(priv, REG_OFDM0_AGCR_SSI_TABLE, val32);
+	if (priv->rtl_chip == RTL8192F) {
+		val32 = rtl8xxxu_write32_mask(priv, 0xca8, 0x000000f0, reg);
+	} else {
+		val32 = rtl8xxxu_read32(priv, REG_OFDM0_AGCR_SSI_TABLE);
+		val32 &= ~0x0000f000;
+		val32 |= (reg << 12);
+		rtl8xxxu_write32(priv, REG_OFDM0_AGCR_SSI_TABLE, val32);
+	}
 }
 
 #define MAX_TOLERANCE		5
@@ -3944,13 +3970,14 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
 	val8 |= HT_SINGLE_AMPDU_ENABLE;
 	rtl8xxxu_write8(priv, REG_HT_SINGLE_AMPDU_8723B, val8);
 
-	rtl8xxxu_write16(priv, REG_MAX_AGGR_NUM, 0x0c14);
+	rtl8xxxu_write16(priv, REG_MAX_AGGR_NUM, priv->fops->max_aggr_num);
 	rtl8xxxu_write8(priv, REG_AMPDU_MAX_TIME_8723B,
 			priv->fops->ampdu_max_time);
 	rtl8xxxu_write32(priv, REG_AGGLEN_LMT, 0xffffffff);
 	rtl8xxxu_write8(priv, REG_RX_PKT_LIMIT, 0x18);
 	rtl8xxxu_write8(priv, REG_PIFS, 0x00);
-	if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8710B) {
+	if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8710B ||
+	    priv->rtl_chip == RTL8192F) {
 		rtl8xxxu_write8(priv, REG_FWHW_TXQ_CTRL, FWHW_TXQ_CTRL_AMPDU_RETRY);
 		rtl8xxxu_write32(priv, REG_FAST_EDCA_CTRL, 0x03086666);
 	}
@@ -4036,9 +4063,14 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	if (ret)
 		goto exit;
 
+	/* Mac APLL Setting */
+	if (priv->rtl_chip == RTL8192F)
+		rtl8xxxu_write16_set(priv, REG_AFE_CTRL4, BIT(4) | BIT(15));
+
 	/* RFSW Control - clear bit 14 ?? */
 	if (priv->rtl_chip != RTL8723B && priv->rtl_chip != RTL8192E &&
-	    priv->rtl_chip != RTL8188E && priv->rtl_chip != RTL8710B)
+	    priv->rtl_chip != RTL8188E && priv->rtl_chip != RTL8710B &&
+	    priv->rtl_chip != RTL8192F)
 		rtl8xxxu_write32(priv, REG_FPGA0_TX_INFO, 0x00000003);
 
 	val32 = FPGA0_RF_TRSW | FPGA0_RF_TRSWB | FPGA0_RF_ANTSW |
@@ -4052,7 +4084,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 
 	/* 0x860[6:5]= 00 - why? - this sets antenna B */
 	if (priv->rtl_chip != RTL8192E && priv->rtl_chip != RTL8188E &&
-	    priv->rtl_chip != RTL8710B)
+	    priv->rtl_chip != RTL8710B && priv->rtl_chip != RTL8192F)
 		rtl8xxxu_write32(priv, REG_FPGA0_XA_RF_INT_OE, 0x66f60210);
 
 	if (!macpower) {
@@ -4126,7 +4158,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 			rtl8xxxu_write8(priv, 0xa3, val8);
 		}
 
-		if (priv->rtl_chip == RTL8710B)
+		if (priv->rtl_chip == RTL8710B || priv->rtl_chip == RTL8192F)
 			rtl8xxxu_write8(priv, REG_EARLY_MODE_CONTROL_8710B, 0);
 	}
 
@@ -4153,7 +4185,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		rtl8xxxu_write8(priv, REG_USB_SPECIAL_OPTION, val8);
 	} else if (priv->rtl_chip == RTL8710B) {
 		rtl8xxxu_write32(priv, REG_HIMR0_8710B, 0);
-	} else {
+	} else if (priv->rtl_chip != RTL8192F) {
 		/*
 		 * Enable all interrupts - not obvious USB needs to do this
 		 */
@@ -4241,7 +4273,8 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	val16 = BEACON_DISABLE_TSF_UPDATE | (BEACON_DISABLE_TSF_UPDATE << 8);
 	rtl8xxxu_write16(priv, REG_BEACON_CTRL, val16);
 	rtl8xxxu_write16(priv, REG_TBTT_PROHIBIT, 0x6404);
-	if (priv->rtl_chip != RTL8188F && priv->rtl_chip != RTL8710B)
+	if (priv->rtl_chip != RTL8188F && priv->rtl_chip != RTL8710B &&
+	    priv->rtl_chip != RTL8192F)
 		/* Firmware will control REG_DRVERLYINT when power saving is enable, */
 		/* so don't set this register on STA mode. */
 		rtl8xxxu_write8(priv, REG_DRIVER_EARLY_INT, DRIVER_EARLY_INT_TIME);
@@ -4292,7 +4325,8 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	/* Disable BAR - not sure if this has any effect on USB */
 	rtl8xxxu_write32(priv, REG_BAR_MODE_CTRL, 0x0201ffff);
 
-	if (priv->rtl_chip != RTL8188F && priv->rtl_chip != RTL8188E && priv->rtl_chip != RTL8710B)
+	if (priv->rtl_chip != RTL8188F && priv->rtl_chip != RTL8188E &&
+	    priv->rtl_chip != RTL8710B && priv->rtl_chip != RTL8192F)
 		rtl8xxxu_write16(priv, REG_FAST_EDCA_CTRL, 0);
 
 	if (fops->init_statistics)
@@ -4310,9 +4344,10 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		 * Reset USB mode switch setting
 		 */
 		rtl8xxxu_write8(priv, REG_ACLK_MON, 0x00);
-	} else if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8188E) {
+	} else if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8188E ||
+		   priv->rtl_chip == RTL8192F) {
 		/*
-		 * Init GPIO settings for 8188f, 8188e
+		 * Init GPIO settings for 8188f, 8188e, 8192f
 		 */
 		val8 = rtl8xxxu_read8(priv, REG_GPIO_MUXCFG);
 		val8 &= ~GPIO_MUXCFG_IO_SEL_ENBT;
@@ -5443,8 +5478,10 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	tx_desc->pkt_size = cpu_to_le16(pktlen);
 	tx_desc->pkt_offset = tx_desc_size;
 
-	tx_desc->txdw0 =
-		TXDESC_OWN | TXDESC_FIRST_SEGMENT | TXDESC_LAST_SEGMENT;
+	/* These bits mean different things to the RTL8192F. */
+	if (priv->rtl_chip != RTL8192F)
+		tx_desc->txdw0 =
+			TXDESC_OWN | TXDESC_FIRST_SEGMENT | TXDESC_LAST_SEGMENT;
 	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
 	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
 		tx_desc->txdw0 |= TXDESC_BROADMULTICAST;
@@ -5511,7 +5548,7 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	rtl8xxxu_calc_tx_desc_csum(tx_desc);
 
 	/* avoid zero checksum make tx hang */
-	if (priv->rtl_chip == RTL8710B)
+	if (priv->rtl_chip == RTL8710B || priv->rtl_chip == RTL8192F)
 		tx_desc->csum = ~tx_desc->csum;
 
 	usb_fill_bulk_urb(&tx_urb->urb, priv->udev, priv->pipe_out[queue],
@@ -7275,6 +7312,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		case 0xf179:
 		case 0x8179:
 		case 0xb711:
+		case 0xf192:
 			untested = 0;
 			break;
 		}
@@ -7560,6 +7598,16 @@ static const struct usb_device_id dev_table[] = {
 /* TOTOLINK N150UA V5 / N150UA-B */
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x2005, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8710bu_fops},
+/* Comfast CF-826F */
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0xf192, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192fu_fops},
+/* Asus USB-N13 rev C1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x18f1, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192fu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xb722, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192fu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x318b, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192fu_fops},
 #ifdef CONFIG_RTL8XXXU_UNTESTED
 /* Still supported by rtlwifi */
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8176, 0xff, 0xff, 0xff),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 4dffbab494c3..b7be889ecb89 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -390,6 +390,12 @@
 #define  TRXDMA_CTRL_BKQ_SHIFT		10
 #define  TRXDMA_CTRL_MGQ_SHIFT		12
 #define  TRXDMA_CTRL_HIQ_SHIFT		14
+#define  TRXDMA_CTRL_VOQ_SHIFT_8192F	4
+#define  TRXDMA_CTRL_VIQ_SHIFT_8192F	7
+#define  TRXDMA_CTRL_BEQ_SHIFT_8192F	10
+#define  TRXDMA_CTRL_BKQ_SHIFT_8192F	13
+#define  TRXDMA_CTRL_MGQ_SHIFT_8192F	16
+#define  TRXDMA_CTRL_HIQ_SHIFT_8192F	19
 #define  TRXDMA_QUEUE_LOW		1
 #define  TRXDMA_QUEUE_NORMAL		2
 #define  TRXDMA_QUEUE_HIGH		3
@@ -973,6 +979,7 @@
 #define REG_RFE_PATH_SELECT		0x0940	/* 8723BU */
 #define REG_RFE_BUFFER			0x0944	/* 8723BU */
 #define REG_S0S1_PATH_SWITCH		0x0948	/* 8723BU */
+#define REG_RX_DFIR_MOD_97F		0x0948
 #define REG_OFDM_RX_DFIR		0x954
 
 #define REG_CCK0_SYSTEM			0x0a00
@@ -1033,6 +1040,8 @@
 
 #define REG_OFDM0_FA_RSTC		0x0c0c
 
+#define REG_DOWNSAM_FACTOR		0x0c10
+
 #define REG_OFDM0_XA_RX_AFE		0x0c10
 #define REG_OFDM0_XA_RX_IQ_IMBALANCE	0x0c14
 #define REG_OFDM0_XB_RX_IQ_IMBALANCE	0x0c1c
@@ -1096,6 +1105,8 @@
 #define REG_TX_AGC_A_MCS11_MCS08	0x0e18
 #define REG_TX_AGC_A_MCS15_MCS12	0x0e1c
 
+#define REG_TAP_UPD_97F			0x0e24
+
 #define REG_FPGA0_IQK			0x0e28
 
 #define REG_TX_IQK_TONE_A		0x0e30
@@ -1147,6 +1158,10 @@
 #define REG_PMPD_ANAEN			0x0eec
 
 #define REG_FW_START_ADDRESS		0x1000
+#define REG_FW_START_ADDRESS_8192F	0x4000
+
+#define REG_SW_GPIO_SHARE_CTRL_0	0x1038
+#define REG_SW_GPIO_SHARE_CTRL_1	0x103c
 
 #define REG_USB_INFO			0xfe17
 #define REG_USB_HIMR			0xfe38
-- 
2.39.2
