Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604BE4D7B65
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 08:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiCNHPE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiCNHPC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 03:15:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B433810FCE
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 00:13:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22E7DkDaA003319, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22E7DkDaA003319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Mar 2022 15:13:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 14 Mar 2022 15:13:46 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 15:13:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 6/8] rtw89: ser: dump fw backtrace while L2 reset
Date:   Mon, 14 Mar 2022 15:12:48 +0800
Message-ID: <20220314071250.40292-7-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Read FW backtrace entry through FW reserved payload engine, and then
add FW backtrace dump during SER (system error recover) L2 reset process.
It contains a list of RA (return address) and SP (stack pointer) which
gives us a chance to trace back the call stack of FW.

Moreover, if core dump might have wrong content due to error during
dumping, we won't invoke device core dump framework. For this case,
rtw89_ser_cd_free() is added to free buffer by ourselves.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  |  9 +++
 drivers/net/wireless/realtek/rtw89/ser.c | 97 +++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d0b93a0b406df..1aaec26722377 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2196,6 +2196,15 @@ struct rtw89_fw_h2c_rf_reg_info {
 
 #define RTW89_FW_RSVD_PLE_SIZE 0x800
 
+#define RTW89_WCPU_BASE_ADDR 0xA0000000
+
+#define RTW89_FW_BACKTRACE_INFO_SIZE 8
+#define RTW89_VALID_FW_BACKTRACE_SIZE(_size) \
+	((_size) % RTW89_FW_BACKTRACE_INFO_SIZE == 0)
+
+#define RTW89_FW_BACKTRACE_MAX_SIZE 512 /* 8 * 64 (entries) */
+#define RTW89_FW_BACKTRACE_KEY 0xBACEBACE
+
 int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev);
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
 int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index bf2f97a146ece..f28cd0645ad92 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -87,14 +87,20 @@ static void ser_cd_ ## _name ## _init(struct ser_cd_ ## _name *p) \
 
 enum rtw89_ser_cd_type {
 	RTW89_SER_CD_FW_RSVD_PLE	= 0,
+	RTW89_SER_CD_FW_BACKTRACE	= 1,
 };
 
 RTW89_DEF_SER_CD_TYPE(fw_rsvd_ple,
 		      RTW89_SER_CD_FW_RSVD_PLE,
 		      RTW89_FW_RSVD_PLE_SIZE);
 
+RTW89_DEF_SER_CD_TYPE(fw_backtrace,
+		      RTW89_SER_CD_FW_BACKTRACE,
+		      RTW89_FW_BACKTRACE_MAX_SIZE);
+
 struct rtw89_ser_cd_buffer {
 	struct ser_cd_fw_rsvd_ple fwple;
+	struct ser_cd_fw_backtrace fwbt;
 } __packed;
 
 static struct rtw89_ser_cd_buffer *rtw89_ser_cd_prep(struct rtw89_dev *rtwdev)
@@ -106,6 +112,7 @@ static struct rtw89_ser_cd_buffer *rtw89_ser_cd_prep(struct rtw89_dev *rtwdev)
 		return NULL;
 
 	ser_cd_fw_rsvd_ple_init(&buf->fwple);
+	ser_cd_fw_backtrace_init(&buf->fwbt);
 
 	return buf;
 }
@@ -123,6 +130,21 @@ static void rtw89_ser_cd_send(struct rtw89_dev *rtwdev,
 	dev_coredumpv(rtwdev->dev, buf, sizeof(*buf), GFP_KERNEL);
 }
 
+static void rtw89_ser_cd_free(struct rtw89_dev *rtwdev,
+			      struct rtw89_ser_cd_buffer *buf, bool free_self)
+{
+	if (!free_self)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_SER, "SER frees core dump by self\n");
+
+	/* When some problems happen during filling data of core dump,
+	 * we won't send it to device coredump framework. Instead, we
+	 * free buf by ourselves.
+	 */
+	vfree(buf);
+}
+
 static void ser_state_run(struct rtw89_ser *ser, u8 evt)
 {
 	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
@@ -487,19 +509,92 @@ static void rtw89_ser_fw_rsvd_ple_dump(struct rtw89_dev *rtwdev, u8 *buf)
 			 RTW89_FW_RSVD_PLE_SIZE);
 }
 
+struct __fw_backtrace_entry {
+	u32 wcpu_addr;
+	u32 size;
+	u32 key;
+} __packed;
+
+struct __fw_backtrace_info {
+	u32 ra;
+	u32 sp;
+} __packed;
+
+static_assert(RTW89_FW_BACKTRACE_INFO_SIZE ==
+	      sizeof(struct __fw_backtrace_info));
+
+static int rtw89_ser_fw_backtrace_dump(struct rtw89_dev *rtwdev, u8 *buf,
+				       const struct __fw_backtrace_entry *ent)
+{
+	struct __fw_backtrace_info *ptr = (struct __fw_backtrace_info *)buf;
+	u32 fwbt_addr = ent->wcpu_addr - RTW89_WCPU_BASE_ADDR;
+	u32 fwbt_size = ent->size;
+	u32 fwbt_key = ent->key;
+	u32 i;
+
+	if (fwbt_addr == 0) {
+		rtw89_warn(rtwdev, "FW backtrace invalid address: 0x%x\n",
+			   fwbt_addr);
+		return -EINVAL;
+	}
+
+	if (fwbt_key != RTW89_FW_BACKTRACE_KEY) {
+		rtw89_warn(rtwdev, "FW backtrace invalid key: 0x%x\n",
+			   fwbt_key);
+		return -EINVAL;
+	}
+
+	if (fwbt_size == 0 || !RTW89_VALID_FW_BACKTRACE_SIZE(fwbt_size) ||
+	    fwbt_size > RTW89_FW_BACKTRACE_MAX_SIZE) {
+		rtw89_warn(rtwdev, "FW backtrace invalid size: 0x%x\n",
+			   fwbt_size);
+		return -EINVAL;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_SER, "dump fw backtrace start\n");
+	rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR, fwbt_addr);
+
+	for (i = R_AX_INDIR_ACCESS_ENTRY;
+	     i < R_AX_INDIR_ACCESS_ENTRY + fwbt_size;
+	     i += RTW89_FW_BACKTRACE_INFO_SIZE, ptr++) {
+		*ptr = (struct __fw_backtrace_info){
+			.ra = rtw89_read32(rtwdev, i),
+			.sp = rtw89_read32(rtwdev, i + 4),
+		};
+		rtw89_debug(rtwdev, RTW89_DBG_SER,
+			    "next sp: 0x%x, next ra: 0x%x\n",
+			    ptr->sp, ptr->ra);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_SER, "dump fw backtrace end\n");
+	return 0;
+}
+
 static void ser_l2_reset_st_pre_hdl(struct rtw89_ser *ser)
 {
 	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
 	struct rtw89_ser_cd_buffer *buf;
+	struct __fw_backtrace_entry fwbt_ent;
+	int ret = 0;
 
 	buf = rtw89_ser_cd_prep(rtwdev);
-	if (!buf)
+	if (!buf) {
+		ret = -ENOMEM;
 		goto bottom;
+	}
 
 	rtw89_ser_fw_rsvd_ple_dump(rtwdev, buf->fwple.data);
+
+	fwbt_ent = *(struct __fw_backtrace_entry *)buf->fwple.data;
+	ret = rtw89_ser_fw_backtrace_dump(rtwdev, buf->fwbt.data, &fwbt_ent);
+	if (ret)
+		goto bottom;
+
 	rtw89_ser_cd_send(rtwdev, buf);
 
 bottom:
+	rtw89_ser_cd_free(rtwdev, buf, !!ret);
+
 	ser_reset_mac_binding(rtwdev);
 	rtw89_core_stop(rtwdev);
 	INIT_LIST_HEAD(&rtwdev->rtwvifs_list);
-- 
2.25.1

