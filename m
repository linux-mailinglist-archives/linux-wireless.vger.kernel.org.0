Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42E5B7FC4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 05:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiINDvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 23:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiINDv3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 23:51:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5082C6DAF6
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 20:51:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28E3orIE3007558, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28E3orIE3007558
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 14 Sep 2022 11:50:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:51:14 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 14 Sep
 2022 11:51:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: support SER L1 simulation
Date:   Wed, 14 Sep 2022 11:50:34 +0800
Message-ID: <20220914035034.14521-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914035034.14521-1-pkshih@realtek.com>
References: <20220914035034.14521-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/14/2022 03:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTMgpFWkyCAxMToxMjowMA==?=
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

SER (system error recovery) can deal with different crash types by
different levels of processes. Previous FW crash simulation triggers
a CPU exception which is one kind of SER L2 type. It can verify SER L2
flow which includes HW/FW restart.

Now, we want to increase crash simulation types. A debug function is added
to trigger control error in purpose for SER L1 simulation/verification.
And, debugfs fw_crash is extended to accept different parameters.

echo 1 > fw_crash:
	simulate CPU exception as before
	(keep 1 for compatibility with previous)

	It will be catched and handled by SER L2.
	(this requires HW/FW restart)

echo 2 > fw_crash:
	simulate control error

	It will be catched and handled by SER L1.
	(driver and FW cooperate to recover this)

Besides, in order to apply to the above two cases,
rename RTW89_FLAG_RESTART_TRIGGER to RTW89_FLAG_CRASH_SIMULATING
and adjust where SER flow clears this bit for both L1 and L2.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  |  2 +-
 drivers/net/wireless/realtek/rtw89/debug.c | 62 ++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/mac.c   |  8 ++-
 drivers/net/wireless/realtek/rtw89/mac.h   |  3 ++
 drivers/net/wireless/realtek/rtw89/ser.c   |  2 +-
 5 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c3eb598120617..ab9f299fdd441 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2878,7 +2878,7 @@ enum rtw89_flags {
 	RTW89_FLAG_LEISURE_PS,
 	RTW89_FLAG_LOW_POWER_MODE,
 	RTW89_FLAG_INACTIVE_PS,
-	RTW89_FLAG_RESTART_TRIGGER,
+	RTW89_FLAG_CRASH_SIMULATING,
 
 	NUM_OF_RTW89_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index eed28c3b440f4..730e83d54257f 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2190,6 +2190,37 @@ rtw89_debug_priv_early_h2c_set(struct file *filp, const char __user *user_buf,
 	return count;
 }
 
+static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_cpuio_ctrl ctrl_para = {0};
+	u16 pkt_id;
+
+	rtw89_leave_ps_mode(rtwdev);
+
+	pkt_id = rtw89_mac_dle_buf_req(rtwdev, 0x20, true);
+	switch (pkt_id) {
+	case 0xffff:
+		return -ETIMEDOUT;
+	case 0xfff:
+		return -ENOMEM;
+	default:
+		break;
+	}
+
+	/* intentionally, enqueue two pkt, but has only one pkt id */
+	ctrl_para.cmd_type = CPUIO_OP_CMD_ENQ_TO_HEAD;
+	ctrl_para.start_pktid = pkt_id;
+	ctrl_para.end_pktid = pkt_id;
+	ctrl_para.pkt_num = 1; /* start from 0 */
+	ctrl_para.dst_pid = WDE_DLE_PORT_ID_WDRLS;
+	ctrl_para.dst_qid = WDE_DLE_QUEID_NO_REPORT;
+
+	if (rtw89_mac_set_cpuio(rtwdev, &ctrl_para, true))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int
 rtw89_debug_priv_fw_crash_get(struct seq_file *m, void *v)
 {
@@ -2197,10 +2228,15 @@ rtw89_debug_priv_fw_crash_get(struct seq_file *m, void *v)
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 
 	seq_printf(m, "%d\n",
-		   test_bit(RTW89_FLAG_RESTART_TRIGGER, rtwdev->flags));
+		   test_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags));
 	return 0;
 }
 
+enum rtw89_dbg_crash_simulation_type {
+	RTW89_DBG_SIM_CPU_EXCEPTION = 1,
+	RTW89_DBG_SIM_CTRL_ERROR = 2,
+};
+
 static ssize_t
 rtw89_debug_priv_fw_crash_set(struct file *filp, const char __user *user_buf,
 			      size_t count, loff_t *loff)
@@ -2208,22 +2244,30 @@ rtw89_debug_priv_fw_crash_set(struct file *filp, const char __user *user_buf,
 	struct seq_file *m = (struct seq_file *)filp->private_data;
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-	bool fw_crash;
+	int (*sim)(struct rtw89_dev *rtwdev);
+	u8 crash_type;
 	int ret;
 
-	if (!RTW89_CHK_FW_FEATURE(CRASH_TRIGGER, &rtwdev->fw))
-		return -EOPNOTSUPP;
-
-	ret = kstrtobool_from_user(user_buf, count, &fw_crash);
+	ret = kstrtou8_from_user(user_buf, count, 0, &crash_type);
 	if (ret)
 		return -EINVAL;
 
-	if (!fw_crash)
+	switch (crash_type) {
+	case RTW89_DBG_SIM_CPU_EXCEPTION:
+		if (!RTW89_CHK_FW_FEATURE(CRASH_TRIGGER, &rtwdev->fw))
+			return -EOPNOTSUPP;
+		sim = rtw89_fw_h2c_trigger_cpu_exception;
+		break;
+	case RTW89_DBG_SIM_CTRL_ERROR:
+		sim = rtw89_dbg_trigger_ctrl_error;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	mutex_lock(&rtwdev->mutex);
-	set_bit(RTW89_FLAG_RESTART_TRIGGER, rtwdev->flags);
-	ret = rtw89_fw_h2c_trigger_cpu_exception(rtwdev);
+	set_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags);
+	ret = sim(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 
 	if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2fda7929e50fd..bd852dd76e99c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2487,8 +2487,7 @@ int rtw89_mac_resume_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
 }
 EXPORT_SYMBOL(rtw89_mac_resume_sch_tx_v1);
 
-static u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len,
-				 bool wd)
+u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd)
 {
 	u32 val, reg;
 	int ret;
@@ -2508,9 +2507,8 @@ static u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len,
 	return FIELD_GET(B_AX_WD_BUF_STAT_PKTID_MASK, val);
 }
 
-static int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
-			       struct rtw89_cpuio_ctrl *ctrl_para,
-			       bool wd)
+int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
+			struct rtw89_cpuio_ctrl *ctrl_para, bool wd)
 {
 	u32 val, cmd_type, reg;
 	int ret;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 12ef97bac39ad..25e6859257e2f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -964,5 +964,8 @@ enum rtw89_mac_xtal_si_offset {
 int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask);
 int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val);
 void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd);
+int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
+			struct rtw89_cpuio_ctrl *ctrl_para, bool wd);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 1b01ff0402fb6..c1a4bc1c64d16 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -396,6 +396,7 @@ static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 	switch (evt) {
 	case SER_EV_STATE_IN:
 		rtw89_hci_recovery_complete(rtwdev);
+		clear_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags);
 		break;
 	case SER_EV_L1_RESET:
 		ser_state_goto(ser, SER_RESET_TRX_ST);
@@ -632,7 +633,6 @@ static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 		fallthrough;
 	case SER_EV_L2_RECFG_DONE:
 		ser_state_goto(ser, SER_IDLE_ST);
-		clear_bit(RTW89_FLAG_RESTART_TRIGGER, rtwdev->flags);
 		break;
 
 	case SER_EV_STATE_OUT:
-- 
2.25.1

