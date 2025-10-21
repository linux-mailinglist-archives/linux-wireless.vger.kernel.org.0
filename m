Return-Path: <linux-wireless+bounces-28145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B05DBF6D09
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 15:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D45ED506122
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D988338928;
	Tue, 21 Oct 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="oExmoEPn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B7338583
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053669; cv=none; b=SJhoNu4iTHkwxprbbP6y//+v6jnvGm0Q/X3vpnpJ8AzMfQAxjXSq8588HcV7gEt79LbgZfH8v9cpoQch5M3lcjFm6W+b+LPBlLxTYbLl9SSN5ubf9gC/F6nRaHU130CV68OJn8BgittV/5cV4BY1ZvxaCXvE6AsGRygJSGJ5GMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053669; c=relaxed/simple;
	bh=tMkrfG/mH6P37yUYX/7Ad2VRE9kXqLOg3/7/jXqjDLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqM3sunxyq0vFkQvNdhJODqoxsqWfq2wvxfTBdiP1QJ9AwmjA3b+pG0grfZIbDXER2f+uqlgtllyekGEtAkRq3/luhm2M22r+s/JBwCQsJmtB6H6ajC0PlmK0/4SECNSLo/mML1txbiqvYMjeDTCMEYRb2LBVpznmUxQOF2Qd6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=oExmoEPn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59LDYMyhC3088105, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761053662; bh=pR+WrRG+7ihAMDgdHjfRl62txFkIXr+W2yPUVMUxt28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=oExmoEPnre/ThQAWdWXxnCT6nJcID5+UaIdsOJU6cWpQ8HlJsiBYMzsUMr1v2mOAu
	 h/bit7TnADJmXMO1VP+VsxViAkege/i1W1S7YldomMDmYGBtdwIexWDSXBDjGo0bi5
	 dz/snMLqsNtYMlhEbDE4mZeLdPWEU2d0KgMBH7jxlwmjYGmk+eNro5yOaQhY/nm5wu
	 w4GhK/16oSmPRl43q4TvXsMgxfcW5WCmmsj2/BzpvLmBnohApRiqvXaWXozazIQQky
	 /mI8/cAM1f6/4REUHgRKKNeBOgctYFx4SWSjYM9cbnpS8enVfVijZ8LpRdxn8vHVVp
	 oMkBuqnXsb9Fg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59LDYMyhC3088105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 21:34:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:22 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:22 +0800
Received: from [127.0.1.1] (10.22.225.127) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 21 Oct 2025 21:34:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <emma_tsai@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [rtw-next 7/8] wifi: rtw89: restart hardware to recover firmware if power-save becomes abnormal
Date: Tue, 21 Oct 2025 21:34:01 +0800
Message-ID: <20251021133402.15467-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021133402.15467-1-pkshih@realtek.com>
References: <20251021133402.15467-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chin-Yen Lee <timlee@realtek.com>

Somehow power-save related functions get failure, such as failed to
send null packet, or no response form firmware, and then WiFi will
become unstable. Trigger SER function actively to reset firmware/driver
to recover from abnormal states, including

 - firmware failed to ACK for entering PS mode
 - firmware failed to ACK for leaving PS mode
 - check PS H2C command received by firmware fail
 - failed to leave PS state

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  1 +
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/mac.c  |  7 +++++--
 drivers/net/wireless/realtek/rtw89/ps.c   | 23 +++++++++++++++++++++--
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a3f156bf708e..1b5a40e9821c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5538,6 +5538,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 	rtw89_fw_h2c_fw_log(rtwdev, rtwdev->fw.log.enable);
 	rtw89_fw_h2c_init_ba_cam(rtwdev);
 	rtw89_tas_fw_timer_enable(rtwdev, true);
+	rtwdev->ps_hang_cnt = 0;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ae98d6866b30..f8b443894db9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -42,6 +42,7 @@ extern const struct ieee80211_ops rtw89_ops;
 #define RTW89_TRACK_WORK_PERIOD	round_jiffies_relative(HZ * 2)
 #define RTW89_TRACK_PS_WORK_PERIOD msecs_to_jiffies(100)
 #define RTW89_FORBID_BA_TIMER round_jiffies_relative(HZ * 4)
+#define RTW89_PS_HANG_MAX_CNT 3
 #define CFO_TRACK_MAX_USER 64
 #define MAX_RSSI 110
 #define RSSI_FACTOR 1
@@ -6082,6 +6083,7 @@ struct rtw89_dev {
 	struct rtw89_btc btc;
 	enum rtw89_ps_mode ps_mode;
 	bool lps_enabled;
+	u8 ps_hang_cnt;
 
 	struct rtw89_wow_param wow;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index fd11b8fb3c89..d837513f4e92 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -12,6 +12,7 @@
 #include "phy.h"
 #include "ps.h"
 #include "reg.h"
+#include "ser.h"
 #include "util.h"
 
 static const u32 rtw89_mac_mem_base_addrs_ax[RTW89_MAC_MEM_NUM] = {
@@ -1423,13 +1424,15 @@ void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 		if (!ret)
 			break;
 
-		if (i == RPWM_TRY_CNT - 1)
+		if (i == RPWM_TRY_CNT - 1) {
 			rtw89_err(rtwdev, "firmware failed to ack for %s ps mode\n",
 				  enter ? "entering" : "leaving");
-		else
+			rtw89_ser_notify(rtwdev, MAC_AX_ERR_ASSERTION);
+		} else {
 			rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
 				    "%d time firmware failed to ack for %s ps mode\n",
 				    i + 1, enter ? "entering" : "leaving");
+		}
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index cf58121eb541..3f69dd4361c3 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -11,6 +11,7 @@
 #include "phy.h"
 #include "ps.h"
 #include "reg.h"
+#include "ser.h"
 #include "util.h"
 
 static int rtw89_fw_receive_lps_h2c_check(struct rtw89_dev *rtwdev, u8 macid)
@@ -26,16 +27,27 @@ static int rtw89_fw_receive_lps_h2c_check(struct rtw89_dev *rtwdev, u8 macid)
 	c2h_info.id = RTW89_FWCMD_C2HREG_FUNC_PS_LEAVE_ACK;
 	ret = rtw89_fw_msg_reg(rtwdev, NULL, &c2h_info);
 	if (ret)
-		return ret;
+		goto fw_fail;
 
 	c2hreg_macid = u32_get_bits(c2h_info.u.c2hreg[0],
 				    RTW89_C2HREG_PS_LEAVE_ACK_MACID);
 	c2hreg_ret = u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_PS_LEAVE_ACK_RET);
 
-	if (macid != c2hreg_macid || c2hreg_ret)
+	if (macid != c2hreg_macid || c2hreg_ret) {
 		rtw89_warn(rtwdev, "rtw89: check lps h2c received by firmware fail\n");
+		ret = -EINVAL;
+		goto fw_fail;
+	}
+	rtwdev->ps_hang_cnt = 0;
 
 	return 0;
+
+fw_fail:
+	rtwdev->ps_hang_cnt++;
+	if (rtwdev->ps_hang_cnt >= RTW89_PS_HANG_MAX_CNT)
+		rtw89_ser_notify(rtwdev, MAC_AX_ERR_ASSERTION);
+
+	return ret;
 }
 
 static int rtw89_fw_leave_lps_check(struct rtw89_dev *rtwdev, u8 macid)
@@ -51,9 +63,16 @@ static int rtw89_fw_leave_lps_check(struct rtw89_dev *rtwdev, u8 macid)
 				       mac->ps_status, chk_msk);
 	if (ret) {
 		rtw89_info(rtwdev, "rtw89: failed to leave lps state\n");
+
+		rtwdev->ps_hang_cnt++;
+		if (rtwdev->ps_hang_cnt >= RTW89_PS_HANG_MAX_CNT)
+			rtw89_ser_notify(rtwdev, MAC_AX_ERR_ASSERTION);
+
 		return -EBUSY;
 	}
 
+	rtwdev->ps_hang_cnt = 0;
+
 	return 0;
 }
 
-- 
2.25.1


