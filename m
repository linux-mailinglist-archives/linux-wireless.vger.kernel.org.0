Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68066C12BB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 14:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjCTNHs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 09:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCTNHq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 09:07:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E855CE3BB
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 06:07:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32KD7NbsC025639, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32KD7NbsC025639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Mar 2023 21:07:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Mar 2023 21:07:19 +0800
Received: from localhost (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Mar
 2023 21:07:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: use schedule_work to request firmware
Date:   Mon, 20 Mar 2023 21:06:05 +0800
Message-ID: <20230320130606.20777-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320130606.20777-1-pkshih@realtek.com>
References: <20230320130606.20777-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.31]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since we are going to load more than one firmware and some are not
presented or optional, using asynchronous API request_firmware_nowait()
will become complicated. Also, we want to use firmware_request_nowarn()
to avoid warning messages when loading optional files. So, use
schedule_work to be simpler.

To abstract loading a firmware or file, define a struct rtw89_fw_req_info
containing a struct firmware and a completion to ensure this firmware is
loaded completely.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 17 +++---
 drivers/net/wireless/realtek/rtw89/core.h |  8 ++-
 drivers/net/wireless/realtek/rtw89/fw.c   | 68 ++++++++++-------------
 drivers/net/wireless/realtek/rtw89/fw.h   |  2 +-
 4 files changed, 45 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0c722c52c9fce..33460954ebf13 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3427,7 +3427,6 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 int rtw89_core_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	int ret;
 	u8 band;
 
 	INIT_LIST_HEAD(&rtwdev->ba_list);
@@ -3464,6 +3463,8 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 
 	INIT_WORK(&rtwdev->c2h_work, rtw89_fw_c2h_work);
 	INIT_WORK(&rtwdev->ips_work, rtw89_ips_work);
+	INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
+
 	skb_queue_head_init(&rtwdev->c2h_queue);
 	rtw89_core_ppdu_sts_init(rtwdev);
 	rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
@@ -3475,12 +3476,10 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	INIT_WORK(&btc->dhcp_notify_work, rtw89_btc_ntfy_dhcp_packet_work);
 	INIT_WORK(&btc->icmp_notify_work, rtw89_btc_ntfy_icmp_packet_work);
 
-	ret = rtw89_load_firmware(rtwdev);
-	if (ret) {
-		rtw89_warn(rtwdev, "no firmware loaded\n");
-		destroy_workqueue(rtwdev->txq_wq);
-		return ret;
-	}
+	init_completion(&rtwdev->fw.req.completion);
+
+	schedule_work(&rtwdev->load_firmware_work);
+
 	rtw89_ser_init(rtwdev);
 	rtw89_entity_init(rtwdev);
 
@@ -3794,7 +3793,7 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	rtwdev->dev = device;
 	rtwdev->ops = ops;
 	rtwdev->chip = chip;
-	rtwdev->fw.firmware = firmware;
+	rtwdev->fw.req.firmware = firmware;
 
 	rtw89_debug(rtwdev, RTW89_DBG_FW, "probe driver %s chanctx\n",
 		    no_chanctx ? "without" : "with");
@@ -3811,7 +3810,7 @@ EXPORT_SYMBOL(rtw89_alloc_ieee80211_hw);
 void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev)
 {
 	kfree(rtwdev->ops);
-	release_firmware(rtwdev->fw.firmware);
+	release_firmware(rtwdev->fw.req.firmware);
 	ieee80211_free_hw(rtwdev->hw);
 }
 EXPORT_SYMBOL(rtw89_free_ieee80211_hw);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7d80d0fc50c38..5fd189dde17e7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3274,10 +3274,13 @@ struct rtw89_fw_suit {
 			  GET_FW_HDR_SUBVERSION(fw_hdr),	\
 			  GET_FW_HDR_SUBINDEX(fw_hdr))
 
-struct rtw89_fw_info {
+struct rtw89_fw_req_info {
 	const struct firmware *firmware;
-	struct rtw89_dev *rtwdev;
 	struct completion completion;
+};
+
+struct rtw89_fw_info {
+	struct rtw89_fw_req_info req;
 	u8 h2c_seq;
 	u8 rec_seq;
 	u8 h2c_counter;
@@ -3994,6 +3997,7 @@ struct rtw89_dev {
 	struct sk_buff_head c2h_queue;
 	struct work_struct c2h_work;
 	struct work_struct ips_work;
+	struct work_struct load_firmware_work;
 
 	struct list_head early_h2c_list;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d9bd4339a59e5..9edc421e176cf 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -155,8 +155,9 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 			struct rtw89_fw_suit *fw_suit, bool nowarn)
 {
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
-	const u8 *mfw = fw_info->firmware->data;
-	u32 mfw_len = fw_info->firmware->size;
+	const struct firmware *firmware = fw_info->req.firmware;
+	const u8 *mfw = firmware->data;
+	u32 mfw_len = firmware->size;
 	const struct rtw89_mfw_hdr *mfw_hdr = (const struct rtw89_mfw_hdr *)mfw;
 	const struct rtw89_mfw_info *mfw_info;
 	int i;
@@ -631,67 +632,58 @@ int rtw89_wait_firmware_completion(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_fw_info *fw = &rtwdev->fw;
 
-	wait_for_completion(&fw->completion);
-	if (!fw->firmware)
+	wait_for_completion(&fw->req.completion);
+	if (!fw->req.firmware)
 		return -EINVAL;
 
 	return 0;
 }
 
-static void rtw89_load_firmware_cb(const struct firmware *firmware, void *context)
+static int rtw89_load_firmware_req(struct rtw89_dev *rtwdev,
+				   struct rtw89_fw_req_info *req,
+				   const char *fw_name, bool nowarn)
 {
-	struct rtw89_fw_info *fw = context;
-	struct rtw89_dev *rtwdev = fw->rtwdev;
-
-	if (!firmware || !firmware->data) {
-		rtw89_err(rtwdev, "failed to request firmware\n");
-		complete_all(&fw->completion);
-		return;
-	}
-
-	fw->firmware = firmware;
-	complete_all(&fw->completion);
-}
-
-int rtw89_load_firmware(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_fw_info *fw = &rtwdev->fw;
-	const char *fw_name = rtwdev->chip->fw_name;
 	int ret;
 
-	fw->rtwdev = rtwdev;
-	init_completion(&fw->completion);
-
-	if (fw->firmware) {
+	if (req->firmware) {
 		rtw89_debug(rtwdev, RTW89_DBG_FW,
 			    "full firmware has been early requested\n");
-		complete_all(&fw->completion);
+		complete_all(&req->completion);
 		return 0;
 	}
 
-	ret = request_firmware_nowait(THIS_MODULE, true, fw_name, rtwdev->dev,
-				      GFP_KERNEL, fw, rtw89_load_firmware_cb);
-	if (ret) {
-		rtw89_err(rtwdev, "failed to async firmware request\n");
-		return ret;
-	}
+	if (nowarn)
+		ret = firmware_request_nowarn(&req->firmware, fw_name, rtwdev->dev);
+	else
+		ret = request_firmware(&req->firmware, fw_name, rtwdev->dev);
 
-	return 0;
+	complete_all(&req->completion);
+
+	return ret;
+}
+
+void rtw89_load_firmware_work(struct work_struct *work)
+{
+	struct rtw89_dev *rtwdev =
+		container_of(work, struct rtw89_dev, load_firmware_work);
+	const char *fw_name = rtwdev->chip->fw_name;
+
+	rtw89_load_firmware_req(rtwdev, &rtwdev->fw.req, fw_name, false);
 }
 
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_fw_info *fw = &rtwdev->fw;
 
-	rtw89_wait_firmware_completion(rtwdev);
+	cancel_work_sync(&rtwdev->load_firmware_work);
 
-	if (fw->firmware) {
-		release_firmware(fw->firmware);
+	if (fw->req.firmware) {
+		release_firmware(fw->req.firmware);
 
 		/* assign NULL back in case rtw89_free_ieee80211_hw()
 		 * try to release the same one again.
 		 */
-		fw->firmware = NULL;
+		fw->req.firmware = NULL;
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index c5c7279ccc23a..661e08ae7bc8c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3660,7 +3660,7 @@ rtw89_early_fw_feature_recognize(struct device *device,
 				 const struct rtw89_chip_info *chip,
 				 struct rtw89_fw_info *early_fw);
 int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type);
-int rtw89_load_firmware(struct rtw89_dev *rtwdev);
+void rtw89_load_firmware_work(struct work_struct *work);
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev);
 int rtw89_wait_firmware_completion(struct rtw89_dev *rtwdev);
 void rtw89_h2c_pkt_set_hdr(struct rtw89_dev *rtwdev, struct sk_buff *skb,
-- 
2.25.1

