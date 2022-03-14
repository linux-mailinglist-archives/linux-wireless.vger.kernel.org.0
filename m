Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683BB4D7B66
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 08:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiCNHPI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 03:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbiCNHPH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 03:15:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145D211A17
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 00:13:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22E7Dn892003333, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22E7Dn892003333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Mar 2022 15:13:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 14 Mar 2022 15:13:49 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 15:13:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 8/8] rtw89: support FW crash simulation
Date:   Mon, 14 Mar 2022 15:12:50 +0800
Message-ID: <20220314071250.40292-9-pkshih@realtek.com>
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

Originally, there is already a mechanism, SER (system error recover),
to deal with HW/FW recovery. After FW v0.13.36.0, FW supports a H2C
(host to chip) command to make a CPU exception. Then, SER is supposed
to catch this FW crash and do L2 reset. This feature is a simulation
to verify if flow of recovering from FW crash works.

Usage of fw_crash debugfs is as the following.
$ echo 1 > fw_crash	// trigger FW crash and wait SER handling
$ cat fw_crash		// return 0 if restart has been done

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  |  2 +
 drivers/net/wireless/realtek/rtw89/debug.c | 48 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c    | 36 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h    | 12 ++++++
 drivers/net/wireless/realtek/rtw89/ser.c   |  1 +
 5 files changed, 99 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 93acc872f2beb..8140958b4a270 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2390,6 +2390,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_OLD_HT_RA_FORMAT,
 	RTW89_FW_FEATURE_SCAN_OFFLOAD,
 	RTW89_FW_FEATURE_TX_WAKE,
+	RTW89_FW_FEATURE_CRASH_TRIGGER,
 };
 
 struct rtw89_fw_suit {
@@ -2492,6 +2493,7 @@ enum rtw89_flags {
 	RTW89_FLAG_LEISURE_PS,
 	RTW89_FLAG_LOW_POWER_MODE,
 	RTW89_FLAG_INACTIVE_PS,
+	RTW89_FLAG_RESTART_TRIGGER,
 
 	NUM_OF_RTW89_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 09c545497ec5c..f93f3fee15058 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2184,6 +2184,48 @@ rtw89_debug_priv_early_h2c_set(struct file *filp, const char __user *user_buf,
 	return count;
 }
 
+static int
+rtw89_debug_priv_fw_crash_get(struct seq_file *m, void *v)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+
+	seq_printf(m, "%d\n",
+		   test_bit(RTW89_FLAG_RESTART_TRIGGER, rtwdev->flags));
+	return 0;
+}
+
+static ssize_t
+rtw89_debug_priv_fw_crash_set(struct file *filp, const char __user *user_buf,
+			      size_t count, loff_t *loff)
+{
+	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	bool fw_crash;
+	int ret;
+
+	if (!RTW89_CHK_FW_FEATURE(CRASH_TRIGGER, &rtwdev->fw))
+		return -EOPNOTSUPP;
+
+	ret = kstrtobool_from_user(user_buf, count, &fw_crash);
+	if (ret)
+		return -EINVAL;
+
+	if (!fw_crash)
+		return -EINVAL;
+
+	mutex_lock(&rtwdev->mutex);
+	set_bit(RTW89_FLAG_RESTART_TRIGGER, rtwdev->flags);
+	ret = rtw89_fw_h2c_trigger_cpu_exception(rtwdev);
+	mutex_unlock(&rtwdev->mutex);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static int rtw89_debug_priv_btc_info_get(struct seq_file *m, void *v)
 {
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
@@ -2468,6 +2510,11 @@ static struct rtw89_debugfs_priv rtw89_debug_priv_early_h2c = {
 	.cb_write = rtw89_debug_priv_early_h2c_set,
 };
 
+static struct rtw89_debugfs_priv rtw89_debug_priv_fw_crash = {
+	.cb_read = rtw89_debug_priv_fw_crash_get,
+	.cb_write = rtw89_debug_priv_fw_crash_set,
+};
+
 static struct rtw89_debugfs_priv rtw89_debug_priv_btc_info = {
 	.cb_read = rtw89_debug_priv_btc_info_get,
 };
@@ -2522,6 +2569,7 @@ void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
 	rtw89_debugfs_add_rw(mac_dbg_port_dump);
 	rtw89_debugfs_add_w(send_h2c);
 	rtw89_debugfs_add_rw(early_h2c);
+	rtw89_debugfs_add_rw(fw_crash);
 	rtw89_debugfs_add_r(btc_info);
 	rtw89_debugfs_add_w(btc_manual);
 	rtw89_debugfs_add_w(fw_log_manual);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e4d94981cd32b..4848f25e7a0af 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -221,6 +221,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852A, le, 0, 13, 29, 0, OLD_HT_RA_FORMAT),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, TX_WAKE),
+	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 36, 0, CRASH_TRIGGER),
 };
 
 static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
@@ -2287,3 +2288,38 @@ void rtw89_store_op_chan(struct rtw89_dev *rtwdev)
 	scan_info->op_bw = hal->current_band_width;
 	scan_info->op_band = hal->current_band_type;
 }
+
+#define H2C_FW_CPU_EXCEPTION_LEN 4
+#define H2C_FW_CPU_EXCEPTION_TYPE_DEF 0x5566
+int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_FW_CPU_EXCEPTION_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for fw cpu exception\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_FW_CPU_EXCEPTION_LEN);
+	RTW89_SET_FWCMD_CPU_EXCEPTION_TYPE(skb->data,
+					   H2C_FW_CPU_EXCEPTION_TYPE_DEF);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_TEST,
+			      H2C_CL_FW_STATUS_TEST,
+			      H2C_FUNC_CPU_EXCEPTION, 0, 0,
+			      H2C_FW_CPU_EXCEPTION_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	dev_kfree_skb_any(skb);
+	return -EBUSY;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 1aaec26722377..24ab249a8ecec 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1461,6 +1461,11 @@ static inline void SET_LPS_PARM_LASTRPWM(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(15, 8));
 }
 
+static inline void RTW89_SET_FWCMD_CPU_EXCEPTION_TYPE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 0));
+}
+
 enum rtw89_btc_btf_h2c_class {
 	BTFC_SET = 0x10,
 	BTFC_GET = 0x11,
@@ -2140,6 +2145,12 @@ struct rtw89_fw_h2c_rf_reg_info {
 
 #define FWCMD_TYPE_H2C			0
 
+#define H2C_CAT_TEST		0x0
+
+/* CLASS 5 - FW STATUS TEST */
+#define H2C_CL_FW_STATUS_TEST		0x5
+#define H2C_FUNC_CPU_EXCEPTION		0x1
+
 #define H2C_CAT_MAC		0x1
 
 /* CLASS 0 - FW INFO */
@@ -2284,5 +2295,6 @@ void rtw89_hw_scan_status_report(struct rtw89_dev *rtwdev, struct sk_buff *skb);
 void rtw89_hw_scan_chan_switch(struct rtw89_dev *rtwdev, struct sk_buff *skb);
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 void rtw89_store_op_chan(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index f28cd0645ad92..25d1df10f2262 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -619,6 +619,7 @@ static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 		fallthrough;
 	case SER_EV_L2_RECFG_DONE:
 		ser_state_goto(ser, SER_IDLE_ST);
+		clear_bit(RTW89_FLAG_RESTART_TRIGGER, rtwdev->flags);
 		break;
 
 	case SER_EV_STATE_OUT:
-- 
2.25.1

