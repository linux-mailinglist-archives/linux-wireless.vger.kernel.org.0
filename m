Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E009D76A6CA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 04:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjHACMT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 22:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjHACMQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 22:12:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55FD91BD3
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 19:12:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3712BmjaE016283, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3712BmjaE016283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 10:11:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 1 Aug 2023 10:12:01 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 1 Aug 2023
 10:12:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: support firmware log with formatted text
Date:   Tue, 1 Aug 2023 10:11:21 +0800
Message-ID: <20230801021127.15919-3-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Original firmware log which is sent via C2H message bloats
code size of firmware and is also length-limited. So we put
some common log into format file, and firmware could use a
log ID and some variables in C2H message to map a formatted
text via pre-designed rule.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  |   2 +-
 drivers/net/wireless/realtek/rtw89/core.h  |  14 +-
 drivers/net/wireless/realtek/rtw89/debug.c |  14 +-
 drivers/net/wireless/realtek/rtw89/fw.c    | 146 ++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h    |  31 ++++-
 drivers/net/wireless/realtek/rtw89/mac.c   |   3 +-
 6 files changed, 194 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 69b181fa29667..48cfac6e41ffe 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3508,7 +3508,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 	set_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
 
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_ON);
-	rtw89_fw_h2c_fw_log(rtwdev, rtwdev->fw.fw_log_enable);
+	rtw89_fw_h2c_fw_log(rtwdev, rtwdev->fw.log.enable);
 	rtw89_fw_h2c_init_ba_cam(rtwdev);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a3acc0bb18926..c68082f239a29 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3398,6 +3398,15 @@ struct rtw89_fw_req_info {
 	struct completion completion;
 };
 
+struct rtw89_fw_log {
+	struct rtw89_fw_suit suit;
+	bool enable;
+	u32 last_fmt_id;
+	u32 fmt_count;
+	const __le32 *fmt_ids;
+	const char *(*fmts)[];
+};
+
 struct rtw89_fw_info {
 	struct rtw89_fw_req_info req;
 	int fw_format;
@@ -3407,8 +3416,7 @@ struct rtw89_fw_info {
 	u8 c2h_counter;
 	struct rtw89_fw_suit normal;
 	struct rtw89_fw_suit wowlan;
-	struct rtw89_fw_suit logfmt;
-	bool fw_log_enable;
+	struct rtw89_fw_log log;
 	u32 feature_map;
 };
 
@@ -4945,7 +4953,7 @@ static inline struct rtw89_fw_suit *rtw89_fw_suit_get(struct rtw89_dev *rtwdev,
 	if (type == RTW89_FW_WOWLAN)
 		return &fw_info->wowlan;
 	else if (type == RTW89_FW_LOGFMT)
-		return &fw_info->logfmt;
+		return &fw_info->log.suit;
 	return &fw_info->normal;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index ce5a9ac081457..f09141704c584 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3204,20 +3204,22 @@ static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
 	return count;
 }
 
-static ssize_t rtw89_debug_fw_log_btc_manual_set(struct file *filp,
-						 const char __user *user_buf,
-						 size_t count, loff_t *loff)
+static ssize_t rtw89_debug_fw_log_manual_set(struct file *filp,
+					     const char __user *user_buf,
+					     size_t count, loff_t *loff)
 {
 	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-	struct rtw89_fw_info *fw_info = &rtwdev->fw;
+	struct rtw89_fw_log *log = &rtwdev->fw.log;
 	bool fw_log_manual;
 
 	if (kstrtobool_from_user(user_buf, count, &fw_log_manual))
 		goto out;
 
 	mutex_lock(&rtwdev->mutex);
-	fw_info->fw_log_enable = fw_log_manual;
+	log->enable = fw_log_manual;
+	if (log->enable)
+		rtw89_fw_log_prepare(rtwdev);
 	rtw89_fw_h2c_fw_log(rtwdev, fw_log_manual);
 	mutex_unlock(&rtwdev->mutex);
 out:
@@ -3571,7 +3573,7 @@ static struct rtw89_debugfs_priv rtw89_debug_priv_btc_manual = {
 };
 
 static struct rtw89_debugfs_priv rtw89_debug_priv_fw_log_manual = {
-	.cb_write = rtw89_debug_fw_log_btc_manual_set,
+	.cb_write = rtw89_debug_fw_log_manual_set,
 };
 
 static struct rtw89_debugfs_priv rtw89_debug_priv_phy_info = {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 6260bebf305e5..a891d063678da 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -718,6 +718,150 @@ void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
 		 */
 		fw->req.firmware = NULL;
 	}
+
+	kfree(fw->log.fmts);
+}
+
+static u32 rtw89_fw_log_get_fmt_idx(struct rtw89_dev *rtwdev, u32 fmt_id)
+{
+	struct rtw89_fw_log *fw_log = &rtwdev->fw.log;
+	u32 i;
+
+	if (fmt_id > fw_log->last_fmt_id)
+		return 0;
+
+	for (i = 0; i < fw_log->fmt_count; i++) {
+		if (le32_to_cpu(fw_log->fmt_ids[i]) == fmt_id)
+			return i;
+	}
+	return 0;
+}
+
+static int rtw89_fw_log_create_fmts_dict(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_log *log = &rtwdev->fw.log;
+	const struct rtw89_fw_logsuit_hdr *suit_hdr;
+	struct rtw89_fw_suit *suit = &log->suit;
+	const void *fmts_ptr, *fmts_end_ptr;
+	u32 fmt_count;
+	int i;
+
+	suit_hdr = (const struct rtw89_fw_logsuit_hdr *)suit->data;
+	fmt_count = le32_to_cpu(suit_hdr->count);
+	log->fmt_ids = suit_hdr->ids;
+	fmts_ptr = &suit_hdr->ids[fmt_count];
+	fmts_end_ptr = suit->data + suit->size;
+	log->fmts = kcalloc(fmt_count, sizeof(char *), GFP_KERNEL);
+	if (!log->fmts)
+		return -ENOMEM;
+
+	for (i = 0; i < fmt_count; i++) {
+		fmts_ptr = memchr_inv(fmts_ptr, 0, fmts_end_ptr - fmts_ptr);
+		if (!fmts_ptr)
+			break;
+
+		(*log->fmts)[i] = fmts_ptr;
+		log->last_fmt_id = le32_to_cpu(log->fmt_ids[i]);
+		log->fmt_count++;
+		fmts_ptr += strlen(fmts_ptr);
+	}
+
+	return 0;
+}
+
+int rtw89_fw_log_prepare(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_log *log = &rtwdev->fw.log;
+	struct rtw89_fw_suit *suit = &log->suit;
+
+	if (!suit || !suit->data) {
+		rtw89_debug(rtwdev, RTW89_DBG_FW, "no log format file\n");
+		return -EINVAL;
+	}
+	if (log->fmts)
+		return 0;
+
+	return rtw89_fw_log_create_fmts_dict(rtwdev);
+}
+
+static void rtw89_fw_log_dump_data(struct rtw89_dev *rtwdev,
+				   const struct rtw89_fw_c2h_log_fmt *log_fmt,
+				   u32 fmt_idx, u8 para_int, bool raw_data)
+{
+	const char *(*fmts)[] = rtwdev->fw.log.fmts;
+	char str_buf[RTW89_C2H_FW_LOG_STR_BUF_SIZE];
+	u32 args[RTW89_C2H_FW_LOG_MAX_PARA_NUM] = {0};
+	int i;
+
+	if (log_fmt->argc > RTW89_C2H_FW_LOG_MAX_PARA_NUM) {
+		rtw89_warn(rtwdev, "C2H log: Arg count is unexpected %d\n",
+			   log_fmt->argc);
+		return;
+	}
+
+	if (para_int)
+		for (i = 0 ; i < log_fmt->argc; i++)
+			args[i] = le32_to_cpu(log_fmt->u.argv[i]);
+
+	if (raw_data) {
+		if (para_int)
+			snprintf(str_buf, RTW89_C2H_FW_LOG_STR_BUF_SIZE,
+				 "fw_enc(%d, %d, %d) %*ph", le32_to_cpu(log_fmt->fmt_id),
+				 para_int, log_fmt->argc, (int)sizeof(args), args);
+		else
+			snprintf(str_buf, RTW89_C2H_FW_LOG_STR_BUF_SIZE,
+				 "fw_enc(%d, %d, %d, %s)", le32_to_cpu(log_fmt->fmt_id),
+				 para_int, log_fmt->argc, log_fmt->u.raw);
+	} else {
+		snprintf(str_buf, RTW89_C2H_FW_LOG_STR_BUF_SIZE, (*fmts)[fmt_idx],
+			 args[0x0], args[0x1], args[0x2], args[0x3], args[0x4],
+			 args[0x5], args[0x6], args[0x7], args[0x8], args[0x9],
+			 args[0xa], args[0xb], args[0xc], args[0xd], args[0xe],
+			 args[0xf]);
+	}
+
+	rtw89_info(rtwdev, "C2H log: %s", str_buf);
+}
+
+void rtw89_fw_log_dump(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
+{
+	const struct rtw89_fw_c2h_log_fmt *log_fmt;
+	u8 para_int;
+	u32 fmt_idx;
+
+	if (len < RTW89_C2H_HEADER_LEN) {
+		rtw89_err(rtwdev, "c2h log length is wrong!\n");
+		return;
+	}
+
+	buf += RTW89_C2H_HEADER_LEN;
+	len -= RTW89_C2H_HEADER_LEN;
+	log_fmt = (const struct rtw89_fw_c2h_log_fmt *)buf;
+
+	if (len < RTW89_C2H_FW_FORMATTED_LOG_MIN_LEN)
+		goto plain_log;
+
+	if (log_fmt->signature != cpu_to_le16(RTW89_C2H_FW_LOG_SIGNATURE))
+		goto plain_log;
+
+	if (!rtwdev->fw.log.fmts)
+		return;
+
+	para_int = u8_get_bits(log_fmt->feature, RTW89_C2H_FW_LOG_FEATURE_PARA_INT);
+	fmt_idx = rtw89_fw_log_get_fmt_idx(rtwdev, le32_to_cpu(log_fmt->fmt_id));
+
+	if (!para_int && log_fmt->argc != 0 && fmt_idx != 0)
+		rtw89_info(rtwdev, "C2H log: %s%s",
+			   (*rtwdev->fw.log.fmts)[fmt_idx], log_fmt->u.raw);
+	else if (fmt_idx != 0 && para_int)
+		rtw89_fw_log_dump_data(rtwdev, log_fmt, fmt_idx, para_int, false);
+	else
+		rtw89_fw_log_dump_data(rtwdev, log_fmt, fmt_idx, para_int, true);
+	return;
+
+plain_log:
+	rtw89_info(rtwdev, "C2H log: %*s", len, buf);
+
 }
 
 #define H2C_CAM_LEN 60
@@ -931,7 +1075,7 @@ int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 	}
 
 	skb_put(skb, H2C_LOG_CFG_LEN);
-	SET_LOG_CFG_LEVEL(skb->data, RTW89_FW_LOG_LEVEL_SER);
+	SET_LOG_CFG_LEVEL(skb->data, RTW89_FW_LOG_LEVEL_LOUD);
 	SET_LOG_CFG_PATH(skb->data, BIT(RTW89_FW_LOG_LEVEL_C2H));
 	SET_LOG_CFG_COMP(skb->data, comp);
 	SET_LOG_CFG_COMP_EXT(skb->data, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 45f927dc212ef..89ab27090b0c0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3232,9 +3232,6 @@ static inline struct rtw89_fw_c2h_attr *RTW89_SKB_C2H_CB(struct sk_buff *skb)
 	return (struct rtw89_fw_c2h_attr *)skb->cb;
 }
 
-#define RTW89_GET_C2H_LOG_SRT_PRT(c2h) (char *)((__le32 *)(c2h) + 2)
-#define RTW89_GET_C2H_LOG_LEN(len) ((len) - RTW89_C2H_HEADER_LEN)
-
 struct rtw89_c2h_done_ack {
 	__le32 w0;
 	__le32 w1;
@@ -3256,6 +3253,26 @@ struct rtw89_c2h_done_ack {
 #define RTW89_GET_MAC_C2H_REV_ACK_H2C_SEQ(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
 
+struct rtw89_fw_c2h_log_fmt {
+	__le16 signature;
+	u8 feature;
+	u8 syntax;
+	__le32 fmt_id;
+	u8 file_num;
+	__le16 line_num;
+	u8 argc;
+	union {
+		DECLARE_FLEX_ARRAY(u8, raw);
+		DECLARE_FLEX_ARRAY(__le32, argv);
+	} __packed u;
+} __packed;
+
+#define RTW89_C2H_FW_FORMATTED_LOG_MIN_LEN 11
+#define RTW89_C2H_FW_LOG_FEATURE_PARA_INT BIT(2)
+#define RTW89_C2H_FW_LOG_MAX_PARA_NUM 16
+#define RTW89_C2H_FW_LOG_SIGNATURE 0xA5A5
+#define RTW89_C2H_FW_LOG_STR_BUF_SIZE 512
+
 struct rtw89_c2h_mac_bcnfltr_rpt {
 	__le32 w0;
 	__le32 w1;
@@ -3426,6 +3443,12 @@ struct rtw89_mfw_hdr {
 	struct rtw89_mfw_info info[];
 } __packed;
 
+struct rtw89_fw_logsuit_hdr {
+	__le32 rsvd;
+	__le32 count;
+	__le32 ids[];
+} __packed;
+
 struct fwcmd_hdr {
 	__le32 hdr0;
 	__le32 hdr1;
@@ -3616,6 +3639,8 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type);
 void rtw89_load_firmware_work(struct work_struct *work);
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev);
 int rtw89_wait_firmware_completion(struct rtw89_dev *rtwdev);
+int rtw89_fw_log_prepare(struct rtw89_dev *rtwdev);
+void rtw89_fw_log_dump(struct rtw89_dev *rtwdev, u8 *buf, u32 len);
 void rtw89_h2c_pkt_set_hdr(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			   u8 type, u8 cat, u8 class, u8 func,
 			   bool rack, bool dack, u32 len);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b114babec698c..1efa4da3cebc9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4437,8 +4437,7 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 static void
 rtw89_mac_c2h_log(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
-	rtw89_info(rtwdev, "%*s", RTW89_GET_C2H_LOG_LEN(len),
-		   RTW89_GET_C2H_LOG_SRT_PRT(c2h->data));
+	rtw89_fw_log_dump(rtwdev, c2h->data, len);
 }
 
 static void
-- 
2.25.1

