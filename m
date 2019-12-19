Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2B125D1A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLSI6m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 03:58:42 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59561 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfLSI6m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 03:58:42 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBJ8wYox024873, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBJ8wYox024873
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 19 Dec 2019 16:58:34 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 19 Dec 2019 16:58:34 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <chiu@endlessm.com>
Subject: [PATCH v4 4/7] rtw88: load wowlan firmware if wowlan is supported
Date:   Thu, 19 Dec 2019 16:58:13 +0800
Message-ID: <20191219085816.20709-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219085816.20709-1-yhchuang@realtek.com>
References: <20191219085816.20709-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Driver used to download normal firmware only,
but some devices support wowlan and require to
download wowlan firmware when system suspends.
So modify rtw_load_firmware() and its callback to
allow driver to download both normal and wowlan firmware.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
 * no change

v2 -> v3
 * no change

v3 -> v4
 * no change

 drivers/net/wireless/realtek/rtw88/main.c | 72 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw88/main.h | 10 ++++
 2 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index ae61415e1665..54e8a0cef14b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -793,6 +793,26 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 	rtw_fw_send_ra_info(rtwdev, si);
 }
 
+static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_fw_state *fw;
+
+	fw = &rtwdev->fw;
+	wait_for_completion(&fw->completion);
+	if (!fw->firmware)
+		return -EINVAL;
+
+	if (chip->wow_fw_name) {
+		fw = &rtwdev->wow_fw;
+		wait_for_completion(&fw->completion);
+		if (!fw->firmware)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int rtw_power_on(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -813,11 +833,10 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
 		goto err;
 	}
 
-	wait_for_completion(&fw->completion);
-	if (!fw->firmware) {
-		ret = -EINVAL;
-		rtw_err(rtwdev, "failed to load firmware\n");
-		goto err;
+	ret = rtw_wait_firmware_completion(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to wait firmware completion\n");
+		goto err_off;
 	}
 
 	ret = rtw_download_firmware(rtwdev, fw);
@@ -1020,8 +1039,8 @@ static void rtw_unset_supported_band(struct ieee80211_hw *hw,
 
 static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
 {
-	struct rtw_dev *rtwdev = context;
-	struct rtw_fw_state *fw = &rtwdev->fw;
+	struct rtw_fw_state *fw = context;
+	struct rtw_dev *rtwdev = fw->rtwdev;
 	const struct rtw_fw_hdr *fw_hdr;
 
 	if (!firmware || !firmware->data) {
@@ -1043,17 +1062,35 @@ static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
 		 fw->version, fw->sub_version, fw->sub_index, fw->h2c_version);
 }
 
-static int rtw_load_firmware(struct rtw_dev *rtwdev, const char *fw_name)
+static int rtw_load_firmware(struct rtw_dev *rtwdev, enum rtw_fw_type type)
 {
-	struct rtw_fw_state *fw = &rtwdev->fw;
+	const char *fw_name;
+	struct rtw_fw_state *fw;
 	int ret;
 
+	switch (type) {
+	case RTW_WOWLAN_FW:
+		fw = &rtwdev->wow_fw;
+		fw_name = rtwdev->chip->wow_fw_name;
+		break;
+
+	case RTW_NORMAL_FW:
+		fw = &rtwdev->fw;
+		fw_name = rtwdev->chip->fw_name;
+		break;
+
+	default:
+		rtw_warn(rtwdev, "unsupported firmware type\n");
+		return -ENOENT;
+	}
+
+	fw->rtwdev = rtwdev;
 	init_completion(&fw->completion);
 
 	ret = request_firmware_nowait(THIS_MODULE, true, fw_name, rtwdev->dev,
-				      GFP_KERNEL, rtwdev, rtw_load_firmware_cb);
+				      GFP_KERNEL, fw, rtw_load_firmware_cb);
 	if (ret) {
-		rtw_err(rtwdev, "async firmware request failed\n");
+		rtw_err(rtwdev, "failed to async firmware request\n");
 		return ret;
 	}
 
@@ -1372,12 +1409,19 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 			  BIT_HTC_LOC_CTRL | BIT_APP_PHYSTS |
 			  BIT_AB | BIT_AM | BIT_APM;
 
-	ret = rtw_load_firmware(rtwdev, rtwdev->chip->fw_name);
+	ret = rtw_load_firmware(rtwdev, RTW_NORMAL_FW);
 	if (ret) {
 		rtw_warn(rtwdev, "no firmware loaded\n");
 		return ret;
 	}
 
+	if (chip->wow_fw_name) {
+		ret = rtw_load_firmware(rtwdev, RTW_WOWLAN_FW);
+		if (ret) {
+			rtw_warn(rtwdev, "no wow firmware loaded\n");
+			return ret;
+		}
+	}
 	return 0;
 }
 EXPORT_SYMBOL(rtw_core_init);
@@ -1385,12 +1429,16 @@ EXPORT_SYMBOL(rtw_core_init);
 void rtw_core_deinit(struct rtw_dev *rtwdev)
 {
 	struct rtw_fw_state *fw = &rtwdev->fw;
+	struct rtw_fw_state *wow_fw = &rtwdev->wow_fw;
 	struct rtw_rsvd_page *rsvd_pkt, *tmp;
 	unsigned long flags;
 
 	if (fw->firmware)
 		release_firmware(fw->firmware);
 
+	if (wow_fw->firmware)
+		release_firmware(wow_fw->firmware);
+
 	tasklet_kill(&rtwdev->tx_tasklet);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	skb_queue_purge(&rtwdev->tx_report.queue);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index d012eefcd0da..b7690666fd57 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -193,6 +193,11 @@ enum rtw_rx_queue_type {
 	RTK_MAX_RX_QUEUE_NUM
 };
 
+enum rtw_fw_type {
+	RTW_NORMAL_FW = 0x0,
+	RTW_WOWLAN_FW = 0x1,
+};
+
 enum rtw_rate_index {
 	RTW_RATEID_BGN_40M_2SS	= 0,
 	RTW_RATEID_BGN_40M_1SS	= 1,
@@ -1030,6 +1035,8 @@ struct rtw_chip_info {
 	u8 bfer_su_max_num;
 	u8 bfer_mu_max_num;
 
+	const char *wow_fw_name;
+
 	/* coex paras */
 	u32 coex_para_ver;
 	u8 bt_desired_ver;
@@ -1456,6 +1463,7 @@ struct rtw_fifo_conf {
 
 struct rtw_fw_state {
 	const struct firmware *firmware;
+	struct rtw_dev *rtwdev;
 	struct completion completion;
 	u16 version;
 	u8 sub_version;
@@ -1580,6 +1588,8 @@ struct rtw_dev {
 
 	u8 mp_mode;
 
+	struct rtw_fw_state wow_fw;
+
 	/* hci related data, must be last */
 	u8 priv[0] __aligned(sizeof(void *));
 };
-- 
2.17.1

