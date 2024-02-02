Return-Path: <linux-wireless+bounces-2983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8319C846657
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 04:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65CF1F2783A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70550D521;
	Fri,  2 Feb 2024 03:07:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95467C8C3
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843256; cv=none; b=VgD2+OWpV2BJB8uDxSP5nCcokj6KedhHUeyvsE+9fBQ+XbDHNUUU2xFtowlx1VQ1ExrOV2fguZst1/EMX8cBcmxx9iHfMWmVJSRuhUGOvhxy96Ehk8HMMCVT35nIJv5DBGQdoAC1RqLglwG5X7qCZlY44kkgixj4hMyA41zr2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843256; c=relaxed/simple;
	bh=DGhEnbqxnqIIXZwRraP7ut8PWzA0ygHanpXUeyCPbQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2TKm3UUebl7O6ae5cROGSM8gJiVy5fgjauLAcWcYTC+cvEN1qz3ILzN+5hAnO4AHDY4oPxYlwG6ZzVaCAMzS2JBRAudGdvIhErmOJv06UuME2cASJxabZIZa9Vbbh5vaDyRmRYhCeIrlexpOIgMR4VKDJi+xd8K5oDNBc9fEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41237LwrC1863000, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41237LwrC1863000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:07:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 2 Feb 2024 11:07:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Feb
 2024 11:07:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 01/11] wifi: rtw89: rfk: add a completion to wait RF calibration report from C2H event
Date: Fri, 2 Feb 2024 11:06:32 +0800
Message-ID: <20240202030642.108385-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202030642.108385-1-pkshih@realtek.com>
References: <20240202030642.108385-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The RF calibrations should be executed one by one, so add a completion
to ensure one is finish before next. The report from C2H event contains
state and optional version, and we only check the state for now. We also
care about the time a RF calibration takes, so record start time before
asking firmware to do calibration and get the delta time when receiving
report.

Consider SER recovery, we can't receive C2H event, use half of argument
'ms' as fixed delay that is 2 times of measured maximum time of
calibrations.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  1 +
 drivers/net/wireless/realtek/rtw89/core.h | 16 +++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  6 +++
 drivers/net/wireless/realtek/rtw89/phy.c  | 52 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h  |  3 ++
 5 files changed, 78 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 260da86bf04a..c6c3e0c0bf84 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4205,6 +4205,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	INIT_WORK(&btc->icmp_notify_work, rtw89_btc_ntfy_icmp_packet_work);
 
 	init_completion(&rtwdev->fw.req.completion);
+	init_completion(&rtwdev->rfk_wait.completion);
 
 	schedule_work(&rtwdev->load_firmware_work);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 30cc77ac78c5..d88a6b9bc4e9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4252,6 +4252,21 @@ struct rtw89_phy_stat {
 	struct rtw89_pkt_stat last_pkt_stat;
 };
 
+enum rtw89_rfk_report_state {
+	RTW89_RFK_STATE_START = 0x0,
+	RTW89_RFK_STATE_OK = 0x1,
+	RTW89_RFK_STATE_FAIL = 0x2,
+	RTW89_RFK_STATE_TIMEOUT = 0x3,
+	RTW89_RFK_STATE_H2C_CMD_ERR = 0x4,
+};
+
+struct rtw89_rfk_wait_info {
+	struct completion completion;
+	ktime_t start_time;
+	enum rtw89_rfk_report_state state;
+	u8 version;
+};
+
 #define RTW89_DACK_PATH_NR 2
 #define RTW89_DACK_IDX_NR 2
 #define RTW89_DACK_MSBK_NR 16
@@ -4944,6 +4959,7 @@ struct rtw89_dev {
 	DECLARE_BITMAP(pkt_offload, RTW89_MAX_PKT_OFLD_NUM);
 
 	struct rtw89_phy_stat phystat;
+	struct rtw89_rfk_wait_info rfk_wait;
 	struct rtw89_dack_info dack;
 	struct rtw89_iqk_info iqk;
 	struct rtw89_dpk_info dpk;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ae69e455cd64..9a2c50c35f2a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4013,6 +4013,12 @@ struct rtw89_c2h_rf_txgapk_rpt_log {
 	u8 rsv1;
 } __packed;
 
+struct rtw89_c2h_rfk_report {
+	struct rtw89_c2h_hdr hdr;
+	u8 state; /* enum rtw89_rfk_report_state */
+	u8 version;
+} __packed;
+
 #define RTW89_FW_RSVD_PLE_SIZE 0x800
 
 #define RTW89_FW_BACKTRACE_INFO_SIZE 8
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f661be2f1287..3de61c0d7b03 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2834,9 +2834,61 @@ void (* const rtw89_phy_c2h_rfk_log_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK] = rtw89_phy_c2h_rfk_log_txgapk,
 };
 
+void rtw89_phy_rfk_report_prep(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_rfk_wait_info *wait = &rtwdev->rfk_wait;
+
+	wait->state = RTW89_RFK_STATE_START;
+	wait->start_time = ktime_get();
+	reinit_completion(&wait->completion);
+}
+
+int rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
+			      unsigned int ms)
+{
+	struct rtw89_rfk_wait_info *wait = &rtwdev->rfk_wait;
+	unsigned long time_left;
+
+	/* Since we can't receive C2H event during SER, use a fixed delay. */
+	if (test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags)) {
+		fsleep(1000 * ms / 2);
+		goto out;
+	}
+
+	time_left = wait_for_completion_timeout(&wait->completion,
+						msecs_to_jiffies(ms));
+	if (time_left == 0) {
+		rtw89_warn(rtwdev, "failed to wait RF %s\n", rfk_name);
+		return -ETIMEDOUT;
+	} else if (wait->state != RTW89_RFK_STATE_OK) {
+		rtw89_warn(rtwdev, "failed to do RF %s result from state %d\n",
+			   rfk_name, wait->state);
+		return -EFAULT;
+	}
+
+out:
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "RF %s takes %lld ms to complete\n",
+		    rfk_name, ktime_ms_delta(ktime_get(), wait->start_time));
+
+	return 0;
+}
+
 static void
 rtw89_phy_c2h_rfk_report_state(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
+	const struct rtw89_c2h_rfk_report *report =
+		(const struct rtw89_c2h_rfk_report *)c2h->data;
+	struct rtw89_rfk_wait_info *wait = &rtwdev->rfk_wait;
+
+	wait->state = report->state;
+	wait->version = report->version;
+
+	complete(&wait->completion);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "RFK report state %d with version %d (%*ph)\n",
+		    wait->state, wait->version,
+		    (int)(len - sizeof(report->hdr)), &report->state);
 }
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 13903ca1eaa9..df915cb0833f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -885,6 +885,9 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 bool rtw89_phy_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func);
 void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func);
+void rtw89_phy_rfk_report_prep(struct rtw89_dev *rtwdev);
+int rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
+			      unsigned int ms);
 void rtw89_phy_cfo_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_cfo_track_work(struct work_struct *work);
 void rtw89_phy_cfo_parse(struct rtw89_dev *rtwdev, s16 cfo_val,
-- 
2.25.1


