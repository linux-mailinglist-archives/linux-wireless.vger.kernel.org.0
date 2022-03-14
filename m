Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1507F4D7B64
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 08:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbiCNHPD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 03:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiCNHPA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 03:15:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F6911168
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 00:13:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22E7DjUgA003313, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22E7DjUgA003313
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Mar 2022 15:13:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 14 Mar 2022 15:13:45 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 15:13:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 5/8] rtw89: ser: dump memory for fw payload engine while L2 reset
Date:   Mon, 14 Mar 2022 15:12:47 +0800
Message-ID: <20220314071250.40292-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314071250.40292-1-pkshih@realtek.com>
References: <20220314071250.40292-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/14/2022 06:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTQgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When FW encounters exception or assertion, SER L2 reset process will start.
It will dump some error information and re-download FW eventually. Since
such errors are usually critical, we would like to keep more information
about error to increase possibility of analysis and debugging FW. We first
add FW payload engine (fw reserved playoad engine, fw_rsvd_ple) memory
dump. FW will record things like CPU registers, backtrace entry, etc. in it
for debugging.

Moreover, device core dump framework is used and wrapped to collect kinds
of dumps during SER L2 reset process.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   1 +
 drivers/net/wireless/realtek/rtw89/fw.h       |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/ser.c      | 118 +++++++++++++++++-
 4 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e072e6859b301..c95cd1a3ee9e0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2267,6 +2267,7 @@ struct rtw89_chip_info {
 	u32 fifo_size;
 	u16 max_amsdu_limit;
 	bool dis_2g_40m_ul_ofdma;
+	u32 rsvd_ple_ofst;
 	const struct rtw89_hfc_param_ini *hfc_param_ini;
 	const struct rtw89_dle_mem *dle_mem;
 	u32 rf_base_addr[2];
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ed8609b204e09..d0b93a0b406df 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2194,6 +2194,8 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_CL_OUTSRC_RF_REG_A		0x8
 #define H2C_CL_OUTSRC_RF_REG_B		0x9
 
+#define RTW89_FW_RSVD_PLE_SIZE 0x800
+
 int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev);
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
 int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index c429eeae1b567..0c92eefb26277 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2033,6 +2033,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.fifo_size		= 458752,
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
+	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852a_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852a_dle_mem_pcie,
 	.rf_base_addr		= {0xc000, 0xd000},
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index a20389cde7e23..bf2f97a146ece 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -2,10 +2,14 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include <linux/devcoredump.h>
+
 #include "cam.h"
 #include "debug.h"
+#include "fw.h"
 #include "mac.h"
 #include "ps.h"
+#include "reg.h"
 #include "ser.h"
 #include "util.h"
 
@@ -67,6 +71,58 @@ static char *ser_st_name(struct rtw89_ser *ser)
 	return "err_st_name";
 }
 
+#define RTW89_DEF_SER_CD_TYPE(_name, _type, _size) \
+struct ser_cd_ ## _name { \
+	u32 type; \
+	u32 type_size; \
+	u64 padding; \
+	u8 data[_size]; \
+} __packed; \
+static void ser_cd_ ## _name ## _init(struct ser_cd_ ## _name *p) \
+{ \
+	p->type = _type; \
+	p->type_size = sizeof(p->data); \
+	p->padding = 0x0123456789abcdef; \
+}
+
+enum rtw89_ser_cd_type {
+	RTW89_SER_CD_FW_RSVD_PLE	= 0,
+};
+
+RTW89_DEF_SER_CD_TYPE(fw_rsvd_ple,
+		      RTW89_SER_CD_FW_RSVD_PLE,
+		      RTW89_FW_RSVD_PLE_SIZE);
+
+struct rtw89_ser_cd_buffer {
+	struct ser_cd_fw_rsvd_ple fwple;
+} __packed;
+
+static struct rtw89_ser_cd_buffer *rtw89_ser_cd_prep(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_ser_cd_buffer *buf;
+
+	buf = vzalloc(sizeof(*buf));
+	if (!buf)
+		return NULL;
+
+	ser_cd_fw_rsvd_ple_init(&buf->fwple);
+
+	return buf;
+}
+
+static void rtw89_ser_cd_send(struct rtw89_dev *rtwdev,
+			      struct rtw89_ser_cd_buffer *buf)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_SER, "SER sends core dump\n");
+
+	/* After calling dev_coredump, buf's lifetime is supposed to be
+	 * handled by the device coredump framework. Note that a new dump
+	 * will be discarded if a previous one hasn't been released by
+	 * framework yet.
+	 */
+	dev_coredumpv(rtwdev->dev, buf, sizeof(*buf), GFP_KERNEL);
+}
+
 static void ser_state_run(struct rtw89_ser *ser, u8 evt)
 {
 	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
@@ -390,6 +446,65 @@ static void ser_do_hci_st_hdl(struct rtw89_ser *ser, u8 evt)
 	}
 }
 
+static void ser_mac_mem_dump(struct rtw89_dev *rtwdev, u8 *buf,
+			     u8 sel, u32 start_addr, u32 len)
+{
+	u32 *ptr = (u32 *)buf;
+	u32 base_addr, start_page, residue;
+	u32 cnt = 0;
+	u32 i;
+
+	start_page = start_addr / MAC_MEM_DUMP_PAGE_SIZE;
+	residue = start_addr % MAC_MEM_DUMP_PAGE_SIZE;
+	base_addr = rtw89_mac_mem_base_addrs[sel];
+	base_addr += start_page * MAC_MEM_DUMP_PAGE_SIZE;
+
+	while (cnt < len) {
+		rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR, base_addr);
+
+		for (i = R_AX_INDIR_ACCESS_ENTRY + residue;
+		     i < R_AX_INDIR_ACCESS_ENTRY + MAC_MEM_DUMP_PAGE_SIZE;
+		     i += 4, ptr++) {
+			*ptr = rtw89_read32(rtwdev, i);
+			cnt += 4;
+			if (cnt >= len)
+				break;
+		}
+
+		residue = 0;
+		base_addr += MAC_MEM_DUMP_PAGE_SIZE;
+	}
+}
+
+static void rtw89_ser_fw_rsvd_ple_dump(struct rtw89_dev *rtwdev, u8 *buf)
+{
+	u32 start_addr = rtwdev->chip->rsvd_ple_ofst;
+
+	rtw89_debug(rtwdev, RTW89_DBG_SER,
+		    "dump mem for fw rsvd payload engine (start addr: 0x%x)\n",
+		    start_addr);
+	ser_mac_mem_dump(rtwdev, buf, RTW89_MAC_MEM_SHARED_BUF, start_addr,
+			 RTW89_FW_RSVD_PLE_SIZE);
+}
+
+static void ser_l2_reset_st_pre_hdl(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+	struct rtw89_ser_cd_buffer *buf;
+
+	buf = rtw89_ser_cd_prep(rtwdev);
+	if (!buf)
+		goto bottom;
+
+	rtw89_ser_fw_rsvd_ple_dump(rtwdev, buf->fwple.data);
+	rtw89_ser_cd_send(rtwdev, buf);
+
+bottom:
+	ser_reset_mac_binding(rtwdev);
+	rtw89_core_stop(rtwdev);
+	INIT_LIST_HEAD(&rtwdev->rtwvifs_list);
+}
+
 static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 {
 	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
@@ -397,8 +512,7 @@ static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 	switch (evt) {
 	case SER_EV_STATE_IN:
 		mutex_lock(&rtwdev->mutex);
-		ser_reset_mac_binding(rtwdev);
-		rtw89_core_stop(rtwdev);
+		ser_l2_reset_st_pre_hdl(ser);
 		mutex_unlock(&rtwdev->mutex);
 
 		ieee80211_restart_hw(rtwdev->hw);
-- 
2.25.1

