Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A624E64F93B
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiLQOSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiLQOSc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:18:32 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7C712601
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:18:27 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m18so12302364eji.5
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xml9btswSDKQL22W8w9PL74VONHWoOC7WUcqPD9NOO8=;
        b=gHbrt1opVmDc7JeIh7JAMZKgs5SYRGqDthgCMzAUDmzFuryCXf9D+OC1emNOgMyHr7
         I/owxEyso2T8hb8lKql0LbaebMnY1BFib8DDLaDrcfq/fyc4CcVPlJaqKikMVlluh61h
         UNpMh+9T5D9hymYXNSnW8YXraCWY3jazf2b6I3CiIa5jttkv/8JL5FRsIcybegaSCv/s
         LC7Wlnjx/AAhijK5fUIhbiHUvx2A43S8/xwSctL0VmuEaGjoV64yYwueyQ23pSP/e7qe
         yoQKkxRLqqMDPsIVQ1W8j1fjV6ko1s4WpEE4XBFY/jmZAYQhb5KuvGgA/to6t1p39Dnv
         SaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xml9btswSDKQL22W8w9PL74VONHWoOC7WUcqPD9NOO8=;
        b=pY18Q7bWhOVPl8f8vsFMk/GLqOuESY1uCfp9BbvTGb3JvcK8kkY9QacHudnLXcY5iY
         P6EyN4hVUgrSKAsCQ71iEBVOgCGEKlB0QgD+8wIqM3SduyZfcbBrhjKlQv2f9OS4icQS
         fwZ6NUVOxlwUZced3AtKRB/RhbL2RUv7qz2cJMbw7spfcdTZ0Kvsq0P4XjqI4n9WJx2o
         k1Wo1nA9g0CLcOVOTk4K09tNK+XglZIUJZG/Q1SMu97xrlL/yhey+JWlVbSha46S1Sv0
         TSkiZNdng7xt8Jgxi1Z37EfgdlkpQsfY6Trs7x5Ie2UmXrHY4BcOfrqNSbHhcEfOQNwP
         kD6w==
X-Gm-Message-State: ANoB5plfANETOhtFsHzOgKprQ9jx2TpKDyvlpoh+2gNdV8WTiFemwB0B
        mBRZ9r/IhrEQCdHiT1YX7gE/VCpntJw=
X-Google-Smtp-Source: AA0mqf6MMUe6n4Ty3bqLbB7OkCqWpLTXR7G3r3lgy/2g0OErA/j9OWrlJJr5nVxfoRzI7dWLFBW27g==
X-Received: by 2002:a17:906:d8b7:b0:7c4:f752:e959 with SMTP id qc23-20020a170906d8b700b007c4f752e959mr9636037ejb.33.1671286705232;
        Sat, 17 Dec 2022 06:18:25 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906b30300b007add28659b0sm2076926ejz.140.2022.12.17.06.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 06:18:24 -0800 (PST)
Message-ID: <3aad60f6-23f9-81e8-c741-4bd51e99f423@gmail.com>
Date:   Sat, 17 Dec 2022 16:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v3 4/5] wifi: rtl8xxxu: Support new chip RTL8188EU
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

From: Jes Sorensen <Jes.Sorensen@gmail.com>

This chip is found in cheap USB devices from TP-Link, D-Link, etc.

Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.

Chip versions older than "I cut" need software rate control. That will
be in the next commit. Until then MCS7 is used for all data frames.

The "I cut" chips are not supported. They require different firmware
and initialisation tables. Support can be added if someone has the
hardware to test it.

Co-developed-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Co-developed-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>
Co-developed-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
So this patch is 52 of the 57 patches found here, squashed together:
https://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git/log/drivers/net/wireless/realtek/rtl8xxxu?h=rtl8xxxu-8188eu

Starting from c3f84ded6f76 ("rtl8xxxu: Accept firmware signature 0x88e0")
up to a9b05c059510 ("rtl8xxxu: Add rpt_sel entry to struct rtl8xxxu_rxdesc16").

These patches were not needed:
3170622ccb61 ("rtl8xxxu: Detect 8188eu parts correctly")
8fb5bc92bce0 ("rtl8xxxu: Initialize GPIO settings for 8188eu")
6ab646adb585 ("rtl8xxxu: Implement rtl8188e_set_tx_power()")
2ccd1f1fc480 ("rtl8xxxu: properly detect RTL8188EU devices")
809a2e000cab ("rtl8xxxu: Do not set auto rate fallback on 8188eu")

On top of that, I made various changes required for today's kernel,
plus changes to match the newer vendor driver more closely, plus some
bug fixes.

v3:
 - Implement suggestion from Ping-Ke Shih:
   - Return -EOPNOTSUPP directly instead of using goto in
     rtl8188eu_identify_chip().
 - Remove set but not used variable ht in rtl8188eu_config_channel().
   Reported-by: kernel test robot <lkp@intel.com>

v2:
 - Implement suggestions from Ping-Ke Shih:
   - Add __packed to struct rtl8188eu_efuse.
   - Use u32p_replace_bits() in rtl8188eu_config_channel().
   - Make fw_name const char*.
   - Use the masks defined in patch 3/5 in rtl8188e_cck_rssi().
 - Use u32_get_bits() in assignment to bit field priv->pi_enabled.
 - Remove the efuse dumping code. It's not needed after patch 1/5.
 - Update the module description.
---
 drivers/net/wireless/realtek/rtl8xxxu/Kconfig |    2 +-
 .../net/wireless/realtek/rtl8xxxu/Makefile    |    3 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   67 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         | 1280 +++++++++++++++++
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    4 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  201 ++-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   40 +-
 7 files changed, 1572 insertions(+), 25 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/Kconfig b/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
index 631d078278be..091d3ad98093 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
+++ b/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
@@ -10,7 +10,7 @@ config RTL8XXXU
 	  parts written to utilize the Linux mac80211 stack.
 	  The driver is known to work with a number of RTL8723AU,
 	  RL8188CU, RTL8188RU, RTL8191CU, RTL8192CU, RTL8723BU, RTL8192EU,
-	  and RTL8188FU devices.
+	  RTL8188FU, and RTL8188EU devices.
 
 	  This driver is under development and has a limited feature
 	  set. In particular it does not yet support 40MHz channels
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/Makefile b/drivers/net/wireless/realtek/rtl8xxxu/Makefile
index c4ad5325f5e7..0cb58fb30228 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/Makefile
+++ b/drivers/net/wireless/realtek/rtl8xxxu/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_RTL8XXXU)	+= rtl8xxxu.o
 
 rtl8xxxu-y	:= rtl8xxxu_core.o rtl8xxxu_8192e.o rtl8xxxu_8723b.o \
-		   rtl8xxxu_8723a.o rtl8xxxu_8192c.o rtl8xxxu_8188f.o
+		   rtl8xxxu_8723a.o rtl8xxxu_8192c.o rtl8xxxu_8188f.o \
+		   rtl8xxxu_8188e.o
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 15bb2b5211a8..29f5dbee16b0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -36,6 +36,7 @@
 
 #define TX_TOTAL_PAGE_NUM		0xf8
 #define TX_TOTAL_PAGE_NUM_8188F		0xf7
+#define TX_TOTAL_PAGE_NUM_8188E		0xa9
 #define TX_TOTAL_PAGE_NUM_8192E		0xf3
 #define TX_TOTAL_PAGE_NUM_8723B		0xf7
 /* (HPQ + LPQ + NPQ + PUBQ) = TX_TOTAL_PAGE_NUM */
@@ -49,6 +50,11 @@
 #define TX_PAGE_NUM_LO_PQ_8188F		0x02
 #define TX_PAGE_NUM_NORM_PQ_8188F	0x02
 
+#define TX_PAGE_NUM_PUBQ_8188E		0x47
+#define TX_PAGE_NUM_HI_PQ_8188E		0x29
+#define TX_PAGE_NUM_LO_PQ_8188E		0x1c
+#define TX_PAGE_NUM_NORM_PQ_8188E	0x1c
+
 #define TX_PAGE_NUM_PUBQ_8192E		0xe7
 #define TX_PAGE_NUM_HI_PQ_8192E		0x08
 #define TX_PAGE_NUM_LO_PQ_8192E		0x0c
@@ -153,7 +159,8 @@ struct rtl8xxxu_rxdesc16 {
 	u32 htc:1;
 	u32 eosp:1;
 	u32 bssidfit:2;
-	u32 reserved1:16;
+	u32 rpt_sel:2;		/* 8188e */
+	u32 reserved1:14;
 	u32 unicastwake:1;
 	u32 magicwake:1;
 
@@ -211,7 +218,8 @@ struct rtl8xxxu_rxdesc16 {
 
 	u32 magicwake:1;
 	u32 unicastwake:1;
-	u32 reserved1:16;
+	u32 reserved1:14;
+	u32 rpt_sel:2;		/* 8188e */
 	u32 bssidfit:2;
 	u32 eosp:1;
 	u32 htc:1;
@@ -502,6 +510,8 @@ struct rtl8xxxu_txdesc40 {
 #define TXDESC_AMPDU_DENSITY_SHIFT	20
 #define TXDESC40_BT_INT			BIT(23)
 #define TXDESC40_GID_SHIFT		24
+#define TXDESC_ANTENNA_SELECT_A		BIT(24)
+#define TXDESC_ANTENNA_SELECT_B		BIT(25)
 
 /* Word 3 */
 #define TXDESC40_USE_DRIVER_RATE	BIT(8)
@@ -546,6 +556,10 @@ struct rtl8xxxu_txdesc40 {
 
 /* Word 6 */
 #define TXDESC_MAX_AGG_SHIFT		11
+#define TXDESC_USB_TX_AGG_SHIT		24
+
+/* Word 7 */
+#define TXDESC_ANTENNA_SELECT_C		BIT(29)
 
 /* Word 8 */
 #define TXDESC40_HW_SEQ_ENABLE		BIT(15)
@@ -912,6 +926,42 @@ struct rtl8188fu_efuse {
 	u8 res11[0xc3];
 };
 
+struct rtl8188eu_efuse {
+	__le16 rtl_id;
+	u8 res0[0x0e];
+	struct rtl8192eu_efuse_tx_power tx_power_index_A;	/* 0x10 */
+	u8 res1[0x7e];			/* 0x3a */
+	u8 channel_plan;		/* 0xb8 */
+	u8 xtal_k;
+	u8 thermal_meter;
+	u8 iqk_lck;
+	u8 res2[5];
+	u8 rf_board_option;
+	u8 rf_feature_option;
+	u8 rf_bt_setting;
+	u8 eeprom_version;
+	u8 eeprom_customer_id;
+	u8 res3[3];
+	u8 rf_antenna_option;		/* 0xc9 */
+	u8 res4[6];
+	u8 vid;				/* 0xd0 */
+	u8 res5[1];
+	u8 pid;				/* 0xd2 */
+	u8 res6[1];
+	u8 usb_optional_function;
+	u8 res7[2];
+	u8 mac_addr[ETH_ALEN];		/* 0xd7 */
+	u8 res8[2];
+	u8 vendor_name[7];
+	u8 res9[2];
+	u8 device_name[0x0b];		/* 0xe8 */
+	u8 res10[2];
+	u8 serial[0x0b];		/* 0xf5 */
+	u8 res11[0x30];
+	u8 unknown[0x0d];		/* 0x130 */
+	u8 res12[0xc3];
+} __packed;
+
 struct rtl8xxxu_reg8val {
 	u16 reg;
 	u8 val;
@@ -1435,6 +1485,7 @@ struct rtl8xxxu_priv {
 		struct rtl8192cu_efuse efuse8192;
 		struct rtl8192eu_efuse efuse8192eu;
 		struct rtl8188fu_efuse efuse8188fu;
+		struct rtl8188eu_efuse efuse8188eu;
 	} efuse_wifi;
 	u32 adda_backup[RTL8XXXU_ADDA_REGS];
 	u32 mac_backup[RTL8XXXU_MAC_REGS];
@@ -1526,6 +1577,7 @@ struct rtl8xxxu_fileops {
 	u8 page_num_hi;
 	u8 page_num_lo;
 	u8 page_num_norm;
+	u8 last_llt_entry;
 };
 
 extern int rtl8xxxu_debug;
@@ -1585,6 +1637,8 @@ void rtl8xxxu_gen1_phy_iq_calibrate(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen1_init_phy_bb(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv,
 				int channel, bool ht40);
+void rtl8188f_set_tx_power(struct rtl8xxxu_priv *priv,
+			   int channel, bool ht40);
 void rtl8xxxu_gen1_config_channel(struct ieee80211_hw *hw);
 void rtl8xxxu_gen2_config_channel(struct ieee80211_hw *hw);
 void rtl8xxxu_gen1_usb_quirks(struct rtl8xxxu_priv *priv);
@@ -1605,6 +1659,8 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv);
 int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb);
 int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb);
 int rtl8xxxu_gen2_channel_to_group(int channel);
+bool rtl8xxxu_simularity_compare(struct rtl8xxxu_priv *priv,
+				 int result[][8], int c1, int c2);
 bool rtl8xxxu_gen2_simularity_compare(struct rtl8xxxu_priv *priv,
 				      int result[][8], int c1, int c2);
 void rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
@@ -1617,13 +1673,20 @@ void rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			     struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
 			     bool short_preamble, bool ampdu_enable,
 			     u32 rts_rate);
+void rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
+			     struct ieee80211_tx_info *tx_info,
+			     struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
+			     bool short_preamble, bool ampdu_enable,
+			     u32 rts_rate);
 void rtl8723bu_set_ps_tdma(struct rtl8xxxu_priv *priv,
 			   u8 arg1, u8 arg2, u8 arg3, u8 arg4, u8 arg5);
 void rtl8723bu_phy_init_antenna_selection(struct rtl8xxxu_priv *priv);
 void rtl8723a_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap);
+void rtl8188f_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap);
 s8 rtl8723a_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt);
 
 extern struct rtl8xxxu_fileops rtl8188fu_fops;
+extern struct rtl8xxxu_fileops rtl8188eu_fops;
 extern struct rtl8xxxu_fileops rtl8192cu_fops;
 extern struct rtl8xxxu_fileops rtl8192eu_fops;
 extern struct rtl8xxxu_fileops rtl8723au_fops;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
new file mode 100644
index 000000000000..ae9a2bec1643
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -0,0 +1,1280 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RTL8XXXU mac80211 USB driver - 8188e specific subdriver
+ *
+ * Copyright (c) 2014 - 2016 Jes Sorensen <Jes.Sorensen@gmail.com>
+ *
+ * Portions, notably calibration code:
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This driver was written as a replacement for the vendor provided
+ * rtl8723au driver. As the Realtek 8xxx chips are very similar in
+ * their programming interface, I have started adding support for
+ * additional 8xxx chips like the 8192cu, 8188cus, etc.
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
+static const struct rtl8xxxu_reg8val rtl8188e_mac_init_table[] = {
+	{0x026, 0x41}, {0x027, 0x35}, {0x040, 0x00}, {0x421, 0x0f},
+	{0x428, 0x0a}, {0x429, 0x10}, {0x430, 0x00}, {0x431, 0x01},
+	{0x432, 0x02}, {0x433, 0x04}, {0x434, 0x05}, {0x435, 0x06},
+	{0x436, 0x07}, {0x437, 0x08}, {0x438, 0x00}, {0x439, 0x00},
+	{0x43a, 0x01}, {0x43b, 0x02}, {0x43c, 0x04}, {0x43d, 0x05},
+	{0x43e, 0x06}, {0x43f, 0x07}, {0x440, 0x5d}, {0x441, 0x01},
+	{0x442, 0x00}, {0x444, 0x15}, {0x445, 0xf0}, {0x446, 0x0f},
+	{0x447, 0x00}, {0x458, 0x41}, {0x459, 0xa8}, {0x45a, 0x72},
+	{0x45b, 0xb9}, {0x460, 0x66}, {0x461, 0x66}, {0x480, 0x08},
+	{0x4c8, 0xff}, {0x4c9, 0x08}, {0x4cc, 0xff}, {0x4cd, 0xff},
+	{0x4ce, 0x01}, {0x4d3, 0x01}, {0x500, 0x26}, {0x501, 0xa2},
+	{0x502, 0x2f}, {0x503, 0x00}, {0x504, 0x28}, {0x505, 0xa3},
+	{0x506, 0x5e}, {0x507, 0x00}, {0x508, 0x2b}, {0x509, 0xa4},
+	{0x50a, 0x5e}, {0x50b, 0x00}, {0x50c, 0x4f}, {0x50d, 0xa4},
+	{0x50e, 0x00}, {0x50f, 0x00}, {0x512, 0x1c}, {0x514, 0x0a},
+	{0x516, 0x0a}, {0x525, 0x4f}, {0x550, 0x10}, {0x551, 0x10},
+	{0x559, 0x02}, {0x55d, 0xff}, {0x605, 0x30}, {0x608, 0x0e},
+	{0x609, 0x2a}, {0x620, 0xff}, {0x621, 0xff}, {0x622, 0xff},
+	{0x623, 0xff}, {0x624, 0xff}, {0x625, 0xff}, {0x626, 0xff},
+	{0x627, 0xff}, {0x63c, 0x08}, {0x63d, 0x08}, {0x63e, 0x0c},
+	{0x63f, 0x0c}, {0x640, 0x40}, {0x652, 0x20}, {0x66e, 0x05},
+	{0x700, 0x21}, {0x701, 0x43}, {0x702, 0x65}, {0x703, 0x87},
+	{0x708, 0x21}, {0x709, 0x43}, {0x70a, 0x65}, {0x70b, 0x87},
+	{0xffff, 0xff},
+};
+
+static const struct rtl8xxxu_reg32val rtl8188eu_phy_init_table[] = {
+	{0x800, 0x80040000}, {0x804, 0x00000003},
+	{0x808, 0x0000fc00}, {0x80c, 0x0000000a},
+	{0x810, 0x10001331}, {0x814, 0x020c3d10},
+	{0x818, 0x02200385}, {0x81c, 0x00000000},
+	{0x820, 0x01000100}, {0x824, 0x00390204},
+	{0x828, 0x00000000}, {0x82c, 0x00000000},
+	{0x830, 0x00000000}, {0x834, 0x00000000},
+	{0x838, 0x00000000}, {0x83c, 0x00000000},
+	{0x840, 0x00010000}, {0x844, 0x00000000},
+	{0x848, 0x00000000}, {0x84c, 0x00000000},
+	{0x850, 0x00000000}, {0x854, 0x00000000},
+	{0x858, 0x569a11a9}, {0x85c, 0x01000014},
+	{0x860, 0x66f60110}, {0x864, 0x061f0649},
+	{0x868, 0x00000000}, {0x86c, 0x27272700},
+	{0x870, 0x07000760}, {0x874, 0x25004000},
+	{0x878, 0x00000808}, {0x87c, 0x00000000},
+	{0x880, 0xb0000c1c}, {0x884, 0x00000001},
+	{0x888, 0x00000000}, {0x88c, 0xccc000c0},
+	{0x890, 0x00000800}, {0x894, 0xfffffffe},
+	{0x898, 0x40302010}, {0x89c, 0x00706050},
+	{0x900, 0x00000000}, {0x904, 0x00000023},
+	{0x908, 0x00000000}, {0x90c, 0x81121111},
+	{0x910, 0x00000002}, {0x914, 0x00000201},
+	{0xa00, 0x00d047c8}, {0xa04, 0x80ff800c},
+	{0xa08, 0x8c838300}, {0xa0c, 0x2e7f120f},
+	{0xa10, 0x9500bb7e}, {0xa14, 0x1114d028},
+	{0xa18, 0x00881117}, {0xa1c, 0x89140f00},
+	{0xa20, 0x1a1b0000}, {0xa24, 0x090e1317},
+	{0xa28, 0x00000204}, {0xa2c, 0x00d30000},
+	{0xa70, 0x101fbf00}, {0xa74, 0x00000007},
+	{0xa78, 0x00000900}, {0xa7c, 0x225b0606},
+	{0xa80, 0x218075b1}, {0xb2c, 0x80000000},
+	{0xc00, 0x48071d40}, {0xc04, 0x03a05611},
+	{0xc08, 0x000000e4}, {0xc0c, 0x6c6c6c6c},
+	{0xc10, 0x08800000}, {0xc14, 0x40000100},
+	{0xc18, 0x08800000}, {0xc1c, 0x40000100},
+	{0xc20, 0x00000000}, {0xc24, 0x00000000},
+	{0xc28, 0x00000000}, {0xc2c, 0x00000000},
+	{0xc30, 0x69e9ac47}, {0xc34, 0x469652af},
+	{0xc38, 0x49795994}, {0xc3c, 0x0a97971c},
+	{0xc40, 0x1f7c403f}, {0xc44, 0x000100b7},
+	{0xc48, 0xec020107}, {0xc4c, 0x007f037f},
+	{0xc50, 0x69553420}, {0xc54, 0x43bc0094},
+	{0xc58, 0x00013169}, {0xc5c, 0x00250492},
+	{0xc60, 0x00000000}, {0xc64, 0x7112848b},
+	{0xc68, 0x47c00bff}, {0xc6c, 0x00000036},
+	{0xc70, 0x2c7f000d}, {0xc74, 0x020610db},
+	{0xc78, 0x0000001f}, {0xc7c, 0x00b91612},
+	{0xc80, 0x390000e4}, {0xc84, 0x21f60000},
+	{0xc88, 0x40000100}, {0xc8c, 0x20200000},
+	{0xc90, 0x00091521}, {0xc94, 0x00000000},
+	{0xc98, 0x00121820}, {0xc9c, 0x00007f7f},
+	{0xca0, 0x00000000}, {0xca4, 0x000300a0},
+	{0xca8, 0x00000000}, {0xcac, 0x00000000},
+	{0xcb0, 0x00000000}, {0xcb4, 0x00000000},
+	{0xcb8, 0x00000000}, {0xcbc, 0x28000000},
+	{0xcc0, 0x00000000}, {0xcc4, 0x00000000},
+	{0xcc8, 0x00000000}, {0xccc, 0x00000000},
+	{0xcd0, 0x00000000}, {0xcd4, 0x00000000},
+	{0xcd8, 0x64b22427}, {0xcdc, 0x00766932},
+	{0xce0, 0x00222222}, {0xce4, 0x00000000},
+	{0xce8, 0x37644302}, {0xcec, 0x2f97d40c},
+	{0xd00, 0x00000740}, {0xd04, 0x00020401},
+	{0xd08, 0x0000907f}, {0xd0c, 0x20010201},
+	{0xd10, 0xa0633333}, {0xd14, 0x3333bc43},
+	{0xd18, 0x7a8f5b6f}, {0xd2c, 0xcc979975},
+	{0xd30, 0x00000000}, {0xd34, 0x80608000},
+	{0xd38, 0x00000000}, {0xd3c, 0x00127353},
+	{0xd40, 0x00000000}, {0xd44, 0x00000000},
+	{0xd48, 0x00000000}, {0xd4c, 0x00000000},
+	{0xd50, 0x6437140a}, {0xd54, 0x00000000},
+	{0xd58, 0x00000282}, {0xd5c, 0x30032064},
+	{0xd60, 0x4653de68}, {0xd64, 0x04518a3c},
+	{0xd68, 0x00002101}, {0xd6c, 0x2a201c16},
+	{0xd70, 0x1812362e}, {0xd74, 0x322c2220},
+	{0xd78, 0x000e3c24}, {0xe00, 0x2d2d2d2d},
+	{0xe04, 0x2d2d2d2d}, {0xe08, 0x0390272d},
+	{0xe10, 0x2d2d2d2d}, {0xe14, 0x2d2d2d2d},
+	{0xe18, 0x2d2d2d2d}, {0xe1c, 0x2d2d2d2d},
+	{0xe28, 0x00000000}, {0xe30, 0x1000dc1f},
+	{0xe34, 0x10008c1f}, {0xe38, 0x02140102},
+	{0xe3c, 0x681604c2}, {0xe40, 0x01007c00},
+	{0xe44, 0x01004800}, {0xe48, 0xfb000000},
+	{0xe4c, 0x000028d1}, {0xe50, 0x1000dc1f},
+	{0xe54, 0x10008c1f}, {0xe58, 0x02140102},
+	{0xe5c, 0x28160d05}, {0xe60, 0x00000048},
+	{0xe68, 0x001b25a4}, {0xe6c, 0x00c00014},
+	{0xe70, 0x00c00014}, {0xe74, 0x01000014},
+	{0xe78, 0x01000014}, {0xe7c, 0x01000014},
+	{0xe80, 0x01000014}, {0xe84, 0x00c00014},
+	{0xe88, 0x01000014}, {0xe8c, 0x00c00014},
+	{0xed0, 0x00c00014}, {0xed4, 0x00c00014},
+	{0xed8, 0x00c00014}, {0xedc, 0x00000014},
+	{0xee0, 0x00000014}, {0xee8, 0x21555448},
+	{0xeec, 0x01c00014}, {0xf14, 0x00000003},
+	{0xf4c, 0x00000000}, {0xf00, 0x00000300},
+	{0xffff, 0xffffffff},
+};
+
+static const struct rtl8xxxu_reg32val rtl8188e_agc_table[] = {
+	{0xc78, 0xfb000001}, {0xc78, 0xfb010001},
+	{0xc78, 0xfb020001}, {0xc78, 0xfb030001},
+	{0xc78, 0xfb040001}, {0xc78, 0xfb050001},
+	{0xc78, 0xfa060001}, {0xc78, 0xf9070001},
+	{0xc78, 0xf8080001}, {0xc78, 0xf7090001},
+	{0xc78, 0xf60a0001}, {0xc78, 0xf50b0001},
+	{0xc78, 0xf40c0001}, {0xc78, 0xf30d0001},
+	{0xc78, 0xf20e0001}, {0xc78, 0xf10f0001},
+	{0xc78, 0xf0100001}, {0xc78, 0xef110001},
+	{0xc78, 0xee120001}, {0xc78, 0xed130001},
+	{0xc78, 0xec140001}, {0xc78, 0xeb150001},
+	{0xc78, 0xea160001}, {0xc78, 0xe9170001},
+	{0xc78, 0xe8180001}, {0xc78, 0xe7190001},
+	{0xc78, 0xe61a0001}, {0xc78, 0xe51b0001},
+	{0xc78, 0xe41c0001}, {0xc78, 0xe31d0001},
+	{0xc78, 0xe21e0001}, {0xc78, 0xe11f0001},
+	{0xc78, 0x8a200001}, {0xc78, 0x89210001},
+	{0xc78, 0x88220001}, {0xc78, 0x87230001},
+	{0xc78, 0x86240001}, {0xc78, 0x85250001},
+	{0xc78, 0x84260001}, {0xc78, 0x83270001},
+	{0xc78, 0x82280001}, {0xc78, 0x6b290001},
+	{0xc78, 0x6a2a0001}, {0xc78, 0x692b0001},
+	{0xc78, 0x682c0001}, {0xc78, 0x672d0001},
+	{0xc78, 0x662e0001}, {0xc78, 0x652f0001},
+	{0xc78, 0x64300001}, {0xc78, 0x63310001},
+	{0xc78, 0x62320001}, {0xc78, 0x61330001},
+	{0xc78, 0x46340001}, {0xc78, 0x45350001},
+	{0xc78, 0x44360001}, {0xc78, 0x43370001},
+	{0xc78, 0x42380001}, {0xc78, 0x41390001},
+	{0xc78, 0x403a0001}, {0xc78, 0x403b0001},
+	{0xc78, 0x403c0001}, {0xc78, 0x403d0001},
+	{0xc78, 0x403e0001}, {0xc78, 0x403f0001},
+	{0xc78, 0xfb400001}, {0xc78, 0xfb410001},
+	{0xc78, 0xfb420001}, {0xc78, 0xfb430001},
+	{0xc78, 0xfb440001}, {0xc78, 0xfb450001},
+	{0xc78, 0xfb460001}, {0xc78, 0xfb470001},
+	{0xc78, 0xfb480001}, {0xc78, 0xfa490001},
+	{0xc78, 0xf94a0001}, {0xc78, 0xf84b0001},
+	{0xc78, 0xf74c0001}, {0xc78, 0xf64d0001},
+	{0xc78, 0xf54e0001}, {0xc78, 0xf44f0001},
+	{0xc78, 0xf3500001}, {0xc78, 0xf2510001},
+	{0xc78, 0xf1520001}, {0xc78, 0xf0530001},
+	{0xc78, 0xef540001}, {0xc78, 0xee550001},
+	{0xc78, 0xed560001}, {0xc78, 0xec570001},
+	{0xc78, 0xeb580001}, {0xc78, 0xea590001},
+	{0xc78, 0xe95a0001}, {0xc78, 0xe85b0001},
+	{0xc78, 0xe75c0001}, {0xc78, 0xe65d0001},
+	{0xc78, 0xe55e0001}, {0xc78, 0xe45f0001},
+	{0xc78, 0xe3600001}, {0xc78, 0xe2610001},
+	{0xc78, 0xc3620001}, {0xc78, 0xc2630001},
+	{0xc78, 0xc1640001}, {0xc78, 0x8b650001},
+	{0xc78, 0x8a660001}, {0xc78, 0x89670001},
+	{0xc78, 0x88680001}, {0xc78, 0x87690001},
+	{0xc78, 0x866a0001}, {0xc78, 0x856b0001},
+	{0xc78, 0x846c0001}, {0xc78, 0x676d0001},
+	{0xc78, 0x666e0001}, {0xc78, 0x656f0001},
+	{0xc78, 0x64700001}, {0xc78, 0x63710001},
+	{0xc78, 0x62720001}, {0xc78, 0x61730001},
+	{0xc78, 0x60740001}, {0xc78, 0x46750001},
+	{0xc78, 0x45760001}, {0xc78, 0x44770001},
+	{0xc78, 0x43780001}, {0xc78, 0x42790001},
+	{0xc78, 0x417a0001}, {0xc78, 0x407b0001},
+	{0xc78, 0x407c0001}, {0xc78, 0x407d0001},
+	{0xc78, 0x407e0001}, {0xc78, 0x407f0001},
+	{0xc50, 0x69553422}, {0xc50, 0x69553420},
+	{0xffff, 0xffffffff}
+};
+
+static const struct rtl8xxxu_rfregval rtl8188eu_radioa_init_table[] = {
+	{0x00, 0x00030000}, {0x08, 0x00084000},
+	{0x18, 0x00000407}, {0x19, 0x00000012},
+	{0x1e, 0x00080009}, {0x1f, 0x00000880},
+	{0x2f, 0x0001a060}, {0x3f, 0x00000000},
+	{0x42, 0x000060c0}, {0x57, 0x000d0000},
+	{0x58, 0x000be180}, {0x67, 0x00001552},
+	{0x83, 0x00000000}, {0xb0, 0x000ff8fc},
+	{0xb1, 0x00054400}, {0xb2, 0x000ccc19},
+	{0xb4, 0x00043003}, {0xb6, 0x0004953e},
+	{0xb7, 0x0001c718}, {0xb8, 0x000060ff},
+	{0xb9, 0x00080001}, {0xba, 0x00040000},
+	{0xbb, 0x00000400}, {0xbf, 0x000c0000},
+	{0xc2, 0x00002400}, {0xc3, 0x00000009},
+	{0xc4, 0x00040c91}, {0xc5, 0x00099999},
+	{0xc6, 0x000000a3}, {0xc7, 0x00088820},
+	{0xc8, 0x00076c06}, {0xc9, 0x00000000},
+	{0xca, 0x00080000}, {0xdf, 0x00000180},
+	{0xef, 0x000001a0}, {0x51, 0x0006b27d},
+	{0x52, 0x0007e49d},	/* Set to 0x0007e4dd for SDIO */
+	{0x53, 0x00000073}, {0x56, 0x00051ff3},
+	{0x35, 0x00000086}, {0x35, 0x00000186},
+	{0x35, 0x00000286}, {0x36, 0x00001c25},
+	{0x36, 0x00009c25}, {0x36, 0x00011c25},
+	{0x36, 0x00019c25}, {0xb6, 0x00048538},
+	{0x18, 0x00000c07}, {0x5a, 0x0004bd00},
+	{0x19, 0x000739d0}, {0x34, 0x0000adf3},
+	{0x34, 0x00009df0}, {0x34, 0x00008ded},
+	{0x34, 0x00007dea}, {0x34, 0x00006de7},
+	{0x34, 0x000054ee}, {0x34, 0x000044eb},
+	{0x34, 0x000034e8}, {0x34, 0x0000246b},
+	{0x34, 0x00001468}, {0x34, 0x0000006d},
+	{0x00, 0x00030159}, {0x84, 0x00068200},
+	{0x86, 0x000000ce}, {0x87, 0x00048a00},
+	{0x8e, 0x00065540}, {0x8f, 0x00088000},
+	{0xef, 0x000020a0}, {0x3b, 0x000f02b0},
+	{0x3b, 0x000ef7b0}, {0x3b, 0x000d4fb0},
+	{0x3b, 0x000cf060}, {0x3b, 0x000b0090},
+	{0x3b, 0x000a0080}, {0x3b, 0x00090080},
+	{0x3b, 0x0008f780}, {0x3b, 0x000722b0},
+	{0x3b, 0x0006f7b0}, {0x3b, 0x00054fb0},
+	{0x3b, 0x0004f060}, {0x3b, 0x00030090},
+	{0x3b, 0x00020080}, {0x3b, 0x00010080},
+	{0x3b, 0x0000f780}, {0xef, 0x000000a0},
+	{0x00, 0x00010159}, {0x18, 0x0000f407},
+	{0xFE, 0x00000000}, {0xFE, 0x00000000},
+	{0x1F, 0x00080003}, {0xFE, 0x00000000},
+	{0xFE, 0x00000000}, {0x1E, 0x00000001},
+	{0x1F, 0x00080000}, {0x00, 0x00033e60},
+	{0xff, 0xffffffff}
+};
+
+static int rtl8188eu_identify_chip(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+	u32 sys_cfg, vendor;
+	int ret = 0;
+
+	strscpy(priv->chip_name, "8188EU", sizeof(priv->chip_name));
+	priv->rtl_chip = RTL8188E;
+	priv->rf_paths = 1;
+	priv->rx_paths = 1;
+	priv->tx_paths = 1;
+	priv->has_wifi = 1;
+
+	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
+	priv->chip_cut = u32_get_bits(sys_cfg, SYS_CFG_CHIP_VERSION_MASK);
+	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
+		dev_info(dev, "Unsupported test chip\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * TODO: At a glance, I cut requires a different firmware,
+	 * different initialisation tables, and no software rate
+	 * control. The vendor driver is not configured to handle
+	 * I cut chips by default. Are there any in the wild?
+	 */
+	if (priv->chip_cut == 8) {
+		dev_info(dev, "RTL8188EU cut I is not supported. Please complain about it at linux-wireless@vger.kernel.org.\n");
+		return -EOPNOTSUPP;
+	}
+
+	vendor = sys_cfg & SYS_CFG_VENDOR_ID;
+	rtl8xxxu_identify_vendor_1bit(priv, vendor);
+
+	ret = rtl8xxxu_config_endpoints_no_sie(priv);
+
+	return ret;
+}
+
+static void rtl8188eu_config_channel(struct ieee80211_hw *hw)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+	u32 val32, rsr;
+	u8 opmode;
+	int sec_ch_above, channel;
+	int i;
+
+	opmode = rtl8xxxu_read8(priv, REG_BW_OPMODE);
+	rsr = rtl8xxxu_read32(priv, REG_RESPONSE_RATE_SET);
+	channel = hw->conf.chandef.chan->hw_value;
+
+	switch (hw->conf.chandef.width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		opmode |= BW_OPMODE_20MHZ;
+		rtl8xxxu_write8(priv, REG_BW_OPMODE, opmode);
+
+		val32 = rtl8xxxu_read32(priv, REG_FPGA0_RF_MODE);
+		val32 &= ~FPGA_RF_MODE;
+		rtl8xxxu_write32(priv, REG_FPGA0_RF_MODE, val32);
+
+		val32 = rtl8xxxu_read32(priv, REG_FPGA1_RF_MODE);
+		val32 &= ~FPGA_RF_MODE;
+		rtl8xxxu_write32(priv, REG_FPGA1_RF_MODE, val32);
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		if (hw->conf.chandef.center_freq1 >
+		    hw->conf.chandef.chan->center_freq) {
+			sec_ch_above = 1;
+			channel += 2;
+		} else {
+			sec_ch_above = 0;
+			channel -= 2;
+		}
+
+		opmode &= ~BW_OPMODE_20MHZ;
+		rtl8xxxu_write8(priv, REG_BW_OPMODE, opmode);
+		rsr &= ~RSR_RSC_BANDWIDTH_40M;
+		if (sec_ch_above)
+			rsr |= RSR_RSC_LOWER_SUB_CHANNEL;
+		else
+			rsr |= RSR_RSC_UPPER_SUB_CHANNEL;
+		rtl8xxxu_write32(priv, REG_RESPONSE_RATE_SET, rsr);
+
+		val32 = rtl8xxxu_read32(priv, REG_FPGA0_RF_MODE);
+		val32 |= FPGA_RF_MODE;
+		rtl8xxxu_write32(priv, REG_FPGA0_RF_MODE, val32);
+
+		val32 = rtl8xxxu_read32(priv, REG_FPGA1_RF_MODE);
+		val32 |= FPGA_RF_MODE;
+		rtl8xxxu_write32(priv, REG_FPGA1_RF_MODE, val32);
+
+		/*
+		 * Set Control channel to upper or lower. These settings
+		 * are required only for 40MHz
+		 */
+		val32 = rtl8xxxu_read32(priv, REG_CCK0_SYSTEM);
+		val32 &= ~CCK0_SIDEBAND;
+		if (!sec_ch_above)
+			val32 |= CCK0_SIDEBAND;
+		rtl8xxxu_write32(priv, REG_CCK0_SYSTEM, val32);
+
+		val32 = rtl8xxxu_read32(priv, REG_OFDM1_LSTF);
+		val32 &= ~OFDM_LSTF_PRIME_CH_MASK; /* 0xc00 */
+		if (sec_ch_above)
+			val32 |= OFDM_LSTF_PRIME_CH_LOW;
+		else
+			val32 |= OFDM_LSTF_PRIME_CH_HIGH;
+		rtl8xxxu_write32(priv, REG_OFDM1_LSTF, val32);
+
+		val32 = rtl8xxxu_read32(priv, REG_FPGA0_POWER_SAVE);
+		val32 &= ~(FPGA0_PS_LOWER_CHANNEL | FPGA0_PS_UPPER_CHANNEL);
+		if (sec_ch_above)
+			val32 |= FPGA0_PS_UPPER_CHANNEL;
+		else
+			val32 |= FPGA0_PS_LOWER_CHANNEL;
+		rtl8xxxu_write32(priv, REG_FPGA0_POWER_SAVE, val32);
+		break;
+
+	default:
+		break;
+	}
+
+	for (i = RF_A; i < priv->rf_paths; i++) {
+		val32 = rtl8xxxu_read_rfreg(priv, i, RF6052_REG_MODE_AG);
+		u32p_replace_bits(&val32, channel, MODE_AG_CHANNEL_MASK);
+		rtl8xxxu_write_rfreg(priv, i, RF6052_REG_MODE_AG, val32);
+	}
+
+	for (i = RF_A; i < priv->rf_paths; i++) {
+		val32 = rtl8xxxu_read_rfreg(priv, i, RF6052_REG_MODE_AG);
+		val32 &= ~MODE_AG_BW_MASK;
+		if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40)
+			val32 |= MODE_AG_BW_40MHZ_8723B;
+		else
+			val32 |= MODE_AG_BW_20MHZ_8723B;
+		rtl8xxxu_write_rfreg(priv, i, RF6052_REG_MODE_AG, val32);
+	}
+}
+
+static void rtl8188eu_init_aggregation(struct rtl8xxxu_priv *priv)
+{
+	u8 agg_ctrl, usb_spec;
+
+	usb_spec = rtl8xxxu_read8(priv, REG_USB_SPECIAL_OPTION);
+	usb_spec &= ~USB_SPEC_USB_AGG_ENABLE;
+	rtl8xxxu_write8(priv, REG_USB_SPECIAL_OPTION, usb_spec);
+
+	agg_ctrl = rtl8xxxu_read8(priv, REG_TRXDMA_CTRL);
+	agg_ctrl &= ~TRXDMA_CTRL_RXDMA_AGG_EN;
+	rtl8xxxu_write8(priv, REG_TRXDMA_CTRL, agg_ctrl);
+}
+
+static int rtl8188eu_parse_efuse(struct rtl8xxxu_priv *priv)
+{
+	struct rtl8188eu_efuse *efuse = &priv->efuse_wifi.efuse8188eu;
+
+	if (efuse->rtl_id != cpu_to_le16(0x8129))
+		return -EINVAL;
+
+	ether_addr_copy(priv->mac_addr, efuse->mac_addr);
+
+	memcpy(priv->cck_tx_power_index_A, efuse->tx_power_index_A.cck_base,
+	       sizeof(efuse->tx_power_index_A.cck_base));
+
+	memcpy(priv->ht40_1s_tx_power_index_A,
+	       efuse->tx_power_index_A.ht40_base,
+	       sizeof(efuse->tx_power_index_A.ht40_base));
+
+	priv->default_crystal_cap = efuse->xtal_k & 0x3f;
+
+	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
+	dev_info(&priv->udev->dev, "Product: %.11s\n", efuse->device_name);
+	dev_info(&priv->udev->dev, "Serial: %.11s\n", efuse->serial);
+
+	return 0;
+}
+
+static void rtl8188eu_reset_8051(struct rtl8xxxu_priv *priv)
+{
+	u16 sys_func;
+
+	sys_func = rtl8xxxu_read16(priv, REG_SYS_FUNC);
+	sys_func &= ~SYS_FUNC_CPU_ENABLE;
+	rtl8xxxu_write16(priv, REG_SYS_FUNC, sys_func);
+
+	sys_func |= SYS_FUNC_CPU_ENABLE;
+	rtl8xxxu_write16(priv, REG_SYS_FUNC, sys_func);
+}
+
+static int rtl8188eu_load_firmware(struct rtl8xxxu_priv *priv)
+{
+	const char *fw_name;
+	int ret;
+
+	fw_name = "rtlwifi/rtl8188eufw.bin";
+
+	ret = rtl8xxxu_load_firmware(priv, fw_name);
+
+	return ret;
+}
+
+static void rtl8188eu_init_phy_bb(struct rtl8xxxu_priv *priv)
+{
+	u8 val8;
+	u16 val16;
+
+	val16 = rtl8xxxu_read16(priv, REG_SYS_FUNC);
+	val16 |= SYS_FUNC_BB_GLB_RSTN | SYS_FUNC_BBRSTB | SYS_FUNC_DIO_RF;
+	rtl8xxxu_write16(priv, REG_SYS_FUNC, val16);
+
+	/*
+	 * Per vendor driver, run power sequence before init of RF
+	 */
+	val8 = RF_ENABLE | RF_RSTB | RF_SDMRSTB;
+	rtl8xxxu_write8(priv, REG_RF_CTRL, val8);
+
+	val8 = SYS_FUNC_USBA | SYS_FUNC_USBD |
+	       SYS_FUNC_BB_GLB_RSTN | SYS_FUNC_BBRSTB;
+	rtl8xxxu_write8(priv, REG_SYS_FUNC, val8);
+
+	rtl8xxxu_init_phy_regs(priv, rtl8188eu_phy_init_table);
+	rtl8xxxu_init_phy_regs(priv, rtl8188e_agc_table);
+}
+
+static int rtl8188eu_init_phy_rf(struct rtl8xxxu_priv *priv)
+{
+	return rtl8xxxu_init_phy_rf(priv, rtl8188eu_radioa_init_table, RF_A);
+}
+
+static int rtl8188eu_iqk_path_a(struct rtl8xxxu_priv *priv)
+{
+	u32 reg_eac, reg_e94, reg_e9c;
+	int result = 0;
+
+	/* Path A IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x10008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x30008c1c);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK_PI_A, 0x8214032a);
+	rtl8xxxu_write32(priv, REG_RX_IQK_PI_A, 0x28160000);
+
+	/* LO calibration setting */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x00462911);
+
+	/* One shot, path A LOK & IQK */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf9000000);
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8000000);
+
+	mdelay(10);
+
+	/* Check failed */
+	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
+	reg_e94 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_A);
+	reg_e9c = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_A);
+
+	if (!(reg_eac & BIT(28)) &&
+	    ((reg_e94 & 0x03ff0000) != 0x01420000) &&
+	    ((reg_e9c & 0x03ff0000) != 0x00420000))
+		result |= 0x01;
+
+	return result;
+}
+
+static int rtl8188eu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
+{
+	u32 reg_ea4, reg_eac, reg_e94, reg_e9c, val32;
+	int result = 0;
+
+	/* Leave IQK mode */
+	val32 = rtl8xxxu_read32(priv, REG_FPGA0_IQK);
+	u32p_replace_bits(&val32, 0, 0xffffff00);
+	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
+
+	/* Enable path A PA in TX IQK mode */
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_WE_LUT, 0x800a0);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_RCK_OS, 0x30000);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXPA_G1, 0x0000f);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXPA_G2, 0xf117b);
+
+	/* Enter IQK mode */
+	val32 = rtl8xxxu_read32(priv, REG_FPGA0_IQK);
+	u32p_replace_bits(&val32, 0x808000, 0xffffff00);
+	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
+
+	/* TX IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK, 0x01007c00);
+	rtl8xxxu_write32(priv, REG_RX_IQK, 0x81004800);
+
+	/* path-A IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x10008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x30008c1c);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK_PI_A, 0x82160804);
+	rtl8xxxu_write32(priv, REG_RX_IQK_PI_A, 0x28160000);
+
+	/* LO calibration setting */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x0046a911);
+
+	/* One shot, path A LOK & IQK */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf9000000);
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8000000);
+
+	mdelay(10);
+
+	/* Check failed */
+	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
+	reg_e94 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_A);
+	reg_e9c = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_A);
+
+	if (!(reg_eac & BIT(28)) &&
+	    ((reg_e94 & 0x03ff0000) != 0x01420000) &&
+	    ((reg_e9c & 0x03ff0000) != 0x00420000))
+		result |= 0x01;
+	else
+		goto out;
+
+	val32 = 0x80007c00 |
+		(reg_e94 & 0x03ff0000) | ((reg_e9c >> 16) & 0x03ff);
+	rtl8xxxu_write32(priv, REG_TX_IQK, val32);
+
+	/* Modify RX IQK mode table */
+	val32 = rtl8xxxu_read32(priv, REG_FPGA0_IQK);
+	u32p_replace_bits(&val32, 0, 0xffffff00);
+	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
+
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_WE_LUT, 0x800a0);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_RCK_OS, 0x30000);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXPA_G1, 0x0000f);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXPA_G2, 0xf7ffa);
+
+	/* Enter IQK mode */
+	val32 = rtl8xxxu_read32(priv, REG_FPGA0_IQK);
+	u32p_replace_bits(&val32, 0x808000, 0xffffff00);
+	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
+
+	/* IQK setting */
+	rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
+
+	/* Path A IQK setting */
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x30008c1c);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x10008c1c);
+
+	rtl8xxxu_write32(priv, REG_TX_IQK_PI_A, 0x82160c05);
+	rtl8xxxu_write32(priv, REG_RX_IQK_PI_A, 0x28160c05);
+
+	/* LO calibration setting */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x0046a911);
+
+	/* One shot, path A LOK & IQK */
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf9000000);
+	rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8000000);
+
+	mdelay(10);
+
+	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
+	reg_ea4 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_A_2);
+
+	if (!(reg_eac & BIT(27)) &&
+	    ((reg_ea4 & 0x03ff0000) != 0x01320000) &&
+	    ((reg_eac & 0x03ff0000) != 0x00360000))
+		result |= 0x02;
+	else
+		dev_warn(&priv->udev->dev, "%s: Path A RX IQK failed!\n",
+			 __func__);
+
+out:
+	return result;
+}
+
+static void rtl8188eu_phy_iqcalibrate(struct rtl8xxxu_priv *priv,
+				      int result[][8], int t)
+{
+	struct device *dev = &priv->udev->dev;
+	u32 i, val32;
+	int path_a_ok;
+	int retry = 2;
+	static const u32 adda_regs[RTL8XXXU_ADDA_REGS] = {
+		REG_FPGA0_XCD_SWITCH_CTRL, REG_BLUETOOTH,
+		REG_RX_WAIT_CCA, REG_TX_CCK_RFON,
+		REG_TX_CCK_BBON, REG_TX_OFDM_RFON,
+		REG_TX_OFDM_BBON, REG_TX_TO_RX,
+		REG_TX_TO_TX, REG_RX_CCK,
+		REG_RX_OFDM, REG_RX_WAIT_RIFS,
+		REG_RX_TO_RX, REG_STANDBY,
+		REG_SLEEP, REG_PMPD_ANAEN
+	};
+	static const u32 iqk_mac_regs[RTL8XXXU_MAC_REGS] = {
+		REG_TXPAUSE, REG_BEACON_CTRL,
+		REG_BEACON_CTRL_1, REG_GPIO_MUXCFG
+	};
+	static const u32 iqk_bb_regs[RTL8XXXU_BB_REGS] = {
+		REG_OFDM0_TRX_PATH_ENABLE, REG_OFDM0_TR_MUX_PAR,
+		REG_FPGA0_XCD_RF_SW_CTRL, REG_CONFIG_ANT_A, REG_CONFIG_ANT_B,
+		REG_FPGA0_XAB_RF_SW_CTRL, REG_FPGA0_XA_RF_INT_OE,
+		REG_FPGA0_XB_RF_INT_OE, REG_CCK0_AFE_SETTING
+	};
+
+	/*
+	 * Note: IQ calibration must be performed after loading
+	 *       PHY_REG.txt , and radio_a, radio_b.txt
+	 */
+
+	if (t == 0) {
+		/* Save ADDA parameters, turn Path A ADDA on */
+		rtl8xxxu_save_regs(priv, adda_regs, priv->adda_backup,
+				   RTL8XXXU_ADDA_REGS);
+		rtl8xxxu_save_mac_regs(priv, iqk_mac_regs, priv->mac_backup);
+		rtl8xxxu_save_regs(priv, iqk_bb_regs,
+				   priv->bb_backup, RTL8XXXU_BB_REGS);
+	}
+
+	rtl8xxxu_path_adda_on(priv, adda_regs, true);
+
+	if (t == 0) {
+		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XA_HSSI_PARM1);
+		priv->pi_enabled = u32_get_bits(val32, FPGA0_HSSI_PARM1_PI);
+	}
+
+	if (!priv->pi_enabled) {
+		/* Switch BB to PI mode to do IQ Calibration. */
+		rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
+		rtl8xxxu_write32(priv, REG_FPGA0_XB_HSSI_PARM1, 0x01000100);
+	}
+
+	/* MAC settings */
+	rtl8xxxu_mac_calibration(priv, iqk_mac_regs, priv->mac_backup);
+
+	val32 = rtl8xxxu_read32(priv, REG_CCK0_AFE_SETTING);
+	u32p_replace_bits(&val32, 0xf, 0x0f000000);
+	rtl8xxxu_write32(priv, REG_CCK0_AFE_SETTING, val32);
+
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x03a05600);
+	rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000800e4);
+	rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x22204000);
+
+	if (!priv->no_pape) {
+		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XAB_RF_SW_CTRL);
+		val32 |= (FPGA0_RF_PAPE |
+			  (FPGA0_RF_PAPE << FPGA0_RF_BD_CTRL_SHIFT));
+		rtl8xxxu_write32(priv, REG_FPGA0_XAB_RF_SW_CTRL, val32);
+	}
+
+	val32 = rtl8xxxu_read32(priv, REG_FPGA0_XA_RF_INT_OE);
+	val32 &= ~BIT(10);
+	rtl8xxxu_write32(priv, REG_FPGA0_XA_RF_INT_OE, val32);
+	val32 = rtl8xxxu_read32(priv, REG_FPGA0_XB_RF_INT_OE);
+	val32 &= ~BIT(10);
+	rtl8xxxu_write32(priv, REG_FPGA0_XB_RF_INT_OE, val32);
+
+	/* Page B init */
+	rtl8xxxu_write32(priv, REG_CONFIG_ANT_A, 0x0f600000);
+
+	/* IQ calibration setting */
+	val32 = rtl8xxxu_read32(priv, REG_FPGA0_IQK);
+	u32p_replace_bits(&val32, 0x808000, 0xffffff00);
+	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
+	rtl8xxxu_write32(priv, REG_TX_IQK, 0x01007c00);
+	rtl8xxxu_write32(priv, REG_RX_IQK, 0x81004800);
+
+	for (i = 0; i < retry; i++) {
+		path_a_ok = rtl8188eu_iqk_path_a(priv);
+		if (path_a_ok == 0x01) {
+			val32 = rtl8xxxu_read32(priv,
+						REG_TX_POWER_BEFORE_IQK_A);
+			result[t][0] = (val32 >> 16) & 0x3ff;
+			val32 = rtl8xxxu_read32(priv,
+						REG_TX_POWER_AFTER_IQK_A);
+			result[t][1] = (val32 >> 16) & 0x3ff;
+			break;
+		}
+	}
+
+	if (!path_a_ok)
+		dev_dbg(dev, "%s: Path A TX IQK failed!\n", __func__);
+
+	for (i = 0; i < retry; i++) {
+		path_a_ok = rtl8188eu_rx_iqk_path_a(priv);
+		if (path_a_ok == 0x03) {
+			val32 = rtl8xxxu_read32(priv,
+						REG_RX_POWER_BEFORE_IQK_A_2);
+			result[t][2] = (val32 >> 16) & 0x3ff;
+			val32 = rtl8xxxu_read32(priv,
+						REG_RX_POWER_AFTER_IQK_A_2);
+			result[t][3] = (val32 >> 16) & 0x3ff;
+
+			break;
+		}
+	}
+
+	if (!path_a_ok)
+		dev_dbg(dev, "%s: Path A RX IQK failed!\n", __func__);
+
+	/* Back to BB mode, load original value */
+	val32 = rtl8xxxu_read32(priv, REG_FPGA0_IQK);
+	u32p_replace_bits(&val32, 0, 0xffffff00);
+	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
+
+	if (t == 0)
+		return;
+
+	if (!priv->pi_enabled) {
+		/* Switch back BB to SI mode after finishing IQ Calibration */
+		rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000000);
+		rtl8xxxu_write32(priv, REG_FPGA0_XB_HSSI_PARM1, 0x01000000);
+	}
+
+	/* Reload ADDA power saving parameters */
+	rtl8xxxu_restore_regs(priv, adda_regs, priv->adda_backup,
+			      RTL8XXXU_ADDA_REGS);
+
+	/* Reload MAC parameters */
+	rtl8xxxu_restore_mac_regs(priv, iqk_mac_regs, priv->mac_backup);
+
+	/* Reload BB parameters */
+	rtl8xxxu_restore_regs(priv, iqk_bb_regs,
+			      priv->bb_backup, RTL8XXXU_BB_REGS);
+
+	/* Restore RX initial gain */
+	rtl8xxxu_write32(priv, REG_FPGA0_XA_LSSI_PARM, 0x00032ed3);
+
+	/* Load 0xe30 IQC default value */
+	rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x01008c00);
+	rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x01008c00);
+}
+
+static void rtl8188eu_phy_iq_calibrate(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+	int result[4][8];	/* last is final result */
+	int i, candidate;
+	bool path_a_ok;
+	u32 reg_e94, reg_e9c, reg_ea4, reg_eac;
+	u32 reg_eb4, reg_ebc, reg_ec4, reg_ecc;
+	bool simu;
+
+	memset(result, 0, sizeof(result));
+	result[3][0] = 0x100;
+	result[3][2] = 0x100;
+	result[3][4] = 0x100;
+	result[3][6] = 0x100;
+
+	candidate = -1;
+
+	path_a_ok = false;
+
+	for (i = 0; i < 3; i++) {
+		rtl8188eu_phy_iqcalibrate(priv, result, i);
+
+		if (i == 1) {
+			simu = rtl8xxxu_simularity_compare(priv,
+							   result, 0, 1);
+			if (simu) {
+				candidate = 0;
+				break;
+			}
+		}
+
+		if (i == 2) {
+			simu = rtl8xxxu_simularity_compare(priv,
+							   result, 0, 2);
+			if (simu) {
+				candidate = 0;
+				break;
+			}
+
+			simu = rtl8xxxu_simularity_compare(priv,
+							   result, 1, 2);
+			if (simu)
+				candidate = 1;
+			else
+				candidate = 3;
+		}
+	}
+
+	if (candidate >= 0) {
+		reg_e94 = result[candidate][0];
+		priv->rege94 =  reg_e94;
+		reg_e9c = result[candidate][1];
+		priv->rege9c = reg_e9c;
+		reg_ea4 = result[candidate][2];
+		reg_eac = result[candidate][3];
+		reg_eb4 = result[candidate][4];
+		priv->regeb4 = reg_eb4;
+		reg_ebc = result[candidate][5];
+		priv->regebc = reg_ebc;
+		reg_ec4 = result[candidate][6];
+		reg_ecc = result[candidate][7];
+		dev_dbg(dev, "%s: candidate is %x\n", __func__, candidate);
+		dev_dbg(dev,
+			"%s: e94=%x e9c=%x ea4=%x eac=%x eb4=%x ebc=%x ec4=%x ecc=%x\n",
+			__func__, reg_e94, reg_e9c, reg_ea4, reg_eac,
+			reg_eb4, reg_ebc, reg_ec4, reg_ecc);
+		path_a_ok = true;
+	} else {
+		reg_e94 = 0x100;
+		reg_eb4 = 0x100;
+		priv->rege94 = 0x100;
+		priv->regeb4 = 0x100;
+		reg_e9c = 0x0;
+		reg_ebc = 0x0;
+		priv->rege9c = 0x0;
+		priv->regebc = 0x0;
+	}
+
+	if (reg_e94 && candidate >= 0)
+		rtl8xxxu_fill_iqk_matrix_a(priv, path_a_ok, result,
+					   candidate, (reg_ea4 == 0));
+
+	rtl8xxxu_save_regs(priv, rtl8xxxu_iqk_phy_iq_bb_reg,
+			   priv->bb_recovery_backup, RTL8XXXU_BB_REGS);
+}
+
+static void rtl8188e_disabled_to_emu(struct rtl8xxxu_priv *priv)
+{
+	u16 val16;
+
+	val16 = rtl8xxxu_read16(priv, REG_APS_FSMCO);
+	val16 &= ~(APS_FSMCO_HW_SUSPEND | APS_FSMCO_PCIE);
+	rtl8xxxu_write16(priv, REG_APS_FSMCO, val16);
+}
+
+static int rtl8188e_emu_to_active(struct rtl8xxxu_priv *priv)
+{
+	u8 val8;
+	u32 val32;
+	u16 val16;
+	int count, ret = 0;
+
+	/* wait till 0x04[17] = 1 power ready*/
+	for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
+		val32 = rtl8xxxu_read32(priv, REG_APS_FSMCO);
+		if (val32 & BIT(17))
+			break;
+
+		udelay(10);
+	}
+
+	if (!count) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	/* reset baseband */
+	val8 = rtl8xxxu_read8(priv, REG_SYS_FUNC);
+	val8 &= ~(SYS_FUNC_BBRSTB | SYS_FUNC_BB_GLB_RSTN);
+	rtl8xxxu_write8(priv, REG_SYS_FUNC, val8);
+
+	/*0x24[23] = 2b'01 schmit trigger */
+	val32 = rtl8xxxu_read32(priv, REG_AFE_XTAL_CTRL);
+	val32 |= BIT(23);
+	rtl8xxxu_write32(priv, REG_AFE_XTAL_CTRL, val32);
+
+	/* 0x04[15] = 0 disable HWPDN (control by DRV)*/
+	val16 = rtl8xxxu_read16(priv, REG_APS_FSMCO);
+	val16 &= ~APS_FSMCO_HW_POWERDOWN;
+	rtl8xxxu_write16(priv, REG_APS_FSMCO, val16);
+
+	/*0x04[12:11] = 2b'00 disable WL suspend*/
+	val16 = rtl8xxxu_read16(priv, REG_APS_FSMCO);
+	val16 &= ~(APS_FSMCO_HW_SUSPEND | APS_FSMCO_PCIE);
+	rtl8xxxu_write16(priv, REG_APS_FSMCO, val16);
+
+	/* set, then poll until 0 */
+	val32 = rtl8xxxu_read32(priv, REG_APS_FSMCO);
+	val32 |= APS_FSMCO_MAC_ENABLE;
+	rtl8xxxu_write32(priv, REG_APS_FSMCO, val32);
+
+	for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
+		val32 = rtl8xxxu_read32(priv, REG_APS_FSMCO);
+		if ((val32 & APS_FSMCO_MAC_ENABLE) == 0) {
+			ret = 0;
+			break;
+		}
+		udelay(10);
+	}
+
+	if (!count) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	/* LDO normal mode*/
+	val8 = rtl8xxxu_read8(priv, REG_LPLDO_CTRL);
+	val8 &= ~BIT(4);
+	rtl8xxxu_write8(priv, REG_LPLDO_CTRL, val8);
+
+exit:
+	return ret;
+}
+
+static int rtl8188eu_active_to_emu(struct rtl8xxxu_priv *priv)
+{
+	u8 val8;
+
+	/* Turn off RF */
+	val8 = rtl8xxxu_read8(priv, REG_RF_CTRL);
+	val8 &= ~RF_ENABLE;
+	rtl8xxxu_write8(priv, REG_RF_CTRL, val8);
+
+	/* LDO Sleep mode */
+	val8 = rtl8xxxu_read8(priv, REG_LPLDO_CTRL);
+	val8 |= BIT(4);
+	rtl8xxxu_write8(priv, REG_LPLDO_CTRL, val8);
+
+	return 0;
+}
+
+static int rtl8188eu_emu_to_disabled(struct rtl8xxxu_priv *priv)
+{
+	u32 val32;
+	u16 val16;
+	u8 val8;
+
+	val32 = rtl8xxxu_read32(priv, REG_AFE_XTAL_CTRL);
+	val32 |= BIT(23);
+	rtl8xxxu_write32(priv, REG_AFE_XTAL_CTRL, val32);
+
+	val16 = rtl8xxxu_read16(priv, REG_APS_FSMCO);
+	val16 &= ~APS_FSMCO_PCIE;
+	val16 |= APS_FSMCO_HW_SUSPEND;
+	rtl8xxxu_write16(priv, REG_APS_FSMCO, val16);
+
+	rtl8xxxu_write8(priv, REG_APS_FSMCO + 3, 0x00);
+
+	val8 = rtl8xxxu_read8(priv, REG_GPIO_MUXCFG + 1);
+	val8 &= ~BIT(4);
+	rtl8xxxu_write8(priv, REG_GPIO_MUXCFG + 1, val8);
+
+	/* Set USB suspend enable local register 0xfe10[4]=1 */
+	val8 = rtl8xxxu_read8(priv, 0xfe10);
+	val8 |= BIT(4);
+	rtl8xxxu_write8(priv, 0xfe10, val8);
+
+	return 0;
+}
+
+static int rtl8188eu_active_to_lps(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+	u8 val8;
+	u16 val16;
+	u32 val32;
+	int retry, retval;
+
+	rtl8xxxu_write8(priv, REG_TXPAUSE, 0x7f);
+
+	retry = 100;
+	retval = -EBUSY;
+	/* Poll 32 bit wide REG_SCH_TX_CMD for 0 to ensure no TX is pending. */
+	do {
+		val32 = rtl8xxxu_read32(priv, REG_SCH_TX_CMD);
+		if (!val32) {
+			retval = 0;
+			break;
+		}
+	} while (retry--);
+
+	if (!retry) {
+		dev_warn(dev, "Failed to flush TX queue\n");
+		retval = -EBUSY;
+		goto out;
+	}
+
+	/* Disable CCK and OFDM, clock gated */
+	val8 = rtl8xxxu_read8(priv, REG_SYS_FUNC);
+	val8 &= ~SYS_FUNC_BBRSTB;
+	rtl8xxxu_write8(priv, REG_SYS_FUNC, val8);
+
+	udelay(2);
+
+	/* Reset MAC TRX */
+	val16 = rtl8xxxu_read16(priv, REG_CR);
+	val16 |= 0xff;
+	val16 &= ~(CR_MAC_TX_ENABLE | CR_MAC_RX_ENABLE | CR_SECURITY_ENABLE);
+	rtl8xxxu_write16(priv, REG_CR, val16);
+
+	val8 = rtl8xxxu_read8(priv, REG_DUAL_TSF_RST);
+	val8 |= DUAL_TSF_TX_OK;
+	rtl8xxxu_write8(priv, REG_DUAL_TSF_RST, val8);
+
+out:
+	return retval;
+}
+
+static int rtl8188eu_power_on(struct rtl8xxxu_priv *priv)
+{
+	u16 val16;
+	int ret;
+
+	rtl8188e_disabled_to_emu(priv);
+
+	ret = rtl8188e_emu_to_active(priv);
+	if (ret)
+		goto exit;
+
+	/*
+	 * Enable MAC DMA/WMAC/SCHEDULE/SEC block
+	 * Set CR bit10 to enable 32k calibration.
+	 * We do not set CR_MAC_TX_ENABLE | CR_MAC_RX_ENABLE here
+	 * due to a hardware bug in the 88E, requiring those to be
+	 * set after REG_TRXFF_BNDY is set. If not the RXFF bundary
+	 * will get set to a larger buffer size than the real buffer
+	 * size.
+	 */
+	val16 = (CR_HCI_TXDMA_ENABLE | CR_HCI_RXDMA_ENABLE |
+		 CR_TXDMA_ENABLE | CR_RXDMA_ENABLE |
+		 CR_PROTOCOL_ENABLE | CR_SCHEDULE_ENABLE |
+		 CR_SECURITY_ENABLE | CR_CALTIMER_ENABLE);
+	rtl8xxxu_write16(priv, REG_CR, val16);
+
+exit:
+	return ret;
+}
+
+static void rtl8188eu_power_off(struct rtl8xxxu_priv *priv)
+{
+	u8 val8;
+	u16 val16;
+
+	rtl8xxxu_flush_fifo(priv);
+
+	val8 = rtl8xxxu_read8(priv, REG_TX_REPORT_CTRL);
+	val8 &= ~TX_REPORT_CTRL_TIMER_ENABLE;
+	rtl8xxxu_write8(priv, REG_TX_REPORT_CTRL, val8);
+
+	/* Turn off RF */
+	rtl8xxxu_write8(priv, REG_RF_CTRL, 0x00);
+
+	rtl8188eu_active_to_lps(priv);
+
+	/* Reset Firmware if running in RAM */
+	if (rtl8xxxu_read8(priv, REG_MCU_FW_DL) & MCU_FW_RAM_SEL)
+		rtl8xxxu_firmware_self_reset(priv);
+
+	/* Reset MCU */
+	val16 = rtl8xxxu_read16(priv, REG_SYS_FUNC);
+	val16 &= ~SYS_FUNC_CPU_ENABLE;
+	rtl8xxxu_write16(priv, REG_SYS_FUNC, val16);
+
+	/* Reset MCU ready status */
+	rtl8xxxu_write8(priv, REG_MCU_FW_DL, 0x00);
+
+	/* 32K_CTRL looks to be very 8188e specific */
+	val8 = rtl8xxxu_read8(priv, REG_32K_CTRL);
+	val8 &= ~BIT(0);
+	rtl8xxxu_write8(priv, REG_32K_CTRL, val8);
+
+	rtl8188eu_active_to_emu(priv);
+	rtl8188eu_emu_to_disabled(priv);
+
+	/* Reset MCU IO Wrapper */
+	val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL + 1);
+	val8 &= ~BIT(3);
+	rtl8xxxu_write8(priv, REG_RSV_CTRL + 1, val8);
+
+	val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL + 1);
+	val8 |= BIT(3);
+	rtl8xxxu_write8(priv, REG_RSV_CTRL + 1, val8);
+
+	/* Vendor driver refers to GPIO_IN */
+	val8 = rtl8xxxu_read8(priv, REG_GPIO_PIN_CTRL);
+	/* Vendor driver refers to GPIO_OUT */
+	rtl8xxxu_write8(priv, REG_GPIO_PIN_CTRL + 1, val8);
+	rtl8xxxu_write8(priv, REG_GPIO_PIN_CTRL + 2, 0xff);
+
+	val8 = rtl8xxxu_read8(priv, REG_GPIO_IO_SEL);
+	rtl8xxxu_write8(priv, REG_GPIO_IO_SEL, val8 << 4);
+	val8 = rtl8xxxu_read8(priv, REG_GPIO_IO_SEL + 1);
+	rtl8xxxu_write8(priv, REG_GPIO_IO_SEL + 1, val8 | 0x0f);
+
+	/*
+	 * Set LNA, TRSW, EX_PA Pin to output mode
+	 * Referred to as REG_BB_PAD_CTRL in 8188eu vendor driver
+	 */
+	rtl8xxxu_write32(priv, REG_PAD_CTRL1, 0x00080808);
+
+	rtl8xxxu_write8(priv, REG_RSV_CTRL, 0x00);
+
+	rtl8xxxu_write32(priv, REG_GPIO_MUXCFG, 0x00000000);
+}
+
+static void rtl8188e_enable_rf(struct rtl8xxxu_priv *priv)
+{
+	u32 val32;
+
+	rtl8xxxu_write8(priv, REG_RF_CTRL, RF_ENABLE | RF_RSTB | RF_SDMRSTB);
+
+	val32 = rtl8xxxu_read32(priv, REG_OFDM0_TRX_PATH_ENABLE);
+	val32 &= ~(OFDM_RF_PATH_RX_MASK | OFDM_RF_PATH_TX_MASK);
+	val32 |= OFDM_RF_PATH_RX_A | OFDM_RF_PATH_TX_A;
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, val32);
+
+	rtl8xxxu_write8(priv, REG_TXPAUSE, 0x00);
+}
+
+static void rtl8188e_disable_rf(struct rtl8xxxu_priv *priv)
+{
+	u32 val32;
+
+	val32 = rtl8xxxu_read32(priv, REG_OFDM0_TRX_PATH_ENABLE);
+	val32 &= ~OFDM_RF_PATH_TX_MASK;
+	rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, val32);
+
+	/* Power down RF module */
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_AC, 0);
+
+	rtl8188eu_active_to_emu(priv);
+}
+
+static void rtl8188e_usb_quirks(struct rtl8xxxu_priv *priv)
+{
+	u16 val16;
+
+	/*
+	 * Technically this is not a USB quirk, but a chip quirk.
+	 * This has to be done after REG_TRXFF_BNDY is set, see
+	 * rtl8188eu_power_on() for details.
+	 */
+	val16 = rtl8xxxu_read16(priv, REG_CR);
+	val16 |= (CR_MAC_TX_ENABLE | CR_MAC_RX_ENABLE);
+	rtl8xxxu_write16(priv, REG_CR, val16);
+
+	rtl8xxxu_gen2_usb_quirks(priv);
+
+	/* Pre-TX enable WEP/TKIP security */
+	rtl8xxxu_write8(priv, REG_EARLY_MODE_CONTROL_8188E + 3, 0x01);
+}
+
+static s8 rtl8188e_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
+{
+	/* only use lna 0/1/2/3/7 */
+	static const s8 lna_gain_table_0[8] = {17, -1, -13, -29, -32, -35, -38, -41};
+	/* only use lna 3/7 */
+	static const s8 lna_gain_table_1[8] = {29, 20, 12, 3, -6, -15, -24, -33};
+
+	s8 rx_pwr_all = 0x00;
+	u8 vga_idx, lna_idx;
+	s8 lna_gain = 0;
+
+	lna_idx = u8_get_bits(cck_agc_rpt, CCK_AGC_RPT_LNA_IDX_MASK);
+	vga_idx = u8_get_bits(cck_agc_rpt, CCK_AGC_RPT_VGA_IDX_MASK);
+
+	if (priv->chip_cut >= 8) /* cut I */ /* SMIC */
+		lna_gain = lna_gain_table_0[lna_idx];
+	else /* TSMC */
+		lna_gain = lna_gain_table_1[lna_idx];
+
+	rx_pwr_all = lna_gain - (2 * vga_idx);
+
+	return rx_pwr_all;
+}
+
+struct rtl8xxxu_fileops rtl8188eu_fops = {
+	.identify_chip = rtl8188eu_identify_chip,
+	.parse_efuse = rtl8188eu_parse_efuse,
+	.load_firmware = rtl8188eu_load_firmware,
+	.power_on = rtl8188eu_power_on,
+	.power_off = rtl8188eu_power_off,
+	.reset_8051 = rtl8188eu_reset_8051,
+	.llt_init = rtl8xxxu_init_llt_table,
+	.init_phy_bb = rtl8188eu_init_phy_bb,
+	.init_phy_rf = rtl8188eu_init_phy_rf,
+	.phy_lc_calibrate = rtl8723a_phy_lc_calibrate,
+	.phy_iq_calibrate = rtl8188eu_phy_iq_calibrate,
+	.config_channel = rtl8188eu_config_channel,
+	.parse_rx_desc = rtl8xxxu_parse_rxdesc16,
+	.init_aggregation = rtl8188eu_init_aggregation,
+	.enable_rf = rtl8188e_enable_rf,
+	.disable_rf = rtl8188e_disable_rf,
+	.usb_quirks = rtl8188e_usb_quirks,
+	.set_tx_power = rtl8188f_set_tx_power,
+	.update_rate_mask = rtl8xxxu_gen2_update_rate_mask,
+	.report_connect = rtl8xxxu_gen2_report_connect,
+	.fill_txdesc = rtl8xxxu_fill_txdesc_v3,
+	.set_crystal_cap = rtl8188f_set_crystal_cap,
+	.cck_rssi = rtl8188e_cck_rssi,
+	.writeN_block_size = 128,
+	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
+	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
+	.has_tx_report = 1,
+	.gen2_thermal_meter = 1,
+	.adda_1t_init = 0x0b1b25a0,
+	.adda_1t_path_on = 0x0bdb25a0,
+	/*
+	 * Use 9K for 8188e normal chip
+	 * Max RX buffer = 10K - max(TxReportSize(64*8), WOLPattern(16*24))
+	 */
+	.trxff_boundary = 0x25ff,
+	.pbp_rx = PBP_PAGE_SIZE_128,
+	.pbp_tx = PBP_PAGE_SIZE_128,
+	.mactable = rtl8188e_mac_init_table,
+	.total_page_num = TX_TOTAL_PAGE_NUM_8188E,
+	.page_num_hi = TX_PAGE_NUM_HI_PQ_8188E,
+	.page_num_lo = TX_PAGE_NUM_LO_PQ_8188E,
+	.page_num_norm = TX_PAGE_NUM_NORM_PQ_8188E,
+	.last_llt_entry = 175,
+};
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 54e136c964b4..63484ab1b4d7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -370,7 +370,7 @@ static void rtl8188f_channel_to_group(int channel, int *group, int *cck_group)
 		*cck_group = *group;
 }
 
-static void
+void
 rtl8188f_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 {
 	u32 val32, ofdm, mcs;
@@ -1651,7 +1651,7 @@ static void rtl8188f_usb_quirks(struct rtl8xxxu_priv *priv)
 #define XTAL1	GENMASK(22, 17)
 #define XTAL0	GENMASK(16, 11)
 
-static void rtl8188f_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
+void rtl8188f_set_crystal_cap(struct rtl8xxxu_priv *priv, u8 crystal_cap)
 {
 	struct rtl8xxxu_cfo_tracking *cfo = &priv->cfo_tracking;
 	u32 val32;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7aa00442c3a5..c63d3459d8d2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -46,6 +46,7 @@ MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("rtlwifi/rtl8723aufw_A.bin");
 MODULE_FIRMWARE("rtlwifi/rtl8723aufw_B.bin");
 MODULE_FIRMWARE("rtlwifi/rtl8723aufw_B_NoBT.bin");
+MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
 MODULE_FIRMWARE("rtlwifi/rtl8192cufw_A.bin");
 MODULE_FIRMWARE("rtlwifi/rtl8192cufw_B.bin");
 MODULE_FIRMWARE("rtlwifi/rtl8192cufw_TMSC.bin");
@@ -2010,6 +2011,7 @@ int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, const char *fw_name)
 	switch (signature & 0xfff0) {
 	case 0x92e0:
 	case 0x92c0:
+	case 0x88e0:
 	case 0x88c0:
 	case 0x5300:
 	case 0x2300:
@@ -2081,10 +2083,20 @@ rtl8xxxu_init_mac(struct rtl8xxxu_priv *priv)
 		}
 	}
 
-	if (priv->rtl_chip != RTL8723B &&
-	    priv->rtl_chip != RTL8192E &&
-	    priv->rtl_chip != RTL8188F)
+	switch (priv->rtl_chip) {
+	case RTL8188C:
+	case RTL8188R:
+	case RTL8191C:
+	case RTL8192C:
+	case RTL8723A:
 		rtl8xxxu_write8(priv, REG_MAX_AGGR_NUM, 0x0a);
+		break;
+	case RTL8188E:
+		rtl8xxxu_write16(priv, REG_MAX_AGGR_NUM, 0x0707);
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
@@ -2383,11 +2395,16 @@ static int rtl8xxxu_llt_write(struct rtl8xxxu_priv *priv, u8 address, u8 data)
 int rtl8xxxu_init_llt_table(struct rtl8xxxu_priv *priv)
 {
 	int ret;
-	int i;
+	int i, last_entry;
 	u8 last_tx_page;
 
 	last_tx_page = priv->fops->total_page_num;
 
+	if (priv->fops->last_llt_entry)
+		last_entry = priv->fops->last_llt_entry;
+	else
+		last_entry = 255;
+
 	for (i = 0; i < last_tx_page; i++) {
 		ret = rtl8xxxu_llt_write(priv, i, i + 1);
 		if (ret)
@@ -2399,14 +2416,14 @@ int rtl8xxxu_init_llt_table(struct rtl8xxxu_priv *priv)
 		goto exit;
 
 	/* Mark remaining pages as a ring buffer */
-	for (i = last_tx_page + 1; i < 0xff; i++) {
+	for (i = last_tx_page + 1; i < last_entry; i++) {
 		ret = rtl8xxxu_llt_write(priv, i, (i + 1));
 		if (ret)
 			goto exit;
 	}
 
 	/*  Let last entry point to the start entry of ring buffer */
-	ret = rtl8xxxu_llt_write(priv, 0xff, last_tx_page + 1);
+	ret = rtl8xxxu_llt_write(priv, last_entry, last_tx_page + 1);
 	if (ret)
 		goto exit;
 
@@ -2714,8 +2731,8 @@ void rtl8xxxu_fill_iqk_matrix_b(struct rtl8xxxu_priv *priv, bool iqk_ok,
 
 #define MAX_TOLERANCE		5
 
-static bool rtl8xxxu_simularity_compare(struct rtl8xxxu_priv *priv,
-					int result[][8], int c1, int c2)
+bool rtl8xxxu_simularity_compare(struct rtl8xxxu_priv *priv,
+				 int result[][8], int c1, int c2)
 {
 	u32 i, j, diff, simubitmap, bound = 0;
 	int candidate[2] = {-1, -1};	/* for path A and path B */
@@ -3908,7 +3925,8 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		goto exit;
 
 	/* RFSW Control - clear bit 14 ?? */
-	if (priv->rtl_chip != RTL8723B && priv->rtl_chip != RTL8192E)
+	if (priv->rtl_chip != RTL8723B && priv->rtl_chip != RTL8192E &&
+	    priv->rtl_chip != RTL8188E)
 		rtl8xxxu_write32(priv, REG_FPGA0_TX_INFO, 0x00000003);
 
 	val32 = FPGA0_RF_TRSW | FPGA0_RF_TRSWB | FPGA0_RF_ANTSW |
@@ -3921,7 +3939,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	rtl8xxxu_write32(priv, REG_FPGA0_XAB_RF_SW_CTRL, val32);
 
 	/* 0x860[6:5]= 00 - why? - this sets antenna B */
-	if (priv->rtl_chip != RTL8192E)
+	if (priv->rtl_chip != RTL8192E && priv->rtl_chip != RTL8188E)
 		rtl8xxxu_write32(priv, REG_FPGA0_XA_RF_INT_OE, 0x66f60210);
 
 	if (!macpower) {
@@ -3989,6 +4007,15 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	} else if (priv->rtl_chip == RTL8188F) {
 		rtl8xxxu_write32(priv, REG_HISR0, 0xffffffff);
 		rtl8xxxu_write32(priv, REG_HISR1, 0xffffffff);
+	} else if (priv->rtl_chip == RTL8188E) {
+		rtl8xxxu_write32(priv, REG_HISR0, 0xffffffff);
+		val32 = IMR0_PSTIMEOUT | IMR0_TBDER | IMR0_CPWM | IMR0_CPWM2;
+		rtl8xxxu_write32(priv, REG_HIMR0, val32);
+		val32 = IMR1_TXERR | IMR1_RXERR | IMR1_TXFOVW | IMR1_RXFOVW;
+		rtl8xxxu_write32(priv, REG_HIMR1, val32);
+		val8 = rtl8xxxu_read8(priv, REG_USB_SPECIAL_OPTION);
+		val8 |= USB_SPEC_INT_BULK_SELECT;
+		rtl8xxxu_write8(priv, REG_USB_SPECIAL_OPTION, val8);
 	} else {
 		/*
 		 * Enable all interrupts - not obvious USB needs to do this
@@ -4094,7 +4121,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	if (fops->init_aggregation)
 		fops->init_aggregation(priv);
 
-	if (priv->rtl_chip == RTL8188F) {
+	if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8188E) {
 		rtl8xxxu_write16(priv, REG_PKT_VO_VI_LIFE_TIME, 0x0400); /* unit: 256us. 256ms */
 		rtl8xxxu_write16(priv, REG_PKT_BE_BK_LIFE_TIME, 0x0400); /* unit: 256us. 256ms */
 	}
@@ -4128,7 +4155,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	/* Disable BAR - not sure if this has any effect on USB */
 	rtl8xxxu_write32(priv, REG_BAR_MODE_CTRL, 0x0201ffff);
 
-	if (priv->rtl_chip != RTL8188F)
+	if (priv->rtl_chip != RTL8188F && priv->rtl_chip != RTL8188E)
 		rtl8xxxu_write16(priv, REG_FAST_EDCA_CTRL, 0);
 
 	if (fops->init_statistics)
@@ -4146,9 +4173,9 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		 * Reset USB mode switch setting
 		 */
 		rtl8xxxu_write8(priv, REG_ACLK_MON, 0x00);
-	} else if (priv->rtl_chip == RTL8188F) {
+	} else if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8188E) {
 		/*
-		 * Init GPIO settings for 8188f
+		 * Init GPIO settings for 8188f, 8188e
 		 */
 		val8 = rtl8xxxu_read8(priv, REG_GPIO_MUXCFG);
 		val8 &= ~GPIO_MUXCFG_IO_SEL_ENBT;
@@ -4194,7 +4221,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 			val32 |= FPGA_RF_MODE_CCK;
 			rtl8xxxu_write32(priv, REG_FPGA0_RF_MODE, val32);
 		}
-	} else if (priv->rtl_chip == RTL8192E) {
+	} else if (priv->rtl_chip == RTL8192E || priv->rtl_chip == RTL8188E) {
 		rtl8xxxu_write8(priv, REG_USB_HRPWM, 0x00);
 	}
 
@@ -5079,6 +5106,96 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	}
 }
 
+/*
+ * Fill in v3 (gen1) specific TX descriptor bits.
+ * This format is a hybrid between the v1 and v2 formats, only seen
+ * on 8188eu devices so far.
+ */
+void
+rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
+			struct ieee80211_tx_info *tx_info,
+			struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
+			bool short_preamble, bool ampdu_enable, u32 rts_rate)
+{
+	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
+	struct rtl8xxxu_priv *priv = hw->priv;
+	struct device *dev = &priv->udev->dev;
+	u8 *qc = ieee80211_get_qos_ctl(hdr);
+	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
+	u32 rate;
+	u16 rate_flags = tx_info->control.rates[0].flags;
+	u16 seq_number;
+
+	if (rate_flags & IEEE80211_TX_RC_MCS &&
+	    !ieee80211_is_mgmt(hdr->frame_control))
+		rate = tx_info->control.rates[0].idx + DESC_RATE_MCS0;
+	else
+		rate = tx_rate->hw_value;
+
+	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
+
+	if (ieee80211_is_data(hdr->frame_control)) {
+		rate = DESC_RATE_MCS7; /* TODO: software rate control */
+		tx_desc->txdw5 = cpu_to_le32(rate);
+		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_USE_DRIVER_RATE);
+		/* Data/RTS rate FB limit */
+		tx_desc->txdw5 |= cpu_to_le32(0x0001ff00);
+	}
+
+	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
+		dev_info(dev, "%s: TX rate: %d, pkt size %d\n",
+			 __func__, rate, le16_to_cpu(tx_desc->pkt_size));
+
+	tx_desc->txdw3 = cpu_to_le32((u32)seq_number << TXDESC32_SEQ_SHIFT);
+
+	if (ampdu_enable && test_bit(tid, priv->tid_tx_operational))
+		tx_desc->txdw2 |= cpu_to_le32(TXDESC40_AGG_ENABLE);
+	else
+		tx_desc->txdw2 |= cpu_to_le32(TXDESC40_AGG_BREAK);
+
+	if (ieee80211_is_mgmt(hdr->frame_control)) {
+		tx_desc->txdw5 = cpu_to_le32(rate);
+		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_USE_DRIVER_RATE);
+		tx_desc->txdw5 |= cpu_to_le32(6 << TXDESC32_RETRY_LIMIT_SHIFT);
+		tx_desc->txdw5 |= cpu_to_le32(TXDESC32_RETRY_LIMIT_ENABLE);
+	}
+
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
+		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_QOS);
+
+		if (conf_is_ht40(&hw->conf)) {
+			tx_desc->txdw4 |= cpu_to_le32(TXDESC_DATA_BW);
+
+			if (conf_is_ht40_minus(&hw->conf))
+				tx_desc->txdw4 |= cpu_to_le32(TXDESC_PRIME_CH_OFF_UPPER);
+			else
+				tx_desc->txdw4 |= cpu_to_le32(TXDESC_PRIME_CH_OFF_LOWER);
+		}
+	}
+
+	if (short_preamble)
+		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_SHORT_PREAMBLE);
+
+	if (sgi)
+		tx_desc->txdw5 |= cpu_to_le32(TXDESC32_SHORT_GI);
+
+	/*
+	 * rts_rate is zero if RTS/CTS or CTS to SELF are not enabled
+	 */
+	tx_desc->txdw4 |= cpu_to_le32(rts_rate << TXDESC32_RTS_RATE_SHIFT);
+	if (ampdu_enable || (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS)) {
+		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_RTS_CTS_ENABLE);
+		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_HW_RTS_ENABLE);
+	} else if (rate_flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
+		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_CTS_SELF_ENABLE);
+		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_HW_RTS_ENABLE);
+	}
+
+	tx_desc->txdw2 |= cpu_to_le32(TXDESC_ANTENNA_SELECT_A |
+				      TXDESC_ANTENNA_SELECT_B);
+	tx_desc->txdw7 |= cpu_to_le32(TXDESC_ANTENNA_SELECT_C);
+}
+
 static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 			struct ieee80211_tx_control *control,
 			struct sk_buff *skb)
@@ -6597,7 +6714,10 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
 	rtl8xxxu_write16(priv, REG_RXFLTMAP2, 0xffff);
 	rtl8xxxu_write16(priv, REG_RXFLTMAP0, 0xffff);
 
-	rtl8xxxu_write32(priv, REG_OFDM0_XA_AGC_CORE1, 0x6954341e);
+	if (priv->rtl_chip == RTL8188E)
+		rtl8xxxu_write32(priv, REG_OFDM0_XA_AGC_CORE1, 0x6955341e);
+	else
+		rtl8xxxu_write32(priv, REG_OFDM0_XA_AGC_CORE1, 0x6954341e);
 
 	return ret;
 
@@ -6764,6 +6884,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		case 0x817f:
 		case 0x818b:
 		case 0xf179:
+		case 0x8179:
 			untested = 0;
 			break;
 		}
@@ -6900,8 +7021,10 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 
 	hw->extra_tx_headroom = priv->fops->tx_desc_size;
 	ieee80211_hw_set(hw, SIGNAL_DBM);
+
 	/*
-	 * The firmware handles rate control
+	 * The firmware handles rate control, except for RTL8188EU,
+	 * where we handle the rate control in the driver.
 	 */
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
@@ -6986,6 +7109,50 @@ static const struct usb_device_id dev_table[] = {
 /* RTL8188FU */
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0xf179, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8188fu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8179, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* Tested by Hans de Goede - rtl8188etv */
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x0179, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* Sitecom rtl8188eus */
+{USB_DEVICE_AND_INTERFACE_INFO(0x0df6, 0x0076, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* D-Link USB-GO-N150 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3311, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* D-Link DWA-125 REV D1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330f, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* D-Link DWA-123 REV D1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3310, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* D-Link DWA-121 rev B1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x331b, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* Abocom - Abocom */
+{USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8179, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* Elecom WDC-150SU2M */
+{USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4008, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* TP-Link TL-WN722N v2 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x010c, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* TP-Link TL-WN727N v5.21 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0111, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* MERCUSYS MW150US v2 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0102, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* ASUS USB-N10 Nano B1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x18f0, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+ /* Edimax EW-7811Un V2 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xb811, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
+/* Rosewill USB-N150 Nano */
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0xffef, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8188eu_fops},
 #ifdef CONFIG_RTL8XXXU_UNTESTED
 /* Still supported by rtlwifi */
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8176, 0xff, 0xff, 0xff),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 3e79efdfb4c2..5818b2378bab 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -371,6 +371,11 @@
 #define  PBP_PAGE_SIZE_512		0x3
 #define  PBP_PAGE_SIZE_1024		0x4
 
+/* 8188eu IOL magic */
+#define REG_PKT_BUF_ACCESS_CTRL		0x0106
+#define  PKT_BUF_ACCESS_CTRL_TX		0x69
+#define  PKT_BUF_ACCESS_CTRL_RX		0xa5
+
 #define REG_TRXDMA_CTRL			0x010c
 #define  TRXDMA_CTRL_RXDMA_AGG_EN	BIT(2)
 #define  TRXDMA_CTRL_VOQ_SHIFT		4
@@ -407,6 +412,8 @@
 #define REG_MBIST_START			0x0174
 #define REG_MBIST_DONE			0x0178
 #define REG_MBIST_FAIL			0x017c
+/* 8188EU */
+#define REG_32K_CTRL			0x0194
 #define REG_C2HEVT_MSG_NORMAL		0x01a0
 /* 8192EU/8723BU/8812 */
 #define REG_C2HEVT_CMD_ID_8723B		0x01ae
@@ -942,6 +949,16 @@
 #define REG_FPGA1_RF_MODE		0x0900
 
 #define REG_FPGA1_TX_INFO		0x090c
+#define  FPGA1_TX_ANT_MASK		0x0000000f
+#define  FPGA1_TX_ANT_L_MASK		0x000000f0
+#define  FPGA1_TX_ANT_NON_HT_MASK	0x00000f00
+#define  FPGA1_TX_ANT_HT1_MASK		0x0000f000
+#define  FPGA1_TX_ANT_HT2_MASK		0x000f0000
+#define  FPGA1_TX_ANT_HT_S1_MASK	0x00f00000
+#define  FPGA1_TX_ANT_NON_HT_S1_MASK	0x0f000000
+#define  FPGA1_TX_OFDM_TXSC_MASK	0x30000000
+
+#define REG_ANT_MAPPING1		0x0914
 #define REG_DPDT_CTRL			0x092c	/* 8723BU */
 #define REG_RFE_CTRL_ANTA_SRC		0x0930	/* 8723BU */
 #define REG_RFE_PATH_SELECT		0x0940	/* 8723BU */
@@ -954,9 +971,25 @@
 
 #define REG_CCK0_AFE_SETTING		0x0a04
 #define  CCK0_AFE_RX_MASK		0x0f000000
-#define  CCK0_AFE_RX_ANT_AB		BIT(24)
+#define  CCK0_AFE_TX_MASK		0xf0000000
 #define  CCK0_AFE_RX_ANT_A		0
-#define  CCK0_AFE_RX_ANT_B		(BIT(24) | BIT(26))
+#define  CCK0_AFE_RX_ANT_B		BIT(26)
+#define  CCK0_AFE_RX_ANT_C		BIT(27)
+#define  CCK0_AFE_RX_ANT_D		(BIT(26) | BIT(27))
+#define  CCK0_AFE_RX_ANT_OPTION_A	0
+#define  CCK0_AFE_RX_ANT_OPTION_B	BIT(24)
+#define  CCK0_AFE_RX_ANT_OPTION_C	BIT(25)
+#define  CCK0_AFE_RX_ANT_OPTION_D	(BIT(24) | BIT(25))
+#define  CCK0_AFE_TX_ANT_A		BIT(31)
+#define  CCK0_AFE_TX_ANT_B		BIT(30)
+
+#define REG_CCK_ANTDIV_PARA2		0x0a04
+#define REG_BB_POWER_SAVE4		0x0a74
+
+/* 8188eu */
+#define REG_LNA_SWITCH			0x0b2c
+#define  LNA_SWITCH_DISABLE_CSCG	BIT(22)
+#define  LNA_SWITCH_OUTPUT_CG		BIT(31)
 
 #define REG_CCK_PD_THRESH			0x0a0a
 #define  CCK_PD_TYPE1_LV0_TH		0x40
@@ -1020,6 +1053,9 @@
 
 #define REG_OFDM0_RX_IQ_EXT_ANTA	0x0ca0
 
+/* 8188eu */
+#define REG_ANTDIV_PARA1		0x0ca4
+
 /* 8723bu */
 #define REG_OFDM0_TX_PSDO_NOISE_WEIGHT	0x0ce4
 
-- 
2.38.0
