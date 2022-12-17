Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A364F936
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiLQOSR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLQOSO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:18:14 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FC241208E
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:18:13 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BHEH8Ll8024805, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BHEH8Ll8024805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 17 Dec 2022 22:17:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 17 Dec 2022 22:17:58 +0800
Received: from localhost (172.16.16.141) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 17 Dec
 2022 22:17:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: coex: add BTC format version derived from firmware version
Date:   Sat, 17 Dec 2022 22:17:39 +0800
Message-ID: <20221217141745.43291-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221217141745.43291-1-pkshih@realtek.com>
References: <20221217141745.43291-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.141]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/17/2022 14:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE3IKRXpMggMTE6MjQ6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Originally, each chip maintains its own format version followed firmware
it uses. As new chip is added, firmware changes format of exchange
messages to have rich information to handle more conditions.

When old chip is going to upgrade firmware, it could use new format and
driver needs to maintain compatibility with old firmware. So, add this
version array to achieve this goal.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 95 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/coex.h |  1 +
 drivers/net/wireless/realtek/rtw89/core.h | 26 +++++++
 drivers/net/wireless/realtek/rtw89/fw.c   |  2 +
 4 files changed, 124 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index f21c73310fdb6..96aadd50f5fd6 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -120,6 +120,70 @@ static const u32 cxtbl[] = {
 	0xfafadafa  /* 19 */
 };
 
+static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
+	/* firmware version must be in decreasing order for each chip */
+	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 57, 0),
+	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
+	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
+	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
+	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,
+	 .info_buf = 1280, .max_role_num = 5,
+	},
+	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 42, 0),
+	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
+	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
+	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
+	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,
+	 .info_buf = 1280, .max_role_num = 5,
+	},
+	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 0, 0),
+	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
+	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
+	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
+	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,
+	 .info_buf = 1280, .max_role_num = 5,
+	},
+	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 14, 0),
+	 .fcxbtcrpt = 5, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 4,
+	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
+	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
+	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,
+	 .info_buf = 1800, .max_role_num = 6,
+	},
+	{RTL8852B, RTW89_FW_VER_CODE(0, 27, 0, 0),
+	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
+	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
+	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
+	 .fwlrole = 1,   .frptmap = 1,    .fcxctrl = 1,
+	 .info_buf = 1280, .max_role_num = 5,
+	},
+	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 37, 0),
+	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
+	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
+	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
+	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,
+	 .info_buf = 1280, .max_role_num = 5,
+	},
+	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 0, 0),
+	 .fcxbtcrpt = 1, .fcxtdma = 1,    .fcxslots = 1, .fcxcysta = 2,
+	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
+	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
+	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,
+	 .info_buf = 1024, .max_role_num = 5,
+	},
+
+	/* keep it to be the last as default entry */
+	{0, RTW89_FW_VER_CODE(0, 0, 0, 0),
+	 .fcxbtcrpt = 1, .fcxtdma = 1,    .fcxslots = 1, .fcxcysta = 2,
+	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
+	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
+	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,
+	 .info_buf = 1024, .max_role_num = 5,
+	},
+};
+
+#define RTW89_DEFAULT_BTC_VER_IDX (ARRAY_SIZE(rtw89_btc_ver_defs) - 1)
+
 struct rtw89_btc_btf_tlv {
 	u8 type;
 	u8 len;
@@ -7008,3 +7072,34 @@ void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	else
 		_show_summary_v1(rtwdev, m);
 }
+
+void rtw89_coex_recognize_ver(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *btc_ver_def;
+	const struct rtw89_fw_suit *fw_suit;
+	u32 suit_ver_code;
+	int i;
+
+	fw_suit = rtw89_fw_suit_get(rtwdev, RTW89_FW_NORMAL);
+	suit_ver_code = RTW89_FW_SUIT_VER_CODE(fw_suit);
+
+	for (i = 0; i < ARRAY_SIZE(rtw89_btc_ver_defs); i++) {
+		btc_ver_def = &rtw89_btc_ver_defs[i];
+
+		if (chip->chip_id != btc_ver_def->chip_id)
+			continue;
+
+		if (suit_ver_code >= btc_ver_def->fw_ver_code) {
+			btc->ver = btc_ver_def;
+			goto out;
+		}
+	}
+
+	btc->ver = &rtw89_btc_ver_defs[RTW89_DEFAULT_BTC_VER_IDX];
+
+out:
+	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC] use version def[%d] = 0x%08x\n",
+		    (int)(btc->ver - rtw89_btc_ver_defs), btc->ver->fw_ver_code);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index ca16afa97ec07..401fb55df82b0 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -164,6 +164,7 @@ void rtw89_coex_rfk_chk_work(struct work_struct *work);
 void rtw89_coex_power_on(struct rtw89_dev *rtwdev);
 void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type);
 void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type);
+void rtw89_coex_recognize_ver(struct rtw89_dev *rtwdev);
 
 static inline u8 rtw89_btc_phymap(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 800ede1d69c75..151343ee7b763 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2019,9 +2019,35 @@ struct rtw89_btc_btf_fwinfo {
 	struct rtw89_btc_rpt_fbtc_btdev rpt_fbtc_btdev;
 };
 
+struct rtw89_btc_ver {
+	enum rtw89_core_chip_id chip_id;
+	u32 fw_ver_code;
+
+	u8 fcxbtcrpt;
+	u8 fcxtdma;
+	u8 fcxslots;
+	u8 fcxcysta;
+	u8 fcxstep;
+	u8 fcxnullsta;
+	u8 fcxmreg;
+	u8 fcxgpiodbg;
+	u8 fcxbtver;
+	u8 fcxbtscan;
+	u8 fcxbtafh;
+	u8 fcxbtdevinfo;
+	u8 fwlrole;
+	u8 frptmap;
+	u8 fcxctrl;
+
+	u16 info_buf;
+	u8 max_role_num;
+};
+
 #define RTW89_BTC_POLICY_MAXLEN 512
 
 struct rtw89_btc {
+	const struct rtw89_btc_ver *ver;
+
 	struct rtw89_btc_cx cx;
 	struct rtw89_btc_dm dm;
 	struct rtw89_btc_ctrl ctrl;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 65b6bd44c5ac7..50fd97a22ffa9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -352,6 +352,8 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 
 	rtw89_fw_recognize_features(rtwdev);
 
+	rtw89_coex_recognize_ver(rtwdev);
+
 	return 0;
 }
 
-- 
2.25.1

