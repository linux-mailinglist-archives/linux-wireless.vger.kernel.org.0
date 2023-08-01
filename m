Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E1A76A6D4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 04:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjHACMn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 22:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHACMi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 22:12:38 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 062B41BEA
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 19:12:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3712CCXC0018143, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3712CCXC0018143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 10:12:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 1 Aug 2023 10:12:07 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 1 Aug 2023
 10:12:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/8] wifi: rtw89: add to parse firmware elements of BB and RF tables
Date:   Tue, 1 Aug 2023 10:11:26 +0800
Message-ID: <20230801021127.15919-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801021127.15919-1-pkshih@realtek.com>
References: <20230801021127.15919-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The tables of BB and RF parameters are pairs of {addr, value}. Load them
and convert from little-endian to CPU order, and show the version to clear
which version we are using.

  rtw89_8922ae 0000:03:00.0: Firmware element BB version: 00 04 00 00
  rtw89_8922ae 0000:03:00.0: Firmware element radio A version: 00 13 00 00
  rtw89_8922ae 0000:03:00.0: Firmware element NCTL version: 00 05 00 00

We use tables defined in firmware elements with higher priority than
original static const tables defined in driver, because WiFi 7 chips will
not define the tables in driver, and existing chips can possibly migrate to
the new design one by one.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  8 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 95 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  7 ++
 drivers/net/wireless/realtek/rtw89/phy.c  | 15 +++-
 4 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a92c027cb2967..b4aa1f9f041b1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3412,6 +3412,13 @@ struct rtw89_fw_log {
 	const char *(*fmts)[];
 };
 
+struct rtw89_fw_elm_info {
+	struct rtw89_phy_table *bb_tbl;
+	struct rtw89_phy_table *bb_gain;
+	struct rtw89_phy_table *rf_radio[RF_PATH_MAX];
+	struct rtw89_phy_table *rf_nctl;
+};
+
 struct rtw89_fw_info {
 	struct rtw89_fw_req_info req;
 	int fw_format;
@@ -3425,6 +3432,7 @@ struct rtw89_fw_info {
 	struct rtw89_fw_suit bbmcu1;
 	struct rtw89_fw_log log;
 	u32 feature_map;
+	struct rtw89_fw_elm_info elm_info;
 };
 
 #define RTW89_CHK_FW_FEATURE(_feat, _fw) \
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f613a50a747e4..be629746b15b0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -565,6 +565,68 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static
+int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
+				 const struct rtw89_fw_element_hdr *elm,
+				 const void *data)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	struct rtw89_phy_table *tbl;
+	struct rtw89_reg2_def *regs;
+	enum rtw89_rf_path rf_path;
+	u32 n_regs, i;
+	u8 idx;
+
+	tbl = kzalloc(sizeof(*tbl), GFP_KERNEL);
+	if (!tbl)
+		return -ENOMEM;
+
+	switch (le32_to_cpu(elm->id)) {
+	case RTW89_FW_ELEMENT_ID_BB_REG:
+		elm_info->bb_tbl = tbl;
+		break;
+	case RTW89_FW_ELEMENT_ID_BB_GAIN:
+		elm_info->bb_gain = tbl;
+		break;
+	case RTW89_FW_ELEMENT_ID_RADIO_A:
+	case RTW89_FW_ELEMENT_ID_RADIO_B:
+	case RTW89_FW_ELEMENT_ID_RADIO_C:
+	case RTW89_FW_ELEMENT_ID_RADIO_D:
+		rf_path = (enum rtw89_rf_path)data;
+		idx = elm->u.reg2.idx;
+
+		elm_info->rf_radio[idx] = tbl;
+		tbl->rf_path = rf_path;
+		tbl->config = rtw89_phy_config_rf_reg_v1;
+		break;
+	case RTW89_FW_ELEMENT_ID_RF_NCTL:
+		elm_info->rf_nctl = tbl;
+		break;
+	default:
+		kfree(tbl);
+		return -ENOENT;
+	}
+
+	n_regs = le32_to_cpu(elm->size) / sizeof(tbl->regs[0]);
+	regs = kcalloc(n_regs, sizeof(tbl->regs[0]), GFP_KERNEL);
+	if (!regs)
+		goto out;
+
+	for (i = 0; i < n_regs; i++) {
+		regs[i].addr = le32_to_cpu(elm->u.reg2.regs[i].addr);
+		regs[i].data = le32_to_cpu(elm->u.reg2.regs[i].data);
+	}
+
+	tbl->n_regs = n_regs;
+	tbl->regs = regs;
+
+	return 0;
+
+out:
+	kfree(tbl);
+	return -ENOMEM;
+}
+
 struct rtw89_fw_element_handler {
 	int (*fn)(struct rtw89_dev *rtwdev,
 		  const struct rtw89_fw_element_hdr *elm, const void *data);
@@ -577,6 +639,17 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 					(const void *)RTW89_FW_BBMCU0, NULL},
 	[RTW89_FW_ELEMENT_ID_BBMCU1] = {__rtw89_fw_recognize_from_elm,
 					(const void *)RTW89_FW_BBMCU1, NULL},
+	[RTW89_FW_ELEMENT_ID_BB_REG] = {rtw89_build_phy_tbl_from_elm, NULL, "BB"},
+	[RTW89_FW_ELEMENT_ID_BB_GAIN] = {rtw89_build_phy_tbl_from_elm, NULL, NULL},
+	[RTW89_FW_ELEMENT_ID_RADIO_A] = {rtw89_build_phy_tbl_from_elm,
+					 (const void *)RF_PATH_A, "radio A"},
+	[RTW89_FW_ELEMENT_ID_RADIO_B] = {rtw89_build_phy_tbl_from_elm,
+					 (const void *)RF_PATH_B, NULL},
+	[RTW89_FW_ELEMENT_ID_RADIO_C] = {rtw89_build_phy_tbl_from_elm,
+					 (const void *)RF_PATH_C, NULL},
+	[RTW89_FW_ELEMENT_ID_RADIO_D] = {rtw89_build_phy_tbl_from_elm,
+					 (const void *)RF_PATH_D, NULL},
+	[RTW89_FW_ELEMENT_ID_RF_NCTL] = {rtw89_build_phy_tbl_from_elm, NULL, "NCTL"},
 };
 
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
@@ -924,6 +997,27 @@ void rtw89_load_firmware_work(struct work_struct *work)
 	rtw89_load_firmware_req(rtwdev, &rtwdev->fw.req, fw_name, false);
 }
 
+static void rtw89_free_phy_tbl_from_elm(struct rtw89_phy_table *tbl)
+{
+	if (!tbl)
+		return;
+
+	kfree(tbl->regs);
+	kfree(tbl);
+}
+
+static void rtw89_unload_firmware_elements(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	int i;
+
+	rtw89_free_phy_tbl_from_elm(elm_info->bb_tbl);
+	rtw89_free_phy_tbl_from_elm(elm_info->bb_gain);
+	for (i = 0; i < ARRAY_SIZE(elm_info->rf_radio); i++)
+		rtw89_free_phy_tbl_from_elm(elm_info->rf_radio[i]);
+	rtw89_free_phy_tbl_from_elm(elm_info->rf_nctl);
+}
+
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_fw_info *fw = &rtwdev->fw;
@@ -940,6 +1034,7 @@ void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
 	}
 
 	kfree(fw->log.fmts);
+	rtw89_unload_firmware_elements(rtwdev);
 }
 
 static u32 rtw89_fw_log_get_fmt_idx(struct rtw89_dev *rtwdev, u32 fmt_id)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 34dc96d949734..9eb908122a4bc 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3504,6 +3504,13 @@ struct rtw89_fw_logsuit_hdr {
 enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_BBMCU0 = 0,
 	RTW89_FW_ELEMENT_ID_BBMCU1 = 1,
+	RTW89_FW_ELEMENT_ID_BB_REG = 2,
+	RTW89_FW_ELEMENT_ID_BB_GAIN = 3,
+	RTW89_FW_ELEMENT_ID_RADIO_A = 4,
+	RTW89_FW_ELEMENT_ID_RADIO_B = 5,
+	RTW89_FW_ELEMENT_ID_RADIO_C = 6,
+	RTW89_FW_ELEMENT_ID_RADIO_D = 7,
+	RTW89_FW_ELEMENT_ID_RF_NCTL = 8,
 };
 
 struct rtw89_fw_element_hdr {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index fb15c852fdd48..4003c59579d46 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1342,12 +1342,16 @@ static void rtw89_phy_init_reg(struct rtw89_dev *rtwdev,
 
 void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_phy_table *bb_table = chip->bb_table;
-	const struct rtw89_phy_table *bb_gain_table = chip->bb_gain_table;
+	const struct rtw89_phy_table *bb_table;
+	const struct rtw89_phy_table *bb_gain_table;
 
+	bb_table = elm_info->bb_tbl ? elm_info->bb_tbl : chip->bb_table;
 	rtw89_phy_init_reg(rtwdev, bb_table, rtw89_phy_config_bb_reg, NULL);
 	rtw89_chip_init_txpwr_unit(rtwdev, RTW89_PHY_0);
+
+	bb_gain_table = elm_info->bb_gain ? elm_info->bb_gain : chip->bb_gain_table;
 	if (bb_gain_table)
 		rtw89_phy_init_reg(rtwdev, bb_gain_table,
 				   rtw89_phy_config_bb_gain, NULL);
@@ -1365,6 +1369,7 @@ void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio)
 {
 	void (*config)(struct rtw89_dev *rtwdev, const struct rtw89_reg2_def *reg,
 		       enum rtw89_rf_path rf_path, void *data);
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_phy_table *rf_table;
 	struct rtw89_fw_h2c_rf_reg_info *rf_reg_info;
@@ -1375,7 +1380,8 @@ void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio)
 		return;
 
 	for (path = RF_PATH_A; path < chip->rf_path_num; path++) {
-		rf_table = chip->rf_table[path];
+		rf_table = elm_info->rf_radio[path] ?
+			   elm_info->rf_radio[path] : chip->rf_table[path];
 		rf_reg_info->rf_path = rf_table->rf_path;
 		if (noio)
 			config = rtw89_phy_config_rf_reg_noio;
@@ -1392,6 +1398,7 @@ void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio)
 
 static void rtw89_phy_init_rf_nctl(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_phy_table *nctl_table;
 	u32 val;
@@ -1414,7 +1421,7 @@ static void rtw89_phy_init_rf_nctl(struct rtw89_dev *rtwdev)
 	if (ret)
 		rtw89_err(rtwdev, "failed to poll nctl block\n");
 
-	nctl_table = chip->nctl_table;
+	nctl_table = elm_info->rf_nctl ? elm_info->rf_nctl : chip->nctl_table;
 	rtw89_phy_init_reg(rtwdev, nctl_table, rtw89_phy_config_bb_reg, NULL);
 
 	if (chip->nctl_post_table)
-- 
2.25.1

